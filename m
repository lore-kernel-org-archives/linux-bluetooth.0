Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40CDE18C.70703@thomae-privat.de>
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Epox Barton keyboard: HID create error 53
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
Date: Mon, 14 Jun 2004 19:34:04 +0200

Hello,

I am trying to connect a Epox Barton Keyboard to a Thinkpad R50 with 
internal bluetooth, Kernel 2.6.6-mh3 and debian bluez-utils 2.7-2.

But I get:
 > hidd --connect 00:04:61:XX:XX:XX
HID create error 53 (Invalid request descriptor)

syslog says:
Jun 14 19:24:11 tyron hidd: New HID device 00:04:61:XX:XX:XX (Epox 
HIDEngine Keyboard)

Tried with and without encryption, both failed. Any ideas?

Greetings
Matthias



 > hciconfig -a
hci0:	Type: USB
	BD Address: 00:20:E0:XX:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN
	RX bytes:2756580 acl:10594 sco:0 events:3821 errors:0
	TX bytes:443471 acl:4191 sco:0 commands:110 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF PARK
	Link mode: SLAVE ACCEPT
	Name: 'BlueTyron'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver: 0x222
	Manufacturer: Cambridge Silicon Radio (10)

 > hcitool info 00:04:61:XX:XX:XX
Requesting information ...
	BD Address:  00:04:61:XX:XX:XX
	Device Name: Bluetooth-Keyboard 817324
	LMP Version: 1.1 (0x1) LMP Subversion: 0x356
	Manufacturer: Cambridge Silicon Radio (10)
	Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
		<3-slot packets> <5-slot packets> <encryption> <slot offset>
		<timing accuracy> <role switch> <hold mode> <sniff mode>
		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
		<transparent SCO>
r


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
