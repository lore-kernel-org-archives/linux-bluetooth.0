Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171220104019.14849-1-szymon.janc@codecoup.pl>
References: <20171220104019.14849-1-szymon.janc@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Dec 2017 10:51:52 -0200
Message-ID: <CABBYNZL7USd-t3s59Ci1gafcpXJ3LmL2JBPawAhL2ES7HXcJ0g@mail.gmail.com>
Subject: Re: [PATCH] gdbus: Fix crash on proxy remove
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Dec 20, 2017 at 8:40 AM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> If proxy was freed due to interface being removed remaining references
> are left with NULL client pointer. We need to cancel pending calls that
> require client when getting reply.
>
> This fix following crash:
> bluetoothd[2773]: src/gatt-database.c:proxy_removed_cb() Proxy removed - removing service: /test/app/hci0/service2
> bluetoothd[2773]: src/gatt-database.c:gatt_db_service_removed() Local GATT service removed
> bluetoothd[2773]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
> bluetoothd[2773]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
> bluetoothd[2773]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10008
> bluetoothd[2773]: src/gatt-database.c:client_disconnect_cb() Client disconnected
> ==2773== Invalid read of size 8
> ==2773==    at 0x485220: proxy_added (client.c:288)
> ==2773==    by 0x485220: get_all_properties_reply (client.c:316)
> ==2773==    by 0x515A041: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.14.6)
> ==2773==    by 0x515DA60: dbus_connection_dispatch (in /lib/x86_64-linux-gnu/libdbus-1.so.3.14.6)
> ==2773==    by 0x47F2BF: message_dispatch (mainloop.c:72)
> ==2773==    by 0x4E84049: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
> ==2773==    by 0x4E843EF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
> ==2773==    by 0x4E84711: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
> ==2773==    by 0x40B51F: main (main.c:770)
> ==2773==  Address 0x88 is not stack'd, malloc'd or (recently) free'd
> ---
>  gdbus/client.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/gdbus/client.c b/gdbus/client.c
> index ec9b63823..ab4059697 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -449,6 +449,12 @@ static void proxy_free(gpointer data)
>         if (proxy->client) {
>                 GDBusClient *client = proxy->client;
>
> +               if (proxy->get_all_call != NULL) {
> +                       dbus_pending_call_cancel(proxy->get_all_call);
> +                       dbus_pending_call_unref(proxy->get_all_call);
> +                       proxy->get_all_call = NULL;
> +               }
> +
>                 if (client->proxy_removed)
>                         client->proxy_removed(proxy, client->user_data);
>
> --
> 2.14.3

Applied, thanks.

-- 
Luiz Augusto von Dentz
