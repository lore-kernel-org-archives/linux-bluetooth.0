Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E9C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 18:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjHISGu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHISGt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 14:06:49 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1668DE5F
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 11:06:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9338e4695so1439961fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691604405; x=1692209205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A33r+cUwE9h45LU57hWMQV2esYR0dedEQBAdOylePCU=;
        b=IQ0kcH4/rPHYKBdrsJyXkMkrLy8YedbT7ZA4D0kaZnQiEbFhTl2gIzHFVCFP8chX6h
         DvF0PihaVEaL+xCHD9xjQ8Sq08vRe1sntzZlTpfy6n5FTepdNjTNOQKqGPf+AbqV1jnr
         WrTFejbWxit2jWCLip+UpXOqfJUG8IAvrSNLos5/eHRVQ0TgTr+gG3mWMyq9GOFB4r69
         Dxj3cWkBNcJtJjbGWCiisDeWlTU6JMiKHVp13yD0NUEw4QycGRzM/L+EbU81bfhhhqbl
         4cinmKDLpxh8tTc6th+9UzWy8FybBlJ4Fv8cN/tmt4y3AINKfKJyd7GD8bDFX/wnM82n
         YGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691604405; x=1692209205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A33r+cUwE9h45LU57hWMQV2esYR0dedEQBAdOylePCU=;
        b=LtVbVr9DW5Pn5kuANGIYp22FTe/6PHhJLaPrOo6kdl3Ff7JJc/IyLlNE2wpR3J50xd
         IYpWhxYrybvg3el2yT+CZfaNqr2qqKM0GAfsVUJJnZyHtNiWhVYrZutHcWA9cWUh1XJG
         BuypVq2A+/mW3UPZfGCjRO1/PMKKg6zF6Gsmz9LHjvfGEElEcbtYm0eNXRckjb1cQW4S
         2AYR7ro50VU6pQ1jKyVnjA/cXOi4jGncTbndZdww4A32fFxJVlFEKTxaBgLHr0vxp7rP
         ZZP7wFOn72RFs3nq+9rxd5NXMBG9d6SfY5O+bAEFpIOmWhBH+GDLwD47k4N3kBfKRzSz
         S5PQ==
X-Gm-Message-State: AOJu0YwgMfqCBnNbsbsK3+g6ig+bvX5MydeDovCFlhh0/SBAVU2EBG7j
        YewDAQdf72b7SlG/umqd98JFeOV/ZdtGDBOzB3U=
X-Google-Smtp-Source: AGHT+IGwr33ooYhKdH3mmghGfWMMFqGlPFhCQmdKvn8Xcsveu++/WtjE37W+LyArDP83cNceogzYbVI36qPxd7s7ENk=
X-Received: by 2002:a2e:8010:0:b0:2b7:bb73:b6e5 with SMTP id
 j16-20020a2e8010000000b002b7bb73b6e5mr2618645ljg.27.1691604405341; Wed, 09
 Aug 2023 11:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230808115040.4403-1-claudia.rosu@nxp.com> <20230808115040.4403-8-claudia.rosu@nxp.com>
In-Reply-To: <20230808115040.4403-8-claudia.rosu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Aug 2023 11:06:32 -0700
Message-ID: <CABBYNZKQ1zsSEXZdMKiv1mDPTaimR9r5pb8+7mhCF_vr+-Nj=w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 7/7] transport: Update transport properties for a
 broadcast stream
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claudia,

