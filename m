Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] android/health: Fix setting wrong PSM for SDP record
Date: Thu, 26 Jun 2014 09:43:33 +0200
Message-ID: <3891930.sElqN291qS@uw000953>
In-Reply-To: <1403766892-14108-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403766892-14108-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 26 of June 2014 10:14:52 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/health.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index b07b11d..79d8055 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -387,7 +387,7 @@ static int register_service_additional_protocols(sdp_record_t *rec,
>  	if (!l2cap_list)
>  		goto fail;
>  
> -	dcpsm = mcap_get_ctrl_psm(mcap, &err);
> +	dcpsm = mcap_get_data_psm(mcap, &err);
>  	if (err)
>  		goto fail;
>  

Patch applied, thanks. 

-- 
Best regards, 
Szymon Janc
