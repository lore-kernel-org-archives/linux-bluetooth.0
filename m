Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 02/10] unit/test-att: Add unit tests for src/shared/att.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400271298-29769-3-git-send-email-armansito@chromium.org>
Date: Sat, 24 May 2014 23:03:33 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A8F91314-BB19-4458-9620-A2CF8354D326@holtmann.org>
References: <1400271298-29769-1-git-send-email-armansito@chromium.org> <1400271298-29769-3-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch introduces unit tests for src/shared/att. The code currently
> only tests locally initiated requests and responses.
> ---
> Makefile.am     |   9 ++
> unit/test-att.c | 308 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 317 insertions(+)
> create mode 100644 unit/test-att.c
> 
> diff --git a/Makefile.am b/Makefile.am
> index 0c3424f..04be6c4 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -262,6 +262,15 @@ unit_test_mgmt_SOURCES = unit/test-mgmt.c \
> 				src/shared/mgmt.h src/shared/mgmt.c
> unit_test_mgmt_LDADD = @GLIB_LIBS@
> 
> +unit_tests += unit/test-att
> +
> +unit_test_att_SOURCES = unit/test-att.c \
> +				src/shared/io.h src/shared/io-glib.c \
> +				src/shared/queue.h src/shared/queue.c \
> +				src/shared/util.h src/shared/util.c \
> +				src/shared/att.h src/shared/att.c
> +unit_test_att_LDADD = @GLIB_LIBS@
> +
> unit_tests += unit/test-sdp
> 
> unit_test_sdp_SOURCES = unit/test-sdp.c \
> diff --git a/unit/test-att.c b/unit/test-att.c
> new file mode 100644
> index 0000000..9d631fb
> --- /dev/null
> +++ b/unit/test-att.c
> @@ -0,0 +1,308 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Google Inc.
> + *  Copyright (C) 2014  Intel Corporation.
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +
> +#include <glib.h>
> +
> +#include "src/shared/att.h"
> +
> +struct context {
> +	GMainLoop *main_loop;
> +	struct bt_att *att_client;
> +	guint server_source;
> +	GList *handler_list;
> +};
> +
> +enum action {
> +	ACTION_PASSED,
> +	ACTION_IGNORE,
> +};
> +
> +struct handler {
> +	const void *req_data;
> +	uint16_t req_size;
> +	const void *resp_data;
> +	uint16_t resp_size;
> +	enum action action;
> +};
> +
> +static void att_debug(const char *str, void *user_data)
> +{
> +	const char *prefix = user_data;
> +
> +	g_printf("%s%s\n", prefix, str);
> +}
> +
> +static void context_quit(struct context *context)
> +{
> +	g_main_loop_quit(context->main_loop);
> +}
> +
> +static void check_actions(struct context *context, int server_socket,
> +					const void *data, uint16_t size)
> +{
> +	GList *list;
> +	ssize_t written;
> +
> +	for (list = g_list_first(context->handler_list); list;
> +						list = g_list_next(list)) {
> +		struct handler *handler = list->data;
> +
> +		if (size != handler->req_size)
> +			continue;
> +
> +		if (memcmp(data, handler->req_data, handler->req_size))
> +			continue;
> +
> +		switch (handler->action) {
> +		case ACTION_PASSED:
> +			if (!handler->resp_data || !handler->resp_size) {
> +				context_quit(context);
> +				return;
> +			}
> +
> +			/* Test case involves a response. */
> +			written = write(server_socket, handler->resp_data,
> +							handler->resp_size);
> +			g_assert(written == handler->resp_size);
> +			return;
> +		case ACTION_IGNORE:
> +			return;
> +		}
> +	}
> +
> +	g_test_message("Request not handled\n");
> +	g_assert_not_reached();
> +}
> +
> +static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
> +							gpointer user_data)
> +{
> +	struct context *context = user_data;
> +	unsigned char buf[512];
> +	ssize_t result;
> +	int fd;
> +
> +	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
> +		return FALSE;
> +
> +	fd = g_io_channel_unix_get_fd(channel);
> +
> +	result = read(fd, buf, sizeof(buf));
> +	if (result < 0)
> +		return FALSE;
> +
> +	check_actions(context, fd, buf, result);
> +
> +	return TRUE;
> +}
> +
> +static struct context *create_context(void)
> +{
> +	struct context *context = g_new0(struct context, 1);
> +	GIOChannel *channel;
> +	int err, sv[2];
> +
> +	context->main_loop = g_main_loop_new(NULL, FALSE);
> +	g_assert(context->main_loop);
> +
> +	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
> +	g_assert(err == 0);
> +
> +	channel = g_io_channel_unix_new(sv[0]);
> +
> +	g_io_channel_set_close_on_unref(channel, TRUE);
> +	g_io_channel_set_encoding(channel, NULL, NULL);
> +	g_io_channel_set_buffered(channel, FALSE);
> +
> +	context->server_source = g_io_add_watch(channel,
> +				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +				server_handler, context);
> +	g_assert(context->server_source > 0);
> +
> +	g_io_channel_unref(channel);

please target struct io as wrapper for IO handling. Long term we want to get rid of GIOChannel and GLib.

Regards

Marcel

