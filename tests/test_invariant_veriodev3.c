#include <check.h>
#include <stdlib.h>
#include <string.h>

// Include the actual production code
#include "Veri-Yapıları/Veri Yapıları Ödev/veriodev3.c"

START_TEST(test_buffer_reads_never_exceed_declared_length)
{
    // Invariant: Buffer reads never exceed the declared length
    const char *payloads[] = {
        "A",                          // Valid input (1 byte)
        "ABCDEFGHIJKLMNOP",           // Boundary case (16 bytes)
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ", // Exploit case (26 bytes > 16)
        "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" // Large overflow (100 bytes)
    };
    int num_payloads = sizeof(payloads) / sizeof(payloads[0]);

    for (int i = 0; i < num_payloads; i++) {
        QUEUE q;
        q.front = NULL;
        q.rear = NULL;
        q.count = 0;
        
        // Enqueue should not crash or overflow
        Enqueue(&q, (char*)payloads[i]);
        
        // Dequeue should not crash or overflow
        char output_buffer[16] = {0};
        Dequeue(&q, output_buffer);
        
        // Verify no out-of-bounds write occurred
        // If strcpy overflowed, stack corruption may have occurred
        // This is a basic check - more sophisticated checks would require
        // address sanitizers or memory protection mechanisms
        ck_assert_msg(strlen(output_buffer) <= 15, 
                     "Buffer overflow detected: input length %zu, output length %zu", 
                     strlen(payloads[i]), strlen(output_buffer));
    }
}
END_TEST

Suite *security_suite(void)
{
    Suite *s;
    TCase *tc_core;

    s = suite_create("Security");
    tc_core = tcase_create("Core");

    tcase_add_test(tc_core, test_buffer_reads_never_exceed_declared_length);
    suite_add_tcase(s, tc_core);

    return s;
}

int main(void)
{
    int number_failed;
    Suite *s;
    SRunner *sr;

    s = security_suite();
    sr = srunner_create(s);

    srunner_run_all(sr, CK_NORMAL);
    number_failed = srunner_ntests_failed(sr);
    srunner_free(sr);

    return (number_failed == 0) ? EXIT_SUCCESS : EXIT_FAILURE;
}