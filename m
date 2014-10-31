Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Add JIRA issue number to TC_GAD_CL_BV_03_C
Date: Fri, 31 Oct 2014 20:15:04 +0100
Message-ID: <1829647.ju1KoU88ou@leonov>
In-Reply-To: <1414746358-4266-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414746358-4266-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Friday 31 of October 2014 10:05:58 Marcin Kraglak wrote:
> ---
>  android/pts-gatt.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
> index 22e3bdb..9e85bcb 100644
> --- a/android/pts-gatt.txt
> +++ b/android/pts-gatt.txt
> @@ -48,7 +48,7 @@ TC_GAD_CL_BV_02_C	PASS	haltest:
>  				gattc disconnect
>  				gattc connect
>  				gattc refresh
> -TC_GAD_CL_BV_03_C	FAIL
> +TC_GAD_CL_BV_03_C	FAIL	JIRA #BA-188
>  TC_GAD_CL_BV_04_C	PASS	haltest:
>  				when requested: gattc get_characteristic
>  TC_GAD_CL_BV_05_C	PASS	haltest:

Applied, thanks.

-- 
BR
Szymon Janc
