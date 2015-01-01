Return-Path: <cyrus@holtmann.org>
Message-ID: <54A54E4C.4080005@gmail.com>
Date: Thu, 01 Jan 2015 14:40:28 +0100
From: Miguel Barrio Orsikowsky <megamik@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: PROBLEM: 0489:e062 [Sony VAIO SVF1531C5E] Bluetooth adapter does
 not see BT devices
References: <54A2D333.7090607@gmail.com> <FB8B7DF3-D835-4270-8932-BAED0DA050BE@holtmann.org> <54A3DD1B.4040100@gmail.com> <F1981414-E281-4925-9C71-7310F538219F@holtmann.org> <54A3F213.20106@gmail.com> <6DA7C965-5DC7-4A67-81FA-6182DF3A12F5@holtmann.org>
In-Reply-To: <6DA7C965-5DC7-4A67-81FA-6182DF3A12F5@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

El 31/12/14 a las 23:51, Marcel Holtmann escribió:

Hi Marcel,

> I have done the following:
>
> 1. dmesg | grep Bluetooth. This reveals the name of the firmware patch needed:
>
> [   15.825275] Bluetooth: hci0: BCM: patch brcm/BCM43142A0-0489-e062.hcd not found
>
> 2. Mounted the Windows 8.1 x64 partition into /mnt
>
> 3. find /mnt -iname '*brcm.inf'. This leads to '/mnt/Program Files/WIDCOMM/Bluetooth Software/bin/bcbtums-win8x64-brcm.inf', viewed it and located the E062 string which leads to the file BCM43142A0_001.001.011.0161.0182.hex:
>
> ...
> %BRCM43142BtAdapter.DeviceDesc%=BlueRAMUSBE062, USB\VID_0489&PID_E062       ; Sony 43142A0 combo
> ...
> ;;;;;;;;;;;;;RAMUSBE062;;;;;;;;;;;;;;;;;
>
> [RAMUSBE062.CopyList]
> bcbtums.sys
> btwampfl.sys
> BCM43142A0_001.001.011.0161.0182.hex
> ...
>
> 4. find /mnt -name 'BCM43142A0_001.001.011.0161.0182.hex'. Copied the '/mnt/Program Files/WIDCOMM/Bluetooth Software/bin/BCM43142A0_001.001.011.0161.0182.hex' file into my home dir.
>
> 5. Downloaded and compiled hex2hcd (https://github.com/jessesung/hex2hcd<https://github.com/jessesung/hex2hcd>). Executed it against the BCM43142A0_001.001.011.0161.0182.hex file to get the BCM43142A0-0489-e062.hcd as requested by the dmesg message, and put it in /lib/firmare/brcm.
>
> 6. Reboot.
>
> 7. Now dmesg does not show the error "patch brcm/BCM43142A0-0489-e062.hcd not found", but the BT adapter is not even recognized ("hcitool scan" shows No such device), and dmesg shows this error in addition to the "hci0 command 0x1001 tx timeout" one:
>
> [   26.265214] Bluetooth: hci0: HCI_OP_READ_LOCAL_VERSION failed (-110)
> can you show us btmon output for this. And it might be really hard to capture it since it is a physical present adapter. Might need to see if rfkill {block,unblock} bluetooth would kick if off the USB bus.

Issuing an rfkill block and then unblock *fixes this issue*, making the 
BT adapter fully functional after the unblock. This is the sequence of 
commands and its output (I have put btmon's output after each rfkill 
{block,unblock} command), with the laptop just powered on:

miguel@vaio:~$ dmesg|grep -e 'Bluetooth\|usb 1\-4'
[    1.059093] usb 1-4: new full-speed USB device number 2 using xhci_hcd
[    1.189158] usb 1-4: New USB device found, idVendor=0489, idProduct=e062
[    1.189163] usb 1-4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[    1.189166] usb 1-4: Product: BCM43142A0
[    1.189168] usb 1-4: Manufacturer: Broadcom Corp
[    1.189170] usb 1-4: SerialNumber: 3C77E6DC7494
[   14.959274] Bluetooth: Core ver 2.20
[   14.959296] Bluetooth: HCI device and connection manager initialized
[   14.959299] Bluetooth: HCI socket layer initialized
[   14.959301] Bluetooth: L2CAP socket layer initialized
[   14.959305] Bluetooth: SCO socket layer initialized
[   17.505949] Bluetooth: hci0 command 0x1001 tx timeout
[   19.345404] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   19.345409] Bluetooth: BNEP filters: protocol multicast
[   19.345415] Bluetooth: BNEP socket layer initialized
[   19.418888] Bluetooth: RFCOMM TTY layer initialized
[   19.418896] Bluetooth: RFCOMM socket layer initialized
[   19.418901] Bluetooth: RFCOMM ver 1.11
[   25.497507] Bluetooth: hci0: HCI_OP_READ_LOCAL_VERSION failed (-110)
miguel@vaio:~$ rfkill list 1
1: sony-bluetooth: Bluetooth
     Soft blocked: no
     Hard blocked: no
miguel@vaio:~$ rfkill list 5
5: hci0: Bluetooth
     Soft blocked: no
     Hard blocked: no
miguel@vaio:~$ rfkill block 1

= Delete Index: 00:00:00:00:00:00                             [hci0] 
366.446485

miguel@vaio:~$ rfkill list 1
1: sony-bluetooth: Bluetooth
     Soft blocked: yes
     Hard blocked: no
miguel@vaio:~$ dmesg|tail -1
[  580.695923] usb 1-4: USB disconnect, device number 2
miguel@vaio:~$ rfkill unblock 1

= New Index: 00:00:00:00:00:00 (BR/EDR,USB,hci0)              [hci0] 
592.834707
< HCI Command: Reset (0x03|0x0003) plen 0 [hci0] 592.834920
 > HCI Event: Command Complete (0x0e) plen 12 [hci0] 592.835593
       Read Local Version Information (0x04|0x0001) ncmd 1
         Status: Success (0x00)
         HCI version: Bluetooth 4.0 (0x06) - Revision 0 (0x0000)
         LMP version: Bluetooth 4.0 (0x06) - Subversion 8459 (0x210b)
         Manufacturer: Broadcom Corporation (15)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.837588
       Reset (0x03|0x0003) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Local Version Inf.. (0x04|0x0001) plen 0 [hci0] 
592.837636
 > HCI Event: Command Complete (0x0e) plen 12 [hci0] 592.838589
       Read Local Version Information (0x04|0x0001) ncmd 1
         Status: Success (0x00)
         HCI version: Bluetooth 4.0 (0x06) - Revision 0 (0x0000)
         LMP version: Bluetooth 4.0 (0x06) - Subversion 8459 (0x210b)
         Manufacturer: Broadcom Corporation (15)
