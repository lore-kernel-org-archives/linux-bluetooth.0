Return-Path: <chris2553@googlemail.com>
Subject: Re: 4.5 Regression - mouse not working after resume from suspend
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
References: <56B5B0C3.6050208@googlemail.com>
 <56B5DB29.9040208@googlemail.com> <56B5F2B1.5010000@googlemail.com>
 <20160206143300.GA18790@t440s.P-661HNU-F1>
From: Chris Clayton <chris2553@googlemail.com>
Message-ID: <56B61000.6060008@googlemail.com>
Date: Sat, 6 Feb 2016 15:23:44 +0000
MIME-Version: 1.0
In-Reply-To: <20160206143300.GA18790@t440s.P-661HNU-F1>
Content-Type: multipart/mixed;
 boundary="------------090603010801060403030009"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090603010801060403030009
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hi Johan,

The information you requested has been captured from v4.5-rc2-340-g5af9c2e and is included below.

On 06/02/16 14:33, Johan Hedberg wrote:
> Hi Chris,
> 
> On Sat, Feb 06, 2016, Chris Clayton wrote:
>> On 06/02/16 11:38, Chris Clayton wrote:
>>> On 06/02/16 08:37, Chris Clayton wrote:
>>>> There seems to be a regression in resuming my laptop from a suspend
>>>> to RAM or disk. The symptom is that my bluetooth
>>>> mouse doesn't work after the resume. The kernel is built after a
>>>> pull of Linus' tree this morning (v4.5-rc2-340-g5af9c2e).
>>>>
>>>> Attached is the output from dmesg showing the boot, suspend (to
>>>> RAM) and resume. You'll see that during the resume,
>>>> error -517 is being reported for some devices. Suspend/resume has worked perfectly with a 4.[234].x kernels.
>>>>
>>>> I'll start a bisection, but thought I'd give a heads up in case
>>>> someone can see the problem before I get done with the
>>>> bisect.
>>>
>>> The bisection ended up at:
>>>
>>> 2ff13894cfb877cb3d02d96a8402202f0a6f3efd is the first bad commit
>>> commit 2ff13894cfb877cb3d02d96a8402202f0a6f3efd
>>> Author: Johan Hedberg <johan.hedberg@intel.com>
>>> Date:   Wed Nov 25 16:15:44 2015 +0200
>>>
>>>     Bluetooth: Perform HCI update for power on synchronously
>>>
>>>     The request to update HCI during power on is always coming either from
>>>     hdev->req_workqueue or through an ioctl, so it's safe to use
>>>     hci_req_sync for it. This way we also eliminate potential races with
>>>     incoming mgmt commands or other actions while powering on.
>>>
>>>     Part of this refactoring is the splitting of mgmt_powered() into
>>>     mgmt_power_on() and __mgmt_power_off() functions. The main reason is
>>>     the different requirements as far as hdev locking is concerned, as
>>>     highlighted with the __ prefix of the power off API.
>>>
>>>     Since the power on in the case of clearing the AUTO_OFF flag cannot be
>>>     done synchronously in the set_powered mgmt handler, the hci_power_on
>>>     work callback is extended to cover this (which also simplifies the
>>>     set_powered helper a lot).
>>>
>>>     Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>>>     Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>>
>>> :040000 040000 a093d0be66f39f99c33a6a4725b2330ca9b41d03 a1eff79cec3ee7208e5aa200ab5069726bbeea8e M      include
>>> :040000 040000 d2d122193b33d45fcb9c2bc69f2024487a7528a0 0036e1ec2e125f2432cfd420b5f79ca133ec34f7 M      net
>>
>> I've just built a kernel at bf943cbf76ecd3b9838a80d5e08777b0f4ccc665
>> (the commit prior to the one the bisect landed on)
>> and my BT mouse works fine after a suspend/resume. With a kernel built
>> at 2ff13894cfb877cb3d02d96a8402202f0a6f3efd, the mouse does not work
>> after resume.
> 
> I've moved the thread over to the linux-bluetooth list, since that's where
> Bluetooth issues are primarily discussed. You had already removed the dmesg
> output by the time you added me to the thread so I'll copy the relevant
> (Bluetooth related) parts here that I found in the online archives:
> 
> [    5.314851] Bluetooth: hci0: read Intel version: 3707100180012d0d1a
> [    5.315569] Bluetooth: hci0: Intel device is already patched. patch num: 1a
> [   61.566028] Bluetooth: HIDP socket layer initialized
> [   61.566498] hid-generic 0005:0A5C:0001.0001: unknown main item tag 0x0
> [   61.566540] input: Bluetooth 3.0 mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-7/3-7:1.0/bluetooth/hci0/hci0:256/0005:0A5C:0001.0001/input/input15
> [   61.566644] hid-generic 0005:0A5C:0001.0001: input: BLUETOOTH HID v1.29 Mouse [Bluetooth 3.0 mouse] on 80:19:34:5a:67:51
> [  122.711385] Bluetooth: hci0: read Intel version: 3707100180012d0d00
> [  122.744439] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
> [  122.895434] Bluetooth: hci0: Intel Bluetooth firmware patch completed and activated
> 
> There's some more information needed to investigate this further:
> 
>  - What's the state of Bluetooth on your machine after resume? If you do
>    "hciconfig" does it show hci0 as being "UP"? Does it show "PSCAN"
>    being enabled? (assuming your mouse is a BR/EDR one)

hci0:   Type: BR/EDR  Bus: USB
        BD Address: 80:19:34:5A:67:51  ACL MTU: 1021:5  SCO MTU: 96:6
        DOWN
        RX bytes:1139 acl:0 sco:0 events:122 errors:0
        TX bytes:17708 acl:0 sco:0 commands:121 errors:0

>  - Do you see any errors from bluetoothd when you suspend/resume?

Feb  6 15:06:24 laptop bluetoothd[888]: Endpoint unregistered: sender=:1.37 path=/MediaEndpoint/A2DPSource
Feb  6 15:06:24 laptop bluetoothd[888]: Endpoint unregistered: sender=:1.37 path=/MediaEndpoint/A2DPSink
Feb  6 15:06:25 laptop bluetoothd[888]: Failed to obtain handles for "Service Changed" characteristic
Feb  6 15:06:25 laptop bluetoothd[888]: Endpoint registered: sender=:1.37 path=/MediaEndpoint/A2DPSource
Feb  6 15:06:25 laptop bluetoothd[888]: Endpoint registered: sender=:1.37 path=/MediaEndpoint/A2DPSink

>  - Could you provide the HCI log from btmon for what happens when you
>    suspend/resume (just keep btmon running over this time)

That log's a bit long, so I've attached it.

Hope this helps. Thanks

Chris
> 
> Thanks.
> 
> Johan
> 

--------------090603010801060403030009
Content-Type: text/x-log;
 name="no-bt-mouse-after-s2r-4.5.0-rc2+.btmon.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="no-bt-mouse-after-s2r-4.5.0-rc2+.btmon.log"

Bluetooth monitor ver 5.37
= Note: Linux version 4.5.0-rc2+ (x86_64)                              0.289000
= Note: Bluetooth subsystem version 2.21                               0.289001
= New Index: 80:19:34:5A:67:51 (BR/EDR,USB,hci0)                [hci0] 0.289002
= Open Index: 80:19:34:5A:67:51                                 [hci0] 0.289002
= Index Info: 80:19:34:5A:67:51 (Intel Corp.)                   [hci0] 0.289002
@ Class of Device Changed: 0x000000
@ New Settings: 0x0ad0
            bondable ssp br/edr le secure-conn 
@ Index Removed
= Close Index: 80:19:34:5A:67:51                               [hci0] 20.456125
= Delete Index: 80:19:34:5A:67:51                              [hci0] 20.456128
= bluetoothd: Endpoint unregistered: sender=:1.37 path=/MediaEndp..   21.820780
= bluetoothd: Endpoint unregistered: sender=:1.37 path=/MediaEndp..   21.820800
= New Index: 00:00:00:00:00:00 (BR/EDR,USB,hci0)               [hci0] 21.949051
= Open Index: 00:00:00:00:00:00                                [hci0] 21.949106
= Index Info: 00:00:00:00:00:00 (Intel Corp.)                  [hci0] 21.949108
< HCI Command: Reset (0x03|0x0003) plen 0                      [hci0] 21.949161
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 21.960445
      Reset (0x03|0x0003) ncmd 2
        Status: Success (0x00)
< HCI Command: Intel Read Version (0x3f|0x0005) plen 0         [hci0] 21.960481
> HCI Event: Command Complete (0x0e) plen 13                   [hci0] 21.961462
      Intel Read Version (0x3f|0x0005) ncmd 1
        Status: Success (0x00)
        Hardware platform: 0x37
        Hardware variant: 0x07
        Hardware revision: 1.0
        Firmware variant: 0x01
        Firmware revision: 8.0
        Firmware build: 1-45.2013
        Firmware patch: 0
