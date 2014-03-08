Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pics: Correct PICS for AbsoluteVolume
Date: Sat, 08 Mar 2014 20:00:01 +0100
Message-ID: <2906912.mZlmsdf1KM@leonov>
In-Reply-To: <1394217767-12242-1-git-send-email-sebastian.chlad@tieto.com>
References: <1394217767-12242-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 07 of March 2014 19:42:46 Sebastian Chlad wrote:
> As Specification for AVRCP 1.4+ requires, in case of Absolute
> Volume, roles are reveresed and IUT plays CT while PTS plays TG
> role (PTS acts as sink. See section 6.13.2 AVRCP 1.5 Spec)
> ---
>  android/pics-avrcp.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
> index 845ba33..bee22c8 100644
> --- a/android/pics-avrcp.txt
> +++ b/android/pics-avrcp.txt
> @@ -12,7 +12,7 @@ O - optional
>  ---------------------------------------------------------------------------
> ---- Parameter Name    Selected	Description
>  ---------------------------------------------------------------------------
> ---- -SPC_AVRCP_1_1     False (*)	Role: Controller (CT) (C.1)
> +SPC_AVRCP_1_1     True		Role: Controller (CT) (C.1)
>  TSPC_AVRCP_1_2    True		Role: Target (TG) (C.1)
>  ---------------------------------------------------------------------------
> ---- C.1: Mandatory to support at least one of the defined roles.
> @@ -82,9 +82,9 @@ TSPC_AVRCP_2_45   False		CT: PlayItem(NowPlayingList)
> (C.8) TSPC_AVRCP_2_46   False		CT: AddToNowPlaying (O)
>  TSPC_AVRCP_2_47   False		CT: EVENT_NOW_PLAYING_CONTENT_CHANGED (O)
>  TSPC_AVRCP_2_48   False		CT: Playable Folders (O)
> -TSPC_AVRCP_2_49   False		CT: Absolute Volume (C.3)
> -TSPC_AVRCP_2_50   False		CT: SetAbsoluteVolume (C.3)
> -TSPC_AVRCP_2_51   False		CT: NotifyVolumeChange (C.3)
> +TSPC_AVRCP_2_49   True (*)	CT: Absolute Volume (C.3)
> +TSPC_AVRCP_2_50   True (*)	CT: SetAbsoluteVolume (C.3)
> +TSPC_AVRCP_2_51   True (*)	CT: NotifyVolumeChange (C.3)
>  TSPC_AVRCP_2_52   False (*)	CT: Discoverable Mode (M)
>  TSPC_AVRCP_2_53   False		CT: PASSTHROUGH operation supporting press
>  					and hold (O)
> @@ -405,9 +405,9 @@ TSPC_AVRCP_7_56   False		TG: 
PlayItem(NowPlayingList)
> (C.11) TSPC_AVRCP_7_57   False		TG: AddToNowPlaying (O)
>  TSPC_AVRCP_7_58   False		TG: EVENT_NOW_PLAYING_CONTENT_CHANGED (C.11)
>  TSPC_AVRCP_7_59   False		TG: Playable Folders (O)
> -TSPC_AVRCP_7_60   True (*)	TG: Absolute Volume (C.5)
> -TSPC_AVRCP_7_61   True (*)	TG: SetAbsoluteVolume (C.5)
> -TSPC_AVRCP_7_62   True (*)	TG: NotifyVolumeChange (C.5)
> +TSPC_AVRCP_7_60   False		TG: Absolute Volume (C.5)
> +TSPC_AVRCP_7_61   False		TG: SetAbsoluteVolume (C.5)
> +TSPC_AVRCP_7_62   False		TG: NotifyVolumeChange (C.5)
>  TSPC_AVRCP_7_63   False		TG: Error Response (O)
>  TSPC_AVRCP_7_64   False		TG: General Reject (C.13)
>  TSPC_AVRCP_7_65   True		TG: Discoverable Mode (M)

Both patches applied, thanks.

-- 
BR
Szymon Janc
