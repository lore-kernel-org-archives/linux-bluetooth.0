Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B5C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 18:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjHISCC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjHISB5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 14:01:57 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6494B1999
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 11:01:55 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so1332101fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691604113; x=1692208913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxyZBuCcK9uKpJnp8jBKeKlBjHeBhIZN/cXWmfyGoss=;
        b=Puv0iMmF/5eKP7qM3uBfp317QPV4Cvrix1W/nnoc2Cw1dynBoDBWk0Gr4cVS5sCfd6
         M1vhYCaPFfci7gzqQAOE0CoNrIhcIIKfYqeHlbh1YdoPDL3By2xYWlrMsXHiPBCTWnOs
         H21wfauvMHiO4655rDZh3MSGpyJaahC/aTwwh9wOgZsPppfRzhaqPi0y6oD0c27LkDAR
         UKGuNb/QmLAN6cIv1xp2zuCs007svZlNAbDS0nI9VbENhRWq0BBIf3jg2BU7upRyigVL
         MAek+ARQlVxZxYvVQf6P/39x5fnt/iCNzXHMugD9CXd7fWB8UAoAruZNu+wyvI/XaiAF
         XcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691604113; x=1692208913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxyZBuCcK9uKpJnp8jBKeKlBjHeBhIZN/cXWmfyGoss=;
        b=D9B2zQXsYgeSalP8rx/eUx4jYYlI0CleKK3qE5K1qOGpAXDgHR12Yq6ujWR5exxoQs
         whAEGmJkD4ksBWhXbENUDBhsuD7HisCeWNznaKgZAYfXzTe9Je1+wm/nrgtRK0XMD4bs
         oihCeLkpPXQJ5wz3yQ/e+GDZtxwZKmYBhNN7DBG0arD63y6aHwghpjPoWEZLZXmrZBCY
         OvDh8fz/YCoLJQYOaKIhyiaPzC7re/vEeaPw6Y/6zMLFHJvoq5Gjy13PKcFb511Bqq2R
         Ab6hqAOTv9aQhP6jfIMdH/ezJdjHpnbcurxODzpmRuL0Y7c0Fzcj7dqTiYcT2OzdFNQh
         d4Ng==
X-Gm-Message-State: AOJu0YxQSLVo/Vmyi3uJc5BRzKimoc+bTQFgBkMAgaC5dTQ5VGZ9moOE
        0N5Zxu4Z5bhEyJXV3m4rij+wyST2Iq7iPQyS035Drxs2
X-Google-Smtp-Source: AGHT+IEl+Sc4lJ0f22ApV/qbI5Ed3qtbYEYnO4ITcK4YMFxHdmiye6JhsyTgsGgPysEWpv3SMPdbxSXM1QBilqN2IBY=
X-Received: by 2002:a2e:8609:0:b0:2b7:3633:2035 with SMTP id
 a9-20020a2e8609000000b002b736332035mr2473631lji.32.1691604113263; Wed, 09 Aug
 2023 11:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230808115040.4403-1-claudia.rosu@nxp.com> <20230808115040.4403-7-claudia.rosu@nxp.com>
In-Reply-To: <20230808115040.4403-7-claudia.rosu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Aug 2023 11:01:40 -0700
Message-ID: <CABBYNZ+CkAgxboz7U+S3A=orYqPuBvKNusNoLKsmBSZi7AigLg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 6/7] media: Add broadcast sink media endpoint
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

