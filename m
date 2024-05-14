Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94016158213
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697761; cv=none; b=ZRk+3M2D1kE0YBGmbMFoBT4AxQVYadj6bf9kqbCeasu+0i+ZjlTPrH7WpwBB36ZtAHb7yufbYA6L2ryxV/rDeBuaUVqd9ZKAX5VatYxQSRoGr6WPTQMZPz6iP+von84x6cJrUxEd8/lTUdeU/Ol9MT/dncI8IJ5T7b/g8lIHy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697761; c=relaxed/simple;
	bh=TXETNvHZquHK3YGFMR0ef1NCtZ4eX2BSe18ChaDCMO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mojk04pArAAphSUTpVSbR9vu/i4Bdr4+ptTZQx3UTn9PBp1SC1nnFOlMGBqZvjqhW1z3jaD3eLf1E4/a1ZaoLS8i0ZSk+uTp7+V6zwJo5pJqxSR9ZOC4c3DncOl7u3FTzuReeRnh49oBa33vKGTwYsXC/Bi3GLpBmPlHf1m5njA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPdpLU3P; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPdpLU3P"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e564cad1f1so49281461fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715697756; x=1716302556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTYt/qIzm95c6EgCoi/MH80Y/+cXJr3xGfTzbyvZPi4=;
        b=cPdpLU3PCZZAsnoQqx8oPXZnjUk3pmEFw6EhJjy+vc2G/AfArpAjN/m8HO56ll0tT1
         I4VZ2nLqSdzJb5Vyp/5wh7YdgfMPL6cmaZE5COz+a8GH3oSAZfiesEZAmwt0vklva/J2
         CYoF00qjBTaxxZkGqapqTmBReY1g6T4U1P9TLtPmju9+8KPQst1WDGBbxicVbIdKEfWs
         EVpGWXUgrwrZfxNVgDS3Kml0gwYhc6Q8x0kaghlGGSIDiaaFKmo2Hk6+/vqX3508wWvB
         PCUmiBcRYEr4wRr4wqq0OEUWk24a75wT36yFobnXJvkiNQSqIMv5Wg1JZzm/xMzsMMZ5
         ZM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715697756; x=1716302556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTYt/qIzm95c6EgCoi/MH80Y/+cXJr3xGfTzbyvZPi4=;
        b=TfW0OtaOGVHWyqaZZFXPeaBIDx7d9jSWwjsFUbluUR/qXhDy70Xnloehd3xUcdFE/5
         rrHK0Xs++Z/vZQCZy1LTonXLaD7tqnqw3dnOUjsQgxbzyQVqK404BUxAMR3FJ3vx5WAE
         8knBlRRO8Qpan/OdkE3pLaQFHBT/DAe8Ae6RrWlsrB2y70zz/8eY5b5RrhcAtivLMKhu
         M8AL6cLUg/90GW2EZLO2Oni7ZSMEFuQE2FuCZU+lmPU/2lRxaC7dzyKFICvAyv1vZlMm
         UXGlgP+i6r98OjvcOHNN6Hri1Q/+35rX76yoBVwT9133ZW4MK0NopAt5yGJAu/Jz0af4
         /zBQ==
X-Gm-Message-State: AOJu0Yye6pR1JcKbw6b7QAzS4HU52Yt7rZ/B0Jed+BX5O/cTtwpb5B5u
	7mDtSl27LTEGv2wOTub384WG0HCFxj0wyy6ebydhTDf2sfr9kV33AxE+iBjOOPCj9qx7WlY6Ps5
	K4fvIeJuKYe/Ws3HDCYpKghB6fh85B4Sz
X-Google-Smtp-Source: AGHT+IGIU6gbUrBp5KbLWpaJJY7yLN4LkGu6Q8M5Kmdm7uxGO2f5ePKNL1v8ej21KyKdlZ4eFuQMCIQRqQ+ZzS7Vh8Y=
X-Received: by 2002:a2e:b602:0:b0:2dd:c6c8:dff4 with SMTP id
 38308e7fff4ca-2e51fe57df2mr78289271fa.24.1715697755995; Tue, 14 May 2024
 07:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514113914.21048-1-andrei.istodorescu@nxp.com> <20240514113914.21048-3-andrei.istodorescu@nxp.com>
