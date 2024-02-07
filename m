Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81457E76A
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316950; cv=none; b=lPeCyDjA4ZBgbNae+MVLLZBfr9tlUd5Qsv0UEN+dr7ZWuWMTkFjIYCQquo9INnopsz7CSMavEpYHn8BHddu3wTav+rfZaFxp+ywO00kEMaR/8tzdlCI34X5u2dGR0c21hIro7V7jwVlcIFU91DNQwMh+nNisZIt4foWvoArxhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316950; c=relaxed/simple;
	bh=Q9puJsjMSmb/r8KqfrH7f6BQwPwzrrjXT5SXqmX13pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEWIfCnrMvS0n6xjHqM3wTHz3CkrPA86MhQki10j7YuHYDZirngnuii9FWjq78NrpBQlL1+SXVUtVT2Pd87UhV/jTgtrFgcPqF3cdh2WoD4zd/wxm8jGZKpwH9piLKGdxxZ9QLA0A7yG7eZD/MF+FDRI+oSyTaklWkiR6g5DrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8uNJ8Ap; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8uNJ8Ap"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf3a095ba6so6450921fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Feb 2024 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707316946; x=1707921746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLGsmVj/KkUBtsXntxqMlZzORuLqP1m1i8rc0OwSBU8=;
        b=J8uNJ8ApUHxeYxUkYHqZkjoZPhdT7H7Q74/SPRA/4O1yKyy/OHzmVFYX0Y2Ltqu+AO
         qF4qiKY2pEz4mZJ72nPuCwqZH4wfXn2SqyWOBNHpfpQzw/soI1vbfDfXd74h2YvedjU0
         b7r6rqh9Vw3cgbMjBs2QgPuR485jp0Otvshsv3UdBo8qHXUex2qwz/gUKJA/7KWq5QDz
         HVbrKzuj/Uzm8GeFgKV6zD4qguIg/avgvPY6UzydceoDftpszo1vMoKyd6sBussfK5Is
         D1QsMCnJR/jCYYnOCqambK2F9JBY7Wn4nyp4ufYZASSPmfY0VkwM78wSfrVusqXNrFF9
         uvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316946; x=1707921746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLGsmVj/KkUBtsXntxqMlZzORuLqP1m1i8rc0OwSBU8=;
        b=RsAk90rurGsWNYUl1wt5SJaPytSrgIK/80OorALe6sEpP90uzIYKZr929hIWBxX/DV
         m5GAh57AF1ZZbe39F8JIse3SL0xIfZlLt9fYAVN8sNIdCcUp6phj3cfug9tDWDm+popp
         yBqldGk2c1RXxRGYTjOiihsfvk0Umbi44qoVc8kE329ENx6qpsdV4XOA4tRzZyNLWXx3
         0W9GDuc68CN9U5E3uBKqLcpSp02QpNzRVFBhabrkI0C2D+tIUi5TqcH6RMlJXUAld58N
         w/8eD07r/nAk9sp9tFHRjpk+/F6Wn0yrzHZlwyR3e8zf3oFQvFq4TZhqngKkMxBwzxtp
         9NWA==
X-Gm-Message-State: AOJu0YwD3zGvtC0CwD7eErz1mvK+oMG5gHNoWXT8l4jHb1B4Ay1HZU6C
	vgEUepEQdgIIbeOBixeeq8jVr5P24iW2Hg75hP5t4sAO3pbEqok+seyON2g4XbC30jU9AbGAD49
	7SODL0mxNIk53/HyDSaJQcRwr7i6/OHtG
X-Google-Smtp-Source: AGHT+IHeyooebqfB70JWyc9fUw//hCizo6hqrA0PHHwPAcA3xDMmr9czosOHK1eevOUD2QIggF+mVfBmiCj+j+h59bA=
X-Received: by 2002:a05:651c:1059:b0:2d0:b2ce:3956 with SMTP id
 x25-20020a05651c105900b002d0b2ce3956mr4174575ljm.32.1707316945560; Wed, 07
 Feb 2024 06:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207122308.26457-1-andrei.istodorescu@nxp.com> <20240207122308.26457-4-andrei.istodorescu@nxp.com>
