Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update GAP results
Date: Wed, 18 Jun 2014 20:13:50 +0200
Message-ID: <3432343.o6xrKI8f6P@leonov>
In-Reply-To: <1403105386-4496-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403105386-4496-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 18 of June 2014 17:29:46 Jakub Tyszkowski wrote:
> ---
>  android/pts-gap.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/pts-gap.txt b/android/pts-gap.txt
> index 87151bd..db2690f 100644
> --- a/android/pts-gap.txt
> +++ b/android/pts-gap.txt
> @@ -336,7 +336,7 @@ TC_PRIV_CONN_BV_07_C	N/A
>  TC_PRIV_CONN_BV_08_C	N/A
>  TC_PRIV_CONN_BV_09_C	N/A
>  TC_PRIV_CONN_BV_10_C	N/A
> -TC_PRIV_CONN_BV_11_C	INC	Privacy feature - not implemented
> +TC_PRIV_CONN_BV_11_C	INC	PTS issue #12310
>  TC_ADV_BV_01_C		N/A
>  TC_ADV_BV_02_C		FAIL	PTS issue #12254
>  TC_ADV_BV_03_C		PASS	gattc register_client

Patch applied, thanks.

-- 
BR
Szymon Janc
