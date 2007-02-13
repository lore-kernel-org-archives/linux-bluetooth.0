Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 13 Feb 2007 10:18:22 +0100
From: =?ISO-8859-2?Q?Miros=B3aw_Malach?= <m.malach@wp.pl>
To: bluez-users <bluez-users@lists.sourceforge.net>
Message-ID: <45d1825e17b9b@wp.pl>
MIME-Version: 1.0
Subject: [Bluez-users] connection problem between samsung mobile phone nad
 bluez 3.8in slackware 11
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hello
I have problem with connection between my usb bluetooth and =

samsung sgh -x680. I have installed slackware 11 with bluez 3.8 (lib and ut=
ils). for easy diagnostic I sending for you output same commands =

and comments =

 =

lsusb :

Bus 2 Device 2: ID 1131:1001 Integrated System Solution Corp. KY-BT100 Blue=
tooth Adapter

hciconfig -a =


hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN
        RX bytes:7001 acl:10 sco:0 events:265 errors:0
        TX bytes:1665 acl:10 sco:0 commands:110 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: MASTER
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer,=
 Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver: 0x=
1fe
        Manufacturer: Integrated System Solution Corp. (57)
hcitool scan
Scanning ...

        00:17:D5:47:4E:88       Mir  - this is my mobile phone

hcid and spdp demon I have started by rc.bluetooth script from /etc/rc.d

my mobile phone hasn't seen my usb bluetooth =

When I have tried connect to my phone I haven't got any error  but this lin=
k hasn't work . =

command l2ping to phone work very well.

hcitool con
Connections:

Could you tell me weher is problem ?

kind regards =

Miroslaw Malach



 =






----------------------------------------------------
W stylu Joanny Brodzik.
Zobacz jak ubiera si=EA prawdziwa gwiazda! Kliknij:
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd69.html&sid=
=3D1018



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
