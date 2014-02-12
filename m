Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] android/test-ipc: Use correct boolean values for glib functions
Date: Wed, 12 Feb 2014 20:21:02 +0100
Message-ID: <2318292.vcUTG61T5m@leonov>
In-Reply-To: <1392232401-26119-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392232401-26119-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Wednesday 12 of February 2014 15:13:21 Anderson Lizardo wrote:
> ---
>  android/test-ipc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/test-ipc.c b/android/test-ipc.c
> index 3a0729e..2def97b 100644
> --- a/android/test-ipc.c
> +++ b/android/test-ipc.c
> @@ -263,8 +263,8 @@ static void execute_context(struct context *context)
>  {
>  	g_main_loop_run(context->main_loop);
> 
> -	g_io_channel_shutdown(context->notif_io, true, NULL);
> -	g_io_channel_shutdown(context->cmd_io, true, NULL);
> +	g_io_channel_shutdown(context->notif_io, TRUE, NULL);
> +	g_io_channel_shutdown(context->cmd_io, TRUE, NULL);
>  	g_io_channel_unref(context->cmd_io);
>  	g_io_channel_unref(context->notif_io);

Applied, thanks.

-- 
BR
Szymon Janc
