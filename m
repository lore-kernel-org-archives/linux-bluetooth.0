Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 4 Apr 2011 18:16:17 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: suraj@atheros.com, marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: change gfp type in hci_recv_stream_fragment()
Message-ID: <20110404211617.GD2230@joana>
References: <1301554616-27595-1-git-send-email-jiejing.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301554616-27595-1-git-send-email-jiejing.zhang@freescale.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhang,

* Zhang Jiejing <jiejing.zhang@freescale.com> [2011-03-31 14:56:56 +0800]:

> change gfp type passed to hci_reassembly(), replace GFP_ATOMIC
> to GFP_KERNEL. Since some HCI_ACLDATA may request 1024+4 bytes
> some time GFP_ATOMIC will failed to allocation memory during
> large file FTP transfer in high baud rate.
> 
> Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
> ---
>  net/bluetooth/hci_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 9c4541b..22b3ded 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1214,7 +1214,7 @@ int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
>  			type = bt_cb(skb)->pkt_type;
>  
>  		rem = hci_reassembly(hdev, type, data,
> -					count, STREAM_REASSEMBLY, GFP_ATOMIC);
> +					count, STREAM_REASSEMBLY, GFP_KERNEL);

We can't use GFP_KERNEL in a interrupt context, we can't sleep here and
GFP_ATOMIC guarantees that.

-- 
Gustavo F. Padovan
http://profusion.mobi