< HCI Command: Intel Manufacturer Mode (0x3f|0x0011) plen 2    [hci0] 21.986844
        Mode switch: Enabled (0x01)
        Reset behavior: No reset (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 21.987456
      Intel Manufacturer Mode (0x3f|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 10        [hci0] 21.987587
        Address: 0x08000100
        Mode: Byte access (0x00)
        Length: 4
        01 2d 0d 1a                                      .-..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 21.988456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 21.988587
        Address: 0x21000000
        Mode: Byte access (0x00)
        Length: 244
        c0 30 e0 78 ac 48 00 00 73 d5 0b 8d 07 e8 d2 0f  .0.x.H..s.......
        a8 05 00 20 74 06 00 20 d0 2e 00 08 08 06 00 20  ... t.. ....... 
        12 d0 0c 80 1d 78 e0 7f c0 b8 e0 78 04 48 00 00  .....x.....x.H..
        06 a1 01 f0 20 20 80 0f 00 08 d8 01 80 e5 b0 08  ....  ..........
        e0 7f c1 c5 94 48 00 00 83 e1 ca 21 81 00 14 21  .....H.....!...!
        9b d0 9c d5 14 48 00 00 98 d0 24 80 21 ad 28 b9  .....H....$.!.(.
        60 d0 20 20 80 0f 00 08 40 02 02 d8 00 aa 21 aa  `.  ....@.....!.
        e0 7e e0 78 1c 48 00 00 c0 2a 1a 70 5a 71 48 77  .~.x.H...*.pZqHw
        e0 7f 05 88 20 48 00 00 c0 2a 08 76 47 09 9e 00  .... H...*.vG...
        18 48 00 00 3a 0d a0 2a 9a d9 67 d0 32 0d a0 2a  .H..:..*..g.2..*
        0c 48 00 00 ce 08 0f ff 22 0c 6f fb 00 87 e5 02  .H......".o.....
        02 d8 03 f0 01 d8 09 ad d1 02 c0 26 10 48 00 00  ...........&.H..
        02 f0 00 d8 5d 02 00 26 08 48 00 00 8f f7 e1 b8  ....]..&.H......
        02 16 fb 77 28 48 00 00 98 10 c1 c7 c1 c6 e0 7f  ...w(H..........
        24 48 00 00 cf 73 00 30 18 44 f4 23 83 03 86 22  $H...s.0.D.#..."
        2c 48 00 00                                      ,H..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 21.990456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 21.990585
        Address: 0x210000f4
        Mode: Byte access (0x00)
        Length: 244
        00 00 68 81 09 81 48 81 70 72 0c 00 58 0f e0 7e  ..h...H.pr..X..~
        44 48 00 00 e1 c7 fc 1c 08 b4 fc 1c c1 c6 e0 7f  DH..............
        c1 c5 e0 78 5c 48 00 00 e1 c7 fc 1c 50 48 00 00  ...x\H......PH..
        b0 18 00 01 6e 1d c2 81 6f 1d 02 81 e0 7f 00 d8  ....n...o.......
        6c 48 00 00 27 08 f3 01 39 70 40 29 c1 c7 c1 c6  lH..'...9p@)....
        e0 7f c1 c5 68 48 00 00 e1 c7 fc 1c 64 48 00 00  ....hH......dH..
        e1 c7 fc 1c 08 b4 fc 1c 48 b4 fc 1c 54 48 00 00  ........H...TH..
        00 16 86 70 00 30 56 01 dc fd 0a 27 20 20 80 0f  ...p.0V....'  ..
        00 08 4c 04 38 d8 ea 0e 6f fe 0a 72 8e e8 20 20  ..L.8...o..r..  
        80 0f 00 08 62 04 50 87 da b8 34 7a 20 1e 42 10  ....b.P...4z .B.
        fd 03 40 1b 40 48 00 00 40 1b 00 dd c1 c7 c1 c6  ..@.@H..@.......
        e0 7f c1 c5 60 48 00 00 e1 c7 fc 1c e0 7f c1 c5  ....`H..........
        58 48 00 00 e1 c7 fc 1c 08 b4 fc 1c db 1e 42 13  XH............B.
        3c 48 00 00 cf 72 00 30 48 5e 68 1a c1 c6 e0 7f  <H...r.0H^h.....
        c1 c5 e0 78 48 48 00 00 e1 c7 fc 1c 4c 48 00 00  ...xHH......LH..
        81 10 04 e0                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 21.992457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 21.992583
        Address: 0x210001e8
        Mode: Byte access (0x00)
        Length: 244
        22 78 00 18 00 20 06 86 60 15 a2 c0 b4 48 00 00  "x... ..`....H..
        60 15 98 73 a1 c1 3a 71 b8 48 00 00 80 14 ed 08  `..s..:q.H......
        f3 01 08 77 1b 17 0e f6 29 06 80 14 bc 48 00 00  ...w....)....H..
        80 14 21 d0 00 88 a1 c1 8c 48 00 00 86 0d 20 01  ..!......H.... .
        41 d9 8a 20 0c 02 d6 0f 08 b1 e0 78 80 48 00 00  A.. .......x.H..
        a0 13 4f d9 a3 d6 c9 70 92 82 d6 f1 70 48 00 00  ..O....p....pH..
        60 13 ff d9 a3 c1 8b 70 f2 f3 01 d8 02 f0 00 d8  `......p........
        79 02 40 13 78 48 00 00 7f 08 10 00 74 48 00 00  y.@.xH......tH..
        43 0b 68 71 8a fd b9 e8 d1 04 8f ff 7c 48 00 00  C.hq........|H..
        11 fd ff d9 2b 08 40 00 90 48 00 00 82 20 c3 08  ....+.@..H... ..
        be 0e 6f ff a9 71 80 e0 88 0f 82 ff bd 07 8f ff  ..o..q..........
        84 48 00 00 6a 0a e0 00 35 dd 20 87 34 79 00 20  .H..j...5. .4y. 
        40 20 01 88 02 71 a0 b8 c0 f1 03 8f 88 48 00 00  @ ...q.......H..
        00 ae 52 0d 2f f1 82 c1 e2 0b af fb 00 8d de 08  ..R./...........
        4f fb 80 e0 34 48 00 00 38 48 00 00 f0 20 40 00  O...4H..8H... @.
        fd b8 d1 20                                      ...             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 21.994456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 202       [hci0] 21.994586
        Address: 0x210002dc
        Mode: Byte access (0x00)
        Length: 196
        a1 86 d1 20 2f fb c9 70 20 20 80 0f 00 08 fa 02  ... /..p  ......
        40 20 00 d8 23 7b d7 70 00 00 24 7b 40 03 02 00  @ ..#{.p..${@...
        30 48 00 00 e0 7f 01 d8 e0 7f 80 d8 00 48 00 00  0H...........H..
        04 80 e0 78 2e 0e 60 02 0a 70 e0 78 a0 48 00 00  ...x..`..p.x.H..
        e0 78 08 b8 40 d0 0c 1f 44 03 a9 71 08 f0 e0 78  .x..@...D..q...x
        a0 a8 3f d0 b0 48 00 00 9a d6 00 dd 07 f0 f0 22  ..?..H........."
        40 03 f2 0f 20 d5 00 85 98 48 00 00 00 00 18 e0  @... ....H......
        16 0e a0 00 0b f0 38 17 00 f0 00 88 9c 48 00 00  ......8......H..
        c2 d1 e1 d1 00 d9 ab 17 00 f6 97 00 ef ff 2e a8  ................
        a8 48 00 00 c9 70 0b f0 0a 09 8f d3 20 20 80 0f  .H...p......  ..
        00 08 5e 05 8b 07 8f ff a4 48 00 00 65 17 0d f6  ..^......H..e...
        08 85 80 e0 26 09 ef ec e9 70 00 c2 20 20 80 0f  ....&....p..  ..
        00 08 e0 01                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 21.996456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 242       [hci0] 21.996588
        Address: 0x92000020
        Mode: Byte access (0x00)
        Length: 236
        65 00 00 00 84 00 00 00 d0 04 00 00 23 05 00 00  e...........#...
        07 06 00 00 f9 0a 00 00 05 0c 00 00 35 0c 00 00  ............5...
        5b 0c 00 00 e7 0c 00 00 d9 10 00 00 5d 14 00 00  [...........]...
        e4 15 00 00 3c 1a 00 00 66 1a 00 00 13 1b 00 00  ....<...f.......
        44 20 00 00 b6 25 00 00 54 27 00 00 6a 27 00 00  D ...%..T'..j'..
        7b 27 00 00 c4 27 00 00 f0 27 00 00 25 2a 00 00  {'...'...'..%*..
        34 2a 00 00 4a 2b 00 00 16 2c 00 00 29 2c 00 00  4*..J+...,..),..
        a4 2d 00 00 4c 35 00 00 ee 35 00 00 2b 37 00 00  .-..L5...5..+7..
        98 38 00 00 a7 38 00 00 d6 3a 00 00 f3 3a 00 00  .8...8...:...:..
        14 3b 00 00 62 3b 00 00 7a 3b 00 00 9a 3b 00 00  .;..b;..z;...;..
        f1 3b 00 00 57 3f 00 00 31 40 00 00 30 41 00 00  .;..W?..1@..0A..
        52 45 00 00 b0 46 00 00 01 4d 00 00 50 4d 00 00  RE...F...M..PM..
        1f 58 00 00 61 58 00 00 6d 58 00 00 c4 5b 00 00  .X..aX..mX...[..
        e2 5b 00 00 9a 5c 00 00 ef 5d 00 00 f6 5d 00 00  .[...\...]...]..
        00 5e 00 00 46 5e 00 00 ff 7f 00 00              .^..F^......    
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 21.998457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 50        [hci0] 21.998586
        Address: 0x08005600
        Mode: Byte access (0x00)
        Length: 44
        08 01 00 92 a0 03 00 21 00 00 00 00 00 00 00 00  .......!........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00              ............    
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 21.999456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 21.999587
        Address: 0x08000100
        Mode: Byte access (0x00)
        Length: 244
        ef be ad de 00 00 00 00 42 ef be 42 14 01 00 08  ........B..B....
        00 00 00 00 24 06 00 08 38 06 00 08 fc 01 00 08  ....$...8.......
        f0 07 00 08 06 02 00 08 10 02 00 08 22 02 00 08  ............"...
        2c 02 00 08 36 02 00 08 74 02 00 08 c8 02 00 08  ,...6...t.......
        f0 02 00 08 20 03 00 08 32 03 00 08 72 03 00 08  .... ...2...r...
        84 03 00 08 a8 12 00 08 f6 03 00 08 00 04 00 08  ................
        0a 04 00 08 28 04 00 08 42 04 00 08 60 1a 00 08  ....(...B...`...
        28 17 00 08 6c 19 00 08 40 1d 00 08 d0 1b 00 08  (...l...@.......
        e0 1c 00 08 88 04 00 08 94 04 00 08 c4 04 00 08  ................
        d0 04 00 08 dc 04 00 08 e8 04 00 08 f4 04 00 08  ................
        08 05 00 08 1c 05 00 08 54 05 00 08 78 05 00 08  ........T...x...
        8c 05 00 08 c4 05 00 08 ee 05 00 08 f8 05 00 08  ................
        02 06 00 08 0c 06 00 08 5c 2f 00 08 84 30 00 08  ........\/...0..
        b4 31 00 08 ad de e1 fe 20 20 80 0f 00 08 a0 06  .1......  ......
        e1 c2 22 20 80 0f 02 20 78 8b c1 c2 04 c0 05 7a  .." ... x......z
        01 c1 05 c0                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.001456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.001587
        Address: 0x080001f4
        Mode: Byte access (0x00)
        Length: 244
        20 20 80 0f 05 20 70 e4 a1 c0 20 20 80 0f 00 08    ... p...  ....
        10 07 a1 c0 20 20 80 0f 00 08 74 08 a1 c0 22 20  ....  ....t..." 
        80 0f 00 08 28 0e 20 20 80 0f 00 20 b4 c0 a1 c0  ....(.  ... ....
        20 20 80 0f 00 08 78 09 a1 c0 20 20 80 0f 00 08    ....x...  ....
        d4 09 a1 c0 20 20 80 0f 00 08 8c 0c 01 d9 0a 22  ....  ........."
        80 0f 00 30 78 3c 20 a8 fc 1c 08 b0 fc 1c 48 b0  ...0x< .......H.
        fc 1c 88 b0 22 20 80 0f 00 08 5c 0f 04 14 02 34  ...." ....\....4
        04 14 01 34 04 14 00 34 20 20 80 0f 00 20 5a c0  ...4...4  ... Z.
        a1 c0 84 e6 cc 26 22 92 0e f4 db 1d 98 1f a0 8e  .....&".........
        04 01 f8 1d 98 1f 04 00 00 10 f9 1d 98 1f 16 00  ................
        da 36 14 f0 0d 0e 50 10 21 0e 91 10 1d 0f 93 10  .6....P.!.......
        db 1d 98 1f a0 8e 04 31 f8 1d 98 1f 28 00 83 20  .......1....(.. 
        f9 1d 98 1f 15 00 d2 b6 d4 15 02 10 20 20 80 0f  ............  ..
        01 20 64 a6 a1 c0 89 ba 73 1d 98 10 87 1d 98 1f  . d.....s.......
        b5 00 00 34 71 15 02 16 05 22 82 0f 00 00 00 80  ...4q...."......
        71 1d 98 10                                      q...            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.003456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.003587
        Address: 0x080002e8
        Mode: Byte access (0x00)
        Length: 244
        20 20 80 0f 01 20 ca a3 a1 c0 20 20 80 0f 00 08    ... ....  ....
        8c 0f 80 e5 12 00 21 00 4a 20 40 20 20 20 80 0f  ......!.J @   ..
        04 20 1e d0 e0 78 0a 25 80 1f 00 30 a1 11 20 20  . ...x.%...0..  
        80 0f 04 20 cc d2 e0 78 a1 c0 22 20 80 0f 00 08  ... ...x.." ....
        14 10 20 20 80 0f 04 20 06 d8 a1 c0 e1 c0 22 d8  ..  ... ......".
        22 20 80 0f 04 20 b0 24 08 71 c1 c0 27 09 51 00  " ... .$.q..'.Q.
        80 e0 e0 20 81 0f 04 20 38 55 5a 08 40 01 17 08  ... ... 8UZ.@...
        10 00 0a 20 80 0f 00 08 b8 3a 20 20 80 0f 04 20  ... .....:  ... 
        3c 55 20 20 80 0f 04 20 26 56 a1 c0 22 20 80 0f  <U  ... &V.." ..
        00 08 c8 11 20 20 80 0f 04 20 18 6d a1 c0 db 1e  ....  ... .m....
        42 13 fc 1c 08 b0 fc 1c 48 b0 fc 1c 88 b0 fc 1c  B.......H.......
        c8 b0 fc 1c 08 b1 fc 1c 48 b1 fc 1c 88 b1 fc 1c  ........H.......
        c8 b1 fc 1c 08 b2 fc 1c 48 b2 fc 1c 88 b2 fc 1c  ........H.......
        c8 b7 62 0e 40 00 04 14 1f 34 04 14 0a 34 04 14  ..b.@....4...4..
        09 34 04 14 08 34 04 14 07 34 04 14 06 34 04 14  .4...4...4...4..
        05 34 04 14                                      .4..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.005456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.005586
        Address: 0x080003dc
        Mode: Byte access (0x00)
        Length: 244
        04 34 04 14 03 34 04 14 02 34 04 14 01 34 04 14  .4...4...4...4..
        00 34 20 20 80 0f 02 20 48 da a1 c0 20 20 80 0f  .4  ... H...  ..
        00 08 60 13 a1 c0 20 20 80 0f 00 08 f4 14 a1 c0  ..`...  ........
        3c 16 80 10 08 e8 00 86 35 16 81 10 20 20 80 0f  <.......5...  ..
        03 20 e6 5e 20 20 80 0f 03 20 ee 5e a1 c0 fc 1c  . .^  ... .^....
        08 b1 4a 24 40 00 ac 18 00 01 04 14 04 34 20 20  ..J$@........4  
        80 0f 02 20 44 75 a1 c0 20 20 80 0f 00 08 3c 1b  ... Du..  ....<.
        1e 10 01 21 01 e1 38 60 28 8e 53 20 90 06 20 20  ...!..8`(.S ..  
        80 0f 02 20 58 a2 cf 70 00 30 06 0f 00 88 22 20  ... X..p.0...." 
        80 0f 03 20 60 47 1c 10 01 01 03 86 38 60 8b 17  ... `G......8`..
        01 17 50 87 20 20 80 0f 02 20 4c a3 a1 c0 20 20  ..P.  ... L...  
        80 0f 00 08 60 26 e0 78 a1 c0 cf 70 00 30 c0 64  ....`&.x...p.0.d
        c7 70 00 00 7e 01 68 71 22 20 80 0f 03 20 d4 ad  .p..~.hq" ... ..
        80 e0 e0 20 81 0f 03 20 1e b8 8a 70 82 20 43 0b  ... ... ...p. C.
        20 20 80 0f 03 20 aa b7 a1 c0 20 20 80 0f 00 08    ... ....  ....
        b0 29 e0 78                                      .).x            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.007457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.007587
        Address: 0x080004d0
        Mode: Byte access (0x00)
        Length: 244
        a1 c0 20 20 80 0f 00 08 64 2a e0 78 a1 c0 20 20  ..  ....d*.x..  
        80 0f 00 08 c4 2a e0 78 a1 c0 20 20 80 0f 00 08  .....*.x..  ....
        dc 20 e0 78 a1 c0 22 20 80 0f 00 08 50 21 08 77  . .x.." ....P!.w
        20 20 80 0f 04 20 14 14 a1 c0 22 20 80 0f 00 08    ... ...." ....
        28 23 08 75 20 20 80 0f 03 20 b8 ad a1 c0 08 77  (#.u  ... .....w
        cf 71 00 30 c0 64 32 21 80 0f 00 00 8d 01 0f 78  .q.0.d2!.......x
        32 21 81 0f 00 00 8e 01 2f 79 13 08 43 00 09 0b  2!....../y..C...
        d1 00 00 db 07 0f d1 10 00 df c9 70 20 20 80 0f  ...........p  ..
        03 20 14 bf a1 c0 20 20 80 0f 00 08 0c 2c 21 85  . ....  .....,!.
        22 78 11 08 33 00 02 a5 c7 70 ff 07 ff ff 02 a5  "x..3....p......
        20 20 80 0f 05 20 76 df a1 c0 22 20 80 0f 00 20    ... v..." ... 
        4c 07 20 20 80 0f 05 20 32 be e0 78 a1 c0 80 e0  L.  ... 2..x....
        2a 00 01 00 0a 20 80 0f 00 30 b8 12 00 10 00 00  *.... ...0......
        ac 10 00 00 18 10 00 08 ef b8 e2 20 82 0f 00 08  ........... ....
        3c 2e 22 20 80 0f 00 20 4c 07 20 20 80 0f 05 20  <." ... L.  ... 
        b6 c9 e0 78                                      ...x            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.009456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.009587
        Address: 0x080005c4
        Mode: Byte access (0x00)
        Length: 244
        a1 c0 0f 14 80 30 0e 14 81 30 fc 1c 48 b0 fc 1c  .....0...0..H...
        08 b0 22 20 80 0f 00 08 58 2e 04 14 00 34 04 14  .." ....X....4..
        01 34 20 20 80 0f 05 20 1e 86 a1 c0 20 20 80 0f  .4  ... ....  ..
        00 08 5c 2c a1 c0 20 20 80 0f 00 08 b4 2c a1 c0  ..\,..  .....,..
        20 20 80 0f 00 08 14 2f a1 c0 4f 26 d2 16 22 20    ...../..O&.." 
        80 0f 00 08 ec 2d 20 20 80 0f 05 20 44 bc e0 78  .....-  ... D..x
        a1 c0 20 20 80 0f 00 08 30 06 e0 7e e0 7f 01 d0  ..  ....0..~....
        01 2d 0d 1a a1 c0 20 20 80 0f 00 08 44 06 e0 7e  .-....  ....D..~
        f1 c0 e1 c5 13 d5 00 85 00 80 b0 10 00 00 00 80  ................
        08 e0 22 20 80 0f 05 20 38 d4 0f 08 1e 00 00 85  .." ... 8.......
        01 80 0f 08 5e 02 0c d0 00 88 0d 08 51 00 00 d9  ....^.......Q...
        28 70 04 f0 04 d8 05 d9 c2 b9 03 b9 c2 b8 25 78  (p............%x
        06 d1 7c 19 20 00 20 20 80 0f 06 20 b0 20 e0 78  ..|. .  ... . .x
        c4 12 00 30 24 3a 00 08 00 00 00 94 08 75 22 20  ...0$:.......u" 
        80 0f 00 20 ec 56 01 d8 22 20 80 0f 00 20 e4 22  ... .V.." ... ."
        80 e5 ca 20                                      ...             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.011457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.011588
        Address: 0x080006b8
        Mode: Byte access (0x00)
        Length: 244
        61 01 e2 20 81 0f 00 20 ec 42 16 ed 22 20 80 0f  a.. ... .B.." ..
        00 20 98 40 fc e8 32 d8 22 20 80 0f 00 20 ec 42  . .@..2." ... .B
        32 d8 22 20 80 0f 00 20 ec 42 32 d8 22 20 80 0f  2." ... .B2." ..
        00 20 ec 42 22 20 80 0f 00 20 8c 51 22 20 80 0f  . .B" ... .Q" ..
        00 20 ec 51 04 d1 18 11 00 08 91 b8 18 19 20 00  . .Q.......... .
        00 f0 e0 78 00 00 00 be 22 20 80 0f 00 20 74 52  ...x...." ... tR
        e1 b8 01 d8 ca 20 21 00 22 20 80 0f 00 20 e0 1f  ..... !." ... ..
        22 20 80 0f 05 20 8c 6e 22 20 80 0f 06 20 cc 1c  " ... .n" ... ..
        22 20 80 0f 05 20 98 e3 21 d2 ff d8 08 b8 08 12  " ... ..!.......
        01 08 04 79 28 b9 19 09 50 00 08 12 01 08 24 78  ...y(...P.....$x
        41 28 3e 82 e2 20 82 0f 05 20 04 fd 22 20 80 0f  A(>.. ... .." ..
        05 20 80 fb 22 20 80 0f 00 20 74 52 15 d1 01 da  . .." ... tR....
        82 e8 40 a9 14 d0 00 d9 14 d2 ff dd 4a 24 c0 71  ..@.........J$.q
        28 73 20 a8 a8 20 80 02 78 63 14 78 58 60 21 b0  (s .. ..xc.xX`!.
        20 b0 a4 a8 01 e3 6f 7b 22 20 80 0f 01 20 5c 5d   .....o{" ... \]
        fc e8 22 20                                      .."             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.013456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.013587
        Address: 0x080007ac
        Mode: Byte access (0x00)
        Length: 244
        80 0f 01 20 b4 5d 22 20 80 0f 05 20 dc 7e 22 20  ... .]" ... .~" 
        80 0f 00 08 e8 2c f0 f1 00 00 00 be fc 03 00 30  .....,.........0
        24 3a 00 08 68 3a 00 08 f1 c0 22 20 80 0f 05 20  $:..h:...." ... 
        b8 f4 22 d1 14 a9 22 20 80 0f 05 20 44 75 d1 c0  .."..." ... Du..
        e0 7e e0 78 a1 c0 20 20 80 0f 00 08 fc 07 e0 7e  .~.x..  .......~
        f1 c0 2a 08 00 00 89 e8 fb 75 c1 c5 20 20 80 0f  ..*......u..  ..
        01 20 98 0d 09 f0 fb 75 c1 c5 0c d9 61 c1 20 20  . .....u....a.  
        80 0f 01 20 94 0d e5 f1 f1 c0 e1 c5 d7 70 00 00  ... .........p..
        57 fc 01 d8 15 f4 0e d0 00 88 80 e0 0c d8 11 f2  W...............
        0c d1 57 d8 00 dd a9 72 22 20 80 0f 01 20 2c 5d  ..W....r" ... ,]
        09 d0 a9 71 22 20 80 0f 00 20 60 ee a9 70 20 20  ...q" ... `..p  
        80 0f 06 20 b0 20 e0 78 84 00 00 30 04 0e 00 30  ... . .x...0...0
        d4 07 00 08 57 fc 00 00 f1 c0 22 20 80 0f 06 20  ....W....." ... 
        28 20 8a 21 43 2f 0f 09 23 20 08 77 1b 00 20 00  ( .!C/..# .w.. .
        39 d5 e9 70 22 20 80 0f 00 20 00 d5 22 20 80 0f  9..p" ... .." ..
        00 20 58 d5                                      . X.            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.015457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.015583
        Address: 0x080008a0
        Mode: Byte access (0x00)
        Length: 244
        08 75 02 15 12 11 e9 70 04 15 10 11 22 20 80 0f  .u.....p...." ..
        04 20 48 0d 2b 08 81 0f 00 00 ff ff 22 20 80 0f  . H.+......." ..
        01 20 4c 42 89 e8 00 d8 b1 d9 a1 da 02 db 22 20  . LB.........." 
        80 0f 05 20 b0 76 22 20 80 0f 00 20 50 da 26 d6  ... .v" ... P.&.
        c9 71 22 20 80 0f 01 20 80 45 22 20 80 0f 00 20  .q" ... .E" ... 
        48 dd 04 1e 84 14 10 ae 00 1e 04 14 03 95 03 b6  H...............
        04 95 01 b6 09 8e 1b 08 d0 00 0d 08 91 00 0a 8e  ................
        0f 08 90 00 22 20 80 0f 00 20 c0 dd 0b e8 02 96  ...." ... ......
        04 20 80 0f ff ff f7 e3 02 b6 00 96 a3 b8 ac b8  . ..............
        00 b6 0f 0f 43 14 00 8d a7 b8 00 ad 05 f0 ff dc  ....C...........
        0e 27 00 13 01 e0 08 ae 22 20 80 0f 00 20 38 dd  .'......" ... 8.
        c9 71 03 a6 e9 70 22 20 80 0f 00 20 0c 71 a9 70  .q...p" ... .q.p
        22 20 80 0f 01 20 d0 46 20 20 80 0f 06 20 88 20  " ... .F  ... . 
        2c 43 00 30 38 43 00 30 f1 c0 e3 d0 9a d9 22 20  ,C.08C.0......" 
        80 0f 06 20 ac 23 e1 d0 3f d9 22 20 80 0f 06 20  ... .#..?." ... 
        ac 23 df d0                                      .#..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.017457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.017583
        Address: 0x08000994
        Mode: Byte access (0x00)
        Length: 244
        cc d9 22 20 80 0f 06 20 ac 23 dd d0 00 d9 20 a8  .." ... .#.... .
        dc d0 22 20 80 0f 00 08 c8 34 22 20 80 0f 00 08  .." .....4" ....
        e8 34 d9 d0 22 20 80 0f 00 08 c8 34 22 20 80 0f  .4.." .....4" ..
        00 08 e8 34 d5 d0 20 a8 d5 d0 2e a8 d1 c0 e0 7e  ...4.. ........~
        f1 c0 22 20 80 0f 06 20 28 20 3a 70 5a 71 48 77  .." ... ( :pZqHw
        84 e2 84 dc cc 27 02 93 58 f4 0a d9 02 f0 01 e1  .....'..X.......
        91 e1 8a 02 06 00 c5 d4 b2 69 b4 7d 9d 65 07 8d  .........i.}.e..
        f7 e8 16 d8 22 20 80 0f 00 20 d0 79 ff d9 03 ad  ...." ... .y....
        0f 08 41 00 00 d8 41 d9 8a 22 86 08 b3 f0 24 ad  ..A...A.."....$.
        06 1d 42 14 00 21 80 2f 00 00 01 0e 00 b5 04 da  ..B..!./........
        47 ad e7 bf 01 d8 ca 20 21 00 09 ad 48 ad 25 ad  G...... !...H.%.
        00 da 03 f0 01 e2 1f 0a d5 01 b6 d4 16 22 81 00  ............."..
        99 61 08 89 f1 08 1f 80 01 de 80 b8 08 a9 4f 78  .a............Ox
        0c f0 01 d8 46 d9 8a 22 45 0c 02 db 22 20 80 0f  ....F.."E..." ..
        05 20 b0 76 ce d8 01 de aa d4 02 ad 16 78 4a 71  . .v.........xJq
        9d 60 a9 70                                      .`.p            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.019457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.019584
        Address: 0x08000a88
        Mode: Byte access (0x00)
        Length: 244
        06 da 22 20 80 0f 06 20 a0 1e a6 d0 0a 88 ed 01  .." ... ........
        20 00 06 ad 80 e7 cc 27 a2 90 58 f4 09 d9 03 f0   ......'..X.....
        01 e1 8a e1 d2 01 06 00 97 d4 b2 69 b4 7d 9d 65  ...........i.}.e
        07 8d f8 e8 00 d9 03 f0 01 e1 8c e9 9a d4 14 21  ...............!
        40 00 72 20 02 03 fa ea 01 da 40 a8 2f 79 03 f0  @.r ......@./y..
        ff d9 ff de 22 ad 13 09 81 03 00 d8 46 d9 8a 22  ....".......F.."
        c7 0b 00 de 4e f0 03 d8 22 20 80 0f 00 20 d0 79  ....N..." ... .y
        03 ad 13 08 81 03 00 d8 41 d9 8a 22 07 0e 00 de  ........A.."....
        40 f0 2a 70 22 20 80 0f 00 20 2c c3 00 de 1a 70  @.*p" ... ,....p
        01 e6 cf 7e c9 70 2a 71 22 20 80 0f 00 20 f8 c2  ...~.p*q" ... ..
        f8 e8 02 76 c0 b5 04 d8 07 ad e8 ad 2a 70 22 20  ...v........*p" 
        80 0f 00 20 9c c2 22 8d 7c d4 05 1d 42 14 34 79  ... ..".|...B.4y
        9a 61 00 aa 01 de 9a f0 00 d8 03 f0 01 e0 87 e0  .a..............
        26 01 06 00 6c d6 b2 68 b4 7d b9 66 27 89 dd 65  &...l..h.}.f'..e
        f6 e9 02 d8 22 20 80 0f 00 20 d0 79 8a 20 c3 2f  ...." ... .y. ./
        03 ad 1d 08                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.021457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.021584
        Address: 0x08000b7c
        Mode: Byte access (0x00)
        Length: 244
        01 04 00 d8 41 d9 8a 22 48 07 08 76 02 db 22 20  ....A.."H..v.." 
        80 0f 05 20 b0 76 78 f0 10 d8 22 20 80 0f 00 20  ... .vx..." ... 
        d0 79 04 ad 0f 08 01 04 00 d8 41 d9 8a 22 48 09  .y........A.."H.
        ed f1 8a 20 04 00 05 f0 80 20 04 00 10 78 33 0e  ... ..... ...x3.
        02 70 00 00 00 0e 00 da 02 f0 01 e2 1b 0a 55 04  .p............U.
        72 6a 74 7b 79 66 27 89 db 63 79 e9 20 93 ef 08  rjt{yf'..cy. ...
        41 80 01 d9 02 f0 00 d9 e8 e9 01 de 0b f0 01 de  A...............
        c9 70 4a d9 e0 da 02 db 22 20 80 0f 05 20 b0 76  .pJ....." ... .v
        00 d8 00 b5 e6 bf 03 d8 ca 20 21 01 07 ad e7 bf  ......... !.....
        d1 27 a1 91 01 d8 ca 20 21 00 09 ad 01 d8 08 ad  .'..... !.......
        00 da 03 f0 01 e2 21 0a d5 01 38 d0 15 22 81 00  ......!...8.."..
        14 22 43 00 74 78 33 88 ed 09 1f 80 80 b9 33 a8  ."C.tx3.......3.
        4f 79 0b f0 01 d8 46 d9 c2 da 02 db 22 20 80 0f  Oy....F....." ..
        05 20 b0 76 ce d9 22 ad 05 1d 42 14 2b d5 15 21  . .v.."...B.+..!
        40 00 14 79 06 da 34 7d 40 25 40 13 4a 71 22 20  @..y..4}@%@.Jq" 
        80 0f 06 20                                      ...             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.023457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.023584
        Address: 0x08000c70
        Mode: Byte access (0x00)
        Length: 244
        a0 1e a9 70 22 20 80 0f 01 20 d0 46 02 f0 00 de  ...p" ... .F....
        c9 70 20 20 80 0f 06 20 88 20 e0 78 f1 c0 22 20  .p  ... . .x.." 
        80 0f 06 20 38 20 08 75 63 09 9e 00 0a d8 03 f0  ... 8 .uc.......
        01 e0 91 e0 7a 01 06 00 19 d4 d2 68 d4 7e 9e 66  ....z......h.~.f
        27 8e f1 0a 41 80 26 8e e9 0d 41 90 03 8e 22 20  '...A.&...A..." 
        80 0f 00 20 e4 79 8b e8 01 d8 42 d9 8a 22 ca 00  ... .y....B.."..
        02 db 22 20 80 0f 05 20 b0 76 02 8e 12 d1 16 78  .." ... .v.....x
        38 60 09 d9 22 20 80 0f 06 20 ac 23 c9 70 0c d9  8`.." ... .#.p..
        22 20 80 0f 06 20 ac 23 93 f0 d3 09 51 00 00 d9  " ... .#....Q...
        1b f0 e0 78 48 3e 00 30 28 3a 00 08 7c 3d 00 30  ...xH>.0(:..|=.0
        4a 0d 00 30 47 0d 00 30 48 0d 00 30 49 0d 00 30  J..0G..0H..0I..0
        dc 3d 00 30 28 3a 00 08 38 17 00 30 44 0d 00 30  .=.0(:..8..0D..0
        45 0d 00 30 01 e1 eb 09 d5 01 d4 17 0c f0 d2 69  E..0...........i
        d4 7e 9e 66 07 8e f1 0a 01 80 05 8e e9 0d 01 90  .~.f............
        03 8e 22 20 80 0f 00 20 e4 79 8b e8 01 d8 42 d9  .." ... .y....B.
        8a 22 8a 0c                                      ."..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.025456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.025584
        Address: 0x08000d64
        Mode: Byte access (0x00)
        Length: 244
        02 db 22 20 80 0f 05 20 b0 76 a9 70 22 20 80 0f  .." ... .v.p" ..
        00 20 64 c2 04 8e 22 20 80 0f 00 20 e4 79 8b e8  . d..." ... .y..
        01 d8 42 d9 8a 22 ca 0e 02 db 22 20 80 0f 05 20  ..B.."...." ... 
        b0 76 02 8e 6c 17 0d f0 15 20 01 00 34 78 14 25  .v..l.... ..4x.%
        00 10 16 d9 22 20 80 0f 06 20 ac 23 22 20 80 0f  ...." ... .#" ..
        00 20 ac c5 22 8e 0c e5 15 21 42 00 54 79 3b 7a  . .."....!B.Ty;z
        5d 65 00 ad 92 f1 09 d8 02 f0 01 e0 4f 08 95 02  ]e..........O...
        38 17 0c f0 d2 68 d4 7e 9e 66 27 8e ef 0a 41 80  8....h.~.f'...A.
        25 8e eb 0d 41 90 03 8e 22 20 80 0f 00 20 e4 79  %...A..." ... .y
        8a e8 01 d8 42 d9 8a 22 8b 07 02 db 22 20 80 0f  ....B.."...." ..
        05 20 b0 76 02 8e 24 17 0c f0 03 d9 14 78 98 60  . .v..$......x.`
        22 20 80 0f 06 20 ac 23 68 f1 20 20 80 0f 06 20  " ... .#h.  ... 
        a8 20 e0 78 f1 c0 22 20 80 0f 06 20 20 20 50 d6  . .x.." ...   P.
        12 d9 c9 70 22 20 80 0f 06 20 ac 23 4d d0 00 80  ...p" ... .#M...
        00 df 03 10 91 00 40 20 10 01 04 f0 01 e7 ef 7f  ......@ ........
        3b 0f d3 11                                      ;...            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.027457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.027584
        Address: 0x08000e58
        Mode: Byte access (0x00)
        Length: 244
        48 d4 b2 6f 48 d2 b4 7d 9d 65 02 8d 15 20 01 00  H..oH..}.e... ..
        34 78 1b 78 58 60 0a 71 06 da 22 20 80 0f 06 20  4x.xX`.q.." ... 
        b8 1f ec e8 00 95 01 b6 07 8d 04 ae 08 8d 01 dd  ................
        05 ae 06 d8 03 f0 00 dd 02 d8 9a 70 43 0d 51 10  ...........pC.Q.
        38 d1 02 bf f4 7f f0 61 01 e0 10 78 09 db 04 f0  8......a...x....
        01 e3 6f 7b 2b 0b 93 02 f2 6b f4 7f f2 61 3f 67  ..o{+....k...a?g
        f1 0a 01 80 15 26 41 13 41 b1 07 8f 01 e5 04 a9  .....&A.A.......
        08 8f af 7d 40 24 14 21 2f 24 07 25 05 a9 0a df  ...}@$.!/$.%....
        03 f0 01 e7 ef 7f 5d 0f 53 14 26 d4 12 6f 14 78  ......].S.&..o.x
        26 d1 00 20 13 03 02 13 80 20 06 da 40 21 92 01  &.. ..... ..@!..
        16 78 38 60 0a 71 22 20 80 0f 06 20 b8 1f eb e8  .x8`.q" ... ....
        02 13 80 20 16 78 32 22 00 20 cb 08 41 84 00 13  ... .x2". ..A...
        00 21 15 26 41 13 01 b1 07 13 80 20 01 e5 04 a9  .!.&A...... ....
        08 13 80 20 af 7d 40 24 14 21 2f 24 07 25 05 a9  ... .}@$.!/$.%..
        05 ed 00 d8 00 ae a1 ae 03 f0 02 d8 00 ae 10 d0  ................
        8a 71 c9 72                                      .q.r            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.029457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.029583
        Address: 0x08000f4c
        Mode: Byte access (0x00)
        Length: 244
        22 20 80 0f 00 20 08 ee 20 20 80 0f 06 20 78 20  " ... ..  ... x 
        0b d0 01 d9 20 a8 00 d8 08 71 20 20 80 0f 00 20  .... ....q  ... 
        0c 4d e0 78 78 3c 00 30 00 0e 00 30 7c 3d 00 30  .M.xx<.0...0|=.0
        55 3e 00 30 28 3a 00 08 2a fc 00 00 24 3a 00 08  U>.0(:..*...$:..
        e1 c5 1e d0 20 10 03 08 24 10 01 08 20 10 02 08  .... ...$... ...
        30 79 50 73 ca 22 ce 00 c4 f7 24 10 01 08 30 79  0yPs."....$...0y
        17 d0 00 88 17 d4 02 b8 15 78 14 78 98 60 65 90  .........x.x.`e.
        35 79 75 7b 75 7b 75 7b 06 90 75 7b 35 79 35 79  5yu{u{u{..u{5y5y
        35 79 3a 62 78 60 05 e2 02 20 81 80 1a 00 23 00  5y:bx`... ....#.
        0d d5 02 22 03 00 17 0d c5 10 c7 70 71 02 00 00  ...".......pq...
        02 20 81 00 03 f0 0d 0d 42 10 0b 09 73 00 00 d8  . ......B...s...
        01 d8 e0 7f c1 c5 e0 78 00 00 00 bc 05 0f 00 30  .......x.......0
        30 44 00 30 8f 7d 38 01 f1 c0 22 20 80 0f 06 20  0D.0.}8..." ... 
        24 20 63 d0 00 80 0b 88 00 dd 61 08 51 00 a9 70  $ c.......a.Q..p
        02 d9 a9 72 a9 73 22 20 80 0f 04 20 c0 28 80 e0  ...r.s" ... .(..
        ab f2 5c d0                                      ..\.            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.031456
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.031581
        Address: 0x08001040
        Mode: Byte access (0x00)
        Length: 244
        02 d9 a9 72 01 db 00 88 22 20 80 0f 04 20 c0 28  ...r...." ... .(
        80 e0 a1 f2 57 d0 20 88 57 d0 35 78 20 80 fc b9  ....W. .W.5x ...
        99 f4 9c b9 20 a0 55 d0 23 d9 40 80 01 6a 22 20  .... .U.#.@..j" 
        80 0f 00 08 d8 34 01 d8 ff d9 22 20 80 0f 04 20  .....4...." ... 
        50 2b 89 f0 4b 17 12 76 4d 17 13 76 00 12 81 20  P+..K..vM..v... 
        f0 23 40 20 f5 b8 7f f2 a9 70 02 d9 a9 72 a9 73  .#@ .....p...r.s
        22 20 80 0f 04 20 c0 28 eb 08 10 00 45 d7 2b d8  " ... .(....E.+.
        20 87 22 89 22 20 80 0f 04 20 9c 22 00 87 02 88   ."." ... ."....
        22 20 80 0f 04 20 88 c4 08 76 4c d8 22 20 80 0f  " ... ...vL." ..
        04 20 f4 24 c4 78 2f 21 08 a0 5d f2 05 d8 22 20  . .$.x/!..]..." 
        80 0f 04 20 14 24 08 76 00 12 80 20 c9 71 f0 23  ... .$.v... .q.#
        00 20 e3 b8 2a 70 a9 72 51 f2 22 20 80 0f 04 20  . ..*p.rQ." ... 
        f0 bc 1a 70 27 d8 22 20 80 0f 04 20 b0 24 12 70  ...p'." ... .$.p
        ca 25 62 10 7f 0d 10 10 2a 70 c9 71 00 da 22 20  .%b.....*p.q.." 
        80 0f 04 20 f0 bc 08 71 27 d8 22 20 80 0f 04 20  ... ...q'." ... 
        9c 22 2c d8                                      .",.            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.033457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.033581
        Address: 0x08001134
        Mode: Byte access (0x00)
        Length: 244
        22 20 80 0f 04 20 b0 24 06 e8 00 87 02 88 86 20  " ... .$....... 
        ff 89 0d f2 2c d8 22 20 80 0f 04 20 b0 24 8c e8  ....,." ... .$..
        00 87 02 88 86 20 ff 89 06 f2 22 20 80 0f 04 20  ..... ...." ... 
        50 d3 17 e8 00 12 80 20 15 23 01 20 00 81 83 b8  P...... .#. ....
        00 a1 27 d8 22 20 80 0f 04 20 b0 24 11 d1 04 a9  ..'." ... .$....
        c5 a9 8a 20 cc 03 22 20 80 0f 04 20 dc 2a 20 20  ... .." ... .*  
        80 0f 06 20 80 20 22 20 80 0f 04 20 f0 bc 1a 70  ... . " ... ...p
        26 d8 b1 f1 a4 11 00 30 a1 11 00 30 a0 11 00 30  &......0...0...0
        38 79 00 30 ec 11 00 30 e4 78 00 30 e8 11 00 30  8y.0...0.x.0...0
        98 79 00 30 f1 c0 22 20 80 0f 04 20 9c 63 0e d0  .y.0.." ... .c..
        20 88 0e d0 f0 20 40 00 fd b8 d1 20 a1 86 d1 20   .... @.... ... 
        61 86 d1 20 21 86 0e f4 09 d0 f0 20 40 00 15 08  a.. !...... @...
        9f 05 08 d0 02 d9 00 88 22 20 80 0f 03 20 9c d6  ........" ... ..
        d1 c0 e0 7e a0 11 00 30 ac 78 00 30 38 79 00 30  ...~...0.x.08y.0
        a1 11 00 30 f1 c0 22 20 80 0f 06 20 38 20 00 d8  ...0.." ... 8 ..
        08 75 03 f0                                      .u..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.035457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.035583
        Address: 0x08001228
        Mode: Byte access (0x00)
        Length: 244
        01 e5 3b 0d d5 11 af 78 22 20 80 0f 02 20 7c 76  ..;....x" ... |v
        78 e8 2d 80 82 e1 cc 21 e2 80 f4 f5 21 80 61 11  x.-....!....!.a.
        81 00 e1 09 51 80 8b 10 01 07 50 80 8c 10 03 07  ....Q.....P.....
        3b 79 80 e3 c0 21 a2 00 03 f0 00 da 48 71 0f d6  ;y...!......Hq..
        25 0d d0 11 3a 62 da ba 45 a6 89 10 02 07 02 22  %...:b..E......"
        40 00 65 b8 1b 08 85 00 09 d2 21 92 13 08 45 00  @.e.......!...E.
        01 b2 07 f0 22 20 80 0f 00 20 6c 50 05 a6 20 20  ...." ... lP..  
        80 0f 06 20 a8 20 e0 78 f8 5c 00 30 7c 10 00 30  ... . .x.\.0|..0
        a1 c0 20 20 80 0f 00 08 b4 12 e0 7e f1 c0 22 20  ..  .......~.." 
        80 0f 06 20 38 20 26 d5 00 de d0 b5 22 20 80 0f  ... 8 &....." ..
        02 20 50 38 0f 08 51 00 1c 8d 0b 08 51 00 dc ad  . P8..Q.....Q...
        2b f0 01 d8 1c ad 1f d0 00 90 26 85 38 60 da b8  +.........&.8`..
        06 a5 22 20 80 0f 06 20 18 1e 3d 68 3a b9 38 60  .." ... ..=h:.8`
        c5 b8 22 78 10 79 46 85 0f b5 02 85 3a 62 da ba  .."x.yF.....:b..
        00 d9 46 a5 28 73 22 20 80 0f 02 20 ec 6f 06 e8  ..F.(s" ... .o..
        02 85 02 e0                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.037457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.037583
        Address: 0x0800131c
        Mode: Byte access (0x00)
        Length: 244
        da b8 06 a5 06 85 04 a5 01 d8 22 20 80 0f 02 20  .........." ... 
        4c 8d 1c 8d 0d e8 22 15 80 10 0a d1 01 e0 20 89  L....."....... .
        0f 78 0f 08 62 00 22 1d 02 10 22 1d 82 13 20 20  .x..b."..."...  
        80 0f 06 20 a8 20 e0 78 b0 59 00 30 4c 10 00 30  ... . .x.Y.0L..0
        50 59 00 30 f1 c0 22 20 80 0f 06 20 2c 20 57 17  PY.0.." ... , W.
        11 76 08 76 00 11 80 20 00 dd 1b 08 1e 00 54 d1  .v.v... ......T.
        32 26 80 1f 00 00 48 01 20 89 22 20 80 0f 02 20  2&....H. ." ... 
        54 46 00 11 80 20 1b 08 5e 00 32 26 80 1f 00 00  TF... ..^.2&....
        48 01 00 d9 01 da 22 20 80 0f 02 20 b0 32 01 86  H....." ... .2..
        61 10 80 00 80 e0 ca 27 81 13 0b f2 45 d0 20 80  a......'....E. .
        20 11 80 00 80 e0 ca 27 41 13 03 f2 e0 81 2f ef   ......'A...../.
        41 17 10 76 00 10 82 20 1d 0a 52 00 32 27 80 1f  A..v... ..R.2'..
        00 00 48 01 01 d9 22 20 80 0f 02 20 b0 32 00 d9  ..H..." ... .2..
        00 18 42 20 00 11 80 20 15 08 5e 01 32 27 80 1f  ..B ... ..^.2'..
        00 00 48 01 22 20 80 0f 02 20 d4 32 00 11 80 20  ..H." ... .2... 
        1b 08 9e 01                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.039492
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.039558
        Address: 0x08001410
        Mode: Byte access (0x00)
        Length: 244
        32 27 80 1f 00 00 48 01 22 20 80 0f 02 20 f0 32  2'....H." ... .2
        00 d8 41 1f 18 10 00 11 80 20 1b 08 9e 00 2a d0  ..A...... ....*.
        2a d1 2b d2 00 88 20 91 40 82 22 20 80 0f 02 20  *.+... .@." ... 
        5c 45 00 11 80 20 17 08 de 00 26 d0 26 d1 00 88  \E... ....&.&...
        20 81 22 20 80 0f 02 20 40 45 4a 20 00 20 00 19   ." ... @EJ . ..
        02 24 1a f0 21 d1 aa 61 32 26 81 1f 00 00 48 01  .$..!..a2&....H.
        22 20 80 0f 05 20 ec 63 15 08 51 00 00 d8 74 d9  " ... .c..Q...t.
        ad da 09 db 22 20 80 0f 05 20 b0 76 00 1f 00 14  ...." ... .v....
        01 e5 af 7d 0d 0d d3 10 15 d7 b5 7f 00 87 e4 e8  ...}............
        14 d5 00 8d 11 08 51 00 22 20 80 0f 03 20 68 69  ......Q." ... hi
        00 1d 02 14 09 d8 80 26 c5 1a 00 ae 20 20 80 0f  .......&....  ..
        06 20 90 20 5a 0f 00 30 5d 0f 00 30 c4 10 00 30  . . Z..0]..0...0
        ac 0f 00 30 9e 0f 00 30 9c 0f 00 30 a0 0f 00 30  ...0...0...0...0
        a4 0f 00 30 a8 0f 00 30 90 0f 00 30 1c 14 00 30  ...0...0...0...0
        df 10 00 30 f1 c0 22 20 80 0f 06 20 34 20 48 75  ...0.." ... 4 Hu
        0c db 21 1d                                      ..!.            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.041491
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.041557
        Address: 0x08001504
        Mode: Byte access (0x00)
        Length: 244
        c2 10 61 85 a2 c1 61 13 83 00 00 da 13 0b 51 00  ..a...a.......Q.
        c0 85 b4 16 03 10 84 eb 57 86 01 e2 57 a6 b9 09  ........W...W...
        51 07 20 85 56 21 02 0a b2 e8 00 de ce a1 db aa  Q. .V!..........
        28 70 22 20 80 0f 01 20 d0 f0 20 85 14 e8 c0 11  (p" ... .. .....
        00 00 25 08 51 00 28 72 80 22 08 00 5a 12 80 80  ..%.Q.(r."..Z...
        0d 08 51 00 0a d8 71 1a 02 80 17 f0 04 d8 71 1a  ..Q...q.......q.
        02 80 13 f0 28 70 22 20 80 0f 01 20 6c f0 20 85  ....(p" ... l. .
        0b e8 28 70 80 20 08 00 52 10 82 80 0b 0a 1e 00  ..(p. ..R.......
        03 da 71 18 82 80 c0 19 80 03 1d f0 1b 8a 01 e0  ..q.............
        0f 78 1b aa 87 11 02 07 2b 08 82 00 8b 70 81 c1  .x......+....p..
        22 20 80 0f 02 20 a0 81 20 85 00 c0 28 72 80 22  " ... .. ...(r."
        08 00 0e a1 00 d8 5b 1a 02 80 c0 19 00 00 71 1a  ......[.......q.
        02 80 80 21 05 08 11 89 5d 08 52 00 61 b8 0f 78  ...!....].R.a..x
        11 a9 2a f0 a8 e8 51 0a 95 07 00 85 22 20 80 0f  ..*...Q....." ..
        01 20 d0 f0 a0 e8 00 85 22 20 80 0f 01 20 6c f0  . ......" ... l.
        9a e8 41 d2                                      ..A.            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.043490
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.043557
        Address: 0x080015f8
        Mode: Byte access (0x00)
        Length: 244
        40 8a 41 d1 0d 0a 72 00 02 81 40 d2 01 db 60 aa  @.A...r...@...`.
        10 e8 40 85 13 0a 00 00 00 a5 41 80 0c 82 41 a5  ..@.......A...A.
        03 a5 0d 82 04 a5 0c 89 20 1d 02 10 02 d8 0f b5  ........ .......
        20 15 80 10 b9 08 d1 0b 33 d0 20 80 c0 85 0a e9   .......3. .....
        32 26 80 1f 00 00 71 01 80 e0 ca 26 4c 10 c5 f6  2&....q....&L...
        2d d8 20 1d 02 10 c9 70 22 20 80 0f 01 20 7c f0  -. ....p" ... |.
        8a e8 32 26 80 1f 00 00 71 01 86 e8 00 d8 20 1d  ..2&....q..... .
        02 10 3e f0 00 85 1b 08 80 03 c0 a5 21 86 0c 81  ..>.........!...
        21 a5 03 a5 0d 81 04 a5 2d d8 20 1d 02 10 c9 77  !.......-. ....w
        80 27 08 10 71 17 80 90 11 08 52 00 64 17 c0 90  .'..q.....R.d...
        88 e8 65 17 80 90 86 e8 c0 16 00 10 0d 08 51 00  ..e...........Q.
        1d d8 20 1d 02 10 1c f0 52 17 80 90 3b 08 1e 00  .. .....R...;...
        c9 70 22 20 80 0f 01 20 6c f0 05 e8 03 d8 71 1f  .p" ... l.....q.
        02 90 71 17 80 90 13 08 52 00 1d d8 20 1d 02 10  ..q.....R... ...
        01 d8 02 a5 04 f0 2d d8 20 1d 02 10 a2 c0 20 20  ......-. .....  
        80 0f 06 20                                      ...             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.045490
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.045555
        Address: 0x080016ec
        Mode: Byte access (0x00)
        Length: 244
        a0 20 00 d8 71 1f 02 90 f5 f1 e0 78 d0 10 00 30  . ..q......x...0
        d4 61 00 30 d8 10 00 30 f1 c0 e1 c5 8f d0 00 88  .a.0...0........
        22 20 80 0f 03 20 60 47 80 e0 00 dd ca 20 41 03  " ... `G..... A.
        02 f2 00 80 20 20 80 0f 06 20 b0 20 a1 c0 20 20  ....  ... . ..  
        80 0f 00 08 34 17 e0 7e f1 c0 22 20 80 0f 06 20  ....4..~.." ... 
        18 20 a1 c1 81 d6 00 8e 22 20 80 0f 03 20 60 47  . ......" ... `G
        7f 17 12 76 08 75 00 12 80 20 4a 20 00 20 3f 08  ...v.u... J . ?.
        91 00 ea ff 03 e8 0d 80 83 e8 0a 70 03 f0 79 d0  ...........p..y.
        00 88 79 d2 c2 b8 20 8e 84 b8 34 7a 00 b2 23 15  ..y... ...4z..#.
        80 10 89 e0 d8 f4 22 20 80 0f 02 20 f0 af 20 8e  ......" ... .. .
        72 d4 05 b9 9a 61 00 aa ce f0 80 e5 ca 27 01 14  r....a.......'..
        1e f2 23 15 80 10 e0 85 35 08 51 00 21 85 8b 70  ..#.....5.Q.!..p
        6f 95 42 85 28 e1 0a 24 00 04 5b 63 da bb e9 72  o.B.(..$..[c...r
        22 20 80 0f 02 20 8c 26 20 8e 65 d4 20 c0 02 b9  " ... .& .e. ...
        35 79 99 61 08 a9 02 14 80 30 0a a9 80 e7 cc 25  5y.a.....0.....%
        22 90 a0 f2                                      "...            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.047490
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.047558
        Address: 0x080017e0
        Mode: Byte access (0x00)
        Length: 244
        20 15 80 10 ab e0 9c f2 5d d0 00 10 91 00 4a 24   .......].....J$
        00 20 7a 77 80 23 08 20 48 13 81 a0 40 29 00 21  . zw.#. H...@).!
        25 78 0f 78 22 20 80 0f 02 20 9c 78 1a 70 69 13  %x.x" ... .x.pi.
        80 a0 21 15 81 10 02 28 40 04 52 17 16 76 39 09  ..!....(@.R..v9.
        f2 03 53 20 15 00 31 09 52 20 02 85 42 21 41 20  ..S ..1.R ..B!A 
        2f 79 22 20 80 0f 03 20 24 12 20 8e 3a 70 02 b9  /y" ... $. .:p..
        35 79 34 79 00 26 40 20 02 d9 22 20 80 0f 00 08  5y4y.&@ .." ....
        f8 34 34 f0 00 8e 01 dd 66 13 91 a0 a9 71 02 b8  .44.....f....q..
        15 78 14 78 c2 70 22 20 80 0f 00 08 f8 34 07 d8  .x.x.p" .....4..
        22 20 80 0f 03 20 78 67 11 e8 3b d0 19 88 20 8e  " ... xg..;... .
        45 08 91 00 02 b9 35 79 34 79 00 26 40 20 02 d9  E.....5y4y.&@ ..
        22 20 80 0f 00 08 f8 34 16 f0 02 d8 22 20 80 0f  " .....4...." ..
        00 20 38 35 07 e8 10 d8 22 20 80 0f 00 20 38 35  . 85...." ... 85
        84 e8 1f 87 09 08 51 00 01 dd 06 f0 2b d1 00 d8  ......Q.....+...
        a0 a1 08 75 00 12 80 20 53 20 81 20 c0 bd 07 bd  ...u... S . ....
        c3 b8 03 b8                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.049490
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.049556
        Address: 0x080018d4
        Mode: Byte access (0x00)
        Length: 244
        25 78 05 7d 40 2d 01 22 53 21 00 20 a5 79 09 b8  %x.}@-."S!. .y..
        25 78 1b d1 40 8e 54 79 00 b1 75 13 80 a0 15 08  %x..@.Ty..u.....
        51 00 e9 70 22 20 80 0f 02 20 f8 17 75 1b 02 a5  Q..p" ... ..u...
        76 13 80 a0 29 08 51 00 e9 70 22 20 80 0f 02 20  v...).Q..p" ... 
        90 18 76 1b 02 a5 0c f0 8a ed 01 d8 44 d9 8a 22  ..v.........D.."
        44 06 09 db 22 20 80 0f 05 20 b0 76 0b d0 00 d9  D..." ... .v....
        00 1a 42 20 20 a8 a1 c0 20 20 80 0f 06 20 68 20  ..B  ...  ... h 
        06 0f 00 30 54 0f 00 30 24 10 00 30 10 0f 00 30  ...0T..0$..0...0
        c4 44 00 30 e8 44 00 30 55 0f 00 30 30 44 00 30  .D.0.D.0U..00D.0
        f0 16 00 30 50 0f 00 30 a1 c0 20 20 80 0f 00 08  ...0P..0..  ....
        78 19 e0 7e f1 c0 22 20 80 0f 06 20 2c 20 a0 80  x..~.." ... , ..
        08 76 0c 85 00 d9 cb 08 51 00 22 20 80 0f 03 20  .v......Q." ... 
        38 47 10 16 11 10 1c e8 21 10 81 00 31 09 51 00  8G......!...1.Q.
        00 80 2d 0d 01 10 03 86 87 15 0f 17 e0 b8 c2 27  ..-............'
        62 10 f8 60 da b8 0b a5 23 86 a9 70 22 20 80 0f  b..`....#..p" ..
        02 20 e0 c0                                      . ..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.051490
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.051557
        Address: 0x080019c8
        Mode: Byte access (0x00)
        Length: 244
        1a 75 80 20 08 20 15 f0 32 25 80 1f 00 00 59 01  .u. . ..2%....Y.
        1a 75 80 20 08 20 04 e8 15 08 92 02 03 86 eb 85  .u. . ..........
        02 7f da bf 0b 0e c5 73 ff 03 ff ff 02 df 52 10  .......s......R.
        80 a0 21 08 1e 00 a9 70 22 20 80 0f 01 20 2c f0  ..!....p" ... ,.
        08 e8 59 10 80 a0 86 e8 0d 85 83 e0 ca 27 a2 10  ..Y..........'..
        04 86 10 77 ca 27 0e 10 c2 f7 e4 a6 01 d8 21 1e  ...w.'........!.
        02 10 10 d8 20 1e 02 10 5a 10 80 a0 23 09 e5 23  .... ...Z...#..#
        02 a6 71 10 80 a0 0d e8 0c d8 21 1e 02 10 1d d8  ..q.......!.....
        20 1e 02 10 10 1e 40 14 03 f0 20 1e 42 10 20 20   .....@... .B.  
        80 0f 06 20 90 20 e0 78 a1 c0 20 20 80 0f 00 08  ... . .x..  ....
        6c 1a e0 7e f1 c0 22 20 80 0f 06 20 2c 20 c0 81  l..~.." ... , ..
        1a 70 00 d8 3a 70 c9 77 80 27 08 10 89 1f 02 90  .p..:p.w.'......
        0c 86 28 75 a7 08 51 00 21 86 87 16 00 17 4c 81  ..(u..Q.!.....L.
        58 60 da b8 0b a6 2c 81 c9 70 22 20 80 0f 02 20  X`....,..p" ... 
        e0 c0 0b 86 a0 b8 0b a6 2f 08 51 20 59 17 80 90  ......../.Q Y...
        27 08 93 02                                      '...            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.053490
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.053555
        Address: 0x08001abc
        Mode: Byte access (0x00)
        Length: 244
        2d 86 23 09 51 00 01 e0 0f 78 59 1f 02 90 01 d8  -.#.Q....xY.....
        21 1d 02 10 10 d9 20 1d 42 10 5a 17 81 90 22 a5  !..... .B.Z...".
        29 f0 59 1f 42 94 c9 70 22 20 80 0f 01 20 7c f0  ).Y.B..p" ... |.
        0a e8 0c d8 21 1d 02 10 2d d8 20 1d 02 10 01 d8  ....!...-. .....
        89 1f 02 90 c9 70 22 20 80 0f 01 20 6c f0 15 e8  .....p" ... l...
        52 17 80 90 23 08 1e 00 0c d8 21 1d 02 10 10 d8  R...#.....!.....
        20 1d 02 10 00 85 03 d9 80 20 45 0c 20 a8 01 d8   ........ E. ...
        02 a5 89 1f 02 90 20 20 80 0f 06 20 90 20 e0 78  ......  ... . .x
        f1 c0 22 20 80 0f 06 20 28 20 28 77 d7 d1 1a 72  .." ... ( (w...r
        3a 73 88 75 12 11 92 00 a8 76 22 20 80 0f 02 20  :s.u.....v" ... 
        7c 76 36 e8 80 20 08 00 0b 0f 51 1b 64 10 c1 80  |v6.. ....Q.d...
        27 e9 52 10 80 80 47 08 1e 00 cd d0 00 80 13 0a  '.R...G.........
        10 20 2e b8 c1 b8 00 ae 0b d8 00 ad 20 f0 13 08  . .......... ...
        11 20 2c b8 c1 b8 00 ae 0a d8 00 ad 18 f0 13 09  . ,.............
        10 20 28 b8 c1 b8 00 ae 08 d8 00 ad 10 f0 2a b8  . (...........*.
        c1 b8 00 ae                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.055491
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.055558
        Address: 0x08001bb0
        Mode: Byte access (0x00)
        Length: 244
        09 d8 00 ad 0a f0 15 08 5e 00 1b d8 00 ad bb d0  ........^.......
        00 80 3c b8 c1 b8 00 ae 20 20 80 0f 06 20 88 20  ..<.....  ... . 
        a1 c0 20 20 80 0f 00 08 dc 1b e0 7e f1 c0 22 20  ..  .......~.." 
        80 0f 06 20 34 20 08 75 56 20 0e 0a 08 8e ed 08  ... 4 .uV ......
        f3 01 28 77 a9 70 22 20 80 0f 02 20 40 73 28 8e  ..(w.p" ... @s(.
        07 d8 22 20 80 0f 02 20 a4 71 28 8e 0e d8 22 20  .." ... .q(..." 
        80 0f 02 20 a4 71 28 8e 15 d8 22 20 80 0f 02 20  ... .q(..." ... 
        a4 71 28 8e 1c d8 22 20 80 0f 02 20 a4 71 28 8e  .q(..." ... .q(.
        23 d8 22 20 80 0f 02 20 a4 71 28 8e 2a d8 22 20  #." ... .q(.*." 
        80 0f 02 20 a4 71 28 8e 31 d8 22 20 80 0f 02 20  ... .q(.1." ... 
        a4 71 28 8e 38 d8 22 20 80 0f 02 20 a4 71 28 8e  .q(.8." ... .q(.
        56 d8 22 20 80 0f 02 20 a4 71 28 8e 3f d8 22 20  V." ... .q(.?." 
        80 0f 02 20 a4 71 28 8e 46 d8 22 20 80 0f 02 20  ... .q(.F." ... 
        a4 71 28 8e 4d d8 22 20 80 0f 02 20 a4 71 08 8e  .q(.M." ... .q..
        17 ef 22 20 80 0f 02 20 00 79 08 8e 84 b8 22 20  .." ... .y...." 
        80 0f 02 20                                      ...             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.057490
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.057557
        Address: 0x08001ca4
        Mode: Byte access (0x00)
        Length: 244
        00 79 08 8e 84 b8 22 20 80 0f 02 20 00 79 08 8e  .y...." ... .y..
        84 b8 22 20 80 0f 02 20 00 79 08 8e 00 d9 7b d4  .." ... .y....{.
        ff da 18 60 14 78 98 60 21 b0 20 b0 44 a8 21 a5  ...`.x.`!. .D.!.
        07 d8 08 ae 20 20 80 0f 06 20 a0 20 a1 c0 20 20  ....  ... . ..  
        80 0f 00 08 ec 1c e0 7e f1 c0 22 20 80 0f 06 20  .......~.." ... 
        30 20 08 76 1d 08 f3 01 00 df 6d d4 b4 6e b5 7d  0 .v......m..n.}
        b5 7d 9d 65 56 25 10 1a 08 10 80 20 09 08 d3 01  .}.eV%..... ....
        e9 75 11 f0 a9 70 22 20 80 0f 02 20 b8 73 63 d4  .u...p" ... .sc.
        d8 66 14 78 ff d9 98 60 e1 b0 e0 b0 24 a8 08 18  .f.x...`....$...
        82 23 a9 70 20 20 80 0f 06 20 98 20 a1 c0 20 20  .#.p  ... . ..  
        80 0f 00 08 4c 1d e0 7e f1 c0 22 20 80 0f 06 20  ....L..~.." ... 
        0c 20 a1 c1 08 76 57 d0 0a 25 00 21 00 88 4a 27  . ...vW..%.!..J'
        00 20 80 e0 cc 23 62 80 cc 21 22 80 60 03 01 00  . ...#b..!".`...
        84 e2 5c 03 0b 00 61 89 00 89 08 bb 05 20 d4 00  ..\...a...... ..
        03 89 62 89 08 b8 05 7b 81 e3 be 02 22 00 40 21  ..b....{....".@!
        12 01 4c 24                                      ..L$            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.059464
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.059532
        Address: 0x08001d98
        Mode: Byte access (0x00)
        Length: 244
        00 a1 38 03 0b 00 40 24 00 21 0f 0a 03 00 42 22  ..8...@$.!....B"
        14 01 2f 24 08 25 ea 77 0a 23 c0 25 0a 26 c0 25  ../$.%.w.#.%.&.%
        13 f0 20 a8 41 a8 01 d9 24 a8 05 18 c2 05 01 10  .. .A...$.......
        81 20 c3 a8 22 a8 22 20 80 0f 02 20 b8 7a 00 c0  . .."." ... .z..
        04 e0 1f 67 f0 7f 92 77 f0 02 0a 00 32 22 c2 23  ...g...w....2".#
        00 22 c1 23 00 22 c0 23 01 90 21 89 a4 6f 40 c0  .".#.".#..!..o@.
        00 22 d0 23 42 75 02 24 c0 23 64 b8 10 78 2b 0a  .".#Bu.$.#d..x+.
        90 00 b5 0a d0 00 cb 0a d1 81 84 e0 bc 02 0b 00  ................
        00 15 11 11 4c 25 00 a0 02 15 10 11 c9 70 d4 f2  ....L%.......p..
        0a 71 2a 72 d2 f0 84 e0 a0 02 0b 00 00 95 d7 70  .q*r...........p
        00 00 00 10 ca 20 2a 00 cf 20 2a 03 00 d9 04 f0  ..... *.. *.....
        01 e1 2f 79 1b 09 13 02 1a d4 3a 61 54 7a 9a 62  ../y......:aTz.b
        64 8a 78 eb 60 92 ed 08 c1 80 02 12 97 00 11 09  d.x.`...........
        11 02 4a 23 00 20 0a 26 c0 24 b3 f1 22 20 80 0f  ..J#. .&.$.." ..
        02 20 84 7a 77 e8 20 95 00 da 4a 26 40 20 4a 23  . .zw. ...J&@ J#
        40 20 99 e1                                      @ ..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.061437
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.061502
        Address: 0x08001e8c
        Mode: Byte access (0x00)
        Length: 244
        c2 26 82 25 97 e1 c2 23 c2 24 24 b0 21 95 23 0d  .&.%...#.$$.!.#.
        11 a0 21 a8 40 a8 8f f1 44 01 00 30 1c 10 00 30  ..!.@...D..0...0
        68 3a 00 08 5c 4d 00 30 04 10 00 30 74 16 00 30  h:..\M.0...0t..0
        88 e0 14 02 0b 00 04 15 11 11 00 15 10 11 4c 21  ..............L!
        40 a0 02 15 18 11 83 f3 c9 70 7b 0d 10 20 22 20  @........p{.. " 
        80 0f 02 20 48 7b 0a 25 00 90 79 f3 d9 09 11 20  ... H{.%..y.... 
        00 1d 02 14 02 d8 04 ad 4c 26 40 a0 cc 23 62 a0  ........L&@..#b.
        17 f2 c9 70 22 20 80 0f 02 20 7c 76 11 e8 25 8d  ...p" ... |v..%.
        80 20 05 00 52 88 61 b9 0f 22 42 00 52 a8 12 88  . ..R.a.."B.R...
        e1 b8 ca 20 62 00 e2 20 82 0f 02 20 0c 8d 4c 26  ... b.. ... ..L&
        40 a0 55 f5 7c 17 0c f0 d8 66 14 78 98 60 24 88  @.U.|....f.x.`$.
        8c 21 c3 8f 4b f5 02 18 04 06 00 18 04 04 c4 a8  .!..K...........
        45 f1 22 20 80 0f 02 20 48 7b 0a 25 00 90 3f f3  E." ... H{.%..?.
        65 09 11 20 01 1d 02 14 02 d8 04 ad 4c 26 40 a0  e.. ........L&@.
        cc 23 62 a0 17 f2 c9 70 22 20 80 0f 02 20 7c 76  .#b....p" ... |v
        11 e8 45 8d                                      ..E.            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.063495
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.063558
        Address: 0x08001f80
        Mode: Byte access (0x00)
        Length: 244
        80 20 05 00 32 88 61 ba 0f 21 81 00 32 a8 12 88  . ..2.a..!..2...
        e1 b8 ca 20 62 00 e2 20 82 0f 02 20 0c 8d 4c 26  ... b.. ... ..L&
        40 a0 1b f5 08 17 0c f0 d8 66 14 78 98 60 24 88  @........f.x.`$.
        8c 21 c3 8f 11 f5 00 18 04 06 02 18 04 04 c7 f1  .!..............
        a9 70 22 20 80 0f 02 20 94 7b 07 f1 2a 71 0a 72  .p" ... .{..*q.r
        22 20 80 0f 02 20 ec 7a 0a 25 00 90 fa 05 c1 ff  " ... .z.%......
        d8 66 14 20 19 00 c9 70 22 20 80 0f 02 20 7c 76  .f. ...p" ... |v
        af 17 18 f6 09 e8 25 8d 80 20 05 00 52 88 61 b9  ......%.. ..R.a.
        10 22 42 00 52 a8 00 20 41 36 24 89 00 20 40 36  ."B.R.. A6$.. @6
        17 0d 10 20 2d 0e 41 10 21 90 29 09 01 04 20 90  ... -.A.!.)... .
        21 09 41 04 09 f0 1d 0e 41 10 21 90 15 09 41 04  !.A.....A.!...A.
        20 90 11 09 01 04 00 d9 21 b0 20 b0 ff d9 24 a8   .......!. ...$.
        22 20 80 0f 02 20 78 8b bc f1 d8 66 14 78 98 17  " ... x....f.x..
        0c f6 98 60 0d 0d 10 20 21 90 79 0b 41 00 05 f0  ...`... !.y.A...
        20 90 71 0b 41 00 04 88 69 0e 01 10 00 12 01 21   .q.A...i......!
        41 29 00 02                                      A)..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.065490
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.065557
        Address: 0x08002074
        Mode: Byte access (0x00)
        Length: 244
        c1 b9 c5 b8 59 09 91 00 42 20 c0 81 18 f2 81 e0  ....Y...B ......
        cc 20 a2 80 cc 20 e2 80 22 f4 c9 70 22 20 80 0f  . ... .."..p" ..
        02 20 7c 76 07 e8 80 20 05 00 32 88 86 21 7c 00  . |v... ..2..!|.
        32 a8 22 20 80 0f 02 20 78 8b 12 f0 c9 70 22 20  2." ... x....p" 
        80 0f 02 20 7c 76 0c e8 80 20 05 00 32 88 80 b9  ... |v... ..2...
        32 a8 01 d8 22 20 80 0f 02 20 cc 8c a1 c0 20 20  2..." ... ....  
        80 0f 06 20 50 20 e0 78 f1 c0 e1 c5 08 75 22 20  ... P .x.....u" 
        80 0f 04 20 e4 0f 80 e0 ca 20 42 03 e2 20 82 0f  ... ..... B.. ..
        03 20 a4 c8 14 d4 14 25 40 13 00 d9 98 60 20 a8  . .....%@....` .
        21 a8 22 a8 22 20 80 0f 04 20 04 10 80 e0 e2 20  !."." ... ..... 
        81 0f 03 20 34 af a9 70 22 20 80 0f 04 20 80 0c  ... 4..p" ... ..
        22 20 80 0f 03 20 b0 b6 08 d5 0a ad 22 20 80 0f  " ... ......" ..
        03 20 d8 b6 0b ad 08 8d 09 ad 20 20 80 0f 06 20  . ........  ... 
        b0 20 e0 78 7c 68 00 30 40 66 00 30 f1 c0 22 20  . .x|h.0@f.0.." 
        80 0f 06 20 2c 20 a4 c1 6d 17 10 76 82 c1 6d d6  ... , ..m..v..m.
        03 10 80 20                                      ...             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.067493
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.067564
        Address: 0x08002168
        Mode: Byte access (0x00)
        Length: 244
        00 ae 22 20 80 0f 02 20 58 38 40 24 8d 32 a9 70  .." ... X8@$.2.p
        22 20 80 0f 03 20 68 ed 8b 70 a9 71 03 da 22 20  " ... h..p.q.." 
        80 0f 06 20 a0 1e 0d 14 80 30 62 d7 03 1c 02 30  ... .....0b....0
        08 14 00 31 04 1c 04 30 00 8e 14 78 08 67 4a 21  ...1...0...x.gJ!
        00 20 19 08 1f 00 00 d8 21 d9 93 da 03 db 22 20  . ......!....." 
        80 0f 05 20 b0 76 7e f0 8b 75 a9 70 22 20 80 0f  ... .v~..u.p" ..
        00 20 bc c2 86 e0 cc 20 22 82 cc 20 62 80 2f f4  . ..... ".. b./.
        a9 70 22 20 80 0f 00 20 b8 ce 22 20 80 0f 03 20  .p" ... .." ... 
        f8 ec 8c 20 c3 8f 00 ae 18 f2 a9 70 22 20 80 0f  ... .......p" ..
        00 20 b8 ce 02 d9 22 20 80 0f 03 20 b0 d8 46 d0  . ...." ... ..F.
        0a 71 24 da 22 20 80 0f 06 20 a0 1e 43 d0 01 d9  .q$." ... ..C...
        20 a8 80 dd 00 d8 50 f0 01 d8 21 d9 a8 da 03 db   .....P...!.....
        22 20 80 0f 05 20 b0 76 f5 f1 89 08 11 00 00 8e  " ... .v........
        22 20 80 0f 03 20 18 ed a9 71 81 da 22 20 80 0f  " ... ...q.." ..
        00 20 54 c3 33 e8 00 8e 07 d9 22 20 80 0f 03 20  . T.3....." ... 
        1c d5 20 8e                                      .. .            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.069491
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.069560
        Address: 0x0800225c
        Mode: Byte access (0x00)
        Length: 244
        a0 e8 32 d2 00 8a 0f 20 40 00 00 aa 00 d9 06 d8  ..2.... @.......
        28 72 28 73 22 20 80 0f 03 20 28 cc 22 20 80 0f  (r(s" ... (." ..
        04 20 4c 11 8a 20 4c 01 00 d9 22 20 80 0f 03 20  . L.. L..." ... 
        40 e5 00 8e 10 d9 14 78 f8 60 20 a8 2a 70 0e f0  @......x.` .*p..
        28 70 22 20 80 0f 03 20 18 ed 01 d9 04 da 22 20  (p" ... ......" 
        80 0f 00 20 b4 c5 01 d8 00 dd 04 f0 01 d8 80 dd  ... ............
        1f e8 00 8e 22 20 80 0f 02 20 9c 4b 90 e8 00 8e  ...." ... .K....
        10 da 14 20 01 00 3f 67 40 af 22 20 80 0f 03 20  ... ..?g@." ... 
        18 ed 22 20 80 0f 00 20 64 c2 0b f0 00 d8 12 d9  .." ... d.......
        8a 22 04 02 03 db 22 20 80 0f 05 20 b0 76 22 20  ."...." ... .v" 
        80 0f 02 20 78 8b a9 70 a4 c0 20 20 80 0f 06 20  ... x..p..  ... 
        90 20 e0 78 24 67 00 30 60 11 00 30 7c 68 00 30  . .x$g.0`..0|h.0
        94 3a 00 08 25 3a 00 08 8b 11 00 30 f1 c0 22 20  .:..%:.....0.." 
        80 0f 06 20 38 20 a4 c1 60 d0 41 d9 60 d5 00 de  ... 8 ..`.A.`...
        03 88 00 ad 22 20 80 0f 03 20 e8 d2 8a 20 0c 02  ...." ... ... ..
        c9 71 22 20                                      .q"             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.071463
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.071530
        Address: 0x08002350
        Mode: Byte access (0x00)
        Length: 244
        80 0f 03 20 40 e5 00 8d 01 d9 22 20 80 0f 03 20  ... @....." ... 
        6c f7 00 8d 22 20 80 0f 03 20 18 ed c9 72 08 71  l..." ... ...r.q
        0a d8 c9 73 22 20 80 0f 03 20 28 cc 00 8d 08 d9  ...s" ... (.....
        22 20 80 0f 03 20 1c d5 93 e8 00 8d 22 20 80 0f  " ... ......" ..
        03 20 78 f5 22 20 80 0f 04 20 1c 14 22 20 80 0f  . x." ... .." ..
        04 20 58 19 22 20 80 0f 04 20 4c 11 09 f0 c9 70  . X." ... L....p
        2e d9 78 da 03 db 22 20 80 0f 05 20 b0 76 40 d1  ..x..." ... .v@.
        00 89 80 e0 ca 26 21 10 64 f2 3e d0 03 88 c0 a9  .....&!.d.>.....
        82 c1 00 ad 22 20 80 0f 02 20 58 38 40 24 8e 32  ...." ... X8@$.2
        c9 70 22 20 80 0f 03 20 68 ed 8b 70 c9 71 03 da  .p" ... h..p.q..
        22 20 80 0f 06 20 a0 1e 0d 14 80 30 03 1c 02 30  " ... .....0...0
        08 14 00 31 04 1c 04 30 00 8d 22 20 80 0f 03 20  ...1...0.." ... 
        18 ed 8b 71 81 da 22 20 80 0f 00 20 54 c3 80 de  ...q.." ... T...
        38 e8 00 8d 07 d9 22 20 80 0f 03 20 1c d5 20 8d  8....." ... .. .
        a0 e8 25 d0 40 88 0f 22 42 00 40 a8 00 d9 06 d8  ..%.@.."B.@.....
        28 72 28 73                                      (r(s            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.073458
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.073551
        Address: 0x08002444
        Mode: Byte access (0x00)
        Length: 244
        22 20 80 0f 03 20 28 cc 22 20 80 0f 04 20 4c 11  " ... (." ... L.
        8a 20 4c 01 00 d9 22 20 80 0f 03 20 40 e5 00 8d  . L..." ... @...
        10 da 19 d4 14 78 99 60 40 a9 12 f0 28 70 22 20  .....x.`@...(p" 
        80 0f 03 20 18 ed 01 d9 04 da 22 20 80 0f 00 20  ... ......" ... 
        b4 c5 00 8d 22 20 80 0f 02 20 9c 4b 22 20 80 0f  ...." ... .K" ..
        02 20 54 8c 22 20 80 0f 02 20 78 8b 22 20 80 0f  . T." ... x." ..
        03 20 90 da c9 70 a4 c0 20 20 80 0f 06 20 a8 20  . ...p..  ... . 
        24 67 00 30 60 11 00 30 25 3a 00 08 94 3a 00 08  $g.0`..0%:...:..
        8b 11 00 30 7c 68 00 30 f1 c0 22 20 80 0f 06 20  ...0|h.0.." ... 
        14 20 ba 70 28 76 da 72 1a 73 0a 27 00 21 0a 24  . .p(v.r.s.'.!.$
        40 21 0a 22 80 21 99 09 a3 00 0a 23 c0 21 db 17  @!.".!.....#.!..
        11 76 03 11 cf 20 01 e7 ed 7f 6a 75 03 f0 42 75  .v... ....ju..Bu
        af 7d cf e5 68 00 0a 00 aa 70 a9 71 22 20 80 0f  .}..h....p.q" ..
        03 20 d4 ad f5 e8 32 27 40 23 04 20 00 04 e3 08  . ....2'@#. ....
        01 84 cf d4 14 6d 98 60 02 11 82 20 23 90 d3 09  .....m.`... #...
        82 80 02 80                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.075458
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.075542
        Address: 0x08002538
        Mode: Byte access (0x00)
        Length: 244
        22 20 80 0f 06 20 08 21 c3 0f 02 90 aa 70 a9 71  " ... .!.....p.q
        01 da 22 20 80 0f 03 20 c8 b0 19 0c 50 20 19 0c  .." ... ....P ..
        11 20 80 e5 cc 25 22 96 4e dc cc 25 02 93 04 f2  . ...%".N..%....
        01 e6 cf 7e 97 0e 82 95 01 e7 11 0e a3 15 ed 7f  ...~............
        87 0e c3 f3 ff ff f6 ff c9 70 20 20 80 0f 06 20  .........p  ... 
        60 20 e0 78 f1 c0 22 20 80 0f 06 20 14 20 9a 70  ` .x.." ... . .p
        1a 71 e1 c2 3a 73 0a 27 00 21 0a 25 40 21 0a 22  .q..:s.'.!.%@!."
        80 21 e8 77 4e dd 4c 26 80 80 cc 25 61 a0 ca 25  .!.wN.L&...%a..%
        81 1f 00 00 4d 00 a8 d0 00 90 15 08 5e 02 a8 d0  ....M.......^...
        0e 10 96 00 0d 10 93 00 0b 0b 82 25 7a 75 da 75  ...........%zu.u
        03 f0 fd 09 de a0 02 25 81 15 02 23 c0 23 13 08  .......%...#.#..
        43 00 02 25 80 14 0f 78 a9 76 08 75 06 f0 00 27  C..%...x.v.u...'
        80 14 0f 78 e9 76 08 77 8a 70 c9 71 22 20 80 0f  ...x.v.w.p.q" ..
        03 20 d4 ad 9d e8 32 27 80 23 04 20 40 04 33 08  . ....2'.#. @.3.
        41 04 8a 70 c9 71 01 da 22 20 80 0f 03 20 c8 b0  A..p.q.." ... ..
        17 0d 50 20                                      ..P             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.077457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.077549
        Address: 0x0800262c
        Mode: Byte access (0x00)
        Length: 244
        1b 0d 11 20 80 e6 cc 26 22 96 4e dc cc 26 02 93  ... ...&".N..&..
        05 f2 40 20 50 20 2f 20 07 24 0b 0f c2 14 0d 0e  ..@ P / .$......
        43 23 00 c0 8f 08 02 a0 0a 70 a1 c0 20 20 80 0f  C#.......p..  ..
        06 20 60 20 f1 c0 22 20 80 0f 06 20 1c 20 b7 c1  . ` .." ... . ..
        8b 70 ff d9 09 da 22 20 80 0f 06 20 50 1f 7f d8  .p...." ... P...
        09 1c 02 30 83 c0 4f d9 22 20 80 0f 06 20 ac 23  ...0..O." ... .#
        06 dd 04 f0 01 e5 af 7d 17 0d 53 13 a9 70 22 20  .......}..S..p" 
        80 0f 03 20 9c b0 f1 08 51 80 01 d8 02 f0 00 d8  ... ....Q.......
        0a 23 00 a0 c8 02 21 00 0a 20 00 27 00 de 69 17  .#....!.. .'..i.
        12 76 40 22 55 25 0b f0 0a 70 c9 71 00 da 22 20  .v@"U%...p.q.." 
        80 0f 03 20 c8 b0 01 e6 cf 7e cf e6 b2 00 0a 00  ... .....~......
        0a 70 c9 71 01 da 22 20 80 0f 03 20 c8 b0 00 12  .p.q.." ... ....
        00 21 4b 08 1e 00 47 08 1f 02 5d d5 4f 15 80 90  .!K...G...].O...
        1d e8 a9 70 82 20 43 06 c9 71 22 20 80 0f 03 20  ...p. C..q" ... 
        f4 b0 b9 08 d0 80 a9 70 82 20 43 06 c9 71 22 20  .......p. C..q" 
        80 0f 03 20                                      ...             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.079459
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.079541
        Address: 0x08002720
        Mode: Byte access (0x00)
        Length: 244
        f4 b0 8b e8 a9 70 82 20 43 0b c9 71 22 20 80 0f  .....p. C..q" ..
        03 20 d4 ad 48 e8 00 df 9b 0f d3 91 b2 6f b4 7d  . ..H........o.}
        00 25 40 23 c9 71 22 20 80 0f 03 20 08 b1 79 08  .%@#.q" ... ..y.
        d0 80 47 d0 c9 71 22 20 80 0f 03 20 f4 b0 94 e8  ..G..q" ... ....
        00 25 40 23 c9 71 22 20 80 0f 03 20 08 b1 81 e0  .%@#.q" ... ....
        ca 20 01 04 ca 21 81 03 ca 22 61 00 e2 20 81 0f  . ...!..."a.. ..
        03 20 c8 b0 01 e7 ef 7f d8 f1 e0 17 11 70 0a 70  . ...........p.p
        2a 71 82 21 c3 08 22 20 80 0f 03 20 28 b1 00 12  *q.!.." ... (...
        00 21 25 08 5e 02 0a 70 58 21 c1 28 22 20 80 0f  .!%.^..pX!.(" ..
        03 20 28 b1 0a 70 2a 71 82 21 82 00 22 20 80 0f  . (..p*q.!.." ..
        03 20 28 b1 00 12 00 21 e6 b8 d1 20 21 82 2b f4  . (....!... !.+.
        00 dd 14 f0 0a 70 c9 71 22 20 80 0f 03 20 d4 ad  .....p.q" ... ..
        80 e0 ca 20 01 04 ca 21 41 03 ca 22 21 00 e2 20  ... ...!A.."!.. 
        81 0f 03 20 c8 b0 c9 75 cf e5 55 f6 c1 6d cf 7e  ... ...u..U..m.~
        d5 0e 50 90 f3 0d 52 90 ce e5 37 f6 0a 70 c9 71  ..P...R...7..p.q
        22 20 80 0f                                      " ..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.081457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.081548
        Address: 0x08002814
        Mode: Byte access (0x00)
        Length: 244
        03 20 d4 ad ef e8 29 6d 2f 79 0a 70 dc f1 0a 70  . ....)m/y.p...p
        22 20 80 0f 03 20 00 af 4a 24 40 20 05 f0 40 24  " ... ..J$@ ..@$
        54 20 2f 24 07 25 4c 24 80 a0 3c 01 0a 00 f3 0b  T /$.%L$..<.....
        10 a0 0a 70 22 20 80 0f 03 20 00 af e3 08 33 85  ...p" ... ....3.
        08 77 00 dd 17 f0 e0 78 c0 64 00 30 6c 45 00 30  .w.....x.d.0lE.0
        40 66 00 30 c0 66 00 30 e7 65 00 30 01 d8 89 e8  @f.0.f.0.e.0....
        00 24 41 33 2c 89 00 24 40 33 85 b9 2c a8 01 e5  .$A3,..$@3..,...
        af 7d cf e5 86 00 0a 00 2a 70 82 20 c3 08 a9 71  .}......*p. ...q
        22 20 80 0f 03 20 d4 ad 08 e8 00 24 41 33 2c 89  " ... .....$A3,.
        00 24 40 33 80 b9 2c a8 58 21 c0 28 a9 71 22 20  .$@3..,.X!.(.q" 
        80 0f 03 20 d4 ad 09 e8 00 24 41 33 2c 89 00 24  ... .....$A3,..$
        40 33 83 b9 2c a8 2a 70 82 20 82 00 a9 71 22 20  @3..,.*p. ...q" 
        80 0f 03 20 d4 ad 09 e8 00 24 41 33 2c 89 00 24  ... .....$A3,..$
        40 33 84 b9 2c a8 00 de 0d f0 12 6e 14 78 a2 70  @3..,......n.x.p
        a9 71 22 20 80 0f 03 20 08 b1 75 08 d0 80 01 e6  .q" ... ..u.....
        cf 7e eb 0e                                      .~..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.083459
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.083542
        Address: 0x08002908
        Mode: Byte access (0x00)
        Length: 244
        d2 91 00 d8 b3 f1 00 12 00 21 a1 de 3f dd 15 08  .........!..?...
        5e 02 8e 11 80 a0 8d 11 81 a0 10 71 ca 26 6b 1e  ^..........q.&k.
        25 0e de 11 04 25 83 13 6f 7b 40 24 04 33 0a 70  %....%..o{@$.3.p
        e9 71 14 da 0a 25 00 05 4a 26 40 00 4a 27 00 00  .q...%..J&@.J'..
        e1 fe 08 77 25 0f 13 15 04 25 83 13 6f 7b 40 24  ...w%....%..o{@$
        04 33 0a 70 e9 71 14 da 0a 25 00 05 4a 26 40 00  .3.p.q...%..J&@.
        4a 27 00 00 08 ff 08 77 b9 0f 32 95 bd 7d 5f f1  J'.....w..2..}_.
        9d d5 0a 71 0a da 40 25 c0 14 22 20 80 0f 06 20  ...q..@%.." ... 
        b8 1f 0c e8 40 25 c0 14 8b 71 0a da 22 20 80 0f  ....@%...q.." ..
        06 20 a0 1e 09 0b 11 20 00 d8 03 f0 01 d8 b7 c0  . ..... ........
        20 20 80 0f 06 20 70 20 f1 c0 22 20 80 0f 06 20    ... p .." ... 
        2c 20 3a 70 00 df e9 76 e9 75 1a 77 16 f0 c9 70  , :p...v.u.w...p
        22 20 80 0f 03 20 ec ad 88 d4 14 20 01 00 35 78  " ... ..... ..5x
        1b 79 98 61 2a 71 22 20 80 0f 03 20 f8 b5 80 e0  .y.a*q" ... ....
        ca 20 42 23 01 e6 cf 7e 4d 0e d3 11 c9 70 22 20  . B#...~M....p" 
        80 0f 03 20                                      ...             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.085458
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.085540
        Address: 0x080029fc
        Mode: Byte access (0x00)
        Length: 244
        18 ed 8c 20 c3 8f f6 f3 c9 70 22 20 80 0f 04 20  ... .....p" ... 
        e4 0f 82 e0 cc 20 62 80 ec f5 78 d2 32 6e 34 79  ..... b...x.2n4y
        29 62 01 dd 17 09 51 00 a3 08 50 80 74 d0 2a 71  )b....Q...P.t.*q
        22 20 80 0f 03 20 f8 b5 dc f1 01 e7 ef 7f da f1  " ... ..........
        05 ed 80 e7 ca 20 69 00 0c f6 00 d8 0a ed 6c d0  ..... i.......l.
        2a 71 22 20 80 0f 03 20 f8 b5 05 20 00 04 0f 78  *q" ... ... ...x
        20 20 80 0f 06 20 90 20 f1 c0 22 20 80 0f 06 20    ... . .." ... 
        38 20 22 20 80 0f 03 20 ec ad ff dd 43 08 40 03  8 " ... ....C.@.
        78 17 0e f6 14 20 01 00 35 78 0a d9 14 7e 68 1e  x.... ..5x...~h.
        42 13 c9 70 73 e0 22 20 80 0f 06 20 ac 23 c9 70  B..ps." ... .#.p
        69 e0 a9 71 09 da 22 20 80 0f 06 20 50 1f 7f d8  i..q.." ... P...
        72 1e 02 10 00 d8 7e 1e 04 10 80 1e 02 10 20 20  r.....~.......  
        80 0f 06 20 a8 20 e0 78 f1 c0 22 20 80 0f 06 20  ... . .x.." ... 
        28 20 64 17 11 f6 4f d9 2a 70 80 20 82 0d 22 20  ( d...O.*p. .." 
        80 0f 06 20 ac 23 62 17 0d f6 0d d9 a9 70 82 20  ... .#b......p. 
        c3 0e 22 20                                      .."             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.087458
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.087540
        Address: 0x08002af0
        Mode: Byte access (0x00)
        Length: 244
        80 0f 06 20 ac 23 40 21 80 22 ff d9 06 da 22 20  ... .#@!."...." 
        80 0f 06 20 50 1f a9 70 82 20 43 0b ff d9 09 da  ... P..p. C.....
        22 20 80 0f 06 20 50 1f 7f d8 5a 70 1c 1d 02 90  " ... P...Zp....
        a9 70 82 20 43 06 14 d9 22 20 80 0f 06 20 ac 23  .p. C..." ... .#
        a9 70 82 20 c2 0e 0a d9 22 20 80 0f 06 20 ac 23  .p. ...." ... .#
        a9 70 82 20 43 01 0a d9 22 20 80 0f 06 20 ac 23  .p. C..." ... .#
        00 dd 03 df 8a 20 c3 2f 14 25 41 13 15 25 40 10  ..... ./.%A..%@.
        14 21 0e 20 68 1e 02 14 c9 70 73 e0 0a d9 22 20  .!. h....ps..." 
        80 0f 06 20 ac 23 c9 70 69 e0 0a 71 09 da 22 20  ... .#.pi..q.." 
        80 0f 06 20 50 1f 72 1e 82 14 00 d8 7e 1e 04 10  ... P.r.....~...
        80 1e 02 10 61 bf 01 e5 bd 0f 75 90 af 7d 20 20  ....a.....u..}  
        80 0f 06 20 88 20 e0 78 e1 c5 30 17 03 f6 8e 13  ... . .x..0.....
        80 80 8d 13 81 80 33 09 03 00 11 d1 4a 24 80 72  ......3.....J$.r
        00 dd a8 20 80 03 ba 63 b8 63 74 10 80 80 1d 12  ... ...c.ct.....
        82 80 bc 61 01 e5 af 7d 44 78 00 ac 09 89 c6 b8  ...a...}Dx......
        09 a9 01 d8                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.089457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.089539
        Address: 0x08002be4
        Mode: Byte access (0x00)
        Length: 244
        02 f0 00 d8 e0 7f c1 c5 c0 65 00 30 29 65 00 30  .........e.0)e.0
        d3 64 00 30 d3 65 00 30 b8 3a 00 08 14 78 19 61  .d.0.e.0.:...x.a
        14 d0 e0 7f f0 20 40 00 f1 c0 e1 c5 69 88 08 72  ..... @.....i..r
        83 e3 aa 88 ca 23 41 03 0f f2 02 92 1b 08 df 00  .....#A.........
        81 e5 cc 23 61 80 06 f2 82 e5 cc 23 a1 80 05 f4  ...#a......#....
        09 d0 0c a2 08 f0 68 70 a9 71 f1 ff 0c a2 a9 70  ......hp.q.....p
        68 71 ef ff 0d a2 20 20 80 0f 06 20 b0 20 e0 78  hq....  ... . .x
        e4 39 00 08 b0 5a 00 20 f1 c0 22 20 80 0f 06 20  .9...Z. .." ... 
        38 20 5a d5 08 85 0a e8 00 de c9 71 02 da 22 20  8 Z........q.." 
        80 0f 05 20 5c 62 c8 a5 06 85 0a e8 01 d9 02 da  ... \b..........
        22 20 80 0f 05 20 5c 62 00 d8 06 a5 50 d5 00 85  " ... \b....P...
        84 10 00 06 09 e8 22 20 80 0f 00 20 98 34 00 85  ......" ... .4..
        00 d9 84 18 58 00 20 20 80 0f 06 20 a8 20 e0 78  ....X.  ... . .x
        f1 c0 48 d0 00 80 b0 10 00 00 00 80 08 e0 22 20  ..H..........." 
        80 0f 05 20 38 d4 42 d1 20 81 24 89 80 e1 ca 20  ... 8.B. .$.... 
        61 00 d3 20                                      a..             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.091460
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.091543
        Address: 0x08002cd8
        Mode: Byte access (0x00)
        Length: 244
        22 00 d1 c0 e0 7e e0 78 01 d9 3e d0 e0 7f 20 a8  "....~.x..>... .
        f1 c0 22 20 80 0f 06 20 28 20 e4 17 10 70 00 10  .." ... ( ...p..
        00 20 39 d7 b0 10 00 00 00 80 08 e0 22 20 80 0f  . 9........." ..
        05 20 38 d4 15 08 1e 00 34 d1 28 b8 cd b8 00 a1  . 8.....4.(.....
        01 d8 00 af f1 ff 54 f0 20 8f a5 09 51 00 2f d6  ......T. ...Q./.
        41 28 01 02 00 86 cd b9 0b 09 00 00 20 a6 eb ff  A(.......... ...
        46 f0 a0 17 11 70 a8 17 12 70 00 11 82 20 29 d5  F....p...p... ).
        0d ea 20 a6 22 20 80 0f 00 20 6c 50 00 1a 00 20  .. ." ... lP... 
        00 d8 00 a5 00 19 02 20 0f f0 22 20 80 0f 00 20  ....... .." ... 
        6c 50 00 12 01 20 22 78 0f 08 33 00 00 a5 c7 70  lP... "x..3....p
        ff 07 ff ff 00 a5 49 0e 03 70 00 00 c8 00 22 20  ......I..p...." 
        80 0f 00 20 f8 56 3a 70 02 d8 22 20 80 0f 05 20  ... .V:p.." ... 
        08 da 2a 70 22 20 80 0f 00 20 04 57 00 10 00 20  ..*p" ... .W... 
        b0 10 00 00 00 80 08 e0 22 20 80 0f 05 20 38 d4  ........" ... 8.
        28 b8 cd b8 00 a6 c9 ff 00 d8 00 af 20 20 80 0f  (...........  ..
        06 20 88 20                                      . .             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.093459
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.093541
        Address: 0x08002dcc
        Mode: Byte access (0x00)
        Length: 244
        78 04 00 30 c4 12 00 30 b8 12 00 30 ed 12 00 30  x..0...0...0...0
        ec 12 00 30 e0 12 00 30 e4 12 00 30 e8 12 00 30  ...0...0...0...0
        03 d0 20 80 01 81 a9 b8 e0 7f 01 a1 c4 12 00 30  .. ............0
        f1 c0 22 20 80 0f 06 20 38 20 2f d0 00 80 ac 10  .." ... 8 /.....
        0d 00 2e d0 22 80 c1 80 40 25 00 15 8f b9 22 20  ...."...@%...." 
        80 0f 05 20 3c d4 4f 26 c1 13 40 25 00 16 28 72  ... <.O&..@%..(r
        22 20 80 0f 05 20 40 d4 20 20 80 0f 06 20 a8 20  " ... @.  ... . 
        21 d0 00 80 21 d1 23 81 ac 10 00 00 00 da 8f b9  !...!.#.........
        18 e0 20 20 80 0f 05 20 40 d4 e0 78 f1 c0 22 20  ..  ... @..x.." 
        80 0f 06 20 38 20 1a d5 08 85 8a e8 19 d0 00 80  ... 8 ..........
        80 20 09 06 22 20 80 0f 05 20 50 dd 06 85 89 e8  . .." ... P.....
        02 d8 01 d9 22 20 80 0f 00 20 0c 34 06 a5 11 d6  ...." ... .4....
        20 86 84 11 00 06 05 e8 60 11 00 06 8f e8 03 d8   .......`.......
        00 d9 22 20 80 0f 00 20 0c 34 40 86 40 20 01 0c  .." ... .4@.@ ..
        84 1a 18 00 cb 1a 58 00 02 a5 20 20 80 0f 06 20  ......X...  ... 
        a8 20 e0 78                                      . .x            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.095460
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.095544
        Address: 0x08002ec0
        Mode: Byte access (0x00)
        Length: 244
        b8 12 00 30 10 3a 00 08 78 04 00 30 c4 12 00 30  ...0.:..x..0...0
        f1 c0 1e d1 00 a9 0f e8 22 20 80 0f 00 20 c0 dd  ........" ... ..
        8e e8 22 20 80 0f 00 08 fc 2d 1a 08 00 00 d1 c0  .." .....-......
        e0 7e 22 20 80 0f 00 08 3c 2e fb f1 f9 f1 e0 78  .~" ....<......x
        13 d0 00 d9 20 a8 13 d0 20 a8 13 d0 20 a8 e0 7f  .... ... ... ...
        21 a8 e0 78 f1 c0 e1 c5 10 d5 00 8d 0f e8 22 20  !..x.........." 
        80 0f 00 08 e0 2c 0e d8 22 20 80 0f 00 20 2c 56  .....,.." ... ,V
        0e d8 22 20 80 0f 00 20 f8 55 00 d8 00 ad 20 20  .." ... .U....  
        80 0f 06 20 b0 20 e0 78 62 0c 00 30 59 0c 00 30  ... . .xb..0Y..0
        58 0c 00 30 60 0c 00 30 63 0c 00 30 a1 c0 20 20  X..0`..0c..0..  
        80 0f 00 08 68 2f e0 7e f1 c0 22 20 80 0f 06 20  ....h/.~.." ... 
        2c 20 43 d7 08 76 14 78 1a 72 15 26 02 10 16 27  , C..v.x.r.&...'
        8d 10 9e 15 80 10 3a 71 68 71 85 e8 1e 95 0b 08  ......:qhq......
        9f 00 0c d8 26 f0 0d 08 de 01 e8 b8 1a d8 22 f2  ....&.........".
        54 25 40 1b 10 da 22 20 80 0f 06 20 a0 1e 9c 1d  T%@..." ... ....
        04 14 54 25                                      ..T%            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.097459
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.097552
        Address: 0x08002fb4
        Mode: Byte access (0x00)
        Length: 244
        40 1a 2a 71 08 da 22 20 80 0f 06 20 a0 1e 00 d8  @.*q.." ... ....
        29 8f 0f 20 80 03 0b 79 06 f2 2d d2 20 8a 25 78  ).. ...y..-. .%x
        00 aa 05 f0 12 08 20 00 c9 70 00 d8 20 20 80 0f  ...... ..p..  ..
        06 20 90 20 f1 c0 22 20 80 0f 06 20 30 20 23 d5  . . .." ... 0 #.
        08 76 09 8d 4a 20 40 20 14 26 81 13 0f 20 80 03  .v..J @ .&... ..
        09 ad 15 26 40 10 16 7d 1e 95 a1 c1 8b 77 3d 08  ...&@..}.....w=.
        df 02 c9 70 22 20 80 0f 03 20 58 7f 9c 15 02 11  ...p" ... X.....
        e9 70 54 25 41 1a 54 25 43 1e 54 25 44 1d 22 20  .pT%A.T%C.T%D." 
        80 0f 03 20 58 99 00 c1 c9 70 03 da 22 20 80 0f  ... X....p.." ..
        03 20 2c 96 0a 70 12 f0 8c b8 1e b5 e9 70 0a d9  . ,..p.......p..
        22 20 80 0f 03 20 fc 99 00 c1 c9 70 03 da 22 20  " ... .....p.." 
        80 0f 03 20 2c 96 05 d8 9e 1d 02 10 01 d8 a1 c0  ... ,...........
        20 20 80 0f 06 20 98 20 18 17 00 30 26 3a 00 08    ... . ...0&:..
        a1 c0 20 20 80 0f 00 08 90 30 e0 7e f1 c0 22 20  ..  .....0.~.." 
        80 0f 06 20 30 20 87 e0 10 01 2a 00 08 77 e0 d6  ... 0 ....*..w..
        14 27 c1 13                                      .'..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.099459
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.099541
        Address: 0x080030a8
        Mode: Byte access (0x00)
        Length: 244
        15 27 40 10 16 26 0d 10 3e 95 21 09 9e 00 00 86  .'@..&..>.!.....
        e8 b8 ca 20 c2 03 ca 21 22 01 ca 22 42 00 e2 20  ... ...!".."B.. 
        82 0f 00 20 b4 c5 12 f0 8a 20 c3 2f 1d 09 5f 00  ... ..... ./.._.
        1b 8e 19 0f 01 10 e9 70 04 d9 28 72 22 20 80 0f  .......p..(r" ..
        00 20 b4 c5 1b 1e 02 14 e9 70 22 20 80 0f 03 20  . .......p" ... 
        c4 a0 ff d8 4a 1d 02 10 1e 95 05 d9 a6 b8 1e b5  ....J...........
        a9 70 80 20 82 04 22 20 80 0f 06 20 ac 23 a9 70  .p. .." ... .#.p
        80 20 c2 05 05 d9 22 20 80 0f 06 20 ac 23 1e 95  . ...." ... .#..
        40 27 01 13 a3 b8 04 20 80 0f 00 00 68 ff 1e b5  @'..... ....h...
        00 86 10 20 40 00 00 a6 b9 d0 1f b5 40 1d 04 10  ... @.......@...
        42 1d 04 10 1e 95 a5 b8 1e b5 e9 70 22 20 80 0f  B..........p" ..
        03 20 e4 9c 1e 95 ab b8 1e b5 00 d8 9e 1d 02 10  . ..............
        1e 95 ac b8 1e b5 e9 70 22 20 80 0f 03 20 34 9c  .......p" ... 4.
        ac d2 00 d8 0f 20 c0 03 20 8a 12 78 04 79 20 aa  ..... .. ..x.y .
        3e 95 04 21 81 0f 00 00 ff 9e 3e b5 26 8e 04 79  >..!......>.&..y
        26 ae 27 8e                                      &.'.            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.101472
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.101531
        Address: 0x0800319c
        Mode: Byte access (0x00)
        Length: 244
        04 79 27 ae 28 8e 04 79 28 ae 29 8e 24 78 09 ae  .y'.(..y(.).$x..
        20 20 80 0f 06 20 98 20 a1 c0 20 20 80 0f 00 08    ... . ..  ....
        c0 31 e0 7e f1 c0 22 20 80 0f 06 20 28 20 99 d0  .1.~.." ... ( ..
        00 88 a1 c1 80 e0 e2 02 22 00 00 dd 92 d6 06 8e  ........".......
        21 e8 12 f0 00 df 06 8e 0f 27 4f 13 0b 7f 4a 20  !........'O...J 
        40 20 08 f2 14 d8 22 20 80 0f 00 20 5c 35 88 e8  @ ...." ... \5..
        01 e5 af 7d e1 0d d2 91 00 dd 0d f0 a9 70 16 d9  ...}.........p..
        13 da 22 20 80 0f 03 20 9c 70 06 8e 0a 75 e6 78  .." ... .p...u.x
        06 ae 14 d8 22 20 80 0f 00 20 5c 35 82 e0 8a 02  ...." ... \5....
        0b 00 8c ed 00 86 15 08 5e 01 00 d8 ff d9 22 20  ........^....." 
        80 0f 03 20 64 7b 08 75 99 0d 11 10 2b 8e 95 09  ... d{.u....+...
        10 00 00 df 29 f0 14 27 c3 13 15 27 c1 10 16 26  ....)..'...'...&
        42 10 3e 92 8b 70 46 12 02 01 51 21 40 82 01 d9  B.>..pF...Q!@...
        c2 21 41 00 80 e1 01 d9 c0 79 22 20 80 0f 03 20  .!A......y" ... 
        10 99 00 c1 e9 70 00 da 22 20 80 0f 03 20 2c 96  .....p.." ... ,.
        0c 8e 2b 8e                                      ..+.            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.103466
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.103562
        Address: 0x08003290
        Mode: Byte access (0x00)
        Length: 244
        2a 75 05 20 00 04 0c ae 06 21 01 04 2b ae 01 e7  *u. .....!..+...
        ef 7f 2f 0f d3 11 4a 20 00 20 0f 20 d0 23 0b 21  ../...J . . .#.!
        00 84 4a 21 40 20 f5 f3 09 8e 0b 20 00 84 f1 f5  ..J!@ ..... ....
        14 d8 22 20 80 0f 00 20 5c 35 8b 08 93 80 ff d8  .." ... \5......
        00 d9 02 da 22 20 80 0f 03 20 2c 96 95 0d 11 10  ...." ... ,.....
        0f 8e 91 08 10 00 00 df 27 f0 14 27 c2 13 15 27  ........'..'...'
        81 10 16 26 43 10 40 13 04 01 8b 70 42 13 05 01  ...&C.@....pB...
        48 13 06 01 32 8e 4a 96 7f 93 22 20 80 0f 03 20  H...2.J..." ... 
        a0 98 00 c1 e9 70 00 da 22 20 80 0f 03 20 2c 96  .....p.." ... ,.
        10 8e 2a 75 05 20 00 04 10 ae 0f 8e 06 20 00 04  ..*u. ....... ..
        0f ae 01 e7 ef 7f 2f 0f d3 11 4a 20 00 20 0f 20  ....../...J . . 
        d0 23 0b 20 00 84 4a 21 40 20 f5 f3 29 8e 0b 21  .#. ..J!@ ..)..!
        00 84 f1 f5 14 d8 22 20 80 0f 00 20 5c 35 8f 08  ......" ... \5..
        93 80 ff d8 00 d9 02 da 22 20 80 0f 03 20 2c 96  ........" ... ,.
        b6 ed 07 8e 34 e8 00 df 03 f0 01 e7 ef 7f 61 0f  ....4.........a.
        d3 11 4a 20                                      ..J             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.105466
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.105563
        Address: 0x08003384
        Mode: Byte access (0x00)
        Length: 244
        00 20 0f 20 d0 23 0b 20 00 84 f7 f3 29 8e 0b 21  . . .#. ....)..!
        00 84 f3 f5 14 27 c0 13 15 27 01 10 16 26 51 10  .....'...'...&Q.
        3c 11 00 21 01 d9 25 b8 52 20 12 00 e9 70 22 20  <..!..%.R ...p" 
        80 0f 03 20 e0 97 07 8e 53 22 0d 20 06 20 00 04  ... ....S". . ..
        07 ae b7 0a 1e a0 3c 11 01 21 09 8e 83 b9 3c 19  ......<..!....<.
        44 20 05 20 00 04 09 ae 9a ed 48 8e 18 ea 00 d8  D . ......H.....
        03 f0 01 e0 0f 78 29 08 d3 01 00 df 0f 27 0f 10  .....x)......'..
        eb 7a f9 f3 29 8e eb 79 f5 f5 22 20 80 0f 03 20  .z..)..y.." ... 
        34 71 85 e8 08 8e e6 78 08 ae 01 dd b7 ed 18 17  4q.....x........
        10 70 00 10 80 20 33 e8 00 df 0c f0 18 17 00 30  .p... 3........0
        ff ff 00 00 26 3a 00 08 27 11 00 30 01 e7 ef 7f  ....&:..'..0....
        4b 0f d3 11 4a 21 00 20 00 10 80 20 0f 21 d1 23  K...J!. ... .!.#
        0b 20 40 84 f4 f3 09 8e 0b 20 40 84 f0 f5 14 27  . @...... @....'
        c1 13 15 27 40 10 33 68 19 d0 28 60 e8 e8 e9 70  ...'@.3h..(`...p
        22 20 80 0f 00 08 e8 2f 0a 25 00 90 e0 f3 00 10  " ...../.%......
        80 20 06 20                                      . .             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.107460
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.107539
        Address: 0x08003478
        Mode: Byte access (0x00)
        Length: 244
        40 04 00 18 02 20 9b ed 11 d0 00 88 17 e8 00 de  @.... ..........
        03 f0 01 e6 cf 7e 27 0e d3 11 14 26 81 13 15 26  .....~'....&...&
        40 10 33 68 09 d0 28 60 f5 e8 c9 70 22 20 80 0f  @.3h..(`...p" ..
        03 20 f4 9b 6f e8 01 dd f9 f1 a9 70 a1 c0 20 20  . ..o......p..  
        80 0f 06 20 88 20 e0 78 b6 17 00 30 28 11 00 30  ... . .x...0(..0
        4a 22 00 10 4a 23 c0 10 20 20 80 0f 06 20 78 2b  J"..J#..  ... x+
        4a 22 40 10 4a 23 80 11 20 20 80 0f 06 20 78 2b  J"@.J#..  ... x+
        4a 22 00 11 4a 23 c0 10 20 20 80 0f 06 20 78 2b  J"..J#..  ... x+
        4a 22 40 10 4a 23 40 10 20 20 80 0f 06 20 64 2b  J"@.J#@.  ... d+
        e1 c5 cf 70 06 20 20 46 20 80 01 db cf 70 06 20  ...p.  F ....p. 
        24 46 28 19 e0 00 40 80 8a 25 11 12 cf 70 80 00  $F(...@..%...p..
        20 40 60 1a 60 03 68 1a 20 00 cf 70 24 00 00 24   @`.`.h. ..p$..$
        6c 1a 20 00 64 d8 20 1a e0 00 1c 1a 20 00 04 d8  l. .d. ..... ...
        18 1a 20 00 00 d8 28 19 20 00 00 d8 91 b8 81 19  .. ...(. .......
        38 00 e0 7f c1 c5 e0 78 cf 71 06 20 24 46 20 81  8......x.q. $F .
        1c 19 20 00                                      .. .            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.109457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.109536
        Address: 0x0800356c
        Mode: Byte access (0x00)
        Length: 244
        e0 7e e0 78 cf 71 06 20 24 46 20 81 18 19 20 00  .~.x.q. $F ... .
        e0 7e e0 78 cf 71 06 20 24 46 20 81 04 19 20 00  .~.x.q. $F ... .
        e0 7e e0 78 cf 70 06 20 20 46 00 80 00 d9 28 18  .~.x.p.  F....(.
        60 00 e0 7e cf 70 06 20 20 46 00 80 01 d9 28 18  `..~.p.  F....(.
        60 00 e0 7e cf 71 06 20 24 46 40 81 48 12 01 08  `..~.q. $F@.H...
        20 a0 4c 12 01 08 e0 7f 24 a8 e0 78 f1 c0 e1 c5   .L.....$..x....
        08 75 cf 70 06 20 24 46 00 80 50 10 00 08 04 20  .u.p. $F..P.... 
        80 0f 00 80 ff 00 00 a5 03 8d 86 20 fd 0f 42 28  ........... ..B(
        fe 81 0e f2 00 8d 22 20 80 0f 00 20 30 41 00 ad  ......" ... 0A..
        a9 70 22 20 80 0f 00 20 50 41 06 f0 cf 70 ad de  .p" ... PA...p..
        ef be 00 a5 20 20 80 0f 06 20 b0 20 cf 71 06 20  ....  ... . .q. 
        24 46 20 81 38 11 01 08 20 a0 03 88 86 20 fd 0f  $F .8... .... ..
        e0 7f 47 b8 f1 c0 e1 c5 08 75 cf 70 06 20 24 46  ..G......u.p. $F
        00 80 5c 10 00 08 04 20 80 0f 00 80 ff 00 00 a5  ..\.... ........
        03 8d 86 20 fd 0f 42 28 fe 81 0e f2 00 8d 22 20  ... ..B(......" 
        80 0f 00 20                                      ...             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.111457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.111536
        Address: 0x08003660
        Mode: Byte access (0x00)
        Length: 244
        30 41 00 ad a9 70 22 20 80 0f 00 20 50 41 06 f0  0A...p" ... PA..
        cf 70 ad de ef be 00 a5 20 20 80 0f 06 20 b0 20  .p......  ... . 
        cf 71 06 20 24 46 20 81 44 11 01 08 20 a0 03 88  .q. $F .D... ...
        86 20 fd 0f e0 7f 47 b8 cf 70 06 20 24 46 00 80  . ....G..p. $F..
        01 d9 28 18 60 00 e0 7e cf 71 06 20 24 46 20 81  ..(.`..~.q. $F .
        20 19 20 00 e0 7e e0 78 cf 70 06 20 20 46 00 80   . ..~.x.p.  F..
        01 d9 28 18 60 00 cf 70 06 20 24 46 00 80 02 d9  ..(.`..p. $F....
        04 18 60 00 e0 7e e0 78 cf 74 00 9f 00 00 04 b8  ..`..~.x.t......
        14 78 9a 60 20 12 00 08 26 78 20 1a 20 00 e0 7e  .x.` ...&x . ..~
        cf 74 00 9f 00 00 04 b8 14 78 9a 60 28 12 00 08  .t.......x.`(...
        26 78 28 1a 20 00 e0 7e cf 74 00 9f 00 00 04 b8  &x(. ..~.t......
        14 78 9a 60 28 12 00 08 05 79 28 1a 60 00 e0 7e  .x.`(....y(.`..~
        cf 71 00 9f 00 00 3c 11 00 08 8c b8 3c 19 20 00  .q....<.....<. .
        40 11 00 08 8c b8 40 19 20 00 e0 7e cf 71 00 9f  @.....@. ..~.q..
        00 00 3c 11 00 08 8d b8 8e b8 3c 19 20 00 40 11  ..<.......<. .@.
        00 08 ad b8                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.113457
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.113537
        Address: 0x08003754
        Mode: Byte access (0x00)
        Length: 244
        ae b8 40 19 20 00 e0 7e cf 74 00 9f 00 00 04 b8  ..@. ..~.t......
        14 78 9a 60 30 12 00 08 26 78 30 1a 20 00 e0 7e  .x.`0...&x0. ..~
        cf 74 00 9f 00 00 04 b8 14 78 9a 60 30 12 00 08  .t.......x.`0...
        05 79 30 1a 60 00 e0 7e cf 74 00 9f 00 00 04 b8  .y0.`..~.t......
        14 78 9a 60 2c 12 00 08 26 78 2c 1a 20 00 e0 7e  .x.`,...&x,. ..~
        cf 74 00 9f 00 00 04 b8 14 78 9a 60 2c 12 00 08  .t.......x.`,...
        05 79 2c 1a 60 00 e0 7e cf 71 00 9f 2c 00 04 b8  .y,.`..~.q..,...
        14 78 30 21 00 80 e0 7e cf 74 00 9f 2c 00 04 b8  .x0!...~.t..,...
        14 78 9a 60 00 1a 60 00 e0 7e e0 78 cf 70 00 9f  .x.`..`..~.x.p..
        00 00 10 10 00 08 e0 7e cf 71 00 9f 00 00 10 19  .......~.q......
        20 00 e0 7e cf 74 00 9f 00 00 04 b8 14 78 9a 60   ..~.t.......x.`
        38 12 00 08 26 78 38 1a 20 00 e0 7e cf 74 00 9f  8...&x8. ..~.t..
        00 00 04 b8 14 78 9a 60 34 12 00 08 26 78 34 1a  .....x.`4...&x4.
        20 00 e0 7e cf 74 00 9f 00 00 04 b8 14 78 9a 60   ..~.t.......x.`
        34 12 00 08 05 79 34 1a 60 00 e0 7e cf 74 00 9f  4....y4.`..~.t..
        00 00 04 b8                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.115452
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 250       [hci0] 22.115531
        Address: 0x08003848
        Mode: Byte access (0x00)
        Length: 244
        14 78 9a 60 38 12 00 08 05 79 38 1a 60 00 e0 7e  .x.`8....y8.`..~
        cf 71 00 9f 24 00 04 b8 14 78 30 21 00 80 e0 7e  .q..$....x0!...~
        cf 74 00 9f 00 00 04 b8 14 78 9a 60 20 12 00 08  .t.......x.` ...
        05 79 20 1a 60 00 e0 7e cf 71 00 9f 24 00 04 b8  .y .`..~.q..$...
        14 78 30 21 00 80 e0 7e cf 71 00 9f 00 00 3c 11  .x0!...~.q....<.
        00 08 45 20 40 01 3c 19 20 00 40 11 00 08 80 b8  ..E @.<. .@.....
        40 19 20 00 40 11 00 08 a2 b8 40 19 20 00 e0 7e  @. .@.....@. ..~
        cf 71 00 9f 00 00 3c 11 00 08 84 b8 3c 19 20 00  .q....<.....<. .
        40 11 00 08 a4 b8 40 19 20 00 e0 7e cf 71 00 9f  @.....@. ..~.q..
        00 00 3c 11 00 08 a4 b8 3c 19 20 00 e0 7e e0 78  ..<.....<. ..~.x
        cf 71 00 9f 00 00 3c 11 00 08 86 b8 3c 19 20 00  .q....<.....<. .
        40 11 00 08 a6 b8 40 19 20 00 e0 7e cf 71 00 9f  @.....@. ..~.q..
        00 00 3c 11 00 08 a6 b8 3c 19 20 00 e0 7e e0 78  ..<.....<. ..~.x
        cf 71 00 9f 00 00 3c 11 00 08 8e b8 8f b8 3c 19  .q....<.......<.
        20 00 40 11 00 08 ae b8 af b8 40 19 20 00 e0 7e   .@.......@. ..~
        cf 74 00 9f                                      .t..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.117452
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 242       [hci0] 22.117531
        Address: 0x0800393c
        Mode: Byte access (0x00)
        Length: 236
        20 00 04 b8 14 78 9a 60 00 1a 60 00 e0 7e e0 78   ....x.`..`..~.x
        cf 74 00 9f 00 00 04 b8 14 78 9a 60 4c 12 00 08  .t.......x.`L...
        26 78 4c 1a 20 00 e0 7e cf 74 00 9f 00 00 04 b8  &xL. ..~.t......
        14 78 9a 60 4c 12 00 08 05 79 4c 1a 60 00 e0 7e  .x.`L....yL.`..~
        cf 72 00 30 04 00 20 12 81 00 7f 8a 05 e8 5e 8a  .r.0.. .......^.
        78 62 38 60 02 f0 38 63 e0 7f 22 b8 cf 70 00 bc  xb8`..8c.."..p..
        00 00 20 10 00 08 8c 20 45 81 e0 7f 6f 20 0b 00  .. .... E...o ..
        00 d9 08 74 80 24 10 10 20 a4 8a 21 10 00 20 20  ...t.$.. ..!..  
        80 0f 06 20 ac 23 e0 78 c8 b8 0e 20 82 0f 00 00  ... .#.x... ....
        00 02 50 71 ca 20 86 00 e0 7f ca 20 45 00 00 00  ..Pq. ..... E...
        00 00 00 00 00 00 00 00 8c 5f 00 20 6c 5f 00 20  ........._. l_. 
        7c 5f 00 20 24 5f 00 20 04 5f 00 20 14 5f 00 20  |_. $_. ._. ._. 
        5c 5f 00 20 34 5f 00 20 48 5f 00 20 00 00 00 00  \_. 4_. H_. ....
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00              ............    
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.119452
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 10        [hci0] 22.119528
        Address: 0x40000000
        Mode: Byte access (0x00)
        Length: 4
        01 2d 0d 00                                      .-..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.120452
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 10        [hci0] 22.120520
        Address: 0x08000100
        Mode: Byte access (0x00)
        Length: 4
        01 2d 0d 1a                                      .-..            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.121452
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 10        [hci0] 22.121526
        Address: 0x30000408
        Mode: Byte access (0x00)
        Length: 4
        14 01 00 08                                      ....            
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.122490
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Memory Write (0x3f|0x008e) plen 9         [hci0] 22.122555
        Address: 0x40000000
        Mode: Byte access (0x00)
        Length: 3
        01 2d 0d                                         .-.             
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.123490
      Intel Memory Write (0x3f|0x008e) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Write BD Data (0x3f|0x002f) plen 80       [hci0] 22.123556
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        00 00 00 2d 31 01                                ...-1.          
        Features: 0xff 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
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
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
        40 fa 1a 20 0a 07 06 08 05 07 07 07 0a 07 06 04  @.. ............
        06 0a a4 09 cc e0 0a 04 00 01 c0 0b 14 08 00 0d  ................
        00 1e 00 b8 0b 64 19 c8 af a8 61 d0 07 04 00 0b  .....d....a.....
        5a 86 86 04 43 b3 7c 02 00 00 00                 Z...C.|....     
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 22.124491
      Intel Write BD Data (0x3f|0x002f) ncmd 1
        Status: Success (0x00)
> HCI Event: Vendor (0xff) plen 2                              [hci0] 22.125488
      Intel Write BD Data Complete (0x19)
        Status: Success (0x00)
< HCI Command: Intel Manufacturer Mode (0x3f|0x0011) plen 2    [hci0] 22.125556
        Mode switch: Disabled (0x00)
        Reset behavior: No reset (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.126458
      Intel Manufacturer Mode (0x3f|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: Vendor (0x3f|0x0060) plen 124                   [hci0] 22.126549
        01 01 01 ff 8e df da 4e 00 00 00 00 ab bf c4 c9  .......N........
        ce d3 d8 dd e2 e7 ec f1 f6 00 00 00 ec ee f0 f2  ................
        f4 f6 f8 fa fc fe 00 02 04 06 08 0a 03 b8 0b 00  ................
        2c 01 32 14 1a 00 00 20 00 90 01 00 03 00 01 00  ,.2.... ........
        02 00 00 03 00 20 00 90 01 00 03 00 01 00 05 00  ..... ..........
        00 03 14 01 00 0a 00 00 03 14 01 00 0a 00 00 03  ................
        14 01 00 0a 00 00 03 14 01 00 0a 00 00 03 14 01  ................
        00 0a 00 00 03 14 01 00 0a 00 00 03              ............    
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.127453
      Vendor (0x3f|0x0060) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Manufacturer Mode (0x3f|0x0011) plen 2    [hci0] 22.127532
        Mode switch: Disabled (0x00)
        Reset behavior: Reset and activate patches (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.139457
      Intel Manufacturer Mode (0x3f|0x0011) ncmd 2
        Status: Success (0x00)
< HCI Command: Intel Manufacturer Mode (0x3f|0x0011) plen 2    [hci0] 22.139540
        Mode switch: Enabled (0x01)
        Reset behavior: No reset (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.140489
      Intel Manufacturer Mode (0x3f|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Set Event Mask (0x3f|0x0052) plen 8       [hci0] 22.140555
        Mask: 0x0000000000000c87
          Bootup
          SCO Rejected via LMP
          PTT Switch Notification
          Scan Status
          Fatal Exception
          System Exception
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.141452
      Intel Set Event Mask (0x3f|0x0052) ncmd 1
        Status: Success (0x00)
< HCI Command: Intel Manufacturer Mode (0x3f|0x0011) plen 2    [hci0] 22.141526
        Mode switch: Disabled (0x00)
        Reset behavior: No reset (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.142452
      Intel Manufacturer Mode (0x3f|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0               [hci0] 22.142522
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 22.143493
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 80:19:34:5A:67:51 (Intel Corporate)
< HCI Command: Reset (0x03|0x0003) plen 0                      [hci0] 22.143560
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.155459
      Reset (0x03|0x0003) ncmd 2
        Status: Success (0x00)
< HCI Command: Read Local Supported Fe.. (0x04|0x0003) plen 0  [hci0] 22.155478
> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 22.156458
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xff 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
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
< HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0  [hci0] 22.156473
> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 22.157457
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.0 (0x06) - Revision 3584 (0x0e00)
        LMP version: Bluetooth 4.0 (0x06) - Subversion 3584 (0x0e00)
        Manufacturer: Intel Corp. (2)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0               [hci0] 22.157472
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 22.158456
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 80:19:34:5A:67:51 (Intel Corporate)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0           [hci0] 22.158548
> HCI Event: Command Complete (0x0e) plen 11                   [hci0] 22.159457
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 5
        SCO MTU: 96   SCO max packet: 6
< HCI Command: Read Class of Device (0x03|0x0023) plen 0       [hci0] 22.159468
> HCI Event: Command Complete (0x0e) plen 7                    [hci0] 22.160454
      Read Class of Device (0x03|0x0023) ncmd 2
        Status: Success (0x00)
        Class: 0x001f00
          Major class: Uncategorized, specific device code not specified
          Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0            [hci0] 22.160467
> HCI Event: Command Complete (0x0e) plen 252                  [hci0] 22.164494
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: Bluemoon Universal Bluetooth Host Controller
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0         [hci0] 22.164541
> HCI Event: Command Complete (0x0e) plen 6                    [hci0] 22.165454
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Supporte.. (0x03|0x0038) plen 0  [hci0] 22.165464
> HCI Event: Command Complete (0x0e) plen 5                    [hci0] 22.166452
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 2
< HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0       [hci0] 22.166465
> HCI Event: Command Complete (0x0e) plen 8                    [hci0] 22.167455
      Read Current IAC LAP (0x03|0x0039) ncmd 2
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1           [hci0] 22.167467
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.168452
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection Accept.. (0x03|0x0016) plen 2  [hci0] 22.168465
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.169452
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0        [hci0] 22.169464
> HCI Event: Command Complete (0x0e) plen 7                    [hci0] 22.170454
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 27
        Num data packets: 7
< HCI Command: LE Read Local Supported.. (0x08|0x0003) plen 0  [hci0] 22.170467
> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 22.171458
      LE Read Local Supported Features (0x08|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
< HCI Command: LE Read Supported States (0x08|0x001c) plen 0   [hci0] 22.171471
> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 22.172458
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
< HCI Command: Read Local Supported Co.. (0x04|0x0002) plen 0  [hci0] 22.172470
> HCI Event: Command Complete (0x0e) plen 68                   [hci0] 22.174456
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
          Remote Name Request (Octet 2 - Bit 3)
          Remote Name Request Cancel (Octet 2 - Bit 4)
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Hold Mode (Octet 4 - Bit 1)
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
          Read Hold Mode Activity (Octet 10 - Bit 0)
          Write Hold Mode Activity (Octet 10 - Bit 1)
          Read Transmit Power Level (Octet 10 - Bit 2)
          Read Sync Flow Control Enable (Octet 10 - Bit 3)
          Write Sync Flow Control Enable (Octet 10 - Bit 4)
          Set Controller To Host Flow Control (Octet 10 - Bit 5)
          Host Buffer Size (Octet 10 - Bit 6)
          Host Number of Completed Packets (Octet 10 - Bit 7)
          Read Link Supervision Timeout (Octet 11 - Bit 0)
          Write Link Supervision Timeout (Octet 11 - Bit 1)
          Read Number of Supported IAC (Octet 11 - Bit 2)
          Read Current IAC LAP (Octet 11 - Bit 3)
          Write Current IAC LAP (Octet 11 - Bit 4)
          Read Page Scan Mode (Octet 11 - Bit 7)
          Write Page Scan Mode (Octet 12 - Bit 0)
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
          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
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
< HCI Command: Write Extended Inquir.. (0x03|0x0052) plen 241  [hci0] 22.174469
        FEC: Not required (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.175456
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1         [hci0] 22.175469
        Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.176452
      Write Inquiry Mode (0x03|0x0045) ncmd 2
        Status: Success (0x00)
< HCI Command: Read Inquiry Response T.. (0x03|0x0058) plen 0  [hci0] 22.176459
> HCI Event: Command Complete (0x0e) plen 5                    [hci0] 22.177452
      Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
        Status: Success (0x00)
        TX power: 10 dBm
< HCI Command: Read Local Extended Fea.. (0x04|0x0004) plen 1  [hci0] 22.177466
        Page: 1
> HCI Event: Command Complete (0x0e) plen 14                   [hci0] 22.178458
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 1/0
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Set Event Mask (0x03|0x0001) plen 8             [hci0] 22.178539
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
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.179453
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7       [hci0] 22.179462
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8                    [hci0] 22.180454
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Success (0x00)
        Max num keys: 5
        Num keys: 0
< HCI Command: Write Default Link Poli.. (0x02|0x000f) plen 2  [hci0] 22.180467
        Link policy: 0x0007
          Enable Role Switch
          Enable Hold Mode
          Enable Sniff Mode
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.181452
      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0    [hci0] 22.181464
> HCI Event: Command Complete (0x0e) plen 8                    [hci0] 22.182455
      Read Page Scan Activity (0x03|0x001b) ncmd 2
        Status: Success (0x00)
        Interval: 1280.000 msec (0x0800)
        Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0        [hci0] 22.182467
> HCI Event: Command Complete (0x0e) plen 5                    [hci0] 22.183454
      Read Page Scan Type (0x03|0x0046) ncmd 2
        Status: Success (0x00)
        Type: Standard Scan (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8          [hci0] 22.183466
        Mask: 0x000000000000001f
          LE Connection Complete
          LE Advertising Report
          LE Connection Update Complete
          LE Read Remote Used Features Complete
          LE Long Term Key Request
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.184452
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Advertising Cha.. (0x08|0x0007) plen 0  [hci0] 22.184465
> HCI Event: Command Complete (0x0e) plen 5                    [hci0] 22.185453
      LE Read Advertising Channel TX Power (0x08|0x0007) ncmd 1
        Status: Success (0x00)
        TX power: 9 dBm
< HCI Command: LE Read White List Size (0x08|0x000f) plen 0    [hci0] 22.185465
> HCI Event: Command Complete (0x0e) plen 5                    [hci0] 22.186453
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 32
< HCI Command: LE Clear White List (0x08|0x0010) plen 0        [hci0] 22.186465
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.187452
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7     [hci0] 22.187530
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 6                    [hci0] 22.188442
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Success (0x00)
        Num keys: 0
= Index Info: 80:19:34:5A:67:51 (Intel Corp.)                  [hci0] 22.188528
@ Index Added
= bluetoothd: Failed to obtain handles for "Service Changed" char..   22.188689
@ New Settings: 0x00c0
            ssp br/edr 
@ New Settings: 0x02c0
            ssp br/edr le 
@ New Settings: 0x0ac0
            ssp br/edr le secure-conn 
@ Device Unblocked: 00:00:00:00:00:00 (0)
@ Device Added: 00:08:4C:FA:B0:47 (0) 1
@ Device Added: 00:12:6F:9D:CF:33 (0) 1
@ Device Added: 00:02:5B:0B:D0:28 (0) 1
@ Device Added: F0:6B:CA:56:23:FB (0) 1
@ Device Added: A0:E9:DB:40:1E:63 (0) 1
@ Device Added: DC:2C:26:5A:03:D6 (0) 1
@ Local Name Changed: laptop ()
@ New Settings: 0x0ad0
            bondable ssp br/edr le secure-conn 
= bluetoothd: Endpoint registered: sender=:1.37 path=/MediaEndpoi..   22.365516
= bluetoothd: Endpoint registered: sender=:1.37 path=/MediaEndpoi..   22.365536
< HCI Command: Write Simple Pairing Mode (0x03|0x0056) plen 1  [hci0] 22.379998
        Mode: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.380454
      Write Simple Pairing Mode (0x03|0x0056) ncmd 1
        Status: Success (0x00)
< HCI Command: Write LE Host Supported (0x03|0x006d) plen 2    [hci0] 22.380465
        Supported: 0x01
        Simultaneous: 0x00
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.381453
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32   [hci0] 22.381471
        Length: 3
        TX power: 9 dBm
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.382451
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Response D.. (0x08|0x0009) plen 32  [hci0] 22.382458
        Length: 8
        Name (complete): laptop
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.383452
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 22.383486
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.384452
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Write Class of Device (0x03|0x0024) plen 3      [hci0] 22.384458
        Class: 0x0c010c
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Laptop
          Rendering (Printing, Speaker)
          Capturing (Scanner, Microphone)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.385451
      Write Class of Device (0x03|0x0024) ncmd 2
        Status: Success (0x00)
< HCI Command: Write Local Name (0x03|0x0013) plen 248         [hci0] 22.385499
        Name: laptop
@ Class of Device Changed: 0x0c010c
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.386452
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Extended Inquir.. (0x03|0x0052) plen 241  [hci0] 22.386481
        FEC: Not required (0x00)
        Name (complete): laptop
        TX power: 10 dBm
        Device ID: USB Implementer's Forum assigned (0x0002)
          Vendor: Linux Foundation (0x1d6b)
          Product: 0x0246
          Version: 5.2.5 (0x0525)
        16-bit Service UUIDs (complete): 7 entries
          Generic Access Profile (0x1800)
          Generic Attribute Profile (0x1801)
          A/V Remote Control (0x110e)
          A/V Remote Control Target (0x110c)
          Headset AG (0x1112)
          Audio Source (0x110a)
          Audio Sink (0x110b)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 22.387452
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
@ New Settings: 0x0ad1
            powered bondable ssp br/edr le secure-conn 
< HCI Command: Intel SW RF Kill (0x3f|0x003f) plen 0           [hci0] 24.186808
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 24.187492
      Intel SW RF Kill (0x3f|0x003f) ncmd 1
        Status: Success (0x00)
= Close Index: 80:19:34:5A:67:51                               [hci0] 24.187553
@ Class of Device Changed: 0x000000
@ New Settings: 0x0ad0
            bondable ssp br/edr le secure-conn 

--------------090603010801060403030009--
