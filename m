Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <000101c3ee91$fa205f40$f84ab850@ULLA>
From: "Zbigniew Diaczyszyn \(gmx\)" <z.dia@gmx.de>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] rfcomm: permission denied
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
Date: Sat, 7 Feb 2004 22:48:12 +0100

I'm working with Suse 8.2 and a Typhoon Bluetooth modem. I had it =
working - once. Now rfcomm is just saying: permission denied. The =
following lines are a protocol of bluetooth session. I have no idea at =
all in which  config-files I should look for a solution. /bin/bluepin =
ist just a < cat /etc/bluetooth/bluepin >. I'm working as root and =
/dev/rfcomm0 ist belonging to root.

Zbigniew Diaczyszyn        z.dia@gmx.de

-------------------------------------------------------------------------=
---------
linux:~ # hcid
linux:~ # hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:60:A6:97:8C ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:129 acl:0 sco:0 events:18 errors:0
        TX bytes:569 acl:0 sco:0 commands:18 errors:0
        Features: 0xff 0xff 0x0f 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Typhoon (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: =
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

linux:~ # rfcomm bind 0 00:10:60:A6:97:8C
linux:~ # rfcomm show
rfcomm0: 00:10:60:A6:97:8C channel 1 clean
linux:~ # hcitool scan
Scanning ...
        00:10:60:29:AC:2C       BluetoothModem
linux:~ # rfcomm connect 0 00:10:60:29:AC:2C
Can't connect RFCOMM socket: Permission denied

linux:~ # sdptool browse
Inquiring ...
Failed to connect to SDP server on 00:10:60:29:AC:2C




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
