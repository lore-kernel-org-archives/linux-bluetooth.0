Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F0F2FC2D
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1sk2SIT"
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C021DCC
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 15:53:50 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c595f5dc84so3416261fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 15:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700006029; x=1700610829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqH2hQBi1HFpeLlUzOTyxaF5rWUT1GlVm/0q3EtzFB0=;
        b=Y1sk2SITmo7z9/5C7lUqG4IZg8bcbPfX9iLucEXhEgwQ3QltCibHrLKT0d94BL+/42
         lHnnmMDYLaAWS9ObZ5snLFqtrdLfUs9Bodv6fh6VNaCov+/lzM79OjlAqQWhOxUoW3N/
         gkPSK4v0j31HLXCabJMPklor87eUNhc4i2WGCkdFG06xix0K0F36o/SRuOxl3Thj379U
         DyVSFoy+PVF4JG6pk1BBYve0DYwHqIE2LPjLHILR9OhcMOYm58KNzKErz1f7tveG2l56
         1rsQtgJyG5kjs6pbLvVxLcrTh1amjZKr9PW+iWKMcBv0mWX09CJmzahLnPi4tYBw2tpq
         0Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700006029; x=1700610829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqH2hQBi1HFpeLlUzOTyxaF5rWUT1GlVm/0q3EtzFB0=;
        b=lAdprKz69FwVmFrUXV1WDLudGBBLJq653JkrwHhioMk+lBZvsD6FcD26/WmwFJEb//
         GJvfduIGjYqASjJGkUq7EegFH36leOaSeEtgfGY5MO9Na49aLRiQIfNdUSuCmCN0e/6+
         dau6rYBnVZqSJ+clPJb6Mccyb9ARLvCiJAflpJIVYBzKpSkWLHRiq2olv7H9fmjnqB8E
         81GqHNsPUWiWmWJu9wZPeIPO6Df5gwZnKDrQSPilRSx0DcjD2ODzpNBgfiFgf9X/2E1R
         3hfrp00vxDh0oFUB+Q91UFq2qpkU+rHMbzRD5gCUhnJdHoSoy0PhgyqxqdtS6+jrNQvd
         9ALg==
X-Gm-Message-State: AOJu0YzGcE14wK5E38PWf5bZeBXP8oZZvC7OmpOrn5HHVdnHrOE1TIaF
	aClpg3l5ej3Wy+uFVQv89WIO/36dV+qY8pGWmwx8r5+3mtI=
X-Google-Smtp-Source: AGHT+IH8Gb94K+pJYMONTIhH0FyskzIqvdpMlWIN5pXL9FMjDVtBiHaXpcZXp0oUeeWkj77fgoNbRpbcpoIGAP8Uzqo=
X-Received: by 2002:a2e:9c87:0:b0:2c5:22cc:eb38 with SMTP id
 x7-20020a2e9c87000000b002c522cceb38mr1372544lji.1.1700006028653; Tue, 14 Nov
 2023 15:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102155827.4219-1-silviu.barbulescu@nxp.com> <20231102155827.4219-5-silviu.barbulescu@nxp.com>
In-Reply-To: <20231102155827.4219-5-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Nov 2023 18:53:36 -0500
Message-ID: <CABBYNZJ3FHhjH465Vw=AgHiYhAecGPsY4zGaSgBB5Z4ACm7qUg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] profiles/audio/transport.c: Add support multiple BIS
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com, 
	andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Thu, Nov 2, 2023 at 11:58=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Add support for bcast multiple BISes
>
> ---
>  profiles/audio/transport.c | 59 ++++++++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 18 deletions(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 23ea267f6..eaafd8a35 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -163,7 +163,9 @@ find_transport_by_bap_stream(const struct bt_bap_stre=
am *stream)
>                 struct bap_transport *bap;
>
>                 if (strcasecmp(uuid, PAC_SINK_UUID) &&
> -                               strcasecmp(uuid, PAC_SOURCE_UUID))
> +                               strcasecmp(uuid, PAC_SOURCE_UUID) &&
> +                               strcasecmp(uuid, BCAA_SERVICE_UUID) &&
> +                               strcasecmp(uuid, BAA_SERVICE_UUID))
>                         continue;
>
>                 bap =3D transport->data;
> @@ -312,9 +314,11 @@ static void media_transport_remove_owner(struct medi=
a_transport *transport)
>                 media_request_reply(owner->pending, EIO);
>
>         transport->owner =3D NULL;
> -       if (bap->linked)
> -               queue_foreach(bt_bap_stream_io_get_links(bap->stream),
> -                               linked_transport_remove_owner, owner);
> +       if (bt_bap_stream_get_type(bap->stream) =3D=3D
> +                                       BT_BAP_STREAM_TYPE_UCAST)
> +               if (bap->linked)
> +                       queue_foreach(bt_bap_stream_io_get_links(bap->str=
eam),
> +                                       linked_transport_remove_owner, ow=
ner);

I wonder it it wouldn't be better to have something like
bt_bap_stream_foreach_link which would take care of detecting if there
are any links, in fact this whole thing about checking the stream type
logic shall probably be keep internal to shared/bap.c, we could
perhaps create a bt_bap_stream_ops which would register callbacks
based on the stream type that way we only need to check the stream
type at creation.

