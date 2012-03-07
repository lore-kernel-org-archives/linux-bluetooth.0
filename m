Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Mar 2012 18:17:14 +0200
From: Ido Yariv <ido@wizery.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Arik Nemtsov <arik@wizery.com>
Subject: Re: [RFC] Bluetooth: Search global l2cap channels by src/dst
 addresses
Message-ID: <20120307161714.GA6802@WorkStation>
References: <1330971024-11010-1-git-send-email-ido@wizery.com>
 <20120307103520.GF3647@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120307103520.GF3647@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Mar 07, 2012 at 12:35:22PM +0200, Andrei Emeltchenko wrote:
> Hi Ido,
> 
> On Mon, Mar 05, 2012 at 08:10:24PM +0200, Ido Yariv wrote:
> > The cid or psm and the source address might not be enough to uniquely
> > identify a global channel, especially when the source address is our
> > own.
> > 
> > For instance, when trying to communicate with two LE devices in master
> > mode, data received from the both devices is sent to the same socket.
> > 
> > Fix this by taking the destination address into account when choosing
> > the socket.
> > 
> > Signed-off-by: Ido Yariv <ido@wizery.com>
> > Signed-off-by: Arik Nemtsov <arik@wizery.com>
> > ---

...

> > @@ -847,14 +849,24 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, __le16 cid, bdadd
> >  			continue;
> >  
> >  		if (c->scid == cid) {
> > +			int src_match, dst_match;
> > +			int src_any, dst_any;
> > +
> > +			src_match = !bacmp(&bt_sk(sk)->src, src);
> > +			dst_match = !bacmp(&bt_sk(sk)->dst, dst);
> > +			src_any = !bacmp(&bt_sk(sk)->src, BDADDR_ANY);
> > +			dst_any = !bacmp(&bt_sk(sk)->dst, BDADDR_ANY);
> 
> This may be not efficient to use extensive memcmp operations every time
> before they can be actually used.
> 
> > +
> >  			/* Exact match. */
> > -			if (!bacmp(&bt_sk(sk)->src, src)) {
> > +			if (src_match && dst_match) {
> >  				read_unlock(&chan_list_lock);
> >  				return c;
> >  			}
> 
> at least src_any and dst_any may be put here. Maybe you could improve it
> even more.

Sure, I'll send an updated version.

Thanks for the review,
Ido.
