Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Apr 2013 19:29:58 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, andrei.emeltchenko@intel.com,
	akarwar@marvell.com, bzhao@marvell.com
Subject: Re: [PATCH 1/2] Bluetooth: btmrvl: release lock while waiting for fw
 download complete.
Message-ID: <20130418222958.GB15279@joana>
References: <1366301890-14100-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <1366301890-14100-2-git-send-email-andreas.fenkart@streamunlimited.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366301890-14100-2-git-send-email-andreas.fenkart@streamunlimited.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andreas,

* Andreas Fenkart <andreas.fenkart@streamunlimited.com> [2013-04-18 18:18:08 +0200]:

> If not winner, driver must release the sdio host lock, so the fw
> download can progress. While holding the lock fw download is stalled
> and the following error is produced:
> 
> [  235.746015] Bluetooth: FW failed to be active in time!
> [  235.752799] Bluetooth: Downloading firmware failed!
> 
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> ---
>  drivers/bluetooth/btmrvl_sdio.c |   26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 9959d4c..6b6abb2 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -234,7 +234,10 @@ static int btmrvl_sdio_verify_fw_download(struct btmrvl_sdio_card *card,
>  
>  	 /* Wait for firmware to become ready */
>  	for (tries = 0; tries < pollnum; tries++) {
> -		if (btmrvl_sdio_read_fw_status(card, &firmwarestat) < 0)
> +		sdio_claim_host(card->func);
> +		ret = btmrvl_sdio_read_fw_status(card, &firmwarestat);
> +		sdio_release_host(card->func);
> +		if (ret < 0)
>  			continue;
>  
>  		if (firmwarestat == FIRMWARE_READY) {
> @@ -882,19 +885,20 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
>  		BT_ERR("card or function is NULL!");
>  		return -EINVAL;
>  	}
> -	sdio_claim_host(card->func);
>  
>  	if (!btmrvl_sdio_verify_fw_download(card, 1)) {
>  		BT_DBG("Firmware already downloaded!");
> -		goto done;
> +		return 0;
>  	}
>  
> +	sdio_claim_host(card->func);
> +
>  	/* Check if other function driver is downloading the firmware */
>  	fws0 = sdio_readb(card->func, card->reg->card_fw_status0, &ret);
>  	if (ret) {
>  		BT_ERR("Failed to read FW downloading status!");
>  		ret = -EIO;
> -		goto done;
> +		goto release_host;

No need to rename this label, it is doing almost the same thing as before.

	Gustavo
