Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677292BB13
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243170; cv=none; b=L9YlA4S44iEsjidh4vMCTixVl2RNbX5b2qXQHcA7tmGFfhU9Gl/D4KTcQs2NqAPsG2H+Q6ug6/mqJB3q4StWfWjpAnnl8pan2FruGDBdCRkHrw94qmyxjPS8nzlWP1Yiz6eiBxkRCN9UOOv8gdixssLbNS2aR0gXlM7Oc94Et4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243170; c=relaxed/simple;
	bh=3rYrel/1SXOTB0psCsmjUz72pk4TGGmF0zlOq30/LEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SP3WLg+hxuSRe3Xs4SCkYzMjxtOE9xfRhpFOYCli0PI30sFw+xig0C11mcSnl342p7hV2Ux0bYWBvNizJ5BJzJ7h40Mv5UFtlj27hWxEvV2eGCrlihovFH7XJQEvwrdUfBdTqoprLdJ9cnisPFVnzmyu7a7Y5b6Td9/S0PzaOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSZfC8aR; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSZfC8aR"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f75aaaade6so26522641fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2024 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726243166; x=1726847966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VMh9IU3m4AiKju8sWeZosP+tGIRAclNS5PgQIZ0ggI=;
        b=KSZfC8aRPJrQvhYG/KDfUUftgGVNn2myJeSduxysqA7+6AEFJUooNth9q4xPMm30BK
         6r/57SqPSmlq5JsLlTIxt+Ibtlq6r/N6xzZMBWhQ6G8cdmkWJPTvGt5IVZp20GVNIKEO
         Ykb3lXrpq16s7IKEBzwPZTQ8uxP/znXFDK0QIc541KULu8WECJl0h2ijgeTgf0I5fsJX
         Ux9I/SrTi+2GZ9qZ1UA3EAwr+x2r39frxq9c8Tr6bIynlMEvIxGHXXwGkBd4Qtmssgw8
         856N6M858dwDLRxk3SmmHA6rfDVf9f6ckRnnNYXkjUToSfuYuVV6zQZTIRVOR+IGfDRu
         iOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726243166; x=1726847966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VMh9IU3m4AiKju8sWeZosP+tGIRAclNS5PgQIZ0ggI=;
        b=rpPNTYfAna0iD4DcTyRajfRN6UMjarejRGJfR+/VT9s9i2glfqa1ZQqRDkYz1ENF8D
         8/Br/scU5oGzT+KPLey3fqDFIdPlh8yIVCl50BhVVIAp09wlMYTykF0zOIKbgeVsWA69
         B+kVWSuboXNJzzjrV8QqvHULpkmkylkrmh53z52H+OIpuvcr9hStKDh8ZGPqA47xE/R6
         tflV+PVvjkBHfhiV0eA3uu/vjO7/HhQlrQyU01ChRiY1vgCTo32Eu+MOYr7EJoDEBbDv
         XiP6zTPe2pLEuWH1dKtp2HMOdBNXY3Tv/P6YjSW9OLpob/xqKx2LTqxT8ZuqvkgI3Dm1
         P7Nw==
X-Gm-Message-State: AOJu0Yya5+LGAteYrDt9//yGUZbIneVUmwh/NPcNuDr7CCylLin2B4mQ
	ZtwxglOqmZ69Sg3neax2faWSk2DDvXrN9aTuur3WHIuP+Sfym/Ibj9uWVeefWbb+YOJ5zdiIn9s
	DqKgRURLBf2AEKYFMhrM9NhIhA9QPCs3s
X-Google-Smtp-Source: AGHT+IFnL4QtD9DW1gKRXZxUq+GIBI/C6MSt2nRGSaFnM14fFWcdCTyxCk0Z7bA482mWGAO1ZYanyvbh95My5TGiCWQ=
X-Received: by 2002:a05:651c:b28:b0:2f7:7ef7:7434 with SMTP id
 38308e7fff4ca-2f787f4f47dmr43814331fa.37.1726243165400; Fri, 13 Sep 2024
 08:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912174921.386856-1-frederic.danis@collabora.com> <20240912174921.386856-5-frederic.danis@collabora.com>
