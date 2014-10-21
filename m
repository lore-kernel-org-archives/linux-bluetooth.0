Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ruslan Mstoi <ruslan.mstoi@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Updated SM PICS and PIXITs for PTS 5.3
Date: Tue, 21 Oct 2014 11:11:32 +0200
Message-ID: <2651118.69zjaL10NW@uw000953>
In-Reply-To: <1413814868-20811-1-git-send-email-ruslan.mstoi@linux.intel.com>
References: <1413814868-20811-1-git-send-email-ruslan.mstoi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruslan,

On Monday 20 of October 2014 17:21:08 Ruslan Mstoi wrote:
> ---
>  android/pics-sm.txt  |  6 +++---
>  android/pixit-sm.txt |  2 +-
>  android/pts-sm.txt   | 12 +++++-------
>  3 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/android/pics-sm.txt b/android/pics-sm.txt
> index dcdfff8..c1bfe0e 100644
> --- a/android/pics-sm.txt
> +++ b/android/pics-sm.txt
> @@ -1,6 +1,6 @@
>  SM PICS for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  
> @@ -25,7 +25,7 @@ Parameter Name	Selected	Description
>  TSPC_SM_2_1	True		Authenticated MITM protection (O)
>  TSPC_SM_2_2	True		Unauthenticated no MITM protection (C.1)
>  TSPC_SM_2_3	True		No security requirements (M)
> -TSPC_SM_2_4	False		OOB supported (O)
> +TSPC_SM_2_4	False (*)	OOB supported (O)
>  -------------------------------------------------------------------------------
>  C.1: If TSPC_SM_2_1 is supported then Mandatory, else Optional
>  -------------------------------------------------------------------------------
> @@ -45,7 +45,7 @@ Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
>  TSPC_SM_4_1	True		Just Works (O)
>  TSPC_SM_4_2	True		Passkey Entry (C.1)
> -TSPC_SM_4_3	False		Out of Band (C.1)
> +TSPC_SM_4_3	False (*)	Out of Band (C.1)
>  -------------------------------------------------------------------------------
>  C.1: If TSPC_SM_2_1 is supported, at least one of these features shall be
>  	supported.
> diff --git a/android/pixit-sm.txt b/android/pixit-sm.txt
> index 2526e29..2d1442b 100644
> --- a/android/pixit-sm.txt
> +++ b/android/pixit-sm.txt
> @@ -1,6 +1,6 @@
>  SM PIXIT for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-sm.txt b/android/pts-sm.txt
> index a5c0aba..8a38d32 100644
> --- a/android/pts-sm.txt
> +++ b/android/pts-sm.txt
> @@ -1,7 +1,7 @@
>  PTS test results for SM
>  
> -PTS version: 5.2
> -Tested: 25-July-2014
> +PTS version: 5.3
> +Tested: 20-October-2014
>  Android version: 4.4.4
>  kernel version: 3.17
>  
> @@ -66,8 +66,7 @@ TC_OOB_BI_01_C		N/A
>  TC_OOB_BI_02_C		N/A
>  TC_EKS_BV_01_C		PASS
>  TC_EKS_BV_02_C		PASS
> -TC_EKS_BI_01_C		INC	PTS issue #12449
> -				btmgmt io-cap 0x03
> +TC_EKS_BI_01_C		PASS	btmgmt io-cap 0x03
>  TC_EKS_BI_02_C		PASS
>  TC_SIGN_BV_01_C		INC	PTS issue #12305
>  TC_SIGN_BV_03_C		PASS	haltest
> @@ -79,7 +78,7 @@ TC_KDU_BV_01_C		PASS	btmgmt pairable on
>  TC_KDU_BV_02_C		PASS	PTS issue #12302
>  				Note: Can pass it with following instructions:
>  				btmgmt privacy on
> -				btmgmt advetising on
> +				btmgmt advertising on
>  				Check our random address (valid for 15 min)
>  				Set PIXIT TSPX_bd_addr_iut to random address
>  				Set PIXIT TSPX_peer_type to 01
> @@ -95,7 +94,6 @@ TC_KDU_BV_05_C		PASS	PTS issue #12302
>  TC_KDU_BV_06_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
>  TC_KDU_BV_07_C		PASS	btmgmt pairable on
>  TC_SIP_BV_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
> -TC_SIP_BV_02_C		INC	PTS issue #12460
> -				l2test -n -J4 -V le_public <addr>
> +TC_SIP_BV_02_C		PASS	l2test -n -J4 -V le_public <addr>
>  TC_SIE_BV_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
>  -------------------------------------------------------------------------------
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
