Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/health: Fix using uninitialized value err
Date: Tue, 17 Jun 2014 22:03:21 +0200
Message-ID: <38974833.TK0Se5ZUMM@athlon>
In-Reply-To: <1402990447-10747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402990447-10747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 17 June 2014 10:34:07 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/health.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 7e2c5d6..85100cd 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -242,7 +242,7 @@ static int
> register_service_additional_protocols(sdp_record_t *rec, sdp_list_t
> *access_proto_list = NULL;
>  	sdp_data_t *psm = NULL;
>  	uint32_t dcpsm;
> -	GError *err;
> +	GError *err = NULL;
> 
>  	DBG("");

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
