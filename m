Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
References: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 12 Sep 2013 14:01:12 +0300
Message-ID: <CABBYNZ+rY4PXtHDoDct2Behj_hhGf9QaGwT37Qf3yEDuY67+mg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] unit: Add gdbus/client_proxy_removed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 9, 2013 at 5:49 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This tests if watches created using g_dbus_proxy_set_removed_watch works
> when the interface is removed.
> ---
>  unit/test-gdbus-client.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
> index 488d4ec..30b0ce3 100644
> --- a/unit/test-gdbus-client.c
> +++ b/unit/test-gdbus-client.c
> @@ -848,6 +848,61 @@ static void client_check_order(void)
>         destroy_context(context);
>  }
>
> +static void proxy_removed(GDBusProxy *proxy, void *user_data)
> +{
> +       struct context *context = user_data;
> +
> +       if (g_test_verbose())
> +               g_print("proxy removed\n");
> +
> +       g_main_loop_quit(context->main_loop);
> +}
> +
> +static void proxy_set_removed(GDBusProxy *proxy, void *user_data)
> +{
> +       struct context *context = user_data;
> +
> +       if (g_test_verbose())
> +               g_print("proxy %s found\n",
> +                                       g_dbus_proxy_get_interface(proxy));
> +
> +       g_assert(g_dbus_proxy_set_removed_watch(proxy, proxy_removed, context));
> +
> +       context->timeout_source = g_timeout_add_seconds(2, timeout_test,
> +                                                               context);
> +
> +       g_dbus_unregister_interface(context->dbus_conn, SERVICE_PATH,
> +                                                               SERVICE_NAME);
> +}
> +
> +static void client_proxy_removed(void)
> +{
> +       struct context *context = create_context();
> +       static const GDBusPropertyTable string_properties[] = {
> +               { "String", "s", get_string, set_string, string_exists },
> +               { },
> +       };
> +
> +       if (context == NULL)
> +               return;
> +
> +       g_dbus_register_interface(context->dbus_conn,
> +                               SERVICE_PATH, SERVICE_NAME,
> +                               methods, signals, string_properties,
> +                               context, NULL);
> +
> +       context->dbus_client = g_dbus_client_new(context->dbus_conn,
> +                                               SERVICE_NAME, SERVICE_PATH);
> +
> +       g_dbus_client_set_proxy_handlers(context->dbus_client,
> +                                               proxy_set_removed, NULL, NULL,
> +                                               context);
> +
> +       g_main_loop_run(context->main_loop);
> +
> +       destroy_context(context);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         g_test_init(&argc, &argv, NULL);
> @@ -880,5 +935,7 @@ int main(int argc, char *argv[])
>
>         g_test_add_func("/gdbus/client_check_order", client_check_order);
>
> +       g_test_add_func("/gdbus/client_proxy_removed", client_proxy_removed);
> +
>         return g_test_run();
>  }
> --
> 1.8.3.1

This patch-set has been pushed upstream.


-- 
Luiz Augusto von Dentz
