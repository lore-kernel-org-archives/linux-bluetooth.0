Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Feb 2012 11:28:56 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org, luiz.dentz@gmail.com
Subject: Re: [RFC 1/2] Bluetooth: Header changes for ERTM state machine
 replacement
Message-ID: <20120227092853.GC13267@aemeltch-MOBL1>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
 <1330029469-8565-2-git-send-email-mathewm@codeaurora.org>
 <20120224094842.GA4013@aemeltch-MOBL1>
 <CAA37ikYYGoYcOg5PD98QZt04NjzUWhi6AQVgh2eGYy94vWPQ=g@mail.gmail.com>
 <4F482993.4030104@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F482993.4030104@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Fri, Feb 24, 2012 at 04:21:39PM -0800, Mat Martineau wrote:
> >>I think that we can minimize amount of changes by redefining defines
> >>when they cannot be used.
> 
> Do you mean that it would be better to modify existing macros rather
> than remove them?

Only if they might be used of course.

> >>I also think think that patches shall be logically split like:
> >>- change control field handling
> >>- working with FCS, etc which do not affect state machine
> >>- adding states
> 
> Sounds like a good way to divide things up.

Agree, this does not mean of course that the whole code shall be put in 3
patches ;) Otherwise it might be rejected because of huge size.

> >>On Thu, Feb 23, 2012 at 12:37:48PM -0800, Mat Martineau wrote:
> >>>This change affects data structures storing ERTM state and control
> >>>-static inline __u32 __get_control(struct l2cap_chan *chan, void *p)
> >>>-{
> >>>-     if (test_bit(FLAG_EXT_CTRL,&chan->flags))
> >>>-             return get_unaligned_le32(p);
> >>>-     else
> >>>-             return get_unaligned_le16(p);
> >>>-}
> >>
> >>Cannot it still be used?
> 
> It's not needed.  The control header is only parsed in one place now
> at the beginning of l2cap_ertm_data_rcv(), and this macro isn't a
> good fit for the code there.

If this is used only once it is not needed of course.

> >>and for example here:
> >>
> >>-       __put_control(chan, control, skb_put(skb, __ctrl_size(chan)));
> >>+       /* Control header is populated later */
> >>+       if (test_bit(FLAG_EXT_CTRL,&chan->flags))

BTW: Here and in all other places please put space after ",".


> >>+               put_unaligned_le32(0, skb_put(skb, 4));
> >>+       else
> >>+               put_unaligned_le16(0, skb_put(skb, 2));
> 
> This is the only place the macro would drop in cleanly - but it
> seems like a macro should be used in more than one place unless it's
> hiding some really distracting syntax.  In this case, I think it's
> clearer to see what's going on.

If the code is dealing with control size than it is OK to see what is
going on but if you use this in L2CAP code implementing e.g. ERTM then
this is not that useful.

> And - I forgot to fix some magic numbers in those skb_puts.

Yes, we should not have them.

> >>>-static inline __u8 __ctrl_size(struct l2cap_chan *chan)
> >>>-{
> >>>-     if (test_bit(FLAG_EXT_CTRL,&chan->flags))
> >>>-             return L2CAP_EXT_HDR_SIZE - L2CAP_HDR_SIZE;
> >>>-     else
> >>>-             return L2CAP_ENH_HDR_SIZE - L2CAP_HDR_SIZE;
> >>>-}
> >
> >Do we have that many places with this test in Mat's code? If not, then
> >we might not need to bother having all of these helpers, I think. And
> >if we add them, I do think it makes sense to add them to l2cap_core.c
> >than in l2cap.h, right?
> 
> Not too many places with the FLAG_EXT_CTRL test, with use of struct
> bt_control in most of the code.  I would rather have helpers in
> l2cap_core.c if they're needed.

Agree with this.

> Thanks for the reviews!

Best regards 
Andrei Emeltchenko 
