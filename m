Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com
References: <1439282325-24882-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1439282325-24882-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH v1] gatt-database: Return meaningful ecodes for ccc write
Date: Thu, 13 Aug 2015 14:31:55 +0530
Message-id: <000601d0d5a6$bf7e3070$3e7a9150$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Tuesday, August 11, 2015 2:09 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: bharat.panda@samsung.com; Gowtham Anandha Babu
> Subject: [PATCH v1] gatt-database: Return meaningful ecodes for ccc write
> 
> Removed generic ATT protocol error codes and added Common Profile and
> Service Error Codes.
> ---
>  src/gatt-database.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/src/gatt-database.c b/src/gatt-database.c index
69a814d..91aba2f
> 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -1783,22 +1783,16 @@ static uint8_t ccc_write_cb(uint16_t value, void
> *user_data)
>  		return 0;
>  	}
> 
> -	/*
> -	 * TODO: All of the errors below should fall into the so called
> -	 * "Application Error" range. Since there is no well defined error
for
> -	 * these, we return a generic ATT protocol error for now.
> -	 */
> -
>  	if (chrc->ntfy_cnt == UINT_MAX) {
>  		/* Maximum number of per-device CCC descriptors
> configured */
> -		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
> +		return BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
>  	}
> 
>  	/* Don't support undefined CCC values yet */
>  	if (value > 2 ||
>  		(value == 1 && !(chrc->props &
> BT_GATT_CHRC_PROP_NOTIFY)) ||
>  		(value == 2 && !(chrc->props &
> BT_GATT_CHRC_PROP_INDICATE)))
> -		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
> +		return BT_ERROR_CCC_IMPROPERLY_CONFIGURED;
> 
>  	/*
>  	 * Always call StartNotify for an incoming enable and ignore the
> return @@ -1807,7 +1801,7 @@ static uint8_t ccc_write_cb(uint16_t value,
> void *user_data)
>  	if (g_dbus_proxy_method_call(chrc->proxy,
>  						"StartNotify", NULL, NULL,
>  						NULL, NULL) == FALSE)
> -		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
> +		return BT_ATT_ERROR_UNLIKELY;
> 
>  	__sync_fetch_and_add(&chrc->ntfy_cnt, 1);
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

