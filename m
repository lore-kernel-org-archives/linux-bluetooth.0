Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1079743635953.samitius.70713.-NzbxEEFNkxHlpJ_X9rCCw@luukku.com>
From: Sami Nikkarinen <samitius@luukku.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Problems with multiple PANUs connecting via the same Bluetooth USB dongle
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 20 Mar 2004 02:47:15 +0200 (EET)

Hi,

I have faced a small problem while trying to connect multiple PANUs via the=
 same Bluetooth dongle. Actually the problem doesn't exist with all Bluetoo=
th dongles I have been using, since e.g. SCM Bluetooth Zio USB dongle can h=
andle multiple PAN connections without any problems.

But when I'm using e.g. MSI Bluetooth PC2PC USB dongle, the PAN connection =
to the first device is successfully established, but the second device can'=
t connect to it (although it has been found during the discovery procedure)=
. The attempt is just rejected, but I can't find any information regarding =
this attempt from /var/log/messages file or output of hcidump.

I'm having exactly the same settings and configurations with both dongles, =
so I would guess that the problem must be dongle-specific.=20

This is the output of 'hciconfig -a' command while using the SCM's dongle:

hci0:=09Type: USB=20
=09BD Address: 00:10:60:A4:9D:4B ACL MTU: 192:8  SCO MTU: 64:8
=09UP RUNNING PSCAN ISCAN=20
=09RX bytes:4448065 acl:39552 sco:0 events:41899 errors:0
=09TX bytes:4337261 acl:42250 sco:0 commands:88 errors:0
=09Features: 0xff 0xff 0x0f 0x00
=09Packet type: DM1 DH1 HV1=20
=09Link policy: HOLD SNIFF PARK=20
=09Link mode: ACCEPT MASTER=20
=09Name: 'ABU BlueZ (0)'
=09Class: 0x000100
=09Service Classes: Unspecified
=09Device Class: Computer, Uncategorized
=09HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
=09Manufacturer: Cambridge Silicon Radio (10)

And this is the output of 'hciconfig -a' command while using the MSI's dong=
le:

hci0:=09Type: USB=20
=09BD Address: 00:10:DC:AF:92:AE ACL MTU: 192:8  SCO MTU: 64:8
=09UP RUNNING PSCAN ISCAN=20
=09RX bytes:760026 acl:6813 sco:0 events:6982 errors:0
=09TX bytes:686512 acl:6945 sco:0 commands:28 errors:0
=09Features: 0xff 0xff 0x0f 0x00
=09Packet type: DM1 DH1 HV1=20
=09Link policy: HOLD SNIFF PARK=20
=09Link mode: ACCEPT MASTER=20
=09Name: 'ABU BlueZ (0)'
=09Class: 0x000100
=09Service Classes: Unspecified
=09Device Class: Computer, Uncategorized
=09HCI Ver: 1.1 (0x1) HCI Rev: 0x1e7 LMP Ver: 1.1 (0x1) LMP Subver: 0x1e7
=09Manufacturer: Cambridge Silicon Radio (10)

The only difference I can spot here is the HCI Revision and LMP Subversion =
fields, but can these explain the different performance of the dongles? Or =
is the reason somewhere else? At least it shouldn't be in any way related t=
o the PAN profile, since the problems seem to exist in much lower level of =
Bluetooth.

Regards, Sami

..............................................................
 MTV3 Laajakaista - Hauskemman el=E4m=E4n puolesta.
 http://www.mtv3.fi/liittyma/hankinta/laajakaista/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
