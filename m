Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix memory leak: uuid free
Date: Fri, 14 Feb 2014 11:36:28 +0100
Message-ID: <2445828.LJE0Spnr79@uw000953>
In-Reply-To: <1392214927-2715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1392214927-2715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 12 of February 2014 16:22:07 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Free uuid before exiting.
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

Applied, thanks.

-- 
Best regards, 
Szymon Janc
