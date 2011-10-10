Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 10:35:32 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: convert flushable variable to flag in
 l2cap chan
Message-ID: <20111010073530.GA12512@aemeltch-MOBL1>
References: <1317995646-11174-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111007182214.GA2695@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111007182214.GA2695@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Oct 07, 2011 at 03:22:14PM -0300, Gustavo Padovan wrote:
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 61f1f62..81fc8f0 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -446,14 +446,15 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
> >  		break;
> >  
> >  	case BT_FLUSHABLE:
> > -		if (put_user(chan->flushable, (u32 __user *) optval))
> > +		if (put_user(test_bit(FLAG_FLUSHABLE, &chan->flags),
> > +						(u32 __user *) optval))
> >  			err = -EFAULT;
> >  
> >  		break;
> >  
> >  	case BT_POWER:
> >  		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM
> > -				&& sk->sk_type != SOCK_RAW) {
> > +						&& sk->sk_type != SOCK_RAW) {
> 
> This change doesn't belong to this patch. Please fix this and resend.

I've just sent patch without this cosmetic change.

Best regards 
Andrei Emeltchenko 
