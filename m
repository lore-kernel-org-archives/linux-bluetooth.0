Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/5] android: Fix ipc cleanup
Date: Thu, 16 Jan 2014 09:41:16 +0100
Message-ID: <8912359.omIpJ0S0ZX@uw000953>
In-Reply-To: <1389813150-16914-2-git-send-email-marcin.kraglak@tieto.com>
References: <1389813150-16914-1-git-send-email-marcin.kraglak@tieto.com> <1389813150-16914-2-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 15 of January 2014 20:12:27 Marcin Kraglak wrote:
> Remove sources while cleanup. It will avoid receiving
> events after cleanup.
> ---
>  android/ipc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/android/ipc.c b/android/ipc.c
> index ed3ef3c..4277bfe 100644
> --- a/android/ipc.c
> +++ b/android/ipc.c
> @@ -45,6 +45,9 @@ static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
>  static GIOChannel *cmd_io = NULL;
>  static GIOChannel *notif_io = NULL;
>  
> +static guint cmd_id;
> +static guint notif_id;

Please name it cmd_watch and notif_watch. Also explicitly initialize them to 0 here.

> +
>  int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
>  						const void *buf, ssize_t len)
>  {
> @@ -192,11 +195,11 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
>  
>  	cond = G_IO_ERR | G_IO_HUP | G_IO_NVAL;
>  
> -	g_io_add_watch(io, cond, notif_watch_cb, NULL);
> +	notif_id = g_io_add_watch(io, cond, notif_watch_cb, NULL);
>  
>  	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
>  
> -	g_io_add_watch(cmd_io, cond, cmd_watch_cb, NULL);
> +	cmd_id = g_io_add_watch(cmd_io, cond, cmd_watch_cb, NULL);
>  
>  	info("IPC: successfully connected");
>  
> @@ -232,12 +235,22 @@ void ipc_init(void)
>  
>  void ipc_cleanup(void)
>  {
> +	if (cmd_id) {
> +		g_source_remove(cmd_id);
> +		cmd_id = 0;
> +	}
> +
>  	if (cmd_io) {
>  		g_io_channel_shutdown(cmd_io, TRUE, NULL);
>  		g_io_channel_unref(cmd_io);
>  		cmd_io = NULL;
>  	}
>  
> +	if (notif_id) {
> +		g_source_remove(notif_id);
> +		notif_id = 0;
> +	}
> +
>  	if (notif_io) {
>  		g_io_channel_shutdown(notif_io, TRUE, NULL);
>  		g_io_channel_unref(notif_io);
> 

-- 
Best regards, 
Szymon Janc
