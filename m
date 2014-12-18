Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] android/gatt: Report error on invalid value length for CCC descriptor
Date: Thu, 18 Dec 2014 11:47:43 +0100
Message-ID: <18922032.OiTWhopxOi@uw000953>
In-Reply-To: <1418731357-8531-2-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418731357-8531-1-git-send-email-jakub.tyszkowski@tieto.com> <1418731357-8531-2-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 16 of December 2014 13:02:37 Jakub Tyszkowski wrote:
> For application services, characteristics and descriptors it's user app's
> responsibility to verify value length but for embeded ones we need to do
> this in daemon. This is checked in TC_GAW_SR_BI_34_C and PTS tries to
> write to embeded CCC descritor if no other descriptors are added by the
> apps. It is expected by PTS for us to be more strict about value length
> controll.
> ---
>  android/gatt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 1e2627b..5f2f1c4 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -6958,6 +6958,13 @@ static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
>  		return;
>  	}
>  
> +	/* No more than 2 octets are expected */
> +	if (len > 2) {
> +		gatt_db_attribute_write_result(attrib, id,
> +						ATT_ECODE_INVAL_ATTR_VALUE_LEN);
> +		return;
> +	}
> +

I think we should check if len == 2 here and use get_le16()
and pass u16 to bt_store_gatt_ccc() (instead of u8 as will *value).

>  	/* Set services changed indication value */
>  	bt_store_gatt_ccc(bdaddr, *value);
>  
> 

-- 
Best regards, 
Szymon Janc
