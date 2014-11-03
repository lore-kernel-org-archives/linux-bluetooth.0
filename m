Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Fix copy paste issue in stop recognition function
Date: Mon, 03 Nov 2014 19:14:55 +0100
Message-ID: <4803015.p7VoNrm65U@leonov>
In-Reply-To: <1415022593-25530-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415022593-25530-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 03 of November 2014 14:49:53 Lukasz Rymanowski wrote:
> ---
>  android/client/if-hf-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
> index a837401..3f6f7c2 100644
> --- a/android/client/if-hf-client.c
> +++ b/android/client/if-hf-client.c
> @@ -489,7 +489,7 @@ static void stop_voice_recognition_p(int argc, const
> char **argv) {
>  	RETURN_IF_NULL(if_hf_client);
> 
> -	EXEC(if_hf_client->start_voice_recognition);
> +	EXEC(if_hf_client->stop_voice_recognition);
>  }
> 
>  static void volume_control_c(int argc, const char **argv, enum_func
> *enum_func,

Patch applied, thanks.

-- 
BR
Szymon Janc
