Return-Path: <niklas.adolfsson@home.se>
Message-ID: <40FAB231.1020400@home.se>
Date: Sun, 18 Jul 2004 19:24:01 +0200
From: niklas adolfsson <niklas.adolfsson@home.se>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Trouble sending from device (K700i)
References: <40FA3DBD.5010401@home.se> <1090142232.4558.60.camel@pegasus>	 <40FA48B4.1010101@home.se> <1090144899.4558.65.camel@pegasus>
In-Reply-To: <1090144899.4558.65.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------080409020201000202040207"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080409020201000202040207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:

>Hi Niklas,
>
>  
>
>>>>I have sucessfully used Bluez for sending files to my K700i without 
>>>>problems but when i want to send from the phone to my notebook it only 
>>>>works once. After i have sent one file from the phone i get a constant 
>>>>bluetooth connection showing on the phone and i don't get bluetooth as 
>>>>an alternative to send to on the phone. It seems that the connection 
>>>>doesn't go down allowing a new one to be initialized. If i disconnect 
>>>>the bluetooth device on the notebook an reconnect it again it works with 
>>>>one file again from the phone. Any ideas? Please tell me if you want any 
>>>>logfiles etc. and i will supply them.
>>>>    
>>>>        
>>>>
>>>what kernel version do you use?
>>>  
>>>      
>>>
>>Here is my "uname -r" i am running Suse 9.1
>>
>> uname -r
>>2.6.5-7.95-default
>>    
>>
>
>in that kernel the HCI disconnect bug for incoming connections was
>fixed, so this can't be the problem. Show us the output of "hcidump -x"
>as root while you send something from your phone.
>
>And btw don't forget to CC the mailing list. Using Reply-All is allways
>a good idea ;)
>
>Regards
>
>Marcel
>
>  
>
Ok, here is the output hope you can read something out of it, i couldn't 
get everything copied from the terminal, the first rows disappeared this 
is all that i could mark an copy, can i read the dump in any other 
application to get everything?

      F5 46 FF 00 8D 35 FD 26 5F 0F
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 96 9F CD 49 24 19 8A 17 5F DE 1E DF 77 3D 2B 81 F3 54 FC
      C3 A1 F5 AF 1E B5 29 53 A4 AF DD 9F 47 80 AC AA 56 93 5E 45
      7B F8 89 42 EA 2A A5 93 79 72 6E 57 C9 06 BC D7 2D 0F 75 4B
      63 D8 BE 1C DE B5 C6 8E 20 3D 21 38 1F 8F 35 D4 D3 A6 EE 99
      95 65 69 1E 75 F1 23 9B F9 06 32 76 0F E5 5C 67 85 2E 4A 5E
      49 0B 31 E4 E6 B1 AA F4 3A F0 EB 44 77 B6 57 1F 26 DC D5 89
      1C 37 5A E6 BD D9 D4 95 8C CB B4 21 B3 8A AA C4 E7 18 AA 4C
      56 D4 81 DB 64 A3 B1 CD 70 FE 2D D5 62 FB 6C D8 24 0C E3 9A
      A8 6F 72 D4 1C 95 91 C0 EA 3A 80 96 61 1C 44 84 CE 5A 9F A9
      DC 98 AD 14 80 CA 4F 63 5D 11 B3 68 27 49 C6 29 06 95 2F 98
      A5 D7 19 23 F0 A9 35 1B 95 8D 91 59 B0 6B 54 CE 3F 63 67 63
      4A 59 E5 96 C2 2D CF B8 28 00 0C F0 07 6A 5D 65 F1 A4 90 B8
      25 88 C5 28 34 E4 AC 45 48 A8 C6 E5 D8 0D A9 B3 8F EC 8A C8
      9B 79 0F F7 89 F5 AB FE 16 27 CC 7E E0 FB F5 A2 EF 95 A6 53
      DD 23 72 F8 B3 34 50 83 D4 E7 23 BD 76 3E 18 B3 13 49 1C 61
      46 07 A5 63 2D 0E EB 72 D3 4C F4 4B 3B 68 AD 61 11 C4 81 47
      53 81 D4 D4 D5 D1 15 65 63 C4
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 9C DC E4 E4 C2 8A 64 9E 39 FB 5A 82 7C 01 A5 80 C1 4F F6
      BC 78 FF 00 BF 33 74 FE 7F 85 7C 91 AB E5 72 46 79 CE 14 75
      FF 00 3F E7 EB D5 89 FE 05 25 EB F9 9E 86 0A 2E 50 92 F3 42
      26 A5 E5 CE 0C 58 C3 C7 86 C8 C0 39 F5 1D 33 FE 7E B6 AC E6
      DE 72 CC 76 AF 38 1D FD EB C9 9C 3D C3 CC 6A 49 D9 77 2D 59
      3A B4 DB 72 7A 65 7B E4 7A FB D4 F2 46 23 7C 12 14 FF 00 7B
      B6 7D AB 8E 53 6A 5A 15 65 29 72 A5 A1 36 C8 A5 B6 65 6C 02
      3E EF B8 AC BF B3 49 0E 36 91 8E FE 9F E4 D3 55 1C 64 CC E5
      F0 F2 F5 23 B8 64 78 82 CA 3A 02 01 EE 0F F9 EF 59 90 C5 04
      8C 62 66 DA C4 1C 67 D3 D6 BA 23 36 93 17 32 E4 4C 49 AD 24
      52 58 02 57 DB 91 F5 15 5C 5B AE 49 51 9E 7A 1E C7 FC 6B 58
      55 95 9A 41 7B 3D 16 E3 9A 30 D1 F2 47 CC 39 CF 7A 1D 06 DC
      A0 20 0E BF E7 FC FF 00 8D 4A 6F A1 9C 93 71 E6 7B 95 64 3B
      A5 04 48 41 5E A3 1C 1A BC CF 14 C0 12 B8 7E A4 62 B4 95 DF
      29 A3 5A DF A0 86 DD C1 21 4F 6C 9E E7 FC FF 00 9F AB 04 B2
      EF 22 45 00 A9 C7 4E 71 EF 59 27 17 A3 DC C3 DF 8C 95 89 91
      1A 69 B6 EF 63 E8 4F F8 F7 FF
 > ACL data: handle 0x0029 flags 0x02 dlen 39
    L2CAP(d): cid 0x40 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46
      00 00 3F 8C C2 25 8C 9E 0E EE DC E7 3F 5A 53 76 5A 09 E9 2B
      05 D2 09 53 7C 68 A7 03 E7 1E
< ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x46 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
      90 00 03
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      01 02 03 F8 48 03 F5 A6 A8 63 69 E9 82 3B 1E A7 E9 5A 43 6E
      56 69 CC 92 B7 51 E5 C8 E8 A0 12 3A 76 22 99 02 96 6D C5 48
      07 AA 9E 40 FF 00 39 AD 14 54 59 A3 A4 9B D4 91 19 84 A3 71
      27 D3 B9 FF 00 3F E7 EB A3 7A D1 FD 96 39 50 B6 FC 60 F3 9A
      1C 96 89 11 CB A3 BA 29 06 56 04 B6 E2 31 81 DF 1F E7 FC FB
      A7 00 EE C8 62 31 8C 1E 0D 5E B6 39 E4 E5 07 EF 0F 81 F6 B0
      7F 2C 9C F3 8C E0 E7 DA AD AB C4 C8 0A B6 71 C6 C2 79 1E F5
      33 DF 43 4B A5 A3 EA 42 59 9D F8 3C FE 55 2C 2C 49 55 6E A2
      AE 2E CB 42 D4 15 95 F7 2D 47 21 57 03 6F 19 E3 1F E7 FC FF
      00 3D DD 0A 0D D7 29 21 65 2A 3A FB D6 B0 76 8B 67 2C A3 CC
      4F 78 D3 CD 7B 28 40 59 73 F7 41 FE 95 4C CA E8 C1 5C 73 F4
      AD 63 64 73 54 85 F5 2E D8 2B CB 2A C7 19 CB B9 C0 1D 8E 6B
      54 5B DD 5A DD 79 33 C7 24 6E A7 18 6E BF E7 FC FD 77 85 5B
      35 72 27 45 B8 5C F4 8F 87 B7 3A 7C 7A DD A2 5D 18 E3 F2 94
      B3 33 1C 64 F6 FE 75 EB 3A 9D A5 9E A9 60 D3 69 F7 76 AF 32
      FF 00 1C 72 06 20 FA 71 90 2B B2 A4 E5 17 09 DB 43 C6 9D 38
      D4 8D 5A 77 49 B7 A7 DC 8B 3E
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x46 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
      1E
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 0E 86 E6 5D 35 ED B5 39 DE 62 09 06 39 0E 58 0F 7A DE B3
      B1 B0 D3 E3 63 04 51 C4 3A B3 1F F1 35 E7 62 AA 3F 69 28 C3
      44 CF 63 2A A6 9E 1E 15 2A 3B C9 2B 6A 71 1E 25 F8 95 6D 6F
      72 D6 BA 59 59 02 64 3C A5 73 FF 00 7C F6 3F 8D 47 E1 5F 14
      C3 AE DF 7D 92 EE 69 24 CA E5 56 42 30 C7 E8 38 AE C9 E0 7E
      AD 47 99 FC 5B FA 05 0C 7B C5 D7 4B EC DE DE BE BF D5 8D 0F
      14 68 E9 63 0F F6 8E 9D 10 82 48 88 62 22 1B 47 AF 6E 95 B5
      E1 3F 10 C3 AB 69 AB 23 B0 13 27 CB 20 27 07 23 BD 73 4A 52
      C5 61 FD A3 DE 2E C5 CE 51 CB B1 DE CD 69 19 AB F9 5D 0D F1
      AF 89 AC 74 3D 12 5B 99 5F 74 8E 85 62 8D 79 66 38 F4 FF 00
      0A F9 E6 FA F6 E6 69 DE 5C 9C 48 CC C7 F1 35 DF 97 D1 F6 78
      79 4E 5F 69 FE 47 95 99 62 23 8A C6 C5 43 EC 2F CF FE 02 3A
      2F 87 57 9E 56 B9 64 44 AF 96 93 68 5C F1 8C 75 AF 62 F1 D5
      E9 83 C1 FA 84 D1 9E 7C 86 0A 7E A0 D4 62 61 CD 5A 97 F5 D4
      8A 15 1D 3A 18 94 BB 7E 87 CE 9A 2D CC 0F 75 8B 96 C1 33 7D
      E2 DF 77 9E BF FD 6A E9 B5 1D 6E 2D 04 47 05 85 D2 4D 16 77
      B2 FC CC 4E 79 F5 1D CE 7D 2B
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 A7 11 36 AB C9 3D 99 9E 1E 95 B0 F4 F9 74 92 B7 DC CA 17
      3E 2F 86 F3 CC B8 B8 F3 84 8D C6 41 C8 C7 B0 A3 C3 DA BA 5E
      16 84 02 A1 79 4C 9E 48 AF 27 17 F0 7A 1F 45 97 27 0A 9A 9B
      4A E1 B2 84 E7 3D EB 35 5B CB BA 65 23 23 3C 7B 57 93 63 E8
      23 65 63 D2 FE 14 DD 1F B4 4B 6F 9E 19 37 0F C2 BD 16 9D 3E
      A4 D6 77 91 E7 3F 12 1D 57 52 93 D9 47 F2 AF 39 D2 EE 96 3D
      5F 68 C0 24 FA D6 55 11 D7 86 D6 09 1D ED A4 E4 C6 08 F4 E9
      57 63 94 32 8E 79 15 C7 73 AD AB 31 AE FE 60 2B 9E 6A 84 C1
      D1 F2 4F 15 A4 75 21 A2 0B B9 00 8C 9F 63 5E 31 E2 8B B2 F7
      93 10 DC 6F 3F 8D 69 49 6E 76 61 95 D1 CF DA 07 9E E0 18 D3
      73 F5 E7 DB FA 7F 9F AD 9F 12 4A C6 DD 37 E4 C9 D4 91 EB 5B
      43 7D 42 A2 FD E2 1B E1 63 90 EE 7A 7E 75 16 B0 EC 75 65 04
      92 B9 1C 1E D5 4B 76 44 63 7A CD 1D 2F 4D 31 0E 73 C8 C6 6A
      4D 64 ED D1 93 E5 E4 B5 2A 7B A3 8E BC 53 8F CC 7D 85 ED BA
      5A 80 49 E0 74 15 BD E1 43 E6 BB 15 19 19 CE 69 4E A7 43 4F
      AA CA DC FD 0D 1B B9 18 EA 40 0E 15 70 3F 1A F4 EF 87 3B 67
      53 21 E5 94 66 A5 EE 8E AC 4D
 > ACL data: handle 0x0029 flags 0x02 dlen 39
    L2CAP(d): cid 0x40 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46
      00 26 B0 BC CB A1 DB 51 5D 47 CD 85 14 01 E3 BF B5 AE 07 C3
      FD 2D CE 30 BA BA 13 EB FE A2
< ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x46 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
      90 00 03
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      01 02 03 F8 48 03 F5 7E 9F E7 A6 6B E4 5D 61 F2 ED CF CD D4
      28 1D 4F B7 A0 E7 1F 8F E7 D3 8A 8D E8 52 97 AF E6 7A 59 6D
      DF 32 E9 74 51 54 00 AA EE DC DD 36 55 DB 4C A3 F0 4F E1 D8
      FB 57 95 55 F3 46 C9 EC 79 CE 4A EE E5 99 25 30 36 F2 0B 05
      38 07 B6 7D 3E B5 5A 6B F7 72 DE 61 38 CE 07 3D 3D 8D 61 08
      F3 A1 2B 72 39 22 65 D4 64 4D B8 65 20 FA 8C FE 22 AE AD C2
      CF 68 0C 64 64 9E 87 B1 EE 2A AA D1 5C BC C8 C6 75 79 FA 19
      8D 82 4A 39 20 83 C0 3D 6A 0B D2 73 E6 A6 1B FD DE 84 7F 9F
      E9 5A D2 8F 32 8A 63 84 54 67 CA F6 2E C1 7D 12 C0 AA 47 CD
      D1 81 EE 7F CF F9 E6 A9 5C 4C BE 79 C0 56 4C F5 C6 39 FF 00
      3F E7 D6 69 47 DE 77 63 A8 B7 71 44 6F 0F 9C 81 A2 CF 07 E7
      1C 73 51 95 91 72 12 31 C7 1F 37 7F F3 FA 52 E5 B5 4D 08 D5
      A4 28 B6 0D 09 20 67 B1 0C 3F AF F8 FF 00 5A 8B 26 30 5D 81
      0C 38 C0 AD A3 77 20 8F BA 84 6B AC 9D CA 4F 5E 07 FF 00 5A
      AC 41 E5 C8 15 F2 76 F7 AA 69 6F D4 8B CB 72 59 20 D9 F3 44
      47 A8 04 F4 FC 69 1E F8 C6 A5 36 FC C1 80 3C 75 A8 50 BA 1F
      2E 8E 4C 73 E5 97 ED 16 DF 2B
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 67 0C 3D FE 9D A9 B1 DD 24 84 AB A0 0C 3D 47 38 A3 91 ED
      D8 14 65 36 36 ED 91 48 08 A4 16 3D FA 7E 14 C8 98 AA 9D C3
      DF EB C7 6A D9 43 DD 35 8C 9A B4 50 E9 5D 18 2B 2A 9D DE F5
      2B EE 6B 75 DC 72 17 A8 A4 A3 CA 90 7B DA 3B 08 22 59 08 E7
      96 E7 6F 70 29 8D 1B 05 CC 63 E6 1D 3D EA DB 77 26 4B 99 32
      34 97 71 60 53 81 C9 C7 6F A5 4F 1B A3 00 49 E0 9E 2A DC 6C
      B4 31 9E 9B 89 24 A4 CB 80 38 CF AD 4F 64 0F 3E 61 C9 3D E9
      B5 CB 11 DE EA E6 81 1B D0 61 01 C7 A5 5F D3 AE 64 8E 33 1A
      0E A3 82 45 55 37 EE D8 E7 4D 26 D9 2A CA F1 8D DB 9B 79 EF
      8A 8E 29 D1 94 99 B2 C0 9E A7 BD 5E FA 99 49 36 AC 5A 82 76
      8F 94 2C 08 3C 10 7F AD 69 A5 E5 C4 B2 A4 97 13 34 84 01 B7
      24 9F A6 33 56 9D DE A4 38 BB EA 69 E9 9A 8B C5 A8 47 74 8E
      01 46 C9 FF 00 3F E7 FC 7D AB C2 3E 2F D2 6D E3 59 AE F5 98
      80 75 04 C5 26 D0 54 FE 15 EC 53 8B AD 47 95 2B BD 8F 17 13
      4D D3 AB CE DD BA 9D 4C 1E 37 F0 C3 5C AC 8B A8 DB 06 23 96
      12 0C 7E 35 A1 71 E2 8F 0F DD 5A B4 7F DA D6 65 64 05 48 13
      2E 7F 2C D7 1C F0 15 E2 D3 E5
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 36 A5 98 51 E4 94 6E 95 CF 17 F1 6F 87 5E 29 65 9F 49 D4
      61 BD 80 92 C0 79 8A 18 75 27 3E BD 7F CF 39 CD F0 84 F7 16
      BA D4 52 79 FF 00 67 31 B6 4B 67 8F A7 F9 FF 00 F5 FA 38 BC
      42 9C 1B 6A CF AA 27 2D A7 1A 72 8A 4E EB B9 E9 BE 20 F1 7B
      36 92 D1 8B A1 2B 11 8D AA 47 3F 5C 55 6F 05 5D 5A E9 BA 6C
      97 97 93 22 CB 39 CF 97 E6 0E 07 AE 3F 5A F3 30 10 6A 94 A2
      BA B3 BB 38 AB 4E 75 E2 DF 44 FF 00 E1 8C 8F 1E 78 AA D1 ED
      25 86 30 97 2A C3 03 9F BB 5E 75 1C E5 DF 3B B8 CF 7A F4 E5
      EE 53 51 3C BC 35 36 E5 CE CD A8 6F A5 B0 48 6F 20 5F 99 5B
      B1 C5 6E 6B 5F 11 67 BC F0 D4 D6 32 C3 B5 A4 5D 83 91 91 C7
      5E B5 8A 94 1A 8B 96 E9 9A E2 28 C9 CD A8 ED 25 66 79 E5 A4
      90 F9 CF 23 46 5D B9 20 0F 53 DF F5 FF 00 39 A8 CD E2 34 9B
      19 D9 81 E4 6F 39 18 AE 4A F5 DC E5 26 76 C2 84 61 15 A6 C3
      FC F8 F7 64 9C 83 D3 35 77 4C BC 10 5C AB 06 19 CF E9 5E 4C
      DB 6C EE 84 DA 9F 31 DB 43 2A CB 1A CA 87 82 32 2A 9D DC 98
      B9 CF AF 5A E7 6B 53 DC 84 B4 3A FF 00 87 37 A2 0D 72 DD 8B
      E1 59 B6 7D 73 C5 7B 28 E9 57
 > ACL data: handle 0x0029 flags 0x02 dlen 39
    L2CAP(d): cid 0x40 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46
      00 07 EF 58 55 37 3C DB E2 94 78 BB 77 F5 40 78 AF 25 B7 94
      7D BD 5F AE 1F AE 7F CE 7F CF
< ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x46 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
      90 00 03
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      01 02 03 F8 48 03 F5 E3 9D 55 A9 DB 85 76 85 CF 45 D2 A7 0D
      00 3D 72 2A DB 4A 55 B2 2B 81 2D 5D CE B6 2B 4E 9B 77 0E A3
      A8 A7 0B 88 EE 13 1C 6E 1C 55 AD 35 25 BD 4C BD 75 8C 36 33
      30 53 90 87 A7 AD 78 E6 B5 68 64 62 C1 89 76 6C 93 DA BA 28
      B3 58 56 F6 68 C7 4B 67 8A F1 54 48 79 3D BF 95 4B AF C3 33
      BA 47 DF 1E BC 0A D5 5F 98 99 D7 F7 D4 99 37 87 A1 68 AD D8
      48 40 39 E0 7B D6 66 A6 AD FD AA 1C A1 2A 1B BD 5A 8D 9B 2A
      8D 54 EA B6 74 27 50 85 E0 82 D9 18 33 1C 64 E7 80 3E B5 6F
      C4 52 46 B6 51 46 B2 0D C4 81 B0 9A 98 DD 49 24 67 52 2D 24
      50 B6 57 00 29 52 07 61 5D CF 82 97 09 9F 5E B5 9C A1 EF 36
      7A 75 DA 74 B4 34 9A 35 6B E7 63 9E 4D 77 1E 07 B8 96 D6 F1
      42 A9 2A C3 E6 1D A8 93 B3 3A DD 15 3C 1C D3 EC 7A 2C 4E 5D
      41 23 14 EA E8 84 B9 A3 73 E1 DA B3 B0 51 56 23 C8 7F 6B 00
      4F C3 CD 3C 80 38 D5 A3 E7 19 C7 EE A5 AF 8F 75 C5 61 B8 A1
      07 27 EE 9E 87 FF 00 AD FA FF 00 5E BC 45 BD 85 2B ED AF E6
      7A B9 64 9A E6 4D 75 45 08 5D 21 9E 37 93 2F 0B FC B9 1D FD
      3A F5 F7 F5 FE 7A 26 E6 DC CD
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 BA 11 CE 3E 61 FD 0F BF 7A F0 A5 0E 5F 79 2F E9 1E 4D 4F
      7A C4 B2 CC 18 10 48 64 6E 84 77 1E F5 9B 70 E1 65 2A E4 02
      7A 7A FF 00 9E 94 E1 75 1D 3A 9A C2 2A 31 D7 66 35 5C 2B 10
      CB 8E 78 C9 FC 87 D6 B6 2C 1D 1A D0 EC 1C 9C 60 E7 FA D3 93
      7C B6 33 9A 82 5E EE E8 A7 29 8E 49 C8 9F 23 9C 13 E9 E9 4D
      61 E5 BE FD DB 94 1E 9E 9F E7 FC FB D4 1C 93 68 CA 72 D5 4D
      8B 24 5B 90 EC 40 13 1F 28 F4 3E F5 52 58 64 07 78 3C 37 3E
      A0 F6 A7 07 CA F5 2F 9D CD E8 0A EF 00 DC AA C1 87 60 3A FA
      D3 FE D4 8B 32 3C A9 95 6E 0F A0 CF 7F AF F9 FA CB B4 A7 24
      89 92 BE A5 C9 5C 45 22 B7 50 DC 8E FC 7D 2A B5 DD BA 4E AC
      63 3D 7F 84 9E 1B DA AA 9C A5 19 2B 98 DD 77 32 E6 59 15 F7
      11 92 78 F4 FF 00 3F E7 F1 92 39 08 4F 9B 2A 48 E7 6F 07 EA
      07 F4 AE 9D EF 73 78 F4 45 C9 E7 26 25 40 01 E8 03 63 FC FF
      00 9F AF 29 18 0C BF BC 41 BB A6 0F 22 B0 53 76 33 A9 4D AD
      57 52 65 29 1A 85 39 19 EA 0F 7A 68 B4 04 B3 2B EE E3 27 3F
      E7 FC FF 00 35 ED 1A BB 33 9B 69 73 08 F1 E6 3D 85 BE 60 32
      33 DF F1 A8 32 70 15 DB 79 03
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 AF 41 FE 7F C6 B6 84 DB D4 D2 9B BE E3 E3 74 04 ED 1F FD
      6A 9C 90 14 1D E1 81 EA 47 F8 50 E2 D9 B5 EE B9 47 23 80 A4
      15 1E E0 7A D4 7B BE 7C 05 60 4F 1F E7 D6 A9 68 88 94 62 D3
      1C 88 85 B3 8F 98 F5 1D 87 BF E3 50 C8 4A 12 50 30 23 B7 61
      57 19 36 EC 61 64 D7 92 16 D8 09 32 48 27 23 24 F4 AB 70 AA
      89 39 38 CF A9 FF 00 3E DF E7 AD D4 93 5A 22 64 A3 2B 34 5B
      56 DA C1 0B 90 A3 90 40 FD 45 6C E9 91 86 70 C8 DB B1 D4 52
      4A C9 30 56 27 B9 92 32 BB 53 18 6E BE A0 FD 7D 2A 9B C7 B1
      F6 B0 C8 3D 8F AD 25 3E 88 8E 57 B9 69 1B F7 63 6A 91 EC 7A
      D5 97 9B 2A A4 9C FC B8 23 15 70 95 D9 94 DD C9 ED A4 45 4C
      83 F4 FF 00 1A B3 6D 78 E1 09 DC D8 27 AE 6B B2 85 79 47 A9
      C9 5A 9F 33 2D 5B 6A 12 6E 07 79 F4 C0 E3 FC FF 00 9F C6 D3
      6A 93 1C 83 21 2B D3 EF 13 9A EC FA EC AE 71 FD 5E 36 6A C3
      16 EA 77 C9 04 83 DC 02 73 4B 1D D4 C0 8C 33 71 D7 26 B9 EA
      E2 79 DD 99 AD 2C 32 86 A8 B1 1D EC D2 E5 B7 ED 00 67 39 A1
      EF 19 06 ED E4 E0 E7 25 8D 2A 55 DC 74 45 D5 A1 19 45 39 22
      BD DD DF 9A 98 12 16 CF BE 6A
 > ACL data: handle 0x0029 flags 0x02 dlen 39
    L2CAP(d): cid 0x40 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46
      00 1B 56 71 30 C0 62 0F BD 5C 6B 3B 6A 54 29 25 AA 37 6F A7
      65 D1 F6 90 AB 93 C1 CF 35 CD
< ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x46 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
      90 00 03
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      01 02 03 F8 48 03 F5 DC 48 08 3B 5B EB CF 41 FD 7F CF E3 9C
      E7 A6 83 4A F2 B1 BB E1 2B 65 BA 86 E7 2F 12 32 AF 52 39 35
      8B 75 0C 71 CC 46 C2 4E EE 6B 81 54 7E D1 C5 9D B8 8A 5C B1
      85 BA DC 8A 42 AA 49 1C E7 A0 F5 34 E8 DA 48 42 B3 AE 03 8C
      A9 F5 15 94 9A D8 39 34 D0 EC BC 25 7F E7 5B 88 1C 00 47 03
      DE B4 6F 53 0E 1B 39 15 83 6D 48 F5 68 34 E0 8D 0F 0F CC D0
      5D C7 22 B0 04 30 3C 7E 75 F4 0D 9C A2 7B 48 A7 1D 24 40 DF
      98 AD 29 BB D8 BA 92 4D E8 70 3F 16 E2 38 47 00 9D F1 E0 FE
      B5 E2 0D 27 95 7D C8 CF CD F9 D4 D6 D9 D8 EC C3 FC 07 7B A2
      DD 03 02 15 3C 63 D6 B6 BC C0 D1 FE 15 E6 DD 9D DD 08 86 E1
      91 50 0D F1 BE F8 F3 F4 AA 4C 9B 22 87 8A 2F 88 D2 25 24 F2
      46 2B CD AE A6 DC 72 0E 79 AD A9 EE C5 56 29 45 1C E6 B9 31
      59 81 8F 2A 41 C9 39 A9 AC 19 A7 80 3C AC 5F D4 9E E6 BA D6
      88 39 3F 74 99 B1 66 81 21 38 E8 39 CE 2B 3F 55 89 76 97 6F
      C0 D2 5A EA 63 4D B8 D4 5E 65 5D 2A 13 2B 8F 9D 77 16 E0 63
      1F 8D 6B DD 5A 20 B8 86 26 2C EC 78 24 FF 00 2A 4A 4D 4A C8
      F4 71 32 E5 92 35 AC 34 87 91
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 F3 21 3C 7E A2 BB 4F 0C 58 AC 08 63 1E 99 CF AD 4B 6F 70
      9D 75 38 A4 6A 69 5A 64 D7 7A 8E C8 A2 67 76 3F 28 1F A9 AF
      49 D0 7C 3C 6C 55 5A 66 46 70 39 DB CF F4 A7 C9 CF A2 37 CC
      71 D1 A1 87 8D 15 BB 37 D4 60 62 96 BA 23 1E 55 64 7C 90 51
      54 07 90 FE D6 0C 17 E1 D6 9F 95 2D 9D 5E 2C 01 FF 00 5C A5
      FF 00 F5 D7 C7 BA EB 02 C7 18 43 9F 99 B3 C0 FF 00 EB 93 FE
      7D 7A 71 6E D8 7A 3F 3F CC F5 72 D5 A4 9F 6F F2 39 48 E7 78
      95 01 65 91 8F 3B 32 4F 03 A7 E5 E9 DB F9 EB 5A 4C B2 C0 19
      77 15 C0 07 D4 1E DC FF 00 4C F3 5E 6D 69 B5 15 23 C5 8D 55
      AC 3B 5C D3 B4 24 DB EF 60 73 DC 01 FE 7E BF 9D 41 70 1D 3F
      79 F2 B2 F4 2D F5 A8 5C B7 B9 B3 6A 31 5C C5 46 3B 64 6F 94
      95 1D 4F 5F C3 FC FF 00 FA E7 B5 BA 96 14 2A A1 98 FF 00 08
      CF 3F 89 ED F5 FF 00 27 5E 44 E3 64 72 BA F2 6D E9 6B B1 B2
      4E CF B4 36 49 3D 0A F5 1C 66 9F 04 AE 32 A7 27 DF 19 34 A4
      A3 7E 54 5F 2B 92 E6 BE 85 F8 A4 46 8B 1D 3D 3D E9 EB 17 99
      13 B6 DE 07 20 FF 00 5F F3 FF 00 EB E7 92 71 D4 50 9B 86 85
      6B 76 5F F5 13 72 84 9C 37 71
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 4D BA B1 0C E4 02 40 CE 7D 88 FF 00 1A A7 EE CB 99 0A 5A
      AF 52 A5 CA 48 9F 27 CC 71 D8 F4 3F E7 FC FB 91 AC AC 72 19
      C6 DC 8F A7 F8 7F 9F C6 E9 FC 09 11 CA A2 ED E8 68 4D 6B 04
      D6 1B E5 05 59 7A FF 00 88 AC F1 10 DC 47 2A 3B 63 9F AF E3
      FE 7E B2 AA 7B F7 EC 5C 64 A3 79 79 8D 64 60 42 A8 CE 0E 36
      FF 00 9F E5 56 A2 1C 7A 8F 51 E9 ED 57 7B C8 D2 AC 97 2A B6
      E3 A7 9E 30 76 3A 8E 80 06 FE B5 12 CE 61 6F 94 92 AD F7 47
      5E 3F AD 25 07 CB 63 9E CB 71 D7 53 34 B0 96 61 B4 A9 E3 8A
      A7 92 4F CC CC C3 D3 FC FF 00 9F EB AC 63 64 6D 09 2B DB A9
      34 43 20 75 38 E3 DE AC 4E A1 6D 83 8E 57 8C 63 A1 CD 5D 87
      CF CB 75 6D 8A EA DC 6F F4 E3 1D FD F3 41 95 81 CF E6 0F 70
      6B 48 C5 48 CD 3B 2B 92 C7 2E 58 31 CE E2 71 EF 52 B8 47 04
      E3 18 E9 8A C9 5F 9A E6 6D A5 A0 89 F2 A9 E7 93 D3 1D 2A 7B
      56 53 82 E0 8A D1 BB 14 E2 8B F1 3C 6C C0 6D 63 DB 3D EB 5E
      CA E0 DB FF 00 AB 0B F3 2E 3E ED 36 B4 21 35 12 AE 59 A5 EE
      33 C9 1D 7F CF F9 FC 5A DB 84 9B BE 63 8E 30 79 A8 93 49 E8
      43 BD B4 2C 89 70 3E EF 51 E9
 > ACL data: handle 0x0029 flags 0x02 dlen 39
    L2CAP(d): cid 0x40 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46
      00 4F 80 19 78 C9 00 76 23 15 70 B2 5C C4 CF E1 2D 5A A9 42
      15 B9 19 AB B2 A2 EC C9 27 9F
< ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x46 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
      90 00 03
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      01 02 03 F8 48 03 F5 4A 97 36 A4 60 EE D1 08 CA 4B C8 C0 F6
      A9 44 98 C9 39 27 1D 2B 5F 69 7D 48 4A DD 0B 0B 74 A2 D4 C6
      14 AB 7F 78 1E 9F FD 7A A4 B7 0C A7 01 49 39 E0 E6 9C 59 51
      F7 BA 0A 67 91 57 9D D8 27 F5 FF 00 0A 27 BA 06 30 15 18 00
      3B 9E A6 AA 32 69 E8 CB 76 D6 E8 8E 2B 8D A4 1D C7 A7 F9 C5
      6A DA 5D 44 E0 1D CC 0E 3A 8A D1 CE E2 94 13 D8 7D ED E2 B4
      22 08 01 68 D4 60 B1 E8 4F D6 B3 66 76 63 EF 9C 73 59 54 9D
      84 95 8E EF E1 8E 92 F7 D1 DC 93 2A 2E 23 F9 B3 FA 0F D6 B9
      8D 71 56 D7 50 96 32 73 B5 8A 83 DB AD 70 C6 6E 55 A7 1E C7
      55 68 72 C6 9E BA 3B 99 CD 70 A3 91 E9 DF FC F3 4D 9A E4 6C
      19 6C E3 8C 9A 08 7B E8 5F F0 F6 A3 24 37 48 E1 48 00 E3 69
      AF 45 CA DC DA 87 5E 49 19 A8 A8 F9 5D CE FC 33 BA 69 A1 2C
      06 C7 52 09 E0 D7 BA 78 0E F1 6F 3C 35 6E 43 64 C5 98 DB F0
      35 74 5F 73 57 D0 CA F8 A9 6C 64 D2 16 75 5C ED CA 9F F3 F9
      D7 CF 5A 92 EC 95 B6 0C 8D D9 3C FF 00 9F F3 FA 95 1D 93 B9
      D9 86 97 BA D1 D3 F8 62 E8 1B 74 CB 71 8E B5 D2 C5 72 B8 03
      35 E5 B7 69 33 D0 8B F7 6E 59
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 8A EA 22 30 58 1A 94 F9 6E 3E 52 29 A6 FA 0A FD 8E 43 E2
      04 BE 4E 9E 54 67 04 FA 57 9A 9B FD B1 90 47 CD D1 6B AE 8A
      D2 E6 D2 A7 CD 05 73 12 EE 6C CC C5 C9 2D DB 23 A9 FE 82 AD
      E9 17 DB 14 A1 1C 7D 2B A9 C5 49 5C 75 A2 F9 34 D8 E9 EC E5
      06 D3 7B 60 8E E4 56 0E A3 7A 8E E6 35 1B B3 D7 1E B5 31 5E
      EB 47 2E 1A 3E D2 7C CF A1 36 8E 51 66 12 80 48 00 62 B6 62
      6F 3B 55 8C 0E 42 D3 84 77 6C DF 15 06 EC CE C2 C2 32 48 00
      70 2B AC F0 F5 B1 96 4D B8 19 C5 64 E4 9C 4C 69 C6 C7 79 E0
      7B 18 E1 5B 89 F6 8F 33 76 D0 7D 05 74 D5 BD 15 68 9C 59 84
      DC B1 0E FD 2C 14 56 A7 10 51 40 1E 39 FB 5A 4E B1 F8 0F 4B
      8D BF 8F 56 46 FC 04 52 E7 F9 D7 C6 DA EC A6 37 27 7E 41 27
      1F 36 3F 33 CF E7 8F AF 5E 7A AA D9 D3 A5 17 D9 FE 67 AB 97
      FC 2D 77 39 D8 ED 9A 4F DD AB 97 31 1F 9D 41 C6 EE FC 63 BF
      4F CF BF 7D B8 D8 C7 68 D1 92 C1 BA E4 0C 11 EB C5 79 D5 25
      CD 15 03 CB 54 A0 AB 39 2E FA 96 ED BC CF B1 81 B7 95 19 CF
      BF D3 FC 9A 82 E6 49 7C BC 13 B5 81 CF 03 A5 4D 37 EF DB A1
      94 9F 33 92 20 52 EA CA 18 63
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 70 FB B8 E9 EB 9F C7 FC FA AC 72 65 9C E4 87 3F C3 9C 95
      3F 4F CB A7 B7 AD 6B 25 A3 B1 9B 94 55 94 87 0C 05 2C 0E E2
      0E 30 0F 4F F1 FF 00 3F 8C 88 CA 88 A5 4A 98 D9 7E 53 D7 3F
      E7 DE B2 BD A4 DB DC DA 31 B5 84 89 CC 60 32 93 B4 71 C9 FD
      2A F5 AC BB 89 DC DC 73 91 9A 26 94 90 38 AB 0D C1 65 64 1B
      4E 79 0C 3A F4 E0 53 60 92 4C 32 1E 1D 7A 1A 86 95 AE 8F 3E
      32 93 B5 C8 AE DB 79 DE 54 F9 89 F7 80 3D 3D BE BF E7 BD 47
      0B C8 1F 70 04 C6 78 6F 7A A8 4D 28 DC E8 96 BE F2 27 32 CE
      87 74 59 31 32 9F 93 1D 3F 0E D4 EB 42 AE C1 00 2A 71 90 7F
      87 FC 9F F3 EE E4 95 82 2A 32 D1 6E 33 50 43 1B 26 E5 6C FA
      9E 0D 56 86 62 C7 F7 64 64 37 38 E9 9F A7 6C D1 16 92 4C 14
      54 9B 7D 49 6F 55 9D 72 AB 81 FE CF 5A AB 1B 0E 57 EE 93 D7
      1D 33 FE 7F CF AE CA 77 83 1C 55 9E A5 DB 70 86 36 0E 09 18
      C6 07 AD 56 B9 82 44 C8 51 90 C3 8C 8E 07 D7 EB 51 CC E3 26
      98 ED 2E 6B 0F B0 CB 37 CC 36 92 79 20 63 F9 FE 35 A1 7D B5
      6C 77 8C E7 3C 8E DC D6 92 D1 AE 51 AB BD 64 65 97 5D A3 E6
      1B FA AE 3B 7F 8D 57 77 52 57
 > ACL data: handle 0x0029 flags 0x02 dlen 39
    L2CAP(d): cid 0x40 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46
      00 7B 02 31 84 DA 7A FB FF 00 9F FF 00 5D C1 BE 6D 09 D1 D3
      2D DB CA 0C 6B 91 F7 B9 3E E3
< ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x46 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
      90 00 03
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      01 82 03 00 49 02 FD D6 A6 96 6C 28 20 EE F7 03 9A 49 5E 44
      D4 56 8A 7D 85 79 02 C4 33 DF 9F A9 FF 00 0F F3 F5 7D BB 14
      8B 9C B1 07 9E 3A FD 3F C2 89 2B 21 3D 51 7A C5 81 70 5B 9C
      8C 11 D7 35 D3 C5 3D A4 16 3F 37 12 1E 9B 86 46 7F A5 69 2D
      6D 63 29 37 AA 33 52 F1 64 1B 4A A8 39 E0 81 8A 14 97 3F 77
      9E C4 77 F4 E6 B3 95 32 A2 A5 25 E6 59 8A 48 C0 1B F9 18 C6
      7D 4D 4A 5D 4A 8F 2C 63 D8 F6 AC D3 64 F2 D9 6A 3D 24 02 33
      95 38 E3 92 7B 54 AB 74 3C B6 04 90 7B 64 D1 6B B6 4F 22 B8
      86 72 E3 18 C7 1D 0D 3E 35 25 03 31 27 BF 4A 14 92 33 6D DC
      47 97 6C 40 95 E0 1E 3E 94 C6 BB 44 DA D1 C7 82 46 3A F5 A6
      9B E8 2A 72 92 BB 68 16 43 33 11 83 8C F3 8E F5 36 C8 DF 67
      18 1E FD 4D 2E 72 DE AB 44 36 68 E3 59 30 78 F6 EF FE 7D A9
      F6 B2 E2 61 B2 06 71 9C 63 B5 74 53 97 32 BB 27 6D 0D 3D 66
      FA 37 B7 8E 0F 20 46 CA 3E 61 D0 8A C7 33 ED 50 03 1F F1 A8
      93 D9 12 95 DB 6C F5 9F 83 8B 23 58 4E 18 90 8E 38 38 C6 78
      CE 73 DE B8 9F 1F 27 D9 F5 FB 88 F9 23 27 3F 5C 9A E2 A5 FC
      69 9D B8 A9 5A 8D 25 E6 FF 00
 > ACL data: handle 0x0029 flags 0x02 dlen 339
    L2CAP(d): cid 0x40 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46
      00 23 98 63 BC E0 12 71 D0 D2 63 39 F6 F5 EF 5B B9 6B 63 99
      2D 6C 8B 16 D2 85 60 41 3E DE F5 DD F8 3F 54 12 DB 7D 9A 43
      F3 2F BF 35 9D 68 DE 27 5D 09 7B C9 1B AA E4 B6 D5 18 CD 7A
      7F C1 AB DD D6 F7 56 47 3F 29 0E 39 FC FF 00 9D 2A 57 48 ED
      9E C8 EC BC 4B A7 B6 A9 A3 CD 64 8C AA F2 70 AC DD 05 78 AF
      8B 3C 1B 3D 8D F1 B5 D8 67 EF B9 17 E5 3F D7 FC FE 6E BB D0
      E8 C2 BB BE 5E A5 2B 4F 0B EA 71 94 28 9E 52 7A 33 02 7F 21
      FD 6A C3 69 3A 8C 52 18 C4 E8 0F A7 27 9A F3 65 26 FA 1E AF
      22 D9 31 6D 74 6B F7 6C 4B 7C 88 73 FC 2B 9F EB 5B 70 68 B3
      43 0E F9 75 1C 81 FE CF FF 00 5E A5 B9 EC B6 2A 51 8C 6D 63
      81 F8 9D 70 63 09 6E AE CD 81 93 91 C1 1E F5 E6 52 48 72 40
      C9 6C E7 D6 BD 1A 71 7C 88 E8 83 D1 22 09 9D 4F CC 4F CA 7D
      69 B6 C9 99 30 AC AB 93 90 73 C5 6D 1B A4 C1 75 B9 D6 D9 93
      FD 8E 73 92 36 77 AE 7B E6 6B 86 6E 37 02 70 07 EA 69 25 64
      CC 70 A9 29 36 68 D9 C8 10 61 30 49 1C 7F 8D 6B F8 7A 74 5B
      B2 F2 26 FE 0F FF 00 AE 9A BF 29 B5 78 39 AB 23 B0 B1 D4 62
      C1 10 9D C4 8E 08 E9 5E 99 F0
 > ACL data: handle 0x0029 flags 0x02 dlen 120
    L2CAP(d): cid 0x40 len 116 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 110 fcs 0x46
      00 C6 D5 AE 96 49 E4 3C 01 58 CE 36 56 31 AB 4D D2 A2 E6 CE
      A7 C3 13 6D BA B9 83 B3 36 47 E1 5D 05 74 D3 F8 4F 27 31 8D
      AB BF 3B 7E 41 45 59 C2 14 50 07 CF FF 00 B6 96 A2 B6 FE 1F
      F0 ED 90 8C 3B CD 79 2C BF 7B 05 42 26 33 F9 BF E5 9A F9 27
      57 90 1C 26 15 89 C0 61 8E 73 8E 87 EB FE 73 5D 15 A7 6A 74
      FC AF F9 B3 D1 C0 EC D2 3F FF D9
< ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x46 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
      A0 00 03
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 13
    L2CAP(d): cid 0x40 len 9 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 3 fcs 0x46
      01 81 00 03
< ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x46 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
      A0 00 03
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x46 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 8 pf 1 ilen 0 fcs 0x49
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 8 pf 1 ilen 0 fcs 0x28
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x46 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 8 pf 1 ilen 0 fcs 0x2
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 8 pf 1 ilen 0 fcs 0x63
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x46 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 8 pf 1 ilen 0 fcs 0xe3
 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00

//niklas

--------------080409020201000202040207
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body>
Marcel Holtmann wrote:
<blockquote cite="mid1090144899.4558.65.camel@pegasus" type="cite">
  <pre wrap="">Hi Niklas,

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">I have sucessfully used Bluez for sending files to my K700i without 
problems but when i want to send from the phone to my notebook it only 
works once. After i have sent one file from the phone i get a constant 
bluetooth connection showing on the phone and i don't get bluetooth as 
an alternative to send to on the phone. It seems that the connection 
doesn't go down allowing a new one to be initialized. If i disconnect 
the bluetooth device on the notebook an reconnect it again it works with 
one file again from the phone. Any ideas? Please tell me if you want any 
logfiles etc. and i will supply them.
    
        </pre>
      </blockquote>
      <pre wrap="">what kernel version do you use?
  
      </pre>
    </blockquote>
    <pre wrap="">Here is my "uname -r" i am running Suse 9.1

 uname -r
2.6.5-7.95-default
    </pre>
  </blockquote>
  <pre wrap=""><!---->
in that kernel the HCI disconnect bug for incoming connections was
fixed, so this can't be the problem. Show us the output of "hcidump -x"
as root while you send something from your phone.

And btw don't forget to CC the mailing list. Using Reply-All is allways
a good idea ;)

Regards

Marcel

  </pre>
