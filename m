Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Feb 2012 11:48:45 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org, luiz.dentz@gmail.com,
	ulisses@profusion.mobi
Subject: Re: [RFC 1/2] Bluetooth: Header changes for ERTM state machine
 replacement
Message-ID: <20120224094842.GA4013@aemeltch-MOBL1>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
 <1330029469-8565-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330029469-8565-2-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

It is better to have normal patches for a better review.
I think that we can minimize amount of changes by redefining defines
when they cannot be used.

I also think think that patches shall be logically split like:
- change control field handling
- working with FCS, etc which do not affect state machine
- adding states

Also check some comments below: (I copied some code from the link you sent)

On Thu, Feb 23, 2012 at 12:37:48PM -0800, Mat Martineau wrote:
> This change affects data structures storing ERTM state and control
> fields, and adds new definitions for states and events.  An
> l2cap_seq_list structure is added for tracking ERTM sequence numbers
> without repeated memory allocations.  Control fields are carried in
> the bt_skb_cb struct rather than constantly doing shift and mask
> operations.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/bluetooth.h |   14 ++-
>  include/net/bluetooth/l2cap.h     |  260 +++++++++----------------------------
>  2 files changed, 73 insertions(+), 201 deletions(-)

...

> -static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
> -{
> -	int sub;
> -
> -	sub = (ch->next_tx_seq - ch->expected_ack_seq) % 64;
> -
> -	if (sub < 0)
> -		sub += 64;
> -
> -	return sub == ch->remote_tx_win;
> -}

BTW: was it already changed? What is the status with Luiz's patch?

...

> -static inline __u32 __get_control(struct l2cap_chan *chan, void *p)
> -{
> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> -		return get_unaligned_le32(p);
> -	else
> -		return get_unaligned_le16(p);
> -}

Cannot it still be used?

+       if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
+               __get_extended_control(get_unaligned_le32(skb->data),
+                                      control);
+               skb_pull(skb, L2CAP_EXT_CTRL_SIZE);
+       } else {
+               __get_enhanced_control(get_unaligned_le16(skb->data),
+                                      control);
+               skb_pull(skb, L2CAP_ENH_CTRL_SIZE);
+       }
 
-       control = __get_control(chan, skb->data);
-       skb_pull(skb, __ctrl_size(chan));

...

> -static inline void __put_control(struct l2cap_chan *chan, __u32 control,
> -								void *p)
> -{
> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> -		return put_unaligned_le32(control, p);
> -	else
> -		return put_unaligned_le16(control, p);
> -}

Can it be used in the code below:

+               if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
+                       put_unaligned_le32(__pack_extended_control(control),
+                                       skb->data + L2CAP_HDR_SIZE);
+               } else {
+                       put_unaligned_le16(__pack_enhanced_control(control),
+                                       skb->data + L2CAP_HDR_SIZE);
+               }

and for example here:

-       __put_control(chan, control, skb_put(skb, __ctrl_size(chan)));
+       /* Control header is populated later */
+       if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+               put_unaligned_le32(0, skb_put(skb, 4));
+       else
+               put_unaligned_le16(0, skb_put(skb, 2));


> -
> -static inline __u8 __ctrl_size(struct l2cap_chan *chan)
> -{
> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> -		return L2CAP_EXT_HDR_SIZE - L2CAP_HDR_SIZE;
> -	else
> -		return L2CAP_ENH_HDR_SIZE - L2CAP_HDR_SIZE;
> -}

Regards,
Andrei
