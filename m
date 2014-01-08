Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pics: Update PICS to PTS 5.0
Date: Wed, 08 Jan 2014 14:20:07 +0100
Message-ID: <5346017.eqC3gyLkDH@uw000953>
In-Reply-To: <1389181018-30211-1-git-send-email-sebastianx.chlad@intel.com>
References: <1389181018-30211-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

> Update PICS settings for HID, L2CAP, OPP, PAN and PBAP
> ---
>  android/pics-hid.txt   | 2 ++
>  android/pics-l2cap.txt | 2 ++
>  android/pics-opp.txt   | 2 ++
>  android/pics-pan.txt   | 2 ++
>  android/pics-pbap.txt  | 5 +++--
>  5 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pics-hid.txt b/android/pics-hid.txt
> index b0b7d52..ac37e45 100644
> --- a/android/pics-hid.txt
> +++ b/android/pics-hid.txt
> @@ -1,5 +1,7 @@
>  HID PICS for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  # - not yet implemented/supported
>  
> diff --git a/android/pics-l2cap.txt b/android/pics-l2cap.txt
> index ef25133..7b49627 100644
> --- a/android/pics-l2cap.txt
> +++ b/android/pics-l2cap.txt
> @@ -1,5 +1,7 @@
>  L2CAP PICS for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  # - not yet implemented/supported
>  
> diff --git a/android/pics-opp.txt b/android/pics-opp.txt
> index c0f2ad6..cd4acce 100644
> --- a/android/pics-opp.txt
> +++ b/android/pics-opp.txt
> @@ -1,5 +1,7 @@
>  OPP PICS for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  # - not yet implemented/supported
>  
> diff --git a/android/pics-pan.txt b/android/pics-pan.txt
> index 7576d2d..16457bf 100644
> --- a/android/pics-pan.txt
> +++ b/android/pics-pan.txt
> @@ -1,5 +1,7 @@
>  PAN PICS for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  # - not yet implemented/supported
>  
> diff --git a/android/pics-pbap.txt b/android/pics-pbap.txt
> index 7b2d7d2..b6b6d8b 100644
> --- a/android/pics-pbap.txt
> +++ b/android/pics-pbap.txt
> @@ -1,5 +1,7 @@
>  PBAP PICS for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  # - not yet implemented/supported
>  
> @@ -12,8 +14,7 @@ Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
>  TSPC_PBAP_0_1	False		Role: PBAP 1.0 (C.1)
>  TSPC_PBAP_0_2	True (*)	Role: PBAP 1.1 (C.1)
> -TSPC_PBAP_0_3	False		Role: Reserve
> -TSPC_PBAP_0_4	False (*)	Role: PBAP 1.2 (C.1)
> +TSPC_PBAP_0_3	False (*)	Role: PBAP 1.2 (C.1)
>  -------------------------------------------------------------------------------
>  C.1: Mandatory to support one and only one major profile version.
>  -------------------------------------------------------------------------------
> 

Applied, thanks.

-- 
BR
Szymon Janc

