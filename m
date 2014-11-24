Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pts: Correct typo in AVDTP PICS file
Date: Mon, 24 Nov 2014 15:56:25 +0100
Message-ID: <3089428.U3OumBROA1@leonov>
In-Reply-To: <1416835839-14761-1-git-send-email-sebastian.chlad@tieto.com>
References: <1416835839-14761-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Monday 24 of November 2014 14:30:38 Sebastian Chlad wrote:
> ---
>  android/pics-avdtp.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/pics-avdtp.txt b/android/pics-avdtp.txt
> index 0bcbfb9..ce7b259 100644
> --- a/android/pics-avdtp.txt
> +++ b/android/pics-avdtp.txt
> @@ -116,7 +116,7 @@ TSPC_AVDTP_8_4	True		Signal identifier (M)
>  Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- TSPC_AVDTP_9_1	True (*)	Establish signaling channel (O)
> -TSPC_AVDTP_9_1	True (*)	Disconnect signaling channel (O)
> +TSPC_AVDTP_9_2	True (*)	Disconnect signaling channel (O)
>  ---------------------------------------------------------------------------
> ----

Applied, thanks.

-- 
BR
Szymon Janc
