Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120809144555.GB2683@aemeltch-MOBL1>
References: <501BC0D5.8080403@linux.intel.com>
	<501BC282.9070509@linux.intel.com>
	<CAJ2qBzaLyPiwEcd2n5Kdu_Y4KMpYjvjGo+Ddk3RC1Cf6_k=K9A@mail.gmail.com>
	<20120809144555.GB2683@aemeltch-MOBL1>
Date: Fri, 10 Aug 2012 10:02:53 +0100
Message-ID: <CAJ2qBzZ3bYd-9ab41q1Xp3xt4m+evp5w5Yx9T1-ZkasP272sMQ@mail.gmail.com>
Subject: Re: RFCOMM disconnection problem
From: Dean Jenkins <djenkins@mvista.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Dean Jenkins <djenkins@mvista.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 9 August 2012 15:46, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Dean,
>
> On Thu, Aug 09, 2012 at 03:29:18PM +0100, Dean Jenkins wrote:
>> One obvious failure of the rfcomm session refcnt is that the refcnt
>> counter either starts with a value of 0 or 1 depending on which peer
>> initiated the connection request, that is wrong. The initiator
>> direction is not relevant for the session as connect and disconnect
>> are independent events. The refcnt should start with a value of 1 in
>> all cases.
>>
>> I am using a 2-core ARM environment that is under high processor
>> loading. The rfcomm session refcnt caused kernel crashes. I used a
>> 2.6.34 kernel but the latest 3.5-RC1 still has the poor rfcomm code.
>> My solution was to remove the rfcomm session refcnt and to ensure that
>> the freeing of the rfcomm session pointer was propagated through-out
>> the rfcomm core code. Some kernel crashes were due to reuse of the
>> freed rfcomm session pointer.
>
> Maybe it does make sense to fix refcounting instead of removing?
>
Hi Andrei,

The existing rfcomm session state machine is capable of determining
when to delete the rfcomm session structure. IMHO the refcnt is an
unnecessary complication. I have fixed rfcomm for our project by
removing the refcnt and ensuring no code can reuse a freed rfcomm
session pointer. This code I have already sent to the mailing list.

In order to get rfcomm to fail, high processor load is necessary
during disconnections to ensure that some of the loops in rfcomm
process more than 1 thing. It is because there are multiple copies of
the rfcomm session pointer s that failure occurs eg. double rfcomm
session free.

Here is an example in net/bluetooth/rfcomm/core.c:

static inline void rfcomm_process_rx(struct rfcomm_session *s)
{
	struct socket *sock = s->sock;
	struct sock *sk = sock->sk;
	struct sk_buff *skb;

	BT_DBG("session %p state %ld qlen %d", s, s->state,
skb_queue_len(&sk->sk_receive_queue));

	/* Get data directly from socket receive queue without copying it. */
	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
		skb_orphan(skb);
		if (!skb_linearize(skb))
			rfcomm_recv_frame(s, skb);
		else
			kfree_skb(skb);
	}

	if (sk->sk_state == BT_CLOSED) {
		if (!s->initiator)
			rfcomm_session_put(s);

		rfcomm_session_close(s, sk->sk_err);
	}
}

In rfcomm_process_rx(), you can see there is a while loop that causes
frames to be analysed and actioned in rfcomm_recv_frame(). This action
may cause the rfcomm session pointer to be freed because the rfcomm
session refcnt has reached zero. Therefore, the s pointer is now
invalid in the scope of rfcomm_process_rx() because the underlying
session structure was freed. Unfortunately,  if the socket state is
also detected as BT_CLOSED then !s->initiator may cause a crash or at
least accesses wrong data as the s pointer is invalid (pointing to
freed memory or reallocated memory). The refcnt in
rfcomm_session_put(s) is also invalid as s is invalid. In fact looking
at the initiator value is wrong for the rfcomm session. I suspect this
was a workaround that did not fix the root cause.

In practice, this failure scenario is difficult to reproduce (we hit
it in our embedded environment). It requires the socket to be in the
BT_CLOSED at the same time as the rfcomm session has been freed in a
single run of rfcomm_process_rx(). This is why high processor loading
triggers the malfunction because rfcomm_process_rx() maybe pre-empted
or time-sliced so rfcomm_process_rx() takes longer to complete than
normal. This gives the opportunity for the socket state to change to
BT_CLOSED during the run-time of rfcomm_process_rx().

In other words, the refcnt going to zero does not prevent copies of
the rfcomm session pointer s that now points to freed memory (or
reallocated memory) from being erroneously reused.

You can also see

		if (!s->initiator)
			rfcomm_session_put(s);

		rfcomm_session_close(s, sk->sk_err);

If rfcomm_session_put(s) succeeds in causing the refcnt to go to zero,
the rfcomm session structure will be freed. s is now invalid.
Unfortunately, rfcomm_session_close(s, sk->sk_err) reuses the s
pointer with a potential for a crash.

The refcnt could be fixed but fixing it will show it to be unnecessary
code IMHO. One of the weaknesses in the code is not managing the s
pointer after the session has been freed.

I do intend to release a patchset of all our rfcomm changes.

I welcome any comments.

Regards,
Dean

> Best regards
> Andrei Emeltchenko
>
>>
>> I intend to release a patchset of rfcomm fixes.
>>
>> Therefore, IMHO the fix "Bluetooth: Fix RFCOMM session reference
>> counting issue" (commit cf33e7 in linux-stable.git) from Octavian
>> Purdila in kernel 3.4.6 is in fact not fixing the root cause and
>> introduces a misbehaviour of the refcnt. In our project, we rejected
>> this commit because disconnections failed.
>>
>


-- 
Dean Jenkins
Embedded Software Engineer
Professional Services UK/EMEA
MontaVista Software, LLC
