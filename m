Return-Path: <cyrus@holtmann.org>
Message-ID: <1401092222.2400.18.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v2 1/8] Bluetooth: Refactor l2cap_sock_sendmsg() to copy
 user buffer
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 26 May 2014 11:17:02 +0300
In-Reply-To: <98B7DE79-FFC6-435F-86DA-36F11C8F7C2B@holtmann.org>
References: 
	<1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1400837248-12179-2-git-send-email-jukka.rissanen@linux.intel.com>
	 <98B7DE79-FFC6-435F-86DA-36F11C8F7C2B@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On la, 2014-05-24 at 21:48 -0700, Marcel Holtmann wrote:
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index f59e00c..7e7b28a 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -948,6 +948,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> > {
> > 	struct sock *sk = sock->sk;
> > 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> > +	unsigned char *buf;
> > 	int err;
> > 
> > 	BT_DBG("sock %p, sk %p", sock, sk);
> > @@ -968,10 +969,21 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> > 	if (err)
> > 		return err;
> > 
> > +	buf = kmalloc(len, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	if (memcpy_fromiovec(buf, msg->msg_iov, len)) {
> > +		err = -EFAULT;
> > +		goto done;
> > +	}
> > +
> > 	l2cap_chan_lock(chan);
> > -	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
> > +	err = l2cap_chan_send(chan, buf, len, sk->sk_priority, msg->msg_flags);
> > 	l2cap_chan_unlock(chan);
> > 
> > +done:
> > +	kfree(buf);
> > 	return err;
> > }
> 
> We don’t have to use chan->ops->alloc_skb here? Has this become obsolete now?

Isn't the buf here just a normal memory buffer that stores just the user
data and has nothing to do with sk_buff that is returned by alloc_skb()?


Cheers,
Jukka
