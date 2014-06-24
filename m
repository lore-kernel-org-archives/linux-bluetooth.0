Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] android/pics-hogp: Fix having both types of discover set
Date: Tue, 24 Jun 2014 09:51:43 +0200
Message-ID: <280722635.R9amvn24Ia@uw000953>
In-Reply-To: <1403527577-16254-1-git-send-email-luiz.dentz@gmail.com>
References: <1403527577-16254-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Monday 23 of June 2014 15:46:16 Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Currently the code discover by service handle and not by UUID.
> ---
>  android/pics-hogp.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pics-hogp.txt b/android/pics-hogp.txt
> index 81e182c..6544b54 100644
> --- a/android/pics-hogp.txt
> +++ b/android/pics-hogp.txt
> @@ -330,10 +330,10 @@ TSPC_HOGP_13_1	True		Attribute Protocol supported over LE Transport
>  				(M)
>  TSPC_HOGP_13_2	True		Generic Attribute Profile Client (M)
>  TSPC_HOGP_13_3	True		Discover All Primary Services (C.1)
> -TSPC_HOGP_13_4	True		Discover Primary Services by Service UUID (C.1)
> +TSPC_HOGP_13_4	False		Discover Primary Services by Service UUID (C.1)
>  TSPC_HOGP_13_5	True		Find Included Services (M)
>  TSPC_HOGP_13_6	True		Discover All Characteristics of a Service (C.2)
> -TSPC_HOGP_13_7	True		Discover Characteristics by UUID (C.2)
> +TSPC_HOGP_13_7	False		Discover Characteristics by UUID (C.2)
>  TSPC_HOGP_13_8	True		Discover All Characteristic Descriptors (M)
>  TSPC_HOGP_13_9	True		Read Characteristic Value (M)
>  TSPC_HOGP_13_10	True		Read using Characteristic UUID (O)
> 

Both patches applied. Thanks.

-- 
Best regards, 
Szymon Janc