</blockquote>
Ok, here is the output hope you can read something out of it, i
couldn't get everything copied from the terminal, the first rows
disappeared this is all that i could mark an copy, can i read the dump
in any other application to get everything?<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F5 46 FF 00 8D 35 FD 26 5F 0F<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 96 9F CD 49 24 19 8A 17 5F DE 1E DF 77 3D 2B 81 F3 54 FC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C3 A1 F5 AF 1E B5 29 53 A4 AF DD 9F 47 80 AC AA 56 93 5E 45<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7B F8 89 42 EA 2A A5 93 79 72 6E 57 C9 06 BC D7 2D 0F 75 4B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 63 D8 BE 1C DE B5 C6 8E 20 3D 21 38 1F 8F 35 D4 D3 A6 EE 99<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 95 65 69 1E 75 F1 23 9B F9 06 32 76 0F E5 5C 67 85 2E 4A 5E<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 49 0B 31 E4 E6 B1 AA F4 3A F0 EB 44 77 B6 57 1F 26 DC D5 89<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1C 37 5A E6 BD D9 D4 95 8C CB B4 21 B3 8A AA C4 E7 18 AA 4C<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 56 D4 81 DB 64 A3 B1 CD 70 FE 2D D5 62 FB 6C D8 24 0C E3 9A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A8 6F 72 D4 1C 95 91 C0 EA 3A 80 96 61 1C 44 84 CE 5A 9F A9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC 98 AD 14 80 CA 4F 63 5D 11 B3 68 27 49 C6 29 06 95 2F 98<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A5 D7 19 23 F0 A9 35 1B 95 8D 91 59 B0 6B 54 CE 3F 63 67 63<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4A 59 E5 96 C2 2D CF B8 28 00 0C F0 07 6A 5D 65 F1 A4 90 B8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25 88 C5 28 34 E4 AC 45 48 A8 C6 E5 D8 0D A9 B3 8F EC 8A C8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9B 79 0F F7 89 F5 AB FE 16 27 CC 7E E0 FB F5 A2 EF 95 A6 53<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DD 23 72 F8 B3 34 50 83 D4 E7 23 BD 76 3E 18 B3 13 49 1C 61<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 46 07 A5 63 2D 0E EB 72 D3 4C F4 4B 3B 68 AD 61 11 C4 81 47<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 53 81 D4 D4 D5 D1 15 65 63 C4<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 9C DC E4 E4 C2 8A 64 9E 39 FB 5A 82 7C 01 A5 80 C1 4F F6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BC 78 FF 00 BF 33 74 FE 7F 85 7C 91 AB E5 72 46 79 CE 14 75<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FF 00 3F E7 EB D5 89 FE 05 25 EB F9 9E 86 0A 2E 50 92 F3 42<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 26 A5 E5 CE 0C 58 C3 C7 86 C8 C0 39 F5 1D 33 FE 7E B6 AC E6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DE 72 CC 76 AF 38 1D FD EB C9 9C 3D C3 CC 6A 49 D9 77 2D 59<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3A B4 DB 72 7A 65 7B E4 7A FB D4 F2 46 23 7C 12 14 FF 00 7B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B6 7D AB 8E 53 6A 5A 15 65 29 72 A5 A1 36 C8 A5 B6 65 6C 02<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3E EF B8 AC BF B3 49 0E 36 91 8E FE 9F E4 D3 55 1C 64 CC E5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F0 F2 F5 23 B8 64 78 82 CA 3A 02 01 EE 0F F9 EF 59 90 C5 04<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8C 62 66 DA C4 1C 67 D3 D6 BA 23 36 93 17 32 E4 4C 49 AD 24<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 52 58 02 57 DB 91 F5 15 5C 5B AE 49 51 9E 7A 1E C7 FC 6B 58<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 55 95 9A 41 7B 3D 16 E3 9A 30 D1 F2 47 CC 39 CF 7A 1D 06 DC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A0 20 0E BF E7 FC FF 00 8D 4A 6F A1 9C 93 71 E6 7B 95 64 3B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A5 04 48 41 5E A3 1C 1A BC CF 14 C0 12 B8 7E A4 62 B4 95 DF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 29 A3 5A DF A0 86 DD C1 21 4F 6C 9E E7 FC FF 00 9F AB 04 B2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EF 22 45 00 A9 C7 4E 71 EF 59 27 17 A3 DC C3 DF 8C 95 89 91<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1A 69 B6 EF 63 E8 4F F8 F7 FF<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 39<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 35 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 00 3F 8C C2 25 8C 9E 0E EE DC E7 3F 5A 53 76 5A 09 E9 2B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 05 D2 09 53 7C 68 A7 03 E7 1E<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 11<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 7 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90 00 03<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 02 03 F8 48 03 F5 A6 A8 63 69 E9 82 3B 1E A7 E9 5A 43 6E<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 56 69 CC 92 B7 51 E5 C8 E8 A0 12 3A 76 22 99 02 96 6D C5 48<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 07 AA 9E 40 FF 00 39 AD 14 54 59 A3 A4 9B D4 91 19 84 A3 71<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 27 D3 B9 FF 00 3F E7 EB A3 7A D1 FD 96 39 50 B6 FC 60 F3 9A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1C 96 89 11 CB A3 BA 29 06 56 04 B6 E2 31 81 DF 1F E7 FC FB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A7 00 EE C8 62 31 8C 1E 0D 5E B6 39 E4 E5 07 EF 0F 81 F6 B0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7F 2C 9C F3 8C E0 E7 DA AD AB C4 C8 0A B6 71 C6 C2 79 1E F5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33 DF 43 4B A5 A3 EA 42 59 9D F8 3C FE 55 2C 2C 49 55 6E A2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AE 2E CB 42 D4 15 95 F7 2D 47 21 57 03 6F 19 E3 1F E7 FC FF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 3D DD 0A 0D D7 29 21 65 2A 3A FB D6 B0 76 8B 67 2C A3 CC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4F 78 D3 CD 7B 28 40 59 73 F7 41 FE 95 4C CA E8 C1 5C 73 F4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AD 63 64 73 54 85 F5 2E D8 2B CB 2A C7 19 CB B9 C0 1D 8E 6B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 54 5B DD 5A DD 79 33 C7 24 6E A7 18 6E BF E7 FC FD 77 85 5B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35 72 27 45 B8 5C F4 8F 87 B7 3A 7C 7A DD A2 5D 18 E3 F2 94<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B3 33 1C 64 F6 FE 75 EB 3A 9D A5 9E A9 60 D3 69 F7 76 AF 32<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FF 00 1C 72 06 20 FA 71 90 2B B2 A4 E5 17 09 DB 43 C6 9D 38<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D4 8D 5A 77 49 B7 A7 DC 8B 3E<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 9<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 5 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1E<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 0E 86 E6 5D 35 ED B5 39 DE 62 09 06 39 0E 58 0F 7A DE B3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B1 B0 D3 E3 63 04 51 C4 3A B3 1F F1 35 E7 62 AA 3F 69 28 C3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 44 CF 63 2A A6 9E 1E 15 2A 3B C9 2B 6A 71 1E 25 F8 95 6D 6F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 72 D6 BA 59 59 02 64 3C A5 73 FF 00 7C F6 3F 8D 47 E1 5F 14<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C3 AE DF 7D 92 EE 69 24 CA E5 56 42 30 C7 E8 38 AE C9 E0 7E<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AD 47 99 FC 5B FA 05 0C 7B C5 D7 4B EC DE DE BE BF D5 8D 0F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14 68 E9 63 0F F6 8E 9D 10 82 48 88 62 22 1B 47 AF 6E 95 B5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E1 3F 10 C3 AB 69 AB 23 B0 13 27 CB 20 27 07 23 BD 73 4A 52<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C5 61 FD A3 DE 2E C5 CE 51 CB B1 DE CD 69 19 AB F9 5D 0D F1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AF 89 AC 74 3D 12 5B 99 5F 74 8E 85 62 8D 79 66 38 F4 FF 00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0A F9 E6 FA F6 E6 69 DE 5C 9C 48 CC C7 F1 35 DF 97 D1 F6 78<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 79 4E 5F 69 FE 47 95 99 62 23 8A C6 C5 43 EC 2F CF FE 02 3A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2F 87 57 9E 56 B9 64 44 AF 96 93 68 5C F1 8C 75 AF 62 F1 D5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E9 83 C1 FA 84 D1 9E 7C 86 0A 7E A0 D4 62 61 CD 5A 97 F5 D4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8A 15 1D 3A 18 94 BB 7E 87 CE 9A 2D CC 0F 75 8B 96 C1 33 7D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E2 DF 77 9E BF FD 6A E9 B5 1D 6E 2D 04 47 05 85 D2 4D 16 77<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B2 FC CC 4E 79 F5 1D CE 7D 2B<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 A7 11 36 AB C9 3D 99 9E 1E 95 B0 F4 F9 74 92 B7 DC CA 17<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3E 2F 86 F3 CC B8 B8 F3 84 8D C6 41 C8 C7 B0 A3 C3 DA BA 5E<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 84 02 A1 79 4C 9E 48 AF 27 17 F0 7A 1F 45 97 27 0A 9A 9B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4A E1 B2 84 E7 3D EB 35 5B CB BA 65 23 23 3C 7B 57 93 63 E8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23 65 63 D2 FE 14 DD 1F B4 4B 6F 9E 19 37 0F C2 BD 16 9D 3E<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A4 D6 77 91 E7 3F 12 1D 57 52 93 D9 47 F2 AF 39 D2 EE 96 3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5F 68 C0 24 FA D6 55 11 D7 86 D6 09 1D ED A4 E4 C6 08 F4 E9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 57 63 94 32 8E 79 15 C7 73 AD AB 31 AE FE 60 2B 9E 6A 84 C1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D1 F2 4F 15 A4 75 21 A2 0B B9 00 8C 9F 63 5E 31 E2 8B B2 F7<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 93 10 DC 6F 3F 8D 69 49 6E 76 61 95 D1 CF DA 07 9E E0 18 D3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 73 F5 E7 DB FA 7F 9F AD 9F 12 4A C6 DD 37 E4 C9 D4 91 EB 5B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 43 7D 42 A2 FD E2 1B E1 63 90 EE 7A 7E 75 16 B0 EC 75 65 04<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 92 B9 1C 1E D5 4B 76 44 63 7A CD 1D 2F 4D 31 0E 73 C8 C6 6A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4D 64 ED D1 93 E5 E4 B5 2A 7B A3 8E BC 53 8F CC 7D 85 ED BA<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5A 80 49 E0 74 15 BD E1 43 E6 BB 15 19 19 CE 69 4E A7 43 4F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AA CA DC FD 0D 1B B9 18 EA 40 0E 15 70 3F 1A F4 EF 87 3B 67<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 53 21 E5 94 66 A5 EE 8E AC 4D<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 39<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 35 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 26 B0 BC CB A1 DB 51 5D 47 CD 85 14 01 E3 BF B5 AE 07 C3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FD 2D CE 30 BA BA 13 EB FE A2<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 11<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 7 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90 00 03<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 02 03 F8 48 03 F5 7E 9F E7 A6 6B E4 5D 61 F2 ED CF CD D4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 28 1D 4F B7 A0 E7 1F 8F E7 D3 8A 8D E8 52 97 AF E6 7A 59 6D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DF 32 E9 74 51 54 00 AA EE DC DD 36 55 DB 4C A3 F0 4F E1 D8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FB 57 95 55 F3 46 C9 EC 79 CE 4A EE E5 99 25 30 36 F2 0B 05<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38 07 B6 7D 3E B5 5A 6B F7 72 DE 61 38 CE 07 3D 3D 8D 61 08<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F3 A1 2B 72 39 22 65 D4 64 4D B8 65 20 FA 8C FE 22 AE AD C2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CF 68 0C 64 64 9E 87 B1 EE 2A AA D1 5C BC C8 C6 75 79 FA 19<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8D 82 4A 39 20 83 C0 3D 6A 0B D2 73 E6 A6 1B FD DE 84 7F 9F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E9 5A D2 8F 32 8A 63 84 54 67 CA F6 2E C1 7D 12 C0 AA 47 CD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D1 81 EE 7F CF F9 E6 A9 5C 4C BE 79 C0 56 4C F5 C6 39 FF 00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3F E7 D6 69 47 DE 77 63 A8 B7 71 44 6F 0F 9C 81 A2 CF 07 E7<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1C 73 51 95 91 72 12 31 C7 1F 37 7F F3 FA 52 E5 B5 4D 08 D5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A4 28 B6 0D 09 20 67 B1 0C 3F AF F8 FF 00 5A 8B 26 30 5D 81<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0C 38 C0 AD A3 77 20 8F BA 84 6B AC 9D CA 4F 5E 07 FF 00 5A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AC 41 E5 C8 15 F2 76 F7 AA 69 6F D4 8B CB 72 59 20 D9 F3 44<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 47 A8 04 F4 FC 69 1E F8 C6 A5 36 FC C1 80 3C 75 A8 50 BA 1F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2E 8E 4C 73 E5 97 ED 16 DF 2B<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 67 0C 3D FE 9D A9 B1 DD 24 84 AB A0 0C 3D 47 38 A3 91 ED<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D8 14 65 36 36 ED 91 48 08 A4 16 3D FA 7E 14 C8 98 AA 9D C3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DF EB C7 6A D9 43 DD 35 8C 9A B4 50 E9 5D 18 2B 2A 9D DE F5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2B EE 6B 75 DC 72 17 A8 A4 A3 CA 90 7B DA 3B 08 22 59 08 E7<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96 E7 6F 70 29 8D 1B 05 CC 63 E6 1D 3D EA DB 77 26 4B 99 32<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 34 97 71 60 53 81 C9 C7 6F A5 4F 1B A3 00 49 E0 9E 2A DC 6C<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B4 31 9E 9B 89 24 A4 CB 80 38 CF AD 4F 64 0F 3E 61 C9 3D E9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B5 CB 11 DE EA E6 81 1B D0 61 01 C7 A5 5F D3 AE 64 8E 33 1A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0E A3 82 45 55 37 EE D8 E7 4D 26 D9 2A CA F1 8D DB 9B 79 EF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8A 8E 29 D1 94 99 B2 C0 9E A7 BD 5E FA 99 49 36 AC 5A 82 76<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8F 94 2C 08 3C 10 7F AD 69 A5 E5 C4 B2 A4 97 13 34 84 01 B7<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24 9F A6 33 56 9D DE A4 38 BB EA 69 E9 9A 8B C5 A8 47 74 8E<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 46 C9 FF 00 3F E7 FC 7D AB C2 3E 2F D2 6D E3 59 AE F5 98<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80 75 04 C5 26 D0 54 FE 15 EC 53 8B AD 47 95 2B BD 8F 17 13<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4D D3 AB CE DD BA 9D 4C 1E 37 F0 C3 5C AC 8B A8 DB 06 23 96<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12 0C 7E 35 A1 71 E2 8F 0F DD 5A B4 7F DA D6 65 64 05 48 13<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2E 7F 2C D7 1C F0 15 E2 D3 E5<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 36 A5 98 51 E4 94 6E 95 CF 17 F1 6F 87 5E 29 65 9F 49 D4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 61 BD 80 92 C0 79 8A 18 75 27 3E BD 7F CF 39 CD F0 84 F7 16<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BA D4 52 79 FF 00 67 31 B6 4B 67 8F A7 F9 FF 00 F5 FA 38 BC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 42 9C 1B 6A CF AA 27 2D A7 1A 72 8A 4E EB B9 E9 BE 20 F1 7B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36 92 D1 8B A1 2B 11 8D AA 47 3F 5C 55 6F 05 5D 5A E9 BA 6C<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 97 97 93 22 CB 39 CF 97 E6 0E 07 AE 3F 5A F3 30 10 6A 94 A2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BA B3 BB 38 AB 4E 75 E2 DF 44 FF 00 E1 8C 8F 1E 78 AA D1 ED<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25 86 30 97 2A C3 03 9F BB 5E 75 1C E5 DF 3B B8 CF 7A F4 E5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EE 53 51 3C BC 35 36 E5 CE CD A8 6F A5 B0 48 6F 20 5F 99 5B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B1 C5 6E 6B 5F 11 67 BC F0 D4 D6 32 C3 B5 A4 5D 83 91 91 C7<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5E B5 8A 94 1A 8B 96 E9 9A E2 28 C9 CD A8 ED 25 66 79 E5 A4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90 F9 CF 23 46 5D B9 20 0F 53 DF F5 FF 00 39 A8 CD E2 34 9B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19 D9 81 E4 6F 39 18 AE 4A F5 DC E5 26 76 C2 84 61 15 A6 C3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FC F8 F7 64 9C 83 D3 35 77 4C BC 10 5C AB 06 19 CF E9 5E 4C<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DB 6C EE 84 DA 9F 31 DB 43 2A CB 1A CA 87 82 32 2A 9D DC 98<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 CF AF 5A E7 6B 53 DC 84 B4 3A FF 00 87 37 A2 0D 72 DD 8B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E1 59 B6 7D 73 C5 7B 28 E9 57<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 39<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 35 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 07 EF 58 55 37 3C DB E2 94 78 BB 77 F5 40 78 AF 25 B7 94<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7D BD 5F AE 1F AE 7F CE 7F CF<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 11<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 7 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90 00 03<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 02 03 F8 48 03 F5 E3 9D 55 A9 DB 85 76 85 CF 45 D2 A7 0D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 3D 72 2A DB 4A 55 B2 2B 81 2D 5D CE B6 2B 4E 9B 77 0E A3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A8 A7 0B 88 EE 13 1C 6E 1C 55 AD 35 25 BD 4C BD 75 8C 36 33<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30 53 90 87 A7 AD 78 E6 B5 68 64 62 C1 89 76 6C 93 DA BA 28<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B3 58 56 F6 68 C7 4B 67 8A F1 54 48 79 3D BF 95 4B AF C3 33<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BA 47 DF 1E BC 0A D5 5F 98 99 D7 F7 D4 99 37 87 A1 68 AD D8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 48 40 39 E0 7B D6 66 A6 AD FD AA 1C A1 2A 1B BD 5A 8D 9B 2A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8D 54 EA B6 74 27 50 85 E0 82 D9 18 33 1C 64 E7 80 3E B5 6F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C4 52 46 B6 51 46 B2 0D C4 81 B0 9A 98 DD 49 24 67 52 2D 24<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50 B6 57 00 29 52 07 61 5D CF 82 97 09 9F 5E B5 9C A1 EF 36<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7A 75 DA 74 B4 34 9A 35 6B E7 63 9E 4D 77 1E 07 B8 96 D6 F1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 42 A9 2A C3 E6 1D A8 93 B3 3A DD 15 3C 1C D3 EC 7A 2C 4E 5D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 41 23 14 EA E8 84 B9 A3 73 E1 DA B3 B0 51 56 23 C8 7F 6B 00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4F C3 CD 3C 80 38 D5 A3 E7 19 C7 EE A5 AF 8F 75 C5 61 B8 A1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 07 27 EE 9E 87 FF 00 AD FA FF 00 5E BC 45 BD 85 2B ED AF E6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7A B9 64 9A E6 4D 75 45 08 5D 21 9E 37 93 2F 0B FC B9 1D FD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3A F5 F7 F5 FE 7A 26 E6 DC CD<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 BA 11 CE 3E 61 FD 0F BF 7A F0 A5 0E 5F 79 2F E9 1E 4D 4F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7A C4 B2 CC 18 10 48 64 6E 84 77 1E F5 9B 70 E1 65 2A E4 02<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7A 7A FF 00 9E 94 E1 75 1D 3A 9A C2 2A 31 D7 66 35 5C 2B 10<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CB 8E 78 C9 FC 87 D6 B6 2C 1D 1A D0 EC 1C 9C 60 E7 FA D3 93<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7C B6 33 9A 82 5E EE E8 A7 29 8E 49 C8 9F 23 9C 13 E9 E9 4D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 61 E5 BE FD DB 94 1E 9E 9F E7 FC FB D4 1C 93 68 CA 72 D5 4D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8B 24 5B 90 EC 40 13 1F 28 F4 3E F5 52 58 64 07 78 3C 37 3E<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A0 F6 A7 07 CA F5 2F 9D CD E8 0A EF 00 DC AA C1 87 60 3A FA<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D3 FE D4 8B 32 3C A9 95 6E 0F A0 CF 7F AF F9 FA CB B4 A7 24<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 92 BE A5 C9 5C 45 22 B7 50 DC 8E FC 7D 2A B5 DD BA 4E AC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 63 3D 7F 84 9E 1B DA AA 9C A5 19 2B 98 DD 77 32 E6 59 15 F7<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11 92 78 F4 FF 00 3F E7 F1 92 39 08 4F 9B 2A 48 E7 6F 07 EA<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 07 F4 AE 9D EF 73 78 F4 45 C9 E7 26 25 40 01 E8 03 63 FC FF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 9F AF 29 18 0C BF BC 41 BB A6 0F 22 B0 53 76 33 A9 4D AD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 57 52 65 29 1A 85 39 19 EA 0F 7A 68 B4 04 B3 2B EE E3 27 3F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E7 FC FF 00 35 ED 1A BB 33 9B 69 73 08 F1 E6 3D 85 BE 60 32<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33 DF F1 A8 32 70 15 DB 79 03<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 AF 41 FE 7F C6 B6 84 DB D4 D2 9B BE E3 E3 74 04 ED 1F FD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6A 9C 90 14 1D E1 81 EA 47 F8 50 E2 D9 B5 EE B9 47 23 80 A4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15 1E E0 7A D4 7B BE 7C 05 60 4F 1F E7 D6 A9 68 88 94 62 D3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1C 88 85 B3 8F 98 F5 1D 87 BF E3 50 C8 4A 12 50 30 23 B7 61<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 57 19 36 EC 61 64 D7 92 16 D8 09 32 48 27 23 24 F4 AB 70 AA<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 39 38 CF A9 FF 00 3E DF E7 AD D4 93 5A 22 64 A3 2B 34 5B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 56 DA C1 0B 90 A3 90 40 FD 45 6C E9 91 86 70 C8 DB B1 D4 52<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4A C9 30 56 27 B9 92 32 BB 53 18 6E BE A0 FD 7D 2A 9B C7 B1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F6 B0 C8 3D 8F AD 25 3E 88 8E 57 B9 69 1B F7 63 6A 91 EC 7A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D5 97 9B 2A A4 9C FC B8 23 15 70 95 D9 94 DD C9 ED A4 45 4C<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 F4 FF 00 1A B3 6D 78 E1 09 DC D8 27 AE 6B B2 85 79 47 A9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C9 5A 9F 33 2D 5B 6A 12 6E 07 79 F4 C0 E3 FC FF 00 9F C6 D3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6A 93 1C 83 21 2B D3 EF 13 9A EC FA EC AE 71 FD 5E 36 6A C3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 EA 77 C9 04 83 DC 02 73 4B 1D D4 C0 8C 33 71 D7 26 B9 EA<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E2 79 DD 99 AD 2C 32 86 A8 B1 1D EC D2 E5 B7 ED 00 67 39 A1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EF 19 06 ED E4 E0 E7 25 8D 2A 55 DC 74 45 D5 A1 19 45 39 22<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD DD DF 9A 98 12 16 CF BE 6A<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 39<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 35 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 1B 56 71 30 C0 62 0F BD 5C 6B 3B 6A 54 29 25 AA 37 6F A7<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 65 D1 F6 90 AB 93 C1 CF 35 CD<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 11<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 7 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90 00 03<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 02 03 F8 48 03 F5 DC 48 08 3B 5B EB CF 41 FD 7F CF E3 9C<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E7 A6 83 4A F2 B1 BB E1 2B 65 BA 86 E7 2F 12 32 AF 52 39 35<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8B 75 0C 71 CC 46 C2 4E EE 6B 81 54 7E D1 C5 9D B8 8A 5C B1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 BA DC 8A 42 AA 49 1C E7 A0 F5 34 E8 DA 48 42 B3 AE 03 8C<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A9 F5 15 94 9A D8 39 34 D0 EC BC 25 7F E7 5B 88 1C 00 47 03<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DE B4 6F 53 0E 1B 39 15 83 6D 48 F5 68 34 E0 8D 0F 0F CC D0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5D C7 22 B0 04 30 3C 7E 75 F4 0D 9C A2 7B 48 A7 1D 24 40 DF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 98 AD 29 BB D8 BA 92 4D E8 70 3F 16 E2 38 47 00 9D F1 E0 FE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B5 E2 0D 27 95 7D C8 CF CD F9 D4 D6 D9 D8 EC C3 FC 07 7B A2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DD 03 02 15 3C 63 D6 B6 BC C0 D1 FE 15 E6 DD 9D DD 08 86 E1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 91 50 0D F1 BE F8 F3 F4 AA 4C 9B 22 87 8A 2F 88 D2 25 24 F2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 46 2B CD AE A6 DC 72 0E 79 AD A9 EE C5 56 29 45 1C E6 B9 31<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 59 81 8F 2A 41 C9 39 A9 AC 19 A7 80 3C AC 5F D4 9E E6 BA D6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 88 39 3F 74 99 B1 66 81 21 38 E8 39 CE 2B 3F 55 89 76 97 6F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C0 D2 5A EA 63 4D B8 D4 5E 65 5D 2A 13 2B 8F 9D 77 16 E0 63<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1F 8D 6B DD 5A 20 B8 86 26 2C EC 78 24 FF 00 2A 4A 4D 4A C8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F4 71 32 E5 92 35 AC 34 87 91<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 F3 21 3C 7E A2 BB 4F 0C 58 AC 08 63 1E 99 CF AD 4B 6F 70<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9D 75 38 A4 6A 69 5A 64 D7 7A 8E C8 A2 67 76 3F 28 1F A9 AF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 49 D0 7C 3C 6C 55 5A 66 46 70 39 DB CF F4 A7 C9 CF A2 37 CC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 71 D1 A1 87 8D 15 BB 37 D4 60 62 96 BA 23 1E 55 64 7C 90 51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 54 07 90 FE D6 0C 17 E1 D6 9F 95 2D 9D 5E 2C 01 FF 00 5C A5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FF 00 F5 D7 C7 BA EB 02 C7 18 43 9F 99 B3 C0 FF 00 EB 93 FE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7D 7A 71 6E D8 7A 3F 3F CC F5 72 D5 A4 9F 6F F2 39 48 E7 78<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 95 01 65 91 8F 3B 32 4F 03 A7 E5 E9 DB F9 EB 5A 4C B2 C0 19<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 77 15 C0 07 D4 1E DC FF 00 4C F3 5E 6D 69 B5 15 23 C5 8D 55<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AC 3B 5C D3 B4 24 DB EF 60 73 DC 01 FE 7E BF 9D 41 70 1D 3F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 79 F2 B2 F4 2D F5 A8 5C B7 B9 B3 6A 31 5C C5 46 3B 64 6F 94<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 95 1D 4F 5F C3 FC FF 00 FA E7 B5 BA 96 14 2A A1 98 FF 00 08<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CF 3F 89 ED F5 FF 00 27 5E 44 E3 64 72 BA F2 6D E9 6B B1 B2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4E CF B4 36 49 3D 0A F5 1C 66 9F 04 AE 32 A7 27 DF 19 34 A4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A3 7E 54 5F 2B 92 E6 BE 85 F8 A4 46 8B 1D 3D 3D E9 EB 17 99<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13 B6 DE 07 20 FF 00 5F F3 FF 00 EB E7 92 71 D4 50 9B 86 85<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6B 76 5F F5 13 72 84 9C 37 71<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 4D BA B1 0C E4 02 40 CE 7D 88 FF 00 1A A7 EE CB 99 0A 5A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AF 52 A5 CA 48 9F 27 CC 71 D8 F4 3F E7 FC FB 91 AC AC 72 19<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C6 DC 8F A7 F8 7F 9F C6 E9 FC 09 11 CA A2 ED E8 68 4D 6B 04<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D6 1B E5 05 59 7A FF 00 88 AC F1 10 DC 47 2A 3B 63 9F AF E3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FE 7E B2 AA 7B F7 EC 5C 64 A3 79 79 8D 64 60 42 A8 CE 0E 36<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FF 00 9F E5 56 A2 1C 7A 8F 51 E9 ED 57 7B C8 D2 AC 97 2A B6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E3 A7 9E 30 76 3A 8E 80 06 FE B5 12 CE 61 6F 94 92 AD F7 47<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5E 3F AD 25 07 CB 63 9E CB 71 D7 53 34 B0 96 61 B4 A9 E3 8A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A7 92 4F CC CC C3 D3 FC FF 00 9F EB AC 63 64 6D 09 2B DB A9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 34 43 20 75 38 E3 DE AC 4E A1 6D 83 8E 57 8C 63 A1 CD 5D 87<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CF CB 75 6D 8A EA DC 6F F4 E3 1D FD F3 41 95 81 CF E6 0F 70<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6B 48 C5 48 CD 3B 2B 92 C7 2E 58 31 CE E2 71 EF 52 B8 47 04<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E3 18 E9 8A C9 5F 9A E6 6D A5 A0 89 F2 A9 E7 93 D3 1D 2A 7B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 56 53 82 E0 8A D1 BB 14 E2 8B F1 3C 6C C0 6D 63 DB 3D EB 5E<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CA E0 DB FF 00 AB 0B F3 2E 3E ED 36 B4 21 35 12 AE 59 A5 EE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33 C9 1D 7F CF F9 FC 5A DB 84 9B BE 63 8E 30 79 A8 93 49 E8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 43 BD B4 2C 89 70 3E EF 51 E9<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 39<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 35 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 4F 80 19 78 C9 00 76 23 15 70 B2 5C C4 CF E1 2D 5A A9 42<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15 B9 19 AB B2 A2 EC C9 27 9F<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 11<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 7 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90 00 03<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 02 03 F8 48 03 F5 4A 97 36 A4 60 EE D1 08 CA 4B C8 C0 F6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A9 44 98 C9 39 27 1D 2B 5F 69 7D 48 4A DD 0B 0B 74 A2 D4 C6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14 AB 7F 78 1E 9F FD 7A A4 B7 0C A7 01 49 39 E0 E6 9C 59 51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F7 BA 0A 67 91 57 9D D8 27 F5 FF 00 0A 27 BA 06 30 15 18 00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3B 9E A6 AA 32 69 E8 CB 76 D6 E8 8E 2B 8D A4 1D C7 A7 F9 C5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6A DA 5D 44 E0 1D CC 0E 3A 8A D1 CE E2 94 13 D8 7D ED E2 B4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22 08 01 68 D4 60 B1 E8 4F D6 B3 66 76 63 EF 9C 73 59 54 9D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 84 95 8E EF E1 8E 92 F7 D1 DC 93 2A 2E 23 F9 B3 FA 0F D6 B9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8D 71 56 D7 50 96 32 73 B5 8A 83 DB AD 70 C6 6E 55 A7 1E C7<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 55 68 72 C6 9E BA 3B 99 CD 70 A3 91 E9 DF FC F3 4D 9A E4 6C<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19 6C E3 8C 9A 08 7B E8 5F F0 F6 A3 24 37 48 E1 48 00 E3 69<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AF 45 CA DC DA 87 5E 49 19 A8 A8 F9 5D CE FC 33 BA 69 A1 2C<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 06 C7 52 09 E0 D7 BA 78 0E F1 6F 3C 35 6E 43 64 C5 98 DB F0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35 74 5F 73 57 D0 CA F8 A9 6C 64 D2 16 75 5C ED CA 9F F3 F9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D7 CF 5A 92 EC 95 B6 0C 8D D9 3C FF 00 9F F3 FA 95 1D 93 B9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D9 86 97 BA D1 D3 F8 62 E8 1B 74 CB 71 8E B5 D2 C5 72 B8 03<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35 E5 B7 69 33 D0 8B F7 6E 59<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 8A EA 22 30 58 1A 94 F9 6E 3E 52 29 A6 FA 0A FD 8E 43 E2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 04 BE 4E 9E 54 67 04 FA 57 9A 9B FD B1 90 47 CD D1 6B AE 8A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D2 E6 D2 A7 CD 05 73 12 EE 6C CC C5 C9 2D DB 23 A9 FE 82 AD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E9 17 DB 14 A1 1C 7D 2B A9 C5 49 5C 75 A2 F9 34 D8 E9 EC E5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 06 D3 7B 60 8E E4 56 0E A3 7A 8E E6 35 1B B3 D7 1E B5 31 5E<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EB 47 2E 1A 3E D2 7C CF A1 36 8E 51 66 12 80 48 00 62 B6 62<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6F 3B 55 8C 0E 42 D3 84 77 6C DF 15 06 EC CE C2 C2 32 48 00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 70 2B AC F0 F5 B1 96 4D B8 19 C5 64 E4 9C 4C 69 C6 C7 79 E0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7B 18 E1 5B 89 F6 8F 33 76 D0 7D 05 74 D5 BD 15 68 9C 59 84<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC B1 0E FD 2C 14 56 A7 10 51 40 1E 39 FB 5A 4E B1 F8 0F 4B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8D BF 8F 56 46 FC 04 52 E7 F9 D7 C6 DA EC A6 37 27 7E 41 27<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1F 36 3F 33 CF E7 8F AF 5E 7A AA D9 D3 A5 17 D9 FE 67 AB 97<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FC 2D 77 39 D8 ED 9A 4F DD AB 97 31 1F 9D 41 C6 EE FC 63 BF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4F CF BF 7D B8 D8 C7 68 D1 92 C1 BA E4 0C 11 EB C5 79 D5 25<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CD 15 03 CB 54 A0 AB 39 2E FA 96 ED BC CF B1 81 B7 95 19 CF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BF D3 FC 9A 82 E6 49 7C BC 13 B5 81 CF 03 A5 4D 37 EF DB A1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 94 9F 33 92 20 52 EA CA 18 63<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 70 FB B8 E9 EB 9F C7 FC FA AC 72 65 9C E4 87 3F C3 9C 95<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3F 4F CB A7 B7 AD 6B 25 A3 B1 9B 94 55 94 87 0C 05 2C 0E E2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0E 30 0F 4F F1 FF 00 3F 8C 88 CA 88 A5 4A 98 D9 7E 53 D7 3F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E7 DE B2 BD A4 DB DC DA 31 B5 84 89 CC 60 32 93 B4 71 C9 FD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2A F5 AC BB 89 DC DC 73 91 9A 26 94 90 38 AB 0D C1 65 64 1B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4E 79 0C 3A F4 E0 53 60 92 4C 32 1E 1D 7A 1A 86 95 AE 8F 3E<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32 93 B5 C8 AE DB 79 DE 54 F9 89 F7 80 3D 3D BE BF E7 BD 47<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0B C8 1F 70 04 C6 78 6F 7A A8 4D 28 DC E8 96 BE F2 27 32 CE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 87 74 59 31 32 9F 93 1D 3F 0E D4 EB 42 AE C1 00 2A 71 90 7F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 87 FC 9F F3 EE E4 95 82 2A 32 D1 6E 33 50 43 1B 26 E5 6C FA<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9E 0D 56 86 62 C7 F7 64 64 37 38 E9 9F A7 6C D1 16 92 4C 14<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 54 9B 7D 49 6F 55 9D 72 AB 81 FE CF 5A AB 1B 0E 57 EE 93 D7<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1D 33 FE 7F CF AE CA 77 83 1C 55 9E A5 DB 70 86 36 0E 09 18<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C6 07 AD 56 B9 82 44 C8 51 90 C3 8C 8E 07 D7 EB 51 CC E3 26<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 98 ED 2E 6B 0F B0 CB 37 CC 36 92 79 20 63 F9 FE 35 A1 7D B5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6C 77 8C E7 3C 8E DC D6 92 D1 AE 51 AB BD 64 65 97 5D A3 E6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1B FA AE 3B 7F 8D 57 77 52 57<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 39<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 35 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 7B 02 31 84 DA 7A FB FF 00 9F FF 00 5D C1 BE 6D 09 D1 D3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2D DB CA 0C 6B 91 F7 B9 3E E3<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 11<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 7 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90 00 03<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 82 03 00 49 02 FD D6 A6 96 6C 28 20 EE F7 03 9A 49 5E 44<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D4 56 8A 7D 85 79 02 C4 33 DF 9F A9 FF 00 0F F3 F5 7D BB 14<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8B 9C B1 07 9E 3A FD 3F C2 89 2B 21 3D 51 7A C5 81 70 5B 9C<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8C 11 D7 35 D3 C5 3D A4 16 3F 37 12 1E 9B 86 46 7F A5 69 2D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6D 63 29 37 AA 33 52 F1 64 1B 4A A8 39 E0 81 8A 14 97 3F 77<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9E C4 77 F4 E6 B3 95 32 A2 A5 25 E6 59 8A 48 C0 1B F9 18 C6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7D 4D 4A 5D 4A 8F 2C 63 D8 F6 AC D3 64 F2 D9 6A 3D 24 02 33<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 95 38 E3 92 7B 54 AB 74 3C B6 04 90 7B 64 D1 6B B6 4F 22 B8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 86 72 E3 18 C7 1D 0D 3E 35 25 03 31 27 BF 4A 14 92 33 6D DC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 47 97 6C 40 95 E0 1E 3E 94 C6 BB 44 DA D1 C7 82 46 3A F5 A6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9B E8 2A 72 92 BB 68 16 43 33 11 83 8C F3 8E F5 36 C8 DF 67<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18 1E FD 4D 2E 72 DE AB 44 36 68 E3 59 30 78 F6 EF FE 7D A9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F6 B2 E2 61 B2 06 71 9C 63 B5 74 53 97 32 BB 27 6D 0D 3D 66<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FA 37 B7 8E 0F 20 46 CA 3E 61 D0 8A C7 33 ED 50 03 1F F1 A8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 93 D9 12 95 DB 6C F5 9F 83 8B 23 58 4E 18 90 8E 38 38 C6 78<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CE 73 DE B8 9F 1F 27 D9 F5 FB 88 F9 23 27 3F 5C 9A E2 A5 FC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 69 9D B8 A9 5A 8D 25 E6 FF 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 339<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 335 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 23 98 63 BC E0 12 71 D0 D2 63 39 F6 F5 EF 5B B9 6B 63 99<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2D 6C 8B 16 D2 85 60 41 3E DE F5 DD F8 3F 54 12 DB 7D 9A 43<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F3 2F BF 35 9D 68 DE 27 5D 09 7B C9 1B AA E4 B6 D5 18 CD 7A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7F C1 AB DD D6 F7 56 47 3F 29 0E 39 FC FF 00 9D 2A 57 48 ED<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9E C8 EC BC 4B A7 B6 A9 A3 CD 64 8C AA F2 70 AC DD 05 78 AF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8B 3C 1B 3D 8D F1 B5 D8 67 EF B9 17 E5 3F D7 FC FE 6E BB D0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E8 C2 BB BE 5E A5 2B 4F 0B EA 71 94 28 9E 52 7A 33 02 7F 21<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FD 6A C3 69 3A 8C 52 18 C4 E8 0F A7 27 9A F3 65 26 FA 1E AF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22 D9 31 6D 74 6B F7 6C 4B 7C 88 73 FC 2B 9F EB 5B 70 68 B3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 43 0E F9 75 1C 81 FE CF FF 00 5E A5 B9 EC B6 2A 51 8C 6D 63<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 81 F8 9D 70 63 09 6E AE CD 81 93 91 C1 1E F5 E6 52 48 72 40<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C9 6C E7 D6 BD 1A 71 7C 88 E8 83 D1 22 09 9D 4F CC 4F CA 7D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 69 B6 C9 99 30 AC AB 93 90 73 C5 6D 1B A4 C1 75 B9 D6 D9 93<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FD 8E 73 92 36 77 AE 7B E6 6B 86 6E 37 02 70 07 EA 69 25 64<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CC 70 A9 29 36 68 D9 C8 10 61 30 49 1C 7F 8D 6B F8 7A 74 5B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B2 F2 26 FE 0F FF 00 AE 9A BF 29 B5 78 39 AB 23 B0 B1 D4 62<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C1 10 9D C4 8E 08 E9 5E 99 F0<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 120<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 116 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 110 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 C6 D5 AE 96 49 E4 3C 01 58 CE 36 56 31 AB 4D D2 A2 E6 CE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A7 C3 13 6D BA B9 83 B3 36 47 E1 5D 05 74 D3 F8 4F 27 31 8D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AB BF 3B 7E 41 45 59 C2 14 50 07 CF FF 00 B6 96 A2 B6 FE 1F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F0 ED 90 8C 3B CD 79 2C BF 7B 05 42 26 33 F9 BF E5 9A F9 27<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 57 90 1C 26 15 89 C0 61 8E 73 8E 87 EB FE 73 5D 15 A7 6A 74<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FC AF F9 B3 D1 C0 EC D2 3F FF D9<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 11<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 7 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A0 00 03<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 13<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 9 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 3 fcs 0x46<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 81 00 03<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 11<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 7 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A0 00 03<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 0 dlci 8 pf 1 ilen 0 fcs 0x49<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 1 dlci 8 pf 1 ilen 0 fcs 0x28<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 8 pf 1 ilen 0 fcs 0x2<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 0 dlci 8 pf 1 ilen 0 fcs 0x63<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x46 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DM: cr 1 dlci 8 pf 1 ilen 0 fcs 0xe3<br>
&gt; HCI Event: Number of Completed Packets(0x13) plen 5<br>
&nbsp; 01 29 00 01 00<br>
<br>
//niklas<br>
</body>
</html>

--------------080409020201000202040207--
