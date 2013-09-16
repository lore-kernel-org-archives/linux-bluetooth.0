Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Sep 2013 11:19:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 8/8] Bluetooth: Fix waiting for clearing of
 BT_SK_SUSPEND flag
Message-ID: <20130916081926.GA13593@x220.p-661hnu-f1>
References: <1379269001-6313-1-git-send-email-johan.hedberg@gmail.com>
 <1379269001-6313-9-git-send-email-johan.hedberg@gmail.com>
 <63CB3872-A353-4997-9A00-E746DA99E6C6@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <63CB3872-A353-4997-9A00-E746DA99E6C6@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 15, 2013, Marcel Holtmann wrote:
> > @@ -525,6 +525,45 @@ int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
> > }
> > EXPORT_SYMBOL(bt_sock_wait_state);
> > 
> 
> add a small comment here that this needs to be called with sk lock held.

I suppose I should do that to the old bt_sock_wait_state function too?
(which btw my wait_ready function is essentially a copy of, with the
exception of which condition it looks for)

> > +int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
> > +{
> > +	DECLARE_WAITQUEUE(wait, current);
> > +	unsigned long timeo;
> > +	int err = 0;
> > +
> > +	BT_DBG("sk %p", sk);
> > +
> > +	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
> > +
> > +	add_wait_queue(sk_sleep(sk), &wait);
> > +	set_current_state(TASK_INTERRUPTIBLE);
> > +	while (test_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags)) {
> > +		if (!timeo) {
> > +			err = -EAGAIN;
> > +			break;
> > +		}
> > +
> > +		if (signal_pending(current)) {
> > +			err = sock_intr_errno(timeo);
> > +			break;
> > +		}
> > +
> > +		release_sock(sk);
> > +		timeo = schedule_timeout(timeo);
> > +		lock_sock(sk);
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +
> > +		err = sock_error(sk);
> > +		if (err)
> > +			break;
> > +	}
> > +	__set_current_state(TASK_RUNNING);
> > +	remove_wait_queue(sk_sleep(sk), &wait);
> > +
> > +	return err;
> > +}
> > +EXPORT_SYMBOL(bt_sock_wait_ready);
> > +
> > #ifdef CONFIG_PROC_FS
> > struct bt_seq_state {
> > 	struct bt_sock_list *l;
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 0098af8..ad95b42 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -777,6 +777,12 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> > 	if (sk->sk_state != BT_CONNECTED)
> > 		return -ENOTCONN;
> > 
> > +	lock_sock(sk);
> > +	err = bt_sock_wait_ready(sk, msg->msg_flags);
> > +	release_sock(sk);
> > +	if (err)
> > +		return err;
> > +
> 
> After starting to look into this now, I am not sure we have proper
> locking in that function in the first place. Can you check that it is
> actually fine not holding the socket lock for the send operation
> itself.

What procedure did you have in mind for checking what's fine and what's
not? Some quick googling and trying to look at the code of other address
families didn't help me getting much wiser about this.

This is the way that RFCOMM and L2CAP sockets seem to always have done
locking and we haven't seen any obvious breakage because of it. The
RFCOMM side does indeed use lock_sock for the send operation and L2CAP
doesn't. However, I think the reason it works is that l2cap_chan_lock
(which is used before calling l2cap_chan_send) serves a similar purpose.

> > --- a/net/bluetooth/rfcomm/sock.c
> > +++ b/net/bluetooth/rfcomm/sock.c
> > @@ -544,7 +544,7 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> > 	struct sock *sk = sock->sk;
> > 	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
> > 	struct sk_buff *skb;
> > -	int sent = 0;
> > +	int err, sent = 0;
> > 
> > 	if (test_bit(RFCOMM_DEFER_SETUP, &d->flags))
> > 		return -ENOTCONN;
> > @@ -559,9 +559,14 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> > 
> > 	lock_sock(sk);
> > 
> > +	err = bt_sock_wait_ready(sk, msg->msg_flags);
> > +	if (err) {
> > +		release_sock(sk);
> > +		return err;
> > +	}
> > +
> 
> I would be fine with using the sent variable here. And then of course
> create a label for the failure case. Assuming bt_sock_wait_ready()
> returning 0 on success you could use it to initialize sent here.
> 
> However at minimum, I want a label here to jump at the end of the
> function in error case. I like to keep the number of lock_sock +
> release_sock balanced.

Makes sense. I'll do these improvements to the next version.

> Which is something that needs to be fixed for l2cap_sock_recvmsg()
> actually.

I'll see if I can roll up a separate patch for that.

Johan
