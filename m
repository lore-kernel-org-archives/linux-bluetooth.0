Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Sep 2010 09:26:34 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: check L2CAP length in first ACL fragment
In-Reply-To: <1283519240-1235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Message-ID: <alpine.DEB.2.00.1009030837330.26179@linux-sea-02>
References: <1283519240-1235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Fri, 3 Sep 2010, Emeltchenko Andrei wrote:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>
> Current Bluetooth code assembles fragments of big L2CAP packets
> in l2cap_recv_acldata and then checks allowed L2CAP size in
> assembled L2CAP packet (pi->imtu < skb->len).
>
> The patch moves allowed L2CAP size check to the early stage when
> we receive the first fragment of L2CAP packet. First fragment has
> already L2CAP header including length.
>
> Trace below is received when using stress tools sending big
> fragmented L2CAP packets.
> ...
> [ 1712.798492] swapper: page allocation failure. order:4, mode:0x4020
> [ 1712.804809] [<c0031870>] (unwind_backtrace+0x0/0xdc) from [<c00a1f70>]
> (__alloc_pages_nodemask+0x4)
> [ 1712.814666] [<c00a1f70>] (__alloc_pages_nodemask+0x47c/0x4d4) from
> [<c00a1fd8>] (__get_free_pages+)
> [ 1712.824645] [<c00a1fd8>] (__get_free_pages+0x10/0x3c) from [<c026eb5c>]
> (__alloc_skb+0x4c/0xfc)
> [ 1712.833465] [<c026eb5c>] (__alloc_skb+0x4c/0xfc) from [<bf28c738>]
> (l2cap_recv_acldata+0xf0/0x1f8 )
> [ 1712.843322] [<bf28c738>] (l2cap_recv_acldata+0xf0/0x1f8 [l2cap]) from
> [<bf0094ac>] (hci_rx_task+0x)
> ...

What is logged right before this allocation failure?  There should be 
a "Start: total len %d, frag len %d" line.  Actually, all log messages 
from l2cap_recv_acldata leading up to the failure would be helpful.

>
> After applying patch dmesg looks like:
> ...
> l2cap_recv_acldata: Frame exceeding recv MTU (len 64182, MTU 1013)
> l2cap_recv_acldata: Unexpected continuation frame (len 34)
> ...
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
> net/bluetooth/l2cap.c |   11 +++++++++++
> 1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 9fad312..21824d7 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -4654,6 +4654,8 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
>
> 	if (flags & ACL_START) {
> 		struct l2cap_hdr *hdr;
> +		struct sock *sk;
> +		u16 cid;
> 		int len;
>
> 		if (conn->rx_len) {
> @@ -4672,6 +4674,7 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
>d
> 		hdr = (struct l2cap_hdr *) skb->data;
> 		len = __le16_to_cpu(hdr->len) + L2CAP_HDR_SIZE;
> +		cid = __le16_to_cpu(hdr->cid);

Some stress tools also send L2CAP data one byte at a time - the start 
fragment may not have all four header bytes.  l2cap_recv_acldata() 
currently allows short start fragments with two or three bytes, which 
would not contain a valid CID.

>
> 		if (len == skb->len) {
> 			/* Complete frame received */
> @@ -4688,6 +4691,14 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
> 			goto drop;
> 		}
>
> +		sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);

There are several issues here.

l2cap_get_chan_by_scid() might return NULL, which will definitely 
happen with signaling or connectionless data frames.

l2cap_get_chan_by_scid() also calls bh_lock_sock() if a channel is 
found, and I don't see that you added a matching call to 
bh_unlock_sock() if l2cap_get_chan_by_scid() returns a non-NULL value.

> +		if (l2cap_pi(sk)->imtu < len) {
> +			BT_ERR("Frame exceeding recv MTU (len %d, MTU %d)",
> +					len, l2cap_pi(sk)->imtu);
> +			conn->rx_len = 0; /* needed? */
> +			goto drop;
> +		}
> +
> 		/* Allocate skb for the complete frame (with header) */
> 		conn->rx_skb = bt_skb_alloc(len, GFP_ATOMIC);
> 		if (!conn->rx_skb)

In general, this approach adds an extra channel lookup and an extra 
lock/unlock on every ACL start frame.  Even if the MTU is known to be 
exceeded on with the start frame, no more than 64k is ever allocated 
(which shouldn't cause problems in itself).  The root of the problem 
may be heap corruption due to a buffer overrun, which seems possible 
due to the crash deep in the memory allocator.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