In-Reply-To: <20240912174921.386856-5-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 13 Sep 2024 11:59:12 -0400
Message-ID: <CABBYNZ+RNkaoNFcpSdiOSR4zrNi7yk6By0t8PdYbUHGPX9jc4w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/7] obexd: Add BIP client for AVRCP cover art download.
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Thu, Sep 12, 2024 at 1:50=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> The cover art image handle is available in the metadata of the track
> when the OBEX BIP session is connected to the PSM port provided
> in AVRCP SDP record and available as org.bluez.MediaPlayer property.
>
> This service allows to get the thumbnail.
> ---
>  Makefile.obexd           |   1 +
>  obexd/client/bip-avrcp.c | 171 +++++++++++++++++++++++++++++++++++++++
>  obexd/client/bip-avrcp.h |  12 +++

Id got with bit.{c,h} so we can reuse the implementation for BIP.

>  obexd/client/manager.c   |   2 +
>  obexd/client/transfer.c  |  16 ++++
>  obexd/client/transfer.h  |   2 +
>  6 files changed, 204 insertions(+)
>  create mode 100644 obexd/client/bip-avrcp.c
>  create mode 100644 obexd/client/bip-avrcp.h
>
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 4cdce73af..8038d2327 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -81,6 +81,7 @@ obexd_src_obexd_SOURCES =3D $(btio_sources) $(gobex_sou=
rces) \
>                         obexd/client/ftp.h obexd/client/ftp.c \
>                         obexd/client/opp.h obexd/client/opp.c \
>                         obexd/client/map.h obexd/client/map.c \
> +                       obexd/client/bip-avrcp.h obexd/client/bip-avrcp.c=
 \
>                         obexd/client/map-event.h obexd/client/map-event.c=
 \
>                         obexd/client/transfer.h obexd/client/transfer.c \
>                         obexd/client/transport.h obexd/client/transport.c=
 \
