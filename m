Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] android/avdtptest: Enable delay reporting
Date: Wed, 03 Sep 2014 16:57:50 +0200
Message-ID: <1905965.DfTHQWInPS@uw000953>
In-Reply-To: <1409750027-20992-1-git-send-email-szymon.janc@tieto.com>
References: <1409750027-20992-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 03 of September 2014 15:13:43 Szymon Janc wrote:
> ---
>  android/avdtptest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/avdtptest.c b/android/avdtptest.c
> index d1f2ef4..d520bc0 100644
> --- a/android/avdtptest.c
> +++ b/android/avdtptest.c
> @@ -856,7 +856,7 @@ int main(int argc, char *argv[])
>  	}
>  
>  	local_sep = avdtp_register_sep(dev_role, AVDTP_MEDIA_TYPE_AUDIO,
> -					0x00, FALSE, &sep_ind, &sep_cfm, NULL);
> +					0x00, TRUE, &sep_ind, &sep_cfm, NULL);
>  	if (!local_sep) {
>  		printf("Failed to register sep\n");
>  		exit(0);
> 

Pushed.

-- 
Best regards, 
Szymon Janc
