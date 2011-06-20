Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308563100-18917-5-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
	<1308563100-18917-5-git-send-email-nami.li@atheros.com>
Date: Mon, 20 Jun 2011 13:06:24 +0300
Message-ID: <BANLkTikwMNxUsv9XeiVnAGJS_2_f-2ugnw@mail.gmail.com>
Subject: Re: [PATCH obexd 05/14] Server listen on both RFCOMM and L2CAP sockets.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Nami <nami.li@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, haijun@qca.qualcomm.com,
	yongli@qca.qualcomm.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jun 20, 2011 at 12:44 PM, Nami <nami.li@atheros.com> wrote:
> ---
>  plugins/bluetooth.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 93 insertions(+), 0 deletions(-)
>
> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 7f81e14..632e148 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -31,6 +31,8 @@
>
>  #include <openobex/obex.h>
>  #include <openobex/obex_const.h>
> +#include <bluetooth/bluetooth.h>
> +#include <bluetooth/l2cap.h>
>
>  #include <glib.h>
>  #include <gdbus.h>
> @@ -146,6 +148,26 @@ static struct bluetooth_service *find_service(
>        return NULL;
>  }
>
> +static struct bluetooth_service *find_service_psm(
> +                                       struct obex_service_driver *driver,
> +                                       uint16_t psm)
> +{
> +       GSList *l;
> +       DBG("");
> +       for (l = any->services; l; l = l->next) {
> +               struct bluetooth_service *service = l->data;
> +
> +               if (driver != NULL && service->driver != driver)
> +                       continue;
> +
> +               if (psm != 0 && service->driver->psm != psm)
> +                       continue;
> +
> +               return service;
> +       }
> +
> +       return NULL;
> +}
>  static void register_record(struct obex_server *server)
>  {
>        const GSList *l;
> @@ -503,6 +525,49 @@ drop:
>        g_io_channel_shutdown(io, TRUE, NULL);
>  }
>
> +static void l2cap_confirm_event(GIOChannel *io, void *user_data)
> +{
> +       struct bluetooth_service *service;
> +       GError *err = NULL;
> +       char address[18];
> +       uint16_t psm;
> +
> +       bt_io_get(io, BT_IO_L2CAP, &err,
> +                       BT_IO_OPT_DEST, address,
> +                       BT_IO_OPT_PSM, &psm,
> +                       BT_IO_OPT_INVALID);
> +       if (err) {
> +               error("%s", err->message);
> +               g_error_free(err);
> +               goto drop;
> +       }
> +
> +       info("bluetooth: New connection from: %s, psm 0x%x", address,
> +                       psm);
> +
> +       service = find_service_psm(NULL, psm);

You don't seems to be using the user_data for anything, so you could
use to pass the service driver instead of the server in start_l2cap,
if that works than you don't really need find_service_psm at all.

> +       if (service == NULL) {
> +               error("bluetooth: Unable to find service");
> +               goto drop;
> +       }
> +       if (service->driver->service != OBEX_OPP) {
> +               if (request_service_authorization(service, io, address) < 0)
> +                       goto drop;
> +
> +               return;
> +       }
> +
> +       if (!bt_io_accept(io, connect_event, service, NULL, &err)) {
> +               error("%s", err->message);
> +               g_error_free(err);
> +               goto drop;
> +       }
> +
> +       return;
> +
> +drop:
> +       g_io_channel_shutdown(io, TRUE, NULL);
> +}
>  static GIOChannel *start(struct obex_server *server,
>                                struct obex_service_driver *service,
>                                BtIOSecLevel sec_level)
> @@ -525,6 +590,28 @@ static GIOChannel *start(struct obex_server *server,
>        return io;
>  }
>
> +static GIOChannel *start_l2cap(struct obex_server *server,
> +                               struct obex_service_driver *service,
> +                               BtIOSecLevel sec_level)
> +{
> +       GIOChannel *io;
> +       GError *err = NULL;
> +       io = bt_io_listen(BT_IO_L2CAP, NULL, l2cap_confirm_event,
> +                               server, NULL, &err,

See the user_data pointer you pass here (server) is never used in the callback.

> +                               BT_IO_OPT_PSM, service->psm,
> +                               BT_IO_OPT_SEC_LEVEL, sec_level,
> +                               BT_IO_OPT_MTU, BT_RX_MTU,
> +                               BT_IO_OPT_MODE, L2CAP_MODE_ERTM,
> +                               BT_IO_OPT_INVALID);
> +       if (io == NULL) {
> +               error("bluetooth: unable to listen in psm 0x%x: %s",
> +                               service->psm, err->message);
> +               g_error_free(err);
> +       } else
> +               DBG("listening on psm 0x%x", service->psm);
> +
> +       return io;
> +}
>  static void *bluetooth_start(struct obex_server *server, int *err)
>  {
>        BtIOSecLevel sec_level;
> @@ -545,6 +632,12 @@ static void *bluetooth_start(struct obex_server *server, int *err)
>                        continue;
>
>                ios = g_slist_prepend(ios, io);
> +
> +               io = start_l2cap(server, service, sec_level);
> +               if (io == NULL)
> +                       continue;
> +
> +               ios = g_slist_prepend(ios, io);
>        }
>
>        register_record(server);
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
