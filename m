Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/avdtptest: Fix NULL local stream endpoint queue
Date: Wed, 13 May 2015 17:04:05 +0200
Message-ID: <5844784.NeDgek3HDe@leonov>
In-Reply-To: <1431417981-24341-1-git-send-email-mariusz.skamra@tieto.com>
References: <1431417981-24341-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Tuesday 12 of May 2015 10:06:21 Mariusz Skamra wrote:
> This patch fixes missing queue_new()
> ---
>  android/avdtptest.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/android/avdtptest.c b/android/avdtptest.c
> index f42f664..2e07d7e 100644
> --- a/android/avdtptest.c
> +++ b/android/avdtptest.c
> @@ -866,6 +866,12 @@ int main(int argc, char *argv[])
>  		}
>  	}
> 
> +	lseps = queue_new();
> +	if (!lseps) {
> +		printf("Failed to allocate memory\n");
> +		exit(0);
> +	}
> +
>  	local_sep = avdtp_register_sep(lseps, dev_role, AVDTP_MEDIA_TYPE_AUDIO,
>  					0x00, TRUE, &sep_ind, &sep_cfm, NULL);
>  	if (!local_sep) {

Patch applied, thanks.

-- 
BR
Szymon Janc
