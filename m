Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Correct PICS for A2DP
Date: Wed, 30 Apr 2014 11:24:02 +0200
Message-ID: <3302532.DveFreDbJv@uw000953>
In-Reply-To: <1398771240-6738-1-git-send-email-sebastian.chlad@tieto.com>
References: <1398771240-6738-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 29 of April 2014 13:34:00 Sebastian Chlad wrote:
> ---
>  android/pics-a2dp.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pics-a2dp.txt b/android/pics-a2dp.txt
> index 5162e62..81debcd 100644
> --- a/android/pics-a2dp.txt
> +++ b/android/pics-a2dp.txt
> @@ -38,7 +38,7 @@ TSPC_A2DP_2_11	False		SRC: SBC Configurations in 16 KHz sampling (O)
>  TSPC_A2DP_2_12	False		SRC: SBC Configurations in 32 KHz sampling (O)
>  TSPC_A2DP_2_13	True		SRC: SBC Configurations in 44.1 KHz sampling
>  					(C.1)
> -TSPC_A2DP_2_14	False		SRC: SBC Configurations in 48 KHz sampling
> +TSPC_A2DP_2_14	False (*)	SRC: SBC Configurations in 48 KHz sampling
>  					(C.1)
>  -------------------------------------------------------------------------------
>  C.1: At least one of the values shall be supported.
> @@ -80,7 +80,7 @@ TSPC_A2DP_4_14	False (*)	SNK: SBC Configurations in 48 KHz sampling (M)
>  -------------------------------------------------------------------------------
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_A2DP_5_1	False		SNK: SBC decoder Codec (M)
> +TSPC_A2DP_5_1	False (*)	SNK: SBC decoder Codec (M)
>  TSPC_A2DP_5_2	False		SNK: Additional decoder Coded (O)
>  TSPC_ALL	False		Enable all test cases when set to False.
>  -------------------------------------------------------------------------------
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
