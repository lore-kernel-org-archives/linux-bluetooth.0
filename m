Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Do bnep and obex work simultaneously?
From: Marcel Holtmann <marcel@holtmann.org>
To: Taneli =?ISO-8859-1?Q?V=E4h=E4kangas?= <taneli.vahakangas@netsonic.fi>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1088783320.22055.12.camel@jumbo228.adsl.netsonic.fi>
References: <1088782104.22055.7.camel@jumbo228.adsl.netsonic.fi>
	 <1088782788.2803.32.camel@pegasus>
	 <1088783320.22055.12.camel@jumbo228.adsl.netsonic.fi>
Content-Type: text/plain
Message-Id: <1088784401.2803.36.camel@pegasus>
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
Date: Fri, 02 Jul 2004 18:06:41 +0200

Hi Taneli,

> > from the Bluetooth stack this is possible, but maybe your local device
> > won't support it. What does "hciconfig -a" say?
> 
> Here goes:
> hci0:	Type: USB
> 	BD Address: 00:40:05:XX:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
> 	UP RUNNING PSCAN ISCAN 
> 	RX bytes:21619370 acl:80564 sco:0 events:9814 errors:0
> 	TX bytes:753307 acl:9833 sco:0 commands:23 errors:0
> 	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> 	Link policy: HOLD SNIFF PARK 
> 	Link mode: SLAVE ACCEPT 
> 	Name: 'mylly-0'
> 	Class: 0x000100
> 	Service Classes: Unspecified
> 	Device Class: Computer, Uncategorized
> 	HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
> 	Manufacturer: Cambridge Silicon Radio (10)
> 
> It is a D-Link DBT-120.

the scatternet support of the HCI 15.3 firmware is very limited. If you
know someone with a MacOS X you can ask him to update your dongle.
Otherwise you are limited here, but maybe it already helps if you
activate the role switch (rswitch) in hcid.conf.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
