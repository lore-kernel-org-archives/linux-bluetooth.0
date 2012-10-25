Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 10:13:09 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: l2cap_physical_cfm() can be static
Message-ID: <20121025071307.GA2502@aemeltch-MOBL1>
References: <508863c1.QTbySMnQ9kj6jDZz%fengguang.wu@intel.com>
 <20121024220131.GB3030@joana>
 <20121025002608.GA10418@localhost>
 <1351130134.1785.85.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351130134.1785.85.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 24, 2012 at 06:55:34PM -0700, Marcel Holtmann wrote:
> Hi Fengguang,
> 
> > Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-next.orig/net/bluetooth/l2cap_core.c	2012-10-25 08:23:52.456742699 +0800
> > +++ linux-next/net/bluetooth/l2cap_core.c	2012-10-25 08:23:55.056742760 +0800
> > @@ -4569,7 +4569,7 @@ static void l2cap_do_move_cancel(struct
> >  	l2cap_ertm_send(chan);
> >  }
> >  
> > -void l2cap_physical_cfm(struct l2cap_chan *chan, int result, u8 local_amp_id,
> > +static void l2cap_physical_cfm(struct l2cap_chan *chan, int result, u8 local_amp_id,
> >  			u8 remote_amp_id)
> 
> I rather wait for Mat to ACK or NACK this one. Maybe it is an oversight
> or we need that later on to be actually public.

Agree with Marcel here. This shall be public.

Best regards 
Andrei Emeltchenko 
