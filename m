Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Apr 2012 08:27:36 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: Re: [RFCv2 6/8] Bluetooth: Lock the L2CAP channel when sending
In-Reply-To: <20120428003015.GB2917@joana>
Message-ID: <alpine.DEB.2.02.1204300815580.2723@mathewm-linux>
References: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org> <1335570655-30878-7-git-send-email-mathewm@codeaurora.org> <20120428003015.GB2917@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Fri, 27 Apr 2012, Gustavo Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2012-04-27 16:50:53 -0700]:
>
>> The ERTM and streaming mode transmit queue must only be accessed while
>> the L2CAP channel lock is held.  Locking the channel before calling
>> l2cap_chan_send ensures that multiple threads cannot simultaneously
>> manipulate the queue when sending and receiving concurrently.
>>
>> L2CAP channel locking had previously moved to the l2cap_chan struct
>> instead of the associated socket, so some of the old socket locking
>> can also be removed in this patch.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  include/net/bluetooth/bluetooth.h |    2 --
>>  net/bluetooth/l2cap_sock.c        |   15 ++++++++-------
>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index 2fb268f..90678a9 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -256,12 +256,10 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
>>  {
>>  	struct sk_buff *skb;
>>
>> -	release_sock(sk);
>>  	if ((skb = sock_alloc_send_skb(sk, len + BT_SKB_RESERVE, nb, err))) {
>>  		skb_reserve(skb, BT_SKB_RESERVE);
>>  		bt_cb(skb)->incoming  = 0;
>>  	}
>> -	lock_sock(sk);
>>
>>  	if (!skb && *err)
>>  		return NULL;
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index 82b6368..ac8ce10 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -716,16 +716,13 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
>>  	if (msg->msg_flags & MSG_OOB)
>>  		return -EOPNOTSUPP;
>>
>> -	lock_sock(sk);
>> -
>> -	if (sk->sk_state != BT_CONNECTED) {
>> -		release_sock(sk);
>> +	if (sk->sk_state != BT_CONNECTED)
>>  		return -ENOTCONN;
>> -	}
>>
>> +	l2cap_chan_lock(chan);
>>  	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
>> +	l2cap_chan_unlock(chan);
>
> I would move these l2cap_chan_{,un}lock calls to inside
> l2cap_chan_send(). The less we use l2cap_chan_* functions here the
> better.

In V1 of this RFC set, Andrei requested that the locking calls be 
outside of l2cap_chan_send().  The A2MP code uses l2cap_chan_send(), 
and already holds the channel lock.

>>
>> -	release_sock(sk);
>>  	return err;
>>  }
>>
>> @@ -936,9 +933,13 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
>>  	struct sk_buff *skb;
>>  	int err;
>>
>> +	l2cap_chan_unlock(chan);
>> +
>>  	skb = bt_skb_send_alloc(chan->sk, len, nb, &err);
>>  	if (!skb)
>> -		return (ERR_PTR(err));
>> +		skb = ERR_PTR(err);
>> +
>> +	l2cap_chan_lock(chan);
>
> I would suggest the same here, but it might not be worth, since we would
> need to create wrapper to call alloc_skb().

bt_skb_send_alloc is also used by HCI raw sockets and SCO, so the 
locking needs to be done here.

Regards,
--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
