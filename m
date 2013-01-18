Return-Path: <cyrus@holtmann.org>
Message-ID: <1358495893.5510.0.camel@aeonflux>
Subject: Re: [PATCH] bluetooth: btmrvl_sdio: look for sd8688 firmware in
 proper location
From: Marcel Holtmann <marcel@holtmann.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Bing Zhao <bzhao@marvell.com>, Ben Hutchings <ben@decadent.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	libertas-dev@lists.infradead.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Thu, 17 Jan 2013 23:58:13 -0800
In-Reply-To: <1358494643-29765-1-git-send-email-lkundrak@v3.sk>
References: <477F20668A386D41ADCC57781B1F70430D13FDB783@SC-VEXCH1.marvell.com>
	 <1358494643-29765-1-git-send-email-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lubumir,

proper commit message with explanation here please.

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/bluetooth/btmrvl_sdio.c |    8 ++++----
>  drivers/bluetooth/btmrvl_sdio.h |    6 ++++--
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 3f4bfc8..bc27d01 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -83,8 +83,8 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_87xx = {
>  };
>  
>  static const struct btmrvl_sdio_device btmrvl_sdio_sd8688 = {
> -	.helper		= "sd8688_helper.bin",
> -	.firmware	= "sd8688.bin",
> +	.helper		= "mrvl/sd8688_helper.bin",
> +	.firmware	= "mrvl/sd8688.bin",
>  	.reg		= &btmrvl_reg_8688,
>  	.sd_blksz_fw_dl	= 64,
>  };
> @@ -1179,7 +1179,7 @@ MODULE_AUTHOR("Marvell International Ltd.");
>  MODULE_DESCRIPTION("Marvell BT-over-SDIO driver ver " VERSION);
>  MODULE_VERSION(VERSION);
>  MODULE_LICENSE("GPL v2");
> -MODULE_FIRMWARE("sd8688_helper.bin");
> -MODULE_FIRMWARE("sd8688.bin");
> +MODULE_FIRMWARE("mrvl/sd8688_helper.bin");
> +MODULE_FIRMWARE("mrvl/sd8688.bin");
>  MODULE_FIRMWARE("mrvl/sd8787_uapsta.bin");
>  MODULE_FIRMWARE("mrvl/sd8797_uapsta.bin");
> diff --git a/drivers/bluetooth/btmrvl_sdio.h b/drivers/bluetooth/btmrvl_sdio.h
> index 43d35a6..4a5a019 100644
> --- a/drivers/bluetooth/btmrvl_sdio.h
> +++ b/drivers/bluetooth/btmrvl_sdio.h
> @@ -84,7 +84,9 @@ struct btmrvl_sdio_card {
>  	struct sdio_func *func;
>  	u32 ioport;
>  	const char *helper;
> +	const char *helper2;
>  	const char *firmware;
> +	const char *firmware2;

And please clear out the patch from left-overs.

>  	const struct btmrvl_sdio_card_reg *reg;
>  	u16 sd_blksz_fw_dl;
>  	u8 rx_unit;
> @@ -92,8 +94,8 @@ struct btmrvl_sdio_card {
>  };
>  
>  struct btmrvl_sdio_device {
> -	const char *helper;
> -	const char *firmware;
> +	const char *helper, *helper2;
> +	const char *firmware, *firmware2;

And here as well.

Regards

Marcel


