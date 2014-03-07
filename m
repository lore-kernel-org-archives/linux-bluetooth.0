Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] android/pics: Change AVRCP to 1.5
Date: Fri, 07 Mar 2014 10:51:12 +0100
Message-ID: <1802559.g2LozSmNuR@uw000953>
In-Reply-To: <1394096561-18911-1-git-send-email-sebastian.chlad@tieto.com>
References: <1394096561-18911-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Thursday 06 of March 2014 10:02:41 Sebastian Chlad wrote:
> Simple PICS switch from AVRCP 1.3 to 1.5
> ---
>  android/pics-avrcp.txt | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
> index 2be0746..845ba33 100644
> --- a/android/pics-avrcp.txt
> +++ b/android/pics-avrcp.txt
> @@ -336,7 +336,7 @@ TSPC_AVRCP_7_5    True		TG: Receiving UNIT INFO (M)
>  TSPC_AVRCP_7_6    True		TG: Receiving SUBUNIT INFO (M)
>  TSPC_AVRCP_7_7    True		TG: Receiving PASS THROUGH command category 1
>  					(C.1)
> -TSPC_AVRCP_7_8    False		TG: Receiving PASS THROUGH command category 2
> +TSPC_AVRCP_7_8    True (*)	TG: Receiving PASS THROUGH command category 2
>  					(C.1)
>  TSPC_AVRCP_7_9    False		TG: Receiving PASS THROUGH command category 3
>  					(C.1)
> @@ -405,9 +405,9 @@ TSPC_AVRCP_7_56   False		TG: PlayItem(NowPlayingList) (C.11)
>  TSPC_AVRCP_7_57   False		TG: AddToNowPlaying (O)
>  TSPC_AVRCP_7_58   False		TG: EVENT_NOW_PLAYING_CONTENT_CHANGED (C.11)
>  TSPC_AVRCP_7_59   False		TG: Playable Folders (O)
> -TSPC_AVRCP_7_60   False		TG: Absolute Volume (C.5)
> -TSPC_AVRCP_7_61   False		TG: SetAbsoluteVolume (C.5)
> -TSPC_AVRCP_7_62   False		TG: NotifyVolumeChange (C.5)
> +TSPC_AVRCP_7_60   True (*)	TG: Absolute Volume (C.5)
> +TSPC_AVRCP_7_61   True (*)	TG: SetAbsoluteVolume (C.5)
> +TSPC_AVRCP_7_62   True (*)	TG: NotifyVolumeChange (C.5)
>  TSPC_AVRCP_7_63   False		TG: Error Response (O)
>  TSPC_AVRCP_7_64   False		TG: General Reject (C.13)
>  TSPC_AVRCP_7_65   True		TG: Discoverable Mode (M)
> @@ -448,9 +448,9 @@ C.15: Mandatory if Basic Group Navigation Feature supported. If any item
>  Parameter Name    Selected	Description
>  -------------------------------------------------------------------------------
>  TSPC_AVRCP_7b_1   False		TG: AVRCP v1.0 (C.1)
> -TSPC_AVRCP_7b_2   True (*)	TG: AVRCP v1.3 (C.1)
> +TSPC_AVRCP_7b_2   False		TG: AVRCP v1.3 (C.1)
>  TSPC_AVRCP_7b_3   False		TG: AVRCP v1.4 (C.1)
> -TSPC_AVRCP_7b_4   False		TG: AVRCP v1.5 (C.1)
> +TSPC_AVRCP_7b_4   True (*)	TG: AVRCP v1.5 (C.1)
>  TSPC_AVRCP_7b_5   False		TG: AVRCP v1.6 (C.1)
>  -------------------------------------------------------------------------------
>  C.1: It is mandatory to support at least one of the profile versions.
> @@ -523,8 +523,8 @@ TSPC_AVRCP_9_16   False		TG: category 2 - Operation id: display
>  					information (O)
>  TSPC_AVRCP_9_17	  False		TG: category 2 - Operation id: help (O)
>  TSPC_AVRCP_9_18	  False		TG: category 2 - Operation id: power (O)
> -TSPC_AVRCP_9_19   False (*)	TG: category 2 - Operation id: volume up (C.2)
> -TSPC_AVRCP_9_20   False (*)	TG: category 2 - Operation id: volume down (C.2)
> +TSPC_AVRCP_9_19   True		TG: category 2 - Operation id: volume up (C.2)
> +TSPC_AVRCP_9_20   True		TG: category 2 - Operation id: volume down (C.2)
>  TSPC_AVRCP_9_21   False		TG: category 2 - Operation id: mute (O)
>  TSPC_AVRCP_9_24   False		TG: category 2 - Operation id: F1 (O)
>  TSPC_AVRCP_9_25   False		TG: category 2 - Operation id: F2 (O)
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