On Tue, Aug 8, 2023 at 10:35=E2=80=AFAM Claudia Draghicescu
<claudia.rosu@nxp.com> wrote:
>
> This patch gets the QOS broadcast stream parameters and passes them
> to upper layers.
> ---
>  profiles/audio/transport.c | 245 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 243 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index cf5662d1d..107339520 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -552,6 +552,8 @@ static DBusMessage *acquire(DBusConnection *conn, DBu=
sMessage *msg,
>         owner =3D media_owner_create(msg);
>
>         if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
> +                                               BAA_SERVICE_UUID)
> +               || !strcmp(media_endpoint_get_uuid(transport->endpoint),
>                                                 BCAA_SERVICE_UUID)) {

This code above is probably what media_endpoint_is_broadcast should be
doing, so it matches by uuid.

>                 req =3D media_request_create(msg, 0x00);
>                 media_owner_add(owner, req);
> @@ -853,6 +855,9 @@ static gboolean qos_exists(const GDBusPropertyTable *=
property, void *data)
>         struct media_transport *transport =3D data;
>         struct bap_transport *bap =3D transport->data;
>
> +       if (media_endpoint_is_broadcast(transport->endpoint))
> +               return bap->qos.bcast.io_qos.sdu !=3D 0x00;
> +
>         return bap->qos.ucast.io_qos.phy !=3D 0x00;
>  }
>
> @@ -868,6 +873,18 @@ static gboolean get_cig(const GDBusPropertyTable *pr=
operty,
>         return TRUE;
>  }
>
> +static gboolean get_big(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> +                                                       &bap->qos.bcast.b=
ig);
> +
> +       return TRUE;
> +}
> +
>  static gboolean get_cis(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data=
)
>  {
> @@ -880,6 +897,18 @@ static gboolean get_cis(const GDBusPropertyTable *pr=
operty,
>         return TRUE;
>  }
>
> +static gboolean get_bis(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> +                                                       &bap->qos.bcast.b=
is);
> +
> +       return TRUE;
> +}
> +
>  static gboolean get_interval(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data=
)
>  {
> @@ -899,6 +928,9 @@ static gboolean get_framing(const GDBusPropertyTable =
*property,
>         struct bap_transport *bap =3D transport->data;
>         dbus_bool_t val =3D bap->qos.ucast.framing;
>
> +       if (media_endpoint_is_broadcast(transport->endpoint))
> +               val =3D bap->qos.bcast.framing;
> +
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
>
>         return TRUE;
> @@ -910,6 +942,12 @@ static gboolean get_phy(const GDBusPropertyTable *pr=
operty,
>         struct media_transport *transport =3D data;
>         struct bap_transport *bap =3D transport->data;
>
> +       if (media_endpoint_is_broadcast(transport->endpoint)) {
> +               dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> +                                       &bap->qos.bcast.io_qos.phy);
> +               return TRUE;
> +       }
> +
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
>                                         &bap->qos.ucast.io_qos.phy);
>
> @@ -922,6 +960,12 @@ static gboolean get_sdu(const GDBusPropertyTable *pr=
operty,
>         struct media_transport *transport =3D data;
>         struct bap_transport *bap =3D transport->data;
>
> +       if (media_endpoint_is_broadcast(transport->endpoint)) {
> +               dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
> +                                       &bap->qos.bcast.io_qos.sdu);
> +               return TRUE;
> +       }
> +
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
>                                         &bap->qos.ucast.io_qos.sdu);
>
> @@ -1040,6 +1084,121 @@ static gboolean get_links(const GDBusPropertyTabl=
e *property,
>         return TRUE;
>  }
>
> +static gboolean get_sync_interval(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> +                                               &bap->qos.bcast.sync_inte=
rval);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_packing(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> +                                               &bap->qos.bcast.packing);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_bcode(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +       DBusMessageIter array;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +                                       DBUS_TYPE_BYTE_AS_STRING, &array)=
;
> +
> +       if (bap->qos.bcast.bcode && bap->qos.bcast.bcode->iov_len)
> +               dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BY=
TE,
> +                                               &bap->qos.bcast.bcode->io=
v_base,
> +                                               bap->qos.bcast.bcode->iov=
_len);
> +
> +       dbus_message_iter_close_container(iter, &array);
> +       return TRUE;
> +}
> +
> +static gboolean get_options(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> +                                       &bap->qos.bcast.options);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_skip(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
> +                                       &bap->qos.bcast.skip);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_sync_timeout(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
> +                                       &bap->qos.bcast.sync_timeout);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_sync_cte_type(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> +                                       &bap->qos.bcast.sync_cte_type);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_mse(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> +                                       &bap->qos.bcast.mse);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_timeout(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct bap_transport *bap =3D transport->data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
> +                                       &bap->qos.bcast.timeout);
> +
> +       return TRUE;
> +}
> +
>  static const GDBusPropertyTable bap_properties[] =3D {
>         { "Device", "o", get_device },
>         { "UUID", "s", get_uuid },
> @@ -1059,6 +1218,17 @@ static const GDBusPropertyTable bap_properties[] =
=3D {
>         { "Location", "u", get_location },
>         { "Metadata", "ay", get_metadata },
>         { "Links", "ao", get_links, NULL, links_exists },
> +       { "BIG", "y", get_big, NULL, qos_exists },
> +       { "BIS", "y", get_bis, NULL, qos_exists },
> +       { "SyncInterval", "y", get_sync_interval, NULL, qos_exists },
> +       { "Packing", "y", get_packing, NULL, qos_exists },
> +       { "BCode", "ay", get_bcode, NULL, qos_exists },
> +       { "Options", "y", get_options, NULL, qos_exists },
> +       { "Skip", "q", get_skip, NULL, qos_exists },
> +       { "SyncTimeout", "q", get_sync_timeout, NULL, qos_exists },
> +       { "SyncCteType", "y", get_sync_cte_type, NULL, qos_exists },
> +       { "MSE", "y", get_mse, NULL, qos_exists },
> +       { "Timeout", "q", get_timeout, NULL, qos_exists },
>         { }
>  };
>
> @@ -1341,6 +1511,71 @@ static gboolean bap_resume_wait_cb(void *data)
>         return FALSE;
>  }
>
> +static void bap_update_bcast_qos(const struct media_transport *transport=
)
> +{
> +       struct bap_transport *bap =3D transport->data;
> +       struct bt_bap_qos *qos;
> +
> +       qos =3D bt_bap_stream_get_qos(bap->stream);
> +
> +       if (!memcmp(qos, &bap->qos, sizeof(struct bt_bap_qos)))
> +               return;
> +
> +       bap->qos =3D *qos;
> +
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "BIG");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "BIS");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "SyncInterval");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "Packing");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "Framing");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "BCode");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "Options");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "Skip");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "SyncTimeout");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "SyncCteType");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "MSE");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "Timeout");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "Interval");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "Latency");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "PHY");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "SDU");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "RTN");
> +}
> +
>  static guint resume_bap(struct media_transport *transport,
>                                 struct media_owner *owner)
>  {
> @@ -1493,7 +1728,10 @@ static void bap_state_changed(struct bt_bap_stream=
 *stream, uint8_t old_state,
>                 if (owner && owner->pending)
>                         return;
>                 bap_update_links(transport);
> -               bap_update_qos(transport);
> +               if (!media_endpoint_is_broadcast(transport->endpoint))
> +                       bap_update_qos(transport);
> +               else if (bt_bap_stream_io_dir(stream) !=3D BT_BAP_BCAST_S=
OURCE)
> +                       bap_update_bcast_qos(transport);
>                 transport_update_playing(transport, FALSE);
>                 return;
>         case BT_BAP_STREAM_STATE_DISABLING:
> @@ -1503,6 +1741,8 @@ static void bap_state_changed(struct bt_bap_stream =
*stream, uint8_t old_state,
>                         return;
>                 break;
>         case BT_BAP_STREAM_STATE_STREAMING:
> +               if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SOUR=
CE)
> +                       bap_update_bcast_qos(transport);
>                 break;
>         }
>
> @@ -1631,7 +1871,8 @@ struct media_transport *media_transport_create(stru=
ct btd_device *device,
>                 properties =3D a2dp_properties;
>         } else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
>                                 !strcasecmp(uuid, PAC_SOURCE_UUID) ||
> -                               !strcasecmp(uuid, BCAA_SERVICE_UUID)) {
> +                               !strcasecmp(uuid, BCAA_SERVICE_UUID) ||
> +                               !strcasecmp(uuid, BAA_SERVICE_UUID)) {
>                 if (media_transport_init_bap(transport, stream) < 0)
>                         goto fail;
>                 properties =3D bap_properties;
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
