Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 13 Oct 2007 16:40:03 +0100 (BST)
From: Ray <whatdoineed2do@yahoo.co.uk>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <323835.55544.qm@web23315.mail.ird.yahoo.com>
Subject: [Bluez-users] laptop undiscoverable but iscan enabled?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hi,

am running linux 2.6.21 with bluez libs/utils 2.20 and
am having problems getting my sony ericsson phone (or
anything for that matter) discover my linux box.

bluetooth is working to some extent on the linux box:
i am able to obexftp to my devices, just that when i
try to get my devices to discover my laptop nothing is
found.  when i reboot my laptop into windows, the my
devices can discover the laptop.

iscan and pscan is enabled on the device (see below)

can anyone tell me where i might be going wrong?
thanks
-ray

hci0:	Type: USB
	BD Address: 00:xx:xx:xx:xx:xx ACL MTU: 192:8 SCO MTU:
64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:11020 acl:47 sco:0 events:186 errors:0
	TX bytes:2408 acl:36 sco:0 commands:97 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'BlueZ (0)'
	Class: 0x00010c
	Service Classes: Unspecified
	Device Class: Computer, Laptop
	HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1)
LMP Subver: 0x20d
	Manufacturer: Cambridge Silicon Radio (10)



      ___________________________________________________________ 
Want ideas for reducing your carbon footprint? Visit Yahoo! For Good  http://uk.promotions.yahoo.com/forgood/environment.html


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
