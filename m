Return-Path: <taneli.vahakangas@netsonic.fi>
Subject: Re: [Bluez-users] Do bnep and obex work simultaneously?
From: Taneli =?ISO-8859-1?Q?V=E4h=E4kangas?= <taneli.vahakangas@netsonic.fi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1088784401.2803.36.camel@pegasus>
References: <1088782104.22055.7.camel@jumbo228.adsl.netsonic.fi>
	 <1088782788.2803.32.camel@pegasus>
	 <1088783320.22055.12.camel@jumbo228.adsl.netsonic.fi>
	 <1088784401.2803.36.camel@pegasus>
Content-Type: text/plain
Message-Id: <1088844532.22814.644.camel@jumbo228.adsl.netsonic.fi>
Mime-Version: 1.0
Date: Sat, 03 Jul 2004 11:48:54 +0300
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, 2004-07-02 at 19:06, Marcel Holtmann wrote:
> Hi Taneli,
> 
[snip]
> > 	HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
> > 	Manufacturer: Cambridge Silicon Radio (10)

Aha! The GN side has a newer (?) chip:

        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

And it did work! Thanks for the hint. 

> the scatternet support of the HCI 15.3 firmware is very limited. If you
> know someone with a MacOS X you can ask him to update your dongle.
> Otherwise you are limited here, but maybe it already helps if you
> activate the role switch (rswitch) in hcid.conf.

rswitch didn't help, so I need to eventually ask my friend to help me
out. Thanks again!

	Taneli
