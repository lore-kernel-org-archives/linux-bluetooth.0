Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 May 2011 16:02:13 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [PATCH] Bluetooth: Support SCO over HCI for Atheros AR300x
 Bluetooth device
Message-ID: <20110530190213.GC2556@joana>
References: <1305878771-26464-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305878771-26464-1-git-send-email-suraj@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

* Suraj Sumangala <suraj@atheros.com> [2011-05-20 13:36:11 +0530]:

> This patch adds SCO over HCI support to Atheros AR300x HCI transport
> driver.
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  drivers/bluetooth/hci_ath.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
> index 4093935..8e15c31 100644
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
> @@ -184,9 +179,14 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>  	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
>  
>  	skb_queue_tail(&ath->txq, skb);
> -	set_bit(HCI_UART_SENDING, &hu->tx_state);
>  
> -	schedule_work(&ath->ctxtsw);
> +	if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
> +		clear_bit(HCI_UART_SENDING, &hu->tx_state);
> +		hci_uart_tx_wakeup(hu);

We can't do that, prioritize SCO over HCI Events. This can lead to weird sync
problems, so please remove this and send me a new patch.

-- 
Gustavo F. Padovan
http://profusion.mobi
