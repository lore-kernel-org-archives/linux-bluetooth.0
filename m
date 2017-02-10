Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Do not change uart speed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170207125342.21962-1-jonashg@axis.com>
Date: Fri, 10 Feb 2017 12:41:09 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <59DECB69-AB06-4F66-8CE1-AA90A797285B@holtmann.org>
References: <20170207125342.21962-1-jonashg@axis.com>
To: jonas.holmberg@axis.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonas,

> Do not change from init_speed to oper_speed per default since it may
> cause failures and timeouts if the uart cannot handle the new speed.
> orig_speed should probably be set using device tree instead.
> ---
> drivers/bluetooth/hci_bcm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 8f6c23c..7787f82 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -809,7 +809,7 @@ static const struct hci_uart_proto bcm_proto = {
> 	.name		= "Broadcom",
> 	.manufacturer	= 15,
> 	.init_speed	= 115200,
> -	.oper_speed	= 4000000,
> +	.oper_speed	= 0,
> 	.open		= bcm_open,
> 	.close		= bcm_close,
> 	.flush		= bcm_flush,

I am generally fine with this, but the DT support for Broadcom UART devices is not yet upstream. And we need to make sure this also works for ACPI based devices. If we can get the max UART speed from ACPI, then I am fine doing it this way.

Regards

Marcel

