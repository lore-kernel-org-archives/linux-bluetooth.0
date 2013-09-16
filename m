Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v4 8/8] Bluetooth: Fix waiting for clearing of BT_SK_SUSPEND flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130916081926.GA13593@x220.p-661hnu-f1>
Date: Mon, 16 Sep 2013 09:14:53 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5FF04A9E-05D7-4CF9-888B-A2F7221F6A4F@holtmann.org>
References: <1379269001-6313-1-git-send-email-johan.hedberg@gmail.com> <1379269001-6313-9-git-send-email-johan.hedberg@gmail.com> <63CB3872-A353-4997-9A00-E746DA99E6C6@holtmann.org> <20130916081926.GA13593@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> @@ -525,6 +525,45 @@ int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
>>> }
>>> EXPORT_SYMBOL(bt_sock_wait_state);
>>> 
>> 
>> add a small comment here that this needs to be called with sk lock held.
> 
> I suppose I should do that to the old bt_sock_wait_state function too?
> (which btw my wait_ready function is essentially a copy of, with the
> exception of which condition it looks for)

good idea.

>>> +int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
>>> +{
>>> +	DECLARE_WAITQUEUE(wait, current);
>>> +	unsigned long timeo;
>>> +	int err = 0;
>>> +
>>> +	BT_DBG("sk %p", sk);
>>> +
>>> +	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
>>> +
>>> +	add_wait_queue(sk_sleep(sk), &wait);
>>> +	set_current_state(TASK_INTERRUPTIBLE);
>>> +	while (test_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags)) {
>>> +		if (!timeo) {
>>> +			err = -EAGAIN;
>>> +			break;
>>> +		}
>>> +
>>> +		if (signal_pending(current)) {
>>> +			err = sock_intr_errno(timeo);
>>> +			break;
>>> +		}
>>> +
>>> +		release_sock(sk);
>>> +		timeo = schedule_timeout(timeo);
>>> +		lock_sock(sk);
>>> +		set_current_state(TASK_INTERRUPTIBLE);
>>> +
>>> +		err = sock_error(sk);
>>> +		if (err)
>>> +			break;
>>> +	}
>>> +	__set_current_state(TASK_RUNNING);
>>> +	remove_wait_queue(sk_sleep(sk), &wait);
>>> +
>>> +	return err;
>>> +}
>>> +EXPORT_SYMBOL(bt_sock_wait_ready);
>>> +
>>> #ifdef CONFIG_PROC_FS
>>> struct bt_seq_state {
>>> 	struct bt_sock_list *l;
>>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>>> index 0098af8..ad95b42 100644
>>> --- a/net/bluetooth/l2cap_sock.c
>>> +++ b/net/bluetooth/l2cap_sock.c
>>> @@ -777,6 +777,12 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
>>> 	if (sk->sk_state != BT_CONNECTED)
>>> 		return -ENOTCONN;
>>> 
>>> +	lock_sock(sk);
>>> +	err = bt_sock_wait_ready(sk, msg->msg_flags);
>>> +	release_sock(sk);
>>> +	if (err)
>>> +		return err;
>>> +
>> 
>> After starting to look into this now, I am not sure we have proper
>> locking in that function in the first place. Can you check that it is
>> actually fine not holding the socket lock for the send operation
>> itself.
> 
> What procedure did you have in mind for checking what's fine and what's
> not? Some quick googling and trying to look at the code of other address
> families didn't help me getting much wiser about this.
> 
> This is the way that RFCOMM and L2CAP sockets seem to always have done
> locking and we haven't seen any obvious breakage because of it. The
> RFCOMM side does indeed use lock_sock for the send operation and L2CAP
> doesn't. However, I think the reason it works is that l2cap_chan_lock
> (which is used before calling l2cap_chan_send) serves a similar purpose.

Then lets leave it as is.

Regards

Marcel