In-Reply-To: <20240207122308.26457-4-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Feb 2024 09:42:11 -0500
Message-ID: <CABBYNZJ9VQL+bvx1=0EaPV0WJS_jLnP=3-gwTLr3rvqhSbN9iA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] bap: Do PA Sync for each BAP Broadcast source discovered
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Wed, Feb 7, 2024 at 7:23=E2=80=AFAM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> After discovering a BAP Broadcast Source do a short PA sync first to lear=
n
> the BASE. After discovering the BASE check how many BISes are matching
> the sink capabilities and create endpoints for them. Allow user to
> configure one endpoint using "SetConfiguration" causing BIG
> synchronization to the corresponding BIS; also this results in creating a
> stream and the corresponding transport.
> ---
>  profiles/audio/bap.c | 324 +++++++++++++++----------------------------
>  1 file changed, 110 insertions(+), 214 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 88c93127bea0..8646eae2ed20 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -105,6 +105,44 @@ struct bap_data {
>         void *user_data;
>  };
>
> +/* Structure holding the parameters for periodic train and BIG
> + * synchronization
> + */
> +static struct bt_iso_qos bap_sink_sync_parameters =3D {
> +       .bcast =3D {
> +               .big                    =3D BT_ISO_QOS_BIG_UNSET,
> +               .bis                    =3D BT_ISO_QOS_BIS_UNSET,
> +               /* HCI_LE_Periodic_Advertising_Create_Sync */
> +               .options                =3D 0x00,
> +               .skip                   =3D 0x0000,
> +               .sync_timeout   =3D 0x4000,
> +               .sync_cte_type  =3D 0x00,
> +               /* HCI_LE_BIG_Create_Sync */
> +               .encryption             =3D 0x00,
> +               .bcode                  =3D {0x00},
> +               .mse                    =3D 0x00,
> +               .timeout                =3D 0x4000,
> +               /* to remove from kernel check */
> +               .sync_factor    =3D 0x07,
> +               .packing                =3D 0x00,
> +               .framing                =3D 0x00,
> +               .in =3D {
> +                       .interval       =3D 10000,
> +                       .latency        =3D 10,
> +                       .sdu            =3D 40,
> +                       .phy            =3D 0x02,
> +                       .rtn            =3D 2,
> +               },
> +               .out =3D {
> +                       .interval       =3D 10000,
> +                       .latency        =3D 10,
> +                       .sdu            =3D 40,
> +                       .phy            =3D 0x02,
> +                       .rtn            =3D 2,
> +               }
> +       }
> +};

This cannot be global, it needs to be stored on a per device basis so
it doesn't get overwritten.

