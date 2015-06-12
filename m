Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2 4/5] Support the BCM4354 Bluetooth UART device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433966720-17482-5-git-send-email-ifaenson@broadcom.com>
Date: Fri, 12 Jun 2015 10:47:17 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Arend van Spriel <arend@broadcom.com>
Message-Id: <C6CF4337-66BB-4DEB-93DA-B04A8ACA8B54@holtmann.org>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com> <1433966720-17482-5-git-send-email-ifaenson@broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

> The ability to run over the BCM4354 while we are awaiting
> the Bluetooth UART firmware map file introduction.
> 
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/btbcm.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 8e2f6b6..1849db2 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -243,6 +243,7 @@ static const struct {
> } bcm_uart_subver_table[] = {
> 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
> 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
> +	{ 0x610c, "BCM4354_003.001.012.0306.0659"}, /* 003.001.012 */

Please shorten this to BCM4354 here. I know what you are trying to do, but we fix that different way with a manifest file.

Regards

Marcel

