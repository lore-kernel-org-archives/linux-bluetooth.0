Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] android/system-emulator: Pass --track-origin=yes to valgrind
Date: Thu, 10 Apr 2014 07:16:01 -0700 (PDT)
Message-ID: <2591055.y4vYqD1uRh@uw000953>
In-Reply-To: <1397132229-892-1-git-send-email-luiz.dentz@gmail.com>
References: <1397132229-892-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thursday 10 of April 2014 15:17:08 Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds --track-origin=yes option:
> 
>   "Controls whether Memcheck tracks the origin of uninitialised values.
>    By default, it does not, which means that although it can tell you
>    that an uninitialised value is being used in a dangerous way, it
>    cannot tell you where the uninitialised value came from. This often
>    makes it difficult to track down the root problem."
> ---
>  android/system-emulator.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/android/system-emulator.c b/android/system-emulator.c
> index dc46814..c1b1b25 100644
> --- a/android/system-emulator.c
> +++ b/android/system-emulator.c
> @@ -50,7 +50,7 @@ static pid_t snoop_pid = -1;
>  static void ctl_start(void)
>  {
>  	char prg_name[PATH_MAX + 1];
> -	char *prg_argv[5];
> +	char *prg_argv[6];
>  	char *prg_envp[3];
>  	pid_t pid;
>  
> @@ -58,9 +58,10 @@ static void ctl_start(void)
>  
>  	prg_argv[0] = "/usr/bin/valgrind";
>  	prg_argv[1] = "--leak-check=full";
> -	prg_argv[2] = prg_name;
> -	prg_argv[3] = "-d";
> -	prg_argv[4] = NULL;
> +	prg_argv[2] = "--track-origins=yes";
> +	prg_argv[3] = prg_name;
> +	prg_argv[4] = "-d";
> +	prg_argv[5] = NULL;
>  
>  	prg_envp[0] = "G_SLICE=always-malloc";
>  	prg_envp[1] = "G_DEBUG=gc-friendly";
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
