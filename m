Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 4/6] shared: Add support for shutdown to IO
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392137346-26272-4-git-send-email-szymon.janc@tieto.com>
Date: Tue, 11 Feb 2014 09:02:15 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <301FB290-56A1-404A-9A79-62F360D9DA9A@holtmann.org>
References: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com> <1392137346-26272-4-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This allows to locally shutdown IO.
> ---
> src/shared/io-glib.c     | 9 +++++++++
> src/shared/io-mainloop.c | 9 +++++++++
> src/shared/io.h          | 2 ++
> 3 files changed, 20 insertions(+)
> 
> diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> index a4f982d..8290745 100644
> --- a/src/shared/io-glib.c
> +++ b/src/shared/io-glib.c
> @@ -320,3 +320,12 @@ done:
> 
> 	return true;
> }
> +
> +bool io_shutdown(struct io *io)
> +{
> +	if (!io || !io->channel)
> +		return false;
> +
> +	return g_io_channel_shutdown(io->channel, TRUE, NULL)
> +							== G_IO_STATUS_NORMAL;
> +}
> diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
> index 14ab128..f1e3b3b 100644
> --- a/src/shared/io-mainloop.c
> +++ b/src/shared/io-mainloop.c
> @@ -26,6 +26,7 @@
> #endif
> 
> #include <unistd.h>
> +#include <sys/socket.h>
> 
> #include "monitor/mainloop.h"
> #include "src/shared/util.h"
> @@ -294,3 +295,11 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
> 
> 	return true;
> }
> +
> +bool io_shutdown(struct io *io)
> +{
> +	if (!io || io->fd < 0)
> +		return false;
> +
> +	return shutdown(io->fd, SHUT_RDWR) == 0;
> +}

I have no problem doing this, but why is this actually needed? Is not closing the socket good enough? Or would be better also add a shutdown_on_unref option?

Regards

Marcel

