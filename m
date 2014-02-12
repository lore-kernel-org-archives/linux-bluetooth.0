Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 4/6] shared: Add support for shutdown to IO
Date: Wed, 12 Feb 2014 19:38:10 +0100
Message-ID: <4170119.cK3WpejJYp@leonov>
In-Reply-To: <301FB290-56A1-404A-9A79-62F360D9DA9A@holtmann.org>
References: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com> <1392137346-26272-4-git-send-email-szymon.janc@tieto.com> <301FB290-56A1-404A-9A79-62F360D9DA9A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tuesday 11 of February 2014 09:02:15 Marcel Holtmann wrote:
> Hi Szymon,
> 
> > This allows to locally shutdown IO.
> > ---
> > src/shared/io-glib.c     | 9 +++++++++
> > src/shared/io-mainloop.c | 9 +++++++++
> > src/shared/io.h          | 2 ++
> > 3 files changed, 20 insertions(+)
> > 
> > diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> > index a4f982d..8290745 100644
> > --- a/src/shared/io-glib.c
> > +++ b/src/shared/io-glib.c
> > 
> > @@ -320,3 +320,12 @@ done:
> > 	return true;
> > 
> > }
> > +
> > +bool io_shutdown(struct io *io)
> > +{
> > +	if (!io || !io->channel)
> > +		return false;
> > +
> > +	return g_io_channel_shutdown(io->channel, TRUE, NULL)
> > +							== G_IO_STATUS_NORMAL;
> > +}
> > diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
> > index 14ab128..f1e3b3b 100644
> > --- a/src/shared/io-mainloop.c
> > +++ b/src/shared/io-mainloop.c
> > @@ -26,6 +26,7 @@
> > #endif
> > 
> > #include <unistd.h>
> > +#include <sys/socket.h>
> > 
> > #include "monitor/mainloop.h"
> > #include "src/shared/util.h"
> > @@ -294,3 +295,11 @@ bool io_set_disconnect_handler(struct io *io,
> > io_callback_func_t callback,> 
> > 	return true;
> > 
> > }
> > +
> > +bool io_shutdown(struct io *io)
> > +{
> > +	if (!io || io->fd < 0)
> > +		return false;
> > +
> > +	return shutdown(io->fd, SHUT_RDWR) == 0;
> > +}
> 
> I have no problem doing this, but why is this actually needed? Is not
> closing the socket good enough? Or would be better also add a
> shutdown_on_unref option?

This is to allow to read from the socket in case there is some data already 
received (FWIW). I also plan to add 'flush' or similar flag to it to allow 
graceful disconnect i.e. make something like this work as expected

hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
hfp_gw_disconnect(device.gw);

but this can be added later on if needed and we could go with close() for now 
as you suggested.

-- 
BR
Szymon Janc
