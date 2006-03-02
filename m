Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060302221048.42091.qmail@web33608.mail.mud.yahoo.com>
From: Frans Meulenbroeks <fransmeulenbroeks@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] btsco v0.41 & Logitech HS01-V16 working inconsistently
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 2 Mar 2006 14:10:48 -0800 (PST)

Dear all,

I'm trying to get my Logitech HS01-V16 working with
btsco v0.41 and I encountered a strange problem.

I tried to play a file; first it did not work, then I
started hcidump -X and restarted the file playback. it
worked for a short while and then stopped working.
Stopping and restarting aplay did not give sound.

The hcidump -X log is showing some striking
differences. See the log below. The second time there
is a lot of ff ff and also some small numbers. Note
that this is with the same wav!

First some info.
I'm using bluez 2.25 with hcidump 1.29
OS is 2.6.16 rc4 git 9 on Linksys NSLU2 (ARM, Big
Endian).

headset Logitech HS01-V16
bt usb dongle: Conceptronic Bluetooth 2.0 usb adapter
200M (c04-101)

playback is always done with aplay -B 1000000 -D
plughw:Headset sound.wav (always the same file)

hciconfig -a output:

hci2:   Type: USB
        BD Address: 00:80:5A:46:07:0A ACL MTU: 384:8
SCO MTU: 64:8
        UP RUNNING
        RX bytes:317919 acl:27 sco:6215 events:58
errors:0
        TX bytes:316946 acl:22 sco:6198 commands:26
errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00
0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'NSLU2'
        Class: 0x120104
        Service Classes: Networking
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0
(0x3) LMP Subver: 0x7a6
        Manufacturer: Cambridge Silicon Radio (10)

hciconfig hci0 revision output

hci0:   Type: USB
        BD Address: 00:80:5A:46:07:0A ACL MTU: 384:8
SCO MTU: 64:8
        HCI 19.2
        Chip version: BlueCore4-ROM
        Max key size: 128 bit
        SCO mapping:  HCI

hcitool info output:

Requesting information ...
        BD Address:  00:0D:44:03:A9:C6
        Device Name: Logitech HS01-V16
        LMP Version: 1.2 (0x2) LMP Subversion: 0x611
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00
0x00
                <encryption> <slot offset> <timing
accuracy> <role switch>
                <hold mode> <sniff mode> <RSSI>
<channel quality> <SCO link>                 <HV2
packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                <paging scheme> <power control>
<transparent SCO>
                <AFH cap. slave> <AFH cap. master>

btsco log (with some comments inserted by me)

btsco v0.41
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected

This is where I started the first playback cmd (no
hcidump data for this one)

speaker volume: 14 mic volume: 0
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=14^M
Sending up speaker change 14
recieved AT+VGS=13^M
Sending up speaker change 13
recieved AT+VGS=12^M
Sending up speaker change 12
speaker volume: 12 mic volume: 1
driver is not in use
disconnected SCO channel

This is the second time, here I got audio for a few
seconds

speaker volume: 12 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=12^M
Sending up speaker change 12
recieved AT+VGS=13^M
Sending up speaker change 13
recieved AT+VGS=13^M
Sending up speaker change 13
recieved AT+VGS=12^M
Sending up speaker change 12
recieved AT+VGS=11^M
Sending up speaker change 11
recieved AT+VGS=12^M Sending up speaker change 12
speaker volume: 12 mic volume: 1
driver is not in use
disconnected SCO channel

And this is the third try

speaker volume: 12 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=12^M
Sending up speaker change 12
speaker volume: 12 mic volume: 1
driver is not in use
disconnected SCO channel
recieved AT+CKPD=200^M
RFCOMM channel lost


hcidump -x of invocation that that plays audio

HCI sniffer - Bluetooth packet analyzer ver 1.29
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
  0000: 2a 00 e0 00                                   
   *...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                   
   ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2d 00 c6 a9 03 44 0d  00 00 00             
   .-....D....
> SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
> SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
< SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
< SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
> SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 fd ff f4 ff e6 ff  dc ff d2 ff c4 ff
c4 ff  ................
> SCO data: handle 45 dlen 48
    0000: c1 ff bf ff c3 ff b8 ff  b3 ff b0 ff b0 ff
c1 ff  ................
    0010: c4 ff c1 ff c6 ff ba ff  a7 ff ad ff c4 ff
c2 ff  ................
    0020: b6 ff b8 ff c8 ff bc ff  ba ff c7 ff a1 ff
b3 ff  ................
> SCO data: handle 45 dlen 48
    0000: ca ff 9e ff 94 ff 90 ff  aa ff c0 ff 96 ff
