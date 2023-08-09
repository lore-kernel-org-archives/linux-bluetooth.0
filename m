Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C751C001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 17:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjHIRlo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjHIRlo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 13:41:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54CE10D8
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 10:41:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9c66e2e36so458191fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691602900; x=1692207700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90xc4bMWVJOQZqLH+Dxf9M/b90DDp7Np5wWTVk197ho=;
        b=H17QHd2h2E2mRN4PJroh0BGDbuFNuvODopBwDG5fgsRI1HUOEXXpyZLLL7FG8qSTAa
         myvb51NXENKDlSxsRLzCBeIpXVZM7EIptczGSC6xi0o23npAtc1ivIBZUdWdgaE5oapO
         v65cNY5w3cFDNcPieQeApgqHgoM8FYj8J9Sk1oKBuc9NKvHvTnnFdxbK/1GAERacy74T
         N80snNM6w0LBOcNZQCV7hJztSHxl1XnG/sJwWEpaUQXxhlk4URw171Ic347hcGuFr0Cb
         yxKyR5+XJwu7m3jxlVMyDdI3QN7utD6KO409zLhg6iYsewtR/kxbJUZGB48bHtiv7aDx
         i84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691602900; x=1692207700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90xc4bMWVJOQZqLH+Dxf9M/b90DDp7Np5wWTVk197ho=;
        b=MTH/AdBOMJzfIm3FDULFKdq7PK1lXyrluEgXpahoqj+a/yfOw7L8DTVv8vFcd4VcZo
         1o0I9urhuMcR2XwhnKepEsqm+WGni579CvSpiUVpyN8NQLC6CVPh8apD8prbaPwRf9G6
         wQd4N5qI9+GAp6yG1srIXcLtKHMjkiU3bLDuSbc89Fg6HJZ6IUebrU7re85lhgQu+i1O
         Tucc4G2/x5eTEcbd6zUVhaYel3HR0ckABqb+W0rZKrWko4w2vwlGA6NMm6cTFB5WaueC
         4iwkJkoDfQphGMEMh1HscOs8c3ahd9oEJTF2yCy7M9rjsLLhhSMvUCqnGLxM8897VHMz
         dO8g==
X-Gm-Message-State: AOJu0YzA0b1H5oZfxXkMyHJIHEb7BmUZftP5rzeNrdj+l64EFS8fKP2X
        35RZ03z7IKO++ThOK0cLR9IHSEpQmpHP0oHZAOB53s/QIFU=
X-Google-Smtp-Source: AGHT+IG/KPIoH8JpGFOU8AI59Bo4BZitIH2Sh4Gr/uLR9RIfFZgO7lUsXTTL88WpJxufdK2lQ07PL6iZjfyFRASGno0=
X-Received: by 2002:a2e:9088:0:b0:2b6:d03a:5d8d with SMTP id
 l8-20020a2e9088000000b002b6d03a5d8dmr30965ljg.6.1691602899227; Wed, 09 Aug
 2023 10:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230808115040.4403-1-claudia.rosu@nxp.com> <20230808115040.4403-6-claudia.rosu@nxp.com>
In-Reply-To: <20230808115040.4403-6-claudia.rosu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Aug 2023 10:41:26 -0700
Message-ID: <CABBYNZ+pGUkFt1_2sxq-qnCOP2YrOeitbBYd4TF9DwBO5QszhQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 5/7] bap: Add support for BAP broadcast sink
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

