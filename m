Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pics: Update HDP settings
Date: Thu, 03 Jul 2014 12:44:25 +0200
Message-ID: <1697396.AyCnejtYSf@uw000953>
In-Reply-To: <1404373801-5974-1-git-send-email-szymon.janc@tieto.com>
References: <1404373801-5974-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 03 of July 2014 09:50:01 Szymon Janc wrote:
> ---
>  android/pics-hdp.txt | 2 +-
>  android/pts-hdp.txt  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pics-hdp.txt b/android/pics-hdp.txt
> index f23aa74..d48e576 100644
> --- a/android/pics-hdp.txt
> +++ b/android/pics-hdp.txt
> @@ -167,7 +167,7 @@ Parameter Name	Selected	Description
>  TSPC_HDP_7_1	False		Supports Initiation of Echo Test (O)
>  TSPC_HDP_7_2	True		Supports Acceptance of Echo Test (M)
>  TSPC_HDP_7_3	True		Supports IEEE 11073-20601 (M)
> -TSPC_HDP_7_4	True		Supports IEEE 11073-20601 Agent Role (C.1)
> +TSPC_HDP_7_4	False (*)	Supports IEEE 11073-20601 Agent Role (C.1)
>  TSPC_HDP_7_5	True (*)	Supports IEEE 11073-20601 Manager Role (C.1)
>  TSPC_HDP_7_6	False		Supports Initiation of Association Release (O)
>  -------------------------------------------------------------------------------
> diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
> index f254bd0..4337e0e 100644
> --- a/android/pts-hdp.txt
> +++ b/android/pts-hdp.txt
> @@ -146,7 +146,7 @@ TC_SRC_DE_BV_02_I	PASS	haltest:
>  				bluez-hdp health-device-profile 1
>  				BTHL_MDEP_ROLE_SOURCE 4100
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
> -TC_SRC_DEP_BV_01_I	INC	PTS issue #12340
> +TC_SRC_DEP_BV_01_I	N/A
>  TC_SRC_DEP_BV_02_I	N/A
>  TC_SNK_CON_BV_01_I	PASS	haltest:
>  				hl register_application <args>
> 

Applied with some extra comment in commit message.

-- 
Best regards, 
Szymon Janc
