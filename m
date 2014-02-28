Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCHv2 2/8] shared/hfp: Add prefix handlers functionality
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393494006-20363-3-git-send-email-marcin.kraglak@tieto.com>
Date: Thu, 27 Feb 2014 23:06:48 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <97847860-E690-4FC9-A631-16A0E4CE8486@holtmann.org>
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com> <1393494006-20363-3-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> Add two functions: hfp_gw_set_prefix_handler() and
> hfp_gw_remove_prefix_handler(). It will allow user to register for
> specific command. Current implementation just adds or removes data
> from hfp_gw structure.
> ---
> Makefile.tools   |  1 +
> src/shared/hfp.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> src/shared/hfp.h | 17 ++++++++++++
> 3 files changed, 102 insertions(+)
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index 9f7ba9f..31e1093 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -63,6 +63,7 @@ emulator_hfp_SOURCES = emulator/hfp.c \
> 				monitor/mainloop.h monitor/mainloop.c \
> 				src/shared/io.h src/shared/io-mainloop.c \
> 				src/shared/util.h src/shared/util.c \
> +				src/shared/queue.h src/shared/queue.c \
> 				src/shared/ringbuf.h src/shared/ringbuf.c \
> 				src/shared/hfp.h src/shared/hfp.c
> 
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index 0681b19..e164dd6 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -32,6 +32,7 @@
> 
> #include "src/shared/util.h"
> #include "src/shared/ringbuf.h"
> +#include "src/shared/queue.h"
> #include "src/shared/io.h"
> #include "src/shared/hfp.h"
> 
> @@ -42,6 +43,7 @@ struct hfp_gw {
> 	struct io *io;
> 	struct ringbuf *read_buf;
> 	struct ringbuf *write_buf;
> +	struct queue *prefix_handlers;
> 	bool writer_active;
> 	bool permissive_syntax;
> 	bool result_pending;
> @@ -60,6 +62,37 @@ struct hfp_gw {
> 	bool destroyed;
> };
> 
> +struct prefix_handler_data {
> +	char *prefix;
> +	void *user_data;
> +	hfp_destroy_func_t destroy;
> +	hfp_result_func_t callback;
> +};
> +
> +static void destroy_prefix_handler_data(void *data)
> +{
> +	struct prefix_handler_data *handler = data;
> +
> +	if (handler->destroy)
> +		handler->destroy(handler->user_data);
> +
> +	free(handler);
> +}
> +
> +static bool match_handler_prefix(const void *a, const void *b)
> +{
> +	const struct prefix_handler_data *handler = a;
> +	const char *prefix = b;
> +
> +	if (strlen(handler->prefix) != strlen(prefix))
> +		return false;
> +
> +	if (memcmp(handler->prefix, prefix, strlen(prefix)))
> +		return false;
> +
> +	return true;
> +}
> +
> static void write_watch_destroy(void *user_data)
> {
> 	struct hfp_gw *hfp = user_data;
> @@ -194,8 +227,19 @@ struct hfp_gw *hfp_gw_new(int fd)
> 		return NULL;
> 	}
> 
> +	hfp->prefix_handlers = queue_new();
> +	if (!hfp->prefix_handlers) {
> +		io_destroy(hfp->io);
> +		ringbuf_free(hfp->write_buf);
> +		ringbuf_free(hfp->read_buf);
> +		free(hfp);
> +		return NULL;
> +	}
> +
> 	if (!io_set_read_handler(hfp->io, can_read_data,
> 					hfp, read_watch_destroy)) {
> +		queue_destroy(hfp->prefix_handlers,
> +						destroy_prefix_handler_data);
> 		io_destroy(hfp->io);
> 		ringbuf_free(hfp->write_buf);
> 		ringbuf_free(hfp->read_buf);
> @@ -248,6 +292,9 @@ void hfp_gw_unref(struct hfp_gw *hfp)
> 	ringbuf_free(hfp->write_buf);
> 	hfp->write_buf = NULL;
> 
> +	queue_destroy(hfp->prefix_handlers, destroy_prefix_handler_data);
> +	hfp->prefix_handlers = NULL;
> +
> 	if (!hfp->in_disconnect) {
> 		free(hfp);
> 		return;
> @@ -407,6 +454,43 @@ bool hfp_gw_set_command_handler(struct hfp_gw *hfp,
> 	return true;
> }
> 
> +bool hfp_gw_set_prefix_handler(struct hfp_gw *hfp, hfp_result_func_t callback,
> +						char *prefix, void *user_data,
> +						hfp_destroy_func_t destroy)
> +{

it is either add and remove or register and unregister, but never set and remove. If you set something, the next call to set would overwrite it.

Regards

Marcel

