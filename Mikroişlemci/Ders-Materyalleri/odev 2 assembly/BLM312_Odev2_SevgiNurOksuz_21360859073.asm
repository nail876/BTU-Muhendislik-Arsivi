.DATA
    sayilar: db 40,1,67,99,88,26,10,60,34,58 ; sayilar diziye yerleþtirildi   

; Deðiþkenlerin baþlatýlmasý
mov ax,0 ; min indis
mov bx,0 ; temp  
mov dx,0 ; temp2
mov di,0 ; iç döngü (j)  
mov si,0 ; dýþ döngü (i) 

dongu1:  
    mov di,si ; i=j      
    mov ax,si ; i'yi muhafaza ediyorum, daha sonra aþaðýda si'yi deðiþtireceðim
    jmp dongu2 ; dongu2'ye koþulsuz git
    
minKaydet: 
    mov dx,si ; min deðer saklanýr min=dx
    mov si,ax ; i indisi si'ye atandý
    mov bl,sayilar[si] ; tmp=sayilar[i] 
    mov di,dx ; min=di (indis)
    mov dl,sayilar[di] ; hata almamak için
    mov sayilar[si],dl ; sayilar[i] = sayilar[min]
    mov sayilar[di],bl ; sayilar[min]=tmp
    jmp devam2 ; devam 2'ye koþulsuz git
    
dongu2:       
    mov dl,sayilar[si] ; d register'ýnýn l bölümüne sayilar[si] (min) ata
    cmp sayilar[di],dl ; min ile sayilar[di]'yi karþýlaþtýr
    jb minbul ; eðer sayilar[di] küçükse min'den minBul'a git
devam:
    inc di ; di yani j'yi 1 arttýr
    cmp di,10 ; di ve 10'u karþýlaþtýr
    jb dongu2 ; di 10'dan küçükse dongu2 devam   
    jae minKaydet ; di 10'a eþit veya büyükse minKaydet'e git
     
minbul:    
    mov si,di ; min elemanýn indisini si'de tut
    jmp devam ; koþulsuz olarak devam bölümüne atla

devam2:
    mov si,ax ; i indisini muhafaza etmiþtik, tekrardan onu si'ye ata 
    inc si ; dýþ döngü (i) indisini bir arttýr 
    cmp si,9 ; n-1 adet elemana kadar bakýldý mý     
    jb dongu1 ; bakýlmadýysa dongu1 çalýþsýn 

; sayilar dizisini register'lar üzerinden okumak için
mov si,0   

mov al,sayilar[si]
inc si     
mov ah,sayilar[si]   
inc si
mov bl,sayilar[si]
inc si      
mov bh,sayilar[si]
inc si 
mov cl,sayilar[si]
inc si 
mov ch,sayilar[si]
inc si 
mov dl,sayilar[si]  
inc si 
mov dh,sayilar[si]   

; register'lar ax, bx, cx, dx sýrasýyla önce l sonra h okunarak dizinin sýralanmasý anlaþýlýr  
hlt ; n-1 adet elemana bakýldý, bitir.