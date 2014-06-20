Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pics: Enable privacy for peripheral
Date: Fri, 20 Jun 2014 17:33:39 +0200
Message-ID: <1996396.GEAxASJi7u@uw000953>
In-Reply-To: <1403218234-19996-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1403218234-19996-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Friday 20 of June 2014 00:50:33 Lukasz Rymanowski wrote:
> ---
>  android/pics-gap.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pics-gap.txt b/android/pics-gap.txt
> index 5b36d4a..b3b896c 100644
> --- a/android/pics-gap.txt
> +++ b/android/pics-gap.txt
> @@ -461,12 +461,12 @@ C.2: Mandatory if TSPC_GAP_0A_1 and TSPC_GAP_27_4 are supported,
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
>  TSPC_GAP_26_1	False		Peripheral: Privacy Feature (O)
> -TSPC_GAP_26_1A	False		Peripheral: Privacy Feature v1.1 (O)
> -TSPC_GAP_26_2	False		Peripheral: Non-Resolvable Private Address
> +TSPC_GAP_26_1A	True (*)	Peripheral: Privacy Feature v1.1 (O)
> +TSPC_GAP_26_2	True (*)	Peripheral: Non-Resolvable Private Address
>  					Generation Procedure (C.1)
> -TSPC_GAP_26_3	False		Peripheral: Resolvable Private Address
> +TSPC_GAP_26_3	True (*)	Peripheral: Resolvable Private Address
>  					Generation Procedure (C.2)
> -TSPC_GAP_26_4	False		Peripheral: Resolvable Private Address
> +TSPC_GAP_26_4	True (*)	Peripheral: Resolvable Private Address
>  					Generation Procedure (C.4)
>  -------------------------------------------------------------------------------
>  C.1: Optional if TSPC_GAP_26_1 is supported, otherwise Excluded.
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
