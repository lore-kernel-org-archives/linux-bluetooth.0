Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] android/pts: Update GATT PTS test results
Date: Thu, 06 Nov 2014 16:19:54 +0100
Message-ID: <2629143.XS6eJUSl1Y@uw000953>
In-Reply-To: <1415192511-7651-3-git-send-email-marcin.kraglak@tieto.com>
References: <1415192511-7651-1-git-send-email-marcin.kraglak@tieto.com> <1415192511-7651-3-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 05 of November 2014 14:01:51 Marcin Kraglak wrote:
> ---
>  android/pts-gatt.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
> index 9e85bcb..ea6a014 100644
> --- a/android/pts-gatt.txt
> +++ b/android/pts-gatt.txt
> @@ -48,7 +48,13 @@ TC_GAD_CL_BV_02_C	PASS	haltest:
>  				gattc disconnect
>  				gattc connect
>  				gattc refresh
> -TC_GAD_CL_BV_03_C	FAIL	JIRA #BA-188
> +TC_GAD_CL_BV_03_C	PASS	haltest:
> +                                gattc register_client
> +                                gattc scan
> +                                gattc connect
> +                                gattc search_service
> +				gattc get_included_service
> +				gattc_disconnect
>  TC_GAD_CL_BV_04_C	PASS	haltest:
>  				when requested: gattc get_characteristic
>  TC_GAD_CL_BV_05_C	PASS	haltest:
> 

This patch is now applied, thanks.

-- 
Best regards, 
Szymon Janc
