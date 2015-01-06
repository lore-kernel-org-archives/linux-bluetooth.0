Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: btmrvl: fix card reset and suspend race issue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420538205-12901-1-git-send-email-akarwar@marvell.com>
Date: Tue, 6 Jan 2015 07:21:21 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Cathy Luo <cluo@marvell.com>
Message-Id: <AFEE3FAB-C05E-4F2F-873F-28061AB962F9@holtmann.org>
References: <1420538205-12901-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> Sometimes suspend thread queues a command and wait for it's
> response, meanwhile WLAN driver power cycles the card which
> leads to crash. This patch makes sure that suspend thread is
> woken up in remove path.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_main.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
> index c4a542c..27fa98f 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -207,10 +207,14 @@ static int btmrvl_send_sync_cmd(struct btmrvl_private *priv, u16 opcode,
> 	wake_up_interruptible(&priv->main_thread.wait_q);
> 
> 	if (!wait_event_interruptible_timeout(priv->adapter->cmd_wait_q,
> -				priv->adapter->cmd_complete,
> +				priv->adapter->cmd_complete ||
> +				priv->surprise_removed,
> 				msecs_to_jiffies(WAIT_UNTIL_CMD_RESP)))

I know that even before this patch the coding style was off, but please do not make it worse. So lets fix the coding style here as well.

> 		return -ETIMEDOUT;
> 
> +	if (priv->surprise_removed)
> +		return -EFAULT;
> +
> 	return 0;
> }
> 
> @@ -292,9 +296,10 @@ int btmrvl_enable_hs(struct btmrvl_private *priv)
> 	}
> 
> 	ret = wait_event_interruptible_timeout(adapter->event_hs_wait_q,
> -					       adapter->hs_state,
> +					       adapter->hs_state ||
> +					       priv->surprise_removed,
> 			msecs_to_jiffies(WAIT_UNTIL_HS_STATE_CHANGED));

Same here. I would have the mecs_to_jiffies in the constant declaration.

Regards

Marcel


