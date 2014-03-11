Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/handsfree: Fix list of HF features
Date: Tue, 11 Mar 2014 12:22:30 +0100
Message-ID: <8773861.L8v0dr7lW4@uw000953>
In-Reply-To: <1394532999-15744-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394532999-15744-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tuesday 11 of March 2014 11:16:39 Marcin Kraglak wrote:
> Add missing Remote volume control feature
> ---
>  android/handsfree.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index 0828de8..4f999e1 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -64,9 +64,10 @@
>  #define HFP_HF_FEAT_3WAY	0x00000002
>  #define HFP_HF_FEAT_CLI		0x00000004
>  #define HFP_HF_FEAT_VR		0x00000008
> -#define HFP_HF_FEAT_ECS		0x00000010
> -#define HFP_HF_FEAT_ECC		0x00000020
> -#define HFP_HF_FEAT_CODEC	0x00000040
> +#define HFP_HF_FEAT_RVC		0x00000010
> +#define HFP_HF_FEAT_ECS		0x00000020
> +#define HFP_HF_FEAT_ECC		0x00000040
> +#define HFP_HF_FEAT_CODEC	0x00000080
>  
>  #define HFP_AG_FEATURES ( HFP_AG_FEAT_3WAY | HFP_AG_FEAT_ECNR |\
>  			HFP_AG_FEAT_VR | HFP_AG_FEAT_REJ_CALL |\
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
