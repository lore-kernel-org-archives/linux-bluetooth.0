Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PTS GAP test results
Date: Tue, 17 Jun 2014 16:08:27 +0200
Message-ID: <1733375.NJE76f3crG@uw000953>
In-Reply-To: <1403010877-2391-1-git-send-email-marcin.kraglak@tieto.com>
References: <1403010877-2391-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tuesday 17 of June 2014 15:14:37 Marcin Kraglak wrote:
> ---
>  android/pts-gap.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pts-gap.txt b/android/pts-gap.txt
> index cd70326..bb7f172 100644
> --- a/android/pts-gap.txt
> +++ b/android/pts-gap.txt
> @@ -217,8 +217,11 @@ TC_SEC_AUT_BV_18_C	PASS	haltest: gattc register_client
>  				bluetooth create_bond
>  				gattc read_characteristic
>  TC_SEC_AUT_BV_19_C	PASS
> -TC_SEC_AUT_BV_20_C	INC	Link security level elevation - not implemented
> -TC_SEC_AUT_BV_21_C	INC	Link security level elevation - not implemented
> +TC_SEC_AUT_BV_20_C	INC	PTS issue [ID:12284]
> +TC_SEC_AUT_BV_21_C	PASS	haltest: gattc register_client
> +				gattc connect
> +				bluetooth create_bond
> +				gattc connect
>  TC_SEC_AUT_BV_22_C	INC	Link security level elevation - not implemented
>  TC_SEC_AUT_BV_23_C	PASS	haltest: gatts register_server
>  				gatts add_service 2 <uuid> 3
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