On Tue, Aug 8, 2023 at 10:00=E2=80=AFAM Claudia Draghicescu
<claudia.rosu@nxp.com> wrote:
>
> This adds support for BAP broadcast sink, creates a remote endpoint when =
a
> broadcast source is discovered and synchronizes with the source upon
> endpoint configuration.
> This feature was tested using bluetoothctl with the following commands:
>
> [bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
> [bluetooth]# scan on
> [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
> [bluetooth]# endpoint.config
> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
> /local/endpoint/ep0 16_2_1
> ---
>  profiles/audio/bap.c | 334 ++++++++++++++++++++++++++++++++++++++-----
>  src/shared/bap.c     | 139 +++++++++++++++---
>  src/shared/bap.h     |   6 +-
>  3 files changed, 424 insertions(+), 55 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 8cbb238ef..a0ac642f3 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -34,6 +34,7 @@
>  #include "lib/hci.h"
>  #include "lib/sdp.h"
>  #include "lib/uuid.h"
> +#include "lib/iso.h"
>
>  #include "src/btd.h"
>  #include "src/dbus-common.h"
> @@ -57,7 +58,9 @@
>
>  #define ISO_SOCKET_UUID "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
>  #define PACS_UUID_STR "00001850-0000-1000-8000-00805f9b34fb"
> +#define BCAAS_UUID_STR "00001852-0000-1000-8000-00805f9b34fb"
>  #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
> +#define MEDIA_INTERFACE "org.bluez.Media1"
>
>  struct bap_ep {
>         char *path;
> @@ -186,8 +189,11 @@ static gboolean get_uuid(const GDBusPropertyTable *p=
roperty,
>                 uuid =3D PAC_SINK_UUID;
>         else if (queue_find(ep->data->srcs, NULL, ep))
>                 uuid =3D PAC_SOURCE_UUID;
> -       else
> +       else if ((queue_find(ep->data->bcast, NULL, ep)
> +               && (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SIN=
K)))
>                 uuid =3D BAA_SERVICE_UUID;
> +       else
> +               uuid =3D BCAA_SERVICE_UUID;
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
>
> @@ -341,15 +347,18 @@ static int parse_properties(DBusMessageIter *props,=
 struct iovec **caps,
>                 } else if (!strcasecmp(key, "PHY")) {
>                         const char *str;
>
> -                       if (var !=3D DBUS_TYPE_STRING)
> -                               goto fail;
> -
> -                       dbus_message_iter_get_basic(&value, &str);
> -
> -                       if (!strcasecmp(str, "1M"))
> -                               io_qos.phy =3D 0x01;
> -                       else if (!strcasecmp(str, "2M"))
> -                               io_qos.phy =3D 0x02;
> +                       if (var =3D=3D DBUS_TYPE_STRING) {
> +                               dbus_message_iter_get_basic(&value, &str)=
;
> +
> +                               if (!strcasecmp(str, "1M"))
> +                                       io_qos.phy =3D 0x01;
> +                               else if (!strcasecmp(str, "2M"))
> +                                       io_qos.phy =3D 0x02;
> +                               else
> +                                       goto fail;
> +                       } else if (var =3D=3D DBUS_TYPE_BYTE)
> +                               dbus_message_iter_get_basic(&value,
> +                                                &io_qos.phy);

We shouldn't be accepting different types for PHY, and afaik the PHY
are the same for broadcast, if the problem is that this could be
confusing to the likes of bluetoothctl we could instead make it
support both byte and string formats, but over D-Bus we normally
prefer string format as that is easier to debug.

>                         else
>                                 goto fail;
>                 } else if (!strcasecmp(key, "SDU")) {
> @@ -556,7 +565,7 @@ static DBusMessage *set_configuration(DBusConnection =
*conn, DBusMessage *msg,
>         }
>
>         if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SOURCE) {
> -               /* Mark CIG and CIS to be auto assigned */
> +               /* Mark BIG and BIS to be auto assigned */
>                 ep->qos.bcast.big =3D BT_ISO_QOS_BIG_UNSET;
>                 ep->qos.bcast.bis =3D BT_ISO_QOS_BIS_UNSET;
>         } else {
> @@ -577,8 +586,12 @@ static DBusMessage *set_configuration(DBusConnection=
 *conn, DBusMessage *msg,
>                 ep->stream =3D bt_bap_stream_new(ep->data->bap, ep->lpac,
>                                                 ep->rpac, &ep->qos, ep->c=
aps);
>
> -       ep->id =3D bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
> -                                               config_cb, ep);
> +       if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SINK)
> +               ep->id =3D bt_bap_stream_config(ep->stream, &ep->qos, NUL=
L,
> +                                                       config_cb, ep);
> +       else
> +               ep->id =3D bt_bap_stream_config(ep->stream, &ep->qos, ep-=
>caps,
> +                                                       config_cb, ep);

I guess we can do this internally in bt_bap_stream_config since it is
probably going to discard the capabilities anyway.

>         if (!ep->id) {
>                 DBG("Unable to config stream");
>                 free(ep->caps);
> @@ -597,13 +610,120 @@ static DBusMessage *set_configuration(DBusConnecti=
on *conn, DBusMessage *msg,
>                 break;
>         case BT_BAP_STREAM_TYPE_BCAST:
>                 /* No message sent over the air for broadcast */
> -               ep->id =3D 0;
> +               if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SIN=
K)
> +                       ep->msg =3D dbus_message_ref(msg);
> +               else
> +                       ep->id =3D 0;
> +
>                 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>         }
>
>         return NULL;
>  }
>
> +static void update_bcast_qos(struct bt_iso_qos *qos,
> +                       struct bt_bap_qos *bap_qos)
> +{
> +       bap_qos->bcast.big =3D qos->bcast.big;
> +       bap_qos->bcast.bis =3D qos->bcast.bis;
> +       bap_qos->bcast.sync_interval =3D qos->bcast.sync_interval;
> +       bap_qos->bcast.packing =3D qos->bcast.packing;
> +       bap_qos->bcast.framing =3D qos->bcast.framing;
> +       bap_qos->bcast.encryption =3D qos->bcast.encryption;
> +       bap_qos->bcast.options =3D qos->bcast.options;
> +       bap_qos->bcast.skip =3D qos->bcast.skip;
> +       bap_qos->bcast.sync_timeout =3D qos->bcast.sync_timeout;
> +       bap_qos->bcast.sync_cte_type =3D qos->bcast.sync_cte_type;
> +       bap_qos->bcast.mse =3D qos->bcast.mse;
> +       bap_qos->bcast.timeout =3D qos->bcast.timeout;
> +       bap_qos->bcast.io_qos.interval =3D qos->bcast.in.interval;
> +       bap_qos->bcast.io_qos.latency =3D qos->bcast.in.latency;
> +       bap_qos->bcast.io_qos.phy =3D qos->bcast.in.phy;
> +       bap_qos->bcast.io_qos.sdu =3D qos->bcast.in.sdu;
> +       bap_qos->bcast.io_qos.rtn =3D qos->bcast.in.rtn;
> +
> +       bap_qos->bcast.bcode =3D new0(struct iovec, 1);
> +       util_iov_memcpy(bap_qos->bcast.bcode, qos->bcast.bcode,
> +               sizeof(qos->bcast.bcode));
> +}
> +
> +static bool match_ep_type(const void *data, const void *user_data)
> +{
> +       const struct bap_ep *ep =3D data;
> +
> +       return (bt_bap_pac_get_type(ep->lpac) =3D=3D PTR_TO_INT(user_data=
));
> +}
> +
> +static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user=
_data)
> +{
> +       struct bap_data *data =3D user_data;
> +       struct bt_iso_qos qos;
> +       struct bt_iso_base base;
> +       char address[18];
> +       struct bap_ep *ep;
> +       int fd;
> +       struct iovec *base_io;
> +
> +       bt_io_get(io, &err,
> +                       BT_IO_OPT_DEST, address,
> +                       BT_IO_OPT_QOS, &qos,
> +                       BT_IO_OPT_BASE, &base,
> +                       BT_IO_OPT_INVALID);
> +       if (err) {
> +               error("%s", err->message);
> +               g_error_free(err);
> +               goto drop;
> +       }
> +
> +       g_io_channel_ref(io);
> +       btd_service_connecting_complete(data->service, 0);
> +       DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
> +                                       address, qos.bcast.big, qos.bcast=
.bis);
> +
> +       ep =3D queue_find(data->bcast, match_ep_type,
> +                       INT_TO_PTR(BT_BAP_BCAST_SINK));
> +       if (!ep) {
> +               DBG("ep not found");
> +               return;
> +       }
> +
> +       update_bcast_qos(&qos, &ep->qos);
> +
> +       base_io =3D new0(struct iovec, 1);
> +       util_iov_memcpy(base_io, base.base, base.base_len);
> +
> +       if (ep->stream =3D=3D NULL)
> +               DBG("stream is null");
> +       ep->id =3D bt_bap_stream_config(ep->stream, &ep->qos,
> +                                       base_io, NULL, NULL);
> +       data->listen_io =3D io;
> +
> +       bt_bap_stream_set_user_data(ep->stream, ep->path);
> +
> +       fd =3D g_io_channel_unix_get_fd(io);
> +
> +       if (bt_bap_stream_set_io(ep->stream, fd)) {
> +               bt_bap_stream_enable(ep->stream, true, NULL, NULL, NULL);
> +               g_io_channel_set_close_on_unref(io, FALSE);
> +               return;
> +       }
> +
> +
> +       return;
> +
> +drop:
> +       g_io_channel_shutdown(io, TRUE, NULL);
> +
> +}
> +
> +static bool match_data_bap_data(const void *data, const void *match_data=
)
> +{
> +       const struct bap_data *bdata =3D data;
> +       const struct btd_adapter *adapter =3D match_data;
> +
> +       return bdata->user_data =3D=3D adapter;
> +}
> +
>  static const GDBusMethodTable ep_methods[] =3D {
>         { GDBUS_EXPERIMENTAL_ASYNC_METHOD("SetConfiguration",
>                                         GDBUS_ARGS({ "endpoint", "o" },
> @@ -649,15 +769,23 @@ static struct bap_ep *ep_register_bcast(struct bap_=
data *data,
>                                         struct bt_bap_pac *lpac,
>                                         struct bt_bap_pac *rpac)
>  {
> -       struct btd_adapter *adapter =3D data->user_data;
> +       struct btd_adapter *adapter =3D data->adapter;
> +       struct btd_device *device =3D data->device;
>         struct bap_ep *ep;
>         struct queue *queue;
> -       int i, err;
> +       int i, err =3D 0;
>         const char *suffix;
>         struct match_ep match =3D { lpac, rpac };
>
> +       if (!adapter)
> +               DBG("adapter is null");
> +
> +       if (!device)
> +               DBG("device is null");

I assume the above are just leftovers to debug possible errors, we
probably don't need them if this code has been tested properly.

>         switch (bt_bap_pac_get_type(rpac)) {
>         case BT_BAP_BCAST_SOURCE:
> +       case BT_BAP_BCAST_SINK:
>                 queue =3D data->bcast;
>                 i =3D queue_length(data->bcast);
>                 suffix =3D "bcast";
> @@ -675,8 +803,24 @@ static struct bap_ep *ep_register_bcast(struct bap_d=
ata *data,
>         ep->lpac =3D lpac;
>         ep->rpac =3D rpac;
>
> -       err =3D asprintf(&ep->path, "%s/pac_%s%d", adapter_get_path(adapt=
er),
> -                      suffix, i);
> +       if (device)
> +               ep->data->device =3D device;
> +
> +       switch (bt_bap_pac_get_type(rpac)) {
> +       case BT_BAP_BCAST_SINK:
> +               DBG("sink");
> +               err =3D asprintf(&ep->path, "%s/pac_%s%d",
> +                       adapter_get_path(adapter), suffix, i);
> +               DBG("sink path %s", ep->path);
> +               break;
> +       case BT_BAP_BCAST_SOURCE:
> +               DBG("source");
> +               err =3D asprintf(&ep->path, "%s/pac_%s%d",
> +                               device_get_path(device), suffix, i);
> +               DBG("source path %s", ep->path);

Ditto, we can probably just leave the asprintf line and remove the DBG
statements.

> +               break;
> +       }
> +
>         if (err < 0) {
>                 error("Could not allocate path for remote pac %s/pac%d",
>                                 adapter_get_path(adapter), i);
> @@ -685,14 +829,13 @@ static struct bap_ep *ep_register_bcast(struct bap_=
data *data,
>         }
>
>         if (g_dbus_register_interface(btd_get_dbus_connection(),
> -                               ep->path, MEDIA_ENDPOINT_INTERFACE,
> -                               ep_methods, NULL, ep_properties,
> -                               ep, ep_free) =3D=3D FALSE) {
> +                       ep->path, MEDIA_ENDPOINT_INTERFACE,
> +                       ep_methods, NULL, ep_properties,
> +                       ep, ep_free) =3D=3D FALSE) {
>                 error("Could not register remote ep %s", ep->path);
>                 ep_free(ep);
>                 return NULL;
>         }
> -
>         bt_bap_pac_set_user_data(rpac, ep->path);
>
>         DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->=
path);
> @@ -824,6 +967,7 @@ done:
>
>         queue_foreach(ep->data->srcs, bap_config, NULL);
>         queue_foreach(ep->data->snks, bap_config, NULL);
> +       queue_foreach(ep->data->bcast, bap_config, NULL);
>  }
>
>  static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> @@ -1310,6 +1454,46 @@ static void bap_listen_io(struct bap_data *data, s=
truct bt_bap_stream *stream,
>         data->listen_io =3D io;
>  }
>
> +static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep=
 *ep,
> +                       struct bt_bap_stream *stream, struct bt_iso_qos *=
qos)
> +{
> +       GIOChannel *io;
> +       GError *err =3D NULL;
> +       struct sockaddr_iso_bc iso_bc_addr;
> +
> +       iso_bc_addr.bc_bdaddr_type =3D btd_device_get_bdaddr_type(data->d=
evice);
> +       memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
> +                       sizeof(bdaddr_t));
> +       iso_bc_addr.bc_bis[0] =3D 1;
> +       iso_bc_addr.bc_num_bis =3D 1;
> +
> +       DBG("stream %p", stream);
> +
> +       /* If IO already set skip creating it again */
> +       if (bt_bap_stream_get_io(stream) || data->listen_io)
> +               return;
> +
> +       io =3D bt_io_listen(iso_bcast_confirm_cb, NULL, ep->data, NULL, &=
err,
> +                       BT_IO_OPT_SOURCE_BDADDR,
> +                       btd_adapter_get_address(ep->data->adapter),
> +                       BT_IO_OPT_DEST_BDADDR,
> +                       device_get_address(data->device),
> +                       BT_IO_OPT_DEST_TYPE,
> +                       btd_device_get_bdaddr_type(data->device),
> +                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> +                       BT_IO_OPT_QOS, &qos->bcast,
> +                       BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
> +                       BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
> +                       BT_IO_OPT_INVALID);
> +       if (!io) {
> +               error("%s", err->message);
> +               g_error_free(err);
> +       } else
> +               DBG("io created");
> +
> +       ep->data->listen_io =3D io;
> +
> +}
>  static void bap_create_ucast_io(struct bap_data *data, struct bap_ep *ep=
,
>                                 struct bt_bap_stream *stream, int defer)
>  {
> @@ -1364,10 +1548,10 @@ static void bap_create_bcast_io(struct bap_data *=
data, struct bap_ep *ep,
>         memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos,
>                                 sizeof(struct bt_iso_io_qos));
>  done:
> -       if (ep)
> +       if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SOURCE)
>                 bap_connect_io_broadcast(data, ep, stream, &iso_qos);
>         else
> -               bap_listen_io(data, stream, &iso_qos);
> +               bap_listen_io_broadcast(data, ep, stream, &iso_qos);
>  }
>
>  static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
> @@ -1417,6 +1601,11 @@ static void bap_state(struct bt_bap_stream *stream=
, uint8_t old_state,
>                 break;
>         case BT_BAP_STREAM_STATE_CONFIG:
>                 if (ep && !ep->id) {
> +                       if
> +                       (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAS=
T_SINK) {
> +                               bap_create_bcast_io(data, ep, stream, tru=
e);
> +                               return;
> +                       }
>                         bap_create_io(data, ep, stream, true);
>                         if (!ep->io) {
>                                 error("Unable to create io");
> @@ -1424,7 +1613,6 @@ static void bap_state(struct bt_bap_stream *stream,=
 uint8_t old_state,
>                                 return;
>                         }
>
> -
>                         if (bt_bap_stream_get_type(stream) =3D=3D
>                                         BT_BAP_STREAM_TYPE_UCAST) {
>                                 /* Wait QoS response to respond */
> @@ -1480,6 +1668,10 @@ static void pac_added_broadcast(struct bt_bap_pac =
*pac, void *user_data)
>
>                 bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
>                                                 pac_found_bcast, data);
> +       } else if (bt_bap_pac_get_type(pac) =3D=3D BT_BAP_BCAST_SINK) {
> +               DBG("sink pac %p", pac);

Ditto.

> +               bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
> +                                               pac_found_bcast, data);
>         }
>  }
>
> @@ -1596,14 +1788,6 @@ static bool match_data(const void *data, const voi=
d *match_data)
>         return bdata->bap =3D=3D bap;
>  }
>
> -static bool match_data_bap_data(const void *data, const void *match_data=
)
> -{
> -       const struct bap_data *bdata =3D data;
> -       const struct btd_adapter *adapter =3D match_data;
> -
> -       return bdata->user_data =3D=3D adapter;
> -}
> -
>  static bool io_get_qos(GIOChannel *io, struct bt_iso_qos *qos)
>  {
>         GError *err =3D NULL;
> @@ -1733,6 +1917,73 @@ static void bap_detached(struct bt_bap *bap, void =
*user_data)
>         bap_data_remove(data);
>  }
>
> +static int bap_bcast_probe(struct btd_service *service)
> +{
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       struct btd_adapter *adapter =3D device_get_adapter(device);
> +       struct btd_gatt_database *database =3D btd_adapter_get_database(a=
dapter);
> +       struct bap_data *data =3D btd_service_get_user_data(service);
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("Device %s is a BAP broadcast source", addr);
> +
> +       if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
> +               error("BAP requires ISO Socket which is not enabled");
> +               return -ENOTSUP;
> +       }
> +
> +       /* Ignore, if we were probed for this device already */
> +       if (data) {
> +               error("Profile probed twice for the same device!");
> +               return -EINVAL;
> +       }
> +
> +       data =3D bap_data_new(device);
> +       data->service =3D service;
> +       data->adapter =3D adapter;
> +       data->device =3D device;
> +
> +       data->bap =3D bt_bap_new(btd_gatt_database_get_db(database),
> +                       btd_gatt_database_get_db(database));
> +       if (!data->bap) {
> +               error("Unable to create BAP instance");
> +               free(data);
> +               return -EINVAL;
> +       }
> +
> +       bap_data_add(data);
> +
> +       data->ready_id =3D bt_bap_ready_register(data->bap, bap_ready, se=
rvice,
> +                                                               NULL);
> +       data->state_id =3D bt_bap_state_register(data->bap, bap_state,
> +                                               bap_connecting, data, NUL=
L);
> +       data->pac_id =3D bt_bap_pac_register(data->bap, pac_added_broadca=
st,
> +                                pac_removed_broadcast, data, NULL);
> +
> +       bt_bap_set_user_data(data->bap, service);
> +       bt_bap_new_bcast_source(data->bap, device_get_path(device));
> +       return 0;
> +}
> +
> +static void bap_bcast_remove(struct btd_service *service)
> +{
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       struct bap_data *data;
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("%s", addr);
> +
> +       data =3D btd_service_get_user_data(service);
> +       if (!data) {
> +               error("BAP service not handled by profile");
> +               return;
> +       }
> +
> +       bap_data_remove(data);
> +}
> +
>  static int bap_probe(struct btd_service *service)
>  {
>         struct btd_device *device =3D btd_service_get_device(service);
> @@ -1854,7 +2105,7 @@ static int bap_adapter_probe(struct btd_profile *p,
>
>         bap_data_add(data);
>
> -       if (!bt_bap_attach_broadcast(data->bap)) {
> +       if (!bt_bap_attach_broadcast(data->bap, BT_BAP_BCAST_SOURCE)) {
>                 error("BAP unable to attach");
>                 return -EINVAL;
>         }
> @@ -1901,6 +2152,17 @@ static struct btd_profile bap_profile =3D {
>         .experimental   =3D true,
>  };
>
> +static struct btd_profile bap_bcast_profile =3D {
> +       .name           =3D "bapbcast",

Id suggest using "bcaa" as name instead.

> +       .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .remote_uuid    =3D BCAAS_UUID_STR,
> +       .device_probe   =3D bap_bcast_probe,
> +       .device_remove  =3D bap_bcast_remove,
> +       .auto_connect   =3D false,
> +       .experimental   =3D true,
> +       .probe_on_discover =3D true,
> +};
> +
>  static unsigned int bap_id =3D 0;
>
>  static int bap_init(void)
> @@ -1911,6 +2173,10 @@ static int bap_init(void)
>         if (err)
>                 return err;
>
> +       err =3D btd_profile_register(&bap_bcast_profile);
> +       if (err)
> +               return err;
> +
>         bap_id =3D bt_bap_register(bap_attached, bap_detached, NULL);
>
>         return 0;
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 72ce67c08..ebeb713d5 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -633,14 +633,18 @@ static struct bt_bap_endpoint *bap_endpoint_new(str=
uct bt_bap_db *bdb,
>         return ep;
>  }

Changes to shared shall normally be split in their own commits.

> -static struct bt_bap_endpoint *bap_endpoint_new_broacast(struct bt_bap_d=
b *bdb)
> +static struct bt_bap_endpoint *bap_endpoint_new_broadcast(struct bt_bap_=
db *bdb,
> +                                                               uint8_t t=
ype)
>  {
>         struct bt_bap_endpoint *ep;
>
>         ep =3D new0(struct bt_bap_endpoint, 1);
>         ep->bdb =3D bdb;
>         ep->attr =3D NULL;
> -       ep->dir =3D BT_BAP_BCAST_SOURCE;
> +       if (type =3D=3D BT_BAP_BCAST_SINK)
> +               ep->dir =3D BT_BAP_BCAST_SOURCE;
> +       else
> +               ep->dir =3D BT_BAP_BCAST_SINK;
>
>         return ep;
>  }
> @@ -667,22 +671,27 @@ static struct bt_bap_endpoint *bap_get_endpoint(str=
uct queue *endpoints,
>         return ep;
>  }
>
> +static bool match_ep_type(const void *data, const void *match_data)
> +{
> +       const struct bt_bap_endpoint *ep =3D data;
> +       const uint8_t type =3D PTR_TO_INT(match_data);
> +
> +       return (ep->dir =3D=3D type);
> +}
> +
>  static struct bt_bap_endpoint *bap_get_endpoint_bcast(struct queue *endp=
oints,
> -                                               struct bt_bap_db *db)
> +                                       struct bt_bap_db *db, uint8_t typ=
e)
>  {
>         struct bt_bap_endpoint *ep;
>
>         if (!db)
>                 return NULL;
> -       /*
> -        * We have support for only one stream so we will have
> -        * only one endpoint.
> -        * TO DO add support for more then one stream
> -        */
> -       if (queue_length(endpoints) > 0)
> -               return queue_peek_head(endpoints);
>
> -       ep =3D bap_endpoint_new_broacast(db);
> +       ep =3D queue_find(endpoints, match_ep_type, INT_TO_PTR(type));
> +       if (ep)
> +               return ep;
> +
> +       ep =3D bap_endpoint_new_broadcast(db, type);
>         if (!ep)
>                 return NULL;
>
> @@ -1317,6 +1326,8 @@ static void stream_set_state_broadcast(struct bt_ba=
p_stream *stream,
>         struct bt_bap *bap =3D stream->bap;
>         const struct queue_entry *entry;
>
> +       if (ep->old_state =3D=3D state)
> +               return;
>         ep->old_state =3D ep->state;
>         ep->state =3D state;
>
> @@ -1348,6 +1359,9 @@ static void stream_set_state(struct bt_bap_stream *=
stream, uint8_t state)
>         ep->old_state =3D ep->state;
>         ep->state =3D state;
>
> +       if (stream->lpac->type =3D=3D BT_BAP_BCAST_SINK)
> +               goto done;
> +
>         if (stream->client)
>                 goto done;
>
> @@ -2379,6 +2393,10 @@ static struct bt_bap_pac *bap_pac_find(struct bt_b=
ap_db *bdb, uint8_t type,
>                 return queue_find(bdb->sources, match_codec, codec);
>         case BT_BAP_SINK:
>                 return queue_find(bdb->sinks, match_codec, codec);
> +       case BT_BAP_BCAST_SOURCE:
> +               return queue_find(bdb->broadcast_sources, match_codec, co=
dec);
> +       case BT_BAP_BCAST_SINK:
> +               return queue_find(bdb->broadcast_sinks, match_codec, code=
c);
>         }
>
>         return NULL;
> @@ -2518,7 +2536,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gat=
t_db *db,
>                                         struct iovec *metadata)
>  {
>         struct bt_bap_db *bdb;
> -       struct bt_bap_pac *pac, *pac_brodcast_sink;
> +       struct bt_bap_pac *pac, *pac_broadcast_sink;
>         struct bt_bap_codec codec;
>
>         if (!db)
> @@ -2545,11 +2563,19 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct g=
att_db *db,
>                 bap_add_source(pac);
>                 break;
>         case BT_BAP_BCAST_SOURCE:
> -               // For broadcast add local pac and remote pac
>                 bap_add_broadcast_source(pac);
> -               pac_brodcast_sink =3D bap_pac_new(bdb, name, type, &codec=
, qos,
> +               if (queue_isempty(bdb->broadcast_sinks)) {
> +                       /* When adding a local broadcast source, add also=
 a
> +                        * local broadcast sink
> +                        */
> +                       pac_broadcast_sink =3D bap_pac_new(bdb, name,
> +                                       BT_BAP_BCAST_SINK, &codec, qos,
>                                         data, metadata);
> -               bap_add_broadcast_sink(pac_brodcast_sink);
> +                       bap_add_broadcast_sink(pac_broadcast_sink);
> +               }
> +               break;
> +       case BT_BAP_BCAST_SINK:
> +               bap_add_broadcast_sink(pac);
>                 break;
>         default:
>                 bap_pac_free(pac);
> @@ -3996,7 +4022,7 @@ clone:
>         return true;
>  }
>
> -bool bt_bap_attach_broadcast(struct bt_bap *bap)
> +bool bt_bap_attach_broadcast(struct bt_bap *bap, uint8_t type)
>  {
>         struct bt_bap_endpoint *ep;
>
> @@ -4008,7 +4034,7 @@ bool bt_bap_attach_broadcast(struct bt_bap *bap)
>
>         queue_push_tail(sessions, bap);
>
> -       ep =3D bap_get_endpoint_bcast(bap->remote_eps, bap->ldb);
> +       ep =3D bap_get_endpoint_bcast(bap->remote_eps, bap->ldb, type);
>         if (ep)
>                 ep->bap =3D bap;
>
> @@ -4221,9 +4247,19 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_=
t type,
>                 return bap_foreach_pac(bap->ldb->sinks, bap->rdb->sources=
,
>                                                            func, user_dat=
a);
>         case BT_BAP_BCAST_SOURCE:
> -               return bap_foreach_pac(bap->ldb->broadcast_sources,
> +               if (queue_isempty(bap->rdb->broadcast_sources)
> +                       && queue_isempty(bap->rdb->broadcast_sinks))
> +                       return bap_foreach_pac(bap->ldb->broadcast_source=
s,
>                                         bap->ldb->broadcast_sinks,
>                                         func, user_data);
> +
> +               return bap_foreach_pac(bap->ldb->broadcast_sinks,
> +                                       bap->rdb->broadcast_sources,
> +                                       func, user_data);
> +       case BT_BAP_BCAST_SINK:
> +               return bap_foreach_pac(bap->ldb->broadcast_sinks,
> +                                       bap->rdb->broadcast_sources,
> +                                       func, user_data);
>         }
>  }
>
> @@ -4382,6 +4418,11 @@ unsigned int bt_bap_stream_config(struct bt_bap_st=
ream *stream,
>                 return req->id;
>         case BT_BAP_STREAM_TYPE_BCAST:
>                 stream->qos =3D *qos;
> +               if (stream->lpac->type =3D=3D BT_BAP_BCAST_SINK) {
> +                       if (data)
> +                               stream_config(stream, data, NULL);
> +                       stream_set_state(stream, BT_BAP_STREAM_STATE_CONF=
IG);
> +               }
>                 return 1;
>         }
>
> @@ -4446,13 +4487,19 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt=
_bap *bap,
>                 if (rpac)
>                         type =3D rpac->type;
>                 else if (lpac) {
> -                       switch(lpac->type) {
> +                       switch (lpac->type) {
>                         case BT_BAP_SINK:
>                                 type =3D BT_BAP_SOURCE;
>                                 break;
>                         case BT_BAP_SOURCE:
>                                 type =3D BT_BAP_SINK;
>                                 break;
> +                       case BT_BAP_BCAST_SOURCE:
> +                               type =3D BT_BAP_BCAST_SINK;
> +                               break;
> +                       case BT_BAP_BCAST_SINK:
> +                               type =3D BT_BAP_BCAST_SOURCE;
> +                               break;
>                         default:
>                                 return NULL;
>                         }
> @@ -4913,6 +4960,13 @@ struct io *bt_bap_stream_get_io(struct bt_bap_stre=
am *stream)
>         return io->io;
>  }
>
> +bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_d=
ata)
> +{
> +       const struct bt_bap_stream *stream =3D data;
> +
> +       return stream->lpac->type =3D=3D BT_BAP_BCAST_SINK;
> +}
> +
>  static bool stream_io_disconnected(struct io *io, void *user_data)
>  {
>         struct bt_bap_stream *stream =3D user_data;
> @@ -4944,6 +4998,14 @@ static bool match_req_id(const void *data, const v=
oid *match_data)
>         return (req->id =3D=3D id);
>  }
>
> +static bool match_name(const void *data, const void *match_data)
> +{
> +       const struct bt_bap_pac *pac =3D data;
> +       const char *name =3D match_data;
> +
> +       return (!strcmp(pac->name, name));
> +}
> +
>  int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id)
>  {
>         struct bt_bap_req *req;
> @@ -5132,3 +5194,42 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_=
stream *stream, int *fd)
>
>         return io->connecting;
>  }
> +
> +bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name)
> +{
> +       struct bt_bap_endpoint *ep;
> +       struct bt_bap_pac *pac_broadcast_source, *local_sink;
> +       struct bt_bap_codec bap_codec;
> +
> +       bap_codec.id =3D 0x06;
> +       bap_codec.cid =3D 0;
> +       bap_codec.vid =3D 0;
> +
> +       /* Add remote source endpoint */
> +       if (!bap->rdb->broadcast_sources)
> +               bap->rdb->broadcast_sources =3D queue_new();
> +
> +       if (queue_find(bap->rdb->broadcast_sources, match_name, name)) {
> +               DBG(bap, "broadcast source already registered");
> +               return true;
> +       }
> +
> +       local_sink =3D queue_peek_head(bap->ldb->broadcast_sinks);
> +       pac_broadcast_source =3D bap_pac_new(bap->rdb, name, BT_BAP_BCAST=
_SOURCE,
> +                       &bap_codec, NULL, local_sink->data, NULL);
> +       queue_push_tail(bap->rdb->broadcast_sources, pac_broadcast_source=
);
> +
> +       if (!pac_broadcast_source) {
> +               DBG(bap, "No broadcast source could be created");
> +               return false;
> +       }
> +       queue_foreach(bap->pac_cbs, notify_pac_added, pac_broadcast_sourc=
e);
> +
> +       /* Push remote endpoint with direction sink */
> +       ep =3D bap_endpoint_new_broadcast(bap->rdb, BT_BAP_BCAST_SINK);
> +
> +       if (ep)
> +               queue_push_tail(bap->remote_eps, ep);
> +
> +       return true;
> +}
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 50b567663..fcacfcbed 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -186,7 +186,7 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap);
>  void bt_bap_unref(struct bt_bap *bap);
>
>  bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client);
> -bool bt_bap_attach_broadcast(struct bt_bap *bap);
> +bool bt_bap_attach_broadcast(struct bt_bap *bap, uint8_t type);
>  void bt_bap_detach(struct bt_bap *bap);
>
>  bool bt_bap_set_debug(struct bt_bap *bap, bt_bap_debug_func_t cb,
> @@ -289,7 +289,7 @@ struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_ba=
p_stream *stream);
>  struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
>
>  struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
> -
> +bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_d=
ata);
>  bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd);
>
>  int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id);
> @@ -305,3 +305,5 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *st=
ream);
>
>  int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd);
>  bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *f=
d);
> +
> +bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name);

Not really getting the purpose of this function, it seems to be adding
a new pac record but I assume that shall be done when we had
discovered the BASE, also we shall probably use the Broadcast ID
instead of an arbitrary name and probably set a NULL codec since we
haven't discovered that either.

> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
