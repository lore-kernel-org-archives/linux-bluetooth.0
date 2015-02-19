Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424338913-30942-1-git-send-email-luiz.dentz@gmail.com>
References: <1424338913-30942-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 19 Feb 2015 14:42:53 +0200
Message-ID: <CABBYNZLd3XhKwBTm9vKf1CC_JRqBwDw09hYrqmzfdn0HvKHEFw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] unit/test-gatt: Use tester framework
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 19, 2015 at 11:41 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Our tester framework actually produces much better output.
> ---
>  unit/test-gatt.c | 106 +++++++++++++++++++------------------------------------
>  1 file changed, 36 insertions(+), 70 deletions(-)
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 2be4c87..3ab5340 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -44,6 +44,7 @@
>  #include "src/shared/gatt-db.h"
>  #include "src/shared/gatt-server.h"
>  #include "src/shared/gatt-client.h"
> +#include "src/shared/tester.h"
>
>  struct test_pdu {
>         bool valid;
> @@ -67,7 +68,6 @@ struct test_data {
>  };
>
>  struct context {
> -       GMainLoop *main_loop;
>         struct bt_gatt_client *client;
>         struct bt_gatt_server *server;
>         struct bt_att *att;
> @@ -103,7 +103,7 @@ struct context {
>                 data.source_db = db;                                    \
>                 data.pdu_list = g_malloc(sizeof(pdus));                 \
>                 memcpy(data.pdu_list, pdus, sizeof(pdus));              \
> -               g_test_add_data_func(name, &data, function);            \
> +               tester_add(name, &data, NULL, function, NULL);          \
>         } while (0)
>
>  #define define_test_att(name, function, bt_uuid, test_step, args...)   \
> @@ -272,6 +272,23 @@ struct test_step {
>         uint16_t length;
>  };
>
> +static void destroy_context(struct context *context)
> +{
> +       if (context->source > 0)
> +               g_source_remove(context->source);
> +
> +       bt_gatt_client_unref(context->client);
> +       bt_gatt_server_unref(context->server);
> +       gatt_db_unref(context->client_db);
> +       gatt_db_unref(context->server_db);
> +
> +       if (context->att)
> +               bt_att_unref(context->att);
> +
> +       test_free(context->data);
> +       g_free(context);
> +}
> +
>  static gboolean context_quit(gpointer user_data)
>  {
>         struct context *context = user_data;
> @@ -280,11 +297,13 @@ static gboolean context_quit(gpointer user_data)
>         if (context->process > 0)
>                 g_source_remove(context->process);
>
> -       g_main_loop_quit(context->main_loop);
> -
>         if (step && step->post_func)
>                 step->post_func(context);
>
> +       destroy_context(context);
> +
> +       tester_test_passed();
> +
>         return FALSE;
>  }
>
> @@ -292,7 +311,7 @@ static void test_debug(const char *str, void *user_data)
>  {
>         const char *prefix = user_data;
>
> -       g_print("%s%s\n", prefix, str);
> +       tester_debug("%s%s", prefix, str);
>  }
>
>  static gboolean send_pdu(gpointer user_data)
> @@ -305,8 +324,7 @@ static gboolean send_pdu(gpointer user_data)
>
>         len = write(context->fd, pdu->data, pdu->size);
>
> -       if (g_test_verbose())
> -               util_hexdump('<', pdu->data, len, test_debug, "GATT: ");
> +       util_hexdump('<', pdu->data, len, test_debug, "GATT: ");
>
>         g_assert_cmpint(len, ==, pdu->size);
>
> @@ -314,8 +332,7 @@ static gboolean send_pdu(gpointer user_data)
>
>         pdu = &context->data->pdu_list[context->pdu_offset];
>         if (pdu->valid && (pdu->size == 0)) {
> -               if (g_test_verbose())
> -                       test_debug("(no action expected)", "GATT: ");
> +               test_debug("(no action expected)", "GATT: ");
>                 context->pdu_offset++;
>                 return send_pdu(context);
>         }
> @@ -358,8 +375,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
>
>         g_assert(len > 0);
>
> -       if (g_test_verbose())
> -               util_hexdump('>', buf, len, test_debug, "GATT: ");
> +       util_hexdump('>', buf, len, test_debug, "GATT: ");
>
>         g_assert_cmpint(len, ==, pdu->size);
>
> @@ -370,9 +386,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
>
>         if (pdu->valid && (pdu->size == 0)) {
>                 context->pdu_offset++;
> -               if (g_test_verbose())
> -                       test_debug("triggering server action",
> -                                                       "Empty client pdu: ");
> +               test_debug("triggering server action", "Empty client pdu: ");
>                 g_assert(step && step->func);
>                 step->func(context);
>                 return TRUE;
> @@ -387,7 +401,7 @@ static void print_debug(const char *str, void *user_data)
>  {
>         const char *prefix = user_data;
>
> -       g_print("%s%s\n", prefix, str);
> +       tester_debug("%s%s", prefix, str);
>  }
>
>  struct db_attribute_test_data {
> @@ -566,9 +580,6 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
>         int err, sv[2];
>         struct bt_att *att;
>
> -       context->main_loop = g_main_loop_new(NULL, FALSE);
> -       g_assert(context->main_loop);
> -
>         err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
>         g_assert(err == 0);
>
> @@ -579,9 +590,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
>         case ATT:
>                 context->att = att;
>
> -               if (g_test_verbose())
> -                       bt_att_set_debug(context->att, print_debug, "bt_att:",
> -                                                                       NULL);
> +               bt_att_set_debug(context->att, print_debug, "bt_att:", NULL);
>
>                 bt_gatt_exchange_mtu(context->att, mtu, NULL, NULL, NULL);
>                 break;
> @@ -593,8 +602,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
>                                                                         mtu);
>                 g_assert(context->server);
>
> -               if (g_test_verbose())
> -                       bt_gatt_server_set_debug(context->server, print_debug,
> +               bt_gatt_server_set_debug(context->server, print_debug,
>                                                 "bt_gatt_server:", NULL);
>                 bt_att_unref(att);
>                 break;
> @@ -606,8 +614,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
>                                                                         mtu);
>                 g_assert(context->client);
>
> -               if (g_test_verbose())
> -                       bt_gatt_client_set_debug(context->client, print_debug,
> +               bt_gatt_client_set_debug(context->client, print_debug,
>                                                 "bt_gatt_client:", NULL);
>
>                 bt_gatt_client_set_ready_handler(context->client,
> @@ -649,32 +656,6 @@ static void generic_search_cb(bool success, uint8_t att_ecode,
>         context_quit(context);
>  }
>
> -static void destroy_context(struct context *context)
> -{
> -       if (context->source > 0)
> -               g_source_remove(context->source);
> -
> -       bt_gatt_client_unref(context->client);
> -       bt_gatt_server_unref(context->server);
> -       gatt_db_unref(context->client_db);
> -       gatt_db_unref(context->server_db);
> -
> -       if (context->att)
> -               bt_att_unref(context->att);
> -
> -       g_main_loop_unref(context->main_loop);
> -
> -       test_free(context->data);
> -       g_free(context);
> -}
> -
> -static void execute_context(struct context *context)
> -{
> -       g_main_loop_run(context->main_loop);
> -
> -       destroy_context(context);
> -}
> -
>  static void test_read_cb(bool success, uint8_t att_ecode,
>                                         const uint8_t *value, uint16_t length,
>                                         void *user_data)
> @@ -1339,9 +1320,7 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>
>  static void test_client(gconstpointer data)
>  {
> -       struct context *context = create_context(512, data);
> -
> -       execute_context(context);
> +       create_context(512, data);
>  }
>
>  static void test_server(gconstpointer data)
> @@ -1354,10 +1333,7 @@ static void test_server(gconstpointer data)
>
>         g_assert_cmpint(len, ==, pdu.size);
>
> -       if (g_test_verbose())
> -               util_hexdump('<', pdu.data, len, test_debug, "GATT: ");
> -
> -       execute_context(context);
> +       util_hexdump('<', pdu.data, len, test_debug, "GATT: ");
>  }
>
>  static void test_search_primary(gconstpointer data)
> @@ -1368,8 +1344,6 @@ static void test_search_primary(gconstpointer data)
>         bt_gatt_discover_all_primary_services(context->att, test_data->uuid,
>                                                         generic_search_cb,
>                                                         context, NULL);
> -
> -       execute_context(context);
>  }
>
>  static void test_search_included(gconstpointer data)
> @@ -1379,8 +1353,6 @@ static void test_search_included(gconstpointer data)
>         bt_gatt_discover_included_services(context->att, 0x0001, 0xffff,
>                                                         generic_search_cb,
>                                                         context, NULL);
> -
> -       execute_context(context);
>  }
>
>  static void test_search_chars(gconstpointer data)
> @@ -1390,8 +1362,6 @@ static void test_search_chars(gconstpointer data)
>         g_assert(bt_gatt_discover_characteristics(context->att, 0x0010, 0x0020,
>                                                         generic_search_cb,
>                                                         context, NULL));
> -
> -       execute_context(context);
>  }
>
>  static void test_search_descs(gconstpointer data)
> @@ -1401,8 +1371,6 @@ static void test_search_descs(gconstpointer data)
>         g_assert(bt_gatt_discover_descriptors(context->att, 0x0013, 0x0016,
>                                                         generic_search_cb,
>                                                         context, NULL));
> -
> -       execute_context(context);
>  }
>
>  static const struct test_step test_read_by_type_1 = {
> @@ -1552,8 +1520,6 @@ static void test_read_by_type(gconstpointer data)
>         g_assert(bt_gatt_read_by_type(context->att, step->handle,
>                                         step->end_handle, test_data->uuid,
>                                         read_by_type_cb, context, NULL));
> -
> -       execute_context(context);
>  }
>
>  static void test_long_read(struct context *context)
> @@ -1788,7 +1754,7 @@ int main(int argc, char *argv[])
>  {
>         struct gatt_db *service_db_1, *ts_small_db, *ts_large_db_1;
>
> -       g_test_init(&argc, &argv, NULL);
> +       tester_init(&argc, &argv);
>
>         service_db_1 = make_service_data_1_db();
>         ts_small_db = make_test_spec_small_db();
> @@ -2879,5 +2845,5 @@ int main(int argc, char *argv[])
>                         raw_pdu(0x0a, 0x03, 0x00),
>                         raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x80));
>
> -       return g_test_run();
> +       return tester_run();
>  }
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz
