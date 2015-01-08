Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Jan 2015 16:19:11 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix dead code warnings
Message-ID: <20150108141909.GA7114@aemeltch-MOBL1>
References: <1418981080-19796-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418981080-19796-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Fri, Dec 19, 2014 at 11:24:40AM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> gatt_db_attribute_get_permissions() used everywhere without check since
> those conditions are checked already.
> ---
>  android/gatt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 0258d91..169f6db 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -6311,8 +6311,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
>  	if (!attrib)
>  		return;
>  
> -	if (!gatt_db_attribute_get_permissions(attrib, &permissions))
> -		return;
> +	gatt_db_attribute_get_permissions(attrib, &permissions);
>  
>  	if (check_device_permissions(dev, cmd[0], permissions))
>  		return;
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
