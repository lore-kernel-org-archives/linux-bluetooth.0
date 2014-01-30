Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pts: PTS test results for AVCTP
Date: Thu, 30 Jan 2014 17:28:09 +0100
Message-ID: <2111615.yXGGy1ROm3@leonov>
In-Reply-To: <1391002025-15997-1-git-send-email-sebastianx.chlad@intel.com>
References: <1391002025-15997-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Wednesday 29 of January 2014 15:27:04 Sebastian Chlad wrote:
> ---
>  android/pts-avctp.txt | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/android/pts-avctp.txt b/android/pts-avctp.txt
> index c057a10..a57ecee 100644
> --- a/android/pts-avctp.txt
> +++ b/android/pts-avctp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for AVCTP
> 
>  PTS version: 5.0
> -Tested: --not yet tested--
> +Tested: 29.01.2014
> 
>  Results:
>  PASS	test passed
> @@ -29,13 +29,13 @@ TC_CT_FRA_BV_04_C	N/A
>  ---------------------------------------------------------------------------
> ---- Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- -TC_TG_CCM_BV_01_C	INC
> -TC_TG_CCM_BV_02_C	INC
> -TC_TG_CCM_BV_03_C	INC
> -TC_TG_CCM_BV_04_C	INC
> -TC_TG_NFR_BV_02_C	INC
> -TC_TG_NFR_BV_03_C	INC
> -TC_TG_NFR_BI_01_C	INC
> -TC_TG_FRA_BV_02_C	INC
> +TC_TG_CCM_BV_01_C	PASS	avtest --device hci0 --avctp --send x 
<bdaddr>
> +TC_TG_CCM_BV_02_C	PASS	avtest --device hci0 --avctp --send x 
<bdaddr>
> +TC_TG_CCM_BV_03_C	PASS	avtest --device hci0 --avctp --send x 
<bdaddr>
> +TC_TG_CCM_BV_04_C	PASS	avtest --device hci0 --avctp --send x 
<bdaddr>
> +TC_TG_NFR_BV_02_C	PASS	avtest --device hci0 --avctp --send x 
<bdaddr>
> +TC_TG_NFR_BV_03_C	PASS	avtest --device hci0 --avctp --send x 
<bdaddr>
> +TC_TG_NFR_BI_01_C	PASS
> +TC_TG_FRA_BV_02_C	FAIL
>  TC_TG_FRA_BV_03_C	INC
>  ---------------------------------------------------------------------------
> ----

Patch 1/2 pushed, for 2/2 please mark version as 4.4.2 as discussed. Thanks.

-- 
BR
Szymon Janc
