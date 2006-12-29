Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 29 Dec 2006 15:57:44 +0100
Message-Id: <1007107986@web.de>
MIME-Version: 1.0
From: Christian Gebhard <gebhard_christian@web.de>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] SCO connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello to all

I am trying to set up a SCO connection between 2 PCs, one with kernel 2.6.1=
8 and one with kernel 2.6.17. After several tries with sco-sockets I tried =
the scotest program with which I have the same problems as with my own sock=
et-program. The data seems to be sent (according to the output of hcidump -=
X -V), but it is not received. I have two Bluegiga Dongles with a CSR Bluec=
ore 4 External chip connected via USB to a USB2.0 PCI-Card in each PC.

output of "hciconfig -a" (same with both PCs):

hci0:   Type: USB
        BD Address: 00:07:80:81:A9:XX ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:684 acl:0 sco:0 events:22 errors:0
        TX bytes:332 acl:0 sco:0 commands:21 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'server-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer,=
 Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0xafa LMP Ver: 2.0 (0x3) LMP Subver: 0x=
afa
        Manufacturer: Cambridge Silicon Radio (10) =


output of "hciconfig hci0 revision" (same with both PCs):

hci0:   Type: USB
        BD Address: 00:07:80:81:A9:XX ACL MTU: 384:8 SCO MTU: 64:8
        Build 2810
        Chip version: BlueCore4-External
        Max key size: 56 bit
        SCO mapping:  HCI

If I use scotest on the sending PC appears the following:

debian:/home/christian# ./scotest -s 00:07:80:81:A9:XX
scotest[27090]: Connected [handle 46, class 0x000000]
scotest[27090]: Sending ...

on the receiving PC I get the following output:

server:/home/cgebhard# ./scotest -r
scotest[3851]: Waiting for connection ...
scotest[3852]: Connect from 00:07:80:81:A9:B4 [handle 47, class 0x3e0100]
scotest[3852]: Receiving ...
scotest[3852]: 672 bytes in 0.00m speed 1328.44 kb
scotest[3852]: 672 bytes in 0.00m speed 1515.59 kb
scotest[3852]: 672 bytes in 0.00m speed 1488.10 kb
scotest[3852]: 672 bytes in 0.00m speed 1481.38 kb

...etc...

the output of "hcidump -X -V for the sender:

< SCO data: handle 46 dlen 64
    0000: a2 02 00 00 a0 02 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0010: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0020: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0030: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
< SCO data: handle 46 dlen 64
    0000: a3 02 00 00 a0 02 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0010: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0020: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0030: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
< SCO data: handle 46 dlen 64
    0000: a4 02 00 00 a0 02 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0010: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0020: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0030: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
> SCO data: handle 46 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................

...etc...

it seems as if now and then the data is sent, but the only data I see on th=
e receiver with "hcidump -X -V is:

> SCO data: handle 47 dlen 48
    0000: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................
    0010: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................
    0020: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................
> SCO data: handle 47 dlen 48
    0000: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................
    0010: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................
    0020: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................
> SCO data: handle 47 dlen 48
    0000: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................
    0010: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................
    0020: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................
> SCO data: handle 47 dlen 48
    0000: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................
    0010: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................
    0020: ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ................

...etc...

it seems as if the data that was sent is not received.

Do I maybe need a kernel patch like the "patch-2.6.18-mh8.gz" or is there a=
nother problem. I am stuck with this since two weeks and don't know what to=
 do. But maybe that's because I started with Linux only 2 months ago^^. I w=
ould be glad if someone could help me with this.

Regards

Chris
_______________________________________________________________________
Viren-Scan f=FCr Ihren PC! Jetzt f=FCr jeden. Sofort, online und kostenlos.
Gleich testen! http://www.pc-sicherheit.web.de/freescan/?mc=3D022222


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
