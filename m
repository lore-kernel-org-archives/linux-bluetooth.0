Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pts: Disable OOB from Secure Manager PICS
Date: Tue, 17 Jun 2014 15:06:36 +0200
Message-ID: <7930007.4UKpXLPTX4@uw000953>
In-Reply-To: <1402958397-1415-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1402958397-1415-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 17 of June 2014 00:39:56 Lukasz Rymanowski wrote:
> ---
>  android/pics-sm.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pics-sm.txt b/android/pics-sm.txt
> index 3060d40..239f568 100644
> --- a/android/pics-sm.txt
> +++ b/android/pics-sm.txt
> @@ -25,7 +25,7 @@ Parameter Name	Selected	Description
>  TSPC_SM_2_1	True		Authenticated MITM protection (O)
>  TSPC_SM_2_2	True		Unauthenticated no MITM protection (C.1)
>  TSPC_SM_2_3	True		No security requirements (M)
> -TSPC_SM_2_4	True		OOB supported (O)
> +TSPC_SM_2_4	False		OOB supported (O)
>  -------------------------------------------------------------------------------
>  C.1: If TSPC_SM_2_1 is supported then Mandatory, else Optional
>  -------------------------------------------------------------------------------
> @@ -45,7 +45,7 @@ Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
>  TSPC_SM_4_1	True		Just Works (O)
>  TSPC_SM_4_2	True		Passkey Entry (C.1)
> -TSPC_SM_4_3	True		Out of Band (C.1)
> +TSPC_SM_4_3	False		Out of Band (C.1)
>  -------------------------------------------------------------------------------
>  C.1: If TSPC_SM_2_1 is supported, at least one of these features shall be
>  	supported.
> 

Both patches (v2 of 2/2) applied, thanks.

-- 
Best regards, 
Szymon Janc
