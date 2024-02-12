Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77C4D5A3
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775716; cv=none; b=egkkFqUUbnvzhvUs5mlr3CMCYnXTkvf2YhuDbYPPmj0x6rO59amIa8DOhT2n84ONFJ0FUargvI+T0cu1/POGScy4SevMNaeG5rjmcpMxR2ZZLnDiZJOLpc+K3HddlVlVMgAl32B944/MJNTWrADzRgMc6CxMEaaQAN1CBWoRC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775716; c=relaxed/simple;
	bh=Ov68sZRabfLDEI1pSZ0fozX37PePHnWT5UFbYqSfMRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esCgb0VouyA1ti5aZanuFCWGMZX6ExnUUlOnmVUlEt0ohcMId94ZTmmgoRuIHEeSaqjYO5KSRMBI59yaOPv5ArkQT/ZCOXn8ipQKFx/R+hgP9o/3MsutqI3Um4MvKov6bpfS2wkjHsAmt9PRaevXH5t3bnzU3SYb9iIyAHtEO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjSUP4Y7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjSUP4Y7"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0fd07ba8bso14446791fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 14:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707775712; x=1708380512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8JXwuH2F1i10dQ/EG31hLMeJaNsEtJIA7bmYls9q4I=;
        b=hjSUP4Y71qgczR7q8SXCL6sZUf/aME19QrT0d+l5PgJ9eb7nUozCQIUsQUuRjVaR37
         zXliuIxqy5D2dRAZ2d/BmGHhFXkP8HjDKgSsveVwCaJAC7j6bRKT11HTFe3av6ePD5O8
         7c913ja6MVUGtiZi7xwORGdLHGQg1yuxrLwqptHjT4412bB786GDrsfbmHimrzdn//Z4
         KtshoxoD9f231aBtQvZILWoxVTfwbgwlSXgEQLJLi/gmO571eqHq33u2xbP02pqK0NJu
         GiWq7oMjxGNCDsFuusQc7n+UvW2Xy0dkgBqHC6QieBtHFP1yEgNtP3NA9JNK5VvuSHtk
         g1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775712; x=1708380512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8JXwuH2F1i10dQ/EG31hLMeJaNsEtJIA7bmYls9q4I=;
        b=gSC9K9FANfGlVPWfVyCOWe2mMgiB54ZgeAtBU+cFcGa6w+1tlliGAiNShV35NprCKE
         B/d7lBM9THmVIK/L4k37c7Xm2NTlZ6yZjCE4jyHtccNlwMufJJH7ATg00to5Ur1/G96O
         ++pLVvTY1pd2gzopdz2hi2EWVALptq9CeRGOQRq8AdCKZt6d4gyjHGJza3pINkiAAbPe
         hHvW4rbDXUhd0mJ6rSu9UkE4dzLKFJTbRbdrCzFMK6mVJivhpqujcmYTEwqT7Ly22uSR
         Hce5vZiPQMpV4Ib3llcvH/ZBzYA5NwEP/we2ZDEIePG2H1z76wcbJn0D48/UXTcE2pkF
         LQ+g==
X-Gm-Message-State: AOJu0YyUz8pXw2J9gxuXdnbrW6rqCRW9asltnplJdpdND8sIal1p2ykj
	TWffK4HRmxwBDmL5e1KH7Ku2RfOZ4MxC8aLOzbV7Su+ajO6kmUGiIF+CclLfCrGch359j+R1UGD
	/HPjdluVr/c+BU4KM/EqBUjlWEHA=
X-Google-Smtp-Source: AGHT+IFM4LHJTgYzodooBz1QJ9y7EZw6GWvXN1nwQeZBDhWNpDXUXIX1PNj/akxYXa2AWnfQDmvea/XRhrOmbXAOw1M=
X-Received: by 2002:a2e:88cf:0:b0:2d0:e5d1:43d1 with SMTP id
 a15-20020a2e88cf000000b002d0e5d143d1mr5154676ljk.0.1707775711149; Mon, 12 Feb
 2024 14:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209164630.92208-1-andrei.istodorescu@nxp.com> <20240209164630.92208-6-andrei.istodorescu@nxp.com>
