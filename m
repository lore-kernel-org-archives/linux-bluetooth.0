Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Mar 2012 14:59:52 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv5 06/26] Bluetooth: A2MP: Add chan callbacks
Message-ID: <20120326115950.GB18219@aemeltch-MOBL1>
References: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332519246-16656-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120325171612.GH3106@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120325171612.GH3106@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sun, Mar 25, 2012 at 02:16:12PM -0300, Gustavo Padovan wrote:
...

> > +static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
> > +					unsigned long len, int nb, int *err)
> 
> Wrong coding style here. As we just changed our coding style check the rest of
> this patchset for errors like this

I believe that here the style is OK. Otherwise we would have to make
several lines or go outside 80 characters.

> > +{
> > +	return bt_skb_alloc(len, GFP_KERNEL);
> > +}
> > +
> >  static struct l2cap_ops a2mp_chan_ops = {
> >  	.name = "L2CAP A2MP channel",
> > +	.state_change = a2mp_chan_state_change_cb,
> > +	.close = a2mp_chan_close_cb,
> > +	.alloc_skb = a2mp_chan_alloc_skb_cb,
> >  };
> >  
> >  static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
> > @@ -108,6 +142,8 @@ static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
> >  	chan->remote_mps = chan->omtu;
> >  	chan->mps = chan->omtu;
> >  
> > +	chan->ops->state_change(chan, BT_CONNECTED, 0);
> 
> This is the same of calling a2mp_chan_alloc_skb_cb() directly. ops is intended
> to be used outside of this file, not inside it.

You probably mean a2mp_chan_state_change_cb? I will change to something
even simpler.

Best regards 
Andrei Emeltchenko 
