Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414490125-31339-2-git-send-email-marcin.kraglak@tieto.com>
References: <1414490125-31339-1-git-send-email-marcin.kraglak@tieto.com>
	<1414490125-31339-2-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 28 Oct 2014 13:41:05 +0200
Message-ID: <CABBYNZL+oWdW2FYGST5bO7=NiEu2DZWG-5UeT75XVDLeqKLdbw@mail.gmail.com>
Subject: Re: [PATCH 2/7] unit/test-gatt: Add search all primary services test case
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tue, Oct 28, 2014 at 11:55 AM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> ---
>  unit/test-gatt.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index bbbf9a5..57cb109 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -35,8 +35,10 @@
>
>  #include <glib.h>
>
> +#include "lib/uuid.h"
>  #include "src/shared/util.h"
>  #include "src/shared/att.h"
> +#include "src/shared/gatt-helpers.h"
>  #include "src/shared/gatt-client.h"
>
>  struct test_pdu {
> @@ -53,6 +55,7 @@ struct test_data {
>  struct context {
>         GMainLoop *main_loop;
>         struct bt_gatt_client *client;
> +       struct bt_att *att;
>         guint source;
>         guint process;
>         int fd;
> @@ -222,6 +225,53 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
>         return context;
>  }
>
> +static void primary_cb(bool success, uint8_t att_ecode,
> +                                               struct bt_gatt_result *result,
> +                                               void *user_data)
> +{
> +       struct context *context = user_data;
> +
> +       g_assert(success);
> +
> +       context_quit(context);
> +}
> +
> +static struct context *create_helpers_context(uint16_t mtu, gconstpointer data)
> +{
> +       struct context *context = g_new0(struct context, 1);
> +       GIOChannel *channel;
> +       int err, sv[2];
> +
> +       context->main_loop = g_main_loop_new(NULL, FALSE);
> +       g_assert(context->main_loop);
> +
> +       err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
> +       g_assert(err == 0);
> +
> +       context->att = bt_att_new(sv[0]);
> +       g_assert(context->att);
> +
> +       channel = g_io_channel_unix_new(sv[1]);
> +
> +       g_io_channel_set_close_on_unref(channel, TRUE);
> +       g_io_channel_set_encoding(channel, NULL, NULL);
> +       g_io_channel_set_buffered(channel, FALSE);
> +
> +       context->source = g_io_add_watch(channel,
> +                               G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +                               test_handler, context);
> +       g_assert(context->source > 0);
> +
> +       g_io_channel_unref(channel);
> +
> +       context->fd = sv[1];
> +       context->data = data;
> +
> +       bt_gatt_exchange_mtu(context->att, mtu, NULL, NULL, NULL);
> +
> +       return context;
> +}

Another function to create context? I looks awful similar to
create_context, perhaps you want a create_client_context and
create_server_context wrappers that calls create_context or even
better add a parameter to create_context to say what role we will act.

>  static void destroy_context(struct context *context)
>  {
>         if (context->source > 0)
> @@ -229,6 +279,8 @@ static void destroy_context(struct context *context)
>
>         bt_gatt_client_unref(context->client);
>
> +       bt_att_unref(context->att);
> +
>         g_main_loop_unref(context->main_loop);
>
>         test_free(context->data);
> @@ -249,6 +301,16 @@ static void test_client(gconstpointer data)
>         execute_context(context);
>  }
>
> +static void test_search_primary(gconstpointer data)
> +{
> +       struct context *context = create_helpers_context(512, data);
> +
> +       bt_gatt_discover_all_primary_services(context->att, NULL, primary_cb,
> +                                                               context, NULL);
> +
> +       execute_context(context);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         g_test_init(&argc, &argv, NULL);
> @@ -262,5 +324,21 @@ int main(int argc, char *argv[])
>         define_test("/TP/GAC/CL/BV-01-C", test_client,
>                                 raw_pdu(0x02, 0x00, 0x02));
>
> +       /* Discover All Primary Services */
> +       define_test("/TP/GAD/CL/BV-01-C", test_search_primary,
> +                       raw_pdu(0x02, 0x00, 0x02),
> +                       raw_pdu(0x03, 0x00, 0x02),
> +                       raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
> +                       raw_pdu(0x11, 0x06, 0x10, 0x00, 0x13, 0x00, 0x00, 0x18,
> +                                       0x20, 0x00, 0x29, 0x00, 0xb0, 0x68,
> +                                       0x30, 0x00, 0x32, 0x00, 0x19, 0x18),
> +                       raw_pdu(0x10, 0x33, 0x00, 0xff, 0xff, 0x00, 0x28),
> +                       raw_pdu(0x11, 0x14, 0x90, 0x00, 0x96, 0x00, 0xef, 0xcd,
> +                                       0xab, 0x89, 0x67, 0x45, 0x23, 0x01,
> +                                       0x00, 0x00, 0x00, 0x00, 0x85, 0x60,
> +                                       0x00, 0x00),
> +                       raw_pdu(0x10, 0x97, 0x00, 0xff, 0xff, 0x00, 0x28),
> +                       raw_pdu(0x01, 0x10, 0x97, 0x00, 0x0a));
> +
>         return g_test_run();
>  }
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
