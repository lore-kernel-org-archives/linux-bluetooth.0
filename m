Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pics: Update PICS to PTS 5.0 for DID
Date: Wed, 08 Jan 2014 14:19:51 +0100
Message-ID: <1919110.Rd69fWbI2t@uw000953>
In-Reply-To: <1389175277-28726-1-git-send-email-sebastianx.chlad@intel.com>
References: <1389175277-28726-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

> Remove PICS settings which are not applicable in PTS
> ---
>  android/pics-did.txt | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/android/pics-did.txt b/android/pics-did.txt
> index 8f92bc1..58cee41 100644
> --- a/android/pics-did.txt
> +++ b/android/pics-did.txt
> @@ -1,21 +1,13 @@
>  DID PICS for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  # - not yet implemented/supported
>  
>  M - mandatory
>  O - optional
>  
> -		Version
> --------------------------------------------------------------------------------
> -Parameter Name	Selected	Description
> --------------------------------------------------------------------------------
> -TSPC_DID_0_1	False		Device ID 1.2 (C.1)
> -TSPC_DID_0_2	True		Device ID 1.3 (C.1)
> --------------------------------------------------------------------------------
> -C.1: It is mandatory to support one of the profile versions.
> --------------------------------------------------------------------------------
> -
>  
>  		SDP Requirements
>  -------------------------------------------------------------------------------
> 

Applied, thanks.

-- 
BR
Szymon Janc
