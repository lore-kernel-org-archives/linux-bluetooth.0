Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] TDK Firmware Upgrade Procedure....
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Super Smart <alwaysgone@seznam.cz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>, steve.crane@rococosoft.com, samlee@ptl.com.tw
In-Reply-To: <103424.317214-26559-26157991-1053865944@seznam.cz>
References: <103424.317214-26559-26157991-1053865944@seznam.cz>
Content-Type: text/plain
Message-Id: <1053866257.30943.20.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 25 May 2003 14:37:29 +0200

Hi,

> Output of hciconfig -a for the TDK device is:
> 
> hci0:	Type: USB 
> 	BD Address: 00:80:98:34:83:E7 ACL MTU: 192:8  SCO MTU: 64:8
> 	UP RUNNING PSCAN ISCAN 
> 	RX bytes:370 acl:0 sco:0 events:15 errors:0
> 	TX bytes:305 acl:0 sco:0 commands:15 errors:0
> 	Features: 0xff 0xff 0x0f 0x00
> 	Packet type: DM1 DH1 HV1 
> 	Link policy: RSWITCH 
> 	Link mode: SLAVE ACCEPT 
> 	Name: 'BT_Server '
> 	Class: 0x000100
> 	Service Classes: Unspecified
> 	Device Class: Computer, Uncategorized
> 	HCI Ver: 1.1 (0x1) HCI Rev: 0x20c LMP Ver: 1.1 (0x1) LMP Subver:
> 0x20c
> 	Manufacturer: Cambridge Silicon Radio (10)

this is the HCI 16.4 with 128bit encryption support :)

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