In-Reply-To: <20240209164630.92208-6-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Feb 2024 17:08:18 -0500
Message-ID: <CABBYNZKv6pwOdVG0i0pZ09cin7B2Nn8TwndZt_yozMa84UEgXQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 5/6] bap: Do PA Sync for each BAP Broadcast
 source discovered
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Fri, Feb 9, 2024 at 11:46=E2=80=AFAM Andrei Istodorescu
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
>  profiles/audio/bap.c | 308 +++++++++++++------------------------------
>  1 file changed, 95 insertions(+), 213 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 88c93127bea0..61fb124b62c2 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -422,113 +422,6 @@ static int parse_array(DBusMessageIter *iter, struc=
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
> @@ -948,12 +841,36 @@ static DBusMessage *set_configuration(DBusConnectio=
n *conn, DBusMessage *msg,
>
>         setup =3D setup_new(ep);
>
> +       /* For BAP Broadcast Sink QOS comes from the kernel and it should=
 be set
> +        * in the setup before taking user's new values.
> +        */
> +       if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SINK) {
> +               GError *gerr =3D NULL;
> +               struct bt_iso_qos qos;
> +
> +               bt_io_get(ep->data->listen_io, &gerr,
> +                               BT_IO_OPT_QOS, &qos,
> +                               BT_IO_OPT_INVALID);
> +               bt_bap_bcast_qos_iso_to_bap(&setup->qos, &qos);
> +       }
> +
>         if (setup_parse_configuration(setup, &props) < 0) {
>                 DBG("Unable to parse configuration");
>                 setup_free(setup);
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
> @@ -977,95 +894,27 @@ static DBusMessage *set_configuration(DBusConnectio=
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
>
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
> -
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
> @@ -1074,26 +923,43 @@ static void iso_bcast_confirm_cb(GIOChannel *io, G=
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

We shall only mark it as connected when a stream is set up, before
that the device shall be considered temporary so we only keep the
devices the user is interested in.

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
> @@ -1934,12 +1800,11 @@ static void setup_listen_io(struct bap_data *data=
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
> @@ -1951,29 +1816,26 @@ static void setup_listen_io_broadcast(struct bap_=
data *data,
>
>         DBG("stream %p", stream);
>
> -       /* If IO already set skip creating it again */
> -       if (bt_bap_stream_get_io(stream) || data->listen_io)
> -               return;
> +       /* Send back to the kernel the updated QOS */
> +       if (!bt_io_set(data->listen_io, &err,
> +                       BT_IO_OPT_QOS, qos,
> +                       BT_IO_OPT_INVALID)) {
> +               error("bt_io_set: %s", err->message);
> +               g_error_free(err);
> +       }
>
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
> @@ -2037,7 +1899,7 @@ done:
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
> @@ -2422,6 +2284,7 @@ static int bap_bcast_probe(struct btd_service *serv=
ice)
>         struct btd_gatt_database *database =3D btd_adapter_get_database(a=
dapter);
>         struct bap_data *data =3D btd_service_get_user_data(service);
>         char addr[18];
> +       GError *err =3D NULL;
>
>         ba2str(device_get_address(device), addr);
>
> @@ -2465,7 +2328,26 @@ static int bap_bcast_probe(struct btd_service *ser=
vice)
>
>         bt_bap_set_user_data(data->bap, service);
>
> -       bt_bap_new_bcast_source(data->bap, device_get_path(device));
> +       /* TODO: Check that there is no other PA Sync in progress already=
.
> +        * If there is another PA Sync controller procedure in progress t=
his
> +        * one will fail.
> +        */
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
> +                       BT_IO_OPT_INVALID);
> +       if (!data->listen_io) {
> +               error("%s", err->message);
> +               g_error_free(err);
> +       }
> +
>         return 0;
>  }
>
> --
> 2.40.1

Doesn't seem to work:

bluetoothd[37]: profiles/audio/bap.c:bap_bcast_probe() Create PA sync
with this source
bluetoothd[37]: src/service.c:change_state() 0x89f540: device
0F:3A:2B:0B:92:1A profile bcaa state changed: unavailable ->
disconnected (0)
bluetoothd[37]: src/device.c:device_set_flags() flags 4
[CHG] Controller 00:AA:01:01:00:03 Discovering: yes
[NEW] Device 0F:3A:2B:0B:92:1A 0F-3A-2B-0B-92-1A
hci0 type 6 discovering off
bluetoothd[37]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x0013
[bluetooth]# scan bluetoothd[37]: src/adapter.c:discovering_callback()
hci0 type 6 discovering 0 method 0
bluetoothd[37]: src/adapter.c:trigger_start_discovery()
bluetoothd[37]: src/adapter.c:cancel_passive_scanning()
bluetoothd[37]: src/service.c:change_state() 0x89f540: device
0F:3A:2B:0B:92:1A profile bcaa state changed: disconnected ->
connected (0)
hci0 0F:3A:2B:0B:92:1A type LE Random connected eir_len 0
bluetoothd[37]: BASE len 0

> HCI Event: LE Meta Event (0x3e) plen 39                                  =
                                       #1128 [hci3] 16:51:03.376695
      LE Periodic Advertising Report (0x0f)
        Sync handle: 1
        TX power: 127 dbm (0x7f)
        RSSI: not available (0x7f)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Incomplete, more data to come
        Data length: 0x1f
        25 16 51 18 e0 99 89 01 01 06 00 00 00 00 10 02  %.Q.............
        01 03 02 02 01 03 04 28 00 05 03 03 00 00 00     .......(.......
> HCI Event: LE Meta Event (0x3e) plen 15                                  =
                                       #1129 [hci3] 16:51:03.376698
      LE Periodic Advertising Report (0x0f)
        Sync handle: 1
        TX power: 127 dbm (0x7f)
        RSSI: not available (0x7f)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x07
        00 00 00 00 00 00 00                             .......
> HCI Event: LE Meta Event (0x3e) plen 20                                  =
                                       #1130 [hci3] 16:51:03.376701
      LE Broadcast Isochronous Group Info Advertising Report (0x22)
        Sync Handle: 0x0001
        Number BIS: 1
        NSE: 1
        ISO Interval: 10.00 msec (0x0008)
        BN: 1
        PTO: 1
        IRC: 1
        Maximum PDU: 40
        SDU Interval: 10000 us (0x002710)
        Maximum SDU: 40
        PHY: LE 2M (0x02)
        Framing: Unframed (0x00)
        Encryption: 0x00

Sounds like it is a kernel problem since it seems to not be passing
the BASE back to usespace, or perhaps it is something with
BT_IO_OPT_BASE, we may be missing a test for BT_ISO_BASE in iso-tester
so we can check that it is reading it properly as it seem we only do
set via setsockopt but we don't have any instance of reading it with
getsockopt.

--=20
Luiz Augusto von Dentz
