Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS test results for HID
Date: Tue, 28 Jan 2014 16:39:31 +0100
Message-ID: <3964416.LD5rIGGQ5E@leonov>
In-Reply-To: <1390916262-8022-1-git-send-email-sebastianx.chlad@intel.com>
References: <1390916262-8022-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 28 of January 2014 15:37:42 Sebastian Chlad wrote:
> ---
>  android/pts-hid.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/android/pts-hid.txt b/android/pts-hid.txt
> index 7e9f986..5208d92 100644
> --- a/android/pts-hid.txt
> +++ b/android/pts-hid.txt
> @@ -1,7 +1,7 @@
>  PTS test results for DID
> 
> -PTS version: 4.9
> -Tested: 14.11.2013
> +PTS version: 5.0
> +Tested: 28.01.2014
> 
>  Results:
>  PASS	test passed
> @@ -13,7 +13,8 @@ N/A	test is disabled due to PICS setup
>  Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- TC_HOS_HCE_BV_01_I	PASS
> -TC_HOS_HCE_BV_02_I	PASS
> +TC_HOS_HCE_BV_02_I	PASS	IUT must be connectable
> +					(i.e. btmgmt connectable on)

Isn't enabling BT enough for this test to pass?

>  TC_HOS_HCE_BV_03_I	PASS
>  TC_HOS_HCE_BV_04_I	PASS
>  TC_HOS_HCR_BV_01_I	PASS

-- 
BR
Szymon Janc
