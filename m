Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/pts: Update PTS files for A2DP
Date: Mon, 19 Jan 2015 21:04:21 +0100
Message-ID: <2833426.o5KBs8VqnT@athlon>
In-Reply-To: <1421315546-1117-1-git-send-email-sebastian.chlad@tieto.com>
References: <1421315546-1117-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Thursday 15 January 2015 10:52:26 Sebastian Chlad wrote:
> Updated PICS, PIXITs and PTS tests results for A2DP.
> PTS version 6.0. Android version 5.0
> ---
>  android/pics-a2dp.txt  | 91
> ++++++++++++++++++++++++++++++++++++++++++++++---- android/pixit-a2dp.txt |
>  6 ++--
>  android/pts-a2dp.txt   |  9 +++--
>  3 files changed, 93 insertions(+), 13 deletions(-)
> 
> diff --git a/android/pics-a2dp.txt b/android/pics-a2dp.txt
> index adac664..f184cb8 100644
> --- a/android/pics-a2dp.txt
> +++ b/android/pics-a2dp.txt
> @@ -1,6 +1,6 @@
>  A2DP PICS for the PTS tool.
> 
> -PTS version: 5.3
> +PTS version: 6.0
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> @@ -8,6 +8,18 @@ PTS version: 5.3
>  M - mandatory if such role selected
>  O - optional
> 
> +		Profile Version
> +---------------------------------------------------------------------------
> ---- +Parameter Name	Selected	Description
> +---------------------------------------------------------------------------
> ---- +TSPC_A2DP_0_1	False		A2DP 1.0
> +TSPC_A2DP_0_1	False		A2DP 1.2
> +TSPC_A2DP_0_1	True (*)	A2DP 1.3
> +---------------------------------------------------------------------------
> ---- +C.1: It is mandatory to select one of the profile versions.
> +---------------------------------------------------------------------------
> ---- +
> +
>  		Roles
>  ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
> @@ -38,10 +50,16 @@ TSPC_A2DP_2_11	False		SRC: SBC Configurations in 
16 KHz
> sampling (O) TSPC_A2DP_2_12	False		SRC: SBC Configurations in 32 KHz
> sampling (O) TSPC_A2DP_2_13	True		SRC: SBC Configurations in 44.1 
KHz
> sampling (C.1)
> -TSPC_A2DP_2_14	False (*)	SRC: SBC Configurations in 48 KHz sampling
> +TSPC_A2DP_2_14	True		SRC: SBC Configurations in 48 KHz sampling
>  					(C.1)
> +TSPC_A2DP_2_15	False		SRC: Delay Reporting (C.2)
> +TSPC_A2DP_2_16	False		SRC video playback via Bluetooth VDP (C.3)
> +TSPC_A2DP_2_17	False		SRC video playback on a local video
> +					display (C.3)
>  ---------------------------------------------------------------------------
> ---- C.1: At least one of the values shall be supported.
> +C.2: Mandatory if A2DP 0/3 AND (2/16 OR 2/17) is supported, otherwise
> excluded. +C.3: Optional to support if A2DP 0/3 is supported, otherwise
> excluded.
> ---------------------------------------------------------------------------
> ----
> 
> 
> @@ -49,8 +67,39 @@ C.1: At least one of the values shall be supported.
>  ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- -TSPC_A2DP_3_1	True		SRC: SBC encoder Codec (M)
> -TSPC_A2DP_3_2	True (*)	SRC: Additional encoder Codec (O)
> +TSPC_A2DP_3_1	True		SRC: SBC encoder (M)
> +TSPC_A2DP_3_1a	False		SRC: Encode and Forward SBC Audio Stream (O)
> +TSPC_A2DP_3_2	False		SRC: Optional codec (O)
> +TSPC_A2DP_3_3	False		SRC: MPEG-1,2 Audio decoder (C.1)
> +TSPC_A2DP_3_4	False		SRC: MPEG-1,2 Audio encoder (C.1)
> +TSPC_A2DP_3_5	False		SRC: MPEG-2,4 AAC decoder (C.1)
> +TSPC_A2DP_3_6	False		SRC: MPEG-2,4 AAC encoder (C.1)
> +TSPC_A2DP_3_7	False		SRC: ATRAC family decoder (C.1)
> +TSPC_A2DP_3_8	False		SRC: ATRAC family encoder (C.1)
> +---------------------------------------------------------------------------
> ---- +C.1: At least one of the implementations shall be supported if 12/2
> (Optional +	codec) is supported, else excluded.
> +---------------------------------------------------------------------------
> ---- +
> +
> +		Supported Codec Features in SRC
> +---------------------------------------------------------------------------
> ---- +Parameter Name	Selected	Description
> +---------------------------------------------------------------------------
> ---- +TSPC_A2DP_3a_1	True 		SRC: Channel Mode - Mono (M)
> +TSPC_A2DP_3a_2	True (*)	SRC: Channel Mode - Dual Channel (C.1)
> +TSPC_A2DP_3a_3	True (*)	SRC: Channel Mode - Stereo (C.1)
> +TSPC_A2DP_3a_4	True (*)	SRC: Channel Mode - Joint Stereo (C.1)
> +TSPC_A2DP_3a_5	True		SRC: Block Length 4 (M)
> +TSPC_A2DP_3a_6	True		SRC: Block Length 8 (M)
> +TSPC_A2DP_3a_7	True		SRC: Block Length 12 (M)
> +TSPC_A2DP_3a_8	True		SRC: Block Length 16 (M)
> +TSPC_A2DP_3a_9	True (*)	SRC: Subbands - 4 (O)
> +TSPC_A2DP_3a_10	True		SRC: Subbands - 8 (M)
> +TSPC_A2DP_3a_11	True (*)	SRC: Allocation - SNR (O)
> +TSPC_A2DP_3a_12	True		SRC: Allocation - Loudness (M)
> +---------------------------------------------------------------------------
> ---- +C.1: At least one of the values shall be supported.
>  ---------------------------------------------------------------------------
> ----
> 
> 
> @@ -73,6 +122,9 @@ TSPC_A2DP_4_11	False		SNK: SBC Configurations in 16 
KHz
> sampling (O) TSPC_A2DP_4_12	False		SNK: SBC Configurations in 32 KHz
> sampling (O) TSPC_A2DP_4_13	False (*)	SNK: SBC Configurations in 44.1 
KHz
> sampling (M) TSPC_A2DP_4_14	False (*)	SNK: SBC Configurations in 48 KHz
> sampling (M) +TSPC_A2DP_4_15	False		SNK: Delay Reporting (C.1)
> +---------------------------------------------------------------------------
> ---- +C.1: Mandatory to support if A2DP 0/3 is supported, otherwise
> excluded.
> ---------------------------------------------------------------------------
> ----
> 
> 
> @@ -80,7 +132,32 @@ TSPC_A2DP_4_14	False (*)	SNK: SBC Configurations in 
48
> KHz sampling (M)
> ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- -TSPC_A2DP_5_1	False (*)	SNK: SBC decoder Codec (M)
> -TSPC_A2DP_5_2	False		SNK: Additional decoder Coded (O)
> -TSPC_ALL	False		Enable all test cases when set to False.
> +TSPC_A2DP_5_1	False (*)	SNK: SBC decoder (M)
> +TSPC_A2DP_5_1a	False		SNK: Decode and Forward SBC Audio Stream (O)
> +TSPC_A2DP_5_2	False		SNK: Optional codec decoder (O)
> +TSPC_A2DP_5_3	False		SNK: MPEG-1,2 Audio (C.1)
> +TSPC_A2DP_5_4	False		SNK: MPEG-2,4 AAC (C.1)
> +TSPC_A2DP_5_5	False		SNK: ATRAC family (C.1)
> +---------------------------------------------------------------------------
> ---- +C.1: At least one codec shall be supported if Table 13/2 (Optional
> codec +	decoder) is supported, otherwise excluded.
> +---------------------------------------------------------------------------
> ---- +
> +
> +		Supported Codec Features in SNK
> +---------------------------------------------------------------------------
> ---- +Parameter Name	Selected	Description
> +---------------------------------------------------------------------------
> ---- +TSPC_A2DP_5a_1	False (*)	SNK: Channel Mode - Mono (M)
> +TSPC_A2DP_5a_2	False (*)	SNK: Channel Mode - Dual Channel (M)
> +TSPC_A2DP_5a_3	False (*)	SNK: Channel Mode - Stereo (M)
> +TSPC_A2DP_5a_4	False (*)	SNK: Channel Mode - Joint Stereo (M)
> +TSPC_A2DP_5a_5	False (*)	SNK: Block Length 4 (M)
> +TSPC_A2DP_5a_6	False (*)	SNK: Block Length 8 (M)
> +TSPC_A2DP_5a_7	False (*)	SNK: Block Length 12 (M)
> +TSPC_A2DP_5a_8	False (*)	SNK: Block Length 16 (M)
> +TSPC_A2DP_5a_9	False (*)	SNK: Subbands - 4 (M)
> +TSPC_A2DP_5a_10	False (*)	SNK: Subbands - 8 (M)
> +TSPC_A2DP_5a_11	False (*)	SNK: Allocation - SNR (M)
> +TSPC_A2DP_5a_12	False (*)	SNK: Allocation - Loudness (M)
>  ---------------------------------------------------------------------------
> ---- diff --git a/android/pixit-a2dp.txt b/android/pixit-a2dp.txt
> index 3e26eac..62a9b43 100644
> --- a/android/pixit-a2dp.txt
> +++ b/android/pixit-a2dp.txt
> @@ -1,6 +1,6 @@
>  A2DP PIXIT for the PTS tool.
> 
> -PTS version: 5.3
> +PTS version: 6.0
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> @@ -10,7 +10,7 @@ Required PIXIT settings
>  ---------------------------------------------------------------------------
> ---- Parameter Name			Value
>  ---------------------------------------------------------------------------
> ---- -TSPX_security_enabled		FALSE
> +TSPX_security_enabled		TRUE
>  TSPX_bd_addr_iut		112233445566 (*&)
>  TSPX_SRC_class_of_device	080418
>  TSPX_SNK_class_of_device	04041C
> @@ -20,7 +20,7 @@ TSPX_time_guard			300000
>  TSPX_use_implicit_send		TRUE
>  TSPX_media_directory		C:\Program Files\Bluetooth SIG\Bluetooth PTS\
>  					bin\audio (#)
> -TSPX_no_avrcp			TRUE
> +TSPX_no_avrcp			FALSE
>  TSPX_auth_password		0000
>  TSPX_auth_user_id		PTS
>  TSPX_rfcomm_channel		8
> diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
> index 92c3e15..500c631 100644
> --- a/android/pts-a2dp.txt
> +++ b/android/pts-a2dp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for A2DP
> 
> -PTS version: 5.3
> -Tested: 19-November-2014
> +PTS version: 6.0
> +Tested: 14-January-2015
>  Android version: 5.0
> 
>  Results:
> @@ -15,7 +15,7 @@ N/A	test is disabled due to PICS setup
>  Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- TC_SRC_CC_BV_09_I	PASS	Start streaming
> -TC_SRC_CC_BV_10_I	N/A
> +TC_SRC_CC_BV_10_I	PASS
>  TC_SRC_REL_BV_01_I	PASS	Connect to PTS from IUT. When requested
>  				disconnect from IUT
>  TC_SRC_REL_BV_02_I	PASS
> @@ -24,12 +24,15 @@ TC_SRC_SET_BV_02_I	PASS
>  TC_SRC_SET_BV_03_I	PASS	Start streaming
>  TC_SRC_SET_BV_04_I	PASS	Start streaming
>  TC_SRC_SET_BV_05_I	PASS	IUT must be moved out of range
> +				JIRA issue BA-314
>  TC_SRC_SET_BV_06_I	PASS	IUT must be moved out of range
>  TC_SRC_SUS_BV_01_I	PASS	Stop streaming
>  TC_SRC_SUS_BV_02_I	PASS
>  TC_SRC_SDP_BV_01_I	PASS
>  TC_SRC_AS_BV_01_I	PASS	Requires checking if the output on the IUT is
>  				correct
> +TC_SRC_AS_BV_02_I	N/A
> +TC_SRC_AS_BV_03_I	N/A
>  ---------------------------------------------------------------------------
> ----

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