> diff --git a/obexd/client/bip-avrcp.c b/obexd/client/bip-avrcp.c
> new file mode 100644
> index 000000000..ca702be5a
> --- /dev/null
> +++ b/obexd/client/bip-avrcp.c
> @@ -0,0 +1,171 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *
> + *  OBEX Client
> + *
> + *  Copyright (C) 2024  Collabora Ltd.
> + *
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include "gdbus/gdbus.h"
> +#include "gobex/gobex.h"
> +
> +#include "obexd/src/log.h"
> +#include "transfer.h"
> +#include "session.h"
> +#include "driver.h"
> +#include "bip-avrcp.h"
> +
> +#define OBEX_BIP_AVRCP_UUID \
> +       "\x71\x63\xDD\x54\x4A\x7E\x11\xE2\xB4\x7C\x00\x50\xC2\x49\x00\x48=
"
> +#define OBEX_BIP_AVRCP_UUID_LEN 16
> +
> +#define BIP_AVRCP_INTERFACE "org.bluez.obex.BipAvrcp1"
> +#define ERROR_INTERFACE "org.bluez.obex.Error"
> +#define BIP_AVRCP_UUID "0000111A-0000-1000-8000-00805f9b34fb"
> +
> +#define IMG_HANDLE_TAG  0x30
> +
> +static DBusConnection *conn;
> +
> +struct bip_avrcp_data {
> +       struct obc_session *session;
> +};
> +
> +static DBusMessage *get_image_thumbnail(DBusConnection *connection,
> +                                       DBusMessage *message, void *user_=
data)
> +{
> +       struct bip_avrcp_data *bip_avrcp =3D user_data;
> +       const char *handle =3D NULL, *image_path =3D NULL;
> +       struct obc_transfer *transfer;
> +       GObexHeader *header;
> +       DBusMessage *reply =3D NULL;
> +       GError *err =3D NULL;
> +
> +       DBG("");
> +
> +       if (dbus_message_get_args(message, NULL,
> +                               DBUS_TYPE_STRING, &image_path,
> +                               DBUS_TYPE_STRING, &handle,
> +                               DBUS_TYPE_INVALID) =3D=3D FALSE) {
> +               reply =3D g_dbus_create_error(message,
> +                               ERROR_INTERFACE ".InvalidArguments", NULL=
);
> +               goto fail;
> +       }
> +
> +       transfer =3D obc_transfer_get("x-bt/img-thm", NULL, image_path, &=
err);
> +       if (transfer =3D=3D NULL)
> +               goto fail;
> +
> +       header =3D g_obex_header_new_unicode(IMG_HANDLE_TAG, handle);
> +       obc_transfer_add_header(transfer, header);
> +
> +       if (!obc_session_queue(bip_avrcp->session, transfer, NULL, NULL, =
&err))
> +               goto fail;
> +
> +       return obc_transfer_create_dbus_reply(transfer, message);
> +
> +fail:
> +       reply =3D g_dbus_create_error(message, ERROR_INTERFACE ".Failed",=
 "%s",
> +                                                               err->mess=
age);
> +       g_error_free(err);
> +       return reply;
> +}
> +
> +static const GDBusMethodTable bip_avrcp_methods[] =3D {
> +       { GDBUS_ASYNC_METHOD("GetImageThumbnail",
> +               GDBUS_ARGS({ "file", "s" }, { "handle", "s"}),
> +               GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }=
),
> +               get_image_thumbnail) },
> +       { }
> +};
> +
> +static void bip_avrcp_free(void *data)
> +{
> +       struct bip_avrcp_data *bip_avrcp =3D data;
> +
> +       obc_session_unref(bip_avrcp->session);
> +       g_free(bip_avrcp);
> +}
> +
> +static int bip_avrcp_probe(struct obc_session *session)
> +{
> +       struct bip_avrcp_data *bip_avrcp;
> +       const char *path;
> +
> +       path =3D obc_session_get_path(session);
> +
> +       DBG("%s", path);
> +
> +       bip_avrcp =3D g_try_new0(struct bip_avrcp_data, 1);
> +       if (!bip_avrcp)
> +               return -ENOMEM;
> +
> +       bip_avrcp->session =3D obc_session_ref(session);
> +
> +       if (!g_dbus_register_interface(conn, path, BIP_AVRCP_INTERFACE,
> +                                       bip_avrcp_methods,
> +                                       NULL, NULL,
> +                                       bip_avrcp, bip_avrcp_free)) {
> +               bip_avrcp_free(bip_avrcp);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void bip_avrcp_remove(struct obc_session *session)
> +{
> +       const char *path =3D obc_session_get_path(session);
> +
> +       DBG("%s", path);
> +
> +       g_dbus_unregister_interface(conn, path, BIP_AVRCP_INTERFACE);
> +}
> +
> +static struct obc_driver bip_avrcp =3D {
> +       .service =3D "BIP-AVRCP",
> +       .uuid =3D BIP_AVRCP_UUID,
> +       .target =3D OBEX_BIP_AVRCP_UUID,
> +       .target_len =3D OBEX_BIP_AVRCP_UUID_LEN,
> +       .probe =3D bip_avrcp_probe,
> +       .remove =3D bip_avrcp_remove
> +};

This can stay as bip_arvcp, since obc_driver is per-uuid, but in the
future if someone wants to add BIP uuid it just registers another
driver.

> +int bip_avrcp_init(void)
> +{
> +       int err;
> +
> +       DBG("");
> +
> +       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       if (!conn)
> +               return -EIO;
> +
> +       err =3D obc_driver_register(&bip_avrcp);
> +       if (err < 0)
> +               goto failed;
> +
> +       return 0;
> +
> +failed:
> +       dbus_connection_unref(conn);
> +       conn =3D NULL;
> +       return err;
> +}
> +
> +void bip_avrcp_exit(void)
> +{
> +       DBG("");
> +
> +       dbus_connection_unref(conn);
> +       conn =3D NULL;
> +
> +       obc_driver_unregister(&bip_avrcp);
> +}
> diff --git a/obexd/client/bip-avrcp.h b/obexd/client/bip-avrcp.h
> new file mode 100644
> index 000000000..acd8068f2
> --- /dev/null
> +++ b/obexd/client/bip-avrcp.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *
> + *  OBEX Client
> + *
> + *  Copyright (C) 2024  Collabora Ltd.
> + *
> + *
> + */
> +
> +int bip_avrcp_init(void);
> +void bip_avrcp_exit(void);
> diff --git a/obexd/client/manager.c b/obexd/client/manager.c
> index 52c00fb0c..5078f56da 100644
> --- a/obexd/client/manager.c
> +++ b/obexd/client/manager.c
> @@ -32,6 +32,7 @@
>  #include "pbap.h"
>  #include "sync.h"
>  #include "map.h"
> +#include "bip-avrcp.h"
>  #include "manager.h"
>
>  #define CLIENT_INTERFACE       "org.bluez.obex.Client1"
> @@ -258,6 +259,7 @@ static const struct obc_module {
>         { "pbap", pbap_init, pbap_exit },
>         { "sync", sync_init, sync_exit },
>         { "map", map_init, map_exit },
> +       { "bip-avrcp", bip_avrcp_init, bip_avrcp_exit },

For the module it shall be just bip, avrcp specific UUID is handled by
a dedicated driver.

>         { }
>  };
>
> diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
> index a7a85a0c0..fdf32a985 100644
> --- a/obexd/client/transfer.c
> +++ b/obexd/client/transfer.c
> @@ -57,6 +57,7 @@ struct obc_transfer {
>         GObex *obex;
>         uint8_t status;
>         GObexApparam *apparam;
> +       GSList *headers;
>         guint8 op;
>         struct transfer_callback *callback;
>         DBusConnection *conn;
> @@ -820,6 +821,16 @@ static gboolean transfer_start_get(struct obc_transf=
er *transfer, GError **err)
>                 g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->t=
ype,
>                                                 strlen(transfer->type) + =
1);
>
> +       if (transfer->headers !=3D NULL) {
> +               GSList *l;
> +
> +               for (l =3D transfer->headers; l !=3D NULL; l =3D g_slist_=
next(l)) {
> +                       GObexHeader *hdr =3D l->data;
> +
> +                       g_obex_packet_add_header(req, hdr);
> +               }
> +       }

This one seems to be a different change, so Id put it in a different patch.

> +
>         if (transfer->apparam !=3D NULL) {
>                 hdr =3D g_obex_header_new_apparam(transfer->apparam);
>                 g_obex_packet_add_header(req, hdr);
> @@ -974,3 +985,8 @@ gint64 obc_transfer_get_size(struct obc_transfer *tra=
nsfer)
>  {
>         return transfer->size;
>  }
> +
> +void obc_transfer_add_header(struct obc_transfer *transfer, void *data)
> +{
> +       transfer->headers =3D g_slist_append(transfer->headers, data);
> +}
> diff --git a/obexd/client/transfer.h b/obexd/client/transfer.h
> index 323332a62..1ed195984 100644
> --- a/obexd/client/transfer.h
> +++ b/obexd/client/transfer.h
> @@ -47,3 +47,5 @@ gint64 obc_transfer_get_size(struct obc_transfer *trans=
fer);
>
>  DBusMessage *obc_transfer_create_dbus_reply(struct obc_transfer *transfe=
r,
>                                                         DBusMessage *mess=
age);
> +
> +void obc_transfer_add_header(struct obc_transfer *transfer, void *data);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