>  static struct queue *sessions;
>
>  static bool bap_data_set_user_data(struct bap_data *data, void *user_dat=
a)
> @@ -422,113 +460,6 @@ static int parse_array(DBusMessageIter *iter, struc=
t iovec *iov)
>         return 0;
>  }
>
> -static bool parse_base(void *data, size_t len, util_debug_func_t func,
> -               uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numB=
is,
> -               struct bt_bap_codec *codec, struct iovec **caps,
> -               struct iovec **meta)
> -{
> -       struct iovec iov =3D {
> -               .iov_base =3D data,
> -               .iov_len =3D len,
> -       };
> -
> -       uint8_t capsLen, metaLen;
> -       struct iovec cc;
> -       struct iovec metadata;
> -
> -       if (presDelay) {
> -               if (!util_iov_pull_le24(&iov, presDelay))
> -                       return false;
> -               util_debug(func, NULL, "PresentationDelay %d", *presDelay=
);
> -       }
> -
> -       if (numSubgroups) {
> -               if (!util_iov_pull_u8(&iov, numSubgroups))
> -                       return false;
> -               util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
> -       }
> -
> -       if (numBis) {
> -               if (!util_iov_pull_u8(&iov, numBis))
> -                       return false;
> -               util_debug(func, NULL, "NumBis %d", *numBis);
> -       }
> -
> -       if (codec) {
> -               codec =3D util_iov_pull_mem(&iov, sizeof(*codec));
> -               if (!codec)
> -                       return false;
> -               util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x=
",
> -                               "Codec", codec->id, codec->cid, codec->vi=
d);
> -       }
> -
> -       if (!util_iov_pull_u8(&iov, &capsLen))
> -               return false;
> -       util_debug(func, NULL, "CC Len %d", capsLen);
> -
> -       if (!capsLen)
> -               return false;
> -
> -       cc.iov_len =3D capsLen;
> -       cc.iov_base =3D util_iov_pull_mem(&iov, capsLen);
> -       if (!cc.iov_base)
> -               return false;
> -
> -       if (caps) {
> -               if (*caps)
> -                       util_iov_free(*caps, 1);
> -
> -               *caps =3D util_iov_dup(&cc, 1);
> -       }
> -
> -       for (int i =3D 0; capsLen > 1; i++) {
> -               struct bt_ltv *ltv =3D util_iov_pull_mem(&cc, sizeof(*ltv=
));
> -               uint8_t *caps;
> -
> -               if (!ltv) {
> -                       util_debug(func, NULL, "Unable to parse %s",
> -                                                               "Capabili=
ties");
> -                       return false;
> -               }
> -
> -               util_debug(func, NULL, "%s #%u: len %u type %u",
> -                                       "CC", i, ltv->len, ltv->type);
> -
> -               caps =3D util_iov_pull_mem(&cc, ltv->len - 1);
> -               if (!caps) {
> -                       util_debug(func, NULL, "Unable to parse %s",
> -                                                               "CC");
> -                       return false;
> -               }
> -               util_hexdump(' ', caps, ltv->len - 1, func, NULL);
> -
> -               capsLen -=3D (ltv->len + 1);
> -       }
> -
> -       if (!util_iov_pull_u8(&iov, &metaLen))
> -               return false;
> -       util_debug(func, NULL, "Metadata Len %d", metaLen);
> -
> -       if (!metaLen)
> -               return false;
> -
> -       metadata.iov_len =3D metaLen;
> -       metadata.iov_base =3D util_iov_pull_mem(&iov, metaLen);
> -       if (!metadata.iov_base)
> -               return false;
> -
> -       if (meta) {
> -               if (*meta)
> -                       util_iov_free(*meta, 1);
> -
> -               *meta =3D util_iov_dup(&metadata, 1);
> -       }
> -
> -       util_hexdump(' ', metadata.iov_base, metaLen, func, NULL);
> -
> -       return true;
> -}
> -
>  static int parse_io_qos(const char *key, int var, DBusMessageIter *iter,
>                                 struct bt_bap_io_qos *qos)
>  {
> @@ -954,6 +885,17 @@ static DBusMessage *set_configuration(DBusConnection=
 *conn, DBusMessage *msg,
>                 return btd_error_invalid_args(msg);
>         }
>
> +       /* For BAP Broadcast Sink, the capabilities and metadata are comi=
ng
> +        * from the source's BIS, which are present in the remote PAC
> +        */
> +       if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SINK) {
> +               util_iov_free(setup->caps, 1);
> +               setup->caps =3D util_iov_dup(bt_bap_pac_get_data(ep->rpac=
), 1);
> +               util_iov_free(setup->metadata, 1);
> +               setup->metadata =3D util_iov_dup(
> +                               bt_bap_pac_get_metadata(ep->rpac), 1);
> +       }
> +
>         setup->stream =3D bt_bap_stream_new(ep->data->bap, ep->lpac, ep->=
rpac,
>                                                 &setup->qos, setup->caps)=
;
>
> @@ -977,95 +919,27 @@ static DBusMessage *set_configuration(DBusConnectio=
n *conn, DBusMessage *msg,
>                 break;
>         case BT_BAP_STREAM_TYPE_BCAST:
>                 /* No message sent over the air for broadcast */
> -               if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SIN=
K)
> -                       setup->msg =3D dbus_message_ref(msg);
> -               else {
> +               if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SOU=
RCE)
>                         setup->base =3D bt_bap_stream_get_base(setup->str=
eam);
> -                       setup->id =3D 0;
>                 }
> +               setup->id =3D 0;
>
>                 if (ep->data->service)
>                         service_set_connecting(ep->data->service);
>
>                 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> -       }
>
>         return NULL;
>  }
>
> -static void update_bcast_qos(struct bt_iso_qos *qos,
> -                       struct bt_bap_qos *bap_qos)
> -{
> -       bap_qos->bcast.big =3D qos->bcast.big;
> -       bap_qos->bcast.bis =3D qos->bcast.bis;
> -       bap_qos->bcast.sync_factor =3D qos->bcast.sync_factor;
> -       bap_qos->bcast.packing =3D qos->bcast.packing;
> -       bap_qos->bcast.framing =3D qos->bcast.framing;
> -       bap_qos->bcast.encryption =3D qos->bcast.encryption;
> -       bap_qos->bcast.options =3D qos->bcast.options;
> -       bap_qos->bcast.skip =3D qos->bcast.skip;
> -       bap_qos->bcast.sync_timeout =3D qos->bcast.sync_timeout;
> -       bap_qos->bcast.sync_cte_type =3D qos->bcast.sync_cte_type;
> -       bap_qos->bcast.mse =3D qos->bcast.mse;
> -       bap_qos->bcast.timeout =3D qos->bcast.timeout;
> -       bap_qos->bcast.io_qos.interval =3D qos->bcast.in.interval;
> -       bap_qos->bcast.io_qos.latency =3D qos->bcast.in.latency;
> -       bap_qos->bcast.io_qos.phy =3D qos->bcast.in.phy;
> -       bap_qos->bcast.io_qos.sdu =3D qos->bcast.in.sdu;
> -       bap_qos->bcast.io_qos.rtn =3D qos->bcast.in.rtn;
> -       if (!bap_qos->bcast.bcode)
> -               bap_qos->bcast.bcode =3D new0(struct iovec, 1);
> -       util_iov_memcpy(bap_qos->bcast.bcode, qos->bcast.bcode,
> -                                               sizeof(qos->bcast.bcode))=
;
> -}
> -
>  static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user=
_data)
>  {
>         struct bap_setup *setup =3D user_data;
> -       struct bap_ep *ep =3D setup->ep;
> -       struct bap_data *data =3D ep->data;
> -       struct bt_iso_qos qos;
> -       struct bt_iso_base base;
> -       char address[18];
>         int fd;
> -       struct iovec *base_io;
> -       uint32_t presDelay;
> -       uint8_t numSubgroups;
> -       uint8_t numBis;
> -       struct bt_bap_codec codec;
> -
> -       bt_io_get(io, &err,
> -                       BT_IO_OPT_DEST, address,
> -                       BT_IO_OPT_QOS, &qos,
> -                       BT_IO_OPT_BASE, &base,
> -                       BT_IO_OPT_INVALID);
> -       if (err) {
> -               error("%s", err->message);
> -               g_error_free(err);
> -               goto drop;
> -       }
>
> -       g_io_channel_ref(io);
> -       btd_service_connecting_complete(data->service, 0);
> -       DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
> -                                       address, qos.bcast.big, qos.bcast=
.bis);
> -
> -       update_bcast_qos(&qos, &setup->qos);
> -
> -       base_io =3D new0(struct iovec, 1);
> -       util_iov_memcpy(base_io, base.base, base.base_len);
> -
> -       parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
> -                       &presDelay, &numSubgroups, &numBis,
> -                       &codec, &setup->caps, &setup->metadata);
> -
> -       /* Update pac with BASE information */
> -       bt_bap_update_bcast_source(ep->rpac, &codec, setup->caps,
> -                                       setup->metadata);
> -       setup->id =3D bt_bap_stream_config(setup->stream, &setup->qos,
> -                                       setup->caps, NULL, NULL);
> -
> -       bt_bap_stream_set_user_data(setup->stream, ep->path);
> +       /* listen channel is not needed anymore */
> +       g_io_channel_unref(setup->io);
> +       setup->io =3D NULL;
>
>         fd =3D g_io_channel_unix_get_fd(io);
>
> @@ -1074,26 +948,43 @@ static void iso_bcast_confirm_cb(GIOChannel *io, G=
Error *err, void *user_data)
>                 g_io_channel_set_close_on_unref(io, FALSE);
>                 return;
>         }
> -
> -
> -       return;
> -
> -drop:
> -       g_io_channel_shutdown(io, TRUE, NULL);
> -
>  }
>
>  static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
>  {
>         GError *err =3D NULL;
> +       struct bap_data *data =3D user_data;
> +       struct bt_iso_base base;
> +       struct bt_bap_base base_s;
> +       struct bt_iso_qos qos;
>
> -       if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
> -                               user_data, NULL, &err, BT_IO_OPT_INVALID)=
) {
> -               error("bt_io_bcast_accept: %s", err->message);
> +       btd_service_connecting_complete(data->service, 0);
> +
> +       bt_io_get(io, &err,
> +                       BT_IO_OPT_BASE, &base,
> +                       BT_IO_OPT_QOS, &qos,
> +                       BT_IO_OPT_INVALID);
> +       if (err) {
> +               error("%s", err->message);
>                 g_error_free(err);
>                 g_io_channel_shutdown(io, TRUE, NULL);
> +               return;
>         }
>
> +       /* The PA Sync channel becomes the new listen_io.
> +        * It will be later used to listen for a BIS io.
> +        */
> +       g_io_channel_unref(data->listen_io);
> +       data->listen_io =3D io;
> +       g_io_channel_ref(io);
> +
> +       /* Analyze received BASE data and create remote media endpoints f=
or each
> +        * matching BIS
> +        */
> +       base_s.subgroups =3D queue_new();
> +       bt_bap_parse_base(data->bap, base.base, base.base_len, bap_debug,
> +                       &base_s);
> +       queue_foreach(base_s.subgroups, bt_bap_parse_bis, NULL);
>  }
>
>  static bool match_data_bap_data(const void *data, const void *match_data=
)
> @@ -1934,12 +1825,11 @@ static void setup_listen_io(struct bap_data *data=
, struct bt_bap_stream *stream,
>         data->listen_io =3D io;
>  }
>
> -static void setup_listen_io_broadcast(struct bap_data *data,
> +static void setup_accept_io_broadcast(struct bap_data *data,
>                                         struct bap_setup *setup,
>                                         struct bt_bap_stream *stream,
>                                         struct bt_iso_qos *qos)
>  {
> -       GIOChannel *io;
>         GError *err =3D NULL;
>         struct sockaddr_iso_bc iso_bc_addr;
>
> @@ -1951,29 +1841,18 @@ static void setup_listen_io_broadcast(struct bap_=
data *data,
>
>         DBG("stream %p", stream);
>
> -       /* If IO already set skip creating it again */
> -       if (bt_bap_stream_get_io(stream) || data->listen_io)
> -               return;
> -
> -       io =3D bt_io_listen(NULL, iso_pa_sync_confirm_cb, setup, NULL, &e=
rr,
> -                       BT_IO_OPT_SOURCE_BDADDR,
> -                       btd_adapter_get_address(data->adapter),
> -                       BT_IO_OPT_DEST_BDADDR,
> -                       device_get_address(data->device),
> -                       BT_IO_OPT_DEST_TYPE,
> -                       btd_device_get_bdaddr_type(data->device),
> -                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> -                       BT_IO_OPT_QOS, &qos->bcast,
> -                       BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
> -                       BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
> -                       BT_IO_OPT_INVALID);
> -       if (!io) {
> -               error("%s", err->message);
> +       if (!bt_io_bcast_accept(data->listen_io,
> +                       iso_bcast_confirm_cb,
> +                       setup, NULL, &err,
> +                       BT_IO_OPT_ISO_BC_NUM_BIS,
> +                       iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
> +                       iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
> +               error("bt_io_bcast_accept: %s", err->message);
>                 g_error_free(err);
>         }
> -       setup->io =3D io;
> -       data->listen_io =3D io;
>
> +       setup->io =3D data->listen_io;
> +       data->listen_io =3D NULL;
>  }
>  static void setup_create_ucast_io(struct bap_data *data,
>                                         struct bap_setup *setup,
> @@ -2037,7 +1916,7 @@ done:
>         if (bt_bap_pac_get_type(setup->ep->lpac) =3D=3D BT_BAP_BCAST_SOUR=
CE)
>                 setup_connect_io_broadcast(data, setup, stream, &iso_qos)=
;
>         else
> -               setup_listen_io_broadcast(data, setup, stream, &iso_qos);
> +               setup_accept_io_broadcast(data, setup, stream, &iso_qos);
>  }
>
>  static void setup_create_io(struct bap_data *data, struct bap_setup *set=
up,
> @@ -2422,6 +2301,7 @@ static int bap_bcast_probe(struct btd_service *serv=
ice)
>         struct btd_gatt_database *database =3D btd_adapter_get_database(a=
dapter);
>         struct bap_data *data =3D btd_service_get_user_data(service);
>         char addr[18];
> +       GError *err =3D NULL;
>
>         ba2str(device_get_address(device), addr);
>
> @@ -2465,7 +2345,23 @@ static int bap_bcast_probe(struct btd_service *ser=
vice)
>
>         bt_bap_set_user_data(data->bap, service);
>
> -       bt_bap_new_bcast_source(data->bap, device_get_path(device));
> +       DBG("Create PA sync with this source");
> +       data->listen_io =3D bt_io_listen(NULL, iso_pa_sync_confirm_cb, da=
ta,
> +                       NULL, &err,
> +                       BT_IO_OPT_SOURCE_BDADDR,
> +                       btd_adapter_get_address(data->adapter),
> +                       BT_IO_OPT_DEST_BDADDR,
> +                       device_get_address(data->device),
> +                       BT_IO_OPT_DEST_TYPE,
> +                       btd_device_get_bdaddr_type(data->device),
> +                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> +                       BT_IO_OPT_QOS, &bap_sink_sync_parameters,
> +                       BT_IO_OPT_INVALID);
> +       if (!data->listen_io) {
> +               error("%s", err->message);
> +               g_error_free(err);
> +       }

I really doubt this will work in a crowded environment, it seems we
would be doing several PA Sync in parallel, one for each announcement
found, which not only would overwrite the QOS but also I don't think
controller are capable of doing multiple PA Sync like that so we might
need to serialize the process of doing short lived PA Syncs to
enumerate the BASE.

Usually we have dealt with the serialization using an idle timer which
can then check services that need to be resolved, once a service is
being resolved then the timer shall be stopped, we restart the time
everytime something needs to be resolved.

> +
>         return 0;
>  }
>
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
