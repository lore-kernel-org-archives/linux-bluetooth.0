Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF315C15C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507674; cv=none; b=KCvMzVcl93OijJQ1yr0H5gr1qk8EjZ6dnoL3HYl4PmqnWi907tK/3Ii+Zk/GteQslLq76L+9M/hBElCid5yWpTo9g9sTLb4uzVIzmHhPfiiJtjIug6Iekuk1keC/LthxuJoeaTbSLfIXVXA+YsnN/a9kSsls5mP9RmazGsioLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507674; c=relaxed/simple;
	bh=+TTS5iZHIRfktqYxglk8Gj0esUbCi1OLDmahRLlfXgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCjFjiC9+b4JMyUv8Bc7S+abgE1NbRzvkNQiLcThmth247smhiueATPb+Ho8QscbqGnt7B/y0beiTD66LumImsRBX3TJWKSs2ANHHPtSGshd5dvQOxJSg1Ietl/2rtG8Y2qQO/ir29CzIu3t04835XmgXAqHvUOQtESaWHyz7XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj0XzccJ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj0XzccJ"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75de9a503so49798321fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726507671; x=1727112471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV48bapdHimv6gRzG4TPDyF1linzl4kVeP8GW5fJ8Iw=;
        b=Hj0XzccJCOK0SO8Ki4FMrsAK0wn7ssTlP4XfSTja9HnwawhGB0pUiKSOpikZmUwFLD
         R6YJDWnEcRD0Y3ME1fSgZA+KMs0VAH0p2MLPfZxtOBLtBOcWw5kvzUCwDDw8E2sLFTwO
         Im3qGOYiUyMPitlKYLE01qG4cJJ3UMu1Pp/X+i4jbEZYSAMcwfICMBIl2IG8uDzkB5qT
         L6bMM+sdcw6x9ckW4h47hLS6aNpryCsITt18XOS1owoD3oKpDzX5USYvqAEr6TRkOlqd
         Vyg4Nf7pypOqPfpJPD5P+eRsb+QQIEXUg5XPmlc4uTDbAI5paDtHMQi0ZUvtFw1jvmlQ
         3FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726507671; x=1727112471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV48bapdHimv6gRzG4TPDyF1linzl4kVeP8GW5fJ8Iw=;
        b=xM+/kxXe1owY1FDmD9g6prck4PQ0IHG8SFoZdBHmfbnMHylexfb7rN0hZNPM31j5lW
         pdGetaPFtzYsmH1cisp3YpHlCi3b2JAc7SNCIptjT9bzi/A7LbgEI+2ZaGwWn7SPq69U
         RN1YBRPzqcx0vqzP8EPFuGMgX71su9V5HL9IA0y8XMSop25WsU3p9rYbVUtO0V0hl/jR
         DId+N0g24xHs5mlE2C2t9vQeLe32vv2HAEcN5vc8kfvH5LAh17NnifchCqg8oHFxLkvX
         liRwjGl48OjM9B+Kt4BuTrEesIP4gqelsEf9CNNon02rtEKcJth1rrXANFoNcQdDn7Fv
         kClQ==
X-Gm-Message-State: AOJu0YxmTaQl0kObqJpqXcPmWEJ1fAaHUYW9EZCH5uqATkGq7qB8r+o9
	tg0OlHCd3mWvEdZ4DvSzXaYK9lhI5p7686/gmgpNWCArZfAbButbNuOvdZuC5oYJfZ7ogZUxKN6
	M6w7Qm2hqZB+LlsIXHNbIOSOad5Rkp5Sm
X-Google-Smtp-Source: AGHT+IEidQAd2kbdP8zVu7PY2B6HQfyIf7uB9gg6IrmMOi7zCCbyTb3BeWsQkrHV8wgHIXutp5ErV1CI5mSjP5T6wmc=
X-Received: by 2002:a05:651c:1548:b0:2f7:6664:f295 with SMTP id
 38308e7fff4ca-2f787ee4fd7mr79121091fa.27.1726507669850; Mon, 16 Sep 2024
 10:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916132813.165731-1-frederic.danis@collabora.com> <20240916132813.165731-6-frederic.danis@collabora.com>
