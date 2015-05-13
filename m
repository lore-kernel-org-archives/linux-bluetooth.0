Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/3] android/pts: Update BNEP PTS 6.0 results for android 5.0
Date: Wed, 13 May 2015 16:45:02 +0200
Message-ID: <5245500.732iXbM3q3@leonov>
In-Reply-To: <1428930887-25519-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1428930887-25519-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1428930887-25519-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 13 of April 2015 15:14:47 Grzegorz Kolodziejczyk wrote:
> This patch updates BNEP PTS 6.0 results for android 5.0 witch added
> support for handling extension headers of BNEP control frames.
> ---
>  android/pts-bnep.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/android/pts-bnep.txt b/android/pts-bnep.txt
> index 91ef1c5..42f6438 100644
> --- a/android/pts-bnep.txt
> +++ b/android/pts-bnep.txt
> @@ -1,7 +1,7 @@
>  PTS test results for BNEP
> 
>  PTS version: 6.0
> -Tested: 12-March-2015
> +Tested: 09-April-2015
>  Android version: 5.0
>  Kernel version: 3.20
> 
> @@ -33,8 +33,7 @@ TC_CTRL_BV_09_C		PASS	bneptest -c <PTS addr> -b 
<bridge>
> -n <iface> -j ff:ff:ff:ff:ff:ff -y 1
>  TC_CTRL_BV_10_C		PASS	PTS issue #13169
>  				bneptest -s -b <bridge> -n <iface>
> -TC_CTRL_BV_19_C		INC	JIRA #BA-343
> -				bneptest -s -b <bridge> -n <iface>
> +TC_CTRL_BV_19_C		PASS	bneptest -s -b <bridge> -n <iface>
>  TC_RX_TYPE_0_BV_11_C	PASS	bneptest -s -b <bridge> -n <iface>
>  TC_RX_C_BV_12_C		PASS	bneptest -s -b <bridge> -n <iface>
>  TC_RX_C_S_BV_13_C	PASS	bneptest -s -b <bridge> -n <iface>

This patch is now applied, thanks.

-- 
BR
Szymon Janc
