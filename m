Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Thu, 22 Apr 2010 03:54:01 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: Re: [PATCH] Bluetooth: Fix return value when bt_skb_alloc fails
Message-ID: <20100422065401.GF22959@vigoh>
References: <1271917230-30439-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1271917230-30439-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Gustavo F. Padovan <gustavo@padovan.org> [2010-04-22 03:20:30 -0300]:

> From: Gustavo F. Padovan <padovan@profusion.mobi>
> 
> Set the proper error(ENOMEM), instead of just return 0.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  drivers/bluetooth/hci_h4.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
> index c0ce813..3f038f5 100644
> --- a/drivers/bluetooth/hci_h4.c
> +++ b/drivers/bluetooth/hci_h4.c
> @@ -246,7 +246,7 @@ static int h4_recv(struct hci_uart *hu, void *data, int count)
>  			BT_ERR("Can't allocate mem for new packet");
>  			h4->rx_state = H4_W4_PACKET_TYPE;
>  			h4->rx_count = 0;
> -			return 0;
> +			return -ENOMEM;
>  		}
>  
>  		h4->rx_skb->dev = (void *) hu->hdev;
> -- 
> 1.7.0.4
> 

Ignore this one, I have found a similar issue in other file, just sent
the new fix to the list.

-- 
Gustavo F. Padovan
http://padovan.org
