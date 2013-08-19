Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1376922779-11802-3-git-send-email-luiz.dentz@gmail.com>
References: <1376922779-11802-1-git-send-email-luiz.dentz@gmail.com> <1376922779-11802-3-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 19 Aug 2013 20:59:12 -0300
Message-ID: <CAMOw1v5V5gr1LkQ=KfimkP7PiMHbo=fNf0BDjw8m7pOde3N2Hg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] gdbus: Fix not maintaining message order for signals
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 19, 2013 at 11:32 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> In some cases the order of the messages is altered when a message is
> sent without processing the pending signals first, currently this affect

Here and in every commit message: I think it should be made clear that
we are talking about properties and object manager signals, not
generic signals. Other signals are not affected by the out-of-order
issue.


> client_check_order unit test:
>
> /gdbus/client_check_order: **
> ERROR:unit/test-gdbus-client.c:795:property_check_order: assertion failed: (g_strcmp0(string, "value1") == 0)
>
> As can be observed the value of the property is not yet updated because the
> signal it is still pending, once this fix is applied the test pass:
>
> /gdbus/client_check_order: OK
>
> Note that the flushing only works when g_dbus_send_message is used so
> places where dbus_connection_send and other variants are called directly
> may still change the order.
> ---
>  gdbus/object.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 2f8ef45..b2ca1c2 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -1494,6 +1494,35 @@ DBusMessage *g_dbus_create_reply(DBusMessage *message, int type, ...)
>         return reply;
>  }
>
> +static void g_dbus_flush_object(struct generic_data *data)
> +{
> +       GSList *l;
> +
> +       if (data->process_id > 0) {
> +               g_source_remove(data->process_id);
> +               data->process_id = 0;
> +       }
> +
> +       process_changes(data);
> +
> +       for (l = data->objects; l; l = l->next)
> +               g_dbus_flush_object(l->data);

wouldn't it be better swap these 2 so we flush the pending messages
from children first, then from the parent? Then we can even guarantee
this ordering by moving this code to process_changes().

> +}
> +
> +static void g_dbus_flush(DBusConnection *connection)
> +{
> +       static gboolean flushing = FALSE;

this static var makes no sense with multiple connections, does it?


> +
> +       if (flushing || root == NULL || root->conn != connection)
> +               return;
> +
> +       flushing = TRUE;
> +
> +       g_dbus_flush_object(root);
> +
> +       flushing = FALSE;
> +}
> +
>  gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
>  {
>         dbus_bool_t result = FALSE;
> @@ -1510,6 +1539,9 @@ gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
>                         goto out;
>         }
>
> +       /* Flush pending signal to guarantee message order */
> +       g_dbus_flush(connection);
> +
>         result = dbus_connection_send(connection, message, NULL);
>
>  out:
> --

Otherwise looks good.

Lucas De Marchi
