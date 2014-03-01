Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 1/6] shared/hfp: Add prefix handlers functionality
Date: Sat, 01 Mar 2014 21:37:12 +0100
Message-ID: <2778228.8L27g4k6zG@leonov>
In-Reply-To: <1393704046-4317-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393704046-4317-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Saturday 01 of March 2014 21:00:41 Marcin Kraglak wrote:
> Add two functions: hfp_gw_register_prefix_handler() and
> hfp_gw_unregister_prefix_handler(). It will allow user to register for
> specific command. Current implementation just put/remove handler data
> from queue.
> ---
>  Makefile.tools   |  1 +
>  src/shared/hfp.c | 99
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ src/shared/hfp.h |
> 18 +++++++++++
>  3 files changed, 118 insertions(+)
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index 9f7ba9f..31e1093 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -63,6 +63,7 @@ emulator_hfp_SOURCES = emulator/hfp.c \
>  				monitor/mainloop.h monitor/mainloop.c \
>  				src/shared/io.h src/shared/io-mainloop.c \
>  				src/shared/util.h src/shared/util.c \
> +				src/shared/queue.h src/shared/queue.c \
>  				src/shared/ringbuf.h src/shared/ringbuf.c \
>  				src/shared/hfp.h src/shared/hfp.c
> 
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index 854cf46..4bf993d 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -32,6 +32,7 @@
> 
>  #include "src/shared/util.h"
>  #include "src/shared/ringbuf.h"
> +#include "src/shared/queue.h"
>  #include "src/shared/io.h"
>  #include "src/shared/hfp.h"
> 
> @@ -42,6 +43,7 @@ struct hfp_gw {
>  	struct io *io;
>  	struct ringbuf *read_buf;
>  	struct ringbuf *write_buf;
> +	struct queue *cmd_handlers;
>  	bool writer_active;
>  	bool permissive_syntax;
>  	bool result_pending;
> @@ -60,6 +62,37 @@ struct hfp_gw {
>  	bool destroyed;
>  };
> 
> +struct cmd_handler {
> +	char *prefix;
> +	void *user_data;
> +	hfp_destroy_func_t destroy;
> +	hfp_result_func_t callback;
> +};
> +
> +static void destroy_cmd_handler(void *data)
> +{
> +	struct cmd_handler *handler = data;
> +
> +	if (handler->destroy)
> +		handler->destroy(handler->user_data);
> +
> +	free(handler);
> +}
> +
> +static bool match_handler_prefix(const void *a, const void *b)
> +{
> +	const struct cmd_handler *handler = a;
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
>  static void write_watch_destroy(void *user_data)
>  {
>  	struct hfp_gw *hfp = user_data;
> @@ -196,8 +229,19 @@ struct hfp_gw *hfp_gw_new(int fd)
>  		return NULL;
>  	}
> 
> +	hfp->cmd_handlers = queue_new();
> +	if (!hfp->cmd_handlers) {
> +		io_destroy(hfp->io);
> +		ringbuf_free(hfp->write_buf);
> +		ringbuf_free(hfp->read_buf);
> +		free(hfp);
> +		return NULL;
> +	}
> +
>  	if (!io_set_read_handler(hfp->io, can_read_data,
>  					hfp, read_watch_destroy)) {
> +		queue_destroy(hfp->cmd_handlers,
> +						destroy_cmd_handler);
>  		io_destroy(hfp->io);
>  		ringbuf_free(hfp->write_buf);
>  		ringbuf_free(hfp->read_buf);
> @@ -250,6 +294,9 @@ void hfp_gw_unref(struct hfp_gw *hfp)
>  	ringbuf_free(hfp->write_buf);
>  	hfp->write_buf = NULL;
> 
> +	queue_destroy(hfp->cmd_handlers, destroy_cmd_handler);
> +	hfp->cmd_handlers = NULL;
> +
>  	if (!hfp->in_disconnect) {
>  		free(hfp);
>  		return;
> @@ -405,6 +452,58 @@ bool hfp_gw_set_command_handler(struct hfp_gw *hfp,
>  	return true;
>  }
> 
> +bool hfp_gw_register(struct hfp_gw *hfp, hfp_result_func_t callback,
> +						const char *prefix,
> +						void *user_data,
> +						hfp_destroy_func_t destroy)
> +{
> +	struct cmd_handler *handler;
> +
> +	handler = new0(struct cmd_handler, 1);
> +	if (!handler)
> +		return false;
> +
> +	handler->callback = callback;
> +	handler->user_data = user_data;
> +
> +	handler->prefix = strdup(prefix);
> +	if (!handler->prefix) {
> +		free(handler);
> +		return false;
> +	}
> +
> +	if (queue_find(hfp->cmd_handlers, match_handler_prefix,
> +							handler->prefix)) {
> +		destroy_cmd_handler(handler);
> +		return false;
> +	}
> +
> +	handler->destroy = destroy;
> +
> +	return queue_push_tail(hfp->cmd_handlers, handler);
> +}
> +
> +bool hfp_gw_unregister(struct hfp_gw *hfp, const char *prefix)
> +{
> +	struct cmd_handler *handler;
> +	char *lookup_prefix;
> +
> +	lookup_prefix = strdup(prefix);
> +	if (!lookup_prefix)
> +		return false;
> +
> +	handler = queue_remove_if(hfp->cmd_handlers, match_handler_prefix,
> +								lookup_prefix);
> +	free(lookup_prefix);
> +
> +	if (!handler)
> +		return false;
> +
> +	destroy_cmd_handler(handler);
> +
> +	return true;
> +}
> +
>  static void disconnect_watch_destroy(void *user_data)
>  {
>  	struct hfp_gw *hfp = user_data;
> diff --git a/src/shared/hfp.h b/src/shared/hfp.h
> index b0bd934..0755a46 100644
> --- a/src/shared/hfp.h
> +++ b/src/shared/hfp.h
> @@ -60,6 +60,18 @@ enum hfp_error {
>  	HFP_ERROR_NETWORK_NOT_ALLOWED		= 32,
>  };
> 
> +enum hfp_gw_cmd_type {
> +	HFP_GW_CMD_TYPE_READ,
> +	HFP_GW_CMD_TYPE_SET,
> +	HFP_GW_CMD_TYPE_TEST,
> +	HFP_GW_CMD_TYPE_COMMAND
> +};
> +
> +struct hfp_gw_result;
> +
> +typedef void (*hfp_result_func_t)(struct hfp_gw_result *result,
> +				enum hfp_gw_cmd_type type, void *user_data);
> +
>  typedef void (*hfp_destroy_func_t)(void *user_data);
>  typedef void (*hfp_debug_func_t)(const char *str, void *user_data);
> 
> @@ -94,3 +106,9 @@ bool hfp_gw_set_disconnect_handler(struct hfp_gw *hfp,
>  					hfp_destroy_func_t destroy);
> 
>  bool hfp_gw_disconnect(struct hfp_gw *hfp);
> +
> +bool hfp_gw_register(struct hfp_gw *hfp, hfp_result_func_t callback,
> +						const char *prefix,
> +						void *user_data,
> +						hfp_destroy_func_t destroy);
> +bool hfp_gw_unregister(struct hfp_gw *hfp, const char *prefix);

All patches in this set are now applied, thanks.

-- 
BR
Szymon Janc
