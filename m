Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: Re: [PATCH] android/pixit: Add PTS version to respective pixit
Date: Wed, 08 Jan 2014 15:51:13 +0100
Message-ID: <3016423.KQ2rzUoU3Y@uw000953>
In-Reply-To: <1389133067-5157-1-git-send-email-sebastianx.chlad@intel.com>
References: <1389133067-5157-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 07 of January 2014 23:17:47 Sebastian Chlad wrote:
> ---
>  android/pixit-did.txt   | 2 ++
>  android/pixit-gap.txt   | 2 ++
>  android/pixit-hid.txt   | 2 ++
>  android/pixit-l2cap.txt | 2 ++
>  android/pixit-opp.txt   | 2 ++
>  android/pixit-pan.txt   | 2 ++
>  android/pixit-pbap.txt  | 2 ++
>  7 files changed, 14 insertions(+)
> 
> diff --git a/android/pixit-did.txt b/android/pixit-did.txt
> index 2527845..8c64d52 100644
> --- a/android/pixit-did.txt
> +++ b/android/pixit-did.txt
> @@ -1,5 +1,7 @@
>  DID PIXIT for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
>  
> diff --git a/android/pixit-gap.txt b/android/pixit-gap.txt
> index 786c55e..f3c7726 100644
> --- a/android/pixit-gap.txt
> +++ b/android/pixit-gap.txt
> @@ -1,5 +1,7 @@
>  GAP PIXIT for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
>  
> diff --git a/android/pixit-hid.txt b/android/pixit-hid.txt
> index f306615..1d36c92 100644
> --- a/android/pixit-hid.txt
> +++ b/android/pixit-hid.txt
> @@ -1,5 +1,7 @@
>  HID PIXIT for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
>  
> diff --git a/android/pixit-l2cap.txt b/android/pixit-l2cap.txt
> index 7de6638..a307625 100644
> --- a/android/pixit-l2cap.txt
> +++ b/android/pixit-l2cap.txt
> @@ -1,5 +1,7 @@
>  L2CAP PIXIT for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
>  
> diff --git a/android/pixit-opp.txt b/android/pixit-opp.txt
> index 1b1e834..93f6a29 100644
> --- a/android/pixit-opp.txt
> +++ b/android/pixit-opp.txt
> @@ -1,5 +1,7 @@
>  OPP PIXIT for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
>  
> diff --git a/android/pixit-pan.txt b/android/pixit-pan.txt
> index 2d180da..6544a9c 100644
> --- a/android/pixit-pan.txt
> +++ b/android/pixit-pan.txt
> @@ -1,5 +1,7 @@
>  PAN PIXIT for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
>  
> diff --git a/android/pixit-pbap.txt b/android/pixit-pbap.txt
> index 272cbc3..470f4c5 100644
> --- a/android/pixit-pbap.txt
> +++ b/android/pixit-pbap.txt
> @@ -1,5 +1,7 @@
>  PBAP PIXIT for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
>  
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
