Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 11/11] android/gatt: Verify offset on srvc change ccc write
Date: Tue, 13 Jan 2015 14:48:57 +0100
Message-ID: <2487952.WsYVOWAuiO@uw000953>
In-Reply-To: <1420708669-32600-11-git-send-email-jakub.tyszkowski@tieto.com>
References: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com> <1420708669-32600-11-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 08 of January 2015 10:17:49 Jakub Tyszkowski wrote:
> Protect CCC from remote sending invalid prepare write offset.
> 
> We are not using offset value in the code right now, but there is a test
> case in PTS that expects this error to be send. PTS can use this embeded
> service's ccc descriptor if no such descriptors are added by the user.

Please mention affected PTS test name.

> ---
>  android/gatt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index c00eb9e..70b8a00 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -7029,6 +7029,12 @@ static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
>  		return;
>  	}
>  
> +	if (offset > 1) {
> +			gatt_db_attribute_write_result(attrib, id,
> +						ATT_ECODE_INVALID_OFFSET);
> +			return;

Indentation is wrong here.

> +	}
> +
>  	/* 2 octets are expected as CCC value */
>  	if (len != 2) {
>  		gatt_db_attribute_write_result(attrib, id,
> 

-- 
Best regards, 
Szymon Janc
