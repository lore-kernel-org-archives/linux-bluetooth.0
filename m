Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349383353-16733-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349383353-16733-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Thu, 4 Oct 2012 23:57:51 +0300
Message-ID: <CABBYNZLzCx+4kAwtq6+pcc_uBX1=jJE-CXU2aAat00bGe_Kd8A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Fix invalid memory access while unregistering
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Oct 4, 2012 at 11:42 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> If an interface is added and removed on the same mailoop iteration,
> ObjectManager would try to send InterfacesAdded signal while running the
> idler because the interface was added to data->added list.
>
> This is easily reproduced by forcing an error path in a plugin
> registration, like on sap_server_register(), resulting in the following
> error:
>
> ==11795== Invalid read of size 4
> ==11795==    at 0x496F592: dbus_message_iter_append_basic (dbus-message.c:2598)
> ==11795==    by 0x117B39: append_interface (object.c:554)
> ==11795==    by 0x48955E7: g_slist_foreach (gslist.c:840)
> ==11795==    by 0x11923B: process_changes (object.c:592)
> ==11795==    by 0x11956D: generic_unregister (object.c:980)
> ==11795==    by 0x4973BAC: _dbus_object_tree_unregister_and_unlock (dbus-object-tree.c:516)
> ==11795==    by 0x4965240: dbus_connection_unregister_object_path (dbus-connection.c:5776)
> ==11795==    by 0x1178A5: object_path_unref (object.c:1219)
> ==11795==    by 0x118517: g_dbus_unregister_interface (object.c:1344)
> ==11795==    by 0x19AF5B: sap_exit (sap.c:385)
> ==11795==    by 0x13E9E2: sap_server_register (server.c:1428)
> ==11795==    by 0x13C092: sap_server_probe (manager.c:44)
>
> With this patch we don't send the InterfacesAdded signal, removing it
> from data->added while unregistering.
> ---
>  gdbus/object.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index c63a26d..444728c 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -657,6 +657,17 @@ static gboolean remove_interface(struct generic_data *data, const char *name)
>                 return TRUE;
>         }
>
> +       /*
> +        * Interface being removed was just added, on the same mainloop
> +        * iteration? Don't send any signal
> +        */
> +       if (g_slist_find(data->added, iface)) {
> +               data->added = g_slist_remove(data->added, iface);
> +               g_free(iface->name);
> +               g_free(iface);
> +               return TRUE;
> +       }
> +
>         data->removed = g_slist_prepend(data->removed, iface->name);
>         g_free(iface);
>
> --
> 1.7.12.2

Ack, gonna apply it tomorrow in case of no objections.


-- 
Luiz Augusto von Dentz