In-Reply-To: <20240916132813.165731-6-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Sep 2024 13:27:37 -0400
Message-ID: <CABBYNZLpkgGJ_VE1=3m3An1T8sDJoXRbtNOZcAnMbTqyWy5DmQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 5/9] obexd: Add BIP client for AVRCP cover art download
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Mon, Sep 16, 2024 at 9:28=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> The cover art image handle is available in the metadata of the track
> when the OBEX BIP session is connected to the PSM port provided
> in AVRCP SDP record and available as org.bluez.MediaPlayer property.
>
> This service allows to get the thumbnail.
> ---
>  Makefile.obexd         |   1 +
>  obexd/client/bip.c     | 171 +++++++++++++++++++++++++++++++++++++++++
>  obexd/client/bip.h     |  12 +++
>  obexd/client/manager.c |   2 +
>  4 files changed, 186 insertions(+)
>  create mode 100644 obexd/client/bip.c
>  create mode 100644 obexd/client/bip.h
>
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 4cdce73af..866147dd1 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -81,6 +81,7 @@ obexd_src_obexd_SOURCES =3D $(btio_sources) $(gobex_sou=
rces) \
>                         obexd/client/ftp.h obexd/client/ftp.c \
>                         obexd/client/opp.h obexd/client/opp.c \
>                         obexd/client/map.h obexd/client/map.c \
> +                       obexd/client/bip.h obexd/client/bip.c \
>                         obexd/client/map-event.h obexd/client/map-event.c=
 \
>                         obexd/client/transfer.h obexd/client/transfer.c \
>                         obexd/client/transport.h obexd/client/transport.c=
 \
> diff --git a/obexd/client/bip.c b/obexd/client/bip.c
> new file mode 100644
> index 000000000..f4af2834b
> --- /dev/null
> +++ b/obexd/client/bip.c
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
> +#include "bip.h"
> +
> +#define OBEX_BIP_AVRCP_UUID \
> +       "\x71\x63\xDD\x54\x4A\x7E\x11\xE2\xB4\x7C\x00\x50\xC2\x49\x00\x48=
"
> +#define OBEX_BIP_AVRCP_UUID_LEN 16
> +
> +#define BIP_AVRCP_INTERFACE "org.bluez.obex.BipAvrcp1"

I'd go with org.bluez.obex.Image and then work the details of BIP vs
BIP-AVRCP internally.

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
> +               return reply;
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

If we rename the interface to Image then this can be just "GetThumbnail".

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
> +
> +int bip_init(void)
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
> +void bip_exit(void)
> +{
> +       DBG("");
> +
> +       dbus_connection_unref(conn);
> +       conn =3D NULL;
> +
> +       obc_driver_unregister(&bip_avrcp);
> +}
> diff --git a/obexd/client/bip.h b/obexd/client/bip.h
> new file mode 100644
> index 000000000..18e3360f3
> --- /dev/null
> +++ b/obexd/client/bip.h
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
> +int bip_init(void);
> +void bip_exit(void);
> diff --git a/obexd/client/manager.c b/obexd/client/manager.c
> index 52c00fb0c..52f4d0179 100644
> --- a/obexd/client/manager.c
> +++ b/obexd/client/manager.c
> @@ -32,6 +32,7 @@
>  #include "pbap.h"
>  #include "sync.h"
>  #include "map.h"
> +#include "bip.h"
>  #include "manager.h"
>
>  #define CLIENT_INTERFACE       "org.bluez.obex.Client1"
> @@ -258,6 +259,7 @@ static const struct obc_module {
>         { "pbap", pbap_init, pbap_exit },
>         { "sync", sync_init, sync_exit },
>         { "map", map_init, map_exit },
> +       { "bip", bip_init, bip_exit },
>         { }
>  };
>
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
