Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/7] shared: Add support for disconnect handler to GLib based IO handling
Date: Mon, 24 Feb 2014 10:57:09 +0100
Message-ID: <15483540.rKo7RXqjDX@uw000953>
In-Reply-To: <1393103365-19908-1-git-send-email-szymon.janc@gmail.com>
References: <1393103365-19908-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Saturday 22 of February 2014 22:09:19 Szymon Janc wrote:
> From: Szymon Janc <szymon.janc@tieto.com>
> 
> ---
>  src/shared/io-glib.c | 76 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 67 insertions(+), 9 deletions(-)
> 
> diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> index 5bd9ac0..5490fc0 100644
> --- a/src/shared/io-glib.c
> +++ b/src/shared/io-glib.c
> @@ -40,6 +40,10 @@ struct io {
>  	io_callback_func_t write_callback;
>  	io_destroy_func_t write_destroy;
>  	void *write_data;
> +	guint disconnect_watch;
> +	io_callback_func_t disconnect_callback;
> +	io_destroy_func_t disconnect_destroy;
> +	void *disconnect_data;
>  };
>  
>  static struct io *io_ref(struct io *io)
> @@ -157,7 +161,7 @@ static gboolean read_callback(GIOChannel *channel, GIOCondition cond,
>  	struct io *io = user_data;
>  	bool result;
>  
> -	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
> +	if (cond & (G_IO_ERR | G_IO_NVAL))
>  		return FALSE;
>  
>  	if (io->read_callback)
> @@ -183,9 +187,9 @@ bool io_set_read_handler(struct io *io, io_callback_func_t callback,
>  		goto done;
>  
>  	io->read_watch = g_io_add_watch_full(io->channel, G_PRIORITY_DEFAULT,
> -				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> -				read_callback, io_ref(io),
> -				read_watch_destroy);
> +						G_IO_IN | G_IO_ERR | G_IO_NVAL,
> +						read_callback, io_ref(io),
> +						read_watch_destroy);
>  	if (io->read_watch == 0)
>  		return false;
>  
> @@ -218,7 +222,7 @@ static gboolean write_callback(GIOChannel *channel, GIOCondition cond,
>  	struct io *io = user_data;
>  	bool result;
>  
> -	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
> +	if (cond & (G_IO_ERR | G_IO_NVAL))
>  		return FALSE;
>  
>  	if (io->write_callback)
> @@ -244,9 +248,9 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
>  		goto done;
>  
>  	io->write_watch = g_io_add_watch_full(io->channel, G_PRIORITY_DEFAULT,
> -				G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> -				write_callback, io_ref(io),
> -				write_watch_destroy);
> +						G_IO_OUT | G_IO_ERR | G_IO_NVAL,
> +						write_callback, io_ref(io),
> +						write_watch_destroy);
>  	if (io->write_watch == 0)
>  		return false;
>  
> @@ -258,8 +262,62 @@ done:
>  	return true;
>  }
>  
> +static void disconnect_watch_destroy(gpointer user_data)
> +{
> +	struct io *io = user_data;
> +
> +	if (io->disconnect_destroy)
> +		io->disconnect_destroy(io->disconnect_data);
> +
> +	io->disconnect_watch = 0;
> +	io->disconnect_callback = NULL;
> +	io->disconnect_destroy = NULL;
> +	io->disconnect_data = NULL;
> +
> +	io_unref(io);
> +}
> +
> +static gboolean disconnect_callback(GIOChannel *channel, GIOCondition cond,
> +							gpointer user_data)
> +{
> +	struct io *io = user_data;
> +	bool result;
> +
> +	if (io->disconnect_callback)
> +		result = io->disconnect_callback(io, io->disconnect_data);
> +	else
> +		result = false;
> +
> +	return result ? TRUE : FALSE;
> +}
> +
>  bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
>  				void *user_data, io_destroy_func_t destroy)
>  {
> -	return false;
> +	if (!io)
> +		return false;
> +
> +	if (io->disconnect_watch > 0) {
> +		g_source_remove(io->disconnect_watch);
> +		io->disconnect_watch = 0;
> +	}
> +
> +	if (!callback)
> +		goto done;
> +
> +	io->disconnect_watch = g_io_add_watch_full(io->channel,
> +						G_PRIORITY_DEFAULT,
> +						G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +						disconnect_callback, io_ref(io),
> +						disconnect_watch_destroy);
> +	if (io->disconnect_watch == 0)
> +		return false;
> +
> +	io->disconnect_destroy = destroy;
> +	io->disconnect_data = user_data;
> +
> +done:
> +	io->disconnect_callback = callback;
> +
> +	return true;
>  }
> 

This is now applied.

-- 
Best regards, 
Szymon Janc
