Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/6] shared: Add support for disonnect handler to GLib based IO handling
Date: Wed, 12 Feb 2014 19:42:09 +0100
Message-ID: <1410905.4MB1ZWjKzY@leonov>
In-Reply-To: <D4957F12-AE54-43F2-A9EE-859676DE055E@holtmann.org>
References: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com> <D4957F12-AE54-43F2-A9EE-859676DE055E@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tuesday 11 of February 2014 08:57:25 Marcel Holtmann wrote:
> Hi Szymon,
> 
> > ---
> > src/shared/io-glib.c | 59
> > +++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed, 58
> > insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> > index 77ba19e..a4f982d 100644
> > --- a/src/shared/io-glib.c
> > +++ b/src/shared/io-glib.c
> > @@ -40,6 +40,10 @@ struct io {
> > 
> > 	io_callback_func_t write_callback;
> > 	io_destroy_func_t write_destroy;
> > 	void *write_data;
> > 
> > +	guint disconnect_watch;
> > +	io_callback_func_t disconnect_callback;
> > +	io_destroy_func_t disconnect_destroy;
> > +	void *disconnect_data;
> > };
> > 
> > static struct io *io_ref(struct io *io)
> > 
> > @@ -258,8 +262,61 @@ done:
> > 	return true;
> > 
> > }
> > 
> > +static void disconnect_watch_destroy(gpointer user_data)
> > +{
> > +	struct io *io = user_data;
> > +
> > +	if (io->disconnect_destroy)
> > +		io->disconnect_destroy(io->disconnect_data);
> > +
> > +	io->disconnect_watch = 0;
> > +	io->disconnect_callback = NULL;
> > +	io->disconnect_destroy = NULL;
> > +	io->disconnect_data = NULL;
> > +
> > +	io_unref(io);
> > +}
> > +
> > +static gboolean disconnect_callback(GIOChannel *channel, GIOCondition
> > cond, +							gpointer user_data)
> > +{
> > +	struct io *io = user_data;
> > +	bool result;
> > +
> > +	if (io->disconnect_callback)
> > +		result = io->disconnect_callback(io, io->disconnect_data);
> > +	else
> > +		result = false;
> > +
> > +	return result ? TRUE : FALSE;
> > +}
> > +
> > bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
> > 
> > 				void *user_data, io_destroy_func_t destroy)
> > 
> > {
> > -	return false;
> > +	if (!io)
> > +		return false;
> > +
> > +	if (io->disconnect_watch > 0) {
> > +		g_source_remove(io->disconnect_watch);
> > +		io->disconnect_watch = 0;
> > +	}
> > +
> > +	if (!callback)
> > +		goto done;
> > +
> > +	io->disconnect_watch = g_io_add_watch_full(io->channel,
> > +				G_PRIORITY_DEFAULT,
> > +				G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> 
> If we are using G_IO_HUP here, we should remove it from the other callback
> handling?

We should, will fix that in next version.

> > +				disconnect_callback, io_ref(io),
> > +				disconnect_watch_destroy);
> > +	if (io->disconnect_watch == 0)
> > +		return false;
> > +
> > +	io->disconnect_destroy = destroy;
> > +	io->disconnect_data = user_data;
> 
> we normally have an extra empty line here. You might also fix the previous
> patch then.

I'll fix that as well.

> > +done:
> > +	io->disconnect_callback = callback;
> > +
> > +	return true;
> > }

-- 
BR
Szymon Janc
