Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update GAP TC_CONN_CPUP_BV_06_C test result
Date: Tue, 10 Jun 2014 14:05:37 +0200
Message-ID: <4029435.KgTHP1E5xz@uw000953>
In-Reply-To: <1402323259-15400-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1402323259-15400-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 09 of June 2014 16:14:19 Grzegorz Kolodziejczyk wrote:
> ---
>  android/pts-gap.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/android/pts-gap.txt b/android/pts-gap.txt
> index f83a8be..2b335a1 100644
> --- a/android/pts-gap.txt
> +++ b/android/pts-gap.txt
> @@ -133,7 +133,12 @@ TC_CONN_CPUP_BV_04_C	PASS	gattc register_client
>  TC_CONN_CPUP_BV_05_C	PASS	gattc register_client
>  				gattc connect 1 <pts_bdaddr>
>  				gattc disconnect 1 <pts_bdaddr> 1
> -TC_CONN_CPUP_BV_06_C	INC
> +TC_CONN_CPUP_BV_06_C	PASS	gattc register_client
> +				gattc connect 1 <pts_bdaddr>
> +				hcitool lecup <handle> 0x0008 0x0C7B 0x0010
> +					0x0014
> +				gattc disconnect <client_if> <pts_bdaddr>
> +					<conn_id>
>  TC_CONN_TERM_BV_01_C	PASS
>  TC_CONN_PRDA_BV_01_C	INC	Privacy feature - not implemented
>  TC_CONN_PRDA_BV_02_C	INC	Privacy feature - not implemented
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
