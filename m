Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Oct 2011 12:44:57 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Bluetooth: convert force_active variable to flag in
 l2cap chan
Message-ID: <20111011094454.GC19953@aemeltch-MOBL1>
References: <1318232034-13410-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318232034-13410-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111010210706.GC6936@joana>
 <20111011075032.GB19953@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111011075032.GB19953@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Oct 11, 2011 at 10:50:34AM +0300, Emeltchenko Andrei wrote:
> > > @@ -942,7 +946,8 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
> > >  			set_bit(FLAG_FORCE_RELIABLE, &chan->flags);
> > >  		if (test_bit(FLAG_FLUSHABLE, &pchan->flags))
> > >  			set_bit(FLAG_FLUSHABLE, &chan->flags);
> > > -		chan->force_active = pchan->force_active;
> > > +		if (test_bit(FLAG_FORCE_ACTIVE, &pchan->flags))
> > > +			set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
> > >  	} else {
> > >  
> > >  		switch (sk->sk_type) {
> > > @@ -973,8 +978,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
> > >  		chan->role_switch = 0;
> > >  		clear_bit(FLAG_FORCE_RELIABLE, &chan->flags);
> > >  		clear_bit(FLAG_FLUSHABLE, &chan->flags);
> > > -		chan->force_active = BT_POWER_FORCE_ACTIVE_ON;
> > > -
> > > +		set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
> > 
> > One last comment: set chan->flags to 0 here, the just to set the bits that
> > needs to be 1 at initialization.
> 
> Sorry do not understand this :-(
> 
> Do you mean assign chan->flags = 0; and set_bit only for
> FLAG_FORCE_ACTIVE?

Just sent patches with cumulative difference below:


diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 3ca71b4..4b388b7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -979,9 +979,7 @@ static void l2cap_sock_init(struct sock *sk, struct
sock *parent)
                chan->fcs  = L2CAP_FCS_CRC16;
                chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
                chan->sec_level = BT_SECURITY_LOW;
-               clear_bit(FLAG_ROLE_SWITCH, &chan->flags);
-               clear_bit(FLAG_FORCE_RELIABLE, &chan->flags);
-               clear_bit(FLAG_FLUSHABLE, &chan->flags);
+               chan->flags = 0;
                set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
        }


Best regards 
Andrei Emeltchenko 