< HCI Command: Vendor (0x3f|0x002e) plen 0 [hci0] 592.838631
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.839604
       Vendor (0x3f|0x002e) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 139 [hci0] 592.895629
         00 00 21 00 01 06 00 69 99 99 42 04 1f c1 5e 00 ..!....i..B...^.
         00 00 14 22 22 00 00 14 22 22 3b 02 57 02 58 02 ...""..."";.W.X.
         58 02 59 02 59 02 5a 02 5a 02 5b 02 5b 02 5c 02 X.Y.Y.Z.Z.[.[.\.
         5c 02 5d 02 5d 02 5e 02 5e 02 5f 02 5f 02 60 02 \.].].^.^._._.`.
         60 02 61 02 61 02 62 02 62 02 63 02 63 02 64 02 `.a.a.b.b.c.c.d.
         64 02 65 02 65 02 66 02 66 02 67 02 67 02 68 02 d.e.e.f.f.g.g.h.
         68 02 69 02 69 02 6a 02 6a 02 6b 28 1f 0a fd 04 h.i.i.j.j.k(....
         00 ff ff ff ff 40 06 00 00 00 00 a4 01 00 02 0a .....@..........
         00 87 00 21 00 00 00 00 00 00 00 ...!.......
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.896654
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.896745
         87 00 21 00 41 22 00 42 72 6f 61 64 63 6f 6d 20 ..!.A".Broadcom
         42 6c 75 65 74 6f 6f 74 68 20 44 65 76 69 63 65  Bluetooth Device
         20 28 34 33 31 34 32 29 00 98 01 00 03 5c 01 00 (43142).....\..
         01 72 06 00 03 00 07 08 00 01 93 04 00 20 00 00 .r........... ..
         00 92 06 00 a3 00 c8 00 14 64 8f 03 00 02 02 02 .........d......
         b2 09 00 00 00 00 80 00 00 00 00 00 6f 21 00 02 ............o!..
         33 1f 05 cf 00 00 00 aa 14 7f 8c 00 aa 00 80 0a 3...............
         92 00 00 00 00 14 00 00 00 00 00 00 6c 58 4e 6c ............lXNl
         6a 36 00 01 01 11 00 00 00 b0 00 00 00 a0 00 00 j6..............
         00 43 10 08 04 53 10 02 01 80 00 00 00 90 00 00 .C...S..........
         00 63 10 04 02 73 10 04 02 c1 00 00 00 d0 00 00 .c...s..........
         00 22 00 00 00 32 00 00 00 7c 04 00 01 0a 00 02 ."...2...|......
         0a 05 00 1c 0a 20 00 01 c4 08 00 78              ..... .....x
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.897653
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.897744
         4f 01 21 00 00 32 00 00 03 00 00 c3 00 00 c0 00 O.!..2..........
         06 98 f8 31 00 ff ff ff ff ff 7f 00 00 9c f8 31 ...1...........1
         00 ff ff ff ff 08 3b 00 00 a0 f8 31 00 ff ff ff ......;....1....
         ff 06 00 00 00 a4 f8 31 00 ff ff ff ff 5c 34 00 .......1.....\4.
         00 a8 f8 31 00 ff ff ff ff 04 00 00 00 ac f8 31 ...1...........1
         00 ff ff ff ff 36 30 00 00 b0 f8 31 00 ff ff ff .....60....1....
         ff 09 00 00 00 b4 f8 31 00 ff ff ff ff f5 33 00 .......1......3.
         00 b8 f8 31 00 ff ff ff ff c5 c4 00 00 c0 f8 31 ...1...........1
         00 ff ff ff ff 00 00 00 00 c4 f8 31 00 ff ff ff ...........1....
         ff 35 c9 00 00 ec f8 31 00 ff ff ff ff 28 c9 00 .5.....1.....(..
         00 38 f9 31 00 ff ff ff ff 32 00 00 00 3c f9 31 .8.1.....2...<.1
         00 ff ff ff ff 28 05 00 00 40 f9 31 00 ff ff ff .....(...@.1....
         ff 17 05 00 00 44 f9 31 00 ff ff ff .....D.1....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.898653
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.898745
         17 02 21 00 ff 0c 09 00 00 48 f9 31 00 ff ff ff ..!......H.1....
         ff 30 05 00 00 4c f9 31 00 ff ff ff ff 0c 08 00 .0...L.1........
         00 50 f9 31 00 ff ff ff ff 16 07 00 00 5c f9 31 .P.1.........\.1
         00 ff ff ff ff 15 09 00 00 60 f9 31 00 ff ff ff .........`.1....
         ff 08 09 00 00 64 f9 31 00 ff ff ff ff 17 0a 00 .....d.1........
         00 6c f9 31 00 ff ff ff ff 9c 05 00 00 70 f9 31 .l.1.........p.1
         00 ff ff ff ff ed 01 00 00 30 fc 31 00 ff ff ff .........0.1....
         ff 6a 04 00 00 5c fc 31 00 ff ff ff ff 02 00 00 .j...\.1........
         00 70 fc 31 00 ff ff ff ff 0b 09 00 00 94 fc 31 .p.1...........1
         00 ff ff ff ff 5e 00 00 00 c0 fc 31 00 ff ff ff .....^.....1....
         ff 02 80 00 00 c8 fc 31 00 ff ff ff ff 48 85 00 .......1.....H..
         00 cc fc 31 00 ff ff ff ff 37 45 00 00 d0 fc 31 ...1.....7E....1
         00 ff ff ff ff 2d c9 00 00 dc fc 31 .....-.....1
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.899654
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.899747
         df 02 21 00 00 ff ff ff ff 2d c8 00 00 e0 fc 31 ..!......-.....1
         00 ff ff ff ff 36 47 00 00 00 fd 31 00 ff ff ff .....6G....1....
         ff 6d 02 00 00 04 fd 31 00 ff ff ff ff 05 00 00 .m.....1........
         00 50 fd 31 00 ff ff ff ff 00 00 00 00 f4 fd 31 .P.1...........1
         00 ff ff ff ff 80 00 00 00 f8 fd 31 00 ff ff ff ...........1....
         ff 37 4a 00 00 1c fe 31 00 ff ff ff ff a3 18 00 .7J....1........
         00 20 fe 31 00 ff ff ff ff 88 1b 00 00 24 fe 31  . .1.........$.1
         00 ff ff ff ff 19 18 00 00 28 fe 31 00 ff ff ff .........(.1....
         ff b8 1b 00 00 2c fe 31 00 ff ff ff ff 0c 18 00 .....,.1........
         00 e4 fe 31 00 ff ff ff ff 24 a0 00 00 34 ff 31 ...1.....$...4.1
         00 ff ff ff ff 21 65 00 00 3c ff 31 00 ff ff ff .....!e..<.1....
         ff 00 0c 00 00 88 ff 31 00 ff ff ff ff 28 94 00 .......1.....(..
         00 8c ff 31 00 ff ff ff ff 50 3c 00 ...1.....P<.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.900653
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.900746
         a7 03 21 00 00 e4 ff 31 00 ff ff ff ff 6d 6d 00 ..!....1.....mm.
         00 f0 ff 31 00 ff ff ff ff 31 80 00 00 f8 ff 31 ...1.....1.....1
         00 ff ff ff ff 44 e0 00 00 64 fc 31 00 ff ff ff .....D...d.1....
         ff 3a 40 00 00 88 fc 31 00 ff ff ff ff 00 04 00 .:@....1........
         00 34 00 60 00 ff ff ff ff 00 00 00 00 24 01 60 .4.`.........$.`
         00 ff ff ff ff 55 00 00 00 28 01 60 00 ff ff ff .....U...(.`....
         ff f5 00 00 00 2c 01 60 00 ff ff ff ff 13 00 00 .....,.`........
         00 30 01 60 00 ff ff ff ff 22 00 00 00 34 01 60 .0.`....."...4.`
         00 ff ff ff ff a2 00 00 00 38 01 60 00 ff ff ff .........8.`....
         ff 55 00 00 00 3c 01 60 00 ff ff ff ff f5 00 00 .U...<.`........
         00 40 01 60 00 ff ff ff ff 13 00 00 00 44 01 60 .@.`.........D.`
         00 ff ff ff ff 22 00 00 00 48 01 60 00 ff ff ff ....."...H.`....
         ff a2 00 00 00 c0 01 60 00 ff ff ff .......`....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.901653
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.901744
         6f 04 21 00 ff f0 00 00 00 c4 01 60 00 ff ff ff o.!........`....
         ff 00 00 00 00 c8 01 60 00 ff ff ff ff 14 00 00 .......`........
         00 cc 01 60 00 ff ff ff ff 00 00 00 00 d0 01 60 ...`...........`
         00 ff ff ff ff 1e 00 00 00 d4 01 60 00 ff ff ff ...........`....
         ff 00 00 00 00 d8 01 60 00 ff ff ff ff 00 00 00 .......`........
         00 dc 01 60 00 ff ff ff ff 5b 00 00 00 e0 01 60 ...`.....[.....`
         00 ff ff ff ff 09 00 00 00 e4 01 60 00 ff ff ff ...........`....
         ff 89 00 00 00 e8 01 60 00 ff ff ff ff 09 00 00 .......`........
         00 ec 01 60 00 ff ff ff ff d9 00 00 00 80 02 60 ...`...........`
         00 ff ff ff ff 28 00 00 00 88 02 60 00 ff ff ff .....(.....`....
         ff 02 00 00 00 8c 02 60 00 ff ff ff ff d0 00 00 .......`........
         00 94 02 60 00 ff ff ff ff 04 00 00 00 98 02 60 ...`...........`
         00 ff ff ff ff c0 00 00 00 9c 02 60 ...........`
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.902614
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.902698
         37 05 21 00 00 ff ff ff ff 1a 00 00 00 a0 02 60 7.!............`
         00 ff ff ff ff 1a 00 00 00 a4 02 60 00 ff ff ff ...........`....
         ff 1a 00 00 00 a8 02 60 00 ff ff ff ff 1a 00 00 .......`........
         00 ac 02 60 00 ff ff ff ff 1a 00 00 00 c8 02 60 ...`...........`
         00 ff ff ff ff 1a 00 00 00 cc 02 60 00 ff ff ff ...........`....
         ff 1a 00 00 00 d0 02 60 00 ff ff ff ff 1a 00 00 .......`........
         00 d4 02 60 00 ff ff ff ff 1a 00 00 00 d8 02 60 ...`...........`
         00 ff ff ff ff 1a 00 00 00 b4 02 60 00 ff ff ff ...........`....
         ff 02 00 00 00 b8 02 60 00 ff ff ff ff d0 00 00 .......`........
         00 c0 02 60 00 ff ff ff ff 04 00 00 00 c4 02 60 ...`...........`
         00 ff ff ff ff c0 00 00 00 ec 02 60 00 ff ff ff ...........`....
         ff 14 00 00 00 30 04 60 00 ff ff ff ff 01 00 00 .....0.`........
         00 74 04 60 00 ff ff ff ff b9 00 00 .t.`........
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.903614
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.903688
         ff 05 21 00 00 78 04 60 00 ff ff ff ff 00 00 00 ..!..x.`........
         00 7c 04 60 00 ff ff ff ff 07 00 00 00 80 04 60 .|.`...........`
         00 ff ff ff ff 13 00 00 00 84 04 60 00 ff ff ff ...........`....
         ff 1a 00 00 00 54 05 60 00 ff ff ff ff 1b 00 00 .....T.`........
         00 2c 06 60 00 ff ff ff ff 00 00 00 00 34 06 60 .,.`.........4.`
         00 ff ff ff ff 0a 00 00 00 38 06 60 00 ff ff ff .........8.`....
         ff 07 00 00 00 40 06 60 00 ff ff ff ff 78 00 00 .....@.`.....x..
         00 48 06 60 00 ff ff ff ff 02 00 00 00 64 07 60 .H.`.........d.`
         00 ff ff ff ff 5c 00 00 00 70 07 60 00 ff ff ff .....\...p.`....
         ff 01 00 00 00 e0 00 64 00 ff ff ff ff 01 00 00 .......d........
         00 e4 00 64 00 ff ff ff ff 00 00 00 00 e8 00 64 ...d...........d
         00 ff ff ff ff 00 00 00 00 ec 00 64 00 ff ff ff ...........d....
         ff 02 00 00 00 f0 00 64 00 ff ff ff .......d....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.904601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.904675
         c7 06 21 00 ff 02 00 00 00 54 01 64 00 ff ff ff ..!......T.d....
         ff 13 00 00 00 f0 02 60 00 ff ff ff ff 20 00 00 .......`..... ..
         00 fc 02 60 00 ff ff ff ff 01 00 00 00 bc 01 60 ...`...........`
         00 ff ff ff ff 01 00 00 00 1c 01 64 00 ff ff ff ...........d....
         ff c0 00 00 00 1c 00 60 00 ff ff ff ff 00 00 00 .......`........
         00 20 00 60 00 ff ff ff ff 00 00 00 00 78 00 64  . .`.........x.d
         00 01 00 00 00 01 00 00 00 00 00 64 00 01 00 00 ...........d....
         00 01 00 00 00 1c 00 64 00 04 00 00 00 04 00 00 .......d........
         00 60 04 60 00 ff ff ff ff 0c 00 00 00 b4 07 60 .`.`...........`
         00 ff ff ff ff 04 00 00 00 69 02 00 b6 00 68 04 .........i....h.
         00 12 00 0c 00 b4 01 00 01 1a 24 00 ff 00 08 08 ..........$.....
         00 00 fc 01 f8 02 f4 03 f0 04 ec 05 e8 06 e4 07 ................
         00 00 fc 01 f8 02 f4 03 f0 04 ec 05 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.905601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.905675
         8f 07 21 00 e8 06 e4 07 d8 32 00 ff 08 0f 00 00 ..!......2......
         00 0d 00 00 00 0b 00 00 00 09 00 00 00 07 00 00 ................
         00 05 00 00 00 03 00 00 00 02 00 00 00 03 00 00 ................
         00 02 00 00 00 01 00 00 00 00 00 00 00 0a c4 00 ................
         4c 1f 20 00 00 00 00 00 00 00 00 00 00 00 00 00  L. .............
         00 00 00 00 00 00 00 00 00 00 00 00 20 20 00 00 ............  ..
         00 00 00 00 40 40 00 00 00 00 00 00 60 60 00 00 ....@@......``..
         00 00 00 00 70 70 00 00 00 00 00 00 80 80 00 00 ....pp..........
         00 00 00 00 90 90 00 00 00 00 00 00 a0 a0 00 00 ................
         00 00 00 00 b0 b0 00 00 00 00 00 00 c0 c0 00 00 ................
         00 00 00 00 c1 c1 00 00 00 00 00 00 c2 c2 00 00 ................
         00 00 00 00 c3 c3 00 00 00 00 00 00 c4 c4 00 00 ................
         00 00 00 00 c5 c5 00 00 00 00 00 00 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.906593
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.906626
         57 08 21 00 e4 c6 00 00 00 00 00 00 eb d6 00 00 W.!.............
         00 00 00 00 ec e6 00 00 00 00 00 00 ed e7 00 00 ................
         00 00 00 00 ee ee 00 00 00 00 00 00 ef ef 00 00 ................
         00 00 00 00 ef ef 00 00 00 00 00 00 0a 64 00 0c .............d..
         20 20 00 00 00 00 00 00 00 00 00 00 00 00 00 20 .............
         00 00 00 40 00 00 00 60 00 00 00 70 00 00 00 80 ...@...`...p....
         00 00 00 90 00 00 00 a0 00 00 00 b0 00 00 00 c0 ................
         00 00 00 c1 00 00 00 c2 00 00 00 c3 00 00 00 c4 ................
         00 00 00 c5 00 00 00 e4 00 00 00 eb 00 00 00 ec ................
         00 00 00 ed 00 00 00 ee 00 00 00 ef 00 00 00 ef ................
         00 00 00 70 04 00 19 01 00 00 86 3f 00 04 00 1e ...p.......?....
         14 01 02 04 5c 00 3d 14 01 00 0e c0 ff 40 00 0e ....\.=......@..
         c0 ff 40 00 5c 00 3d 14 03 02 08 f0 ..@.\.=.....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.907594
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.907651
         1f 09 21 00 10 02 0a e1 1f 01 14 00 04 00 00 cc ..!.............
         00 00 00 00 04 00 00 00 00 00 00 66 02 33 03 c8 ...........f.3..
         00 00 ff 01 0b 04 00 d0 02 0b 00 08 0f 00 00 ac ................
         21 03 00 bd e8 f0 81 00 00 00 00 00 00 08 0f 00 !...............
         01 dc 24 03 00 00 bf 00 bf 00 00 00 00 00 00 0b ..$.............
         04 00 0a 03 0b 00 0b 04 00 82 04 0b 00 0b 04 00 ................
         82 05 0b 00 08 0f 00 02 f4 94 01 00 96 f0 84 be ................
         00 00 00 02 0b 00 08 0f 00 03 4c 46 00 00 ab f0 ..........LF....
         dc bd 00 00 08 02 0b 00 08 0f 00 04 e8 4d 00 00 .............M..
         ab f0 45 bc 00 00 76 06 0b 00 08 0f 00 05 94 6b ..E...v........k
         00 00 a9 f0 4a be 00 00 2c 08 0b 00 0b 04 00 5c ....J...,......\
         09 0b 00 0b 04 00 94 09 0b 00 0b 04 00 48 0c 0b .............H..
         00 08 0f 00 06 c4 f4 01 00 91 f0 2e ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.908602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.908687
         e7 09 21 00 bc 00 00 24 0d 0b 00 08 0f 00 07 bc ..!....$........
         34 05 00 5d f0 ff be 00 00 be 12 0b 00 08 0f 00 4..]............
         08 b0 2f 05 00 5e f0 80 ba 00 00 b4 14 0b 00 08 ../..^..........
         0f 00 09 20 31 05 00 5d f0 78 b8 00 00 14 02 0b  ... 1..].x......
         00 08 0f 00 0a 18 36 00 00 ac f0 fe bd 00 00 18 ......6.........
         02 0b 00 08 0f 00 0b dc 6c 00 00 a9 f0 a8 ba 00 ........l.......
         00 30 02 0b 00 08 0f 00 0c 10 5e 04 00 6b f0 7a .0........^..k.z
         be 00 00 08 1b 0b 00 08 0f 00 0d b0 52 02 00 8c ............R...
         f0 ba bc 00 00 28 1c 0b 00 08 0f 00 0e 88 4c 02 .....(........L.
         00 8b f0 dc ba 00 00 44 02 0b 00 08 0f 00 0f 68 .......D.......h
         5d 02 00 8a f0 70 ba 00 00 4c 02 0b 00 08 0f 00 ]....p...L......
         10 e4 f7 04 00 62 f0 25 bb 00 00 32 1e 0b 00 08 .....b.%...2....
         0f 00 11 b8 1f 01 00 9e f0 4c b9 00 .........L..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.909602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.909687
         af 0a 21 00 00 54 02 0b 00 08 0f 00 12 94 1f 01 ..!..T..........
         00 9e f0 62 b9 00 00 5c 02 0b 00 08 0f 00 13 74 ...b...\.......t
         1f 01 00 9e f0 76 b9 00 00 64 02 0b 00 08 0f 00 .....v...d......
         14 40 27 03 00 7f f0 76 bc 00 00 30 20 0b 00 08 .@'....v...0 ...
         0f 00 15 1c 30 00 00 af f0 44 b8 00 00 a8 20 0b ....0....D.... .
         00 08 0f 00 16 d8 e8 03 00 73 f0 46 bc 00 00 68 .........s.F...h
         21 0b 00 08 0f 00 17 30 8c 00 00 a9 f0 08 bc 00 !......0........
         00 44 24 0b 00 08 0f 00 18 04 8e 00 00 a7 f0 32 .D$............2
         ba 00 00 6c 02 0b 00 08 0f 00 19 18 66 04 00 6c ...l........f..l
         f0 f5 ba 00 00 06 2c 0b 00 0b 04 00 c4 34 0b 00 ......,......4..
         0b 04 00 4c 36 0b 00 08 0f 00 1a 10 f2 01 00 94 ...L6...........
         f0 3e ba 00 00 90 36 0b 00 08 0f 00 1b 20 f5 01 .>....6...... ..
         00 94 f0 58 b9 00 00 d4 37 0b 00 08 ...X....7...
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.910601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.910685
         77 0b 21 00 0f 00 1c dc 5d 02 00 8e f0 ba ba 00 w.!.....].......
         00 54 43 0b 00 08 0f 00 1d 9c 59 01 00 9a f0 6a .TC.......Y....j
         bc 00 00 74 02 0b 00 08 0f 00 1e 50 ef 04 00 61 ...t.......P...a
         f0 94 b9 00 00 7c 02 0b 00 08 0f 00 1f 58 b6 04 .....|.......X..
         00 69 f0 35 bc 00 00 c6 4e 0b 00 08 0f 00 20 98 .i.5....N..... .
         88 00 00 a7 f0 f4 bc 00 00 84 02 0b 00 08 0f 00 ................
         21 98 a5 04 00 65 f0 78 be 00 00 8c 02 0b 00 08 !....e.x........
         0f 00 22 64 14 00 00 ae f0 19 bf 00 00 9a 02 0b .."d............
         00 08 0f 00 23 60 34 00 00 b1 f0 3e be 00 00 e0 ....#`4....>....
         50 0b 00 08 0f 00 24 58 1b 03 00 7e f0 a8 bb 00 P.....$X...~....
         00 ac 02 0b 00 08 0f 00 25 14 09 02 00 94 f0 72 ........%......r
         bc 00 00 fc 51 0b 00 08 0f 00 26 6c 29 02 00 8d ....Q.....&l)...
         f0 a4 bc 00 00 b8 02 0b 00 03 01 00 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.911612
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.911686
         3f 0c 21 00 01 82 71 01 ff 06 0a 23 3c 5a 6e 7d ?.!...q....#<Zn}
         8a 02 bc 02 ee 02 20 03 52 03 b6 03 02 12 03 24  ...... .R......$
         04 34 06 3b 08 46 0a 4b 8a 02 bc 02 ee 02 20 03 .4.;.F.K...... .
         52 03 b6 03 02 12 03 24 04 34 06 3b 08 46 0a 4b R......$.4.;.F.K
         03 01 00 00 60 00 05 9c 02 ff a0 02 ff a4 02 ff ....`...........
         a8 02 ff ac 02 ff 00 00 60 00 05 c8 02 ff cc 02 ........`.......
         ff d0 02 ff d4 02 ff d8 02 ff 00 00 60 00 05 74 ............`..t
         04 f0 34 06 0f 40 06 0c 70 05 ff 38 07 ff 00 00 ..4..@..p..8....
         31 00 03 30 fc 7f 00 00 fd 7f 00 c0 fe f7 00 0b 1..0............
         00 0b 00 0b 00 0b 00 0b 00 0b 00 0b 00 0b 00 0b ................
         00 0b 00 b9 00 0a 00 7c 00 0b 00 81 00 0f 00 0f .......|........
         00 0f 00 0f 00 0f 00 0f 00 0f 00 0f 00 0f 00 0f ................
         00 b9 00 0a 00 78 00 0b 00 91 00 15 .....x......
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.912601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 180 [hci0] 592.912684
         07 0d 21 00 00 15 00 15 00 15 00 15 00 15 00 15 ..!.............
         00 15 00 15 00 15 00 b9 00 0a 00 78 00 0d 00 91 ...........x....
         00 1a 00 1a 00 1a 00 1a 00 1a 00 1a 00 1a 00 1a ................
         00 1a 00 1a 00 b9 00 0a 00 78 00 0d 00 91 00 1f .........x......
         00 1f 00 1f 00 1f 00 1f 00 1f 00 1f 00 1f 00 1f ................
         00 1f 00 b9 00 0a 00 78 00 0f 00 91 00 29 00 29 .......x.....).)
         00 29 00 29 00 29 00 29 00 29 00 29 00 29 00 29 .).).).).).).).)
         00 b9 00 0a 00 78 00 0f 00 a1 00 6a 04 00 6d 02 .....x.....j..m.
         00 13 00 00 6a 04 00 6d 02 00 13 00 00 6a 04 00 ....j..m.....j..
         6d 02 00 13 00 00 6a 04 00 6d 02 00 13 00 00 6a m.....j..m.....j
         04 00 6d 02 00 13 00 00 6a 04 00 6d 02 00 13 00 ..m.....j..m....
         00 fe 00 00 ....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.913601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.913687
         00 02 0b 00 00 f0 ca f9 69 f7 7b b9 0d 46 04 46 ........i.{..F.F
         00 f0 26 fa 54 f7 1e ba a2 f7 88 bf 1c b5 4f f0 ..&.T.........O.
         01 00 01 f0 e3 fb bd e8 1c 40 00 21 4f f4 f0 40 .........@.!O..@
         53 f7 f7 b9 18 b5 00 20 01 f0 d8 fb bd e8 18 40  S...... .......@
         00 22 01 21 56 f7 4e bd 00 b5 01 f0 75 fd 00 bd .".!V.N.....u...
         01 f0 ce fd 3e bd 00 00 01 f0 3e fe bd e8 f0 81 ....>.....>.....
         00 b5 01 f0 c3 fe 00 bd 00 b5 01 f0 cf fe 00 bd ................
         02 f0 13 f9 bd e8 f0 9f 00 b5 04 f0 8b fd 00 bd ................
         20 46 04 f0 00 fe 10 bd 04 f0 5c fe 58 f7 0b bb F........\.X...
         68 7e 40 1e 68 76 04 f0 63 fe 9a f7 82 b9 10 31 h~@.hv..c......1
         01 f1 2c 00 b6 f7 ee fa 04 f0 7f fe 51 f7 e1 b8 ..,.........Q...
         20 46 04 f0 6d ff 81 f7 64 bc 00 00 d9 f8 2c 00 F..m...d.....,.
         40 69 b0 f8 4e 00 21 46 04 f0 e2 ff @i..N.!F....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.914601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.914685
         c8 02 0b 00 05 46 72 f7 5c bb 00 00 04 48 40 78 .....Fr.\....H@x
         03 28 03 d1 04 49 03 48 08 60 00 47 70 47 00 00 .(...I.H.`.GpG..
         38 e7 20 00 11 eb 01 00 30 59 0b 00 70 b5 0d 46  8. .....0Y..p..F
         1c 46 82 28 05 d1 23 46 29 46 00 f0 0b f8 60 19 .F.(..#F)F....`.
         70 bd 00 20 70 bd af f2 1b 00 01 49 08 60 70 47  p.. p......I.`pG
         70 04 20 00 f8 b5 12 4e 0d 46 0a 46 1f 46 31 46  p. ....N.F.F.F1F
         18 46 51 f7 51 fd e4 20 6e f7 5a f8 00 f0 0f 04  .FQ.Q.. n.Z.....
         01 22 69 46 38 46 51 f7 47 fd 0a 49 08 68 00 28 ."iF8FQ.G..I.h.(
         0c d1 9d f8 00 00 a0 42 01 d0 ff 28 06 d1 01 20 .......B...(...
         08 60 aa b2 04 49 30 46 68 f7 c4 f9 f8 bd 00 00 .`...I0Fh.......
         c4 f0 20 00 34 59 0b 00 23 21 20 00 70 b5 4b 49  .. .4Y..#! .p.KI
         49 48 08 60 4b 49 4a 48 08 60 01 f0 9b fb 00 f0 IH.`KIJH.`......
         1f ff 01 f0 3f fb 4f f4 c0 04 d4 f8 ....?.O.....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.915602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.915686
         90 03 0b 00 10 04 00 22 00 b2 02 28 05 dd d4 f8 ......."...(....
         10 14 89 1e c4 f8 64 14 01 e0 c4 f8 64 24 01 28 ......d.....d$.(
         05 dd d4 f8 10 04 40 1e c4 f8 68 04 01 e0 c4 f8 ......@...h.....
         68 24 04 f2 8c 64 60 6f e1 6f 00 f0 0f 00 08 30 h$...d`o.o.....0
         60 f3 03 01 e1 67 d4 f8 b4 10 00 f0 10 00 21 f0 `....g........!.
         10 01 01 43 c4 f8 b4 10 50 f7 58 f8 06 46 50 f7 ...C....P.X..FP.
         58 f8 2f 48 01 25 85 72 30 46 50 f7 55 f8 03 f0 X./H.%.r0FP.U...
         3f fc 01 f0 4b fd 2b 49 4f f4 04 50 c1 f8 f0 0d ?...K.+IO..P....
         4f f4 48 10 c0 f8 98 50 40 f2 89 62 c1 f8 84 2f O.H....P@..b.../
         80 21 44 f8 d4 1c 01 68 21 f4 7f 61 41 f0 20 01 .!D....h!..aA. .
         01 60 21 49 c0 12 08 80 21 49 20 48 08 60 04 f0  .`!I....!I H.`..
         cb fe 21 49 1f 48 c1 f8 20 01 70 bd 01 29 18 d1  ..!I.H.. .p..)..
         18 49 01 28 0a d1 40 f2 f1 20 c1 f8              .I.(..@.. ..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.916601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.916675
         58 04 0b 00 dc 0e 44 f2 03 00 c1 f8 34 0e 48 f2 X.....D.....4.H.
         12 00 08 e0 48 f2 f1 20 c1 f8 dc 0e 44 f2 63 00  ....H.. ....D.c.
         c1 f8 34 0e 13 20 c1 f8 c0 0e 01 20 70 47 af f2  ..4.. ..... pG..
         13 10 10 49 08 60 af f2 43 01 0d 48 c0 f8 6c 11 ...I.`..C..H..l.
         0d 49 81 60 70 47 00 00 c9 0a 0b 00 0c 04 20 00 .I.`pG........ .
         31 0c 0b 00 e4 1a 20 00 1c 11 20 00 00 f0 31 00  1..... ... ...1.
         54 05 20 00 c4 5d 0b 00 68 0d 20 00 83 4a 0b 00  T. ..]..h. ..J..
         f8 4c 20 00 0c e7 20 00 1b 1a 0b 00 10 b5 b0 f8  .L ... .........
         01 30 01 24 c3 f3 09 02 03 f4 7c 43 1b 0a 0c 2b .0.$......|C...+
         09 d1 03 2a 04 d0 6d 2a 3d d1 04 f0 77 fc 0f e0 ...*..m*=...w...
         01 f0 54 fb 0c e0 fc 2b 37 d1 34 2a 1c d0 09 dc ..T....+7.4*....
         14 2a 13 d0 2b 2a 14 d0 2e 2a 2c d1 03 f0 c0 f8 .*..+*...*,.....
         01 20 10 bd b8 2a 06 d0 b9 2a 04 d0              . ...*...*..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.917601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.917676
         20 05 0b 00 f3 2a 22 d1 00 f0 1a fc f4 e7 8b f7 ....*".........
         41 f9 f1 e7 01 f0 7c fe ee e7 01 f0 4b fe eb e7 A.....|.....K...
         13 48 c0 7c c0 07 12 d0 12 49 c8 7b 40 f0 01 00 .H.|.....I.{@...
         c8 73 c8 7c 82 07 06 d5 20 f0 02 00 c8 74 00 20  .s.|.... ....t.
         5a f7 0e fc 03 e0 00 21 03 20 5a f7 4d fc 00 20  Z......!. Z.M..
         10 bd 04 2b fb d1 1d 2a 02 d1 04 f0 51 fd 00 e0 ...+...*....Q...
         00 24 20 46 10 bd af f2 b3 00 03 49 08 60 70 47  .$ F.......I.`pG
         d0 2b 20 00 84 3c 20 00 34 08 20 00 03 48 00 68  .+ ..< .4. ..H.h
         00 07 01 d5 8e f7 9a b9 70 47 00 00 30 08 20 00 ........pG..0. .
         07 48 80 68 48 b1 01 7c 4f f4 46 10 1a 29 01 d1 .H.hH..|O.F..)..
         be 21 00 e0 7d 21 c0 f8 94 10 00 20 70 47 00 00  .!..}!..... pG..
         44 29 20 00 10 b5 48 b1 01 7d 00 7c 27 22 41 ea  D) ...H..}.|'"A.
         00 43 40 f2 c6 31 d5 48 8d f7 39 ff .C@..1.H..9.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.918601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.918674
         e8 05 0b 00 00 20 10 bd 10 b5 48 b1 01 7d 00 7c  ..... ....H..}.|
         32 22 41 ea 00 43 40 f2 c6 31 ce 48 8d f7 2b ff 2"A..C@..1.H..+.
         00 20 10 bd 10 b5 48 b1 01 7d 00 7c 3d 22 41 ea  . ....H..}.|="A.
         00 43 40 f2 c6 31 c7 48 8d f7 1d ff 00 20 10 bd .C@..1.H..... ..
         10 b5 48 b1 01 7d 00 7c 48 22 41 ea 00 43 40 f2 ..H..}.|H"A..C@.
         c6 31 c0 48 8d f7 0f ff 00 20 10 bd 10 b5 48 b1  .1.H..... ....H.
         01 7d 00 7c 53 22 41 ea 00 43 40 f2 c6 31 b9 48 .}.|S"A..C@..1.H
         8d f7 01 ff 00 20 10 bd 00 28 09 d0 01 7d 00 7c  ..... ...(...}.|
         5f 22 41 ea 00 43 40 f2 c6 31 b2 48 8d f7 f3 be _"A..C@..1.H....
         70 47 70 b5 b0 48 c0 68 00 28 41 d1 af 4d 00 24 pGp..H.h.(A..M.$
         95 f8 3f 00 01 28 02 d1 85 f8 3e 40 46 e0 ab 48 ..?..(....>@F..H
         69 68 00 68 01 26 41 b9 48 b3 b5 f7 6d ff 30 b3 ih.h.&A.H...m.0.
         85 f8 3e 40 85 f8 3f 60 38 e0 00 28 ..>@..?`8..(
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.919601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.919685
         b0 06 0b 00 f8 d0 b5 f7 63 ff 00 28 f4 d1 68 68 ........c..(..hh
         29 68 80 7c 8a 7c 90 42 15 d9 9f 4a 12 78 90 42 )h.|.|.B...J.x.B
         02 d3 85 f8 3e 40 0c e0 95 f8 3e 00 01 28 03 d1 ....>@....>..(..
         02 20 85 f8 3e 00 12 e0 18 b1 03 28 03 d1 88 89  . ..>......(....
         a0 b9 85 f8 3f 60 95 f8 3e 00 01 28 05 d1 28 68 ....?`..>..(..(h
         80 89 58 b9 85 f8 3e 40 70 bd 02 28 06 d1 28 68 ..X...>@p..(..(h
         80 89 18 b9 03 20 85 f8 3e 00 70 bd 95 f8 3f 00  ..... ..>.p...?.
         01 28 fa d1 89 48 00 68 c0 f3 02 16 68 68 20 b1 .(...H.h....hh .
         80 7b 31 46 54 f7 3f fb 10 b1 6c 62 ac 62 70 bd .{1FT.?...lb.bp.
         68 68 80 4a 81 7b 24 32 30 46 6d f7 5a fa 68 6a hh.J.{$20Fm.Z.hj
         00 f0 03 00 68 62 70 bd 2d e9 f0 41 04 46 00 f1 ....hbp.-..A.F..
         18 05 0f 46 80 7b 6d f7 4a f9 46 08 20 68 00 21 ...F.{m.J.F. h.!
         82 6a 20 46 90 47 04 46 31 46 28 68              .j F.G.F1F(h
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.920601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.920684
         78 07 0b 00 6d f7 d4 f8 b0 f1 80 6f 00 d9 00 20 x...m......o...
         40 08 68 60 21 68 a0 eb 91 00 38 44 68 60 bd e8 @.h`!h....8Dh`..
         f0 81 2d e9 fc 41 6c 48 cd f8 00 d0 cd f8 04 d0 ..-..AlH........
         04 68 6e 46 65 4f 80 46 25 68 1a e0 24 1f e0 7b .hnFeO.F%h..$..{
         01 28 14 d1 97 f8 43 00 88 b1 20 68 00 21 82 6a  .(....C... h.!.j
         20 46 90 47 58 b1 90 f8 24 00 40 b1 20 46 53 f7 F.GX...$.@. FS.
         34 fe 24 1d 01 98 01 94 c4 e9 00 60 04 60 2c 46 4.$........`.`,F
         2d 68 44 45 e2 d1 59 48 00 68 79 6b 20 f0 03 00 -hDE..YH.hyk ...
         88 42 01 d3 40 1a 02 e0 08 1a c0 f1 80 50 87 08 .B..@........P..
         00 9c 0c e0 24 1f d4 e9 01 10 48 60 01 60 39 46 ....$.....H`.`9F
         20 46 ff f7 9d ff 20 46 54 f7 db fb 2c 46 25 68   F.... FT...,F%h
         b4 42 ef d1 bd e8 fc 81 2d e9 fc 47 07 46 00 25 .B......-..G.F.%
         28 46 6d f7 89 fa 46 48 00 78 00 28 (Fm...FH.x.(
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.921601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.921684
         40 08 0b 00 78 d0 df f8 fc 80 4f f0 01 09 00 2f @...x.....O..../
         46 d0 98 f8 43 00 50 b1 40 f2 71 20 b7 fb f0 f0  F...C.P.@.q ....
         b8 f8 38 10 41 43 4f f4 c8 60 b1 fb f0 f6 38 48 ..8.ACO..`....8H
         82 46 04 68 1a e0 e1 7a 20 1f 01 29 15 d1 82 7b  .F.h...z ..)...{
         09 fa 02 f1 0d 43 98 f8 43 10 71 b1 01 68 8a 6a .....C..C.q..h.j
         00 21 90 47 48 b1 90 f8 24 10 31 b1 81 68 01 eb .!.GH...$.1..h..
         46 01 81 60 01 8c 31 44 01 84 24 68 54 45 e2 d1 F..`..1D..$hTE..
         98 f8 43 00 00 b1 37 44 85 b1 69 46 38 46 6d f7 ..C...7D..iF8Fm.
         63 f9 01 24 4e 46 06 fa 04 f0 28 42 03 d0 69 46 c..$NF....(B..iF
         20 46 6d f7 26 fa 64 1c 05 2c f4 d3 ff f7 5d ff Fm.&.d..,....].
         55 f7 6f f9 d8 f8 1c 00 44 46 00 b3 00 7d 49 46 U.o.....DF...}IF
         03 28 01 d0 04 28 1a d1 c9 b1 14 48 00 68 c0 f3 .(...(.....H.h..
         02 15 28 46 b5 f7 c2 fd 88 b9 28 46 ..(F......(F
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.922585
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.922635
         08 09 0b 00 9d f7 54 f9 68 b9 e0 69 6a 46 80 7b ......T.h..ijF.{
         29 46 6d f7 72 f9 00 98 69 46 00 f0 03 00 00 90 )Fm.r...iF......
         28 46 6d f7 fa f9 54 f7 f0 fe 0a 49 18 20 08 60 (Fm...T....I. .`
         bd e8 fc 87 07 00 01 00 f8 28 20 00 44 29 20 00  .........( .D) .
         45 05 20 00 24 86 31 00 78 05 20 00 88 80 31 00  E. .$.1.x. ...1.
         c4 04 20 00 30 41 31 00 07 48 06 49 81 64 07 49  .. .0A1..H.I.d.I
         01 60 07 49 81 60 07 49 01 61 07 49 81 61 07 49 .`.I.`.I.a.I.a.I
         01 62 70 47 ad 05 0b 00 a4 4d 20 00 d1 05 0b 00  .bpG.....M .....
         ed 05 0b 00 09 06 0b 00 25 06 0b 00 41 06 0b 00 ........%...A...
         47 49 46 48 08 60 70 47 7c b5 46 49 05 46 b0 f9 GIFH.`pG|.FI.F..
         24 00 09 78 88 42 04 dc 43 49 91 f9 00 10 88 42 $..x.B..CI.....B
         01 da 0c 46 00 e0 04 46 00 1b 00 b2 a8 84 10 b9 ...F...F........
         01 20 85 f8 29 00 00 26 00 2c 02 dd              . ..)..&.,..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.923586
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.923635
         d0 09 0b 00 cd e9 00 64 07 e0 6f f0 70 40 00 90 .......d..o.p@..
         00 20 6c f7 77 ff 20 44 01 90 69 46 00 20 6d f7  . l.w. D..iF. m.
         bf f9 68 46 55 f7 2f fd 00 20 6d f7 9a f9 ee 84  ..hFU./.. m.....
         7c bd 2d e9 f0 47 df f8 bc 80 04 46 98 f8 40 00 |.-..G.....F..@.
         01 28 4d d0 94 f8 2a 00 01 27 40 b1 94 f8 29 00 .(M...*..'@...).
         58 b1 94 f8 2b 00 40 b9 20 46 84 f7 a0 fd 94 f8  X...+.@. F......
         29 00 10 b1 94 f8 2b 00 d8 b1 23 48 01 88 11 f0 ).....+...#H....
         fe 0f 16 d0 01 25 81 46 4f f4 00 6a b9 f8 00 00 .....%.FO..j....
         07 fa 05 f6 30 42 09 d0 20 6a 30 42 06 d1 29 46  ....0B.. j0B..)F
         50 46 59 f7 be fd 20 6a 30 43 20 62 6d 1c 08 2d  PFY... j0C bm..-
         ec d3 d8 f8 00 00 a0 42 09 d1 a0 8c 50 b1 a0 7c .......B....P..|
         2c 28 15 d1 20 46 ff f7 8b ff 00 20 a0 74 a0 8c  ,(.. F..... .t..
         00 28 0d d1 94 f8 2a 00 00 28 09 d1 .(....*..(..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.924603
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.924682
         98 0a 0b 00 20 7d 02 28 06 d1 00 2f 04 d0 20 46  .... }.(.../.. F
         bd e8 f0 47 53 f7 51 be bd e8 f0 87 38 59 0b 00 ...GS.Q.....8Y..
         e0 0d 20 00 d8 0d 20 00 d9 0d 20 00 44 29 20 00  .. ... ... .D) .
         64 0d 20 00 2d e9 f0 47 df f8 3c a1 4f 4e 04 46  d. .-..G..<.ON.F
         40 f2 c1 37 49 b9 4e 48 04 42 05 d0 23 46 48 22 @..7I.NH.B..#FH"
         39 46 30 46 8d f7 b7 fc 8b e0 df f8 28 81 df f8 9F0F........(...
         28 91 01 29 75 d1 49 4d 60 05 51 d5 49 e0 47 49 (..)u.IM`.Q.I.GI
         50 46 75 f7 20 fa 2b 88 20 2b 20 d2 df e8 03 f0  PFu. .+. + .....
         10 10 10 1f 10 10 1f 1f 10 1f 10 10 10 10 1f 1f ................
         1f 1f 1f 1f 1f 1f 10 10 10 10 10 1f 1f 1f 10 10 ................
         67 22 39 46 30 46 8d f7 8e fc 28 88 08 28 06 d1 g"9F0F....(..(..
         36 48 6c 22 43 68 39 46 30 46 8d f7 84 fc 28 88 6Hl"Ch9F0F....(.
         04 28 0d d1 68 88 69 68 75 22 40 ea .(..h.ihu"@.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.925601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.925675
         60 0b 0b 00 01 43 2b 48 39 46 40 1e 8d f7 77 fc `....C+H9F@...w.
         2c 48 59 f7 bf fe 10 e0 11 28 03 d1 29 48 02 f0 ,HY......(..)H..
         f7 fe 0a e0 0f 28 03 d1 26 48 04 f0 42 fa 04 e0 .....(..&H..B...
         25 49 51 f8 20 10 23 48 88 47 50 46 75 f7 0a fa  %IQ. .#H.GPFu...
         00 28 b0 d0 24 f4 80 64 20 04 2e d5 d8 f8 00 00  .(..$..d .......
         01 79 89 f8 00 10 00 21 01 71 9a f7 8f fc 57 f7 .y.....!.q....W.
         0c fe 10 b9 19 48 40 7e 50 b1 19 48 50 f7 a4 f9 .....H@~P..HP...
         5d f7 ca fc 13 21 16 20 04 f0 d0 f9 02 e0 04 e0  ]....!. ........
         50 f7 7f f9 24 f4 00 44 0f e0 02 29 0d d1 e0 03 P...$..D...)....
         09 d5 99 f8 00 00 01 28 05 d1 d8 f8 00 00 01 21 .......(.......!
         01 71 9a f7 5f fc 59 f7 6c fc 20 46 bd e8 f0 87  .q.._.Y.l. F....
         3c 27 20 00 03 00 01 00 b7 f3 fb ff b8 24 20 00  <' ..........$ .
         64 59 0b 00 30 04 20 00 64 0d 26 00              dY..0. .d.&.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.926601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.926675
         28 0c 0b 00 40 a6 20 00 38 04 20 00 10 b5 04 46  (...@. .8. ....F
         29 b9 a0 06 03 d5 02 f0 30 f9 24 f0 20 04 20 46 ).......0.$. . F
         10 bd 00 00 f0 b5 11 49 00 20 0f 4a 10 4e 01 27  .......I. .J.N.'
         4a 61 14 e0 62 09 51 f8 22 30 04 f0 1f 04 07 fa Ja..b.Q."0......
         04 f5 2b 43 41 f8 22 30 06 eb c0 02 52 68 4b 69 ..+CA."0....RhKi
         42 f0 01 02 c2 f5 3a 22 23 f8 10 20 40 1c 56 f8  B.....:"#.. @.V.
         30 40 92 2c e6 d3 f0 bd b8 5e 0b 00 9c 78 20 00 0@.,.....^...x .
         00 59 0b 00 10 b5 d0 f8 e4 00 2d 22 c0 f3 04 20 .Y........-"...
         40 ea 01 43 40 f2 c3 31 02 48 8d f7 d4 fb 00 20 @..C@..1.H.....
         10 bd 00 00 03 00 01 00 10 b5 06 48 19 22 00 7e ...........H.".~
         40 ea 01 43 40 f2 c2 31 03 48 8d f7 c4 fb 00 20 @..C@..1.H.....
         10 bd 00 00 40 3d 20 00 03 00 01 00 10 b5 90 f8  ....@= .........
         ad 00 09 04 41 ea d0 03 24 22 4f f4 ....A...$"O.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.927613
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.927685
         f0 0c 0b 00 71 71 02 48 8d f7 b1 fb 00 20 10 bd ....qq.H..... ..
         03 00 01 00 10 b5 06 49 1c 22 91 f8 90 10 41 ea .......I."....A.
         00 43 40 f2 c5 31 03 48 8d f7 a1 fb 00 20 10 bd .C@..1.H..... ..
         d4 45 20 00 03 00 01 00 70 b5 04 46 00 68 01 25  .E .....p..F.h.%
         40 01 00 f5 83 50 08 44 00 f0 1f 02 40 09 42 ea @....P.D....@.B.
         00 20 62 68 05 fa 01 f1 40 f0 1a 40 0a 42 05 d0  . bh....@..@.B..
         6e f7 79 fb 10 b9 25 74 00 20 70 bd 01 20 70 bd  n.y...%t. p.. p.
         2d e9 f8 43 06 46 c8 78 0d 46 4f f0 00 09 c8 b1 -..C.F.x.FO.....
         01 28 4e d1 24 20 6c f7 bf fc 04 46 24 21 b3 f7  .(N.$ l....F$!..
         f6 fb 69 46 24 48 8e f7 df fd 60 70 00 99 61 80 ..iF$H....`p..a.
         21 49 20 22 09 1d 20 1d b3 f7 5a fb e9 78 21 70  !I ".. ...Z..x!p
         24 22 27 e0 24 20 6c f7 a7 fc df f8 70 80 04 46  $"'.$ l.....p..F
         98 f8 00 00 20 b1 07 20 60 70 a4 f8              .... .. `p..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.928601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.928684
         b8 0d 0b 00 02 90 18 e0 24 20 6c f7 99 fc 16 49  ........$ l....I
         07 46 02 c0 20 22 29 1d b3 f7 3e fb 69 46 38 46  .F.. ")...>.iF8F
         8e f7 70 fd 60 70 00 98 60 80 38 46 6c f7 a2 fc ..p.`p..`.8Fl...
         60 78 10 b9 01 21 88 f8 00 10 04 22 e8 78 20 70 `x...!.....".x p
         31 78 23 46 4f f6 f3 40 68 f7 97 fe 20 46 6c f7 1x#FO..@h... Fl.
         91 fc 86 f8 28 90 bd e8 f8 83 12 20 30 70 fa e7  ....(...... 0p..
         60 e7 20 00 ce e6 20 00 40 4f 50 59 70 b5 d0 f8  `. ... .@OPYp...
         dc 10 d0 f8 d0 40 4e 69 93 f7 9f fd 94 f8 2f 00 .....@Ni....../.
         01 28 08 d1 04 f1 2a 05 00 f0 37 fd 31 78 04 eb .(....*...7.1x..
         41 01 c9 8b 08 e0 04 f1 28 05 00 20 00 f0 2d fd  A.......(.. ..-.
         31 78 04 eb 41 01 89 8a 08 44 00 b2 01 21 00 28 1x..A....D...!.(
         01 da 00 20 04 e0 b0 f5 80 4f 07 db 43 f6 ff 70  ... .....O..C..p
         a0 85 32 78 28 88 91 40 08 43 04 e0 ..2x(..@.C..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.929601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.929684
         80 0e 0b 00 a0 85 32 78 28 88 91 40 88 43 28 80 ......2x(..@.C(.
         30 78 bc 4a 04 eb 40 01 89 8a 22 f8 10 10 31 78 0x.J..@..."...1x
         a0 8d 0c 32 22 f8 11 00 70 bd 70 b5 d0 f8 d0 40 ...2"...p.p....@
         b5 48 0e 46 00 78 b5 49 00 eb c0 03 03 eb 00 10 .H.F.x.I........
         01 eb 40 00 b2 49 15 46 09 68 94 f8 2f 20 89 09 ..@..I.F.h../ ..
         00 eb 45 00 01 2a 0e d1 09 07 04 d5 29 46 01 20 ..E..*......)F.
         00 f0 7d fc 01 e0 90 f8 c1 00 61 19 88 72 a1 19 ..}.......a..r..
         c9 7b a8 4a 0c e0 49 07 04 d5 29 46 00 20 00 f0 .{.J..I...)F. ..
         6e fc 01 e0 90 f8 b7 00 60 55 a1 19 49 79 a2 4a n.......`U..Iy.J
         08 31 50 55 08 30 89 02 b1 fb f0 f0 70 bd 2d e9 .1PU.0......p.-.
         f0 5f df f8 78 b2 9a 4d d0 f8 d0 80 06 46 00 24 ._..x..M.....F.$
         28 68 aa 46 c0 06 22 46 01 d5 21 46 00 e0 02 21 (h.F.."F..!F...!
         30 46 ff f7 b2 ff 01 46 30 46 93 f7 0F.....F0F..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.930601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.930685
         48 0f 0b 00 90 fd 98 f8 2f 10 01 29 01 d1 59 46 H......./..)..YF
         00 e0 91 49 41 f8 24 00 64 1c 05 2c e4 db 00 26 ...IA.$.d..,...&
         df f8 38 92 2f e0 06 eb c6 00 00 eb 06 10 00 24 ..8./..........$
         05 eb 40 07 98 f8 2f 00 07 eb 44 05 01 28 0e d1 ..@.../...D..(..
         95 f8 c2 00 d8 b9 15 f8 c1 0f 5b f8 24 10 93 f7 ..........[.$...
         7e fd d9 f8 2e 10 93 f7 88 fd 28 70 0f e0 95 f8 ~.........(p....
         b8 00 60 b9 7c 49 15 f8 b7 0f 51 f8 24 10 93 f7 ..`.|I....Q.$...
         6e fd d9 f8 26 10 93 f7 78 fd 28 70 a8 72 64 1c n...&...x.(p.rd.
         05 2c d7 db 76 1c 6f 4d 68 78 b0 42 cb dc 74 4e .,..v.oMhx.B..tN
         00 24 57 46 38 68 4f ea 90 10 40 07 12 d5 21 46 .$WF8hO...@...!F
         00 20 00 f0 f8 fb 04 eb 84 01 32 68 01 eb c4 01  . ........2h....
         02 eb 81 02 52 6a 10 60 32 68 02 eb 81 01 c9 6a ....Rj.`2h.....j
         08 60 1a e0 5e 48 33 68 00 78 00 eb .`..^H3h.x..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.931602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.931686
         10 10 0b 00 c0 01 01 eb 00 10 05 eb 40 00 00 eb ............@...
         44 01 04 eb 84 00 00 eb c4 00 03 eb 80 03 5b 6a D.............[j
         11 f8 b7 2f 1a 60 32 68 89 7a 02 eb 80 00 c0 6a .../.`2h.z.....j
         01 60 64 1c 05 2c c9 db bd e8 f0 9f 2d e9 f0 41 .`d..,......-..A
         88 30 41 6d 44 6d 4a 69 81 6c 64 69 91 f8 2f 60 .0AmDmJi.ldi../`
         43 78 88 38 24 78 51 4d 51 4f 01 2e 09 d0 51 4e Cx.8$xQMQO....QN
         33 55 16 78 4b 1d c4 6a f4 54 14 78 c3 6a 2b 55 3U.xK..j.T.x.j+U
         09 e0 4d 4e 33 55 16 78 01 f1 0f 03 c4 6a f4 54 ..MN3U.x.....j.T
         14 78 c3 6a 3b 55 90 f8 89 30 05 2b 40 d1 3c 4b .x.j;U...0.+@.<K
         1b 68 5c 07 03 d5 01 6e c0 f8 c8 10 38 e0 12 78 .h\....n....8..x
         02 2a 35 d1 41 4a 12 7d d2 07 0b d0 91 f8 2f 10 .*5.AJ.}....../.
         01 29 01 d0 19 07 00 e0 99 06 00 29 28 da ff f7 .).........)(...
         26 ff 25 e0 d8 06 23 d4 33 4e 00 20 &.%...#.3N.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.932601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.932685
         d8 10 0b 00 91 f8 2f 20 01 2a 0f d0 00 eb 80 02  ....../ .*......
         34 68 02 eb c0 02 04 eb 82 04 64 6a ab 78 23 60 4h........dj.x#`
         34 68 ab 78 04 eb 82 02 d2 6a 09 e0 00 eb 80 02 4h.x.....j......
         33 68 02 eb c0 02 03 eb 82 02 d2 6a 0a b1 bb 78 3h.........j...x
         13 60 40 1c 05 28 dd db 05 20 bd e8 f0 81 70 b5  .`@..(... ....p.
         d0 f8 d0 50 04 46 05 f5 8a 76 22 46 31 46 68 6b ...P.F...v"F1Fhk
         a1 f7 63 ff 68 64 14 48 00 68 40 07 02 d5 1f 49 ..c.hd.H.h@....I
         1d 48 08 60 d4 f8 d4 00 c1 69 20 46 88 47 e0 6f  .H.`.....i F.G.o
         01 6a 04 f1 08 00 88 47 d4 f8 d4 00 c1 68 20 46 .j.....G.....h F
         88 47 84 f8 89 00 22 46 30 46 69 6c a1 f7 8e ff .G...."F0Fil....
         20 46 ff f7 67 ff 84 f8 88 00 70 bd c4 5e 0b 00 F..g.....p..^..
         1e 21 20 00 23 21 20 00 ac 1d 20 00 d0 20 20 00  .! .#! ... ..  .
         c8 20 20 00 ec 20 20 00 d8 20 20 00              .  ..  .. .
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.933601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.933685
         a0 11 0b 00 16 12 20 00 00 12 20 00 00 21 20 00  ...... ... ..! .
         08 21 20 00 f4 12 20 00 fc 12 20 00 b8 2a 20 00  .! ... ... ..* .
         dc 5c 0b 00 c0 12 20 00 10 49 0f 48 08 60 11 49  .\.... ..I.H.`.I
         0f 48 08 60 11 49 10 48 08 60 12 49 10 48 08 60 .H.`.I.H.`.I.H.`
         11 49 18 30 08 60 11 49 28 30 08 60 10 49 18 30 .I.0.`.I(0.`.I.0
         08 60 10 49 18 30 08 60 0f 49 a0 38 08 60 0f 49 .`.I.0.`.I.8.`.I
         18 30 08 60 70 47 00 00 68 59 0b 00 0c 12 20 00 .0.`pG..hY.... .
         98 5a 0b 00 d0 12 20 00 88 5b 0b 00 d4 12 20 00  .Z.... ..[.... .
         58 5c 0b 00 c0 12 20 00 c4 12 20 00 c8 12 20 00  X\.... ... ... .
         08 12 20 00 04 12 20 00 a4 12 20 00 28 13 20 00  .. ... ... .(. .
         2d e9 f0 41 04 46 40 6f 41 69 20 46 88 47 20 63  -..A.F@oAi F.G c
         d4 e9 08 10 0d 1a 00 d5 6d 42 e1 69 46 1a 00 d5 ........mB.iF...
         76 42 01 27 67 70 60 6f 41 6a 20 46              vB.'gp`oAj F
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.934601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.934685
         68 12 0b 00 88 47 05 21 10 b1 21 70 bd e8 f0 81 h....G.!..!p....
         02 2d 03 d2 02 2e 01 d2 67 70 f6 e7 60 6c 40 1c .-......gp..`l@.
         60 64 a0 6c 40 1c a0 64 e2 6c 90 42 02 d9 02 20 `d.l@..d.l.B...
         60 70 ea e7 60 6f 81 69 20 46 88 47 d4 e9 07 01  `p..`o.i F.G....
         09 1a 01 eb d1 71 00 eb 61 01 61 62 60 6f 02 69 .....q..a.ab`o.i
         20 46 90 47 00 20 60 70 d8 e7 10 b5 04 46 00 68   F.G. `p.....F.h
         40 f4 00 40 20 60 6c f7 cc fc 20 68 21 68 21 f4  @..@ `l... h!h!.
         00 41 21 60 10 bd 70 b5 05 6f d5 f8 e0 40 a2 f7 .A!`..p..o...@..
         fd f8 00 2c 1a d0 21 78 00 29 17 d0 a1 68 00 29 ...,..!x.)...h.)
         14 d0 b4 f8 01 20 64 2a 10 d3 60 4b 1b 68 9a 42  ..... d*..`K.h.B
         0c d2 88 80 a2 68 d5 f8 94 10 51 70 b4 f8 01 10 .....h....Qp....
         49 1c a4 f8 01 10 a1 68 89 1d a1 60 70 bd 10 b5 I......h...`p...
         04 46 40 6f 41 69 20 46 88 47 e0 62              .F@oAi F.G.b
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.935602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.935685
         30 13 0b 00 58 b9 21 6a 89 1e 21 62 60 6f 02 69 0...X.!j..!b`o.i
         20 46 90 47 60 6c 40 1c 60 64 03 20 0e e0 a0 6a   F.G`l@.`d. ...j
         20 61 e0 6a 60 61 00 20 a0 61 60 6f 61 6a 02 69   a.j`a. .a`oaj.i
         20 46 90 47 60 6c 40 1c 60 64 04 20 20 70 10 bd F.G`l@.`d.  p..
         83 6b 02 6b 41 6a 9a 42 02 d9 c2 62 01 62 70 47 .k.kAj.B...b.bpG
         82 62 c1 61 70 47 70 b5 01 6f 82 69 d1 f8 dc 10 .b.apGp..o.i....
         49 69 3a bb 06 69 82 6b 01 23 3b 4c 3b 4d 96 42 Ii:..i.k.#;L;M.B
         0d d9 0a 78 a3 54 0b 78 82 6b 25 f8 13 20 09 78 ...x.T.x.k%.. .x
         05 f1 18 03 02 69 23 f8 11 20 81 68 0f e0 46 69  .....i#.. .h..Fi
         96 42 0e d2 0a 78 a3 54 0b 78 82 6b 25 f8 13 20 .B...x.T.x.k%..
         2e 4b 09 78 0c 33 42 69 23 f8 11 20 c1 68 41 62  .K.x.3Bi#.. .hAb
         1e e0 83 61 82 6b 01 6b 89 1a 00 d5 49 42 43 6b ...a.k.k....IBCk
         8b 42 1a d9 83 6a 9a 1a 00 d5 52 42 .B...j....RB
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.936601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.936684
         f8 13 0b 00 8a 42 03 d2 03 63 c1 69 41 62 11 46 .....B...c.iAb.F
         c3 6a 82 6b 9a 1a 00 d5 52 42 8a 42 01 d3 41 6a .j.k....RB.B..Aj
         02 e0 03 63 01 6a 41 62 42 6f 12 69 90 47 01 20 ...c.jAbBo.i.G.
         70 bd 00 20 70 bd 10 b5 04 46 41 6a 00 6a 81 42  p.. p....FAj.j.B
         04 dd 01 20 60 70 05 20 20 70 10 bd 60 6f 41 69  ... `p. p..`oAi
         20 46 88 47 20 63 a1 6d 08 80 a0 6d 80 1c a0 65   F.G c.m...m...e
         e1 6d 60 6a 08 44 60 62 14 28 07 d1 0a 48 02 68 .m`j.D`b.(...H.h
         07 49 09 1f 08 68 00 f8 01 2b 08 60 60 6f 61 6a .I...h...+.``oaj
         02 69 20 46 90 47 00 20 60 70 10 bd 00 63 0b 00  .i F.G. `p...c..
         f8 5c 0b 00 dc 5e 0b 00 04 01 60 00 10 b5 d0 f8 .\...^....`.....
         e0 40 00 2c 0b d0 60 68 00 28 08 d0 74 49 49 68 .@.,..`h.(..tIIh
         b3 f7 f2 f8 60 68 a0 60 00 20 a4 f8 01 00 10 bd  ....`h.`. ......
         70 b5 d0 f8 e0 40 05 46 0c b9 00 20 p....@.F...
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.937601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.937685
         c0 14 0b 00 70 bd 60 68 20 b9 6b 48 40 68 6c f7  ....p.`h .kH@hl.
         13 f9 60 60 28 46 ff f7 dd ff 60 68 70 bd 70 b5 ..``(F....`hp.p.
         66 4c 00 26 4f f4 c0 05 01 28 31 d1 04 f5 4c 64 fL.&O....(1...Ld
         d4 f8 28 03 e1 6b 20 f4 00 70 40 f4 80 70 21 f4  ..(..k ..p@..p!.
         00 51 41 f4 80 41 c4 f8 28 03 e1 63 40 f4 00 70 .QA..A..(..c@..p
         41 f4 00 51 c4 f8 28 03 e1 63 c8 20 6c f7 fe fc  A..Q..(..c. l...
         d5 f8 94 01 d5 f8 80 11 00 f0 07 00 54 4a 60 f3 ............TJ`.
         1f 21 90 68 20 f8 02 1b 90 60 2e 62 40 20 e8 61  .!.h ....`.b@ .a
         ae 61 f0 20 68 61 20 68 40 f0 01 00 20 60 70 bd  .a. ha h@... `p.
         02 28 fc d1 04 f5 4c 64 26 60 6e 61 ae 61 ee 61 .(....Ld&`na.a.a
         2e 62 d4 f8 28 03 e1 6b 20 f4 00 70 21 f4 00 51  .b..(..k ..p!..Q
         40 f4 80 75 41 f4 80 46 c4 f8 28 53 e6 63 32 20 @..uA..F..(S.c2
         6c f7 cc fc 25 f4 80 70 26 f4 80 41 l...%..p&..A
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.938601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.938683
         88 15 0b 00 c4 f8 28 03 e1 63 70 bd 70 b5 d0 f8 ......(..cp.p...
         dc 40 3a 49 63 69 0a 68 05 46 37 4e b2 80 0a 68 .@:Ici.h.F7N...h
         5b 78 48 f2 ff 06 32 40 03 f0 7f 03 42 ea 03 22 [xH...2@....B.."
         0a 60 00 26 4f f4 c0 01 4e 60 a1 f7 e7 fd 26 73 .`.&O...N`....&s
         02 21 26 61 85 f8 88 10 70 bd 10 b5 a1 f7 53 fe .!&a....p.....S.
         29 48 2a 49 80 88 08 60 01 20 4f f4 c0 01 48 60  )H*I...`. O...H`
         10 bd 24 4a 24 49 01 28 0d d1 d2 f8 b4 0e 08 80 ..$J$I.(........
         1f 49 80 b2 09 88 00 f0 07 00 21 f0 07 01 01 43 .I........!....C
         c2 f8 b4 1e 70 47 02 28 fc d1 08 88 c2 f8 b4 0e ....pG.(........
         70 47 18 4a 18 49 01 28 0d d1 d2 f8 ac 0e 48 80 pG.J.I.(......H.
         13 49 80 b2 49 88 20 f0 fc 00 01 f0 fc 01 01 43  .I..I. ........C
         c2 f8 ac 1e 70 47 02 28 fc d1 48 88 c2 f8 ac 0e ....pG.(..H.....
         70 47 0f 4a 4f f4 c0 01 01 28 0b d1 pG.JO....(..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.939601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.939684
         50 16 0b 00 d1 f8 dc 04 10 70 10 20 c1 f8 dc 04  P........p. ....
         0a 48 00 78 80 06 06 d5 04 20 02 e0 02 28 02 d1  .H.x..... ...(..
         10 78 c1 f8 dc 04 70 47 04 63 0b 00 00 f0 31 00 .x....pG.c....1.
         08 5d 0b 00 18 fe 31 00 94 25 20 00 16 12 20 00  .]....1..% ... .
         70 b5 d0 f8 74 11 04 46 45 69 d1 f8 d0 60 92 f7 p...t..FEi...`..
         38 fd 20 78 03 28 15 d1 29 78 12 4a 50 5c 00 28  8. x.(..)x.JP\.(
         10 d1 11 48 76 1d 00 78 00 eb c0 03 03 eb 00 10 ...Hv..x........
         0e 4b 03 eb 40 00 00 eb 41 00 90 f8 b7 00 50 54 .K..@...A.....PT
         29 78 88 55 70 bd d1 f8 8c 10 d2 b2 00 29 00 d0 )x.Up........)..
         02 70 70 47 10 b5 04 46 92 f7 49 fd 00 21 21 73 .ppG...F..I..!!s
         21 61 10 bd 00 21 20 00 1e 21 20 00 23 21 20 00  !a...! ..! .#! .
         70 b5 04 46 90 f8 2a 00 18 b9 94 f8 29 00 04 28 p..F..*.....)..(
         0b d1 aa 4d 28 68 01 68 20 46 88 47              ...M(h.h F.G
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.940601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.940685
         18 17 0b 00 28 68 41 68 20 46 88 47 01 20 84 f8  ....(hAh F.G. ..
         28 00 70 bd 10 b5 a4 4a 51 70 90 f8 2a 00 10 b1 (.p....JQp..*...
         50 78 10 70 90 70 50 78 91 78 41 1a 00 d5 49 42 Px.p.pPx.xA...IB
         9e 4b c9 b2 5c 78 a1 42 01 d9 10 70 90 70 91 78 .K..\x.B...p.p.x
         1b 78 21 fa 03 f4 09 1b d8 40 08 44 c0 b2 10 70 .x!......@.D...p
         10 bd 70 b5 93 4e 04 46 30 68 81 68 20 46 88 47 ..p..N.F0h.h F.G
         93 4d c1 b2 28 70 20 46 ff f7 d4 ff 28 70 94 f8  .M..(p F....(p..
         2a 00 01 28 02 d1 8f 49 28 78 08 80 30 68 29 78 *..(...I(x..0h)x
         c2 68 20 46 90 47 05 46 30 68 01 69 20 46 88 47  .h F.G.F0h.i F.G
         89 49 65 63 0d 70 02 20 84 f8 28 00 70 bd 30 b5  .Iec.p. ..(.p.0.
         d0 e9 02 32 d4 1a 09 c8 18 1a 05 05 a0 02 95 fb ...2............
         f0 f0 59 1a 09 05 91 fb f0 f0 c0 eb 82 20 00 f5 ..Y.......... ..
         00 70 80 12 30 bd 70 b4 7c 4a 13 78 .p..0.p.|J.x
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.941601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.941684
         e0 17 0b 00 5a 1c 05 2b 00 d3 05 22 02 eb c2 04 ....Z..+..."....
         04 eb 02 15 78 4c 00 eb 80 00 04 eb 45 05 05 eb ....xL......E...
         40 05 05 eb 41 05 95 f8 b7 60 74 4d 53 1e ee 60 @...A....`tMS..`
         03 eb c3 06 06 eb 03 16 04 eb 46 06 06 eb 40 00 ..........F...@.
         00 eb 41 00 90 f8 b7 00 a8 60 a0 18 80 78 68 60 ..A......`...xh`
         e0 18 80 78 28 60 66 48 01 78 28 46 70 bc ba e7 ...x(`fH.x(Fp...
         f0 b5 df f8 94 c1 00 24 dc f8 3a 50 04 eb 44 00 .......$..:P..D.
         00 eb 0c 06 b6 f8 3f 00 21 46 47 19 00 20 ff f7 ......?.!FG.. ..
         be ff 38 60 b6 f8 53 10 48 51 64 1c 05 2c ed d3 ..8`..S.HQd..,..
         f0 bd 70 b5 05 46 66 f7 34 fd 59 4c 20 68 4f ea ..p..Ff.4.YL hO.
         90 10 40 07 02 d5 00 20 ff f7 da ff 20 68 4f ea  ..@.... .... hO.
         90 10 00 07 02 d5 01 20 ff f7 d2 ff 95 f8 2a 00  ....... ......*.
         10 b9 28 46 66 f7 1b fd 28 46 bd e8 ..(Ff...(F..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.942602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.942686
         a8 18 0b 00 70 40 66 f7 b9 bc 2d e9 f0 43 df f8 ....p@f...-..C..
         1c 91 47 4e 99 f8 00 20 46 4c 52 1c 05 2a 04 d3  ..GN... FLR..*..
         05 22 04 23 87 21 61 60 0e e0 51 1c 31 44 8d 78 .".#.!a`..Q.1D.x
         06 eb 02 01 89 78 53 1e a5 eb 01 05 05 eb d5 75 .....xS........u
         01 eb 65 01 61 60 09 d0 b1 18 8d 78 f1 18 89 78 ..e.a`.....x...x
         6d 1a 05 eb d5 75 01 eb 65 05 00 e0 14 25 df f8 m....u..e....%..
         c8 80 98 f8 00 10 a9 42 0f d2 db b1 17 46 1a 46 .......B.....F.F
         37 44 5b 1e 97 f8 02 c0 b7 18 bf 78 ac eb 07 0c 7D[........x....
         0c eb dc 7c 07 eb 6c 07 67 60 5b b1 b7 18 97 f8 ...|..l.g`[.....
         02 c0 f7 18 bf 78 ac eb 07 0c 0c eb dc 7c 07 eb .....x.......|..
         6c 07 00 e0 14 27 00 28 27 60 06 eb 43 00 09 d0 l....'.('`..C...
         b0 f9 20 00 a0 60 06 eb 42 00 b0 f9 20 00 e0 60  .. ..`..B... ..`
         1e 48 08 e0 b0 f9 08 00 a0 60 06 eb .H.......`..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.943602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.943685
         70 19 0b 00 42 00 b0 f9 08 00 e0 60 1a 48 18 4a p...B......`.H.J
         b0 f9 00 00 12 68 4f ea 92 12 d2 06 04 d5 a9 42 .....hO........B
         02 d0 12 48 ff f7 0f ff 0c 49 98 f8 00 20 4a 80 ...H.....I... J.
         99 f8 00 20 8a 80 a2 68 ca 80 e2 68 0a 81 22 68  ... ...h...h.."h
         4a 81 62 68 8a 81 c8 81 bd e8 f0 83 28 5d 0b 00 J.bh........(]..
         14 5d 0b 00 0c 63 0b 00 22 21 20 00 34 5f 0b 00  .]...c.."! .4_..
         1d 21 20 00 1e 21 20 00 23 21 20 00 18 5d 0b 00  .! ..! .#! ..]..
         ac 1d 20 00 10 21 20 00 0e 21 20 00 0e 49 4f f0  .. ..! ..! ..IO.
         02 02 09 7d cb 07 4f f4 c0 01 00 d0 10 b1 c1 f8 ...}..O.........
         a4 27 70 47 00 20 c1 f8 a4 07 70 47 08 49 07 48  .'pG. ....pG.I.H
         08 60 14 30 a0 f1 18 01 08 60 00 20 e6 e7 05 49  .`.0.....`. ...I
         00 20 08 60 70 47 00 00 b8 2a 20 00 2c 5d 0b 00  . .`pG...* .,]..
         24 08 20 00 a4 07 60 00 1d 48 02 68              $. ...`..H.h
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.944601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.944684
         38 1a 0b 00 1d 49 0a 60 00 6c 48 60 70 47 1a 48 8....I.`.lH`pG.H
         01 68 21 f0 42 01 01 60 00 21 01 64 01 21 01 64 .h!.B..`.!.d.!.d
         70 47 4f f4 c0 01 d1 f8 a8 07 c0 07 fb d0 d1 f8 pGO.............
         ac 07 d1 f8 a8 17 00 f0 3f 00 c1 f3 40 01 08 44 ........?...@..D
         70 47 4f ea 81 20 0e 49 4a 68 09 68 50 43 01 eb  pGO.. .IJh.hPC..
         a0 20 00 f5 48 40 01 01 01 d5 00 20 70 47 00 f5  . ..H@..... pG..
         00 70 c0 f3 87 20 70 47 04 48 03 49 02 68 0a 60  .p... pG.H.I.h.`
         40 68 08 64 70 47 00 00 64 07 60 00 44 5f 0b 00 @h.dpG..d.`.D_..
         54 5d 0b 00 4f f4 c0 02 d2 f8 00 07 43 f6 79 73 T]..O.......C.ys
         00 f0 0f 01 88 02 00 f5 00 40 43 43 c9 02 9b 12 .........@CC....
         01 f5 c0 51 9b 02 93 fb f1 f3 a3 f5 28 53 9b 12 ...Q........(S..
         c2 f8 3c 34 43 f2 f2 63 58 43 80 12 80 02 90 fb ..<4C..cXC......
         f1 f0 a0 f5 40 60 80 12 1f 28 00 d9 ....@`...(..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.945602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.945687
         00 1b 0b 00 1f 20 c2 f8 40 04 70 47 2d e9 fc 41  ..... ..@.pG-..A
         0c 46 90 46 06 46 1f 49 dd e9 08 27 00 eb 80 00 .F.F.F.I...'....
         01 eb c0 05 5a 2c 33 d8 8c b3 0a 20 b4 fb f0 f1  ....Z,3.... ....
         00 fb 11 40 58 bb b8 f1 03 0f 29 d0 3b bb 40 2a ...@X.....).;.@*
         26 d1 20 2f 24 d1 00 23 22 b2 08 21 12 48 a7 f7  &. /$..#"..!.H..
         f2 fa e0 b9 11 48 b0 f9 08 30 b0 f9 06 20 cd e9 .....H...0... ..
         00 23 b0 f9 04 30 b0 f9 02 20 b0 f9 00 10 0a 48  .#...0... .....H
         94 f7 44 f9 22 46 41 46 30 46 94 f7 29 f9 95 f8 ..D."FAF0F..)...
         26 10 07 48 95 f7 4c fc 01 20 bd e8 fc 81 ff e7 &..H..L.. ......
         00 20 fa e7 20 bf 20 00 e8 89 20 00 0c 1b 20 00  . .. . ... ... .
         54 90 20 00 70 b5 1a 49 04 46 08 78 20 f0 fc 00  T. .p..I.F.x ...
         28 30 08 70 17 48 00 25 01 68 11 b1 05 60 84 f8 (0.p.H.%.h...`..
         28 50 15 48 85 62 c5 62 58 f7 b1 fb (P.H.b.bX...
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.946601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.946684
         c8 1b 0b 00 56 f7 05 fe 30 b9 12 48 40 7e 18 b9 ....V...0..H@~..
         01 20 67 f7 53 fc 04 e0 4f f7 3b fc 04 20 84 f8  . g.S...O.;.. ..
         28 00 0d 48 05 70 0d 48 01 78 41 f0 01 01 01 70 (..H.p.H.xA....p
         0b 48 05 70 6b f7 a6 fa bd e8 70 40 04 48 06 21 .H.pk.....p@.H.!
         8e 30 b2 f7 b0 bc 00 00 7a 5f 0b 00 d4 10 20 00 .0......z_.... .
         d0 2b 20 00 40 a6 20 00 06 04 20 00 2c 09 20 00  .+ .@. ... .,. .
         df 08 20 00 2d e9 f0 47 81 46 b4 f7 e7 fd 04 46  .. .-..G.F.....F
         b4 f7 0e fd df f8 44 82 4f f4 70 77 84 42 0e d1 ......D.O.pw.B..
         b4 f7 dc fd 48 b1 4b 46 25 22 39 46 40 46 8c f7 ....H.KF%"9F@F..
         02 fc 48 46 9b f7 63 f9 01 e0 9b f7 30 f9 88 4d ..HF..c.....0..M
         28 68 04 79 87 48 b4 f7 73 fc 01 26 28 b1 85 48 (h.y.H..s..&(..H
         00 7d 00 b9 0e b9 00 20 00 e0 01 20 84 42 14 d1  .}..... ... .B..
         28 68 00 79 48 b1 4b 46 35 22 39 46 (h.yH.KF5"9F
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.947602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.947686
         90 1c 0b 00 40 46 8c f7 e2 fb 48 46 9a f7 1e fd ....@F....HF....
         07 e0 00 23 3d 22 39 46 40 46 8c f7 d8 fb 9a f7 ...#="9F@F......
         de fc 77 48 00 68 00 78 d8 b1 76 48 b4 f7 4c fc ..wH.h.x..vH..L.
         00 28 37 d0 73 48 00 7d 00 28 33 d1 00 2e 31 d0 .(7.sH.}.(3...1.
         70 48 90 f8 6c 00 00 28 2c d1 4b 46 49 22 39 46 pH..l..(,.KFI"9F
         40 46 8c f7 bc fb 49 46 bd e8 f0 47 01 20 99 f7 @F....IF...G. ..
         55 bc b4 f7 b9 fc 68 b1 00 23 5b 22 39 46 40 46 U.....h..#["9F@F
         8c f7 ad fb 9b f7 08 fc bd e8 f0 47 4f f4 80 10 ...........GO...
         4f f7 20 bb 5f 48 b4 f7 1f fc 00 28 0a d0 00 23  O. ._H.....(...#
         65 22 39 46 40 46 8c f7 9a fb bd e8 f0 47 04 20 e"9F@F.......G.
         99 f7 5b bc bd e8 f0 87 70 b5 52 4e 04 00 4f f4 ..[.....p.RN..O.
         70 75 0a d0 94 f8 32 00 94 f8 33 10 79 22 40 ea pu....2...3.y"@.
         01 43 29 46 30 46 8c f7 82 fb 94 f8 .C)F0F......
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.948602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.948685
         58 1d 0b 00 33 00 58 b3 94 f8 32 10 41 bb c1 07 X...3.X...2.A...
         0a d0 20 f0 01 00 84 f8 33 00 01 20 84 f8 32 00  .. .....3.. ..2.
         20 46 73 f7 f6 ff 28 e0 41 07 0c d5 20 f0 04 00 Fs...(.A... ...
         84 f8 33 00 04 20 84 f8 32 00 03 22 00 21 20 46  ..3.. ..2..".! F
         9d f7 26 fd 19 e0 01 07 0b d5 20 f0 08 00 84 f8 ..&....... .....
         33 00 08 20 84 f8 32 00 01 46 20 46 73 f7 3b fe  3.. ..2..F Fs.;.
         0b e0 c1 06 09 d5 20 f0 10 00 84 f8 33 00 10 20  ...... .....3..
         84 f8 32 00 20 46 73 f7 10 fe 00 2c 0b d0 14 f8  ..2. Fs....,....
         32 0f 61 78 a5 22 40 ea 01 43 29 46 30 46 bd e8 2.ax."@..C)F0F..
         70 40 8c f7 38 bb 70 bd 3e b5 04 46 90 f8 be 00 p@..8.p.>..F....
         73 f7 4f ff 05 46 26 48 29 46 90 f8 24 00 e0 75 s.O..F&H)F..$..u
         94 f8 be 00 9b f7 47 fd 2a 46 69 46 20 46 73 f7 ......G.*FiF Fs.
         9a ff 94 f8 be 00 0c 22 69 46 9d f7 ......."iF..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.949601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.949684
         20 1e 0b 00 dc f9 2b 46 cd 22 4f f4 70 71 15 48 .....+F."O.pq.H
         8c f7 15 fb 3e bd 70 b5 04 00 0e 46 15 46 1f d0 ....>.p....F.F..
         94 f8 bd 20 0f 48 00 2a 94 f8 a8 20 2b 46 4f f4  ... .H.*... +FO.
         70 71 62 f3 1f 43 09 d1 e6 22 8c f7 00 fb 2a 46 pqb..C..."....*F
         31 46 20 46 bd e8 70 40 9d f7 5d bd ed 22 8c f7  1F F..p@..].."..
         f6 fa 2a 46 31 46 20 46 bd e8 70 40 9d f7 2b bb  ..*F1F F..p@..+.
         70 bd 00 00 08 00 01 00 b8 24 20 00 84 a8 20 00  p........$ ... .
         bc 24 20 00 3c a9 20 00 f4 be 20 00 63 49 08 78  .$ .<. ... .cI.x
         0a 28 14 d1 48 78 78 28 11 d1 88 78 aa 28 0e d1 .(..Hxx(...x.(..
         c8 78 a5 28 0b d1 08 79 e1 28 08 d1 48 79 69 28 .x.(...y.(..Hyi(
         05 d1 88 79 8c 28 02 d1 c8 79 ff 28 03 d0 0c 22 ...y.(...y.(..."
         57 48 b2 f7 bd ba 70 47 2d e9 f8 4f df f8 50 a1 WH....pG-..O..P.
         81 46 aa f1 08 0a 54 46 da f8 00 50 .F....TF...P
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.950601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.950685
         e8 1e 0b 00 55 f7 db ff 07 46 90 f8 9b 00 61 68 ....U....F....ah
         46 09 01 eb 09 00 90 f8 3f 42 df f8 2c 81 01 2e F.......?B..,...
         2b d1 03 2c 09 d0 0a 2c 0f d0 0e 2c 18 d0 0f 2c +..,...,...,...,
         4f d1 28 78 98 f8 06 10 19 e0 28 78 98 f8 0b 10 O.(x......(x....
         88 42 46 d3 60 f7 33 f8 15 e0 28 78 98 f8 09 10 .BF.`.3...(x....
         88 42 f7 d2 98 f8 0a 10 88 42 3a d8 03 24 38 e0 .B.......B:..$8.
         28 78 98 f8 07 10 88 42 2a d2 98 f8 08 10 88 42 (x.....B*......B
         2f d8 60 f7 0c f8 c4 b2 2b e0 4e bb 0a 2c 0a d0 /.`.....+.N..,..
         0e 2c 0e d0 0f 2c 24 d1 a8 78 98 f8 01 10 88 42 .,...,$..x.....B
         1f d8 0e 24 1d e0 68 78 98 f8 05 10 88 42 f8 d2 ...$..hx.....B..
         17 e0 68 78 98 f8 02 10 88 42 0b d3 69 46 48 46 ..hx.....B..iFHF
         80 f7 4a fd 98 f9 03 00 9d f9 00 10 88 42 08 dc ..J..........B..
         0f 24 06 e0 98 f8 04 10 88 42 02 d8 .$.......B..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.951602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.951685
         b0 1f 0b 00 0a 24 00 e0 01 26 da f8 04 10 01 22 .....$...&....."
         01 eb 09 00 80 f8 3f 42 21 46 f0 b2 79 f7 42 fa ......?B!F..y.B.
         fa 69 01 21 c2 f3 c2 22 01 2a 02 d9 11 46 00 e0 .i.!...".*...F..
         10 38 02 78 8a 42 fb d8 bd e8 f8 8f 10 48 10 4a .8.x.B.......H.J
         08 38 01 68 d3 79 09 78 0a 20 99 42 01 d3 0f 20  .8.h.y.x. .B...
         70 47 52 7a 91 42 fb d3 0e 20 70 47 08 48 08 4a  pGRz.B... pG.H.J
         08 38 01 68 93 7a 09 78 0e 20 99 42 01 d8 03 20  .8.h.z.x. .B...
         70 47 12 7a 91 42 fb d8 0a 20 70 47 5c 06 20 00  pG.z.B... pG\. .
         7c 5d 0b 00 f0 b5 c1 07 01 d1 08 28 01 d1 19 48 |].........(...H
         01 e0 18 48 08 38 18 4a 11 68 c1 f3 0a 06 51 68 ...H.8.J.h....Qh
         c1 f3 0b 04 91 68 d3 68 c1 f3 0b 01 52 69 db 00 .....h.h....Ri..
         b3 fb f1 f7 c2 f3 0b 05 c2 88 4f f0 01 0c 4a 43 ..........O...JC
         92 0a 63 46 01 2a 00 d9 13 46 42 88 ..cF.*...FB.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.952601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.952685
         78 20 0b 00 4a 43 91 0a 01 29 00 d9 8c 46 81 88  x ..JC...)...F..
         b1 42 06 d9 9c 42 04 d2 00 88 b8 42 01 d9 65 45 .B...B.....B..eE
         01 d3 00 20 f0 bd 01 20 f0 bd 00 00 90 5d 0b 00  ... ... .....]..
         3c fd 31 00 2d e9 f0 47 06 46 c0 8b 2b 49 c0 f3 <.1.-..G.F..+I..
         81 07 c7 eb 07 10 00 eb 87 10 01 eb 80 08 38 46 ..............8F
         91 f7 52 fe 04 00 4f f0 3c 09 0a d1 70 69 b0 f8 ..R...O.<...pi..
         4e 10 3c 29 17 d2 bd e8 f0 47 c1 f1 3c 01 78 f7 N.<).....G..<.x.
         f7 bb 1f 48 00 eb c7 05 d8 f8 e4 00 81 02 0c d5 ...H............
         00 21 01 e0 2a 68 49 1c b1 eb 54 0f fa d3 20 f4 .!..*hI...T... .
         00 11 c8 f8 e4 10 bd e8 f0 87 94 f7 e7 fb 30 b1 ..............0.
         3a 46 21 46 28 46 bd e8 f0 47 94 f7 45 bc 70 69 :F!F(F...G..E.pi
         4b 46 b0 f8 4c 10 4a 46 3c 29 00 d9 0a 46 a2 42 KF..L.JF<)...F.B
         03 d2 1c 46 3c 29 00 d9 0c 46 b0 f8 ...F<)...F..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.953601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.953685
         40 21 0b 00 4e 10 b0 f8 50 20 21 44 91 42 02 d9  @!..N...P !D.B..
         89 1a 78 f7 f4 fb 22 46 29 46 70 69 bd e8 f0 47 ..x..."F)Fpi...G
         78 f7 da bc bc 38 20 00 04 10 35 00 10 b5 11 4a  x....8 ...5....J
         11 4b 11 78 52 78 c1 f5 95 70 a2 f2 1b 12 52 42 .K.xRx...p....RB
         42 ea 40 22 1a 60 0d 4b 58 31 1a 60 0c 4a 11 60 B.@".`.KX1.`.J.`
         0c 49 08 80 0c 49 08 80 0c 49 47 f6 43 60 08 60 .I...I...IG.C`.`
         aa 22 06 21 0a 48 b2 f7 da f9 bd e8 10 40 59 f7 .".!.H.......@Y.
         61 bf 00 00 0e 63 0b 00 30 05 20 00 3c 05 20 00  a....c..0. .<. .
         f8 05 20 00 40 05 20 00 42 05 20 00 8c 80 31 00  .. .@. .B. ...1.
         e4 e6 20 00 f8 b5 05 46 0e 46 51 f7 d6 fa 4e f7  .. ....F.FQ...N.
         5d f9 04 46 4e f7 5d f9 00 20 8d f8 03 00 69 46  ]..FN.].. ....iF
         69 f7 ec f8 08 20 56 f7 dd fb 4f f4 46 11 48 62  i.... V...O.F.Hb
         d1 f8 04 02 20 f0 80 00 c1 f8 04 02              .... .......
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.954586
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.954635
         08 22 0b 00 4f f4 80 70 08 60 40 02 4f f4 48 11 ."..O..p.`@.O.H.
         08 66 20 46 4e f7 44 f9 84 49 0c 20 08 60 31 46  .f FN.D..I. .`1F
         28 46 68 f7 d4 ff f8 bd 2d e9 f8 4f 0d 46 51 f7 (Fh.....-..O.FQ.
         a8 fa 4e f7 2f f9 83 46 4e f7 2f f9 e9 78 7c 4e ..N./..FN./..x|N
         4f f4 46 10 4f f0 01 09 4f f4 48 1a 4f f4 c0 07 O.F.O...O.H.O...
         00 24 c9 b9 c0 f8 00 42 80 21 c0 f8 04 12 75 49 .$.....B.!....uI
         01 60 4f f4 45 11 d1 f8 38 01 00 06 fb d5 c8 46 .`O.E...8......F
         c6 f8 c0 9c 4f f4 00 31 ca f8 60 10 c8 20 6b f7 ....O..1..`.. k.
         49 fe c7 f8 bc 81 13 e0 80 46 c0 f8 00 42 04 21 I........F...B.!
         c0 f8 04 12 ca f8 60 40 c8 20 6b f7 3b fe c8 f8  ......`@. k.;...
         00 40 c6 f8 c0 4c c8 20 6b f7 34 fe c7 f8 bc 41  .@...L. k.4....A
         58 46 4e f7 f5 f8 e8 78 df f8 7c b1 a0 46 00 28 XFN....x..|..F.(
         77 d1 8d f8 03 80 69 46 69 f7 7c f8 w.....iFi.|.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.955585
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.955642
         d0 22 0b 00 9b f8 02 10 58 46 31 b9 55 4a 11 68 ."......XF1.UJ.h
         41 60 80 f8 02 90 0c 21 11 60 44 f0 01 01 61 f3 A`.....!.`D...a.
         07 04 69 79 06 29 19 d2 df e8 01 f0 03 07 0e 40 ..iy.).........@
         43 47 24 f0 1c 01 18 31 0e e0 c4 f3 07 21 41 f0 CG$....1.....!A.
         01 01 61 f3 0f 24 09 e0 c4 f3 07 21 41 f0 01 01 ..a..$.....!A...
         61 f3 0f 24 44 f0 02 01 61 f3 07 04 aa 79 c4 f3 a..$D...a....y..
         07 21 62 f3 83 01 61 f3 0f 24 e9 78 81 bb b9 6a .!b...a..$.x...j
         4f f0 00 09 80 46 00 78 01 43 b9 62 c8 20 6b f7 O....F.x.C.b. k.
         e5 fd 38 6b 98 f8 01 10 08 43 38 63 4f f4 fa 60 ..8k.....C8cO..`
         6b f7 dc fd 29 79 37 48 6c f7 34 f8 e8 79 07 28 k...)y7Hl.4..y.(
         0f d8 e8 79 80 00 40 42 40 b2 0e e0 24 f0 e0 01 ...y..@B@...$...
         d2 e7 24 f0 e0 01 20 31 ce e7 24 f0 e0 01 a0 31  ..$... 1..$....1
         ca e7 08 28 05 d1 95 f9 08 00 81 f7 ...(........
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.956596
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.956630
         98 23 0b 00 a7 fe 05 e0 0b e0 09 28 03 d1 68 7a .#.........(..hz
         81 f7 88 fa 81 46 25 48 49 46 08 30 6c f7 0e f8 .....F%HIF.0l...
         2d e0 9b f8 02 00 d9 46 28 b1 1c 4a d9 f8 04 10 -......F(..J....
         11 60 89 f8 02 80 00 21 1c 48 6b f7 ff ff 1b 48 .`.....!.Hk....H
         00 21 08 30 6b f7 fa ff 18 48 00 21 e8 38 6b f7 .!.0k....H.!.8k.
         f5 ff 16 48 00 21 e4 38 6b f7 f0 ff b8 6a 99 f8 ...H.!.8k....j..
         00 10 88 43 b8 62 c8 20 6b f7 8c fd 38 6b 99 f8  ...C.b. k...8k..
         01 10 88 43 38 63 4f f4 00 21 ca f8 5c 10 e8 78 ...C8cO..!..\..x
         18 b9 c6 f8 c0 4c bd e8 f8 8f 4f f6 fe 70 04 40 .....L....O..p.@
         44 f0 22 00 c6 f8 c0 0c f5 e7 00 00 50 01 64 00 D.".........P.d.
         00 f0 31 00 01 00 80 00 98 5d 0b 00 04 01 60 00 ..1......]....`.
         2d e9 f0 41 04 46 d0 f8 e4 00 f9 4e 20 f4 80 10 -..A.F.....N ...
         c4 f8 e4 00 f7 4f 20 46 56 f7 a2 fb              .....O FV...
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.957602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.957691
         60 24 0b 00 00 25 08 b1 e5 65 04 e0 e0 6d 10 b1 `$...%...e...m..
         6b f7 a1 f9 f8 e7 60 68 10 b1 6b f7 9c f9 65 60 k.....`h..k...e`
         30 68 10 b1 6b f7 97 f9 35 60 38 68 00 28 02 d0 0h..k...5`8h.(..
         6b f7 91 f9 3d 60 bd e8 f0 81 2d e9 f0 47 e6 4e k...=`....-..G.N
         e6 4f c5 6d 04 46 4f f0 00 08 4f f4 87 69 25 b9 .O.m.FO...O..i%.
         48 46 6b f7 57 f9 05 00 03 d0 48 46 6b f7 52 f9 HFk.W.....HFk.R.
         80 46 30 68 4f f4 88 69 30 b9 48 46 6b f7 4a f9 .F0hO..i0.HFk.J.
         49 46 30 60 b2 f7 4b f8 38 68 30 b9 48 46 6b f7 IF0`..K.8h0.HFk.
         41 f9 49 46 38 60 b2 f7 42 f8 35 b1 b8 f1 00 0f A.IF8`..B.5.....
         03 d0 38 68 08 b1 30 68 c8 b9 00 20 e5 65 c4 f8  ..8h..0h... .e..
         e0 00 d4 f8 e4 00 c1 02 08 d4 40 f4 80 10 c4 f8 ..........@.....
         e4 00 50 22 07 21 20 68 59 f7 27 ff c8 48 00 68  ..P".! hY.'..H.h
         10 b9 c7 48 6b f7 28 f9 00 20 bd e8              ...Hk.(.. ..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.958602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.958655
         28 25 0b 00 f0 87 c4 f8 04 80 e5 65 d4 f8 e4 00 (%.........e....
         07 21 20 f4 80 10 c4 f8 e4 00 20 68 59 f7 38 ff  .! ....... hY.8.
         ee e7 70 b5 04 46 78 21 b2 f7 9e f8 04 f1 78 00 ..p..Fx!......x.
         78 21 05 46 b2 f7 98 f8 c4 f8 f8 40 04 f1 77 00 x!.F.......@..w.
         c4 e9 3f 04 c4 f8 04 41 78 30 c4 f8 08 51 f0 34 ..?....Ax0...Q.4
         c4 e9 07 05 00 20 65 62 20 70 a0 71 84 f8 28 00  ..... eb p.q..(.
         84 f8 29 00 70 bd 2d e9 fc 4f ac 4d 88 46 11 78 ..).p.-..O.M.F.x
         95 f8 19 71 79 bb 77 bb 43 46 00 21 2d e0 04 78 ...qy.w.CF.!-..x
         46 78 5b 1e 44 ea 06 24 86 78 10 f8 03 7f 80 1e Fx[.D..$.x......
         46 ea 07 26 01 27 7c 40 86 f0 ad 06 34 43 14 f0 F..&.'|@....4C..
         ff 0f 19 d1 01 21 40 1e 85 f8 19 11 5b 1c 0f e0 .....!@.....[...
         f0 35 69 69 10 f8 01 4b 01 f8 01 4b 69 61 69 6a .5ii...K...Kiaij
         14 78 01 f8 01 4b 69 62 29 78 49 1c .x...Kib)xI.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.959614
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.959687
         f0 25 0b 00 05 f8 f0 19 5b 1e ed d2 18 e1 03 e0 .%......[.......
         49 1c 41 45 cf d3 13 e1 8e 4e ae 46 f8 36 d6 e9 I.AE.....N.F.6..
         00 14 35 69 76 69 01 2f 21 d1 1c e0 de f8 04 71 ..5ivi./!......q
         10 f8 01 cb 07 f8 01 cb ce f8 04 71 a7 42 01 d9 ...........q.B..
         ce f8 04 11 de f8 14 71 92 f8 00 c0 07 f8 01 cb .......q........
         ce f8 14 71 b7 42 01 d9 ce f8 14 51 9e f8 f0 70 ...q.B.....Q...p
         7f 1c 8e f8 f0 70 b8 f1 01 07 b8 46 de d2 9e f8 .....p.....F....
         f0 00 f4 46 3c 28 c9 d3 00 27 83 46 38 46 00 97 ...F<(...'.F8F..
         cb e0 dc f8 00 01 10 f8 01 7b cc f8 00 01 dc f8 .........{......
         10 e1 a0 42 0e f1 01 0e cc f8 10 e1 01 d9 cc f8 ...B............
         00 11 b6 45 01 d9 cc f8 10 51 dc f8 00 e1 1e f8 ...E.....Q......
         01 0b cc f8 00 e1 47 ea 00 2a dc f8 10 01 40 1c ......G..*....@.
         cc f8 10 01 a6 45 01 d9 cc f8 00 11 .....E......
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.960601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.960685
         b8 26 0b 00 b0 42 01 d9 cc f8 10 51 dc f8 00 01 .&...B.....Q....
         10 f8 01 9b cc f8 00 01 dc f8 10 71 7f 1c cc f8 ...........q....
         10 71 a0 42 01 d9 cc f8 00 11 b7 42 01 d9 cc f8 .q.B.......B....
         10 51 dc f8 00 e1 1e f8 01 0b cc f8 00 e1 49 ea .Q............I.
         00 29 dc f8 10 01 40 1c cc f8 10 01 a6 45 01 d9 .)....@......E..
         cc f8 00 11 b0 42 01 d9 cc f8 10 51 dc f8 00 01 .....B.....Q....
         40 1c cc f8 00 01 dc f8 10 71 7f 1c cc f8 10 71 @........q.....q
         a0 42 01 d9 cc f8 00 11 b7 42 01 d9 cc f8 10 51 .B.......B.....Q
         dc f8 00 01 40 1e cc f8 00 01 dc f8 10 71 7f 1e ....@........q..
         cc f8 10 71 88 42 01 d2 cc f8 00 41 af 42 01 d2 ...q.B.....A.B..
         cc f8 10 61 dc f8 00 71 7f 1e cc f8 00 71 dc f8 ...a...q.....q..
         10 01 40 1e cc f8 10 01 8f 42 01 d2 cc f8 00 41 ..@......B.....A
         a8 42 01 d2 cc f8 10 61 dc f8 00 71 .B.....a...q
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.961601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.961685
         80 27 0b 00 7f 1e cc f8 00 71 dc f8 10 01 40 1e .'.......q....@.
         cc f8 10 01 8f 42 01 d2 cc f8 00 41 a8 42 01 d2 .....B.....A.B..
         cc f8 10 61 dc f8 00 71 7f 1e cc f8 00 71 dc f8 ...a...q.....q..
         10 01 40 1e cc f8 10 01 8f 42 01 d2 cc f8 00 41 ..@......B.....A
         a8 42 01 d2 cc f8 10 61 01 27 8a ea 07 00 89 f0 .B.....a.'......
         ad 07 38 43 10 f0 ff 0f 9c f8 f0 00 a0 f1 01 00 ..8C............
         8c f8 f0 00 0f d1 9c f8 f0 00 40 1c 8c f8 f0 00 ..........@.....
         dc f8 00 01 40 1e cc f8 00 01 dc f8 10 01 40 1e ....@.........@.
         cc f8 10 01 07 e0 08 f1 01 00 80 46 58 45 ff f4 ...........FXE..
         30 af 00 98 18 b1 9c f8 f0 00 3c 28 14 d2 00 20 0.........<(...
         01 46 40 1c 03 f8 01 1b 3c 28 fa d3 02 20 10 70 .F@.....<(... .p
         00 20 bd e8 fc 8f 00 00 ac 98 20 00 04 99 20 00  . ........ ... .
         c8 05 20 00 7c 5f 0b 00 40 1e 01 90              .. .|_..@...
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.962601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.962685
         48 28 0b 00 dc f8 00 01 dc f8 10 71 40 1c 7f 1c H(.........q@...
         81 42 00 d9 20 46 bd 42 00 d9 37 46 00 21 4f f0  .B.. F.B..7F.!O.
         01 0e 11 70 91 e0 10 f8 01 6b 97 f8 00 a0 7d 1c ...p.....k....}.
         ff 4c d4 f8 fc 10 81 42 01 d2 d4 f8 f8 00 a4 46 .L.....B.......F
         d4 f8 0c 41 ac 42 01 d2 dc f8 08 51 10 f8 01 7b ...A.B.....Q...{
         81 42 46 ea 07 29 15 f8 01 6b 56 44 b7 b2 01 d2 .BF..)...kVD....
         dc f8 f8 00 e2 46 ac 42 01 d2 da f8 08 51 10 f8 .....F.B.....Q..
         01 6b 15 f8 01 cb 81 42 67 44 bf b2 d4 46 01 d2 .k.....BgD...F..
         dc f8 f8 00 e3 46 ac 42 01 d2 db f8 08 51 10 f8 .....F.B.....Q..
         01 cb 81 42 46 ea 0c 2a 15 f8 01 6b 3e 44 b6 b2 ...BF..*...k>D..
         5f 46 01 d2 d7 f8 f8 00 bc 46 ac 42 01 d2 dc f8 _F.......F.B....
         08 51 40 1c 15 f8 01 7b 81 42 3e 44 b6 b2 67 46 .Q@....{.B>D..gF
         01 d2 d7 f8 f8 00 bc 46 ac 42 01 d2 .......F.B..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.963602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.963685
         10 29 0b 00 dc f8 08 51 40 1e 15 f8 01 79 3e 44 .).....Q@....y>D
         1f fa 86 fb 2e 46 65 46 dc f8 f8 c0 84 45 00 d9 .....FeF.....E..
         08 46 d5 f8 08 51 b5 42 00 d9 26 46 40 1e 76 1e .F...Q.B..&F@.v.
         84 45 00 d9 08 46 b5 42 00 d9 26 46 40 1e 76 1e .E...F.B..&F@.v.
         84 45 00 d9 08 46 b5 42 00 d9 26 46 40 1e 77 1e .E...F.B..&F@.w.
         84 45 00 d9 08 46 bd 42 00 d9 27 46 01 24 89 ea .E...F.B..'F.$..
         04 01 8a f0 ad 04 21 43 0e f1 01 0e c9 b2 1f fa ......!C........
         8e fe bb f1 00 0f 01 d0 02 24 14 70 31 b1 08 f1 .........$.p1...
         01 01 01 9c 88 46 a1 42 ff f4 69 af b6 48 be f1 .....F.B..i..H..
         3c 0f 90 f8 f0 10 23 d3 3c 39 80 f8 f0 10 00 21 <.....#.<9.....!
         fc 30 42 68 12 78 03 f8 01 2b 42 68 52 1c 42 60 .0Bh.x...+BhR.B`
         44 69 64 1c 44 61 50 f8 fc 59 aa 42 03 d9 d0 f8 Did.DaP..Y.B....
         f8 20 c0 f8 00 21 d0 f8 0c 21 94 42              . ...!...!.B
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.964601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.964684
         d8 29 0b 00 03 d9 d0 f8 08 21 c0 f8 10 21 49 1c .).......!...!I.
         3c 29 e1 d3 3c 20 20 e7 a1 eb 0e 01 80 f8 f0 10 <)..<  .........
         00 21 1b e0 fc 30 44 68 24 78 03 f8 01 4b 45 68 .!...0Dh$x...KEh
         6d 1c 45 60 44 69 64 1c 44 61 50 f8 fc 69 b5 42 m.E`Did.DaP..i.B
         03 d9 d0 f8 f8 50 c0 f8 00 51 d0 f8 0c 51 ac 42 .....P...Q...Q.B
         03 d9 d0 f8 08 41 c0 f8 10 41 49 1c 71 45 e1 d3 .....A...AI.qE..
         00 20 01 46 ce f1 3c 04 02 e0 03 f8 01 1b 40 1c  . .F..<.......@.
         84 42 fa d8 02 20 10 70 cc e7 2d e9 fc 5f 89 4d  .B... .p..-.._.M
         89 49 44 69 49 88 6a 68 28 68 01 90 b4 f8 4e 00 .IDiI.jh(h....N.
         8f 1a b8 42 00 d2 07 46 df f8 10 b2 4f f0 00 0a ...B...F....O...
         00 2f 7e d0 4d f7 0e fd 06 46 4d f7 0e fd e0 6b ./~.M....FM....k
         38 44 e0 63 b4 f8 4e 00 c0 1b a4 f8 4e 00 30 46 8D.c..N.....N.0F
         4d f7 06 fd 39 46 20 46 77 f7 9b ff              M...9F Fw...
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.965601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.965685
         a0 2a 0b 00 40 ea 07 09 4d f7 f8 fc 80 46 4d f7 .*..@...M....FM.
         f8 fc 20 6a 18 b9 a0 68 c4 f8 28 a0 20 62 40 46  .. j...h..(. b@F
         26 6a 4d f7 f1 fc b4 f8 4c 20 a0 6a 39 46 12 1a &jM.....L .j9F..
         ba 42 00 d8 11 46 88 46 06 f1 1c 01 01 44 e0 69 .B...F.F.....D.i
         42 46 03 68 01 98 98 47 a7 eb 08 07 01 90 4d f7 BF.h...G......M.
         d5 fc 00 90 4d f7 d5 fc a0 6a 40 44 a0 62 b4 f8 ....M....j@D.b..
         4c 10 88 42 11 d1 d6 e9 00 10 48 60 01 60 61 69 L..B......H`.`ai
         04 f1 10 00 66 61 c6 e9 00 01 0e 60 c4 f8 28 a0 ....fa.....`..(.
         a6 68 08 38 86 42 3c d0 26 62 00 98 4d f7 bc fc .h.8.B<.&b..M...
         00 2f c8 d1 a0 69 b4 f8 4e 20 81 68 a1 b1 c1 8b  ./...i..N .h....
         cb 06 11 d5 c1 f3 01 03 01 2b 02 d1 83 8b 93 42 .........+.....B
         04 d9 8b 07 08 d1 83 8b 93 42 05 d3 21 f0 10 01 .........B..!...
         c1 83 82 68 81 69 90 47 e0 69 c1 8b ...h.i.G.i..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.966586
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.966633
         68 2b 0b 00 41 f0 10 01 c1 83 5f ea 09 50 23 d0 h+..A....._..P#.
         00 e0 29 e0 42 49 c9 f3 01 30 a0 b1 01 28 13 d0 ..).BI...0...(..
         02 22 02 28 01 d0 03 28 01 d1 28 7e 0a 54 bb f8 .".(...(..(~.T..
         00 00 3c 49 58 b1 50 46 0c e0 c4 f8 20 a0 00 98 ..<IX.PF.... ...
         4d f7 7e fc c2 e7 50 46 2a 7e 88 54 ef e7 49 f3 M.~...PF*~.T..I.
         80 30 40 1c 2a 7e 88 54 69 68 c9 f3 0b 00 01 44 .0@.*~.Tih.....D
         69 60 29 68 08 44 28 60 2b 49 68 68 4a 88 90 42 i`)h.D(`+IhhJ..B
         15 d3 bb f8 00 30 2c 4a 13 b1 1e 28 0f d3 01 e0 .....0,J...(....
         3c 28 0c d3 08 89 81 18 27 4a 28 68 93 f7 b7 fb <(......'J(h....
         c5 e9 00 0a bd e8 fc 5f 20 20 93 f7 bd b8 bd e8  ......._ ......
         fc 9f 0f b4 2d e9 fc 5f 21 48 20 4e 00 78 19 4c  ....-.._!H N.x.L
         15 46 00 28 7e d0 1f 48 00 78 00 28 7a d0 1e 49 .F.(~..H.x.(z..I
         00 20 08 60 1d 49 4f f4 34 77 08 70              . .`.IO.4w.p
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.967586
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.967635
         30 2c 0b 00 39 46 1c 48 b1 f7 2a fd b4 21 1b 48 0,..9F.H..*..!.H
         b1 f7 26 fd b4 21 12 48 b1 f7 22 fd 39 46 18 48 ..&..!.H..".9F.H
         b1 f7 1e fd 08 48 ff f7 78 fc dd e9 0c 02 02 23 .....H..x......#
         14 4f 15 49 1f fa 85 fb 1f fa 80 fa 01 2a 7d d1 .O.I.........*}.
         3b 60 0c 98 22 e0 00 00 7c 5f 0b 00 74 91 20 00 ;`.."...|_..t. .
         9c 98 20 00 5a 1b 20 00 60 1b 20 00 64 1b 20 00  .. .Z. .`. .d. .
         18 95 20 00 5c 91 20 00 54 1b 20 00 68 1b 20 00  .. .\. .T. .h. .
         6c 1b 20 00 55 1b 20 00 94 91 20 00 64 94 20 00  l. .U. ... .d. .
         cc 95 20 00 44 0c 20 00 e2 1a 20 00 00 eb 80 00  .. .D. ... .....
         ff 4a 02 eb c0 05 ff 4a 02 eb c0 08 fe 4a 02 eb .J.....J.....J..
         c0 07 fe 4a 02 eb c0 09 01 20 08 80 fc 48 28 21  ...J..... ...H(!
         05 60 f7 48 b1 f7 d4 fc e8 8b 28 21 20 f0 03 00 .`.H......(! ...
         40 1c 80 b2 6a f3 83 00 80 b2 20 f0              @...j..... .
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.968591
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.968615
         f8 2c 0b 00 20 00 e8 83 f0 48 b1 f7 c5 fc b8 f8  .,.. ....H......
         1e 00 20 f0 03 00 80 b2 6a f3 83 00 80 b2 6b f3  .. .....j.....k.
         45 10 00 e0 bd e0 a8 f8 1e 00 ec 48 c8 f8 00 00 E..........H....
         00 20 c8 f8 04 00 28 21 e5 48 b1 f7 ad fc f8 8b  . ....(!.H......
         df f8 9c 83 20 f0 03 00 40 1c 80 b2 6a f3 83 00  .... ...@...j...
         80 b2 6b f3 45 10 f8 83 af f2 01 30 c7 e9 00 80 ..k.E......0....
         28 21 dc 48 b1 f7 98 fc b9 f8 1e 00 20 f0 03 01 (!.H........ ...
         89 b2 00 e0 10 e0 6a f3 83 01 89 b2 6b f3 45 11 ......j.....k.E.
         a9 f8 1e 10 d7 48 d5 49 c5 e9 00 80 c9 f8 00 10 .....H.I........
         00 21 c9 f8 04 10 23 e0 12 bb 3b 60 00 20 08 80 .!....#...;`. ..
         d1 4d d2 4f 28 21 28 46 b1 f7 76 fc e8 8b 28 21 .M.O(!(F..v...(!
         20 f0 03 00 80 b2 6a f3 83 00 80 b2 6b f3 45 10 .....j.....k.E.
         e8 83 38 46 b1 f7 68 fc f8 8b 20 f0              ..8F..h... .
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.969602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.969684
         c0 2d 0b 00 03 00 40 1c 80 b2 6a f3 83 00 f8 83 .-....@...j.....
         f9 8b 6b f3 45 11 f9 83 c4 49 01 27 c2 48 0f 80 ..k.E....I.'.H..
         00 25 05 60 c2 49 41 20 08 80 0f 98 01 0c c1 48  .%.`.IA .......H
         1e 29 05 d1 0f 99 89 b2 1e 29 01 d1 07 80 00 e0 .).......)......
         05 80 bd 49 78 22 0a 80 f0 22 8a 80 b4 22 0a 81 ...Ix"..."..."..
         92 00 4a 81 00 88 28 b1 01 28 07 d1 1e 20 48 80 ..J...(..(... H.
         22 20 02 e0 3c 20 48 80 40 20 c8 80 b3 48 c6 e9  " ..< H.@ ...H..
         00 05 b0 60 b2 48 f0 60 30 61 35 75 b5 75 75 75 ...`.H.`0a5u.uuu
         ff 22 b4 21 b1 f7 8b fb 1a 23 08 22 cd e9 00 23 .".!.....#."...#
         00 23 1a 46 0f 21 18 46 a1 f7 3c fa a1 f7 de fa .#.F.!.F..<.....
         a8 48 20 60 c4 e9 01 50 25 77 25 76 65 76 a6 48  .H `...P%w%vev.H
         e0 60 c4 e9 04 05 a5 48 0c 9a 41 78 97 40 39 43 .`.....H..Ax.@9C
         41 70 0d 98 01 21 08 b9 04 20 00 e0              Ap...!... ..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.970601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.970684
         88 2e 0b 00 07 20 bd e8 fc 1f 5d f8 14 eb 6d f7  ..... ....]...m.
         51 bb bd e8 fc 1f 5d f8 14 fb 2d e9 f0 4f 91 b0 Q.....]...-..O..
         88 48 99 4c 10 90 03 20 a0 76 98 48 4f f0 00 08  .H.L... .v.HO...
         00 78 00 28 70 d0 93 48 00 78 00 28 6c d0 3c 21 .x.(p..H.x.(l.<!
         01 a8 b1 f7 e1 fb 89 48 91 4f 00 88 88 4e 00 28 .......H.O...N.(
         20 7e df f8 40 92 00 eb 07 02 df f8 3c b2 a0 68 ~..@.......<..h
         0d f1 04 0a 3d 46 01 ab 0f d1 3c 21 ff f7 4b fb ....=F....<!..K.
         10 b9 6f f0 02 05 2e e0 20 7e 29 5c 19 f8 00 00  ..o..... ~)\....
         41 ea c0 01 ab f8 a8 10 1e e0 1e 21 ff f7 3b fb A..........!..;.
         82 49 78 b9 91 f8 18 01 40 1c c0 b2 81 f8 18 01 .Ix.....@.......
         02 28 04 d3 6f f0 02 05 81 f8 18 81 13 e0 6f f0 .(..o.........o.
         08 05 10 e0 81 f8 18 81 20 7e 29 5c 19 f8 00 00  ........ ~)\....
         41 ea c0 00 ab f8 a8 00 39 22 75 49 A.......9"uI
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.971613
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.971686
         50 2f 0b 00 0a f1 02 00 a1 f7 5a fa 05 46 73 48 P/........Z..FsH
         00 68 28 b1 72 48 00 68 10 b1 28 46 93 f7 f4 f8 .h(.rH.h..(F....
         20 7e 40 1c c0 b2 20 76 02 28 01 d9 84 f8 18 80   ~@... v.(......
         20 7e df f8 80 a1 07 f8 00 80 09 f8 00 80 69 4f ~............iO
         df f8 74 91 00 2d 11 dd 38 88 68 b9 62 49 08 e0 ..t..-..8.h.bI..
         d8 e0 e3 68 31 f8 10 20 1a 80 e2 68 92 1c 40 1c  ...h1.. ...h..@.
         e2 60 a8 42 f5 d3 6c e0 01 21 38 e0 15 f1 08 00 .`.B..l..!8.....
         07 d1 71 88 a0 68 08 44 a0 60 32 89 02 eb 0a 01 ..q..h.D.`2.....
         b5 e0 15 f1 09 00 0b d1 4d f7 60 fa 05 46 4d f7 ........M.`..FM.
         60 fa a0 68 1e 30 a0 60 28 46 4d f7 5d fa 66 e0 `..h.0.`(FM.].f.
         e8 1d 07 28 4d d8 15 f1 07 0f 08 d0 15 f1 06 0f ...(M...........
         19 d0 15 f1 02 0f 02 d0 b5 f1 ff 3f 29 d1 38 88 ...........?).8.
         60 b9 06 e0 e1 68 c1 f8 00 80 e1 68 `....h.....h
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.972601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.972684
         18 30 0b 00 09 1d 40 1c e1 60 31 88 b0 eb 51 0f .0....@..`1...Q.
         f4 d3 32 e0 00 21 10 98 94 f7 e5 f8 2d e0 0b f1 ..2..!......-...
         9e 00 01 88 21 f0 07 01 01 80 38 88 00 28 f1 d1 ....!.....8..(..
         06 e0 e1 68 c1 f8 00 80 e1 68 09 1d 40 1c e1 60 ...h.....h..@..`
         31 88 b0 eb 51 0f f4 d3 17 e0 38 88 00 28 e1 d1 1...Q.....8..(..
         e0 68 49 46 48 45 01 d1 70 89 08 44 b1 88 40 1a .hIFHE..p..D..@.
         00 21 06 e0 04 c8 e3 68 1a 60 e2 68 12 1d 49 1c .!.....h.`.h..I.
         e2 60 32 88 b1 eb 52 0f f4 d3 38 88 58 b9 4d f7 .`2...R...8.X.M.
         01 fa 05 46 4d f7 01 fa 31 88 60 69 08 44 60 61 ...FM...1.`i.D`a
         28 46 4d f7 fd f9 11 48 00 88 00 28 90 d1 71 88 (FM....H...(..q.
         a0 68 08 44 a0 60 3b e0 0c 91 20 00 34 91 20 00  .h.D.`;... .4. .
         bc 90 20 00 e4 90 20 00 ec 1a 20 00 87 af 02 00  .. ... ... .....
         9b af 02 00 29 63 04 00 6c 90 20 00              ....)c..l. .
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.973602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.973685
         e0 30 0b 00 94 90 20 00 70 1b 20 00 5c 1b 20 00  .0.... .p. .\. .
         56 1b 20 00 5a 1b 20 00 9c 98 20 00 94 91 20 00  V. .Z. ... ... .
         64 94 20 00 18 95 20 00 cc 95 20 00 68 1b 20 00  d. ... ... .h. .
         74 91 20 00 54 1b 20 00 60 1b 20 00 64 1b 20 00  t. .T. .`. .d. .
         d4 dc 20 00 7c 5f 0b 00 ac e4 20 00 74 1b 20 00  .. .|_.... .t. .
         88 1b 20 00 e2 1a 20 00 31 89 a0 68 51 44 07 4a  .. ... .1..hQD.J
         93 f7 11 f9 a0 60 71 89 05 4a 49 44 e0 68 93 f7 .....`q..JID.h..
         0a f9 e0 60 11 b0 bd e8 f0 8f 00 00 18 95 20 00 ...`.......... .
         cc 95 20 00 10 b5 04 00 27 d0 20 68 28 b3 20 7c  .. .....'. h(. |
         16 28 22 d0 d9 49 09 68 49 02 03 d5 19 28 01 d0 .("..I.hI....(..
         17 28 08 d1 00 20 83 f7 ef f8 50 f7 0d fd 20 46  .(... ....P... F
         51 f7 53 fc 11 e0 d2 49 09 68 11 f4 00 3f 0c d0 Q.S....I.h...?..
         11 28 0a d0 08 28 08 d0 0a 28 06 d0 .(...(...(..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.974601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.974675
         a8 31 0b 00 0c 28 04 d0 00 20 83 f7 d9 f8 50 f7  .1...(... ....P.
         fe ff 01 20 10 bd 10 b5 c8 48 4f f0 ff 31 01 60  ... .....HO..1.`
         81 61 80 69 c6 49 08 60 c6 49 0a 68 42 40 12 f4 .a.i.I.`.I.hB@..
         7e 4f 04 d0 08 60 4f f4 80 40 4e f7 b7 f8 c2 48 ~O...`O..@N....H
         01 68 bd e8 10 40 c1 48 73 f7 66 b8 10 b5 c0 49 .h...@.Hs.f....I
         64 20 08 70 ba 49 00 20 08 60 be 49 08 60 b9 49  d .p.I. .`.I.`.I
         08 60 bd 49 09 68 00 29 20 da bc 4a 01 21 11 70  .`.I.h.) ..J.!.p
         bb 49 08 70 b1 49 09 1d 08 60 48 60 c8 60 88 61 .I.p.I...`H`.`.a
         c8 61 48 62 b1 48 00 68 10 b1 b0 48 73 f7 27 f8 .aHb.H.h...Hs.'.
         00 23 1a 46 af f2 81 01 ac 48 73 f7 0d f8 aa 48 .#.F.....Hs....H
         01 68 bd e8 10 40 a9 48 73 f7 36 b8 10 bd 2d e9 .h...@.Hs.6...-.
         f8 4f 05 46 00 20 8a 46 00 90 a0 49 83 46 06 46  .O.F. .F...I.F.F
         07 46 4f f4 00 70 10 39 d5 f8 28 80 .FO..p.9..(.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.975602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.975676
         70 32 0b 00 4f f0 40 09 08 60 00 20 4f f4 c8 01  p2..O.@..`. O...
         81 f8 b0 00 a1 48 30 f8 1a 40 b4 f5 88 7f 13 d1 .....H0..@......
         95 f8 78 00 9e 49 40 5c 9e 49 c0 eb c0 00 01 eb ..x..I@\.I......
         40 00 81 88 51 b1 80 7a 01 28 02 d1 4f f4 98 74 @...Q..z.(..O..t
         04 e0 4f f4 90 74 01 e0 00 2c 75 d0 28 46 83 f7 ..O..t...,u.(F..
         c9 f9 00 b1 40 24 94 48 00 68 38 b1 60 2c 01 d1 ....@$.H.h8.`,..
         e0 24 77 e0 70 2c 08 d1 d0 24 73 e0 ba f1 04 0f .$w.p,...$s.....
         02 d0 ba f1 02 0f 00 d1 01 26 30 2c 18 d1 7d 48 .........&0,..}H
         4f f0 ff 31 01 60 81 61 80 69 10 f4 70 4f 06 d0 O..1.`.a.i..pO..
         00 21 85 f8 63 10 95 f8 5c 10 85 f8 5d 10 95 f8 .!..c...\...]...
         68 00 01 21 08 b9 00 29 54 d1 4f f4 c8 74 51 e0 h..!...)T.O..tQ.
         50 2c 1c d1 b8 f1 00 0f 4c d0 98 f8 6d 00 c0 07 P,......L...m...
         48 d0 98 f8 68 00 02 28 44 d1 98 f8 H...h..(D...
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.976601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.976684
         38 33 0b 00 64 00 c0 f3 c3 00 03 28 3e d3 b8 f8 83..d......(>...
         66 00 c0 f3 01 00 03 28 02 d1 46 f0 01 06 35 e0 f......(..F...5.
         46 f0 02 06 32 e0 b4 f5 a0 7f 0d d1 95 f8 2b 00 F...2.........+.
         60 b3 01 28 01 d1 01 27 28 e0 02 28 01 d1 02 27 `..(...'(..(...'
         24 e0 03 28 22 d1 11 e0 b4 f5 b8 7f 11 d1 95 f8 $..("...........
         81 00 10 b1 02 28 00 d1 01 27 95 f8 9a 00 01 28 .....(...'.....(
         00 d1 02 27 95 f8 99 00 01 28 0f d1 03 27 0d e0 ...'.....(...'..
         43 e0 b4 f5 a8 7f 09 d1 95 f8 2d 00 01 28 00 d1 C.........-..(..
         01 27 28 8d 20 f0 01 00 38 43 c7 b2 04 f0 f0 00  .'(. ...8C......
         00 90 49 48 c4 f3 00 23 00 1d 00 eb 14 10 00 78 ..IH...#.......x
         30 2c 0b d1 95 f8 68 20 01 21 3a b9 31 b1 05 f1  0,....h .!:.1...
         2e 00 01 78 80 79 08 44 c0 f3 46 00 43 ea 00 10 ...x.y.D..F.C...
         00 f0 ff 0b e8 7b 08 b1 4f f0 c0 09 .....{..O...
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.977602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.977687
         00 34 0b 00 e8 7c 03 28 07 d1 68 8c c0 f3 47 00 .4...|.(..h...G.
         3f 28 00 d9 3f 20 49 ea 00 09 40 2c 22 d1 3f 4c  ?(..? I...@,".?L
         20 78 38 b1 28 46 64 f7 a9 f8 00 f0 0f 00 46 ea x8.(Fd.......F.
         00 16 17 e0 46 f0 08 06 a8 7b 6a f7 e0 fa 38 49 ....F....{j...8I
         40 08 08 60 37 49 09 68 6a f7 6e fa 36 49 08 60 @..`7I.hj.n.6I.`
         36 49 09 68 88 42 03 d2 28 46 64 f7 6e f8 08 b1 6I.h.B..(Fd.n...
         01 20 20 70 32 48 00 99 01 70 80 f8 04 b0 06 72  . p2H...p.....r
         07 73 80 f8 14 90 bd e8 f8 8f 30 b4 20 48 01 23 .s........0. H.#
         00 68 20 49 00 22 00 28 01 da 0b 70 00 e0 0a 70  .h I.".(...p...p
         28 48 00 68 00 28 15 d0 20 4c 23 70 21 4b 1a 60  (H.h.(.. L#p!K.`
         1f 4b 1a 60 20 4b 1a 60 af f2 55 22 82 60 af f2  .K.` K.`..U".`..
         bb 22 02 60 09 78 01 29 01 d1 30 bc 9a e6 40 68 .".`.x.)..0...@h
         30 bc 00 47 30 bc 70 47 af f2 51 01 0..G0.pG..Q.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.978601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.978685
         c8 34 0b 00 1a 48 81 65 af f2 6f 31 c0 f8 ec 10 .4...H.e..o1....
         70 47 00 00 b4 80 31 00 fc 0d 20 00 40 41 31 00  pG....1... .@A1.
         c8 07 20 00 c4 0e 20 00 a0 5d 0b 00 98 60 0b 00  .. ... ..]...`..
         cc 07 20 00 c0 0e 20 00 bc 07 20 00 a8 07 20 00  .. ... ... ... .
         cd 07 20 00 c8 0e 20 00 6c 0e 20 00 5c 75 20 00  .. ... .l. .\u .
         48 0d 20 00 a9 07 20 00 b0 07 20 00 ac 07 20 00  H. ... ... ... .
         b4 07 20 00 d0 07 20 00 9c 00 64 00 5c 0f 20 00  .. ... ...d.\. .
         f8 4c 20 00 70 b5 36 4d 4f f4 c8 04 28 68 c1 07  .L .p.6MO...(h..
         03 d0 e1 69 21 f0 04 01 e1 61 81 07 03 d5 21 68 ...i!....a....!h
         21 f0 01 01 21 60 41 07 03 d5 21 68 41 f0 02 01 !...!`A...!hA...
         21 60 c1 06 03 d5 61 6d 21 f0 01 01 61 65 81 06 !`....am!...ae..
         03 d5 21 68 21 f0 10 01 21 60 41 06 03 d5 e1 69 ..!h!...!`A....i
         21 f0 01 01 e1 61 c1 05 05 d5 d4 f8 !....a......
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.979602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.979685
         90 35 0b 00 1c 11 21 f0 40 01 c4 f8 1c 11 c0 04 .5....!.@.......
         03 d5 a0 6d 40 f0 0e 00 a0 65 6a f7 77 fe 28 68 ...m@....ej.w.(h
         c1 04 03 d5 a1 6d 21 f0 0e 01 a1 65 c1 05 05 d5 .....m!....e....
         d4 f8 1c 11 41 f0 40 01 c4 f8 1c 11 c1 06 03 d5 ....A.@.........
         61 6d 41 f0 01 01 61 65 81 06 03 d5 21 68 41 f0 amA...ae....!hA.
         10 01 21 60 41 06 03 d5 e1 69 41 f0 01 01 e1 61 ..!`A....iA....a
         41 07 03 d5 21 68 21 f0 02 01 21 60 81 07 03 d5 A...!h!...!`....
         21 68 41 f0 01 01 21 60 c0 07 03 d0 e0 69 40 f0 !hA...!`.....i@.
         04 00 e0 61 70 bd 00 00 c0 5d 0b 00 70 b5 04 46 ...ap....]..p..F
         7d f7 60 fb a0 6a 90 f8 64 00 10 f0 78 0f 0c d0 }.`..j..d...x...
         06 48 01 78 02 79 05 7a 03 7b 04 7d 45 f0 02 05 .H.x.y.z.{.}E...
         01 70 02 71 05 72 03 73 04 75 70 bd 9c 00 64 00 .p.q.r.s.up...d.
         0d 48 00 78 c0 f3 02 11 00 20 03 29              .H.x..... .)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.980601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.980685
         58 36 0b 00 01 d0 0b 49 08 70 0b 49 08 70 4f f4 X6.....I.p.I.pO.
         48 10 02 69 02 f0 0f 02 01 2a 07 d1 0a 70 01 69 H..i.....*...p.i
         21 f0 10 01 01 61 00 20 6a f7 eb bd 70 47 00 00  !....a. j...pG..
         cc e6 20 00 34 e7 20 00 f0 5d 0b 00 70 47 00 00  .. .4. ..]..pG..
         10 b5 04 46 01 78 00 23 1a 46 4f f6 2e 40 66 f7 ...F.x.#.FO..@f.
         44 fa 04 20 84 f8 28 00 00 20 4f f4 80 41 40 1c  D.. ..(.. O..A@.
         88 42 fc d3 00 20 90 f7 ac f9 4c f7 eb fe 04 46  .B... ....L....F
         4c f7 eb fe 08 49 00 20 08 60 6b f7 81 ff 07 49  L....I. .`k....I
         01 20 08 60 74 f7 c8 fc 4e f7 47 fa 20 46 bd e8  . .`t...N.G. F..
         10 40 4c f7 dd be 00 00 70 04 20 00 04 02 31 00  .@L.....p. ...1.
         4f f4 e0 01 4a 69 22 f0 01 02 42 f4 00 62 02 43 O...Ji"...B..b.C
         22 f0 1e 00 40 f0 14 00 48 61 d1 f8 f4 00 20 f0 "...@...Ha.... .
         0f 00 40 f0 06 00 c1 f8 f4 00 01 20 ..@........
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.981601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.981684
         20 37 0b 00 70 47 10 b5 4f f4 e0 03 5a 69 8e 4c 7..pG..O...Zi.L
         22 f4 80 62 22 f0 01 02 42 f4 00 62 02 43 00 29 "..b"...B..b.C.)
         22 f4 7f 00 02 d1 40 f4 20 20 01 e0 40 f4 a0 20  ".....@. ..@..
         20 f0 e0 00 40 f0 80 00 58 61 d3 f8 f4 00 00 ea ...@...Xa......
         04 00 02 d1 40 f4 04 40 01 e0 40 f4 80 60 c3 f8 ....@..@..@..`..
         f4 00 01 20 10 bd 70 b5 04 46 00 68 0d 46 40 01  ... ..p..F.h.F@.
         00 f5 83 50 08 44 00 f0 1f 01 40 09 41 ea 00 20 ...P.D....@.A..
         40 f0 10 40 6b f7 57 fe 01 21 08 b9 21 74 19 e0 @..@k.W..!..!t..
         4f f4 e0 01 88 69 82 00 4f f0 01 00 00 fa 05 f0 O....i..O.......
         02 d5 62 68 02 42 0b d1 8a 69 92 00 02 d4 62 68 ..bh.B...i....bh
         02 42 05 d0 89 69 89 00 04 d5 61 68 01 42 01 d1 .B...i....ah.B..
         01 20 70 bd 00 20 70 bd 2d e9 f0 5f 00 25 80 46  . p.. p.-.._.%.F
         85 60 6b f7 bd fd 01 27 40 b9 60 49 .`k....'@.`I
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.982586
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.982632
         e8 37 0b 00 4f f4 7a 50 6b f7 c7 fd 10 b9 88 f8 .7..O.zPk.......
         10 70 05 e0 6b f7 89 fe 28 b1 04 21 88 f8 10 10 .p..k...(..!....
         00 20 bd e8 f0 9f 6b f7 30 fe 6b f7 75 fe 00 28  . ....k.0.k.u..(
         ed d0 00 24 00 20 ff f7 6b ff 21 46 40 46 6b f7  ...$. ..k.!F@Fk.
         4f fe 01 20 ff f7 64 ff 21 46 40 46 6b f7 48 fe  O.. ..d.!F@Fk.H.
         64 1c 20 2c ee d3 ab 46 2e 46 4f f0 00 09 ba 46  d. ,...F.FO....F
         00 24 0a fa 04 f7 3d 42 09 d1 00 21 08 46 ff f7 .$....=B...!.F..
         66 ff 21 46 40 46 ff f7 8a ff 00 b1 3d 43 3e 42 f.!F@F......=C>B
         09 d1 00 21 01 20 ff f7 5a ff 21 46 40 46 ff f7  ...!. ..Z.!F@F..
         7e ff 00 b1 3e 43 64 1c 20 2c e2 d3 00 24 0a fa  ~...>Cd. ,...$..
         04 f7 3d 42 06 d1 00 20 ff f7 32 ff 21 46 40 46  ..=B... ..2.!F@F
         6b f7 16 fe 3e 42 06 d1 01 20 ff f7 29 ff 21 46 k...>B... ..).!F
         40 46 6b f7 0d fe 64 1c 20 2c e8 d3              @Fk...d. ,..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.983585
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.983630
         b0 38 0b 00 09 f1 01 09 b9 f1 10 0f c4 d3 5d 46 .8............]F
         d9 46 5e 46 5f 46 00 24 00 21 08 46 ff f7 2b ff .F^F_F.$.!.F..+.
         21 46 40 46 ff f7 4f ff 18 b1 0a fa 04 f1 49 ea !F@F..O.......I.
         01 09 00 21 01 20 ff f7 1e ff 21 46 40 46 ff f7  ...!. ....!F@F..
         42 ff 10 b1 0a fa 04 f0 05 43 01 21 00 20 ff f7 B........C.!. ..
         12 ff 21 46 40 46 ff f7 36 ff 10 b1 0a fa 04 f0 ..!F@F..6.......
         06 43 01 21 08 46 ff f7 06 ff 21 46 40 46 ff f7 .C.!.F....!F@F..
         2a ff 10 b1 0a fa 04 f0 07 43 64 1c 20 2c cb d3 *........Cd. ,..
         00 21 53 46 03 fa 01 f0 19 ea 00 0f 03 d0 05 42 .!SF...........B
         0a d1 07 42 08 d1 06 42 01 d0 05 42 04 d1 d8 f8 ...B...B...B....
         08 20 02 43 c8 f8 08 20 49 1c 20 29 ea d3 6b f7  . .C... I. )..k.
         a0 fd 01 20 51 e7 00 00 ff 00 fe ff 20 c5 01 00  ... Q....... ...
         2d e9 fc 5f 47 68 06 46 00 97 80 78 -.._Gh.F...x
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.984586
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.984616
         78 39 0b 00 f1 78 00 f0 0f 05 4f ea 90 19 78 18 x9...x....O...x.
         90 f8 07 a0 b2 48 88 46 00 68 00 79 50 b9 b1 48 .....H.F.h.yP..H
         00 68 00 06 06 d4 00 2f 11 d0 38 46 bd e8 fc 5f .h...../..8F..._
         69 f7 c0 be 06 2d 0a d8 ba f1 00 0f 09 d0 ba f1 i....-..........
         14 0f 06 d0 30 46 71 f7 9a fd 00 28 eb d0 bd e8 ....0Fq....(....
         fc 9f a5 4c a5 49 20 78 09 79 88 42 02 d3 20 46  ...L.I x.y.B.. F
         97 f7 02 fc a1 48 40 88 00 b3 df f8 80 b2 9b f8 .....H@.........
         00 10 59 b1 60 78 18 b1 9d 48 6a f7 c8 fc a8 b1 ..Y.`x...Hj.....
         00 20 60 70 a0 70 bb f8 02 00 01 e0 21 78 31 b9  . `p.p......!x1.
         00 eb 80 00 01 01 96 48 6a f7 a7 fc 06 e0 94 48 .......Hj......H
         6a f7 b5 fc 10 b1 90 48 97 f7 de fb 20 78 91 49 j......H.... x.I
         a3 46 d4 f8 03 20 00 eb c0 03 49 5d 03 eb 40 14  .F... ....I]..@.
         11 55 03 2d 01 d0 05 2d 3a d1 49 46 .U.-...-:.IF
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.985601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.985681
         40 3a 0b 00 db f8 03 20 60 1c 11 54 db f8 03 20  @:..... `..T...
         a8 f1 06 00 04 f1 08 01 50 54 db f8 03 10 04 f1 ........PT......
         09 00 08 44 d9 46 06 22 00 99 b0 f7 f1 fc 00 98 ...D.F."........
         06 22 80 1d 00 90 d9 f8 03 10 a0 1c 08 44 00 99 ."...........D..
         b0 f7 e6 fc 05 2d 09 d1 d9 f8 03 20 00 99 04 f1  .....-..... ....
         0f 00 10 44 89 1d a8 f1 0c 02 c7 e0 f1 78 70 68 ...D.........xph
         28 34 08 44 d9 f8 03 10 80 79 08 55 9b f8 00 10 (4.D.....y.U....
         49 1c 8b f8 00 10 bc e0 6a 48 09 f0 01 09 00 78 I.......jH.....x
         28 b9 01 2d 07 d1 6a 48 00 68 c0 05 05 d5 41 46 (..-..jH.h....AF
         38 46 71 f7 ee fc 04 2d 06 d0 f1 78 70 68 08 44 8Fq....-...xph.D
         5d 49 80 79 09 68 48 72 5b 48 00 68 c1 79 01 29 ]I.y.hHr[H.h.y.)
         13 d1 49 46 00 98 71 f7 42 fa 04 2d 02 d1 71 f7 ..IF..q.B..-..q.
         62 fa 07 e0 ff 28 03 d1 49 46 00 98 b....(..IF..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.986601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.986675
         08 3b 0b 00 71 f7 8c fa 71 f7 6d fa 00 28 ce d0 .;..q...q.m..(..
         55 e0 56 4a 11 78 a9 b3 55 49 01 91 04 2d 13 d1 U.VJ.x..UI...-..
         dd e9 00 10 06 22 b0 f7 49 fc 00 28 7d d1 50 49 ....."..I..(}.PI
         10 39 88 7d 00 f0 0f 02 4a 45 76 d1 02 06 74 d5 .9.}....JEv...t.
         20 f0 80 00 88 75 3a e0 90 f9 09 00 92 f9 01 10 ....u:.........
         88 42 6a db dd e9 00 10 06 22 b0 f7 2f fc 30 b9 .Bj......"../.0.
         43 48 10 38 80 7d 00 f0 0f 00 48 45 5d d0 dd e9 CH.8.}....HE]...
         00 10 06 22 b0 f7 68 fc 3d 48 49 f0 80 01 10 38 ..."..h.=HI....8
         81 75 1c e0 ff e7 38 48 00 68 c0 05 17 d5 39 48 .u....8H.h....9H
         01 2d 12 d1 c0 78 30 b1 07 eb 08 01 03 22 35 48 .-...x0......"5H
         b0 f7 0c fc a0 b3 33 49 01 20 c8 70 07 eb 08 01  ......3I. .p....
         03 22 30 48 b0 f7 48 fc 01 e0 00 21 c1 70 48 46 ."0H..H....!.pHF
         db f8 03 10 63 1c c8 54 db f8 03 10 ....c..T....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.987613
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.987747
         d0 3b 0b 00 a0 1c 08 44 d9 46 06 22 00 99 b0 f7 .;.....D.F."....
         37 fc 20 48 00 78 48 b1 d9 f8 03 00 07 eb 08 01  7. H.xH.........
         20 44 71 f7 9d fa c0 b2 ff 28 1a d1 00 99 a8 f1 Dq......(......
         06 00 89 1d c2 b2 01 2d 07 d1 d9 f8 03 20 00 21 .......-..... .!
         04 f1 08 00 11 54 41 e7 0b e0 d9 f8 03 30 04 f1 .....TA......0..
         08 00 1a 54 d9 f8 03 30 40 1c 18 44 b0 f7 10 fc ...T...0@..D....
         34 e7 0c 48 9b f8 00 10 00 79 81 42 02 d3 08 48 4..H.....y.B...H
         97 f7 ce fa ba f1 14 0f 7f f4 a9 ae 70 f7 83 ff ............p...
         bd e8 fc 5f 71 f7 16 bc b8 24 20 00 f4 be 20 00  ..._q....$ ... .
         48 a8 20 00 04 0b 20 00 b8 52 20 00 00 20 26 00  H. ... ..R .. &.
         fc 0a 20 00 38 25 20 00 b0 52 20 00 00 0b 20 00  .. .8% ..R ... .
         07 49 06 48 08 60 07 49 2c 30 08 60 06 49 2c 30 .I.H.`.I,0.`.I,0
         08 60 06 49 2c 30 08 60 70 47 00 00 .`.I,0.`pG..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.988601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.988676
         98 3c 0b 00 f4 5d 0b 00 04 25 20 00 f8 24 20 00 .<...]...% ..$ .
         d4 24 20 00 ec 24 20 00 70 b5 ff 49 09 68 c1 f3  .$ ..$ .p..I.h..
         c0 11 81 42 12 d1 4f f4 5c 15 d5 f8 88 48 96 f7 ...B..O.\....H..
         6d fc 42 79 d0 f8 02 10 62 f3 1f 61 8c 42 05 d1 m.By....b..a.B..
         d5 f8 84 18 00 88 09 0c 81 42 01 d0 00 20 70 bd .........B... p.
         01 20 70 bd 7c b5 04 46 98 f7 22 ff 94 f8 56 00  . p.|..F.."...V.
         a0 b3 94 f8 55 00 01 28 0f d1 94 f8 2e 00 01 28 ....U..(.......(
         10 d1 94 f8 57 00 68 b9 94 f8 30 00 ff f7 cc ff ....W.h...0.....
         18 b9 20 46 50 f7 2a f9 20 e0 94 f8 55 00 08 b1  .. FP.*. ...U...
         01 28 1b d1 68 46 a5 6e 98 f7 c5 fe 06 46 94 f8 .(..hF.n.....F..
         57 00 58 b9 06 22 69 46 05 f1 3c 00 b0 f7 35 fc W.X.."iF..<...5.
         85 f8 42 60 01 20 84 f8 6c 00 7c bd 94 f8 2e 00  ..B`. ..l.|.....
         01 28 03 d1 69 46 30 46 98 f7 98 fe .(..iF0F....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.989601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.989675
         60 3d 0b 00 d3 49 a0 7c 89 78 88 42 02 d1 20 46 `=...I.|.x.B.. F
         99 f7 8a fb 20 46 bd e8 7c 40 01 21 98 f7 d2 bc  .... F..|@.!....
         10 b5 04 46 50 f7 f6 f8 20 46 50 f7 e2 fc 00 20  ...FP... FP....
         48 34 60 80 61 7f 02 20 70 f7 69 ff 20 6a 00 21  H4`.a.. p.i. j.!
         90 f8 bc 00 bd e8 10 40 97 f7 51 be 10 b5 04 46 .......@..Q....F
         c9 b9 c1 49 91 f8 44 10 61 b1 c0 49 0a 69 a2 42 ...I..D.a..I.i.B
         08 d1 bf 4a 12 68 12 f0 10 0f 03 d0 01 20 81 f8 ...J.h....... ..
         46 00 10 bd c1 7b 80 7b 97 f7 39 fe 20 46 bd e8 F....{.{..9. F..
         10 40 98 f7 94 bd 02 29 f3 d1 3c 34 20 8a a1 7f .@.....)..<4 ...
         08 44 40 1c 24 f8 30 0c e0 89 21 8a 40 1a e0 81 .D@.$.0...!.@...
         10 bd 70 b5 0d 00 04 46 19 d1 ab 49 91 f8 44 10 ..p....F...I..D.
         61 b1 aa 49 0a 69 a2 42 08 d1 a9 4a 12 68 12 f0 a..I.i.B...J.h..
         10 0f 03 d0 01 20 81 f8 46 00 70 bd              ..... ..F.p.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.990601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.990683
         28 3e 0b 00 c1 7b 80 7b 97 f7 0d fe 20 46 bd e8 (>...{.{.... F..
         70 40 99 f7 a2 bb 29 46 ff f7 b4 ff 02 2d f0 d1 p@....)F.....-..
         4f f4 46 10 e1 6d c0 f8 b0 1b 21 6e c0 f8 b4 1b O.F..m....!n....
         a1 6b 71 b9 a1 6e c9 6b c0 f8 74 1b a1 6e b1 f8 .kq..n.k..t..n..
         40 10 c0 f8 78 1b d0 f8 6c 1b 41 f0 08 01 c0 f8 @...x...l.A.....
         6c 1b a1 6e 89 6a c0 f8 b8 1b 70 bd 70 b5 04 46 l..n.j....p.p..F
         85 7c 8a 48 01 22 00 78 a0 74 00 21 20 46 52 f7 .|.H.".x.t.! FR.
         29 fc a5 74 21 6d b1 f8 b2 20 93 1e 83 42 00 dc  )..t!m... ...B..
         90 1e 40 f2 71 22 50 43 84 4a 12 88 b0 fb f2 f0 ..@.q"PC.J......
         94 f8 08 21 82 42 00 d8 10 46 91 f8 32 10 49 07 ...!.B...F..2.I.
         02 d5 01 28 00 d9 01 20 7d 49 48 74 70 bd 2d e9  ...(... }IHtp.-.
         f0 41 04 46 00 21 52 f7 48 fd 76 4f 05 1e 4f f0 .A.F.!R.H.vO..O.
         01 06 03 da 87 f8 45 60 bd e8 f0 81 ......E`....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.991593
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.991690
         f0 3e 0b 00 94 f8 81 00 68 b9 a0 7b 69 f7 7f fd .>......h..{i...
         21 6d 40 08 d1 f8 b8 10 69 f7 16 fd 00 28 04 dc !m@.....i....(..
         94 f8 81 00 30 b1 00 2d 04 dd 20 46 bd e8 f0 41  ....0..-.. F...A
         99 f7 67 bf e0 7b 01 28 04 d1 94 f8 81 00 08 b9 ..g..{.(........
         84 f8 81 60 94 f8 7a 00 64 49 40 f0 80 00 08 60 ...`..z.dI@....`
         08 21 05 20 4f f7 47 fe 97 f8 45 00 00 28 cf d1  .!. O.G...E..(..
         97 f7 87 fd 14 21 5c 48 b0 f7 9a fb 5a 4d 03 20 .....!\H....ZM.
         28 74 20 46 ff f7 8e ff 97 f7 86 fd 00 20 84 f8  (t F......... ..
         8a 00 84 f8 1f 01 20 46 99 f7 a4 fe 54 48 01 78  ...... F....TH.x
         01 b1 00 26 06 70 94 f8 0b 11 ff 29 09 d1 94 f8 ...&.p.....)....
         81 10 02 29 12 d1 01 78 84 f8 0b 11 a1 69 c4 f8 ...)...x.....i..
         0c 11 94 f8 0b 11 01 29 08 d8 00 78 84 f8 0b 01 .......)...x....
         48 4a 00 eb 40 00 69 7c 10 44 81 70 HJ..@.i|.D.p
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.992601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.992676
         b8 3f 0b 00 20 46 bd e8 f0 41 97 f7 75 bc 10 b5  .?.. F...A..u...
         3b 4a 04 46 71 b9 92 f8 44 10 39 b1 39 4a 11 69 ;J.Fq...D.9.9J.i
         81 42 03 d1 01 20 82 f8 46 00 10 bd 20 46 bd e8  .B... ..F... F..
         10 40 74 e7 01 29 f8 d0 02 29 19 d1 e0 7b 01 28 .@t..)...)...{.(
         04 d1 20 6b 10 b1 b4 f8 46 00 a0 81 92 f8 3d 00  .. k....F.....=.
         10 b1 4f f7 8d fd 02 e0 20 46 97 f7 95 ff 94 f8  ..O..... F......
         0b 01 01 28 e1 d8 20 46 bd e8 10 40 9a f7 41 bb  ...(.. F...@..A.
         05 29 da d1 94 f8 0b 01 01 28 d6 d8 20 46 bd e8 .).......(.. F..
         10 40 9a f7 f0 ba 1c b5 04 46 1d 48 90 f8 3d 00 .@.......F.H..=.
         c0 b1 e0 7b f0 b9 94 f8 81 00 d8 b9 a0 7b 69 46 ...{.........{iF
         69 f7 ad fc 00 98 c0 43 80 07 04 d1 1c 49 01 98 i......C.....I..
         09 78 88 42 02 d2 00 98 80 07 0b d1 01 20 84 f8 .x.B......... ..
         81 00 07 e0 8b f7 8b f9 c0 07 03 d0 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.993601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.993676
         80 40 0b 00 20 68 81 69 20 46 88 47 97 f7 e9 fc  .@.. h.i F.G....
         d4 f8 20 01 00 28 23 da e0 7b 01 28 20 d1 94 f8  .. ..(#..{.( ...
         09 01 00 28 1c d1 a0 7b 69 f7 a9 fc 40 08 15 e0 ...(...{i...@...
         98 8b 31 00 14 25 20 00 44 29 20 00 f8 28 20 00  ..1..% .D) ..( .
         38 41 31 00 a4 5e 0b 00 70 a8 20 00 a4 86 31 00  8A1..^..p. ...1.
         00 25 20 00 18 25 20 00 fe 24 20 00 c4 f8 20 01  .% ..% ..$ ... .
         1c bd 2d e9 fc 47 4f f4 46 11 d1 f8 ac 4b 05 46 ..-..GO.F....K.F
         4f f0 00 08 90 f8 2b 20 90 48 01 2a 01 d1 00 78  O.....+ .H.*...x
         00 e0 40 78 a8 74 c4 f3 41 00 03 28 46 d1 d1 f8 ..@x.t..A..(F...
         98 6b 89 46 06 f0 0f 07 20 07 07 d5 88 48 00 68  .k.F.... ....H.h
         80 7b 18 b1 30 46 99 f7 6d f8 80 46 05 2f 24 d1 .{..0F..m..F./$.
         95 f8 2b 00 01 28 00 d0 f8 b9 95 f8 2c 00 c6 f3 ..+..(......,...
         c0 11 88 42 0c d1 96 f7 2d fa 7e 49 ...B....-.~I
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.994601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.994684
         48 41 0b 00 0a 68 00 92 49 68 01 91 06 22 0d f1 HA...h..Ih..."..
         02 01 b0 f7 33 f9 08 b1 44 f0 08 04 20 07 02 d5 ....3...D... ...
         b8 f1 00 0f 05 d0 28 46 99 f7 a8 f8 00 21 c9 f8 ......(F.....!..
         14 10 73 48 00 68 00 06 0c d5 05 2f 01 d0 03 2f ..sH.h...../.../
         08 d1 b0 b2 02 b0 bd e8 f0 47 6c 49 00 22 09 1f .........GlI."..
         70 f7 6c be bd e8 fc 87 2d e9 fc 41 04 46 90 f8 p.l.....-..A.F..
         56 00 0f 46 00 25 28 b3 01 25 68 46 98 f7 83 fc V..F.%(..%hF....
         06 46 94 f8 57 00 90 b1 94 f8 55 00 01 28 05 d1 .F..W.....U..(..
         94 f8 30 00 ff f7 70 fd 00 28 14 d0 94 f8 2e 00 ..0...p..(......
         01 28 04 d1 69 46 30 46 98 f7 58 fc 05 46 59 48 .(..iF0F..X..FYH
         00 78 38 b1 01 2e 05 d1 01 98 c0 f3 81 30 01 28 .x8..........0.(
         00 d1 38 60 28 46 bd e8 fc 81 2d e9 fe 43 00 25 ..8`(F....-..C.%
         04 46 01 26 02 95 98 f7 93 fc 94 f8 .F.&........
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.995601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.995685
         10 42 0b 00 50 00 df f8 2c 91 01 28 a9 f1 04 09 .B..P...,..(....
         3b d0 df f8 2c 81 02 28 46 d0 03 28 61 d0 04 28 ;...,..(F..(a..(
         21 d1 94 f8 56 00 c0 b1 94 f8 55 00 04 28 14 d1 !...V.....U..(..
         b4 f8 48 00 08 22 c0 f3 80 17 49 46 68 46 b1 f7 ..H.."....IFhF..
         a3 ff d8 f8 04 00 b8 42 07 d1 06 22 69 46 08 f1 .......B..."iF..
         08 00 b0 f7 af f8 00 b9 01 25 20 46 98 f7 e6 fb  .........% F....
         20 46 98 f7 48 fa 02 98 05 43 06 d0 b4 f8 48 30 F..H....C....H0
         c2 b2 49 46 18 46 70 f7 f5 fd 00 2e 03 d0 01 21 ..IF.Fp........!
         20 46 98 f7 47 fa bd e8 fe 83 94 f8 55 00 28 b1 F..G.......U.(.
         06 28 03 d0 02 28 01 d0 01 28 e4 d1 02 a9 20 46 .(...(...(.... F
         ff f7 76 ff 05 46 de e7 94 f8 55 00 08 b1 06 28 ..v..F....U....(
         f0 d1 94 f8 56 00 00 28 f0 d0 94 f8 57 00 00 28 ....V..(....W..(
         ec d1 04 20 84 f8 50 00 1b 48 1e 49              ... ..P..H.I
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.996601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.996684
         d8 42 0b 00 90 f8 26 00 08 60 1b 48 00 26 08 30 .B....&..`.H.&.0
         98 f7 e9 fb c8 f8 04 00 dc e7 94 f8 55 00 08 b1 ............U...
         06 28 bc d1 b4 f8 46 00 40 1e a4 f8 46 00 b6 e7 .(....F.@...F...
         10 b5 04 46 11 48 9c 30 00 68 80 07 11 d5 e0 7b ...F.H.0.h.....{
         01 28 05 d1 94 f8 09 01 10 b9 20 46 52 f7 a9 fe  .(........ FR...
         94 f8 81 00 01 28 04 d1 20 46 bd e8 10 40 00 f0  .....(.. F...@..
         3f be 10 bd e8 24 20 00 b4 24 20 00 84 08 37 00  ?....$ ..$ ...7.
         f4 be 20 00 e0 a7 20 00 a4 5e 0b 00 10 8b 31 00  .. ... ..^....1.
         2d e9 fc 41 01 26 1a 4f 00 25 05 eb 45 00 07 eb -..A.&.O.%..E...
         80 14 20 8e c0 07 24 d0 94 f8 bd 00 08 bb e0 8d  .. ...$.........
         f8 b1 94 f8 32 00 08 b1 00 26 1a e0 05 22 04 f1 ....2....&..."..
         0c 01 10 48 b0 f7 1a f8 98 b1 02 20 84 f8 32 00  ...H....... ..2.
         20 46 71 f7 14 fd 69 46 20 46 71 f7               Fq...iF Fq.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.997601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.997684
         a0 43 0b 00 fe fc 14 f8 be 0f 69 46 9a f7 70 fa .C........iF..p.
         20 78 08 22 69 46 9a f7 12 ff 6d 1c 0f 2d d0 d3 x."iF....m..-..
         30 46 bd e8 fc 81 00 00 00 9b 20 00 70 a6 20 00  0F........ .p. .
         70 b5 14 46 00 22 83 5c 8d 5c 2b 40 83 54 52 1c p..F.".\.\+@.TR.
         0a 2a f8 d3 5c f7 76 ff a0 42 01 d2 20 1a 70 bd .*..\.v..B.. .p.
         00 20 70 bd 70 b5 14 46 00 22 83 5c 8d 5c ab 43  . p.p..F.".\.\.C
         83 54 52 1c 0a 2a f8 d3 5c f7 64 ff a0 42 01 d2 .TR..*..\.d..B..
         20 1a 70 bd 00 20 70 bd 2d e9 f3 4f 4f f0 00 09   .p.. p.-..OO...
         89 b0 c8 46 4e 46 ff 4c 4f 46 a4 f1 54 00 04 f1 ...FNF.LOF..T...
         50 05 03 90 4c f7 32 f8 04 90 4c f7 32 f8 a4 f1 P...L.2...L.2...
         a4 0b 9b f9 df 02 05 90 04 98 4c f7 2d f8 00 20 ..........L.-..
         8b f8 53 02 01 20 8b f8 f3 00 f3 4b 05 98 93 f9  ..S.. .....K....
         12 10 81 42 f1 48 05 da 81 79 8b f8 ...B.H...y..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.998601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.998685
         68 44 0b 00 d1 12 58 46 19 7d 04 e0 c1 79 8b f8 hD....XF.}...y..
         d1 12 59 7d 58 46 80 f8 d0 12 00 20 22 5c 29 5c  ..Y}XF..... "\)\
         90 44 0e 44 11 44 b9 42 00 d9 0f 46 40 1c 4f 28 .D.D.D.B...F@.O(
         f4 d3 e3 48 80 7a b8 42 02 d9 00 20 8b f8 f3 00  ...H.z.B... ....
         ff 22 0a 21 06 a8 b0 f7 56 f8 4f 21 06 a8 60 f7 .".!....V.O!..`.
         dd fd 00 21 8b f8 e3 11 8b f8 93 11 0f 46 4f f0 ...!.........FO.
         00 0b 37 b9 20 78 61 78 00 eb 01 08 28 78 69 78  ..7. xax....(xix
         0b e0 4e 2f 0b d1 94 f8 4d 10 94 f8 4e 00 01 eb ..N/....M...N...
         00 08 95 f8 4d 00 95 f8 4e 10 46 18 11 e0 78 1e ....M...N.F...x.
         4c 28 0e d8 e0 19 10 f8 01 1c e2 5d 40 78 11 44 L(.........]@x.D
         01 eb 00 08 e8 19 10 f8 01 1c ea 5d 40 78 11 44 ...........]@x.D
         0e 18 df f8 08 c3 df f8 08 e3 ac f1 a4 0c 0c eb ................
         07 01 91 f8 54 02 08 eb 06 02 9e f8 ....T.......
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.999601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 592.999684
         30 45 0b 00 09 30 02 44 9a 42 17 d3 9c f8 d1 22 0E...0.D.B....."
         02 fb 08 f3 c2 f1 ff 02 72 43 93 42 07 d3 9e f8 ........rC.B....
         18 20 90 42 0a d9 e0 5d ea 5d 80 18 06 d1 9c f8  . .B...].]......
         93 01 4f f0 01 0b 40 1c 8c f8 93 01 91 f8 44 01 ..O...@.......D.
         60 b1 39 46 ae 48 60 f7 f0 fc 38 b1 a9 49 a4 39 `.9F.H`...8..I.9
         91 f8 e3 01 40 1c 81 f8 e3 01 02 e0 bb f1 00 0f ....@...........
         03 d0 39 46 06 a8 60 f7 6d fd 7f 1c 4f 2f 92 d3 ..9F..`.m...O/..
         03 98 0a 22 06 a9 1e 30 af f7 52 ff 9e 4d 28 88 ..."...0..R..M(.
         00 05 25 d5 00 24 01 27 69 68 07 fa 04 f0 01 42 ..%..$.'ih.....B
         1b d0 98 4e a4 3e d6 f8 c8 12 01 42 15 d0 99 48 ...N.>.....B...H
         30 f8 14 10 10 f8 14 00 c1 f3 c5 12 c0 f3 06 01 0...............
         68 46 60 f7 03 fd dd e9 09 02 69 46 ff f7 02 ff hF`.......iF....
         10 f0 ff 00 86 f8 53 02 7e d1 64 1c ......S.~.d.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.000602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.000686
         f8 45 0b 00 20 2c db d3 03 98 0a 22 28 30 09 99  .E.. ,....."(0..
         af f7 22 ff 00 26 34 46 85 48 41 68 01 20 00 fa .."..&4F.HAh. ..
         04 f0 01 42 4a d0 81 49 a4 39 d1 f8 c8 12 01 42 ...BJ..I.9.....B
         44 d1 82 48 00 eb 44 05 6b 78 19 06 26 d5 10 f8 D..H..D.kx..&...
         14 10 30 f8 14 00 7b 4d c0 f3 c5 10 c3 f3 41 13 ..0...{M......A.
         42 08 2b 44 1b 7a c1 f3 06 01 5d 08 8f 18 a0 eb B.+D.z....].....
         02 0b a3 eb 05 08 06 a8 02 97 60 f7 f4 fc 07 46 ..........`....F
         5a 46 06 a8 02 99 60 f7 ee fc af 42 1e d3 40 45 ZF....`....B..@E
         1c d3 01 26 38 44 48 45 18 d9 15 e0 30 f8 14 10 ...&8DHE....0...
         10 f8 14 00 c1 f3 c5 12 c0 f3 06 01 06 a8 60 f7 ..............`.
         da fc 69 78 63 4a c1 f3 41 11 11 44 09 7a 81 42 ..ixcJ..A..D.z.B
         04 d8 01 26 81 45 01 d2 81 46 a2 46 64 1c 20 2c ...&.E...F.Fd. ,
         aa d3 9e b3 5d 4e 36 f8 1a 00 c0 f3 ....]N6.....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.001601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.001676
         c0 46 0b 00 c5 12 16 f8 1a 00 c0 f3 06 01 68 46 .F............hF
         60 f7 8c fc 53 4d 01 24 a4 3d d5 f8 c8 12 04 fa `...SM.$.=......
         0a f0 01 43 c5 f8 c8 12 dd e9 09 02 69 46 ff f7 ...C........iF..
         81 fe 85 f8 53 02 00 e0 32 e0 16 f8 1a 00 36 f8 ....S...2.....6.
         1a 20 4a 49 c0 f3 06 00 c2 f3 c5 12 09 79 02 44  . JI.........y.D
         03 e0 2b 18 83 f8 94 11 40 1c 82 42 f9 d8 85 f8 ..+.....@..B....
         f3 40 17 e0 ff e7 dd e9 09 02 06 a9 ff f7 50 fe .@............P.
         3c 4d 3e 4e a4 3d 85 f8 53 02 00 24 21 46 06 a8 <M>N.=..S..$!F..
         60 f7 14 fc 18 b1 30 79 29 19 81 f8 94 01 64 1c `.....0y).....d.
         4f 2c f3 d3 03 98 0a 22 32 30 09 99 af f7 78 fe O,....."20....x.
         0b b0 bd e8 f0 8f 2d e9 f1 4f 2e 4c 8a b0 54 3c ......-..O.L..T<
         32 48 09 94 00 7e df f8 c0 80 00 28 51 d1 a8 f1 2H...~.....(Q...
         04 00 90 f8 33 00 a4 f1 50 05 41 07 ....3...P.A.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.002601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.002675
         88 47 0b 00 05 f1 98 00 08 90 05 f1 8c 00 4f f0 .G............O.
         00 0b 07 90 02 d4 85 f8 53 b2 4c e1 4f 21 20 46 ........S.L.O! F
         60 f7 64 fc 0a 22 21 46 04 a8 af f7 4d fe b5 f8 `.d.."!F....M...
         d2 02 df f8 6c a0 40 1c 80 b2 a5 f8 d2 02 ba f8 ....l.@.........
         16 10 a9 46 88 42 47 d2 00 25 4e 46 70 19 90 f8 ...F.BG..%NFp...
         94 01 b1 46 18 b9 29 46 04 a8 60 f7 b0 fb 6d 1c ...F..)F..`...m.
         4f 2d f3 d3 00 25 01 26 da f8 04 00 ae 40 30 42 O-...%.&.....@0B
         2e d0 d9 f8 c8 02 30 42 2a d0 0c 4f 37 f8 15 00 ......0B*..O7...
         c0 f3 c5 12 17 f8 15 00 c0 f3 06 01 04 a8 60 f7 ..............`.
         1a fc 07 eb 45 01 49 78 0e e0 1f e1 98 43 20 00 ....E.Ix.....C .
         c0 06 20 00 98 07 20 00 18 06 20 00 e0 06 20 00  .. ... ... ... .
         d4 2b 20 00 40 3d 20 00 c1 f3 41 11 ff 4a 11 44  .+ .@= ...A..J.D
         09 7a 81 42 04 d9 d9 f8 c8 02 b0 43 .z.B.......C
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.003613
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.003688
         50 48 0b 00 c9 f8 c8 02 6d 1c 20 2d c7 d3 09 e0  PH......m. -....
         f9 4a a9 f8 d2 b2 c8 ca 04 ad c8 c5 c9 f8 c8 b2 .J..............
         5c f7 2e fc 0a 22 04 a9 04 f1 0a 00 af f7 e8 fd \...."..........
         04 f1 14 00 28 21 05 46 af f7 71 fe 41 46 04 a8 ....(!.F..q.AF..
         0a 9a ff f7 9d fd 10 f0 ff 00 89 f8 53 02 7e d1 ............S.~.
         ea 48 00 78 a0 b1 ba f8 00 00 c0 05 10 d5 e8 48 .H.x...........H
         62 f7 1f fe 4f 21 e6 48 60 f7 dc fb e4 49 04 a8 b...O!.H`....I..
         0a 9a ff f7 85 fd 10 f0 ff 00 89 f8 53 02 73 d1 ............S.s.
         ba f8 00 00 56 46 c0 04 0e d5 de 48 00 68 58 b1 ....VF.....H.hX.
         00 21 04 a8 60 f7 c6 fb 18 21 04 a8 60 f7 c2 fb .!..`....!..`...
         4e 21 04 a8 60 f7 be fb 0a 22 04 a9 28 46 af f7 N!..`...."..(F..
         a7 fd 04 a8 0a 99 ff f7 87 fd 99 f8 53 02 00 28 ............S..(
         52 d1 04 a8 07 99 60 f7 fb fa dd e9 R.....`.....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.004601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.004684
         18 49 0b 00 07 10 0a 22 af f7 50 fd 10 b1 cc 49 .I....."..P....I
         0f 20 88 73 ca 48 00 68 10 f0 fe 0f 3d d0 30 88  . .s.H.h....=.0.
         80 05 3a d5 99 f8 c7 02 40 1c c0 b2 53 f7 af fa ..:.....@...S...
         05 46 60 f7 2b fb 58 b9 01 26 30 46 53 f7 a7 fa .F`.+.X..&0FS...
         05 46 60 f7 23 fb 18 b9 76 1c 08 2e f5 d3 24 e0 .F`.#...v.....$.
         1d b3 b7 48 01 ae 0e c8 86 e8 0e 00 10 35 00 21 ...H.........5.!
         03 27 00 22 6b 5c 07 fa 02 f0 30 ea 03 03 02 d1 .'."k\....0.....
         73 5c 83 43 73 54 92 1c 08 2a f3 d3 49 1c 0a 29 s\.CsT...*..I..)
         ef d3 01 a9 00 e0 0b e0 04 a8 0a 9a ff f7 14 fd ................
         10 f0 ff 00 89 f8 53 02 02 d1 89 f8 53 b2 3d e0 ......S.....S.=.
         a5 4a 00 20 01 ab 18 f8 00 10 15 5c 29 40 19 54  .J. .......\)@.T
         40 1c 0a 28 f7 d3 01 a8 5c f7 80 fc 14 28 01 d9 @..(....\....(..
         01 a8 00 e0 40 46 07 46 4e 46 99 f8 ....@F.FNF..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.005602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.005686
         e0 49 0b 00 53 52 0a 22 04 a9 04 f1 32 00 af f7 .I..SR."....2...
         2f fd 1d e0 00 24 30 19 90 f8 94 11 29 b1 49 1e /....$0.....).I.
         11 f0 ff 01 80 f8 94 11 0f d1 21 46 04 a8 60 f7 ..........!F..`.
         ad fa 50 b1 21 46 38 46 60 f7 9f fa 28 b1 21 46 ..P.!F8F`...(.!F
         04 a8 60 f7 90 fa 6d 1e 04 d0 64 1c 4f 2c e2 d3 ..`...m...d.O,..
         00 2d df d1 89 48 90 f8 33 00 40 07 13 d4 0a 22 .-...H..3.@...."
         41 46 09 98 af f7 04 fd 40 46 07 99 60 f7 60 fa AF......@F..`.`.
         dd e9 07 10 0a 22 af f7 b5 fc 00 28 02 d0 7e 49 .....".....(..~I
         0f 20 88 73 7c e6 ba f8 00 00 4f f0 0a 02 40 05  . .s|.....O...@.
         04 d5 41 46 09 98 af f7 eb fc 71 e6 04 a9 09 98 ..AF......q.....
         af f7 97 fd 6c e6 2d e9 f0 47 77 48 74 4c 72 4e ....l.-..GwHtLrN
         00 25 df f8 d0 81 00 68 74 4f 04 f1 1c 09 0f 36 .%.....htO.....6
         18 b9 38 78 40 00 ff f7 5e fe 05 22 ..8x@...^.."
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.006601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.006685
         a8 4a 0b 00 21 46 30 46 af f7 ce fc 00 24 30 5d .J..!F0F.....$0]
         69 f7 f5 f9 64 1c 05 44 05 2c f8 d3 65 48 90 f8 i...d..D.,..eH..
         33 00 40 07 1a d5 68 48 00 88 40 05 16 d4 00 24 3.@...hH..@....$
         38 78 85 42 12 d0 0a 2c 4f ea 44 01 01 d8 89 1c 8x.B...,O.D.....
         00 e0 09 1d 40 46 60 f7 3d fa 20 b1 21 46 30 46  ....@F`.=. .!F0F
         60 f7 bc fa 6d 1e 64 1c 25 2c e9 d3 05 22 31 46 `...m.d.%,..."1F
         48 46 af f7 5b fc 52 4c 40 b1 05 22 31 46 48 46 HF..[.RL@.."1FHF
         af f7 9a fc 20 7d 20 f0 01 00 20 75 20 7d c0 07  .... } ... u }..
         05 d1 71 f7 59 f9 21 7d 60 f3 00 01 21 75 00 20 ..q.Y.!}`...!u.
         bd e8 f0 87 10 b5 4d 48 69 f7 4a fc 42 b2 47 48 ......MHi.J.B.GH
         50 38 90 f9 cc 12 59 b1 a1 eb e1 01 01 eb e2 01 P8....Y.........
         6f f0 7f 02 91 42 03 db 7f 22 7f 29 00 dc 4a b2 o....B...".)..J.
         3f 49 80 f8 cc 22 09 68 00 29 03 d1 ?I...".h.)..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.007613
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.007686
         70 4b 0b 00 90 f8 cc 12 80 f8 df 12 10 bd 2d e9 pK............-.
         f0 41 00 26 a0 f8 8c 60 80 f8 9b 60 90 f8 1f 11 .A.&...`...`....
         04 46 49 1c 80 f8 1f 11 c0 7b 4f f4 46 15 01 28 .FI......{O.F..(
         15 d1 94 f8 09 01 a8 b9 d5 f8 ac 0b 80 07 11 d5 ................
         a0 7b 68 f7 24 ff 40 08 20 f0 01 01 a0 69 88 42  .{h.$.@. ....i.B
         08 d0 68 f7 b1 fe 40 00 c4 f8 84 00 02 e0 20 46 ..h...@....... F
         b1 f7 fe fb d5 f8 ac 5b a8 07 7e d5 26 48 05 f0 .......[..~.&H..
         04 01 00 68 00 f0 40 00 08 43 50 d0 a0 7b 68 f7 ...h..@..CP..{h.
         06 ff 40 08 a4 f8 a0 00 94 f8 81 00 01 28 46 d1 ..@..........(F.
         02 20 84 f8 81 00 20 6d 90 f8 be 10 0c 20 70 f7  . .... m..... p.
         2e f8 20 6d 40 89 00 01 a4 f8 a2 00 20 46 98 f7  .. m@....... F..
         06 ff 20 6d d0 f8 b8 10 b4 f8 a0 00 68 f7 7c fe  .. m........h.|.
         21 6d 80 22 b1 f8 b2 10 81 42 26 d8 !m.".....B&.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.008601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.008685
         38 4c 0b 00 08 44 c9 01 80 31 1b e0 98 07 20 00 8L...D...1.... .
         90 14 26 00 a8 07 20 00 18 06 20 00 08 25 20 00  ..&... ... ..% .
         74 3d 20 00 d0 2b 20 00 54 a6 20 00 44 43 20 00  t= ..+ .T. .DC .
         b0 0c 20 00 14 06 20 00 c0 06 20 00 00 01 60 00  .. ... ... ...`.
         fc 0a 20 00 b1 fb f0 f0 c0 b2 84 f8 9f 00 80 28  .. ............(
         01 d9 84 f8 9f 20 94 f8 1f 01 01 28 0f d1 7f f7  ..... .....(....
         8a f9 48 49 89 78 21 b9 00 b9 7f 20 84 f8 26 01  ..HI.x!.... ..&.
         03 e0 01 46 20 46 70 f7 a0 f8 ff f7 43 ff 42 4f  ...F Fp.....C.BO
         78 7b 02 28 17 d1 21 6d 38 68 91 f8 be 10 88 42 x{.(..!m8h.....B
         11 d1 7f f7 70 f9 3a 7b 07 f1 38 01 50 54 38 7b ....p.:{..8.PT8{
         00 e0 08 e0 40 1c 07 21 b0 fb f1 f2 01 fb 12 00 ....@..!........
         38 73 87 f8 3f 60 c5 f3 41 00 03 28 23 d1 a0 7b 8s..?`..A..(#..{
         68 f7 81 fe 40 08 a4 f8 a0 00 20 46              h...@..... F
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.009601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.009687
         00 4d 0b 00 97 f7 92 f9 94 f8 0b 01 01 28 05 d8 .M...........(..
         2c 4a 00 eb 40 00 11 5c 49 1c 11 54 e0 7b 29 46 ,J..@..\I..T.{)F
         00 28 20 46 02 d1 99 f7 c5 f9 01 e0 99 f7 71 f9  .( F..........q.
         20 46 96 f7 bd fe 84 f8 8a 60 bd e8 f0 81 84 f8 F.......`......
         1e 61 a8 07 0b d5 20 49 94 f8 8a 00 09 78 88 42  .a.... I.....x.B
         05 d2 e1 7b 19 b1 40 1c 84 f8 8a 00 ed e7 94 f8 ...{..@.........
         98 00 08 b1 84 f8 98 60 20 46 bd e8 f0 41 99 f7  .......` F...A..
         40 b8 10 b5 53 f7 4b ff 14 49 09 68 08 43 07 d1 @...S.K..I.h.C..
         13 48 14 49 00 68 09 68 88 42 01 d1 01 20 10 bd .H.I.h.h.B... ..
         00 20 10 bd 10 b5 10 48 44 88 1c b1 0f 48 00 88  . .....HD....H..
         00 04 01 d5 00 20 10 bd ff f7 e3 ff 00 b1 a4 00  ..... ..........
         21 46 0b 48 71 f7 84 fa 01 20 10 bd c4 24 20 00  !F.Hq.... ...$ .
         b0 4b 20 00 18 25 20 00 fc 24 20 00              .K ..% ..$ .
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.010601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.010685
         c8 4d 0b 00 10 25 20 00 b0 0c 20 00 d0 0d 20 00  .M...% ... ... .
         98 07 20 00 c0 06 20 00 ac 42 20 00 11 48 cb 78  .. ... ..B ..H.x
         82 68 01 2b 02 d1 42 f0 02 02 01 e0 22 f0 02 02 .h.+..B....."...
         82 60 09 79 01 29 11 46 02 d1 41 f0 04 01 01 e0 .`.y.).F..A.....
         21 f0 04 01 81 60 08 48 00 21 c2 69 d3 02 02 d5 !....`.H.!.i....
         22 f0 80 72 c2 61 49 1c c9 b2 00 f5 8a 70 0b 29 "..r.aI......p.)
         f3 d3 70 47 b8 2a 20 00 e0 2c 20 00 10 b5 95 f7  ..pG.* .., .....
         c9 fa 04 46 90 f8 bd 00 f8 b9 20 8e 00 07 94 f8  ...F...... .....
         a8 00 06 d4 03 28 0e d0 12 28 0c d0 05 28 14 d1 .....(...(...(..
         09 e0 0f 28 07 d0 02 28 05 d0 04 28 03 d0 13 28 ...(...(...(...(
         01 d0 06 28 09 d1 3d 22 11 46 20 46 70 f7 fc fe  ...(..=".F Fp...
         00 20 84 f8 a8 00 01 20 10 bd 00 20 10 bd 10 b5  . ..... ... ....
         04 46 80 79 ff f7 d2 ff 20 b1 20 68              .F.y.... . h
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.011602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.011685
         90 4e 0b 00 bd e8 10 40 68 f7 8d bc a0 79 95 f7 .N.....@h....y..
         95 fa 80 8d 00 21 60 f3 0b 01 e0 79 60 f3 0d 31 .....!`....y`..1
         a0 88 60 f3 1f 41 20 68 01 60 a1 88 20 68 09 1d  ..`..A h.`.. h..
         bd e8 10 40 00 22 73 f7 a0 bb 2d e9 f0 41 07 46 ...@."s...-..A.F
         95 f7 7c fa 04 46 90 f8 af 50 86 8d 00 8e 80 05 ..|..F...P......
         03 d5 29 46 20 46 96 f7 a4 fa 20 8e 40 05 03 d5  ..)F F.... .@...
         29 46 20 46 96 f7 39 fa 94 f8 32 00 40 07 0c d5  )F F..9...2.@...
         20 8e 00 07 04 d5 29 46 20 46 96 f7 81 fa 04 e0   .....)F F......
         00 22 29 46 20 46 96 f7 68 fa 20 46 5c f7 52 fb  .")F F..h. F\.R.
         20 46 98 f7 2a fe 38 46 99 f7 aa fd 38 46 95 f7 F..*.8F....8F..
         05 fb 76 f7 57 fa 2a 46 31 46 bd e8 f0 41 00 20 ..v.W.*F1F...A.
         64 f7 cf bc 10 b5 53 f7 48 fc 00 28 07 d1 18 48 d.....S.H..(...H
         40 7e 00 28 03 d1 bd e8 10 40 4c f7 @~.(.....@L.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.012601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.012684
         58 4f 0b 00 90 ba 10 bd 10 b5 53 f7 3a fc 00 28 XO........S.:..(
         07 d1 11 48 40 7e 00 28 03 d1 bd e8 10 40 4c f7 ...H@~.(.....@L.
         82 ba 10 bd 2d e9 f0 41 0c 4d 06 46 0f 46 00 24 ....-..A.M.F.F.$
         04 eb 44 00 05 eb 80 10 01 8e c9 07 03 d0 3a 46 ..D...........:F
         31 46 70 f7 69 fe 64 1c e4 b2 0f 2c f0 d3 bd e8 1Fp.i.d....,....
         f0 81 13 21 16 20 e5 e7 40 a6 20 00 00 9b 20 00  ...!. ..@. ... .
         10 b5 04 46 02 20 84 f8 81 00 20 6d 40 89 00 01  ...F. .... m@...
         a4 f8 a2 00 20 46 98 f7 2e fd 20 6d 90 f8 be 10  .... F.... m....
         0c 20 6f f7 48 fe 20 6d d0 f8 b8 10 b4 f8 a0 00  . o.H. m........
         68 f7 9e fc 21 6d 80 22 b1 f8 b2 10 81 42 09 d8 h...!m.".....B..
         08 44 c9 01 80 31 b1 fb f0 f0 c0 b2 84 f8 9f 00 .D...1..........
         80 28 01 d9 84 f8 9f 20 10 bd 01 79 0c 29 01 d1  .(..... ...y.)..
         80 f7 1a ba 6f f7 6a be 70 b5 04 46 ....o.j.p..F
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.013601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.013685
         20 50 0b 00 0e 46 b1 f8 03 00 01 21 53 f7 89 f9 P...F.....!S...
         05 00 0d d1 b6 f8 03 00 95 f7 67 fa 28 b1 31 46 ..........g.(.1F
         20 46 bd e8 70 40 00 f0 11 b8 12 20 20 70 70 bd F..p@.....  pp.
         21 78 b4 f8 01 00 64 f7 8f fd 00 20 84 f8 28 00  !x....d.... ..(.
         01 46 28 46 bd e8 70 40 64 f7 2a bd 70 b5 05 46 .F(F..p@d.*.p..F
         b1 f8 03 00 95 f7 d5 f9 04 00 02 d1 12 20 28 70 ............. (p
         70 bd 20 8e 00 26 c1 05 1c d4 94 f8 32 10 c9 06  p. ..&......2...
         08 d5 81 05 02 d5 0c 20 28 70 14 e0 40 f4 00 70  ....... (p..@..p
         20 86 10 e0 40 f4 00 70 80 b2 40 f0 40 00 20 86 ...@..p..@.@. .
         94 f8 33 00 40 f0 10 00 84 f8 33 00 20 46 6f f7 ..3.@.....3. Fo.
         e2 fd 00 e0 01 26 29 78 b5 f8 01 00 64 f7 54 fd .....&)x....d.T.
         1e b1 00 21 20 46 96 f7 ac f9 00 20 85 f8 28 00  ...! F..... ..(.
         70 bd 00 00 2d e9 f8 43 89 46 b0 f8 p...-..C.F..
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.014601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.014678
         e8 50 0b 00 1e e0 05 46 26 49 ce f3 81 00 31 f8 .P.....F&I....1.
         10 70 00 24 08 9e a7 f5 70 60 90 46 ff 38 3f d0 .p.$....p`.F.8?.
         95 f8 24 00 01 28 3b d1 68 69 b0 f8 4e 20 42 45 ..$..(;.hi..N BE
         08 d2 d0 f8 10 c0 00 f1 10 01 8c 45 02 d1 a8 eb ...........E....
         02 01 8c b2 93 b1 00 21 5f ea 8e 62 03 d5 31 46 .......!_..b..1F
         75 f7 fe fe 01 46 39 43 ad f8 00 10 8d f8 02 60 u....F9C.......`
         2b 68 03 22 69 46 48 46 98 47 81 46 3c b9 68 69 +h."iFHF.G.F<.hi
         b0 f8 4e 10 b1 42 02 d2 71 1a 75 f7 b9 fb 42 46 ..N..B..q.u...BF
         49 46 68 69 75 f7 44 fc 00 2c 09 d0 03 e0 68 69 IFhiu.D..,....hi
         00 6b 89 f8 00 00 20 00 a4 f1 01 04 a4 b2 f6 d1  .k.... .........
         bd e8 f8 83 b8 04 20 00 90 f8 63 10 00 29 09 d0  ...... ...c..)..
         90 f8 69 10 00 29 05 d1 90 f8 62 10 00 29 01 d0 ..i..)....b..)..
         9c f7 7a bc 70 47 00 00 70 b5 04 46 ..z.pG..p..F
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.015586
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.015636
         b0 51 0b 00 0d 46 7c f7 03 fe 02 2d 0b d1 94 f8 .Q...F|....-....
         63 00 00 28 07 d0 20 46 9c f7 3e fc 20 46 bd e8  c..(.. F..>. F..
         70 40 9c f7 83 bc 70 bd 10 b5 2c 22 05 49 06 48 p@....p...,".I.H
         af f7 e7 f9 05 49 04 48 08 60 af f2 3b 01 01 61 .....I.H.`..;..a
         10 bd 00 00 fc 24 26 00 ac 60 0b 00 9c 0d 20 00 .....$&..`.... .
         70 b5 2b 4c 65 68 c5 f3 c1 06 6d f7 ee fa 01 2e p.+Leh....m.....
         37 d1 05 f0 07 00 27 49 27 4a 08 70 05 28 00 d8 7.....'I'J.p.(..
         98 b9 00 20 08 70 10 70 6c f7 6e f9 04 f5 42 74  ... .p.pl.n...Bt
         20 68 40 f0 10 00 20 60 20 68 20 f0 10 00 44 f8   h@... ` h ...D.
         b8 0b 20 68 20 f0 08 00 19 e0 1c 48 00 68 10 70  .. h ......H.h.p
         6b f7 5c fb 00 eb 40 00 19 49 c0 1e 08 70 6b f7 k.\...@..I...pk.
         55 fb 40 1e 04 f5 42 74 60 61 6b f7 4f fb a0 61 U.@...Bt`ak.O..a
         20 68 40 f0 10 00 20 60 20 68 20 f0               h@... ` h .
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.016622
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.016646
         78 52 0b 00 10 00 20 60 70 bd d4 f8 c0 03 20 f0  xR.... `p..... .
         08 00 c4 f8 c0 03 70 bd 48 b9 0a 48 08 4a 00 68 ......p.H..H.J.h
         12 78 90 42 01 d1 01 28 01 d1 00 20 70 47 01 eb  .x.B...(... pG..
         41 00 c0 1e 70 47 00 00 00 30 36 00 9c e7 20 00 A...pG...06... .
         b4 5e 0b 00 48 0c 20 00 a7 e7 20 00 22 00 00 00  .^..H. ... ."...
         39 35 0b 00 23 00 00 00 99 0c 0b 00 24 00 00 00 95..#.......$...
         bd 0c 0b 00 25 00 00 00 e1 0c 0b 00 35 00 00 00 ....%.......5...
         01 0d 0b 00 92 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 0b 55 03 00 .............U..
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 ff 09 0b 00 11 55 03 00 .............U..
         00 00 00 00 c0 fc 31 00 00 00 00 00 ff ff 00 00 ......1.........
         00 00 00 00 fc 02 60 00 01 00 00 00 ......`.....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.017602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.017685
         40 53 0b 00 01 00 00 00 c8 00 00 00 50 01 64 00 @S..........P.d.
         0c 00 00 00 0c 00 00 00 00 00 00 00 bc 01 60 00 ..............`.
         01 00 00 00 01 00 00 00 00 00 00 00 0c 01 60 00 ..............`.
         00 00 00 00 ff 00 00 00 00 00 00 00 2c 00 60 00 ............,.`.
         30 00 00 00 ff 00 00 00 00 00 00 00 24 00 60 00 0...........$.`.
         ff 00 00 00 ff 00 00 00 00 00 00 00 47 16 0b 00 ............G...
         bc b0 bc b0 43 4f 43 4f 00 00 00 00 e8 02 60 00 ....COCO......`.
         40 00 00 00 f0 00 00 00 00 00 00 00 64 fc 31 00 @...........d.1.
         ba 40 00 00 ff ff 00 00 00 00 00 00 60 fc 31 00 .@..........`.1.
         c0 50 00 00 ff ff 00 00 00 00 00 00 17 16 0b 00 .P..............
         bc b0 bc b0 43 4f 43 4f 00 00 00 00 34 fe 31 00 ....COCO....4.1.
         80 18 00 00 ff ff 00 00 00 00 00 00 60 01 60 00 ............`.`.
         55 00 00 00 ff 00 00 00 00 00 00 00 U...........
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.018603
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.018687
         08 54 0b 00 30 fc 31 00 e9 02 00 00 ff ff 00 00 .T..0.1.........
         00 00 00 00 dc fe 31 00 f1 82 00 00 ff ff 00 00 ......1.........
         00 00 00 00 db 14 0b 00 bc b0 bc b0 43 4f 43 4f ............COCO
         00 00 00 00 c0 fc 31 00 21 00 00 00 ff ff 00 00 ......1.!.......
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 c0 fc 31 00 00 00 00 00 ff ff 00 00 ......1.........
         00 00 00 00 88 fc 31 00 00 00 00 00 ff ff 00 00 ......1.........
         00 00 00 00 c4 fe 31 00 00 40 00 00 00 40 00 00 ......1..@...@..
         00 00 00 00 e8 ff 31 00 00 04 00 00 00 04 00 00 ......1.........
         00 00 00 00 db 14 0b 00 bc b0 bc b0 43 4f 43 4f ............COCO
         00 00 00 00 18 00 60 00 0d 00 00 00 ff 00 00 00 ......`.........
         00 00 00 00 14 00 60 00 0f 00 00 00 ff 00 00 00 ......`.........
         00 00 00 00 9c 02 60 00 00 00 00 00 ......`.....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.019612
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.019685
         d0 54 0b 00 ff 00 00 00 00 00 00 00 a0 02 60 00 .T............`.
         00 00 00 00 ff 00 00 00 00 00 00 00 a4 02 60 00 ..............`.
         00 00 00 00 ff 00 00 00 00 00 00 00 a8 02 60 00 ..............`.
         00 00 00 00 ff 00 00 00 00 00 00 00 ac 02 60 00 ..............`.
         00 00 00 00 ff 00 00 00 00 00 00 00 e7 15 0b 00 ................
         bc b0 bc b0 43 4f 43 4f 00 00 00 00 c0 fc 31 00 ....COCO......1.
         19 00 00 00 ff ff 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 c0 fc 31 00 ..............1.
         00 00 00 00 ff ff 00 00 00 00 00 00 88 fc 31 00 ..............1.
         00 08 00 00 ff ff 00 00 00 00 00 00 c4 fe 31 00 ..............1.
         00 40 00 00 00 40 00 00 00 00 00 00 e8 ff 31 00 .@...@........1.
         00 04 00 00 00 04 00 00 00 00 00 00 db 14 0b 00 ................
         bc b0 bc b0 43 4f 43 4f 00 00 00 00 ....COCO....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.020601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.020684
         98 55 0b 00 18 00 60 00 0f 00 00 00 ff 00 00 00 .U....`.........
         00 00 00 00 14 00 60 00 0f 00 00 00 ff 00 00 00 ......`.........
         00 00 00 00 e7 15 0b 00 bc b0 bc b0 43 4f 43 4f ............COCO
         00 00 00 00 c0 fc 31 00 19 00 00 00 ff ff 00 00 ......1.........
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 91 15 0b 00 00 00 00 00 b3 32 05 00 .............2..
         b3 32 05 00 00 00 00 00 cf 15 0b 00 91 15 0b 00 .2..............
         00 00 00 00 e3 4e 04 00 00 00 00 00 00 00 00 00 .....N..........
         cf 15 0b 00 9f 35 05 00 a5 35 05 00 d5 35 05 00 .....5...5...5..
         23 13 0b 00 3d 12 0b 00 b9 39 05 00 4d 34 05 00 #...=....9..M4..
         5d 34 05 00 6d 34 05 00 77 34 05 00 81 34 05 00 ]4..m4..w4...4..
         db 12 0b 00 6d 13 0b 00 bf 39 05 00 f7 39 05 00 ....m....9...9..
         83 13 0b 00 91 15 0b 00 00 00 00 00 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.021601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.021684
         60 56 0b 00 21 0e 0b 00 23 11 0b 00 00 00 00 00 `V..!...#.......
         cf 15 0b 00 13 40 04 00 1b 40 04 00 23 40 04 00 .....@...@..#@..
         4d 40 04 00 d3 16 0b 00 dd 41 04 00 a3 40 04 00 M@.......A...@..
         d9 40 04 00 8d 16 0b 00 45 41 04 00 e1 16 0b 00 .@......EA......
         9f 35 05 00 27 36 05 00 00 00 00 00 00 00 00 00 .5..'6..........
         2b 14 0b 00 b9 39 05 00 00 5f 0b 00 00 00 00 00 +....9..._......
         00 00 00 00 64 00 00 00 05 00 00 00 00 00 00 00 ....d...........
         00 aa 00 00 0c 5f 0b 00 00 00 00 00 01 00 00 00 ....._..........
         01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00 ................
         fd 16 0b 00 67 17 0b 00 6f 18 0b 00 00 00 00 00 ....g...o.......
         00 00 00 00 35 1a 0b 00 43 1a 0b 00 57 1a 0b 00 ....5...C...W...
         77 1a 0b 00 9d 1a 0b 00 cb ed fe ff 13 0b 00 00 w...............
         9c 14 26 00 b4 14 26 00 dc 14 26 00 ..&...&...&.
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.022601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.022685
         28 57 0b 00 f8 14 26 00 14 15 26 00 30 15 26 00 (W....&...&.0.&.
         44 06 20 00 8c 3d 20 00 0a 64 e6 b2 00 00 88 98  D. ..= ..d......
         42 5a 33 43 0f 00 38 00 90 01 38 01 07 00 01 00 BZ3C..8...8.....
         c3 00 f3 00 0a 0a 00 00 00 00 00 00 50 00 00 00 ............P...
         00 00 01 00 03 00 09 09 0a 0a 01 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 ff ff 00 00 ................
         ed 06 03 00 31 0a 03 00 c3 05 03 00 b3 0a 03 00 ....1...........
         19 0b 03 00 00 00 00 00 49 0b 03 00 1b 0e 03 00 ........I.......
         19 36 0b 00 3f 07 03 00 29 0b 03 00 00 00 00 00 .6..?...).......
         3b 40 0b 00 f3 e5 04 00 75 dc 04 00 00 00 00 00 ;@......u.......
         c3 3f 0b 00 00 00 00 00 7b 4b 0b 00 ad e7 04 00 .?......{K......
         05 43 0b 00 b1 e2 04 00 b7 dc 04 00 05 ca 04 00 .C..............
         3b cd 04 00 79 d5 04 00 00 00 00 00 ;...y.......
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.023602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 156 [hci0] 593.023685
         f0 57 0b 00 ff 3d 0b 00 00 00 00 00 e9 3c 0b 00 .W...=.......<..
         7d 3d 0b 00 a5 d5 04 00 f9 d6 04 00 1d c7 04 00 }=..............
         05 ca 04 00 3b cd 04 00 e3 c6 04 00 00 00 00 00 ....;...........
         a9 3d 0b 00 00 00 00 00 ff 41 0b 00 00 00 00 00 .=.......A......
         00 00 00 00 cf cc 04 00 1d c7 04 00 e7 d1 04 00 ................
         00 00 00 00 99 cf 04 00 00 00 00 00 2f d4 04 00 ............/...
         1f d0 04 00 df 40 0b 00 00 00 00 00 e3 d3 04 00 .....@..........
         03 d4 04 00 65 d0 04 00 d4 03 00 00 00 00 00 00 ....e...........
         00 00 00 00 00 00 00 00 00 00 00 00 28 00 00 00 ............(...
         c8 e0 0e 39 f0 00 00 00 02 03 03 00 ...9........
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.024601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.024685
         00 59 0b 00 22 00 00 00 39 35 0b 00 23 00 00 00 .Y.."...95..#...
         99 0c 0b 00 24 00 00 00 bd 0c 0b 00 25 00 00 00 ....$.......%...
         e1 0c 0b 00 35 00 00 00 01 0d 0b 00 92 00 00 00 ....5...........
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 0b 55 03 00 00 00 00 00 00 00 00 00 .....U..........
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         ff 09 0b 00 11 55 03 00 00 00 00 00 c0 fc 31 00 .....U........1.
         00 00 00 00 ff ff 00 00 00 00 00 00 fc 02 60 00 ..............`.
         01 00 00 00 01 00 00 00 c8 00 00 00 50 01 64 00 ............P.d.
         0c 00 00 00 0c 00 00 00 00 00 00 00 bc 01 60 00 ..............`.
         01 00 00 00 01 00 00 00 00 00 00 00 0c 01 60 00 ..............`.
         00 00 00 00 ff 00 00 00 00 00 00 00 2c 00 60 00 ............,.`.
         30 00 00 00 ff 00 00 00 00 00 00 00 0...........
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.025601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.025685
         c8 59 0b 00 24 00 60 00 ff 00 00 00 ff 00 00 00 .Y..$.`.........
         00 00 00 00 47 16 0b 00 bc b0 bc b0 43 4f 43 4f ....G.......COCO
         00 00 00 00 e8 02 60 00 40 00 00 00 f0 00 00 00 ......`.@.......
         00 00 00 00 64 fc 31 00 ba 40 00 00 ff ff 00 00 ....d.1..@......
         00 00 00 00 60 fc 31 00 c0 50 00 00 ff ff 00 00 ....`.1..P......
         00 00 00 00 17 16 0b 00 bc b0 bc b0 43 4f 43 4f ............COCO
         00 00 00 00 34 fe 31 00 80 18 00 00 ff ff 00 00 ....4.1.........
         00 00 00 00 60 01 60 00 55 00 00 00 ff 00 00 00 ....`.`.U.......
         00 00 00 00 30 fc 31 00 e9 02 00 00 ff ff 00 00 ....0.1.........
         00 00 00 00 dc fe 31 00 f1 82 00 00 ff ff 00 00 ......1.........
         00 00 00 00 db 14 0b 00 bc b0 bc b0 43 4f 43 4f ............COCO
         00 00 00 00 c0 fc 31 00 21 00 00 00 ff ff 00 00 ......1.!.......
         00 00 00 00 00 00 00 00 00 00 00 00 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.026601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.026685
         90 5a 0b 00 00 00 00 00 00 00 00 00 c0 fc 31 00 .Z............1.
         00 00 00 00 ff ff 00 00 00 00 00 00 88 fc 31 00 ..............1.
         00 00 00 00 ff ff 00 00 00 00 00 00 c4 fe 31 00 ..............1.
         00 40 00 00 00 40 00 00 00 00 00 00 e8 ff 31 00 .@...@........1.
         00 04 00 00 00 04 00 00 00 00 00 00 db 14 0b 00 ................
         bc b0 bc b0 43 4f 43 4f 00 00 00 00 18 00 60 00 ....COCO......`.
         0d 00 00 00 ff 00 00 00 00 00 00 00 14 00 60 00 ..............`.
         0f 00 00 00 ff 00 00 00 00 00 00 00 9c 02 60 00 ..............`.
         00 00 00 00 ff 00 00 00 00 00 00 00 a0 02 60 00 ..............`.
         00 00 00 00 ff 00 00 00 00 00 00 00 a4 02 60 00 ..............`.
         00 00 00 00 ff 00 00 00 00 00 00 00 a8 02 60 00 ..............`.
         00 00 00 00 ff 00 00 00 00 00 00 00 ac 02 60 00 ..............`.
         00 00 00 00 ff 00 00 00 00 00 00 00 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.027586
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.027636
         58 5b 0b 00 e7 15 0b 00 bc b0 bc b0 43 4f 43 4f X[..........COCO
         00 00 00 00 c0 fc 31 00 19 00 00 00 ff ff 00 00 ......1.........
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 c0 fc 31 00 00 00 00 00 ff ff 00 00 ......1.........
         00 00 00 00 88 fc 31 00 00 08 00 00 ff ff 00 00 ......1.........
         00 00 00 00 c4 fe 31 00 00 40 00 00 00 40 00 00 ......1..@...@..
         00 00 00 00 e8 ff 31 00 00 04 00 00 00 04 00 00 ......1.........
         00 00 00 00 db 14 0b 00 bc b0 bc b0 43 4f 43 4f ............COCO
         00 00 00 00 18 00 60 00 0f 00 00 00 ff 00 00 00 ......`.........
         00 00 00 00 14 00 60 00 0f 00 00 00 ff 00 00 00 ......`.........
         00 00 00 00 e7 15 0b 00 bc b0 bc b0 43 4f 43 4f ............COCO
         00 00 00 00 c0 fc 31 00 19 00 00 00 ff ff 00 00 ......1.........
         00 00 00 00 00 00 00 00 00 00 00 00 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.028584
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.028625
         20 5c 0b 00 00 00 00 00 00 00 00 00 91 15 0b 00 \..............
         00 00 00 00 b3 32 05 00 b3 32 05 00 00 00 00 00 .....2...2......
         cf 15 0b 00 91 15 0b 00 00 00 00 00 e3 4e 04 00 .............N..
         00 00 00 00 00 00 00 00 cf 15 0b 00 9f 35 05 00 .............5..
         a5 35 05 00 d5 35 05 00 23 13 0b 00 3d 12 0b 00 .5...5..#...=...
         b9 39 05 00 4d 34 05 00 5d 34 05 00 6d 34 05 00 .9..M4..]4..m4..
         77 34 05 00 81 34 05 00 db 12 0b 00 6d 13 0b 00 w4...4......m...
         bf 39 05 00 f7 39 05 00 83 13 0b 00 91 15 0b 00 .9...9..........
         00 00 00 00 21 0e 0b 00 23 11 0b 00 00 00 00 00 ....!...#.......
         cf 15 0b 00 13 40 04 00 1b 40 04 00 23 40 04 00 .....@...@..#@..
         4d 40 04 00 d3 16 0b 00 dd 41 04 00 a3 40 04 00 M@.......A...@..
         d9 40 04 00 8d 16 0b 00 45 41 04 00 e1 16 0b 00 .@......EA......
         9f 35 05 00 27 36 05 00 00 00 00 00 .5..'6......
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.029611
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.029657
         e8 5c 0b 00 00 00 00 00 2b 14 0b 00 b9 39 05 00 .\......+....9..
         00 5f 0b 00 00 00 00 00 00 00 00 00 64 00 00 00 ._..........d...
         05 00 00 00 00 00 00 00 00 aa 00 00 0c 5f 0b 00 ............._..
         00 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00 ................
         01 00 00 00 00 00 00 00 fd 16 0b 00 67 17 0b 00 ............g...
         6f 18 0b 00 00 00 00 00 00 00 00 00 35 1a 0b 00 o...........5...
         43 1a 0b 00 57 1a 0b 00 77 1a 0b 00 9d 1a 0b 00 C...W...w.......
         cb ed fe ff 13 0b 00 00 9c 14 26 00 b4 14 26 00 ..........&...&.
         dc 14 26 00 f8 14 26 00 14 15 26 00 30 15 26 00 ..&...&...&.0.&.
         44 06 20 00 8c 3d 20 00 0a 64 e6 b2 00 00 88 98  D. ..= ..d......
         42 5a 33 43 0f 00 38 00 90 01 38 01 07 00 01 00 BZ3C..8...8.....
         c3 00 f3 00 0a 0a 00 00 00 00 00 00 50 00 00 00 ............P...
         00 00 01 00 03 00 09 09 0a 0a 01 00 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.030601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.030682
         b0 5d 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 .]..............
         00 00 00 00 ff ff 00 00 ed 06 03 00 31 0a 03 00 ............1...
         c3 05 03 00 b3 0a 03 00 19 0b 03 00 00 00 00 00 ................
         49 0b 03 00 1b 0e 03 00 19 36 0b 00 3f 07 03 00 I........6..?...
         29 0b 03 00 00 00 00 00 3b 40 0b 00 f3 e5 04 00 ).......;@......
         75 dc 04 00 00 00 00 00 c3 3f 0b 00 00 00 00 00 u........?......
         7b 4b 0b 00 ad e7 04 00 05 43 0b 00 b1 e2 04 00 {K.......C......
         b7 dc 04 00 05 ca 04 00 3b cd 04 00 79 d5 04 00 ........;...y...
         00 00 00 00 ff 3d 0b 00 00 00 00 00 e9 3c 0b 00 .....=.......<..
         7d 3d 0b 00 a5 d5 04 00 f9 d6 04 00 1d c7 04 00 }=..............
         05 ca 04 00 3b cd 04 00 e3 c6 04 00 00 00 00 00 ....;...........
         a9 3d 0b 00 00 00 00 00 ff 41 0b 00 00 00 00 00 .=.......A......
         00 00 00 00 cf cc 04 00 1d c7 04 00 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.031613
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.031686
         78 5e 0b 00 e7 d1 04 00 00 00 00 00 99 cf 04 00 x^..............
         00 00 00 00 2f d4 04 00 1f d0 04 00 df 40 0b 00 ..../........@..
         00 00 00 00 e3 d3 04 00 03 d4 04 00 65 d0 04 00 ............e...
         d4 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.032600
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.032685
         40 5f 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 @_..............
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.033601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 204 [hci0] 593.033684
         08 60 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 .`..............
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
         00 00 00 00 00 00 00 00 00 00 00 00 ............
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.034601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 12 [hci0] 593.034685
         d0 60 0b 00 00 00 00 00 00 00 00 00 .`..........
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.035602
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004c) plen 20 [hci0] 593.035686
         00 63 0b 00 28 00 00 00 c8 e0 0e 39 f0 00 00 00 .c..(......9....
         02 03 03 00 ....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.036601
       Vendor (0x3f|0x004c) ncmd 1
         Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x004e) plen 4 [hci0] 593.036683
         ff ff ff ff ....
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.037597
       Vendor (0x3f|0x004e) ncmd 1
         Status: Success (0x00)
 > HCI Event: Vendor (0xff) plen 2 [hci0] 593.073654
         1e 00 ..
< HCI Command: Reset (0x03|0x0003) plen 0 [hci0] 593.291582
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.293653
       Reset (0x03|0x0003) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Local Version Inf.. (0x04|0x0001) plen 0 [hci0] 
593.293747
 > HCI Event: Command Complete (0x0e) plen 12 [hci0] 593.294660
       Read Local Version Information (0x04|0x0001) ncmd 1
         Status: Success (0x00)
         HCI version: Bluetooth 4.0 (0x06) - Revision 182 (0x00b6)
         LMP version: Bluetooth 4.0 (0x06) - Subversion 8459 (0x210b)
         Manufacturer: Broadcom Corporation (15)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0 [hci0] 593.294764
 > HCI Event: Command Complete (0x0e) plen 10 [hci0] 593.295608
       Read BD ADDR (0x04|0x0009) ncmd 1
         Status: Success (0x00)
         Address: 3C:77:E6:DC:74:94 (OUI 3C-77-E6)
< HCI Command: Reset (0x03|0x0003) plen 0 [hci0] 593.295660
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.297597
       Reset (0x03|0x0003) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Local Supported F.. (0x04|0x0003) plen 0 [hci0] 
593.297614
 > HCI Event: Command Complete (0x0e) plen 12 [hci0] 593.298604
       Read Local Supported Features (0x04|0x0003) ncmd 1
         Status: Success (0x00)
         Features: 0xff 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
           3 slot packets
           5 slot packets
           Encryption
           Slot offset
           Timing accuracy
           Role switch
           Hold mode
           Sniff mode
           Power control requests
           Channel quality driven data rate (CQDDR)
           SCO link
           HV2 packets
           HV3 packets
           u-law log synchronous data
           A-law log synchronous data
           CVSD synchronous data
           Paging parameter negotiation
           Power control
           Transparent synchronous data
           Flow control lag (most significant bit)
           Broadcast Encryption
           Enhanced Data Rate ACL 2 Mbps mode
           Enhanced Data Rate ACL 3 Mbps mode
           Enhanced inquiry scan
           Interlaced inquiry scan
           Interlaced page scan
           RSSI with inquiry results
           Extended SCO link (EV3 packets)
           EV4 packets
           EV5 packets
           AFH capable slave
           AFH classification slave
           LE Supported (Controller)
           3-slot Enhanced Data Rate ACL packets
           5-slot Enhanced Data Rate ACL packets
           Sniff subrating
           Pause encryption
           AFH capable master
           AFH classification master
           Enhanced Data Rate eSCO 2 Mbps mode
           Enhanced Data Rate eSCO 3 Mbps mode
           3-slot Enhanced Data Rate eSCO packets
           Extended Inquiry Response
           Simultaneous LE and BR/EDR (Controller)
           Secure Simple Pairing
           Encapsulated PDU
           Erroneous Data Reporting
           Non-flushable Packet Boundary Flag
           Link Supervision Timeout Changed Event
           Inquiry TX Power Level
           Enhanced Power Control
           Extended features
< HCI Command: Read Local Version Inf.. (0x04|0x0001) plen 0 [hci0] 
593.298622
 > HCI Event: Command Complete (0x0e) plen 12 [hci0] 593.299619
       Read Local Version Information (0x04|0x0001) ncmd 1
         Status: Success (0x00)
         HCI version: Bluetooth 4.0 (0x06) - Revision 182 (0x00b6)
         LMP version: Bluetooth 4.0 (0x06) - Subversion 8459 (0x210b)
         Manufacturer: Broadcom Corporation (15)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0 [hci0] 593.299650
 > HCI Event: Command Complete (0x0e) plen 10 [hci0] 593.300617
       Read BD ADDR (0x04|0x0009) ncmd 1
         Status: Success (0x00)
         Address: 3C:77:E6:DC:74:94 (OUI 3C-77-E6)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0 [hci0] 593.300709
 > HCI Event: Command Complete (0x0e) plen 11 [hci0] 593.301606
       Read Buffer Size (0x04|0x0005) ncmd 1
         Status: Success (0x00)
         ACL MTU: 1021 ACL max packet: 8
         SCO MTU: 64   SCO max packet: 1
< HCI Command: Read Class of Device (0x03|0x0023) plen 0 [hci0] 593.301630
 > HCI Event: Command Complete (0x0e) plen 7 [hci0] 593.302590
       Read Class of Device (0x03|0x0023) ncmd 1
         Status: Success (0x00)
         Class: 0x000000
           Major class: Miscellaneous
           Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0 [hci0] 593.302615
 > HCI Event: Command Complete (0x0e) plen 252 [hci0] 593.318596
       Read Local Name (0x03|0x0014) ncmd 1
         Status: Success (0x00)
         Name: Broadcom Bluetooth Device (43142)
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0 [hci0] 593.318636
 > HCI Event: Command Complete (0x0e) plen 6 [hci0] 593.319623
       Read Voice Setting (0x03|0x0025) ncmd 1
         Status: Success (0x00)
         Setting: 0x0060
           Input Coding: Linear
           Input Data Format: 2's complement
           Input Sample Size: 16-bit
           # of bits padding at MSB: 0
           Air Coding Format: CVSD
< HCI Command: Read Number of Support.. (0x03|0x0038) plen 0 [hci0] 
593.319646
 > HCI Event: Command Complete (0x0e) plen 5 [hci0] 593.320621
       Read Number of Supported IAC (0x03|0x0038) ncmd 1
         Status: Success (0x00)
         Number of IAC: 4
< HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0 [hci0] 593.320642
 > HCI Event: Command Complete (0x0e) plen 8 [hci0] 593.321615
       Read Current IAC LAP (0x03|0x0039) ncmd 1
         Status: Success (0x00)
         Number of IAC: 1
         Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1 [hci0] 593.321634
         Type: Clear All Filters (0x00)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.322612
       Set Event Filter (0x03|0x0005) ncmd 1
         Status: Success (0x00)
< HCI Command: Write Connection Accep.. (0x03|0x0016) plen 2 [hci0] 
593.322631
         Timeout: 20000.000 msec (0x7d00)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.323613
       Write Connection Accept Timeout (0x03|0x0016) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0 [hci0] 593.323632
 > HCI Event: Command Complete (0x0e) plen 7 [hci0] 593.324616
       LE Read Buffer Size (0x08|0x0002) ncmd 1
         Status: Success (0x00)
         Data packet length: 27
         Num data packets: 15
< HCI Command: LE Read Local Supporte.. (0x08|0x0003) plen 0 [hci0] 
593.324634
 > HCI Event: Command Complete (0x0e) plen 12 [hci0] 593.325606
       LE Read Local Supported Features (0x08|0x0003) ncmd 1
         Status: Success (0x00)
         Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
           LE Encryption
< HCI Command: LE Read Supported States (0x08|0x001c) plen 0 [hci0] 
593.325630
 > HCI Event: Command Complete (0x0e) plen 12 [hci0] 593.326607
       LE Read Supported States (0x08|0x001c) ncmd 1
         Status: Success (0x00)
         States: 0x000000001fffffff
           Non-connectable Advertising State
           Scannable Advertising State
           Connectable Advertising State
           High Duty Cycle Directed Advertising State
           Passive Scanning State
           Active Scanning State
           Initiating State
             and Connection State (Master Role)
           Connection State (Slave Role)
           Non-connectable Advertising State
             and Passive Scanning State
           Scannable Advertising State
             and Passive Scanning State
           Connectable Advertising State
             and Passive Scanning State
           High Duty Cycle Directed Advertising State
             and Passive Scanning State
           Non-connectable Advertising State
             and Active Scanning State
           Scannable Advertising State
             and Active Scanning State
           Connectable Advertising State
             and Active Scanning State
           High Duty Cycle Directed Advertising State
             and Active Scanning State
           Non-connectable Advertising State
             and Initiating State
           Scannable Advertising State
             and Initiating State
           Non-connectable Advertising State
             and Connection State (Master Role)
           Scannable Advertising State
             and Connection State (Master Role)
           Non-connectable Advertising State
             and Connection State (Slave Role)
           Scannable Advertising State
             and Connection State (Slave Role)
           Passive Scanning State
             and Initiating State
           Active Scanning State
             and Initiating State
           Passive Scanning State
             and Connection State (Master Role)
           Active Scanning State
             and Connection State (Master Role)
           Passive Scanning State
             and Connection State (Slave Role)
           Active Scanning State
             and Connection State (Slave Role)
           Initiating State
             and Connection State (Master Role)
             and Master Role & Master Role
< HCI Command: LE Read White List Size (0x08|0x000f) plen 0 [hci0] 
593.326631
 > HCI Event: Command Complete (0x0e) plen 5 [hci0] 593.327614
       LE Read White List Size (0x08|0x000f) ncmd 1
         Status: Success (0x00)
         Size: 32
< HCI Command: LE Clear White List (0x08|0x0010) plen 0 [hci0] 593.327629
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.328602
       LE Clear White List (0x08|0x0010) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Local Supported C.. (0x04|0x0002) plen 0 [hci0] 
593.328625
 > HCI Event: Command Complete (0x0e) plen 68 [hci0] 593.333620
       Read Local Supported Commands (0x04|0x0002) ncmd 1
         Status: Success (0x00)
         Commands: 164 entries
           Inquiry (Octet 0 - Bit 0)
           Inquiry Cancel (Octet 0 - Bit 1)
           Periodic Inquiry Mode (Octet 0 - Bit 2)
           Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
           Create Connection (Octet 0 - Bit 4)
           Disconnect (Octet 0 - Bit 5)
           Add SCO Connection (Octet 0 - Bit 6)
           Create Connection Cancel (Octet 0 - Bit 7)
           Accept Connection Request (Octet 1 - Bit 0)
           Reject Connection Request (Octet 1 - Bit 1)
           Link Key Request Reply (Octet 1 - Bit 2)
           Link Key Request Negative Reply (Octet 1 - Bit 3)
           PIN Code Request Reply (Octet 1 - Bit 4)
           PIN Code Request Negative Reply (Octet 1 - Bit 5)
           Change Connection Packet Type (Octet 1 - Bit 6)
           Authentication Requested (Octet 1 - Bit 7)
           Set Connection Encryption (Octet 2 - Bit 0)
           Change Connection Link Key (Octet 2 - Bit 1)
           Master Link Key (Octet 2 - Bit 2)
           Remote Name Request (Octet 2 - Bit 3)
           Remote Name Request Cancel (Octet 2 - Bit 4)
           Read Remote Supported Features (Octet 2 - Bit 5)
           Read Remote Extended Features (Octet 2 - Bit 6)
           Read Remote Version Information (Octet 2 - Bit 7)
           Read Clock Offset (Octet 3 - Bit 0)
           Read LMP Handle (Octet 3 - Bit 1)
           Holde Mode (Octet 4 - Bit 1)
           Sniff Mode (Octet 4 - Bit 2)
           Exit Sniff Mode (Octet 4 - Bit 3)
           QoS Setup (Octet 4 - Bit 6)
           Role Discovery (Octet 4 - Bit 7)
           Switch Role (Octet 5 - Bit 0)
           Read Link Policy Settings (Octet 5 - Bit 1)
           Write Link Policy Settings (Octet 5 - Bit 2)
           Read Default Link Policy Settings (Octet 5 - Bit 3)
           Write Default Link Policy Settings (Octet 5 - Bit 4)
           Flow Specification (Octet 5 - Bit 5)
           Set Event Mask (Octet 5 - Bit 6)
           Reset (Octet 5 - Bit 7)
           Set Event Filter (Octet 6 - Bit 0)
           Flush (Octet 6 - Bit 1)
           Read PIN Type (Octet 6 - Bit 2)
           Write PIN Type (Octet 6 - Bit 3)
           Read Stored Link Key (Octet 6 - Bit 5)
           Write Stored Link Key (Octet 6 - Bit 6)
           Delete Stored Link Key (Octet 6 - Bit 7)
           Write Local Name (Octet 7 - Bit 0)
           Read Local Name (Octet 7 - Bit 1)
           Read Connection Accept Timeout (Octet 7 - Bit 2)
           Write Connection Accept Timeout (Octet 7 - Bit 3)
           Read Page Timeout (Octet 7 - Bit 4)
           Write Page Timeout (Octet 7 - Bit 5)
           Read Scan Enable (Octet 7 - Bit 6)
           Write Scan Enable (Octet 7 - Bit 7)
           Read Page Scan Activity (Octet 8 - Bit 0)
           Write Page Scan Activity (Octet 8 - Bit 1)
           Read Inquiry Scan Activity (Octet 8 - Bit 2)
           Write Inquiry Scan Activity (Octet 8 - Bit 3)
           Read Authentication Enable (Octet 8 - Bit 4)
           Write Authentication Enable (Octet 8 - Bit 5)
           Read Encryption Mode (Octet 8 - Bit 6)
           Write Encryption Mode (Octet 8 - Bit 7)
           Read Class of Device (Octet 9 - Bit 0)
           Write Class of Device (Octet 9 - Bit 1)
           Read Voice Setting (Octet 9 - Bit 2)
           Write Voice Setting (Octet 9 - Bit 3)
           Read Automatic Flush Timeout (Octet 9 - Bit 4)
           Write Automatic Flush Timeout (Octet 9 - Bit 5)
           Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
           Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
           Read Hold Mode Activity (Octet 10 - Bit 0)
           Write Hold Mode Activity (Octet 10 - Bit 1)
           Read Transmit Power Level (Octet 10 - Bit 2)
           Read Sync Flow Control Enable (Octet 10 - Bit 3)
           Set Controller To Host Flow Control (Octet 10 - Bit 5)
           Host Buffer Size (Octet 10 - Bit 6)
           Host Number of Completed Packets (Octet 10 - Bit 7)
           Read Link Supervision Timeout (Octet 11 - Bit 0)
           Write Link Supervision Timeout (Octet 11 - Bit 1)
           Read Number of Supported IAC (Octet 11 - Bit 2)
           Read Current IAC LAP (Octet 11 - Bit 3)
           Write Current IAC LAP (Octet 11 - Bit 4)
           Set AFH Host Channel Classification (Octet 12 - Bit 1)
           Read Inquiry Scan Type (Octet 12 - Bit 4)
           Write Inquiry Scan Type (Octet 12 - Bit 5)
           Read Inquiry Mode (Octet 12 - Bit 6)
           Write Inquiry Mode (Octet 12 - Bit 7)
           Read Page Scan Type (Octet 13 - Bit 0)
           Write Page Scan Type (Octet 13 - Bit 1)
           Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
           Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
           Read Local Version Information (Octet 14 - Bit 3)
           Read Local Supported Features (Octet 14 - Bit 5)
           Read Local Extended Features (Octet 14 - Bit 6)
           Read Buffer Size (Octet 14 - Bit 7)
           Read BD ADDR (Octet 15 - Bit 1)
           Read Failed Contact Counter (Octet 15 - Bit 2)
           Reset Failed Contact Counter (Octet 15 - Bit 3)
           Read Link Quality (Octet 15 - Bit 4)
           Read RSSI (Octet 15 - Bit 5)
           Read AFH Channel Map (Octet 15 - Bit 6)
           Read Clock (Octet 15 - Bit 7)
           Read Loopback Mode (Octet 16 - Bit 0)
           Write Loopback Mode (Octet 16 - Bit 1)
           Enable Device Under Test Mode (Octet 16 - Bit 2)
           Setup Synchronous Connection (Octet 16 - Bit 3)
           Accept Synchronous Connection Request (Octet 16 - Bit 4)
           Reject Synchronous Connection Request (Octet 16 - Bit 5)
           Read Extended Inquiry Response (Octet 17 - Bit 0)
           Write Extended Inquiry Response (Octet 17 - Bit 1)
           Refresh Encryption Key (Octet 17 - Bit 2)
           Sniff Subrating (Octet 17 - Bit 4)
           Read Simple Pairing Mode (Octet 17 - Bit 5)
           Write Simple Pairing Mode (Octet 17 - Bit 6)
           Read Local OOB Data (Octet 17 - Bit 7)
           Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
           Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
           Read Default Erroneous Reporting (Octet 18 - Bit 2)
           Write Default Erroneous Reporting (Octet 18 - Bit 3)
           IO Capability Request Reply (Octet 18 - Bit 7)
           User Confirmation Request Reply (Octet 19 - Bit 0)
           User Confirmation Request Neg Reply (Octet 19 - Bit 1)
           User Passkey Request Reply (Octet 19 - Bit 2)
           User Passkey Request Negative Reply (Octet 19 - Bit 3)
           Remote OOB Data Request Reply (Octet 19 - Bit 4)
           Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
           Enhanced Flush (Octet 19 - Bit 6)
           Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
           Send Keypress Notification (Octet 20 - Bit 2)
           IO Capability Request Negative Reply (Octet 20 - Bit 3)
           Read Encryption Key Size (Octet 20 - Bit 4)
           Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
           Read LE Host Supported (Octet 24 - Bit 5)
           Write LE Host Supported (Octet 24 - Bit 6)
           LE Set Event Mask (Octet 25 - Bit 0)
           LE Read Buffer Size (Octet 25 - Bit 1)
           LE Read Local Supported Features (Octet 25 - Bit 2)
           LE Set Random Address (Octet 25 - Bit 4)
           LE Set Advertising Parameters (Octet 25 - Bit 5)
           LE Read Advertising Channel TX Power (Octet 25 - Bit 6)
           LE Set Advertising Data (Octet 25 - Bit 7)
           LE Set Scan Response Data (Octet 26 - Bit 0)
           LE Set Advertise Enable (Octet 26 - Bit 1)
           LE Set Scan Parameters (Octet 26 - Bit 2)
           LE Set Scan Enable (Octet 26 - Bit 3)
           LE Create Connection (Octet 26 - Bit 4)
           LE Create Connection Cancel (Octet 26 - Bit 5)
           LE Read White List Size (Octet 26 - Bit 6)
           LE Clear White List (Octet 26 - Bit 7)
           LE Add Device To White List (Octet 27 - Bit 0)
           LE Remove Device From White List (Octet 27 - Bit 1)
           LE Connection Update (Octet 27 - Bit 2)
           LE Set Host Channel Classification (Octet 27 - Bit 3)
           LE Read Channel Map (Octet 27 - Bit 4)
           LE Read Remote Used Features (Octet 27 - Bit 5)
           LE Encrypt (Octet 27 - Bit 6)
           LE Rand (Octet 27 - Bit 7)
           LE Start Encryption (Octet 28 - Bit 0)
           LE Long Term Key Request Reply (Octet 28 - Bit 1)
           LE Long Term Key Request Neg Reply (Octet 28 - Bit 2)
           LE Read Supported States (Octet 28 - Bit 3)
           LE Receiver Test (Octet 28 - Bit 4)
           LE Transmitter Test (Octet 28 - Bit 5)
           LE Test End (Octet 28 - Bit 6)
< HCI Command: Write Extended Inqui.. (0x03|0x0052) plen 241 [hci0] 
593.333642
         FEC: Not required (0x00)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.334602
       Write Extended Inquiry Response (0x03|0x0052) ncmd 1
         Status: Success (0x00)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1 [hci0] 593.334622
         Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.335614
       Write Inquiry Mode (0x03|0x0045) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Inquiry Response... (0x03|0x0058) plen 0 [hci0] 
593.335634
 > HCI Event: Command Complete (0x0e) plen 5 [hci0] 593.336602
       Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
         Status: Success (0x00)
         TX power: 0 dBm
< HCI Command: Read Local Extended Fe.. (0x04|0x0004) plen 1 [hci0] 
593.336627
         Page: 1
 > HCI Event: Command Complete (0x0e) plen 14 [hci0] 593.337608
       Read Local Extended Features (0x04|0x0004) ncmd 1
         Status: Success (0x00)
         Page: 1/1
         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Set Event Mask (0x03|0x0001) plen 8 [hci0] 593.337694
         Mask: 0x3dbff807fffbffff
           Inquiry Complete
           Inquiry Result
           Connection Complete
           Connection Request
           Disconnection Complete
           Authentication Complete
           Remote Name Request Complete
           Encryption Change
           Change Connection Link Key Complete
           Master Link Key Complete
           Read Remote Supported Features Complete
           Read Remote Version Information Complete
           QoS Setup Complete
           Command Complete
           Command Status
           Hardware Error
           Flush Occurred
           Role Change
           Mode Change
           Return Link Keys
           PIN Code Request
           Link Key Request
           Link Key Notification
           Loopback Command
           Data Buffer Overflow
           Max Slots Change
           Read Clock Offset Complete
           Connection Packet Type Changed
           QoS Violation
           Page Scan Mode Change
           Page Scan Repetition Mode Change
           Flow Specification Complete
           Inquiry Result with RSSI
           Read Remote Extended Features Complete
           Synchronous Connection Complete
           Synchronous Connection Changed
           Sniff Subrating
           Extended Inquiry Result
           Encryption Key Refresh Complete
           IO Capability Request
           IO Capability Request Reply
           User Confirmation Request
           User Passkey Request
           Remote OOB Data Request
           Simple Pairing Complete
           Link Supervision Timeout Changed
           Enhanced Flush Complete
           User Passkey Notification
           Keypress Notification
           Remote Host Supported Features Notification
           LE Meta
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.339602
       Set Event Mask (0x03|0x0001) ncmd 1
         Status: Success (0x00)
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7 [hci0] 593.339624
         Address: 00:00:00:00:00:00 (OUI 00-00-00)
         Delete all: 0x01
 > HCI Event: Command Complete (0x0e) plen 6 [hci0] 593.340654
       Delete Stored Link Key (0x03|0x0012) ncmd 1
         Status: Success (0x00)
         Num keys: 0
< HCI Command: Write Default Link Pol.. (0x02|0x000f) plen 2 [hci0] 
593.340693
         Link policy: 0x0007
           Enable Role Switch
           Enable Hold Mode
           Enable Sniff Mode
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.341653
       Write Default Link Policy Settings (0x02|0x000f) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0 [hci0] 
593.341691
 > HCI Event: Command Complete (0x0e) plen 8 [hci0] 593.342656
       Read Page Scan Activity (0x03|0x001b) ncmd 1
         Status: Success (0x00)
         Interval: 1280.000 msec (0x0800)
         Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0 [hci0] 593.342695
 > HCI Event: Command Complete (0x0e) plen 5 [hci0] 593.343655
       Read Page Scan Type (0x03|0x0046) ncmd 1
         Status: Success (0x00)
         Type: Standard Scan (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8 [hci0] 593.343694
         Mask: 0x000000000000001f
           LE Connection Complete
           LE Advertising Report
           LE Connection Update Complete
           LE Read Remote Used Features Complete
           LE Long Term Key Request
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.344654
       LE Set Event Mask (0x08|0x0001) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Read Advertising Ch.. (0x08|0x0007) plen 0 [hci0] 
593.344695
 > HCI Event: Command Complete (0x0e) plen 5 [hci0] 593.345621
       LE Read Advertising Channel TX Power (0x08|0x0007) ncmd 1
         Status: Success (0x00)
         TX power: 4 dBm
@ Index Added
@ Device Unblocked: 00:00:00:00:00:00 (0)
@ New Settings: 0x0082
             connectable br/edr
@ New Settings: 0x0092
             connectable bondable br/edr
@ New Settings: 0x00d2
             connectable bondable ssp br/edr
@ New Settings: 0x02d2
             connectable bondable ssp br/edr le
@ Local Name Changed: ubuntu-0 ()
< HCI Command: Write Simple Pairing M.. (0x03|0x0056) plen 1 [hci0] 
593.350250
         Mode: Enabled (0x01)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.405656
       Write Simple Pairing Mode (0x03|0x0056) ncmd 1
         Status: Success (0x00)
< HCI Command: Write LE Host Supported (0x03|0x006d) plen 2 [hci0] 
593.405703
         Supported: 0x01
         Simultaneous: 0x00
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.406653
       Write LE Host Supported (0x03|0x006d) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32 [hci0] 
593.406691
         Length: 3
         TX power: 4 dBm
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.407655
       LE Set Advertising Data (0x08|0x0008) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Scan Response... (0x08|0x0009) plen 32 [hci0] 
593.407692
         Length: 10
         Name (complete): ubuntu-0
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.408613
       LE Set Scan Response Data (0x08|0x0009) ncmd 1
         Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1 [hci0] 593.408629
         Scan enable: Page Scan (0x02)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.409602
       Write Scan Enable (0x03|0x001a) ncmd 1
         Status: Success (0x00)
< HCI Command: Write Class of Device (0x03|0x0024) plen 3 [hci0] 593.409628
         Class: 0x600100
           Major class: Computer (desktop, notebook, PDA, organizers)
           Minor class: Uncategorized, code for device not assigned
           Audio (Speaker, Microphone, Headset)
           Telephony (Cordless telephony, Modem, Headset)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.410586
       Write Class of Device (0x03|0x0024) ncmd 1
         Status: Success (0x00)
< HCI Command: Write Local Name (0x03|0x0013) plen 248 [hci0] 593.410613
         Name: ubuntu-0
@ Class of Device Changed: 0x600100
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.412598
       Write Local Name (0x03|0x0013) ncmd 1
         Status: Success (0x00)
< HCI Command: Write Extended Inqui.. (0x03|0x0052) plen 241 [hci0] 
593.412616
         FEC: Not required (0x00)
         Name (complete): ubuntu-0
         TX power: 0 dBm
         16-bit Service UUIDs (complete): 6 entries
           SIM Access (0x112d)
           Headset AG (0x1112)
           Handsfree Audio Gateway (0x111f)
           Handsfree (0x111e)
           A/V Remote Control Target (0x110c)
           A/V Remote Control (0x110e)
 > HCI Event: Command Complete (0x0e) plen 4 [hci0] 593.413601
       Write Extended Inquiry Response (0x03|0x0052) ncmd 1
         Status: Success (0x00)
@ New Settings: 0x02d3
             powered connectable bondable ssp br/edr le

miguel@vaio:~$ rfkill list 1
1: sony-bluetooth: Bluetooth
     Soft blocked: no
     Hard blocked: no
miguel@vaio:~$ dmesg|tail -8
[  806.862729] usb 1-4: new full-speed USB device number 5 using xhci_hcd
[  806.992853] usb 1-4: New USB device found, idVendor=0489, idProduct=e062
[  806.992858] usb 1-4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[  806.992861] usb 1-4: Product: BCM43142A0
[  806.992863] usb 1-4: Manufacturer: Broadcom Corp
[  806.992865] usb 1-4: SerialNumber: 3C77E6DC7494
[  806.997694] Bluetooth: hci0: BCM: patching hci_ver=06 hci_rev=0000 
lmp_ver=06 lmp_subver=210b
[  807.453541] Bluetooth: hci0: BCM: firmware hci_ver=06 hci_rev=00b6 
lmp_ver=06 lmp_subver=210b

> This could be just a timing issue between some of the commands, but I would need to figure out when that happens and why such command takes longer. One other option is to increase the HCI_INIT_TIMEOUT in the kernel and see if that does help.

Given the last feedback, it does not seem raising the HCI_INIT_TIMEOUT 
should help, but I will try it if you insist.
>> 8. I rebooted into Linux again (no Windows this time), and the BT adapter is now recognized and fully working ("hcitool scan" shows all the BT devices around). Dmesg shows no errors this time but this two new messages:
>>
>> [   15.107318] Bluetooth: hci0: BCM: patching hci_ver=06 hci_rev=00b6 lmp_ver=06 lmp_subver=210b
>> [   15.567138] Bluetooth: hci0: BCM: firmware hci_ver=06 hci_rev=00b6 lmp_ver=06 lmp_subver=210b
>>
>> Thus, there is no need to boot Windows before Linux if the .hcd file is present, but you still need to boot Linux twice in order for the BT adapter to work properly:
> You should also see these two lines for the first time when booting into Linux. The hci_rev should change after loading the firmware.

No, the patching/firmware messages are not displayed the first time 
Linux is booted (look at the first dmesg output in this email).

Regards,
Miguel
