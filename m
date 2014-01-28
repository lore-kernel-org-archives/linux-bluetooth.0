Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Add PTS test results for AVRCP
Date: Tue, 28 Jan 2014 16:57:10 +0100
Message-ID: <16964166.b2Bmkqx9Nj@leonov>
In-Reply-To: <1390911956-6714-1-git-send-email-sebastianx.chlad@intel.com>
References: <1390911956-6714-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 28 of January 2014 14:25:56 Sebastian Chlad wrote:
> ---
>  android/pts-avrcp.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
> index f2533b4..6ad97f7 100644
> --- a/android/pts-avrcp.txt
> +++ b/android/pts-avrcp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for AVRCP
> 
>  PTS version: 5.0
> -Tested: --not yet tested--
> +Tested: 28.01.2014
> 
>  Results:
>  PASS	test passed
> @@ -91,17 +91,17 @@ Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- TC_TG_BGN_BV_01_I	N/A
>  TC_TG_BGN_BV_02_I	N/A
> -TC_TG_CEC_BV_01_I	INC
> -TC_TG_CEC_BV_02_I	INC
> +TC_TG_CEC_BV_01_I	PASS
> +TC_TG_CEC_BV_02_I	INC	Initiate a control chanenel connection
>  TC_TG_CFG_BI_01_C	INC
>  TC_TG_CFG_BV_02_C	INC
>  TC_TG_CON_BV_02_C	N/A
>  TC_TG_CON_BV_04_C	N/A
>  TC_TG_CON_BV_05_C	N/A
> -TC_TG_CRC_BV_01_I	INC
> -TC_TG_CRC_BV_02_I	INC
> -TC_TG_ICC_BV_01_I	INC
> -TC_TG_ICC_BV_02_I	INC
> +TC_TG_CRC_BV_01_I	PASS
> +TC_TG_CRC_BV_02_I	PASS	Disconnect from PTS
> +TC_TG_ICC_BV_01_I	PASS
> +TC_TG_ICC_BV_02_I	PASS
>  TC_TG_INV_BI_01_C	INC
>  TC_TG_INV_BI_02_C	N/A
>  TC_TG_MCN_CB_BI_01_C	N/A

Applied, thanks.

-- 
BR
Szymon Janc
