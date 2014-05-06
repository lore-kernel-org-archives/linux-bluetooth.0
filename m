Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 1/3] Bluetooth: Refactor l2cap_sock_sendmsg() to copy user buffer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399383094.2316.9.camel@jrissane-mobl.ger.corp.intel.com>
Date: Tue, 6 May 2014 06:47:49 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4EBEB507-4D80-40B4-BDF2-EBC3F767F7B4@holtmann.org>
References: <1399282285-32743-1-git-send-email-jukka.rissanen@linux.intel.com> <1399282285-32743-2-git-send-email-jukka.rissanen@linux.intel.com> <EF0AC955-D8AD-437C-829A-7B3D938948CC@holtmann.org> <1399383094.2316.9.camel@jrissane-mobl.ger.corp.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

>>> The l2cap_chan_send() is changed to use kernel memory directly,
>>> so this function must read the user buffer before sending the
>>> message.
>>> 
>>> The change is done as the 6LoWPAN also uses l2cap_chan_send()
>>> and in order to minimize the amount of code changes, we must
>>> copy the user buffer in sock handling code.
>> 
>> is this really the best approach. What are other subsystems doing?
> 
> Johan suggested this approach and I took it :)
> 
> 
>> 
>>> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
>>> ---
>>> net/bluetooth/l2cap_core.c | 25 +++++++++++++++++++++----
>>> net/bluetooth/l2cap_sock.c | 25 ++++++++++++++++++++++++-
>>> 2 files changed, 45 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>> index a1e5bb7..528b38a 100644
>>> --- a/net/bluetooth/l2cap_core.c
>>> +++ b/net/bluetooth/l2cap_core.c
>>> @@ -2098,6 +2098,24 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
>>> 	}
>>> }
>>> 
>>> +static inline void memcpy_fromiovec_kernel(void *kdata, struct iovec *iov,
>>> +					   int len)
>>> +{
>>> +	while (len > 0) {
>>> +		if (iov->iov_len) {
>>> +			int copy = min_t(unsigned int, len, iov->iov_len);
>>> +
>>> +			memcpy(kdata, iov->iov_base, copy);
>>> +
>>> +			len -= copy;
>>> +			kdata += copy;
>>> +			iov->iov_base += copy;
>>> +			iov->iov_len -= copy;
>>> +		}
>>> +		iov++;
>>> +	}
>>> +}
>> 
>> I am a bit amazed that there are no existing helper functions for this. Should we add this to lib/iovec.c? At least lets check what the upstream guys think.
> 
> Did a quick search and did not find similar helper, I might have missed
> it thou.
> 
>> 
>>> +
>>> static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
>>> 					 struct msghdr *msg, int len,
>>> 					 int count, struct sk_buff *skb)
>>> @@ -2106,8 +2124,7 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
>>> 	struct sk_buff **frag;
>>> 	int sent = 0;
>>> 
>>> -	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count))
>>> -		return -EFAULT;
>>> +	memcpy_fromiovec_kernel(skb_put(skb, count), msg->msg_iov, count);
>>> 
>>> 	sent += count;
>>> 	len  -= count;
>>> @@ -2126,8 +2143,8 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
>>> 
>>> 		*frag = tmp;
>>> 
>>> -		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
>>> -			return -EFAULT;
>>> +		memcpy_fromiovec_kernel(skb_put(*frag, count), msg->msg_iov,
>>> +					count);
>>> 
>>> 		(*frag)->priority = skb->priority;
>>> 
>>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>>> index f59e00c..bbee8dc 100644
>>> --- a/net/bluetooth/l2cap_sock.c
>>> +++ b/net/bluetooth/l2cap_sock.c
>>> @@ -948,6 +948,9 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
>>> {
>>> 	struct sock *sk = sock->sk;
>>> 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
>>> +	struct msghdr kernel_msg;
>>> +	struct kvec iv;
>>> +	void *buf;
>>> 	int err;
>>> 
>>> 	BT_DBG("sock %p, sk %p", sock, sk);
>>> @@ -968,10 +971,30 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
>>> 	if (err)
>>> 		return err;
>>> 
>>> +	buf = kmalloc(len, GFP_KERNEL);
>>> +	if (!buf)
>>> +		return -ENOMEM;
>>> +
>>> +	if (memcpy_fromiovec(buf, msg->msg_iov, len)) {
>>> +		err = -EFAULT;
>>> +		goto done;
>>> +	}
>>> +
>>> +	iv.iov_base = buf;
>>> +	iv.iov_len = len;
>>> +
>>> +	memset(&kernel_msg, 0, sizeof(kernel_msg));
>>> +
>>> +	kernel_msg.msg_iov = (struct iovec *) &iv;
>>> +	kernel_msg.msg_iovlen = 1;
>>> +	kernel_msg.msg_flags = msg->msg_flags;
>>> +
>>> 	l2cap_chan_lock(chan);
>>> -	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
>>> +	err = l2cap_chan_send(chan, &kernel_msg, len, sk->sk_priority);
>> 
>> If we move this here. Why are we keeping input variable as an IOV? Will the kernel internal code ever use or require an IOV. We could just make l2cap_chan_send flat with a single buffer.
> 
> I can certainly refactor l2cap_chan_send() further, it is only called
> from two places in current code (a2mp.c and l2cap_sock.c).

just change l2cap_chan_send to take an SKB as input. It seems the best approach here.

Regards

Marcel