>         if (owner->watch)
>                 g_dbus_remove_watch(btd_get_dbus_connection(), owner->wat=
ch);
> @@ -496,9 +500,11 @@ static void media_transport_set_owner(struct media_t=
ransport *transport,
>         DBG("Transport %s Owner %s", transport->path, owner->name);
>         transport->owner =3D owner;
>
> -       if (bap->linked)
> -               queue_foreach(bt_bap_stream_io_get_links(bap->stream),
> -                               linked_transport_set_owner, owner);
> +       if (bt_bap_stream_get_type(bap->stream) =3D=3D
> +                                       BT_BAP_STREAM_TYPE_UCAST)
> +               if (bap->linked)
> +                       queue_foreach(bt_bap_stream_io_get_links(bap->str=
eam),
> +                                       linked_transport_set_owner, owner=
);

Ditto.

>         owner->transport =3D transport;
>         owner->watch =3D g_dbus_add_disconnect_watch(btd_get_dbus_connect=
ion(),
> @@ -641,6 +647,7 @@ static DBusMessage *release(DBusConnection *conn, DBu=
sMessage *msg,
>         const char *sender;
>         struct media_request *req;
>         guint id;
> +       const char *uuid;
>
>         sender =3D dbus_message_get_sender(msg);
>
> @@ -669,9 +676,12 @@ static DBusMessage *release(DBusConnection *conn, DB=
usMessage *msg,
>         req =3D media_request_create(msg, id);
>         media_owner_add(owner, req);
>
> -       if (bt_bap_stream_get_type(bap->stream) =3D=3D
> -                       BT_BAP_STREAM_TYPE_BCAST) {
> -               bap_disable_complete(bap->stream, 0x00, 0x00, owner);
> +       uuid =3D media_endpoint_get_uuid(transport->endpoint);
> +       if (!strcasecmp(uuid, BCAA_SERVICE_UUID) ||
> +                               !strcasecmp(uuid, BAA_SERVICE_UUID)) {
> +               if (bt_bap_stream_get_type(bap->stream) =3D=3D
> +                                               BT_BAP_STREAM_TYPE_BCAST)
> +                       bap_disable_complete(bap->stream, 0x00, 0x00, own=
er);
>         }
>
>         return NULL;
> @@ -686,7 +696,11 @@ static gboolean get_device(const GDBusPropertyTable =
*property,
>         if (transport->device)
>                 path =3D device_get_path(transport->device);
>         else
> -               path =3D adapter_get_path(transport->adapter);
> +               /*
> +                *Use remote endpoint path as fake device path
> +                *for broadcast source transport
> +                */
> +               path =3D transport->remote_endpoint;
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path=
);
>
> @@ -1272,7 +1286,9 @@ static bool match_link_transport(const void *data, =
const void *user_data)
>         if (!transport)
>                 return false;
>
> -       bap_update_links(transport);
> +       if (bt_bap_stream_get_type((struct bt_bap_stream *)stream) =3D=3D
> +                                               BT_BAP_STREAM_TYPE_UCAST)
> +               bap_update_links(transport);
>
>         return true;
>  }
> @@ -1378,7 +1394,9 @@ static guint resume_bap(struct media_transport *tra=
nsport,
>         if (bap->resume_id)
>                 return 0;
>
> -       bap_update_links(transport);
> +       if (bt_bap_stream_get_type(bap->stream) =3D=3D
> +                                       BT_BAP_STREAM_TYPE_UCAST)
> +               bap_update_links(transport);

It is also a bad practice to put test like the above upfront instead
of just embbed it inside bap_update_links otherwise we just keep
duplicating the same check over and over.

>
>         switch (bt_bap_stream_get_state(bap->stream)) {
>         case BT_BAP_STREAM_STATE_ENABLING:
> @@ -1416,7 +1434,9 @@ static guint suspend_bap(struct media_transport *tr=
ansport,
>         else
>                 transport_set_state(transport, TRANSPORT_STATE_IDLE);
>
> -       bap_update_links(transport);
> +       if (bt_bap_stream_get_type(bap->stream) =3D=3D
> +                                       BT_BAP_STREAM_TYPE_UCAST)
> +               bap_update_links(transport);

Ditto.

>         return bt_bap_stream_disable(bap->stream, bap->linked, func, owne=
r);
>  }
> @@ -1491,9 +1511,10 @@ static void bap_state_changed(struct bt_bap_stream=
 *stream, uint8_t old_state,
>                 /* If a request is pending wait it to complete */
>                 if (owner && owner->pending)
>                         return;
> -               bap_update_links(transport);
> -               if (!media_endpoint_is_broadcast(transport->endpoint))
> +               if (!media_endpoint_is_broadcast(transport->endpoint)) {
> +                       bap_update_links(transport);
>                         bap_update_qos(transport);
> +               }
>                 else if (bt_bap_stream_io_dir(stream) !=3D BT_BAP_BCAST_S=
OURCE)
>                         bap_update_bcast_qos(transport);
>                 transport_update_playing(transport, FALSE);
> @@ -1510,7 +1531,7 @@ static void bap_state_changed(struct bt_bap_stream =
*stream, uint8_t old_state,
>                         bap_update_bcast_qos(transport);
>                 break;
>         case BT_BAP_STREAM_STATE_RELEASING:
> -               if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SINK=
)
> +               if (!bt_bap_stream_io_dir(stream))
>                         return;
>                 break;
>         }
> @@ -1555,7 +1576,9 @@ static void bap_connecting(struct bt_bap_stream *st=
ream, bool state, int fd,
>         if (bap->stream !=3D stream)
>                 return;
>
> -       bap_update_links(transport);
> +       if (bt_bap_stream_get_type(bap->stream) =3D=3D
> +                                       BT_BAP_STREAM_TYPE_UCAST)
> +               bap_update_links(transport);

Ditto.

>  }
>
>  static void free_bap(void *data)
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
