Return-Path: <taneli.vahakangas@netsonic.fi>
Subject: Re: [Bluez-users] Do bnep and obex work simultaneously?
From: Taneli =?ISO-8859-1?Q?V=E4h=E4kangas?= <taneli.vahakangas@netsonic.fi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1088782788.2803.32.camel@pegasus>
References: <1088782104.22055.7.camel@jumbo228.adsl.netsonic.fi>
	 <1088782788.2803.32.camel@pegasus>
Content-Type: text/plain
Message-Id: <1088783320.22055.12.camel@jumbo228.adsl.netsonic.fi>
Mime-Version: 1.0
Date: Fri, 02 Jul 2004 18:48:40 +0300
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, 2004-07-02 at 18:39, Marcel Holtmann wrote:
> Hi Taneli,
> 
> > I have a computer running kernel 2.6.7-mh1 and it is acting as a
> > PANU (pand --connect ...), which works very well. The GN on the other end
> > is a similarly configured computer. However, now I can't use ussp-push's
> > obextool on the PANU computer to send files to the mobile phone. Is this
> > expected or did I do something wrong? obextool push ... complains:
> > Can't connect. Too many links (31)
> > and fair enough, the connect() system call receives EMLINK. 
> 
> from the Bluetooth stack this is possible, but maybe your local device
> won't support it. What does "hciconfig -a" say?

Here goes:
hci0:	Type: USB
	BD Address: 00:40:05:XX:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:21619370 acl:80564 sco:0 events:9814 errors:0
	TX bytes:753307 acl:9833 sco:0 commands:23 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'mylly-0'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
	Manufacturer: Cambridge Silicon Radio (10)

It is a D-Link DBT-120.

Thanks for the fast reply!

	Taneli
