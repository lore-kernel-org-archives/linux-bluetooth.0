Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/6] android/pan: Return correct error value
Date: Thu, 26 Feb 2015 10:31:16 +0100
Message-ID: <13838013.rVrWx2AP1Y@uw000953>
In-Reply-To: <1424355399-10015-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424355399-10015-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1424355399-10015-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 19 of February 2015 15:16:35 Grzegorz Kolodziejczyk wrote:
> If problem with bt_io_listen occurs the input/output error is the most
> aproperiate error code to problem rather than invalid argument error
> code.
> ---
>  android/pan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/pan.c b/android/pan.c
> index 3471805..972af89 100644
> --- a/android/pan.c
> +++ b/android/pan.c
> @@ -636,7 +636,7 @@ static int register_nap_server(void)
>  		destroy_nap_device();
>  		error("%s", gerr->message);
>  		g_error_free(gerr);
> -		return -EINVAL;
> +		return -EIO;
>  	}
>  
>  	return 0;
> 

This patch is now applied, thanks.

-- 
Best regards, 
Szymon Janc
