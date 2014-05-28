Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] android/pts: Update SM PTS test results
Date: Wed, 28 May 2014 11:38:56 +0200
Message-ID: <2116919.mRQTGRJTZX@uw000953>
In-Reply-To: <1401269406-18446-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401269406-18446-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 28 of May 2014 11:30:06 Lukasz Rymanowski wrote:
> Rerun TC_JW_* test cases
> ---
> To execute TC_JW_BI_03_C we can use only btmgmt. This patch updates instructions.
> Still I think that previous patch might be useful.
> 
>  android/pts-sm.txt | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/android/pts-sm.txt b/android/pts-sm.txt
> index 0792de8..1714d07 100644
> --- a/android/pts-sm.txt
> +++ b/android/pts-sm.txt
> @@ -18,11 +18,17 @@ TC_PROT_BV_01_C		PASS
>  TC_PROT_BV_02_C		FAIL	JIRA: BZ-24
>  				btmgmt advertising on
>  TC_JW_BV_01_C		FAIL	JIRA: BZ-25
> -TC_JW_BV_02_C		INC	JIRA: BZ-26
> +TC_JW_BV_02_C		PASS
>  TC_JW_BV_05_C		INC
>  TC_JW_BI_01_C		PASS
> -TC_JW_BI_02_C		INC
> -TC_JW_BI_03_C		INC
> +TC_JW_BI_02_C		PASS
> +TC_JW_BI_03_C		PASS	btmgmt:
> +				btmgmt power on
> +				btmgmt le on
> +				btmgmt connectable on
> +				btmgmt pairable on
> +				btmgmt discov on
> +				btmgmt advertising on
>  TC_JW_BI_04_C		FAIL
>  TC_PKE_BV_01_C		FAIL
>  TC_PKE_BV_02_C		INC

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
