Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Aug 2012 12:46:08 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, jaganath.k@samsung.com
Subject: Re: [PATCH] Bluetooth: debug: Correct the PSM printing
Message-ID: <20120806094607.GB2819@aemeltch-MOBL1>
References: <1343413282-8901-1-git-send-email-s.syam@samsung.com>
 <1343413282-8901-2-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343413282-8901-2-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Fri, Jul 27, 2012 at 11:51:22PM +0530, Syam Sidhardhan wrote:
> Earlier we were printing chan->psm before assigning any value.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index bedc960..0912a63 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1447,7 +1447,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
>  	int err;
>  
>  	BT_DBG("%s -> %s (type %u) psm 0x%2.2x", batostr(src), batostr(dst),
> -	       dst_type, __le16_to_cpu(chan->psm));
> +	       dst_type, __le16_to_cpu(psm));
>  
>  	hdev = hci_get_route(dst, src);
>  	if (!hdev)
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
