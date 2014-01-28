Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS test results for GAP
Date: Tue, 28 Jan 2014 16:57:39 +0100
Message-ID: <3791656.buYABHTKP0@leonov>
In-Reply-To: <1390913805-7207-1-git-send-email-sebastianx.chlad@intel.com>
References: <1390913805-7207-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 28 of January 2014 14:56:45 Sebastian Chlad wrote:
> ---
>  android/pts-gap.txt | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/android/pts-gap.txt b/android/pts-gap.txt
> index 0ea5539..1c0feec 100644
> --- a/android/pts-gap.txt
> +++ b/android/pts-gap.txt
> @@ -1,7 +1,7 @@
>  PTS test results for GAP
> 
> -PTS version: 4.9
> -Tested: 14.11.2013
> +PTS version: 5.0
> +Tested: 28.01.2014
> 
>  Results:
>  PASS	test passed
> @@ -12,14 +12,14 @@ N/A	test is disabled due to PICS setup
>  ---------------------------------------------------------------------------
> ---- Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- -TC_MOD_NDIS_BV_01_C	PASS
> +TC_MOD_NDIS_BV_01_C	PASS	IUT must be in non-discoverable mode
>  TC_MOD_LDIS_BV_01_C	N/A
>  TC_MOD_LDIS_BV_02_C	N/A
>  TC_MOD_LDIS_BV_03_C	N/A
> -TC_MOD_GDIS_BV_01_C	PASS
> -TC_MOD_GDIS_BV_02_C	PASS
> -TC_MOD_NCON_BV_01_C	PASS
> -TC_MOD_CON_BV_01_C	PASS
> +TC_MOD_GDIS_BV_01_C	PASS	IUT must be discoverable
> +TC_MOD_GDIS_BV_02_C	PASS	IUT must be discoverable
> +TC_MOD_NCON_BV_01_C	PASS	btmgmt connectable off
> +TC_MOD_CON_BV_01_C	PASS	btmgmt connectable on
>  TC_BROB_BCST_BV_01_C	N/A
>  TC_BROB_BCST_BV_02_C	N/A
>  TC_BROB_BCST_BV_03_C	N/A
> @@ -48,7 +48,7 @@ TC_DISC_GENP_BV_02_C	INC	LE not supported yet
>  TC_DISC_GENP_BV_03_C	INC	LE not supported yet
>  TC_DISC_GENP_BV_04_C	INC	LE not supported yet
>  TC_DISC_GENP_BV_05_C	INC	LE not supported yet
> -TC_IDLE_GIN_BV_01_C	PASS
> +TC_IDLE_GIN_BV_01_C	PASS	Start inquiry from IUT
>  TC_IDLE_LIN_BV_01_C	N/A
>  TC_IDLE_NAMP_BV_01_C	INC	LE not supported yet
>  TC_IDLE_NAMP_BV_02_C	INC	LE not supported yet
> @@ -144,7 +144,7 @@ TC_DM_NBON_BV_01_C	N/A
>  TC_DM_BON_BV_01_C	INC	LE not supported yet
>  TC_DM_GIN_BV_01_C	INC	LE not supported yet
>  TC_DM_LIN_BV_01_C	N/A
> -TC_DM_NAD_BV_01_C	PASS
> +TC_DM_NAD_BV_01_C	PASS	Start inquiry from IUT
>  TC_DM_NAD_BV_02_C	INC	LE not supported yet
>  TC_DM_LEP_BV_01_C	N/A
>  TC_DM_LEP_BV_02_C	N/A

Applied, thanks.

-- 
BR
Szymon Janc
