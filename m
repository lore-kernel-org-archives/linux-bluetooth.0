Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308564051-19004-1-git-send-email-nami.li@atheros.com>
References: <1308564051-19004-1-git-send-email-nami.li@atheros.com>
Date: Mon, 20 Jun 2011 13:49:00 +0300
Message-ID: <BANLkTi=FJ6=OxajrG=qqgSpYkx4=JMvJqQ@mail.gmail.com>
Subject: Re: [PATCH obexd 06/14] Add protocol member to distinguish OBEX Protocol.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Nami <nami.li@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nami,

On Mon, Jun 20, 2011 at 1:00 PM, Nami <nami.li@atheros.com> wrote:
> ---
>  plugins/bluetooth.c |   14 ++++++++++----
>  src/service.h       |    7 +++++++
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 632e148..6eb4048 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -456,10 +456,14 @@ static int request_service_authorization(struct bluetooth_service *service,
>
>        if (connection == NULL || any->path == NULL)
>                return -1;
> -
> -       bt_io_get(io, BT_IO_RFCOMM, &err,
> -                       BT_IO_OPT_SOURCE, source,
> -                       BT_IO_OPT_INVALID);
> +       if(service->driver->protocol == RFCOMM_OBEX)
> +               bt_io_get(io, BT_IO_RFCOMM, &err,
> +                               BT_IO_OPT_SOURCE, source,
> +                               BT_IO_OPT_INVALID);
> +       else
> +               bt_io_get(io, BT_IO_L2CAP, &err,
> +                               BT_IO_OPT_SOURCE, source,
> +                               BT_IO_OPT_INVALID);
>        if (err) {
>                error("%s", err->message);
>                g_error_free(err);
> @@ -505,6 +509,7 @@ static void confirm_event(GIOChannel *io, void *user_data)
>                error("bluetooth: Unable to find service");
>                goto drop;
>        }
> +       service->driver->protocol = RFCOMM_OBEX;
>
>        if (service->driver->service != OBEX_OPP) {
>                if (request_service_authorization(service, io, address) < 0)
> @@ -550,6 +555,7 @@ static void l2cap_confirm_event(GIOChannel *io, void *user_data)
>                error("bluetooth: Unable to find service");
>                goto drop;
>        }
> +       service->driver->protocol = L2CAP_OBEX;
>        if (service->driver->service != OBEX_OPP) {
>                if (request_service_authorization(service, io, address) < 0)
>                        goto drop;
> diff --git a/src/service.h b/src/service.h
> index 313b1f2..465be82 100644
> --- a/src/service.h
> +++ b/src/service.h
> @@ -21,11 +21,18 @@
>  *
>  */
>
> +typedef enum {
> +       RFCOMM_OBEX,
> +       L2CAP_OBEX
> +} Obex_Protocol;
> +
> +
>  struct obex_service_driver {
>        const char *name;
>        uint16_t service;
>        uint8_t channel;
>        uint16_t psm;
> +       Obex_Protocol protocol;
>        const uint8_t *target;
>        unsigned int target_size;
>        const uint8_t *who;
> --
> 1.7.1
>
> --

IMO It should have been named transport instead of protocol, but I
don't think it should be exposed in the service driver, actually the
transport driver should be the one responsible for authorization.


-- 
Luiz Augusto von Dentz
