Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/2] android/haltest: Close file in case of error
Date: Fri, 07 Feb 2014 11:05:01 +0100
Message-ID: <6446365.iLMeAT5gVN@uw000953>
In-Reply-To: <1391696563-7478-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391615042-22677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1391696563-7478-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 06 of February 2014 16:22:42 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/client/if-audio.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/android/client/if-audio.c b/android/client/if-audio.c
> index 66f8364..3b34c95 100644
> --- a/android/client/if-audio.c
> +++ b/android/client/if-audio.c
> @@ -258,19 +258,26 @@ static void play_p(int argc, const char **argv)
>  
>  	if (buffer_size == 0) {
>  		haltest_error("Invalid buffer size. Was stream_out opened?\n");
> -		return;
> +		goto fail;
>  	}
>  
>  	pthread_mutex_lock(&state_mutex);
>  	if (current_state != STATE_STOPPED) {
>  		haltest_error("Already playing or stream suspended!\n");
>  		pthread_mutex_unlock(&state_mutex);
> -		return;
> +		goto fail;
>  	}
>  	pthread_mutex_unlock(&state_mutex);
>  
> -	if (pthread_create(&play_thread, NULL, playback_thread, in) != 0)
> +	if (pthread_create(&play_thread, NULL, playback_thread, in) != 0) {
>  		haltest_error("Cannot create playback thread!\n");
> +		goto fail;
> +	}
> +
> +	return;
> +fail:
> +	if (in)
> +		fclose(in);
>  }
>  
>  static void stop_p(int argc, const char **argv)
> 

This patch is now upstream, thanks.

-- 
Best regards, 
Szymon Janc
