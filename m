Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <12696405.1079094466421.JavaMail.ngmail@webmail05.arcor-online.net>
From: damou@nexgo.de
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] FujitsuSiemens BT USB Adapter 
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Fri, 12 Mar 2004 13:27:46 +0100 (CET)

Hi,

> is this dongle supported? If so, I'll buy it imeditially, coz its SO small!! 

Yes this dongle is working.

Here is the output of hciconfig -a:
hci0:	Type: USB 
	BD Address: 00:30:C2:08:51:57 ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:370 acl:0 sco:0 events:15 errors:0
	TX bytes:305 acl:0 sco:0 commands:15 errors:0
	Features: 0xff 0xff 0x0f 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'BlueZ (0)'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x150 LMP Ver: 1.1 (0x1) LMP Subver: 0x150
	Manufacturer: Cambridge Silicon Radio (10)


cu
Martl










-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
