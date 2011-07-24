Return-Path: <cyrus@holtmann.org>
Message-ID: <4E2C67A1.7060601@kernelconcepts.de>
Date: Sun, 24 Jul 2011 20:42:41 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: RFCOMM connection lag (slow)
References: <4E2C46CE.2060000@kernelconcepts.de> <1311527208.2657.27.camel@THOR> <4E2C5D32.5030108@kernelconcepts.de>
In-Reply-To: <4E2C5D32.5030108@kernelconcepts.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 24.07.2011 19:58, schrieb Nils Faerber:
> Am 24.07.2011 19:06, schrieb Peter Hurley:
>> 1. What does an hcidump -tX of the session say?
> 
> The complete log would be a little longer.
> Is there something special that I could watch for?
> 
> Here an excerpt:
> 
> 1311530163.994927 > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 0c 00 01 00                                    .....
> 1311530165.033926 > ACL data: handle 12 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 0]
>       0000: 09 ff 01 02 5c                                    ....\
> 1311530165.034148 < ACL data: handle 12 flags 0x00 dlen 40
>     0000: 24 00 43 00 0b ef 41 01  20 40 00 57 60 00 00 03  $.C...A. @.W`...
>     0010: fc 01 00 07 00 00 00 00  58 60 00 00 fe ff 01 80  ........X`......
>     0020: 03 00 00 00 00 d7 af 9a                           ........
> 1311530165.034254 < ACL data: handle 12 flags 0x00 dlen 39
>     0000: 23 00 43 00 0b ef 3f 01  20 40 00 59 60 00 00 fc  #.C...?. @.Y`...
>     0010: ff 01 e0 01 00 00 00 00  5a c0 00 00 fc ff 01 38  ........Z......8
>     0020: 00 00 00 00 00 cc 9a                              .......
> 1311530165.244924 > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 0c 00 01 00                                    .....
> 1311530166.494919 > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 0c 00 01 00                                    .....
> 1311530167.594936 > ACL data: handle 12 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 0]
>       0000: 09 ff 01 02 5c                                    ....\

Strangely the dump from the Android G1 looks pretty different (and better):

1311284173.980396 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
1311284174.009115 > ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2
1311284174.012621 < ACL data: handle 1 flags 0x02 dlen 40
    L2CAP(d): cid 0x0043 len 36 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 32 fcs 0x9a
      0000: 01 20 40 01 5a 00 00 00  00 00 00 00 00 00 00 00  .
@.Z...........
      0010: 00 5b 00 00 00 00 00 00  00 00 00 00 00 00 dd a4
.[..............
1311284174.016646 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
1311284174.048780 < ACL data: handle 1 flags 0x02 dlen 40
    L2CAP(d): cid 0x0043 len 36 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 32 fcs 0x9a
      0000: 01 20 40 01 5c 00 00 00  00 00 00 00 00 00 00 00  .
@.\...........
      0010: 00 5d 00 00 00 00 00 00  00 00 00 00 00 00 98 90
.]..............


Why does the hcidump from Linux not show RFCOMM(d) parts like the G1 dump?
Pretty strange...

>> Regards,
>> Peter
Cheers
  nils

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
