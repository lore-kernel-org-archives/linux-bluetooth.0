Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] no concurrent inquiry / inquiry scan and L2CAP
	connection as slave
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <413C24C6.1030102@nue.et-inf.uni-siegen.de>
References: <413B18F9.6010101@nue.et-inf.uni-siegen.de>
	 <1094459425.5145.19.camel@notepaq>
	 <413C24C6.1030102@nue.et-inf.uni-siegen.de>
Content-Type: text/plain
Message-Id: <1094462275.5145.22.camel@notepaq>
Mime-Version: 1.0
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
Date: Mon, 06 Sep 2004 11:17:55 +0200

Hi Michael,

> > this sounds like a chip limitation. What does "hciconfig -a" say?
> 
> Here goes:
> 
> BL-554:
> 
> hci0:	Type: USB
> 	BD Address: 02:00:F4:18:51:74 ACL MTU: 192:8  SCO MTU: 64:8
> 	UP RUNNING PSCAN ISCAN
> 	RX bytes:1787 acl:1 sco:0 events:92 errors:0
> 	TX bytes:543 acl:1 sco:0 commands:44 errors:0
> 	Features: 0xff 0xff 0x0f 0x00
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> 	Link policy: RSWITCH HOLD SNIFF PARK
> 	Link mode: SLAVE ACCEPT
> 	Name: 'BlueZ (0)'
> 	Class: 0x000100
> 	Service Classes: Unspecified
> 	Device Class: Computer, Uncategorized
> 	HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1)
> 	LMP Subver: 0x175
> 	Manufacturer: Cambridge Silicon Radio (10)
> 
> 
> BL-500:
> 
> hci0:	Type: UART
> 	BD Address: 02:00:80:EC:7C:4A ACL MTU: 192:8  SCO MTU: 64:8
> 	UP RUNNING PSCAN ISCAN
> 	RX bytes:897 acl:0 sco:0 events:19 errors:0
> 	TX bytes:634 acl:0 sco:0 commands:20 errors:0
> 	Features: 0xff 0xff 0x0f 0x00
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> 	Link policy: RSWITCH HOLD SNIFF PARK
> 	Link mode: SLAVE ACCEPT
> 	Name: 'BlueZ (0)'
> 	Class: 0x000100
> 	Service Classes: Unspecified
> 	Device Class: Computer, Uncategorized
> 	HCI Ver: 1.1 (0x1) HCI Rev: 0x135 LMP Ver: 1.1 (0x1)
> 	LMP Subver: 0x135
> 	Manufacturer: Cambridge Silicon Radio (10)
> 
> 
> Don't get confused by the apparently weird device addresses; this is 
> part of my project.

you need at least a HCI 16.4 firmware to get it working. Check my pages
and the "hciconfig hci0 revision" command for more information.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
