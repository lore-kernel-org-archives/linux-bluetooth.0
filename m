Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] Bluetooth: Provide L2CAP ops callback for memcpy_fromiovec
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402493714-30849-1-git-send-email-marcel@holtmann.org>
Date: Wed, 11 Jun 2014 18:00:14 +0200
Message-Id: <7C6C6BF5-0ED9-4900-B8EE-1778BB80187B@holtmann.org>
References: <1402493714-30849-1-git-send-email-marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

so this patch is just the groundwork to deal with the socket vs kernel internal handling of TX path. And this patch should most likely also be split into providing the default for alloc_skb and then adding memcpy_fromiovec.

And I have just compile-tested this patch. I have not run it yet. I leave this to someone else to actually test if this works ;)

> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> include/net/bluetooth/l2cap.h | 35 +++++++++++++++++++++++++++++++++++
> net/bluetooth/a2mp.c          | 18 ++++--------------
> net/bluetooth/l2cap_core.c    |  6 ++++--
> net/bluetooth/l2cap_sock.c    | 34 +++++++++++++++++++++-------------
> 4 files changed, 64 insertions(+), 29 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 92511034d1d4..e4f4ca69e301 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -602,6 +602,9 @@ struct l2cap_ops {
> 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
> 					       unsigned long hdr_len,
> 					       unsigned long len, int nb);
> +	int			(*memcpy_fromiovec) (struct l2cap_chan *chan,
> +						     unsigned char *kdata,
> +						     struct iovec *iov, int len);
> };
> 

This is just the first step on how we should deal with addressing this. With this step however further work on 6loWPAN and using l2cap_chan for SMP will become possible. It is also fixing the copy_from_user issue with A2MP that we already have right now and nobody noticed.

Long term I think alloc_skb and memcpy_fromiovec should be combined into a single callback. The problem here is the L2CAP header and in more detail the ERTM / I-Frame headers. It needs a bit clearly work on how to allocate the SKB and reserve the proper headroom for the header. In addition we should properly use appropriate network and transport header pointers of the SKB to map L2CAP headers and HCI ACL headers.

I still have to figure our why the FCS with ERTM and fragmented ACL data actually works since that code is still a bit unclear to me. At this level with might want to add kernel tracing support to L2CAP so that we can use ftrace here. So if anybody is looking for a hobby kernel project, here is one ;)

Regards

Marcel

