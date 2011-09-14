Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Sep 2011 01:06:06 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/4] Bluetooth: convert flushable variable to flag in l2cap
 chan
Message-ID: <20110914040605.GQ16856@joana>
References: <1315404487-12105-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20110914040341.GO16856@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110914040341.GO16856@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo Padovan <padovan@profusion.mobi> [2011-09-14 01:03:42 -0300]:

> Hi Andrei,
> 
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-07 17:08:04 +0300]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > flushable variable inside l2cap_chan is a logical one and can
> > be easily converted to flag
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/l2cap.h |    2 +-
> >  net/bluetooth/l2cap_core.c    |    3 ++-
> >  net/bluetooth/l2cap_sock.c    |   13 +++++++++----
> >  3 files changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index 27bd105..4e6fb39 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -371,7 +371,6 @@ struct l2cap_chan {
> >  	__u8		sec_level;
> >  	__u8		role_switch;
> >  	__u8		force_reliable;
> > -	__u8		flushable;
> >  	__u8		force_active;
> >  
> >  	__u8		ident;
> > @@ -535,6 +534,7 @@ enum {
> >  
> >  /* Definitions for flags in l2cap_chan */
> >  enum {
> > +	FLAG_FLUSHABLE,
> >  	FLAG_EFS_ENABLE,
> >  	FLAG_EXT_CTRL,
> >  };
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index bb18a27..f68c88d 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1269,7 +1269,8 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
> >  
> >  	BT_DBG("chan %p, skb %p len %d", chan, skb, skb->len);
> >  
> > -	if (!chan->flushable && lmp_no_flush_capable(hcon->hdev))
> > +	if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
> > +			lmp_no_flush_capable(hcon->hdev))
> 
> Fix the indetation here.
> 
> >  		flags = ACL_START_NO_FLUSH;
> >  	else
> >  		flags = ACL_START;
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index bf343aa..16210df 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -446,7 +446,8 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
> >  		break;
> >  
> >  	case BT_FLUSHABLE:
> > -		if (put_user(chan->flushable, (u32 __user *) optval))
> > +		if (put_user(test_bit(FLAG_FLUSHABLE, &chan->flags),
> > +					(u32 __user *) optval))
> 
> and here.
> 
> >  			err = -EFAULT;
> >  
> >  		break;
> > @@ -655,7 +656,10 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
> >  			}
> >  		}
> >  
> > -		chan->flushable = opt;
> > +		if (opt)
> > +			set_bit(FLAG_FLUSHABLE, &chan->flags);
> > +		else
> > +			clear_bit(FLAG_FLUSHABLE, &chan->flags);
> >  		break;
> >  
> >  	case BT_POWER:
> > @@ -931,7 +935,8 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
> >  		chan->sec_level = pchan->sec_level;
> >  		chan->role_switch = pchan->role_switch;
> >  		chan->force_reliable = pchan->force_reliable;
> > -		chan->flushable = pchan->flushable;
> > +		if (test_bit(FLAG_FLUSHABLE, &pchan->flags))
> > +			set_bit(FLAG_FLUSHABLE, &chan->flags);
> 
> This if does nothing.

Oops, sorry. This is right, my bad.

	Gustavo
