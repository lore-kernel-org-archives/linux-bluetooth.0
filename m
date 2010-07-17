Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Support for Atheros AR300x serial Bluetooth
 Chip
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com,
	"Luis R. Rodriguez" <lrodriguez@atheros.com>
In-Reply-To: <1279191250-5923-1-git-send-email-suraj@atheros.com>
References: <1279191250-5923-1-git-send-email-suraj@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 17 Jul 2010 15:18:28 -0700
Message-ID: <1279405108.6282.90.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Implements Atheros AR300x Serial HCI protocol.
> This protocol extends H4 serial protocol to implement enhanced power management
> features supported by Atheros AR300x serial Bluetooth chipsets.

<snip>

> +struct ath_struct {
> +	struct hci_uart *hu;
> +	unsigned int cur_sleep;
> +
> +	spinlock_t hciath_lock;
> +	struct sk_buff *rx_skb;
> +	struct sk_buff_head txq;
> +	wait_queue_head_t wqevt;
> +	struct work_struct ctxtsw;
> +};

I was going to merge this as it is, but then I did a usage check on your
variables here and realized that you carry garbage around. I really
would prefer if you guys start cleaning up your patches before blindly
submitting them. I am not your janitor.

So hciath_lock, rx_skb and wqevt are unused in the whole driver. Please
remove them from the patch.

Regards

Marcel


