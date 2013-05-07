Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1367912644-17401-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367912644-17401-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1367912644-17401-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 7 May 2013 11:43:36 -0300
Message-ID: <CAE6HaM=f8ZuWPLP524=a0z=j=O-LaARo=DvLwjwj6fCH1Ax_uA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 3/3] profile: Error-cases for incoming connections
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, May 7, 2013 at 4:44 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> When an incoming connection attempt is received, if the corresponding
> device or service is not found, handle the error-case.
> ---
>  src/profile.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/src/profile.c b/src/profile.c
> index 6a71627..aab7e33 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -1048,22 +1048,26 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
>         struct ext_io *conn;
>         GIOCondition cond;
>
> +       device = adapter_find_device(server->adapter, dst);
> +       if (device == NULL) {
> +               error("%s device %s not found", server->ext->name, src);

src is a bdaddr_t, so it would be better converted to a proper string.

> +               return NULL;
> +       }
> +
> +       service = btd_device_get_service(device, server->ext->remote_uuid);
> +       if (service == NULL) {
> +               error("%s service not found for device %s", server->ext->name,
> +                                                                       src);

Same here.

> +               return NULL;
> +       }
> +
>         conn = g_new0(struct ext_io, 1);
>         conn->io = g_io_channel_ref(io);
>         conn->proto = server->proto;
>         conn->ext = server->ext;
>         conn->adapter = btd_adapter_ref(server->adapter);
> -
> -       device = adapter_find_device(server->adapter, dst);
> -
> -       if (device) {
> -               conn->device = btd_device_ref(device);
> -
> -               service = btd_device_get_service(device,
> -                                               server->ext->remote_uuid);
> -               if (service)
> -                       conn->service = btd_service_ref(service);
> -       }
> +       conn->device = btd_device_ref(device);
> +       conn->service = btd_service_ref(service);
>
>         cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
>         conn->io_id = g_io_add_watch(io, cond, ext_io_disconnected, conn);
> @@ -1137,6 +1141,8 @@ static void ext_confirm(GIOChannel *io, gpointer user_data)
>         DBG("incoming connect from %s", addr);
>
>         conn = create_conn(server, io, &src, &dst);
> +       if (conn == NULL)
> +               return;
>
>         conn->auth_id = btd_request_authorization(&src, &dst, uuid, ext_auth,
>                                                                         conn);
> @@ -1175,6 +1181,9 @@ static void ext_direct_connect(GIOChannel *io, GError *err, gpointer user_data)
>         }
>
>         conn = create_conn(server, io, &src, &dst);
> +       if (conn == NULL)
> +               return;
> +
>         ext->conns = g_slist_append(ext->conns, conn);
>
>         ext_connect(io, err, conn);
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



Cheers,
--
Vinicius
