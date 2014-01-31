Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Add Android version to PTS tests
Date: Fri, 31 Jan 2014 14:44:33 +0100
Message-ID: <7247296.ojFrq7q5PZ@leonov>
In-Reply-To: <1391186602-18769-1-git-send-email-sebastianchlad@gmail.com>
References: <1391186602-18769-1-git-send-email-sebastianchlad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 31 of January 2014 18:43:22 Sebastian Chlad wrote:
> This trivial patch adds Android version to the PTS test results.
> It helps tracking tests status.
> ---
>  android/pts-a2dp.txt  | 1 +
>  android/pts-avctp.txt | 1 +
>  android/pts-avrcp.txt | 1 +
>  android/pts-did.txt   | 1 +
>  android/pts-gap.txt   | 1 +
>  android/pts-l2cap.txt | 1 +
>  android/pts-opp.txt   | 1 +
>  android/pts-pbap.txt  | 1 +
>  8 files changed, 8 insertions(+)
> 
> diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
> index 3d1085e..301b1e7 100644
> --- a/android/pts-a2dp.txt
> +++ b/android/pts-a2dp.txt
> @@ -2,6 +2,7 @@ PTS test results for A2DP
> 
>  PTS version: 5.0
>  Tested: 28.01.2014
> +Android version: 4.4.2
> 
>  Results:
>  PASS	test passed
> diff --git a/android/pts-avctp.txt b/android/pts-avctp.txt
> index a57ecee..4090ec0 100644
> --- a/android/pts-avctp.txt
> +++ b/android/pts-avctp.txt
> @@ -2,6 +2,7 @@ PTS test results for AVCTP
> 
>  PTS version: 5.0
>  Tested: 29.01.2014
> +Android version: 4.4.2
> 
>  Results:
>  PASS	test passed
> diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
> index 454e26c..8bd0b4d 100644
> --- a/android/pts-avrcp.txt
> +++ b/android/pts-avrcp.txt
> @@ -2,6 +2,7 @@ PTS test results for AVRCP
> 
>  PTS version: 5.0
>  Tested: 28.01.2014
> +Android version: 4.4.2
> 
>  Results:
>  PASS	test passed
> diff --git a/android/pts-did.txt b/android/pts-did.txt
> index d764f09..841b257 100644
> --- a/android/pts-did.txt
> +++ b/android/pts-did.txt
> @@ -2,6 +2,7 @@ PTS test results for DID
> 
>  PTS version: 5.0
>  Tested: 28.01.2014
> +Android version: 4.4.2
> 
>  Results:
>  PASS	test passed
> diff --git a/android/pts-gap.txt b/android/pts-gap.txt
> index 1c0feec..7c88f1f 100644
> --- a/android/pts-gap.txt
> +++ b/android/pts-gap.txt
> @@ -2,6 +2,7 @@ PTS test results for GAP
> 
>  PTS version: 5.0
>  Tested: 28.01.2014
> +Android version: 4.4.2
> 
>  Results:
>  PASS	test passed
> diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
> index 3e46309..f04c3e5 100644
> --- a/android/pts-l2cap.txt
> +++ b/android/pts-l2cap.txt
> @@ -2,6 +2,7 @@ PTS test results for L2CAP
> 
>  PTS version: 5.0
>  Tested: 29.01.2014
> +Android version: 4.4.2
> 
>  Results:
>  PASS   test passed
> diff --git a/android/pts-opp.txt b/android/pts-opp.txt
> index 3c4ab47..d5dfcf0 100644
> --- a/android/pts-opp.txt
> +++ b/android/pts-opp.txt
> @@ -2,6 +2,7 @@ PTS test results for OPP
> 
>  PTS version: 5.0
>  Tested: 28.01.2014
> +Android version: 4.4.2
> 
>  Results:
>  PASS	test passed
> diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
> index 4312921..41442c6 100644
> --- a/android/pts-pbap.txt
> +++ b/android/pts-pbap.txt
> @@ -2,6 +2,7 @@ PTS test results for PBAP
> 
>  PTS version: 5.0
>  Tested: 28.01.2014
> +Android version: 4.4.2
> 
>  Results:
>  PASS	test passed

Applied, thanks.

-- 
BR
Szymon Janc
