Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PIXIT, PICS for A2DP PTS6.0
Date: Mon, 09 Mar 2015 16:28:34 +0100
Message-ID: <1815392.FyGPP1g5Uv@uw000953>
In-Reply-To: <1425907785-6931-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1425907785-6931-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 09 of March 2015 14:29:45 Grzegorz Kolodziejczyk wrote:
> Some of pixits, pics were wrong defined.
> ---
>  android/pics-a2dp.txt  | 23 +++++++++++------------
>  android/pixit-a2dp.txt |  4 ++--
>  2 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/android/pics-a2dp.txt b/android/pics-a2dp.txt
> index f184cb8..1328e7e 100644
> --- a/android/pics-a2dp.txt
> +++ b/android/pics-a2dp.txt
> @@ -12,9 +12,9 @@ O - optional
>  -------------------------------------------------------------------------------
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_A2DP_0_1	False		A2DP 1.0
> -TSPC_A2DP_0_1	False		A2DP 1.2
> -TSPC_A2DP_0_1	True (*)	A2DP 1.3
> +TSPC_A2DP_0_1	False		A2DP 1.0 (C.1)
> +TSPC_A2DP_0_2	False		A2DP 1.2 (C.1)
> +TSPC_A2DP_0_3	True (*)	A2DP 1.3 (C.1)
>  -------------------------------------------------------------------------------
>  C.1: It is mandatory to select one of the profile versions.
>  -------------------------------------------------------------------------------
> @@ -24,8 +24,8 @@ C.1: It is mandatory to select one of the profile versions.
>  -------------------------------------------------------------------------------
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_A2DP_1_1	True		Role: Source (C.1)
> -TSPC_A2DP_1_2	False (*)	Role: Sink (C.1)
> +TSPC_A2DP_1_1	True (*)	Role: Source (C.1)
> +TSPC_A2DP_1_2	False		Role: Sink (C.1)
>  -------------------------------------------------------------------------------
>  C.1: It is mandatory to support at least one of the defined roles.
>  -------------------------------------------------------------------------------
> @@ -45,16 +45,15 @@ TSPC_A2DP_2_7	True		SRC: Accept connection release (M)
>  TSPC_A2DP_2_8	True (*)	SRC: Initiate suspend (O)
>  TSPC_A2DP_2_9	True (*)	SRC: Accept suspend (O)
>  TSPC_A2DP_2_10	True		SRC: SBC encoder (M)
> -TSPC_A2DP_2_10a	False		SRC: Encode Audio Stream (O)
> +TSPC_A2DP_2_10a	False		SRC: Encode and Forward Audio Stream (O)
>  TSPC_A2DP_2_11	False		SRC: SBC Configurations in 16 KHz sampling (O)
>  TSPC_A2DP_2_12	False		SRC: SBC Configurations in 32 KHz sampling (O)
> -TSPC_A2DP_2_13	True		SRC: SBC Configurations in 44.1 KHz sampling
> -					(C.1)
> -TSPC_A2DP_2_14	True		SRC: SBC Configurations in 48 KHz sampling
> +TSPC_A2DP_2_13	True (*)	SRC: SBC Configurations in 44.1 KHz sampling
>  					(C.1)
> +TSPC_A2DP_2_14	True (*)	SRC: SBC Configurations in 48 KHz sampling (C.1)
>  TSPC_A2DP_2_15	False		SRC: Delay Reporting (C.2)
> -TSPC_A2DP_2_16	False		SRC video playback via Bluetooth VDP (C.3)
> -TSPC_A2DP_2_17	False		SRC video playback on a local video
> +TSPC_A2DP_2_16	False		SRC: SRC video playback via Bluetooth VDP (C.3)
> +TSPC_A2DP_2_17	False		SRC: SRC video playback on a local video
>  					display (C.3)
>  -------------------------------------------------------------------------------
>  C.1: At least one of the values shall be supported.
> @@ -117,7 +116,7 @@ TSPC_A2DP_4_7	False (*)	SNK: Accept connection release (M)
>  TSPC_A2DP_4_8	False		SNK: Initiate suspend (O)
>  TSPC_A2DP_4_9	False		SNK: Accept suspend (O)
>  TSPC_A2DP_4_10	False (*)	SNK: SBC decoder (M)
> -TSPC_A2DP_4_10a	False (*)	SNK: Decode Audio Stream (O)
> +TSPC_A2DP_4_10a	False		SNK: Decode and Forward Audio Stream (O)
>  TSPC_A2DP_4_11	False		SNK: SBC Configurations in 16 KHz sampling (O)
>  TSPC_A2DP_4_12	False		SNK: SBC Configurations in 32 KHz sampling (O)
>  TSPC_A2DP_4_13	False (*)	SNK: SBC Configurations in 44.1 KHz sampling (M)
> diff --git a/android/pixit-a2dp.txt b/android/pixit-a2dp.txt
> index 62a9b43..b6ef742 100644
> --- a/android/pixit-a2dp.txt
> +++ b/android/pixit-a2dp.txt
> @@ -10,7 +10,7 @@ Required PIXIT settings
>  -------------------------------------------------------------------------------
>  Parameter Name			Value
>  -------------------------------------------------------------------------------
> -TSPX_security_enabled		TRUE
> +TSPX_security_enabled		TRUE (*)
>  TSPX_bd_addr_iut		112233445566 (*&)
>  TSPX_SRC_class_of_device	080418
>  TSPX_SNK_class_of_device	04041C
> @@ -20,7 +20,7 @@ TSPX_time_guard			300000
>  TSPX_use_implicit_send		TRUE
>  TSPX_media_directory		C:\Program Files\Bluetooth SIG\Bluetooth PTS\
>  					bin\audio (#)
> -TSPX_no_avrcp			FALSE
> +TSPX_no_avrcp			FALSE (*)
>  TSPX_auth_password		0000
>  TSPX_auth_user_id		PTS
>  TSPX_rfcomm_channel		8
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