On Tue, Aug 8, 2023 at 9:46=E2=80=AFAM Claudia Draghicescu <claudia.rosu@nx=
p.com> wrote:
>
> This patch adds the possibility to register a broadcast
> media endpoint if the controller has support for ISO Sync Receiver.
> ---
>  profiles/audio/media.c | 82 +++++++++++++++++++++++++++++++++---------
>  profiles/audio/media.h |  3 +-
>  2 files changed, 68 insertions(+), 17 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 15c64c8d6..59143060b 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -105,6 +105,7 @@ struct media_endpoint {
>         GSList                  *requests;
>         struct media_adapter    *adapter;
>         GSList                  *transports;
> +       bool                    broadcast;

Can't we use the uuid to determine if it is a broadcast or not?

>  };
>
>  struct media_player {
> @@ -1058,7 +1059,9 @@ static struct media_transport *pac_bcast_config(str=
uct bt_bap_stream *stream,
>                                                 struct media_endpoint *en=
dpoint)
>  {
>         struct bt_bap *bap =3D bt_bap_stream_get_session(stream);
> -       struct btd_adapter *adapter =3D bt_bap_get_user_data(bap);
> +       struct btd_adapter *adapter =3D endpoint->adapter->btd_adapter;
> +       struct btd_device *device =3D
> +                       btd_service_get_device(bt_bap_get_user_data(bap))=
;
>         const char *path;
>
>         if (!adapter) {
> @@ -1066,9 +1069,17 @@ static struct media_transport *pac_bcast_config(st=
ruct bt_bap_stream *stream,
>                 return NULL;
>         }
>
> +       if (!device) {
> +               DBG("no device found");
> +       } else {
> +               char name[30];
> +
> +               device_get_name(device, name, 30);
> +               DBG("device found name %s", name);
> +       }

Seems like a leftover to debug if the code is working properly, on the
final version this is probably not needed.

>         path =3D bt_bap_stream_get_user_data(stream);
>
> -       return media_transport_create(NULL, path, cfg->iov_base, cfg->iov=
_len,
> +       return media_transport_create(device, path, cfg->iov_base, cfg->i=
ov_len,
>                                         endpoint, stream);
>  }
>
> @@ -1238,6 +1249,12 @@ static bool endpoint_init_broadcast_source(struct =
media_endpoint *endpoint,
>         return endpoint_init_pac(endpoint, BT_BAP_BCAST_SOURCE, err);
>  }
>
> +static bool endpoint_init_broadcast_sink(struct media_endpoint *endpoint=
,
> +                                               int *err)
> +{
> +       return endpoint_init_pac(endpoint, BT_BAP_BCAST_SINK, err);
> +}
> +
>  static bool endpoint_properties_exists(const char *uuid,
>                                                 struct btd_device *dev,
>                                                 void *user_data)
> @@ -1351,6 +1368,17 @@ static bool experimental_broadcaster_ep_supported(=
struct btd_adapter *adapter)
>         return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
>  }
>
> +static bool experimental_bcast_sink_ep_supported(struct btd_adapter *ada=
pter)
> +{
> +       if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
> +               return false;
> +
> +       if (!btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_SYNC_RECE=
IVER))
> +               return false;
> +
> +       return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
> +}
> +
>  static struct media_endpoint_init {
>         const char *uuid;
>         bool (*func)(struct media_endpoint *endpoint, int *err);
> @@ -1366,6 +1394,8 @@ static struct media_endpoint_init {
>                                 experimental_endpoint_supported },
>         { BCAA_SERVICE_UUID, endpoint_init_broadcast_source,
>                         experimental_broadcaster_ep_supported },
> +       { BAA_SERVICE_UUID, endpoint_init_broadcast_sink,
> +                       experimental_bcast_sink_ep_supported },
>  };
>
>  static struct media_endpoint *
> @@ -1382,6 +1412,7 @@ media_endpoint_create(struct media_adapter *adapter=
,
>                                                 int size,
>                                                 uint8_t *metadata,
>                                                 int metadata_size,
> +                                               bool broadcast,
>                                                 int *err)
>  {
>         struct media_endpoint *endpoint;
> @@ -1397,6 +1428,7 @@ media_endpoint_create(struct media_adapter *adapter=
,
>         endpoint->cid =3D cid;
>         endpoint->vid =3D vid;
>         endpoint->delay_reporting =3D delay_reporting;
> +       endpoint->broadcast =3D broadcast;
>
>         if (qos)
>                 endpoint->qos =3D *qos;
> @@ -1458,11 +1490,11 @@ struct vendor {
>  } __packed;
>
>  static int parse_properties(DBusMessageIter *props, const char **uuid,
> -                               gboolean *delay_reporting, uint8_t *codec=
,
> -                               uint16_t *cid, uint16_t *vid,
> -                               struct bt_bap_pac_qos *qos,
> -                               uint8_t **capabilities, int *size,
> -                               uint8_t **metadata, int *metadata_size)
> +                       gboolean *delay_reporting, uint8_t *codec,
> +                       uint16_t *cid, uint16_t *vid,
> +                       struct bt_bap_pac_qos *qos,
> +                       uint8_t **capabilities, int *size,
> +                       uint8_t **metadata, int *metadata_size, bool *bro=
adcast)
>  {
>         gboolean has_uuid =3D FALSE;
>         gboolean has_codec =3D FALSE;
> @@ -1546,6 +1578,10 @@ static int parse_properties(DBusMessageIter *props=
, const char **uuid,
>                         if (var !=3D DBUS_TYPE_UINT16)
>                                 return -EINVAL;
>                         dbus_message_iter_get_basic(&value, &qos->ppd_max=
);
> +               } else if (strcasecmp(key, "Broadcast") =3D=3D 0) {
> +                       if (var !=3D DBUS_TYPE_BOOLEAN)
> +                               return -EINVAL;
> +                       dbus_message_iter_get_basic(&value, broadcast);

I'm not in favor of adding yet another if we can distinct the endpoint
based on their uuid.

>                 }
>
>                 dbus_message_iter_next(props);
> @@ -1569,6 +1605,7 @@ static DBusMessage *register_endpoint(DBusConnectio=
n *conn, DBusMessage *msg,
>         uint8_t *metadata =3D NULL;
>         int size =3D 0;
>         int metadata_size =3D 0;
> +       bool broadcast =3D false;
>         int err;
>
>         sender =3D dbus_message_get_sender(msg);
> @@ -1587,13 +1624,13 @@ static DBusMessage *register_endpoint(DBusConnect=
ion *conn, DBusMessage *msg,
>
>         if (parse_properties(&props, &uuid, &delay_reporting, &codec, &ci=
d,
>                         &vid, &qos, &capabilities, &size, &metadata,
> -                       &metadata_size) < 0)
> +                       &metadata_size, &broadcast) < 0)
>                 return btd_error_invalid_args(msg);
>
>         if (media_endpoint_create(adapter, sender, path, uuid, delay_repo=
rting,
> -                                       codec, cid, vid, &qos, capabiliti=
es,
> -                                       size, metadata, metadata_size,
> -                                       &err) =3D=3D NULL) {
> +                               codec, cid, vid, &qos, capabilities,
> +                               size, metadata, metadata_size, broadcast,
> +                               &err) =3D=3D NULL) {
>                 if (err =3D=3D -EPROTONOSUPPORT)
>                         return btd_error_not_supported(msg);
>                 else
> @@ -2627,6 +2664,7 @@ static void app_register_endpoint(void *data, void =
*user_data)
>         int metadata_size =3D 0;
>         DBusMessageIter iter, array;
>         struct media_endpoint *endpoint;
> +       bool broadcast =3D false;
>
>         if (app->err)
>                 return;
> @@ -2736,12 +2774,18 @@ static void app_register_endpoint(void *data, voi=
d *user_data)
>                 dbus_message_iter_get_basic(&iter, &qos.ppd_min);
>         }
>
> +       if (g_dbus_proxy_get_property(proxy, "Broadcast", &iter)) {
> +               if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_=
BOOLEAN)
> +                       goto fail;
> +               dbus_message_iter_get_basic(&iter, &broadcast);
> +       }
> +
>         endpoint =3D media_endpoint_create(app->adapter, app->sender, pat=
h, uuid,
> -                                               delay_reporting, codec,
> -                                               vendor.cid, vendor.vid, &=
qos,
> -                                               capabilities, size,
> -                                               metadata, metadata_size,
> -                                               &app->err);
> +                                       delay_reporting, codec,
> +                                       vendor.cid, vendor.vid, &qos,
> +                                       capabilities, size,
> +                                       metadata, metadata_size, broadcas=
t,
> +                                       &app->err);
>         if (!endpoint) {
>                 error("Unable to register endpoint %s:%s: %s", app->sende=
r,
>                                                 path, strerror(-app->err)=
);
> @@ -3245,3 +3289,9 @@ struct btd_adapter *media_endpoint_get_btd_adapter(
>  {
>         return endpoint->adapter->btd_adapter;
>  }
> +
> +bool media_endpoint_is_broadcast(
> +       struct media_endpoint *endpoint)
> +{
> +       return endpoint->broadcast;
> +}
> diff --git a/profiles/audio/media.h b/profiles/audio/media.h
> index 1de84a8ff..0eeb5746a 100644
> --- a/profiles/audio/media.h
> +++ b/profiles/audio/media.h
> @@ -22,5 +22,6 @@ const char *media_endpoint_get_uuid(struct media_endpoi=
nt *endpoint);
>  uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
>  struct btd_adapter *media_endpoint_get_btd_adapter(
>                                         struct media_endpoint *endpoint);
> -
> +bool media_endpoint_is_broadcast(
> +       struct media_endpoint *endpoint);
>  int8_t media_player_get_device_volume(struct btd_device *device);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
