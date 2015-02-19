Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Fix Send Pass Through command
Date: Thu, 19 Feb 2015 11:49:07 +0100
Message-ID: <1502700.uFuzQcoapE@uw000953>
In-Reply-To: <1419344963-25331-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1419344963-25331-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 23 of December 2014 15:29:23 Grzegorz Kolodziejczyk wrote:
> Parameter should be checked if it's given with (argc is lower than
> expected). Third parameter can be auto completed with cached bluetooth
> addresses.
> ---
>  android/client/if-rc-ctrl.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/android/client/if-rc-ctrl.c b/android/client/if-rc-ctrl.c
> index 52573a0..3980764 100644
> --- a/android/client/if-rc-ctrl.c
> +++ b/android/client/if-rc-ctrl.c
> @@ -67,10 +67,13 @@ static void cleanup_p(int argc, const char **argv)
>  }
>  
>  /* send_pass_through_cmd */
> -
>  static void send_pass_through_cmd_c(int argc, const char **argv,
>  					enum_func *enum_func, void **user)
>  {
> +	if (argc == 3) {
> +		*user = NULL;
> +		*enum_func = enum_devices;
> +	}
>  }
>  
>  static void send_pass_through_cmd_p(int argc, const char **argv)
> @@ -81,15 +84,15 @@ static void send_pass_through_cmd_p(int argc, const char **argv)
>  	RETURN_IF_NULL(if_rc);
>  	VERIFY_ADDR_ARG(2, &addr);
>  
> -	if (argc <= 4) {
> -		haltest_error("No key code specified");
> +	if (argc < 4) {
> +		haltest_error("No key code specified\n");
>  		return;
>  	}
>  
>  	key_code = (uint8_t) atoi(argv[3]);
>  
> -	if (argc <= 5) {
> -		haltest_error("No key state specified");
> +	if (argc < 5) {
> +		haltest_error("No key state specified\n");
>  		return;
>  	}
>  
> @@ -100,8 +103,7 @@ static void send_pass_through_cmd_p(int argc, const char **argv)
>  
>  static struct method methods[] = {
>  	STD_METHOD(init),
> -	STD_METHODCH(send_pass_through_cmd,
> -					"<bd_addr> <key_code> <key_state>"),
> +	STD_METHODCH(send_pass_through_cmd, "<bd_addr> <key_code> <key_state>"),
>  	STD_METHOD(cleanup),
>  	END_METHOD
>  };

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
