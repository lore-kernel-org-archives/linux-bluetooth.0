Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-id: <918378fefe.8fefe91837@estudiants.urv.es>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Bluez-users] Host is down
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
Date: Fri, 02 Apr 2004 09:02:47 +0200

Hi Marcel!
When I do hciconfig -a , the prompt shows me:

hci0:
Type: USB
	BD Address: 00:0A:3A:50:14:BC ACL MTU: 192:8  SCO
MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:2486 acl:0 sco:0 events:59 errors:0
	TX bytes:472 acl:0 sco:0 commands:44 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'BlueZ (0)'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1)
LMP Subver: 0x20d
	Manufacturer: Cambridge Silicon Radio (10)



I've tried changing the link mode to MASTER and to
ACCEPT MASTER but I get the same message when I try
to rfcomm with the rs232 adapter: "Host is down".

Thank you for your help!!!

Albert

>>>>>>>>>>>>>>>>>>>
>Hi Albert,

>> I'm using rh7.3 with kernel 2.4.24.
>> I've installed bluez-libs-2.5, bluez-utils-2.5,
>> bluez-sdp1.5, bluez-pan1.1, buez-hcidump-1.8,
>> bluez-hciemu-1.0 and bluez-bluefw-1.0, and I have >an
>> usb-dongle that I want to rfcomm with an rs232
>> adapter in a robot.

>what do "hciconfig -a" show?

>Regards

>Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
