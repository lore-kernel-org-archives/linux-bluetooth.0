Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Oct 2011 13:34:00 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/4] Bluetooth: convert force_active variable to flag in
 l2cap chan
Message-ID: <20111011103357.GD19953@aemeltch-MOBL1>
References: <1318232034-13410-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111011075032.GB19953@aemeltch-MOBL1>
 <20111011094454.GC19953@aemeltch-MOBL1>
 <201110111201.10853.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201110111201.10853.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 11, 2011 at 12:01:10PM +0200, Szymon Janc wrote:
> Hi,
> 
> > > Sorry do not understand this :-(
> > > 
> > > Do you mean assign chan->flags = 0; and set_bit only for
> > > FLAG_FORCE_ACTIVE?
> > 
> > Just sent patches with cumulative difference below:
> 
> I guess you could do similar in l2cap_sock_init() chan->flags = pchan->flags
> instead of test_bit/set_bit burst.

yes, I will change this way.

Best regards 
Andrei Emeltchenko 

>  
> > 
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 3ca71b4..4b388b7 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -979,9 +979,7 @@ static void l2cap_sock_init(struct sock *sk, struct
> > sock *parent)
> >                 chan->fcs  = L2CAP_FCS_CRC16;
> >                 chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
> >                 chan->sec_level = BT_SECURITY_LOW;
> > -               clear_bit(FLAG_ROLE_SWITCH, &chan->flags);
> > -               clear_bit(FLAG_FORCE_RELIABLE, &chan->flags);
> > -               clear_bit(FLAG_FLUSHABLE, &chan->flags);
> > +               chan->flags = 0;
> >                 set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
> >         }
> 
> -- 
> BR
> Szymon Janc
