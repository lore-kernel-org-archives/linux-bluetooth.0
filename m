Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/system-emulator: Allow to run daemon without valgrind
Date: Tue, 17 Jun 2014 11:11:53 +0200
Message-ID: <7546385.FRHW8imyP3@uw000953>
In-Reply-To: <1402928748-16128-1-git-send-email-szymon.janc@tieto.com>
References: <1402928748-16128-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 16 of June 2014 16:25:48 Szymon Janc wrote:
> If valgrind is not present on system start bluetoothd directly instead
> of failing silently.
> ---
>  android/system-emulator.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/android/system-emulator.c b/android/system-emulator.c
> index c1b1b25..4d41fce 100644
> --- a/android/system-emulator.c
> +++ b/android/system-emulator.c
> @@ -47,14 +47,10 @@ static char exec_dir[PATH_MAX + 1];
>  static pid_t daemon_pid = -1;
>  static pid_t snoop_pid = -1;
>  
> -static void ctl_start(void)
> +static void run_valgrind(char *prg_name)
>  {
> -	char prg_name[PATH_MAX + 1];
>  	char *prg_argv[6];
>  	char *prg_envp[3];
> -	pid_t pid;
> -
> -	snprintf(prg_name, sizeof(prg_name), "%s/%s", exec_dir, "bluetoothd");
>  
>  	prg_argv[0] = "/usr/bin/valgrind";
>  	prg_argv[1] = "--leak-check=full";
> @@ -67,6 +63,30 @@ static void ctl_start(void)
>  	prg_envp[1] = "G_DEBUG=gc-friendly";
>  	prg_envp[2] = NULL;
>  
> +	execve(prg_argv[0], prg_argv, prg_envp);
> +}
> +
> +static void run_bluetoothd(char *prg_name)
> +{
> +	char *prg_argv[3];
> +	char *prg_envp[1];
> +
> +	prg_argv[0] = prg_name;
> +	prg_argv[1] = "-d";
> +	prg_argv[2] = NULL;
> +
> +	prg_envp[0] = NULL;
> +
> +	execve(prg_argv[0], prg_argv, prg_envp);
> +}
> +
> +static void ctl_start(void)
> +{
> +	char prg_name[PATH_MAX + 1];
> +	pid_t pid;
> +
> +	snprintf(prg_name, sizeof(prg_name), "%s/%s", exec_dir, "bluetoothd");
> +
>  	printf("Starting %s\n", prg_name);
>  
>  	pid = fork();
> @@ -76,7 +96,10 @@ static void ctl_start(void)
>  	}
>  
>  	if (pid == 0) {
> -		execve(prg_argv[0], prg_argv, prg_envp);
> +		run_valgrind(prg_name);
> +
> +		/* Fallback to no valgrind if running with valgind failed */
> +		run_bluetoothd(prg_name);
>  		exit(0);
>  	}
>  
> 

Applied.

-- 
Best regards, 
Szymon Janc
