Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Re: Qualification testing - rfcomm
Date: Tue, 22 Jul 2003 10:01:02 -0700
Message-ID: <001601c35072$d566e510$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1058892812.2755.26.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

> Hi Daryl,
> 
> > > > @@ -1533,6 +1591,9 @@
> > > >  	struct list_head *p, *n;
> > > > 
> > > >  	BT_DBG("session %p state %ld", s, s->state);
> > > > +
> > > > +	if (test_bit(RFCOMM_TX_THROTTLED, &s->flags))
> > > > +		return;
> > > > 
> > > >  	list_for_each_safe(p, n, &s->dlcs) {
> > > >  		d = list_entry(p, struct rfcomm_dlc, list);
> > > This part is not ok. We still have to check for timeout. Rest
> > > of patch is fine.
> > 
> > Ok. I'll see if it's not too late to stop testing it. :)
> 
> it should not make any difference for the test case, but here 
> is the complete version of the new patch.

Great. Thanks.

Turns out they haven't started testing yet. I'll put this in for testing
instead of the old stuff.

-Daryl.
