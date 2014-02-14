Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Feb 2014 11:01:38 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix memory leak: uuid free
Message-ID: <20140214090100.GB3793@aemeltch-MOBL1>
References: <1392214927-2715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392214927-2715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 12, 2014 at 04:22:07PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Free uuid before exiting.

ping

> ---
>  android/bluetooth.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 5de3401..b818e88 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1557,6 +1557,8 @@ int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint)
>  
>  		sdp_uuid2strn(uuid, uuid_str, sizeof(uuid_str));
>  		DBG("UUID %s already added", uuid_str);
> +
> +		bt_free(uuid);
>  		return -EALREADY;
>  	}
>  
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
