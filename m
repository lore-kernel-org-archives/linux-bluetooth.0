Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pics: Update HDP settings
Date: Mon, 30 Jun 2014 15:27:12 +0200
Message-ID: <2121205.1Mp73n2oVr@uw000953>
In-Reply-To: <1403892221-7605-1-git-send-email-szymon.janc@tieto.com>
References: <1403892221-7605-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 27 of June 2014 20:03:41 Szymon Janc wrote:
> ---
>  android/pics-hdp.txt | 28 ++++++++++++++--------------
>  android/pts-hdp.txt  |  4 ++--
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/android/pics-hdp.txt b/android/pics-hdp.txt
> index 95d9917..f23aa74 100644
> --- a/android/pics-hdp.txt
> +++ b/android/pics-hdp.txt
> @@ -71,13 +71,13 @@ TSPC_HDP_3_1	True		Supports Reliable Control Channel (C.1)
>  TSPC_HDP_3_2	True		Uses FCS for Control Channel (M)
>  TSPC_HDP_3_3	True		Supports Reliable Data Channel (C.1)
>  TSPC_HDP_3_4	True		Can send data using SAR in ERTM (C.2)
> -TSPC_HDP_3_5	False		Uses FCS for Reliable Data Channel (O)
> -TSPC_HDP_3_6	False		Supports FCS option of "No FCS" for Reliable
> +TSPC_HDP_3_5	True (*)	Uses FCS for Reliable Data Channel (O)
> +TSPC_HDP_3_6	True (*)	Supports FCS option of "No FCS" for Reliable
>  				Data Channel (C.3)
>  TSPC_HDP_3_7	True		Supports Streaming Data Channel (C.4)
> -TSPC_HDP_3_8	False		Can send data using SAR in SM (C.5)
> -TSPC_HDP_3_9	False		Uses FCS for Steaming Data Channel (C.6)
> -TSPC_HDP_3_10	False		Supports FCS option of "No FCS" for Streaming
> +TSPC_HDP_3_8	True (*)	Can send data using SAR in SM (C.5)
> +TSPC_HDP_3_9	True (*)	Uses FCS for Steaming Data Channel (C.6)
> +TSPC_HDP_3_10	True (*)	Supports FCS option of "No FCS" for Streaming
>  				(C.7)
>  TSPC_HDP_3_11	True		Maximum number of simultaneous Data Channels
>  				supported (DCmax) per MCL (C.8)
> @@ -104,14 +104,14 @@ TSPC_HDP_4_1	True		Supports advertisement of HDP Service Record
>  TSPC_HDP_4_2	True		Service Class ID List (C.2)
>  TSPC_HDP_4_3	True		Protocol Descriptor List (C.2)
>  TSPC_HDP_4_4	True		Bluetooth Profile Descriptor List (C.2)
> -TSPC_HDP_4_5	False		Additional Protocol Descriptor Lists (C.2)
> +TSPC_HDP_4_5	True (*)	Additional Protocol Descriptor Lists (C.2)
>  TSPC_HDP_4_6	True (*)	Service Name (O)
>  TSPC_HDP_4_7	True (*)	Service Description (O)
>  TSPC_HDP_4_8	True (*)	Provider Name (O)
>  TSPC_HDP_4_9	True		HDP Supported Features (MDEP List) (C.3)
>  TSPC_HDP_4_10	True		MCAP Data Exchange Specification (C.3)
>  TSPC_HDP_4_11	True		MCAP Supported Procedures (C.3)
> -TSPC_HDP_4_12	False		Service Record State (O)
> +TSPC_HDP_4_12	True (*)	Service Record State (O)
>  -------------------------------------------------------------------------------
>  C.1: Mandatory if TSPC_HDP_6_3 is supported, otherwise Excluded.
>  C.2: Mandatory if TSPC_HDP_4_1 is supported, otherwise Optional.
> @@ -216,13 +216,13 @@ TSPC_HDP_9_1	True		Supports Reliable Control Channel (C.1)
>  TSPC_HDP_9_2	True		Uses FCS for Control Channel (M)
>  TSPC_HDP_9_3	True		Supports Reliable Data Channel (C.1)
>  TSPC_HDP_9_4	True		Can send data using SAR in ERTM (C.2)
> -TSPC_HDP_9_5	False		Uses FCS for Reliable Data Channel (O)
> -TSPC_HDP_9_6	False		Supports FCS option of "No FCS" for Reliable
> +TSPC_HDP_9_5	True (*)	Uses FCS for Reliable Data Channel (O)
> +TSPC_HDP_9_6	True (*)	Supports FCS option of "No FCS" for Reliable
>  				Data Channel (C.3)
>  TSPC_HDP_9_7	True		Supports Streaming Data Channel (C.4)
>  TSPC_HDP_9_8	True		Can send data using SAR in SM (C.5)
> -TSPC_HDP_9_9	False		Uses FCS for Steaming Data Channel (O)
> -TSPC_HDP_9_10	False		Supports FCS option of "No FCS" for Streaming
> +TSPC_HDP_9_9	True (*)	Uses FCS for Steaming Data Channel (O)
> +TSPC_HDP_9_10	True (*)	Supports FCS option of "No FCS" for Streaming
>  				Data Channel (C.3)
>  TSPC_HDP_9_11	True		Maximum number of simultaneous Data Channels
>  				supported (DCmax) per MCL (M)
> @@ -245,12 +245,12 @@ TSPC_HDP_10_3	True		Protocol Descriptor List (M)
>  TSPC_HDP_10_4	True		Bluetooth Profile Descriptor List (M)
>  TSPC_HDP_10_5	True		Additional Protocol Descriptor Lists (M)
>  TSPC_HDP_10_6	True (*)	Service Name (O)
> -TSPC_HDP_10_7	False		Service Description (O)
> -TSPC_HDP_10_8	False		Provider Name (O)
> +TSPC_HDP_10_7	True (*)	Service Description (O)
> +TSPC_HDP_10_8	True (*)	Provider Name (O)
>  TSPC_HDP_10_9	True		HDP Supported Features (MDEP List) (M)
>  TSPC_HDP_10_10	True		MCAP Data Exchange Specification (M)
>  TSPC_HDP_10_11	True		MCAP Supported Procedures (M)
> -TSPC_HDP_10_12	False		Service Record State (O)
> +TSPC_HDP_10_12	True (*)	Service Record State (O)
>  -------------------------------------------------------------------------------
>  C.1: Mandatory to support 10/1 and SDP Server Role (SDP 1b/1).
>  -------------------------------------------------------------------------------
> diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
> index 99aa2d6..a64c484 100644
> --- a/android/pts-hdp.txt
> +++ b/android/pts-hdp.txt
> @@ -196,6 +196,6 @@ TC_SNK_HCT_BV_06_C	INC
>  TC_SNK_HCT_BV_07_C	INC
>  TC_SNK_DE_BV_01_I	N/A
>  TC_SNK_DE_BV_02_I	INC
> -TC_SNK_DEP_BV_03_I	INC
> -TC_SNK_DEP_BV_04_I	INC
> +TC_SNK_DEP_BV_03_I	N/A
> +TC_SNK_DEP_BV_04_I	N/A
>  -------------------------------------------------------------------------------
> 

Applied.

-- 
Best regards, 
Szymon Janc
