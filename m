Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Feb 2014 16:13:07 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/haltest: Close file in case of error
Message-ID: <20140206141259.GA11005@aemeltch-MOBL1>
References: <1391615042-22677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391615042-22677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 05, 2014 at 05:44:02PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/client/if-audio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/android/client/if-audio.c b/android/client/if-audio.c
> index 66f8364..bb8f51b 100644
> --- a/android/client/if-audio.c
> +++ b/android/client/if-audio.c
> @@ -258,6 +258,7 @@ static void play_p(int argc, const char **argv)
>  
>  	if (buffer_size == 0) {
>  		haltest_error("Invalid buffer size. Was stream_out opened?\n");
> +		fclose(in);

sorry, need to check for NULL here and below.

Best regards 
Andrei Emeltchenko 

>  		return;
>  	}
>  
> @@ -265,12 +266,15 @@ static void play_p(int argc, const char **argv)
>  	if (current_state != STATE_STOPPED) {
>  		haltest_error("Already playing or stream suspended!\n");
>  		pthread_mutex_unlock(&state_mutex);
> +		fclose(in);
>  		return;
>  	}
>  	pthread_mutex_unlock(&state_mutex);
>  
> -	if (pthread_create(&play_thread, NULL, playback_thread, in) != 0)
> +	if (pthread_create(&play_thread, NULL, playback_thread, in) != 0) {
>  		haltest_error("Cannot create playback thread!\n");
> +		fclose(in);
> +	}
>  }
>  
>  static void stop_p(int argc, const char **argv)
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
