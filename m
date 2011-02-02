Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Feb 2011 14:16:41 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [PATCH] Bluetooth: Support SCO over HCI for Atheros AR300x
 Bluetooth device
Message-ID: <20110202161641.GC2273@joana>
References: <1296211744-2487-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296211744-2487-1-git-send-email-suraj@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

* Suraj Sumangala <suraj@atheros.com> [2011-01-28 16:19:04 +0530]:

> This patch adds SCO over HCI support to Atheros AR300x HCI transport
> driver.
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  drivers/bluetooth/hci_ath.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
> index 6a160c1..161bd20 100644
> --- a/drivers/bluetooth/hci_ath.c
> +++ b/drivers/bluetooth/hci_ath.c
> @@ -162,11 +162,6 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>  {
>  	struct ath_struct *ath = hu->priv;
>  
> -	if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
> -		kfree_skb(skb);
> -		return 0;
> -	}
> -
>  	/*
>  	 * Update power management enable flag with parameters of
>  	 * HCI sleep enable vendor specific HCI command.
> @@ -183,10 +178,15 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>  	/* Prepend skb with frame type */
>  	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
>  
> -	skb_queue_tail(&ath->txq, skb);
> -	set_bit(HCI_UART_SENDING, &hu->tx_state);
> -
> -	schedule_work(&ath->ctxtsw);
> +	if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
> +		skb_queue_head(&ath->txq, skb);
> +		clear_bit(HCI_UART_SENDING, &hu->tx_state);
> +		hci_uart_tx_wakeup(hu);

Seems you are giving priority to SCO packets, right? why?

-- 
Gustavo F. Padovan
http://profusion.mobi
