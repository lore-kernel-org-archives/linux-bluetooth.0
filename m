Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Re: Qualification testing - rfcomm
Date: Tue, 22 Jul 2003 09:48:16 -0700
Message-ID: <000c01c35071$0c788f60$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1058838934.3470.5.camel@localhost.localdomain>
List-ID: <bluez-devel.lists.sourceforge.net>

> On Fri, 2003-07-11 at 01:18, Marcel Holtmann wrote:
> > Hi Daryl,
> > 
> > > TP/RFC/BV-12-C:
> > > "Verify that the IUT handles aggregate flow control 
> correctly when 
> > > the Tester, acting as a device conforming to Bleutooth 
> version 1.0B, 
> > > controls the data flow using the Flow Control on/off 
> commands FCon 
> > > and FCoff. The IUT's device role is of no importance."
> > > 
> > > The command and console output:
> > > 
> > > root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> > > rctest[362]: Connected
> > > rctest[362]: Sending ...
> > > rfcomm_recv_mcc: Unknown control type 0x18
> > > rfcomm_recv_mcc: Unknown control type 0x28
> > > 
> > > The IUT does not respond to FCoff with FCoff, and 
> continues sending 
> > > data. It also does not respond to FCon with FCon.
> > 
> > we don't have support for flow control on the entire RFCOMM 
> session. 
> > But it seems that the FCOFF and FCON should be supported. 
> The attached 
> > patch implements support for it, but I am not quite sure if 
> it is the 
> > right way to do this.
> Is it mandatory ? I always thought it's optional.

I asked the same question. Yes, apparently it is mandatory.

> 
> > @@ -1533,6 +1591,9 @@
> >  	struct list_head *p, *n;
> > 
> >  	BT_DBG("session %p state %ld", s, s->state);
> > +
> > +	if (test_bit(RFCOMM_TX_THROTTLED, &s->flags))
> > +		return;
> > 
> >  	list_for_each_safe(p, n, &s->dlcs) {
> >  		d = list_entry(p, struct rfcomm_dlc, list);
> This part is not ok. We still have to check for timeout. Rest 
> of patch is fine.
> 
> Max 

Ok. I'll see if it's not too late to stop testing it. :)

-Daryl.
