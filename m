Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414448041-27866-6-git-send-email-jamuraa@chromium.org>
References: <1414448041-27866-1-git-send-email-jamuraa@chromium.org>
	<1414448041-27866-6-git-send-email-jamuraa@chromium.org>
Date: Tue, 28 Oct 2014 10:47:48 +0200
Message-ID: <CABBYNZ+OrqBph_HgEpPxauujEtv67iaFLD2KiieQ7R30krjEgQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 05/10] Add unit tests for gattrib
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Tue, Oct 28, 2014 at 12:13 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> This will ensure that the API behavior of gattrib is preserved.
> ---
>  .gitignore          |   1 +
>  Makefile.am         |   7 ++
>  unit/test-gattrib.c | 350 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 358 insertions(+)
>  create mode 100644 unit/test-gattrib.c
>
> diff --git a/.gitignore b/.gitignore
> index 97daa9f..164cc97 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -121,6 +121,7 @@ unit/test-avdtp
>  unit/test-avctp
>  unit/test-avrcp
>  unit/test-gatt
> +unit/test-gattrib
>  unit/test-*.log
>  unit/test-*.trs
>
> diff --git a/Makefile.am b/Makefile.am
> index 2dfea28..3fddb80 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -377,6 +377,13 @@ unit_test_gatt_SOURCES = unit/test-gatt.c
>  unit_test_gatt_LDADD = src/libshared-glib.la \
>                                 lib/libbluetooth-internal.la @GLIB_LIBS@
>
> +unit_tests += unit/test-gattrib
> +
> +unit_test_gattrib_SOURCES = unit/test-gattrib.c attrib/gattrib.c $(btio_sources) src/log.h src/log.c
> +unit_test_gattrib_LDADD = lib/libbluetooth-internal.la \
> +                       src/libshared-glib.la \
> +                       @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
> +
>  if MAINTAINER_MODE
>  noinst_PROGRAMS += $(unit_tests)
>  endif
> diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
> new file mode 100644
> index 0000000..23a5485
> --- /dev/null
> +++ b/unit/test-gattrib.c
> @@ -0,0 +1,350 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Google, Inc.
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
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <inttypes.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <sys/socket.h>
> +
> +#include <glib.h>
> +
> +#include "src/shared/util.h"
> +#include "lib/uuid.h"
> +#include "attrib/att.h"
> +#include "attrib/gattrib.h"
> +#include "src/log.h"
> +
> +#define DEFAULT_MTU 23
> +
> +#define data(args...) ((const unsigned char[]) { args })
> +
> +struct context {
> +       GMainLoop *main_loop;
> +       GIOChannel *att_io;
> +       GIOChannel *server_io;
> +       GAttrib *att;
> +};
> +
> +static void setup_context(struct context *cxt, gconstpointer data)
> +{
> +       int err, sv[2];
> +
> +       cxt->main_loop = g_main_loop_new(NULL, FALSE);
> +       g_assert(cxt->main_loop != NULL);
> +
> +       err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
> +       g_assert(err == 0);
> +
> +       cxt->att_io = g_io_channel_unix_new(sv[0]);
> +       g_assert(cxt->att_io != NULL);
> +
> +       g_io_channel_set_close_on_unref(cxt->att_io, TRUE);
> +
> +       cxt->server_io = g_io_channel_unix_new(sv[1]);
> +       g_assert(cxt->server_io != NULL);
> +
> +       g_io_channel_set_close_on_unref(cxt->server_io, TRUE);
> +       g_io_channel_set_encoding(cxt->server_io, NULL, NULL);
> +       g_io_channel_set_buffered(cxt->server_io, FALSE);
> +
> +       cxt->att = g_attrib_new(cxt->att_io, DEFAULT_MTU);
> +       g_assert(cxt->att != NULL);
> +}
> +
> +static void teardown_context(struct context *cxt, gconstpointer data)
> +{
> +       if (cxt->att)
> +               g_attrib_unref(cxt->att);
> +
> +       g_io_channel_unref(cxt->server_io);
> +
> +       g_io_channel_unref(cxt->att_io);
> +
> +       g_main_loop_unref(cxt->main_loop);
> +}
> +
> +
> +static void test_debug(const char *str, void *user_data)
> +{
> +       const char *prefix = user_data;
> +
> +       g_print("%s%s\n", prefix, str);
> +}
> +
> +static void destroy_canary_increment(gpointer data)
> +{
> +       int *canary = data;
> +       (*canary)++;
> +}
> +
> +static void test_refcount(struct context *cxt, gconstpointer unused)
> +{
> +       GAttrib *extra_ref;
> +       int destroy_canary;
> +
> +       g_attrib_set_destroy_function(cxt->att, destroy_canary_increment,
> +                                                              &destroy_canary);
> +
> +       extra_ref = g_attrib_ref(cxt->att);
> +
> +       g_assert(extra_ref == cxt->att);
> +
> +       g_assert(destroy_canary == 0);
> +
> +       g_attrib_unref(extra_ref);
> +
> +       g_assert(destroy_canary == 0);
> +
> +       g_attrib_unref(cxt->att);
> +
> +       g_assert(destroy_canary == 1);
> +
> +       /* Avoid a double-free from the teardown function */
> +       cxt->att = NULL;
> +}
> +
> +static void test_get_channel(struct context *cxt, gconstpointer unused)
> +{
> +       GIOChannel *chan;
> +
> +       chan = g_attrib_get_channel(cxt->att);
> +
> +       g_assert(chan == cxt->att_io);
> +}
> +
> +struct challenge_response {
> +       const uint8_t *expect;
> +       const size_t expect_len;
> +       const uint8_t *respond;
> +       const size_t respond_len;
> +       bool received;
> +};
> +
> +static gboolean test_client(GIOChannel *channel, GIOCondition cond,
> +                                                                 gpointer data)
> +{
> +       struct challenge_response *cr = data;
> +       int fd;
> +       uint8_t buf[256];
> +       ssize_t len;
> +
> +       if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
> +               return FALSE;
> +       }
> +
> +       fd = g_io_channel_unix_get_fd(channel);
> +
> +       len = read(fd, buf, sizeof(buf));
> +
> +       g_assert(len > 0);
> +       g_assert_cmpint(len, ==, cr->expect_len);
> +
> +       if (g_test_verbose())
> +               util_hexdump('>', buf, len, test_debug, "test_client: ");
> +
> +       cr->received = true;
> +
> +       if (cr->respond != NULL) {
> +               if (g_test_verbose())
> +                       util_hexdump('<', cr->respond, cr->respond_len,
> +                                                  test_debug, "test_client: ");
> +               len = write(fd, cr->respond, cr->respond_len);
> +
> +               g_assert_cmpint(len, ==, cr->respond_len);
> +       }
> +
> +       return TRUE;
> +}
> +
> +struct result_data {
> +       guint8 status;
> +       const guint8 *pdu;
> +       guint16 len;
> +       bool done;
> +};
> +
> +static void result_canary(guint8 status, const guint8 *pdu, guint16 len,
> +                                                               gpointer data)
> +{
> +       struct result_data *result = data;
> +       result->status = status;
> +       result->pdu = pdu;
> +       result->len = len;
> +
> +       if (g_test_verbose())
> +               util_hexdump('<', pdu, len, test_debug, "result_canary: ");
> +
> +       result->done = true;
> +}
> +
> +static void test_send(struct context *cxt, gconstpointer unused)
> +{
> +       int cmp;
> +       struct result_data results;
> +       struct challenge_response data = {
> +               .expect = data(0x02, 0x00, 0x02),
> +               .expect_len = 3,
> +               .respond = data(0x01, 0x02, 0x03, 0x04),
> +               .respond_len = 4,
> +               .received = false,
> +       };
> +
> +       g_io_add_watch(cxt->server_io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +                                                           test_client, &data);
> +
> +       results.done = false;
> +
> +       g_attrib_send(cxt->att, 0, data.expect, data.expect_len, result_canary,
> +                                                    (gpointer) &results, NULL);
> +
> +       /* Spin the main loop until we are ready. */
> +       do {
> +               g_main_context_iteration(NULL, TRUE);
> +       } while (!results.done);

I do not understand why you have to manually iterate here? Im fact
none of our unit tests uses g_main_context_iteration.

> +       g_assert_cmpint(results.len, ==, data.respond_len);
> +
> +       cmp = memcmp(results.pdu, data.respond, results.len);
> +
> +       g_assert(cmp == 0);
> +}
> +
> +static void test_cancel(struct context *cxt, gconstpointer unused)
> +{
> +       guint event_id;
> +       gboolean canceled;
> +       struct result_data results;
> +       struct challenge_response data = {
> +               .expect = data(0x02, 0x00, 0x02),
> +               .expect_len = 3,
> +               .respond = data(0x01, 0x02, 0x03, 0x04),
> +               .respond_len = 4,
> +               .received = false,
> +       };
> +
> +       g_io_add_watch(cxt->server_io,
> +                                     G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +                                                           test_client, &data);
> +
> +       results.done = false;
> +       event_id = g_attrib_send(cxt->att, 0, data.expect, data.expect_len,
> +                                                result_canary, &results, NULL);
> +
> +       /* Spin the main loop until we receive the first message */
> +       do {
> +               g_main_context_iteration(NULL, FALSE);
> +       } while (!data.received);
> +
> +       canceled = g_attrib_cancel(cxt->att, event_id);
> +       g_assert(canceled);
> +
> +       /*
> +        * Spin the main loop until all events are processed,
> +        * no result should be called because it was cancelled */
> +       do {
> +               g_main_context_iteration(NULL, TRUE);
> +       } while (g_main_context_pending(NULL));
> +
> +       g_assert(!results.done);
> +
> +       results.done = false;
> +       data.received = false;
> +       event_id = g_attrib_send(cxt->att, 0, data.expect, data.expect_len,
> +                                                result_canary, &results, NULL);
> +
> +       canceled = g_attrib_cancel(cxt->att, event_id);
> +       g_assert(canceled);
> +
> +       /*
> +        * Spin the main loop until all events are processed,
> +        * the message should never be delivered.
> +        */
> +       do {
> +               g_main_context_iteration(NULL, TRUE);
> +       } while (g_main_context_pending(NULL));
> +
> +       g_assert(!data.received);
> +       g_assert(!results.done);
> +
> +       /* Invalid ID */
> +       canceled = g_attrib_cancel(cxt->att, 42);
> +       g_assert(!canceled);
> +}
> +
> +static void test_register(struct context *cxt, gconstpointer user_data)
> +{
> +       /* TODO */
> +}
> +
> +static void test_buffers(struct context *cxt, gconstpointer unused)
> +{
> +       size_t buflen;
> +       uint8_t *buf;
> +       gboolean success;
> +
> +       buf = g_attrib_get_buffer(cxt->att, &buflen);
> +       g_assert(buf != 0);
> +       g_assert_cmpint(buflen, ==, DEFAULT_MTU);
> +
> +       success = g_attrib_set_mtu(cxt->att, 5);
> +       g_assert(!success);
> +
> +       success = g_attrib_set_mtu(cxt->att, 255);
> +       g_assert(success);
> +
> +       buf = g_attrib_get_buffer(cxt->att, &buflen);
> +       g_assert(buf != 0);
> +       g_assert_cmpint(buflen, ==, 255);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       g_test_init(&argc, &argv, NULL);
> +
> +       __btd_log_init("*", 0);

Init the log only in case of g_test_verbose is true.

> +       /*
> +        * Test the GAttrib API behavior
> +        */
> +       g_test_add("/gattrib/refcount", struct context, NULL, setup_context,
> +                                             test_refcount, teardown_context);
> +       g_test_add("/gattrib/get_channel", struct context, NULL, setup_context,
> +                                           test_get_channel, teardown_context);
> +       g_test_add("/gattrib/send", struct context, NULL, setup_context,
> +                                                  test_send, teardown_context);
> +       g_test_add("/gattrib/cancel", struct context, NULL, setup_context,
> +                                                test_cancel, teardown_context);
> +       g_test_add("/gattrib/register", struct context, NULL, setup_context,
> +                                              test_register, teardown_context);
> +       g_test_add("/gattrib/buffers", struct context, NULL, setup_context,
> +                                               test_buffers, teardown_context);

Overall I think using define_test such as in unit/test-gatt produces
less code and is a little bit simpler to maintain, perhaps we should
make the context a bit more generic so new unit test can just provide
their own data but all the pdu handling is done in common place e.g.
unit/test{.c,.h} which later make easier to port to something else
other than glib.


-- 
Luiz Augusto von Dentz
