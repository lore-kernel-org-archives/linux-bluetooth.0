Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS testing results for SM
Date: Fri, 01 Aug 2014 15:16:21 +0200
Message-ID: <2463046.EyZhsJYJTz@uw000953>
In-Reply-To: <1406885392-23611-1-git-send-email-sebastian.chlad@tieto.com>
References: <1406885392-23611-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 01 of August 2014 11:29:52 Sebastian Chlad wrote:
> ---
>  android/pts-sm.txt | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/android/pts-sm.txt b/android/pts-sm.txt
> index af892ef..8f1034b 100644
> --- a/android/pts-sm.txt
> +++ b/android/pts-sm.txt
> @@ -2,7 +2,7 @@ PTS test results for SM
>  
>  PTS version: 5.2
>  Tested: 25-July-2014
> -Android version: 4.4.2
> +Android version: 4.4.4
>  kernel version: 3.17
>  
>  Results:
> @@ -15,7 +15,7 @@ NONE	test result is none
>  -------------------------------------------------------------------------------
>  Test Name		Result	Notes
>  -------------------------------------------------------------------------------
> -TC_PROT_BV_01_C		PASS
> +TC_PROT_BV_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
>  TC_PROT_BV_02_C		PASS	btmgmt advertising on
>  				btmgmt pair -c 0x03 -t 0x01 <addr>
>  TC_JW_BV_01_C		PASS	btmgmt pairable off
> @@ -67,6 +67,7 @@ TC_OOB_BI_02_C		NA
>  TC_EKS_BV_01_C		PASS
>  TC_EKS_BV_02_C		PASS
>  TC_EKS_BI_01_C		INC	btmgmt io-cap 0x03
> +				PTS issue #12449
>  TC_EKS_BI_02_C		PASS
>  TC_SIGN_BV_01_C		INC	PTS issue #12305
>  TC_SIGN_BV_03_C		PASS	haltest
> @@ -84,10 +85,7 @@ TC_KDU_BV_02_C		PASS	PTS issue #12302
>  				Set PIXIT TSPX_peer_type to 01
>  TC_KDU_BV_03_C		PASS	btmgmt pairable on
>  				btmgmt advertising on
> -
>  TC_KDU_BV_04_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
> -
> -
>  TC_KDU_BV_05_C		PASS	PTS issue #12302
>  				Note: Can pass it with following instructions:
>  				btmgmt privacy on
> @@ -96,9 +94,8 @@ TC_KDU_BV_05_C		PASS	PTS issue #12302
>  				Set PIXIT TSPX_peer_type to 01
>  TC_KDU_BV_06_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
>  TC_KDU_BV_07_C		PASS	btmgmt pairable on
> -
> -
>  TC_SIP_BV_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
> -TC_SIP_BV_02_C		PASS	l2test -n -J4 -V le_public <addr>
> +TC_SIP_BV_02_C		INC	l2test -n -J4 -V le_public <addr>
> +				PTS issue #12460
>  TC_SIE_BV_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
>  -------------------------------------------------------------------------------

Patch applied. Thanks. 

-- 
Best regards, 
Szymon Janc
