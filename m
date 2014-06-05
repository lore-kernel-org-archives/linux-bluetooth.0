Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] Bluetooth: Refactor l2cap_sock_sendmsg() to copy user buffer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401870293-23089-1-git-send-email-jukka.rissanen@linux.intel.com>
Date: Thu, 5 Jun 2014 13:25:27 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <36B69F81-526E-48DA-994C-1E95F71610DA@holtmann.org>
References: <1401870293-23089-1-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> The l2cap_chan_send() is changed to use kernel memory directly,
> so this function must read the user buffer before sending the
> message.
> 
> The change is done as the 6LoWPAN also uses l2cap_chan_send()
> and in order to minimize the amount of code changes, we must
> copy the user buffer in sock handling code.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> Hi,
> 
> this is a proposal related to 6LoWPAN patches I sent earlier.
> In this patch we do not copy the memory buffer for L2CAP sock
> users thus avoiding one extra memory copy.
> 
> 
> Cheers,
> Jukka
> 
> 
> include/net/bluetooth/l2cap.h |  11 +++-
> net/bluetooth/a2mp.c          |  12 +----
> net/bluetooth/l2cap_core.c    | 115 +++++++++++++++++++++++++++++-------------
> net/bluetooth/l2cap_sock.c    |  49 +++++++++++++++++-
> 4 files changed, 137 insertions(+), 50 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 4abdcb2..c6f7358 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -872,8 +872,15 @@ struct l2cap_chan *l2cap_chan_create(void);
> void l2cap_chan_close(struct l2cap_chan *chan, int reason);
> int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> 		       bdaddr_t *dst, u8 dst_type);
> -int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> -								u32 priority);
> +int l2cap_chan_send(struct l2cap_chan *chan, const void *buf, size_t len,
> +		    u32 priority, unsigned int flags);
> +typedef int (*skb_copy_cb)(struct l2cap_chan *chan, const struct msghdr *msg,
> +			   int len, unsigned int flags, int count,
> +			   struct sk_buff *skb);
> +int l2cap_chan_send_fromiovec(struct l2cap_chan *chan,
> +			      const struct msghdr *msg, size_t len,
> +			      u32 priority, skb_copy_cb fromiovec);

this is not a direction I like to go towards. The caller should not be required to provide a callback. I spent some time looking into this and it seems it is not trivial.

Our current code is super optimized to go from an iovec of the socket data into skb->frag with ACL frames. Essentially we do not have any interim layer for L2CAP. The packets are directly converted into SKBs for the HCI layer. We need to keep this optimized handling. That it depends on copy_from_user is a bit sad. And I also realized that A2MP is buggy at the moment and we need to fix that.

I do not have a solution right now. All ideas I came up with break with I-Frames from L2CAP ERTM mode. The problem is its variable header length that is killing us when we want to keep this optimized behavior. Meaning we can not pre-calculate the ACL fragments in the caller.

Regards

Marcel