a4 ff  ................
    0010: b2 ff ae ff c4 ff b0 ff  9f ff b8 ff ba ff
a1 ff  ................
    0020: a4 ff b2 ff aa ff 9b ff  b5 ff c7 ff d0 ff
d7 ff  ................
< SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................ < SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
< SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
> SCO data: handle 45 dlen 48
    0000: d0 ff ca ff b5 ff b3 ff  bb ff bb ff c5 ff
af ff  ................
    0010: 9e ff 99 ff 86 ff 90 ff  95 ff 97 ff 81 ff
29 ff  ..............).
    0020: 17 ff 3f ff 01 ff 39 ff  0e ff e5 fe 0c ff
c4 fe  ..?...9.........
> SCO data: handle 45 dlen 48
    0000: 94 fe de fe cf fe b5 fe  a5 fe 90 fe a1 fe
92 fe  ................
    0010: a5 fe b5 fe c1 fe c0 fe  8c fe aa fe be fe
8a fe  ................
    0020: 4d fe 52 fe 6b fe 78 fe  9f fe 71 fe ea fd
a9 fd  M.R.k.x...q.....
> SCO data: handle 45 dlen 48
    0000: db fd 9b fd 6f fd e0 fd  df fd dc fd ed fd
ac fd  ....o...........
    0010: b7 fd d8 fd bd fd 86 fd  5c fd 79 fd 61 fd
55 fd  ........\.y.a.U.
    0020: 7c fd 45 fd 5f fd 9d fd  7c fd af fd ae fd
7c fd  |.E._...|.....|.
> SCO data: handle 45 dlen 48
    0000: a3 fd 6d fd 6a fd c6 fd  70 fd 54 fd 66 fd
05 fd  ..m.j...p.T.f...
    0010: 42 fd b1 fd f3 fd 1f fe  d0 fd 97 fd 93 fd
64 fd  B.............d.
    0020: ff fd 9c fe bc fd de fd  69 fe 96 fd eb fd
e5 fd  ........i.......
< SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................

This continues for a while (I get 16 packets with data
and about 20 packets with zeros).

After that I get data like this:
> SCO data: handle 45 dlen 48
    0000: 16 00 13 00 0a 00 0c 00  05 00 06 00 04 00
02 00  ................
    0010: 02 00 ff ff 03 00 1a 00  2e 00 1b 00 13 00
13 00  ................
    0020: 09 00 0b 00 05 00 05 00  04 00 01 00 03 00
00 00  ................
> SCO data: handle 45 dlen 48
    0000: 0f 00 27 00 1f 00 12 00  13 00 0b 00 0a 00
07 00  ..'.............
    0010: 04 00 07 00 17 00 29 00  17 00 11 00 10 00
08 00  ......).........
    0020: 0a 00 04 00 04 00 03 00  01 00 03 00 0b 00
22 00  ..............".
> SCO data: handle 45 dlen 48
    0000: 1b 00 0e 00 11 00 08 00  09 00 06 00 03 00
04 00  ................
    0010: 00 00 06 00 18 00 1d 00  10 00 0e 00 0b 00
07 00  ................
    0020: 07 00 03 00 04 00 02 00  06 00 19 00 1a 00
0d 00  ................
< SCO data: handle 45 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................


Then I stopped the playback and restarted.
However now the hcidump log is completely different:

< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
  0000: 2a 00 e0 00                                   
   *...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                   
   ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2e 00 c6 a9 03 44 0d  00 00 00             
   ......D....
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
< SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
< SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 03 00
02 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00  ................
    0020: 00 00 00 00 fe ff 04 00  05 00 03 00 03 00
01 00  ................
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  05 00 08 00 04 00
03 00  ................
    0010: 03 00 01 00 02 00 00 00  ff ff 00 00 ff ff
ff ff  ................
    0020: ff ff ff ff ff ff ff ff  03 00 07 00 04 00
02 00  ................
> SCO data: handle 46 dlen 48
    0000: 03 00 01 00 03 00 08 00  07 00 04 00 04 00
03 00  ................
    0010: 01 00 00 00 00 00 00 00  00 00 ff ff fe ff
ff ff  ................
    0020: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff
ff ff  ................
> SCO data: handle 46 dlen 48
    0000: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff
ff ff  ................
    0010: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff
ff ff  ................
    0020: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff
ff ff  ................

It is not even close to what I had before.

I have more hcidump data (about 6.5 MB). 
If this is useful for debugging drop me a note (didn't
want to attach such a large file)

Anyone an idea what is wrong?

Best regards, Frans.




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