In-Reply-To: <20240514113914.21048-3-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 May 2024 10:42:23 -0400
Message-ID: <CABBYNZJKWz342-jepQcZGQo4Kja0J560UBboadN5CD7LLyDQ=Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 2/2] bap: Create transports for matching BISes
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Tue, May 14, 2024 at 7:39=E2=80=AFAM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> Rename bt_bap_add_bis to bt_bap_check_bis. This function is now an
> utilitary for checking if the information from a BIS is matching the
> capabilities in bt_bap. This utilitary is used when parsing the BASE
> data so that we can decide if we create a new setup/stream/transport for
> it, or advance to the next BIS.
> When checking in local PACS for a BIS match, return also the local PAC,
> along with the status of the operation. This information is required
> later when we create the stream.
>
> Use the BIS index received in the BASE to synchronize to the BIG.
> Allow bt_bap_endpoint to be NULL.
> Remove the Broadcast Sink code from set_configuration.
> Update BASE parsing so that it creates streams and transports, without a
> remote PAC and endpoint.
> Update bap_find_setup_by_stream to find the setup in case the stream does
> not contain an endpoint.
> ---
>  profiles/audio/bap.c | 323 ++++++++++++++++++++++++++++++-------------
>  src/shared/bap.c     | 227 ++++++++++++++++--------------
>  src/shared/bap.h     |   6 +-
>  3 files changed, 357 insertions(+), 199 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index f09f2ea44109..eb321f33386a 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -115,6 +115,7 @@ struct bap_data {
>         struct queue *srcs;
>         struct queue *snks;
>         struct queue *bcast;
> +       struct queue *bcast_snks;
>         struct queue *streams;
>         GIOChannel *listen_io;
>         int selecting;
> @@ -131,7 +132,10 @@ struct bap_bcast_pa_req {
>         bool in_progress;
>         union {
>                 struct btd_service *service;
> -               struct bap_setup *setup;
> +               struct bap_accept {
> +                       struct bap_setup *setup;
> +                       struct bap_data *bap_data;
> +               } accept_data;

Don't really like the idea of using nested structs like this, make it
confusing imo, besides can't you actually access the bap_data via
btd_device_get_user_data?

>         } data;
>  };
>
> @@ -202,6 +206,8 @@ static void ep_unregister(void *data)
>                                                 MEDIA_ENDPOINT_INTERFACE)=
;
>  }
>
> +static void setup_free(void *data);
> +
>  static void bap_data_free(struct bap_data *data)
>  {
>         if (data->listen_io) {
> @@ -218,6 +224,7 @@ static void bap_data_free(struct bap_data *data)
>         queue_destroy(data->srcs, ep_unregister);
>         queue_destroy(data->bcast, ep_unregister);
>         queue_destroy(data->streams, NULL);
> +       queue_destroy(data->bcast_snks, setup_free);
>         bt_bap_ready_unregister(data->bap, data->ready_id);
>         bt_bap_state_unregister(data->bap, data->state_id);
>         bt_bap_pac_unregister(data->bap, data->pac_id);
> @@ -855,7 +862,11 @@ static struct bap_setup *setup_new(struct bap_ep *ep=
)
>         setup =3D new0(struct bap_setup, 1);
>         setup->ep =3D ep;
>
> -       if (queue_find(ep->data->bcast, NULL, ep)) {
> +       /* Broadcast Source has endpoints in bcast list, Broadcast Sink
> +        * does not have endpoints
> +        */
> +       if (((ep !=3D NULL) && queue_find(ep->data->bcast, NULL, ep)) ||
> +                       (ep =3D=3D NULL)) {
>                 /* Mark BIG and BIS to be auto assigned */
>                 setup->qos.bcast.big =3D BT_ISO_QOS_BIG_UNSET;
>                 setup->qos.bcast.bis =3D BT_ISO_QOS_BIS_UNSET;
> @@ -871,12 +882,14 @@ static struct bap_setup *setup_new(struct bap_ep *e=
p)
>                 setup->qos_parser =3D setup_parse_ucast_qos;
>         }
>
> -       if (!ep->setups)
> -               ep->setups =3D queue_new();
> +       if (ep) {
> +               if (!ep->setups)
> +                       ep->setups =3D queue_new();
>
> -       queue_push_tail(ep->setups, setup);
> +               queue_push_tail(ep->setups, setup);
>
> -       DBG("ep %p setup %p", ep, setup);
> +               DBG("ep %p setup %p", ep, setup);
> +       }
>
>         return setup;
>  }
> @@ -947,17 +960,6 @@ static DBusMessage *set_configuration(DBusConnection=
 *conn, DBusMessage *msg,
>                 return btd_error_invalid_args(msg);
>         }
>
> -       /* For BAP Broadcast Sink, the capabilities and metadata are comi=
ng
> -        * from the source's BIS, which are present in the remote PAC
> -        */
> -       if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SINK) {
> -               util_iov_free(setup->caps, 1);
> -               setup->caps =3D util_iov_dup(bt_bap_pac_get_data(ep->rpac=
), 1);
> -               util_iov_free(setup->metadata, 1);
> -               setup->metadata =3D util_iov_dup(
> -                               bt_bap_pac_get_metadata(ep->rpac), 1);
> -       }
> -
>         setup->stream =3D bt_bap_stream_new(ep->data->bap, ep->lpac, ep->=
rpac,
>                                                 &setup->qos, setup->caps)=
;
>         bt_bap_stream_set_user_data(setup->stream, ep->path);
> @@ -993,20 +995,27 @@ static DBusMessage *set_configuration(DBusConnectio=
n *conn, DBusMessage *msg,
>  static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user=
_data)
>  {
>         struct bap_bcast_pa_req *req =3D user_data;
> -       struct bap_setup *setup =3D req->data.setup;
> +       struct bap_setup *setup =3D req->data.accept_data.setup;
>         int fd;
>
>         DBG("BIG Sync completed");
>
> -       queue_remove(setup->ep->data->adapter->bcast_pa_requests, req);
> +       g_io_channel_unref(setup->io);
> +       g_io_channel_shutdown(setup->io, TRUE, NULL);
> +       setup->io =3D NULL;
>
>         /* This device is no longer needed */
> -       btd_service_connecting_complete(setup->ep->data->service, 0);
> +       btd_service_connecting_complete(req->data.accept_data.bap_data->s=
ervice,
> +                       0);
>
>         fd =3D g_io_channel_unix_get_fd(io);
>
> +       queue_remove(req->data.accept_data.bap_data->adapter->bcast_pa_re=
quests,
> +                               req);
> +       free(req);
> +
>         if (bt_bap_stream_set_io(setup->stream, fd)) {
> -               bt_bap_stream_enable(setup->stream, true, NULL, NULL, NUL=
L);
> +               bt_bap_stream_start(setup->stream, NULL, NULL);
>                 g_io_channel_set_close_on_unref(io, FALSE);
>                 return;
>         }
> @@ -1019,8 +1028,54 @@ static void print_ltv(size_t i, uint8_t l, uint8_t=
 t, uint8_t *v,
>         util_hexdump(' ', v, l, user_data, NULL);
>  }
>
> -static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
> -               util_debug_func_t func)
> +static void create_stream_for_bis(struct bap_data *bap_data,
> +               struct bt_bap_pac *lpac, struct bt_iso_qos *qos,
> +               struct iovec *caps, struct iovec *meta, char *path)
> +{
> +       struct bap_setup *setup;
> +
> +       setup =3D setup_new(NULL);
> +
> +       /* Create BAP QoS structure */
> +       setup->qos.bcast.big =3D qos->bcast.big;
> +       setup->qos.bcast.bis =3D qos->bcast.bis;
> +       setup->qos.bcast.sync_factor =3D qos->bcast.sync_factor;
> +       setup->qos.bcast.packing =3D qos->bcast.packing;
> +       setup->qos.bcast.framing =3D qos->bcast.framing;
> +       setup->qos.bcast.encryption =3D qos->bcast.encryption;
> +       if (setup->qos.bcast.encryption)
> +               util_iov_append(setup->qos.bcast.bcode,
> +                               qos->bcast.bcode,
> +                               sizeof(qos->bcast.bcode));
> +       setup->qos.bcast.options =3D qos->bcast.options;
> +       setup->qos.bcast.skip =3D qos->bcast.skip;
> +       setup->qos.bcast.sync_timeout =3D qos->bcast.sync_timeout;
> +       setup->qos.bcast.sync_cte_type =3D
> +                       qos->bcast.sync_cte_type;
> +       setup->qos.bcast.mse =3D qos->bcast.mse;
> +       setup->qos.bcast.timeout =3D qos->bcast.timeout;
> +       setup->qos.bcast.io_qos.interval =3D
> +                       qos->bcast.in.interval;
> +       setup->qos.bcast.io_qos.latency =3D qos->bcast.in.latency;
> +       setup->qos.bcast.io_qos.phy =3D qos->bcast.in.phy;
> +       setup->qos.bcast.io_qos.rtn =3D qos->bcast.in.rtn;
> +       setup->qos.bcast.io_qos.sdu =3D qos->bcast.in.sdu;
> +
> +       queue_push_tail(bap_data->bcast_snks, setup);
> +
> +       /* Create and configure stream */
> +       setup->stream =3D bt_bap_stream_new(bap_data->bap,
> +                       lpac, NULL, &setup->qos, caps);
> +
> +       bt_bap_stream_set_user_data(setup->stream, path);
> +       bt_bap_stream_config(setup->stream, &setup->qos,
> +                       caps, NULL, NULL);
> +       bt_bap_stream_metadata(setup->stream, meta,
> +                       NULL, NULL);
> +}
> +
> +static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *ba=
se,
> +               struct bt_iso_qos *qos, util_debug_func_t func)
>  {
>         struct iovec iov =3D {
>                 .iov_base =3D base->base,
> @@ -1099,6 +1154,10 @@ static bool parse_base(struct bt_bap *bap, struct =
bt_iso_base *base,
>                 for (; num_bis; num_bis--) {
>                         uint8_t bis_index;
>                         struct iovec *l3_caps;
> +                       struct iovec *merged_caps;
> +                       struct bt_bap_pac *matched_lpac;
> +                       char *path;
> +                       int err;
>
>                         if (!util_iov_pull_u8(&iov, &bis_index)) {
>                                 ret =3D false;
> @@ -1106,6 +1165,11 @@ static bool parse_base(struct bt_bap *bap, struct =
bt_iso_base *base,
>                         }
>
>                         util_debug(func, NULL, "BIS #%d", bis_index);
> +                       err =3D asprintf(&path, "%s/bis%d",
> +                                       device_get_path(bap_data->device)=
,
> +                                       bis_index);
> +                       if (err < 0)
> +                               continue;
>
>                         /* Read Codec Specific Configuration */
>                         l3_caps =3D new0(struct iovec, 1);
> @@ -1128,9 +1192,16 @@ static bool parse_base(struct bt_bap *bap, struct =
bt_iso_base *base,
>                                         l3_caps->iov_len, NULL, print_ltv=
,
>                                         func);
>
> -                       /* Try to create a PAC using this BIS information=
 */
> -                       bt_bap_add_bis(bap, bis_index, &codec, l2_caps, l=
3_caps,
> -                                       meta);
> +                       /* Check if this BIS matches any local PAC */
> +                       bt_bap_verify_bis(bap_data->bap, bis_index, &code=
c,
> +                                       l2_caps, l3_caps, &matched_lpac,
> +                                       &merged_caps);
> +
> +                       if (matched_lpac =3D=3D NULL || merged_caps =3D=
=3D NULL)
> +                               continue;
> +
> +                       create_stream_for_bis(bap_data, matched_lpac, qos=
,
> +                                       merged_caps, meta, path);
>                 }
>
>  group_fail:
> @@ -1175,12 +1246,16 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io=
, void *user_data)
>         g_io_channel_unref(data->listen_io);
>         g_io_channel_shutdown(io, TRUE, NULL);
>         data->listen_io =3D NULL;
> -       queue_remove(data->adapter->bcast_pa_requests, req);
> -       free(req);
> +
>         /* Analyze received BASE data and create remote media endpoints f=
or each
>          * BIS matching our capabilities
>          */
> -       parse_base(data->bap, &base, bap_debug);
> +       parse_base(data, &base, &qos, bap_debug);
> +
> +       service_set_connecting(req->data.service);
> +
> +       queue_remove(data->adapter->bcast_pa_requests, req);
> +       free(req);
>  }
>
>  static bool match_data_bap_data(const void *data, const void *match_data=
)
> @@ -1583,6 +1658,7 @@ static struct bap_setup *bap_find_setup_by_stream(s=
truct bap_data *data,
>                                         struct bt_bap_stream *stream)
>  {
>         struct bap_ep *ep =3D NULL;
> +       struct queue *queue =3D NULL;
>
>         switch (bt_bap_stream_get_type(stream)) {
>         case BT_BAP_STREAM_TYPE_UCAST:
> @@ -1597,9 +1673,11 @@ static struct bap_setup *bap_find_setup_by_stream(=
struct bap_data *data,
>         }
>
>         if (ep)
> -               return queue_find(ep->setups, match_setup_stream, stream)=
;
> +               queue =3D ep->setups;
> +       else
> +               queue =3D data->bcast_snks;
>
> -       return NULL;
> +       return queue_find(queue, match_setup_stream, stream);
>  }
>
>  static void iso_connect_bcast_cb(GIOChannel *chan, GError *err,
> @@ -2141,7 +2219,8 @@ static void setup_accept_io_broadcast(struct bap_da=
ta *data,
>          */
>         req->type =3D BAP_PA_BIG_SYNC_REQ;
>         req->in_progress =3D FALSE;
> -       req->data.setup =3D setup;
> +       req->data.accept_data.setup =3D setup;
> +       req->data.accept_data.bap_data =3D data;
>         queue_push_tail(adapter->bcast_pa_requests, req);
>  }
>
> @@ -2201,7 +2280,7 @@ static void setup_create_bcast_io(struct bap_data *=
data,
>         memcpy(&iso_qos.bcast.out, &setup->qos.bcast.io_qos,
>                                 sizeof(struct bt_iso_io_qos));
>
> -       if (bt_bap_pac_get_type(setup->ep->lpac) =3D=3D BT_BAP_BCAST_SOUR=
CE)
> +       if (bt_bap_stream_get_dir(stream) =3D=3D BT_BAP_BCAST_SINK)
>                 setup_connect_io_broadcast(data, setup, stream, &iso_qos,
>                         defer);
>         else
> @@ -2413,7 +2492,7 @@ static uint8_t get_streams_nb_by_state(struct bap_s=
etup *setup)
>         return stream_cnt;
>  }
>
> -static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_st=
ate,
> +static void bap_state_bcast_src(struct bt_bap_stream *stream, uint8_t ol=
d_state,
>                                 uint8_t new_state, void *user_data)
>  {
>         struct bap_data *data =3D user_data;
> @@ -2442,66 +2521,96 @@ static void bap_state_bcast(struct bt_bap_stream =
*stream, uint8_t old_state,
>         case BT_BAP_STREAM_STATE_CONFIG:
>                 if (!setup || setup->id)
>                         break;
> -               if (bt_bap_stream_io_dir(stream) =3D=3D
> -                               BT_BAP_BCAST_SOURCE)
> -                       /* If the stream is attached to a
> -                        * broadcast sink endpoint.
> -                        */
> -                       setup_create_io(data, setup, stream, defer);
> -               else {
> -                       /* If the stream attached to a broadcast
> -                        * source endpoint generate the base.
> -                        */
> -                       if (setup->base =3D=3D NULL) {
> -                               setup->base =3D bt_bap_stream_get_base(
> -                                               setup->stream);
> -                               /* Set the generated BASE on all setups
> -                                * from the same BIG.
> -                                */
> -                               queue_foreach(setup->ep->setups,
> -                                       iterate_setup_update_base, setup)=
;
> -                       }
> -                       /* The kernel has 2 requirements when handling
> -                        * multiple BIS connections for the same BIG:
> -                        * 1 - setup_create_io for all but the last BIS
> -                        * must be with defer true so we can inform the
> -                        * kernel when to start the BIG.
> -                        * 2 - The order in which the setup_create_io
> -                        * are called must be in the order of BIS
> -                        * indexes in BASE from first to last.
> -                        * To address this requirement we will call
> -                        * setup_create_io on all BISes only when all
> -                        * transport acquire have been received and will
> -                        * send it in the order of the BIS index
> -                        * from BASE.
> +               /* If the stream attached to a broadcast
> +                * source endpoint generate the base.
> +                */
> +               if (setup->base =3D=3D NULL) {
> +                       setup->base =3D bt_bap_stream_get_base(
> +                                       setup->stream);
> +                       /* Set the generated BASE on all setups
> +                        * from the same BIG.
>                          */
> -                       nb_bises =3D get_streams_nb_by_state(setup);
> -
> -                       if (nb_bises =3D=3D 1) {
> -                               setup_create_io(data, setup,
> -                               stream, defer);
> -                               if (!setup->io) {
> -                                       error("Unable to create io");
> -                                       if (old_state !=3D
> -                                               BT_BAP_STREAM_STATE_RELEA=
SING)
> -                                               bt_bap_stream_release(str=
eam,
> -                                                               NULL, NUL=
L);
> -                               }
> -                               break;
> -                       } else if (nb_bises =3D=3D 0)
> -                               break;
> +                       queue_foreach(setup->ep->setups,
> +                               iterate_setup_update_base, setup);
> +               }
> +               /* The kernel has 2 requirements when handling
> +                * multiple BIS connections for the same BIG:
> +                * 1 - setup_create_io for all but the last BIS
> +                * must be with defer true so we can inform the
> +                * kernel when to start the BIG.
> +                * 2 - The order in which the setup_create_io
> +                * are called must be in the order of BIS
> +                * indexes in BASE from first to last.
> +                * To address this requirement we will call
> +                * setup_create_io on all BISes only when all
> +                * transport acquire have been received and will
> +                * send it in the order of the BIS index
> +                * from BASE.
> +                */
> +               nb_bises =3D get_streams_nb_by_state(setup);
>
> -                       if (!create_io_bises(setup, nb_bises, data)) {
> +               if (nb_bises =3D=3D 1) {
> +                       setup_create_io(data, setup,
> +                       stream, defer);
> +                       if (!setup->io) {
> +                               error("Unable to create io");
>                                 if (old_state !=3D
>                                         BT_BAP_STREAM_STATE_RELEASING)
>                                         bt_bap_stream_release(stream,
> -                                               NULL, NULL);
> +                                                       NULL, NULL);
>                         }
> +                       break;
> +               } else if (nb_bises =3D=3D 0)
> +                       break;
> +
> +               if (!create_io_bises(setup, nb_bises, data)) {
> +                       if (old_state !=3D
> +                               BT_BAP_STREAM_STATE_RELEASING)
> +                               bt_bap_stream_release(stream,
> +                                       NULL, NULL);
>                 }
>                 break;
>         }
>  }
>
> +static void bap_state_bcast_sink(struct bt_bap_stream *stream,
> +                               uint8_t old_state, uint8_t new_state,
> +                               void *user_data)
> +{
> +       struct bap_data *data =3D user_data;
> +       struct bap_setup *setup;
> +       bool defer =3D false;
> +
> +       DBG("stream %p: %s(%u) -> %s(%u)", stream,
> +                       bt_bap_stream_statestr(old_state), old_state,
> +                       bt_bap_stream_statestr(new_state), new_state);
> +
> +       if (new_state =3D=3D old_state && new_state !=3D BT_BAP_STREAM_ST=
ATE_CONFIG)
> +               return;
> +
> +       setup =3D bap_find_setup_by_stream(data, stream);
> +
> +       switch (new_state) {
> +       case BT_BAP_STREAM_STATE_IDLE:
> +               /* Release stream if idle */
> +               if (setup)
> +                       setup_free(setup);
> +               else
> +                       queue_remove(data->streams, stream);
> +               break;
> +       case BT_BAP_STREAM_STATE_CONFIG:
> +               if (!setup)
> +                       break;
> +               if (old_state =3D=3D
> +                               BT_BAP_STREAM_STATE_CONFIG)
> +                       setup_create_io(data, setup, stream, defer);
> +               if (old_state =3D=3D
> +                               BT_BAP_STREAM_STATE_STREAMING)
> +                       setup_io_close(setup, NULL);
> +               break;
> +       }
> +}
> +
>  static void pac_added(struct bt_bap_pac *pac, void *user_data)
>  {
>         struct btd_service *service =3D user_data;
> @@ -2847,29 +2956,50 @@ static void iso_do_big_sync(GIOChannel *io, void =
*user_data)
>  {
>         GError *err =3D NULL;
>         struct bap_bcast_pa_req *req =3D user_data;
> -       struct bap_setup *setup =3D req->data.setup;
> -       struct bap_data *data =3D setup->ep->data;
> +       struct bap_setup *setup =3D req->data.accept_data.setup;
> +       struct bap_data *data =3D req->data.accept_data.bap_data;
>         struct sockaddr_iso_bc iso_bc_addr;
>         struct bt_iso_qos qos;
> +       char *path;
> +       int bis_index =3D 1;
> +       int s_err;
> +       const char *strbis =3D NULL;
>
> -       DBG("PA Sync done, do BIG Sync");
> +       DBG("PA Sync done");
>         g_io_channel_unref(setup->io);
> -       setup->io =3D NULL;
> -
> +       g_io_channel_shutdown(setup->io, TRUE, NULL);
>         setup->io =3D io;
>         g_io_channel_ref(setup->io);
>
>         /* TODO
>          * We can only synchronize with a single BIS to a BIG.
>          * In order to have multiple BISes targeting this BIG we need to =
have
> -        * all the BISes before doing this request. This request is trigg=
ered
> -        * by an endpoint "SetConfiguration" command. For multiple BISes
> -        * we need another way to specify which BISes user is requesting
> +        * all the BISes before doing bt_io_bcast_accept.
> +        * This request comes from a transport "Acquire" call.
> +        * For multiple BISes in the same BIG we need to either wait for =
all
> +        * transports in the same BIG to be acquired or tell when to do t=
he
> +        * bt_io_bcast_accept by other means
>          */
> +       path =3D bt_bap_stream_get_user_data(setup->stream);
> +
> +       strbis =3D strstr(path, "/bis");
> +       if (strbis =3D=3D NULL) {
> +               DBG("bis index cannot be found");
> +               return;
> +       }
> +
> +       s_err =3D sscanf(strbis, "/bis%d", &bis_index);
> +       if (s_err =3D=3D -1) {
> +               DBG("sscanf error");
> +               return;
> +       }
> +
> +       DBG("Do BIG Sync with BIS %d", bis_index);
> +
>         iso_bc_addr.bc_bdaddr_type =3D btd_device_get_bdaddr_type(data->d=
evice);
>         memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
>                         sizeof(bdaddr_t));
> -       iso_bc_addr.bc_bis[0] =3D 1;
> +       iso_bc_addr.bc_bis[0] =3D bis_index;
>         iso_bc_addr.bc_num_bis =3D 1;
>
>         /* Set the user requested QOS */
> @@ -2913,8 +3043,8 @@ static void iso_do_big_sync(GIOChannel *io, void *u=
ser_data)
>  static void pa_and_big_sync(struct bap_bcast_pa_req *req)
>  {
>         GError *err =3D NULL;
> -       struct bap_setup *setup =3D req->data.setup;
> -       struct bap_data *data =3D setup->ep->data;
> +       struct bap_setup *setup =3D req->data.accept_data.setup;
> +       struct bap_data *data =3D req->data.accept_data.bap_data;
>
>         req->in_progress =3D TRUE;
>
> @@ -2967,6 +3097,7 @@ static int bap_bcast_probe(struct btd_service *serv=
ice)
>                 free(data);
>                 return -EINVAL;
>         }
> +       data->bcast_snks =3D queue_new();
>
>         if (!bt_bap_attach(data->bap, NULL)) {
>                 error("BAP unable to attach");
> @@ -2977,7 +3108,7 @@ static int bap_bcast_probe(struct btd_service *serv=
ice)
>
>         data->ready_id =3D bt_bap_ready_register(data->bap, bap_ready, se=
rvice,
>                                                                 NULL);
> -       data->state_id =3D bt_bap_state_register(data->bap, bap_state_bca=
st,
> +       data->state_id =3D bt_bap_state_register(data->bap, bap_state_bca=
st_sink,
>                                         bap_connecting_bcast, data, NULL)=
;
>         data->pac_id =3D bt_bap_pac_register(data->bap, pac_added_broadca=
st,
>                                 pac_removed_broadcast, data, NULL);
> @@ -3160,7 +3291,7 @@ static int bap_adapter_probe(struct btd_profile *p,=
 struct btd_adapter *adapter)
>                 return -EINVAL;
>         }
>
> -       data->state_id =3D bt_bap_state_register(data->bap, bap_state_bca=
st,
> +       data->state_id =3D bt_bap_state_register(data->bap, bap_state_bca=
st_src,
>                                         bap_connecting_bcast, data, NULL)=
;
>         data->pac_id =3D bt_bap_pac_register(data->bap, pac_added_broadca=
st,
>                                         pac_removed_broadcast, data, NULL=
);

Let's split the changes to src/shared/, that always should be
self-contained as much as possible since it has a different license
and is subject to unit tests.

> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 919ecbb6a016..fe91cd67f491 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -226,6 +226,7 @@ struct bt_bap_stream_io {
>  struct bt_bap_stream_ops {
>         uint8_t type;
>         void (*set_state)(struct bt_bap_stream *stream, uint8_t state);
> +       unsigned int (*get_state)(struct bt_bap_stream *stream);
>         unsigned int (*config)(struct bt_bap_stream *stream,
>                                 struct bt_bap_qos *qos, struct iovec *dat=
a,
>                                 bt_bap_stream_func_t func, void *user_dat=
a);
> @@ -245,6 +246,8 @@ struct bt_bap_stream_ops {
>         unsigned int (*metadata)(struct bt_bap_stream *stream,
>                                 struct iovec *data, bt_bap_stream_func_t =
func,
>                                 void *user_data);
> +       unsigned int (*get_dir)(struct bt_bap_stream *stream);
> +       unsigned int (*get_loc)(struct bt_bap_stream *stream);
>         unsigned int (*release)(struct bt_bap_stream *stream,
>                                 bt_bap_stream_func_t func, void *user_dat=
a);
>  };
> @@ -1578,6 +1581,11 @@ done:
>         bap_stream_state_changed(stream);
>  }
>
> +static unsigned int bap_ucast_get_state(struct bt_bap_stream *stream)
> +{
> +       return stream->ep->state;
> +}
> +
>  static unsigned int bap_ucast_config(struct bt_bap_stream *stream,
>                                         struct bt_bap_qos *qos,
>                                         struct iovec *data,
> @@ -1923,6 +1931,27 @@ static bool bap_stream_valid(struct bt_bap_stream =
*stream)
>         return queue_find(stream->bap->streams, NULL, stream);
>  }
>
> +static unsigned int bap_ucast_get_dir(struct bt_bap_stream *stream)
> +{
> +       return stream->ep->dir;
> +}
> +
> +static unsigned int bap_ucast_get_location(struct bt_bap_stream *stream)
> +{
> +       struct bt_pacs *pacs;
> +
> +       if (!stream)
> +               return 0x00000000;
> +
> +       pacs =3D stream->client ? stream->bap->rdb->pacs : stream->bap->l=
db->pacs;
> +
> +       if (stream->ep->dir =3D=3D BT_BAP_SOURCE)
> +               return pacs->source_loc_value;
> +       else if (stream->ep->dir =3D=3D BT_BAP_SINK)
> +               return pacs->sink_loc_value;
> +       return 0x00000000;
> +}
> +
>  static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
>                                         bt_bap_stream_func_t func,
>                                         void *user_data)
> @@ -2000,6 +2029,11 @@ static void bap_bcast_set_state(struct bt_bap_stre=
am *stream, uint8_t state)
>         }
>  }
>
> +static unsigned int bap_bcast_get_state(struct bt_bap_stream *stream)
> +{
> +       return stream->state;
> +}
> +
>  static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
>                                         bool enable_links, struct iovec *=
data,
>                                         bt_bap_stream_func_t func,
> @@ -2019,6 +2053,17 @@ static unsigned int bap_bcast_start(struct bt_bap_=
stream *stream,
>         return 1;
>  }
>
> +static unsigned int bap_bcast_sink_disable(struct bt_bap_stream *stream,
> +                                       bool disable_links,
> +                                       bt_bap_stream_func_t func,
> +                                       void *user_data)
> +{
> +       bap_stream_io_detach(stream);
> +       stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> +
> +       return 1;
> +}
> +
>  static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
>                                         bool disable_links,
>                                         bt_bap_stream_func_t func,
> @@ -2040,6 +2085,43 @@ static unsigned int bap_bcast_metadata(struct bt_b=
ap_stream *stream,
>         return 1;
>  }
>
> +static unsigned int bap_bcast_src_get_dir(struct bt_bap_stream *stream)
> +{
> +       return BT_BAP_BCAST_SINK;
> +}
> +
> +static unsigned int bap_bcast_sink_get_dir(struct bt_bap_stream *stream)
> +{
> +       return BT_BAP_BCAST_SOURCE;
> +}
> +
> +static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
> +               uint8_t *v, void *user_data)
> +{
> +       uint32_t location32;
> +
> +       if (!v)
> +               return;
> +
> +       memcpy(&location32, v, l);
> +       *((uint32_t *)user_data) =3D le32_to_cpu(location32);
> +}
> +
> +static unsigned int bap_bcast_get_location(struct bt_bap_stream *stream)
> +{
> +       uint8_t type =3D BAP_CHANNEL_ALLOCATION_LTV_TYPE;
> +       uint32_t allocation =3D 0;
> +       struct iovec *caps;
> +
> +       caps =3D bt_bap_stream_get_config(stream);
> +
> +       /* Get stream allocation from capabilities */
> +       util_ltv_foreach(caps->iov_base, caps->iov_len, &type,
> +                       bap_sink_get_allocation, &allocation);
> +
> +       return allocation;
> +}
> +
>  static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
>                                         bt_bap_stream_func_t func,
>                                         void *user_data)
> @@ -2049,11 +2131,12 @@ static unsigned int bap_bcast_release(struct bt_b=
ap_stream *stream,
>         return 1;
>  }
>
> -#define STREAM_OPS(_type, _set_state, _config, _qos, _enable, _start, \
> -                       _disable, _stop, _metadata, _release) \
> +#define STREAM_OPS(_type, _set_state, _get_state, _config, _qos, _enable=
, \
> +       _start, _disable, _stop, _metadata, _get_dir, _get_loc, _release)=
 \
>  { \
>         .type =3D _type, \
>         .set_state =3D _set_state, \
> +       .get_state =3D _get_state, \
>         .config =3D _config, \
>         .qos =3D _qos, \
>         .enable =3D _enable, \
> @@ -2061,26 +2144,40 @@ static unsigned int bap_bcast_release(struct bt_b=
ap_stream *stream,
>         .disable =3D _disable, \
>         .stop =3D _stop, \
>         .metadata =3D _metadata, \
> +       .get_dir =3D _get_dir,\
> +       .get_loc =3D _get_loc, \
>         .release =3D _release, \
>  }
>
>  static const struct bt_bap_stream_ops stream_ops[] =3D {
>         STREAM_OPS(BT_BAP_SINK, bap_ucast_set_state,
> +                       bap_ucast_get_state,
>                         bap_ucast_config, bap_ucast_qos, bap_ucast_enable=
,
>                         bap_ucast_start, bap_ucast_disable, bap_ucast_sto=
p,
> -                       bap_ucast_metadata, bap_ucast_release),
> +                       bap_ucast_metadata, bap_ucast_get_dir,
> +                       bap_ucast_get_location,
> +                       bap_ucast_release),
>         STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
> +                       bap_ucast_get_state,
>                         bap_ucast_config, bap_ucast_qos, bap_ucast_enable=
,
>                         bap_ucast_start, bap_ucast_disable, bap_ucast_sto=
p,
> -                       bap_ucast_metadata, bap_ucast_release),
> +                       bap_ucast_metadata, bap_ucast_get_dir,
> +                       bap_ucast_get_location,
> +                       bap_ucast_release),
>         STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
> +                       bap_bcast_get_state,
>                         bap_bcast_config, NULL, bap_bcast_enable,
> -                       bap_bcast_start, bap_bcast_disable, NULL,
> -                       bap_bcast_metadata, bap_bcast_release),
> +                       bap_bcast_start, bap_bcast_sink_disable, NULL,
> +                       bap_bcast_metadata, bap_bcast_sink_get_dir,
> +                       bap_bcast_get_location,
> +                       bap_bcast_release),
>         STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
> +                       bap_bcast_get_state,
>                         bap_bcast_config, NULL, bap_bcast_enable,
>                         bap_bcast_start, bap_bcast_disable, NULL,
> -                       bap_bcast_metadata, bap_bcast_release),
> +                       bap_bcast_metadata, bap_bcast_src_get_dir,
> +                       bap_bcast_get_location,
> +                       bap_bcast_release),
>  };
>
>  static const struct bt_bap_stream_ops *
> @@ -5380,11 +5477,7 @@ uint8_t bt_bap_stream_get_state(struct bt_bap_stre=
am *stream)
>         if (!stream)
>                 return BT_BAP_STREAM_STATE_IDLE;
>
> -       if (stream->lpac->type !=3D BT_BAP_BCAST_SOURCE &&
> -                       stream->lpac->type !=3D BT_BAP_BCAST_SINK)
> -               return stream->ep->state;
> -       else
> -               return stream->state;
> +       return stream->ops->get_state(stream);
>  }
>
>  bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *use=
r_data)
> @@ -5568,53 +5661,15 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_strea=
m *stream)
>         if (!stream)
>                 return 0x00;
>
> -       if (stream->ep)
> -               return stream->ep->dir;
> -
> -       if (bt_bap_pac_get_type(stream->lpac) =3D=3D BT_BAP_BCAST_SINK)
> -               return BT_BAP_BCAST_SOURCE;
> -       else
> -               return BT_BAP_BCAST_SINK;
> -}
> -
> -static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
> -               uint8_t *v, void *user_data)
> -{
> -       uint32_t location32;
> -
> -       if (!v)
> -               return;
> -
> -       memcpy(&location32, v, l);
> -       *((uint32_t *)user_data) =3D le32_to_cpu(location32);
> +       return stream->ops->get_dir(stream);
>  }
>
>  uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
>  {
> -       struct bt_pacs *pacs;
> -       uint8_t type =3D BAP_CHANNEL_ALLOCATION_LTV_TYPE;
> -       uint32_t allocation =3D 0;
> -       struct iovec *caps;
> -
>         if (!stream)
>                 return 0x00000000;
>
> -       pacs =3D stream->client ? stream->bap->rdb->pacs : stream->bap->l=
db->pacs;
> -
> -       if (stream->ep) {
> -               if (stream->ep->dir =3D=3D BT_BAP_SOURCE)
> -                       return pacs->source_loc_value;
> -               else if (stream->ep->dir =3D=3D BT_BAP_SINK)
> -                       return pacs->sink_loc_value;
> -       }
> -
> -       caps =3D bt_bap_stream_get_config(stream);
> -
> -       /* Get stream allocation from capabilities */
> -       util_ltv_foreach(caps->iov_base, caps->iov_len, &type,
> -                       bap_sink_get_allocation, &allocation);
> -
> -       return allocation;
> +       return stream->ops->get_loc(stream);
>  }
>
>  struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
> @@ -6398,9 +6453,11 @@ static void check_local_pac(void *data, void *user=
_data)
>
>                 /* We have a match if all selected LTVs have a match */
>                 if ((bis_compare_data.data32 &
> -                       CODEC_SPECIFIC_CONFIGURATION_MASK) =3D=3D
> -                       CODEC_SPECIFIC_CONFIGURATION_MASK)
> +                               CODEC_SPECIFIC_CONFIGURATION_MASK) =3D=3D
> +                               CODEC_SPECIFIC_CONFIGURATION_MASK) {
>                         compare_data->found =3D true;
> +                       compare_data->data =3D data;
> +               }
>         }
>  }
>
> @@ -6425,7 +6482,8 @@ static void bap_sink_match_allocation(size_t i, uin=
t8_t l, uint8_t t,
>                 data->found =3D false;
>  }
>
> -static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec *bis_data)
> +static struct bt_ltv_match bap_check_bis(struct bt_bap_db *ldb,
> +       struct iovec *bis_data)
>  {
>         struct bt_ltv_match compare_data =3D {};
>
> @@ -6451,21 +6509,18 @@ static bool bap_check_bis(struct bt_bap_db *ldb, =
struct iovec *bis_data)
>                                 &compare_data);
>         }
>
> -       return compare_data.found;
> +       return compare_data;
>  }
>
> -void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
> +void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
>                 struct bt_bap_codec *codec,
>                 struct iovec *l2_caps,
>                 struct iovec *l3_caps,
> -               struct iovec *meta)
> +               struct bt_bap_pac **lpac,
> +               struct iovec **caps)
>  {
> -       struct bt_bap_pac *pac_source_bis;
> -       struct bt_bap_endpoint *ep;
> -       int err =3D 0;
> -       struct bt_bap_pac_qos bis_qos =3D {0};
> -       uint8_t type =3D 0;
>         struct bt_ltv_extract merge_data =3D {0};
> +       struct bt_ltv_match match_data;
>
>         merge_data.src =3D l3_caps;
>         merge_data.result =3D new0(struct iovec, 1);
> @@ -6481,43 +6536,15 @@ void bt_bap_add_bis(struct bt_bap *bap, uint8_t b=
is_index,
>         /* Check each BIS Codec Specific Configuration LTVs against our C=
odec
>          * Specific Capabilities and if the BIS matches create a PAC with=
 it
>          */
> -       if (bap_check_bis(bap->ldb, merge_data.result) =3D=3D false)
> -               goto cleanup;
> -
> -       DBG(bap, "Matching BIS %i", bis_index);
> -
> -       /* Create a QoS structure based on the received BIS information t=
o
> -        * specify the desired channel for this BIS/PAC
> -        */
> -       type =3D BAP_CHANNEL_ALLOCATION_LTV_TYPE;
> -       util_ltv_foreach(merge_data.result->iov_base,
> -                       merge_data.result->iov_len, &type,
> -                       bap_sink_get_allocation, &bis_qos.location);
> -
> -       /* Create a remote PAC */
> -       pac_source_bis =3D bap_pac_new(bap->rdb, NULL,
> -                               BT_BAP_BCAST_SOURCE, codec, &bis_qos,
> -                               merge_data.result, meta);
> -
> -       err =3D asprintf(&pac_source_bis->name, "%d", bis_index);
> -
> -       if (err < 0) {
> -               DBG(bap, "error in asprintf");
> -               goto cleanup;
> +       match_data =3D bap_check_bis(bap->ldb, merge_data.result);
> +       if (match_data.found =3D=3D true) {
> +               *caps =3D merge_data.result;
> +               *lpac =3D match_data.data;
> +               DBG(bap, "Matching BIS %i", bis_index);
> +       } else {
> +               util_iov_free(merge_data.result, 1);
> +               *caps =3D NULL;
> +               *lpac =3D NULL;
>         }
>
> -       /* Add remote source endpoint */
> -       if (!bap->rdb->broadcast_sources)
> -               bap->rdb->broadcast_sources =3D queue_new();
> -       queue_push_tail(bap->rdb->broadcast_sources, pac_source_bis);
> -
> -       queue_foreach(bap->pac_cbs, notify_pac_added, pac_source_bis);
> -       /* Push remote endpoint with direction sink */
> -       ep =3D bap_endpoint_new_broadcast(bap->rdb, BT_BAP_BCAST_SINK);
> -
> -       if (ep)
> -               queue_push_tail(bap->remote_eps, ep);
> -
> -cleanup:
> -       util_iov_free(merge_data.result, 1);
>  }
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 62e2104850c7..35524df0b451 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -251,9 +251,9 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, st=
ruct bt_bap_pac *pac);
>
>  struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
>
> -void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
> +void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
>                 struct bt_bap_codec *codec,
>                 struct iovec *l2_caps,
>                 struct iovec *l3_caps,
> -               struct iovec *meta);
> -
> +               struct bt_bap_pac **lpac,
> +               struct iovec **caps);
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
