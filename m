Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Arthur Breitman <arthur.breitman@gmail.com>
To: bluez-users@lists.sourceforge.net
References: <200511211803.35723.arthur.breitman@gmail.com>
In-Reply-To: <200511211803.35723.arthur.breitman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511221106.42566.arthur.breitman@gmail.com>
Subject: [Bluez-users] Re: Everything seems normal yet...
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 22 Nov 2005 11:06:42 -0500

trying to find the mobile phone:

root@coin:/home/arthurb# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
=A0 =A0 lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
=A0 =A0 Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Vendor (0xff) plen 7
=A0 0000: cd 03 00 04 00 00 00
=A0 =A0 =A0.......
> HCI Event: Vendor (0xff) plen 7
=A0 0000: cd 03 00 04 00 00 00
=A0 =A0 =A0.......
> HCI Event: Vendor (0xff) plen 7
=A0 0000: cd 03 00 04 00 00=20
00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .......
> HCI Event: Vendor (0xff) plen 7
=A0 0000: cd 03 00 04 00 00=20
00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .......
> HCI Event: Vendor (0xff) plen 7
=A0 0000: cd 03 00 04 00 00=20
00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .......
> HCI Event: Vendor (0xff) plen 7
=A0 0000: cd 03 00 04 00 00=20
00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .......
> HCI Event: Vendor (0xff) plen 7
=A0 0000: cd 03 00 04 00 00=20
00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .......
> HCI Event: Vendor (0xff) plen 7
=A0 0000: cd 03 00 04 00 00 00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0.......
> HCI Event: Vendor (0xff) plen 7
=A0 0000: cd 03 00 04 00 00 00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0.......
> HCI Event: Vendor (0xff) plen 7
=A0 0000: cd 03 00 04 00 00 00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0.......
> HCI Event: Inquiry Complete (0x01) plen 1
=A0 =A0 status 0x00


Mobile phone trying to see the laptop:
nothing special except for=20
> HCI Event: Vendor (0xff) plen 7
=A0 0000: cd 03 00 04 00 00 00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0.......
but this seems to be going on all the time


As for the kde info bubble, turns out to be a kde bug in my opinion, it wor=
ks=20
for the first 10 switches then stops when the busID of the bluetooth emitte=
r=20
goes over a certain ID.

I also found something very interesting... when I turn off and =A0on the=20
bluetooth, for a few seconds, hciconfig -a gives

hci0: =A0 Type: USB
=A0 =A0 =A0 =A0 BD Address: 00:10:C6:64:69:6B ACL MTU: 384:8 SCO MTU: 64:8
=A0 =A0 =A0 =A0 UP RUNNING
=A0 =A0 =A0 =A0 RX bytes:96 acl:0 sco:0 events:11 errors:0
=A0 =A0 =A0 =A0 TX bytes:41 acl:0 sco:0 commands:9 errors:0
=A0 =A0 =A0 =A0 Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
=A0 =A0 =A0 =A0 Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
=A0 =A0 =A0 =A0 Link policy: RSWITCH HOLD SNIFF PARK
=A0 =A0 =A0 =A0 Link mode: SLAVE ACCEPT
=A0 =A0 =A0 =A0 Name: 'Dell Wireless 350 Bluetooth Internal Car'
=A0 =A0 =A0 =A0 Class: 0x000000
=A0 =A0 =A0 =A0 Service Classes: Unspecified
=A0 =A0 =A0 =A0 Device Class: Miscellaneous,
=A0 =A0 =A0 =A0 HCI Ver: 1.2 (0x2) HCI Rev: 0x679 LMP Ver: 1.2 (0x2) LMP Su=
bver: 0x679
=A0 =A0 =A0 =A0 Manufacturer: Cambridge Silicon Radio (10)

Hence the KDE warning about the class being 0 !!

But then, it seems a few seconds later to be automagically superseeded with=
 my=20
hci.conf and I have then

root@coin:/home/arthurb# hciconfig -a
hci0: =A0 Type: USB
=A0 =A0 =A0 =A0 BD Address: 00:10:C6:64:69:6B ACL MTU: 384:8 SCO MTU: 64:8
=A0 =A0 =A0 =A0 UP RUNNING
=A0 =A0 =A0 =A0 RX bytes:412 acl:0 sco:0 events:20 errors:0
=A0 =A0 =A0 =A0 TX bytes:322 acl:0 sco:0 commands:18 errors:0
=A0 =A0 =A0 =A0 Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
=A0 =A0 =A0 =A0 Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
=A0 =A0 =A0 =A0 Link policy: RSWITCH HOLD SNIFF PARK
=A0 =A0 =A0 =A0 Link mode: SLAVE ACCEPT
=A0 =A0 =A0 =A0 Name: 'Bluetooth coin-0'
=A0 =A0 =A0 =A0 Class: 0x100000
=A0 =A0 =A0 =A0 Service Classes:
=A0 =A0 =A0 =A0 Device Class: Miscellaneous,
=A0 =A0 =A0 =A0 HCI Ver: 1.2 (0x2) HCI Rev: 0x679 LMP Ver: 1.2 (0x2) LMP Su=
bver: 0x679
=A0 =A0 =A0 =A0 Manufacturer: Cambridge Silicon Radio (10)

I don't know what service is involved in the turning on and off of bluetoot=
h,=20
nor do I know what fills my hciconfig in the first place... would there be=
=20
another configuration file ?

I tried to run khciconfig but it's basically a simple frontend saying the s=
ame=20
as hciconfig


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
