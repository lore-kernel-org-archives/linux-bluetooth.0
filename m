Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update IOPT PICS and PTS test results
Date: Tue, 18 Nov 2014 23:18:54 +0100
Message-ID: <3569506.z2X58Bcpdb@leonov>
In-Reply-To: <1416314340-32688-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416314340-32688-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tuesday 18 of November 2014 13:39:00 Marcin Kraglak wrote:
> ---
>  android/pics-iopt.txt | 2 +-
>  android/pts-iopt.txt  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/android/pics-iopt.txt b/android/pics-iopt.txt
> index 0b7446e..1276224 100644
> --- a/android/pics-iopt.txt
> +++ b/android/pics-iopt.txt
> @@ -96,7 +96,7 @@ TSPC_support_HealthDeviceProfile_Sink	True (*)	
Support
> for: HDP TSPC_support_HealthDeviceProfile_Source	False		Support for: 
HDP
>  							Role: Source
> 
> -TSPC_support_NewHandsFreeProfile_AG	False		Support for: HFP
> +TSPC_support_NewHandsFreeProfile_AG	True		Support for: HFP
>  							Role: Audio gateway
> 
>  TSPC_support_NewHandsFreeProfile_HF	False		Support for: HFP
> diff --git a/android/pts-iopt.txt b/android/pts-iopt.txt
> index aec40ed..f746b1c 100644
> --- a/android/pts-iopt.txt
> +++ b/android/pts-iopt.txt
> @@ -1,8 +1,8 @@
>  PTS test results for IOPT
> 
>  PTS version: 5.3
> -Tested: 20-October-2014
> -Android version: 4.4.4
> +Tested: 18-November-2014
> +Android version: 5.0
> 
>  Results:
>  PASS	test passed

Applied, thanks.

-- 
BR
Szymon Janc
