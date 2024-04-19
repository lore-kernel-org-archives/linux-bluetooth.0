Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F728374
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554956; cv=none; b=BpB6WZaUyCVo9sc+UHPCnL6hX/81e5Ont6m/knAxTp2pt5ehBRt8zb28NXVkB53S6lbYmXaAl3gVAiodn/+X/q81DXUUONEdmvfpAsdfnBIiKSmeGCfaL5eiBCOHv4U95AElPB+iGsfl/TMEBdi4ytpwqLvIrWh3inMrVEZJ7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554956; c=relaxed/simple;
	bh=LgUdLO7Jq5PuPmWszg2tAqPi7p1Fjr9eD3KLCFAnkeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtDATqMFETHlKwWnjxnq/7zM6oRO6ayO+C102CjMRuKo9WFRNWnIOw7HWdrQvassiBsmaJttmdCVMX3Nc1N0hGkt9bjCGvsAgq/LJePUsF6eFD0ofh+dFIuWKwP3XmTma8KO/5W58nASPB4Ubrkkx1xvTAOIEParGF+knIPJv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9WSAvX/; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9WSAvX/"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2db101c11feso16650301fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713554952; x=1714159752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohHdk6hxtOTbsM+6cZDb7/xFTVCaO7cZMjoNbq3JfbM=;
        b=W9WSAvX/u1/cNXuq499Tn3uF/0Vgs70KFHBKyFSVJv5pepSwN+LH8zb5h2ELu0rCXA
         GrldcsuacC2tpZVG9VywQS0jRGogIgZ8FxMO4z5DHlLoL/fgKTWoxD7E6D4pK2tZiFr3
         an9oAf+Z291H7wi+dglaRMyNv+zKB2+cX/+DbeStUwWCLn5Fa/Or0nNd/uXETRJy0XZr
         uPZns8hkFe8JaEGm+EZDPxwJqPO6i8dgwcLgJ22IVeemnn0qBCe8VL/3gy7B87jDAIYL
         t8Qx/e5aNV7qnTvWoNhNimGu/CYtUX6l/neoPa1U48rZfvwMOxeLd5U4DqRklSx2sJDK
         ypyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713554952; x=1714159752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohHdk6hxtOTbsM+6cZDb7/xFTVCaO7cZMjoNbq3JfbM=;
        b=e5ewzHcgCiWxtve1oKCSMyw6i+DmZTfNVtbhnNfYhViJThkWuRZw/cGOXls/FX35Fn
         sPqZf9kGaVMhiesAYKNjOMgOR2djyi5U2A7VLk98F4tbU8v00lAtgr3HsLzVaa4HWVv9
         IswVc4BNu3hfQ1hg3BtbU5JzHU7DjhVfQ4jlRw7zyKoVh0ZPafMOyAlefYA59IT2Q+XA
         iswrgeRSwW2s1TavR/CkekjXy6sccNr3BVaNA+d2Z8yHeAP7I7mde5ESZkIWwVMqmfSG
         yW1uV6kH+HHHTMf08HHuqNDQ1B/BnhqndegzuKcxySNsfXuXc2/Ju466iAArhv3II6p+
         rdNA==
X-Gm-Message-State: AOJu0YyOrJmME8ee99rR3pgACH5nAokfi3az2yex/+h1Rnq9sMJQNoBz
	hOaVnzaK/SLBGM2UrAKKO98qCqhRQ6NGLzztohnX7/BW/FU9n4k4SMZEKwxLM0o/ElKspD4BQMY
	bISFpBicR28PHRsmH+uXr7iKwoeQ98f49
X-Google-Smtp-Source: AGHT+IH9WGNvYiBbYpSew0BcVutAE+fzJM0VCM3fJNVET9kQzS29BSEzv/kMVTFjpAaEYWzyLpeFicMjR1WkVd9s27k=
X-Received: by 2002:a2e:a983:0:b0:2d8:4892:bee2 with SMTP id
 x3-20020a2ea983000000b002d84892bee2mr1175512ljq.20.1713554951292; Fri, 19 Apr
 2024 12:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419180752.96699-1-andrei.istodorescu@nxp.com> <20240419180752.96699-6-andrei.istodorescu@nxp.com>
In-Reply-To: <20240419180752.96699-6-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Apr 2024 15:28:58 -0400
Message-ID: <CABBYNZJa92kOUZSQJREA8ZR5ZkzOyOtiU6ppJ1oE3uM8B6iyMg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] bap: Create streams and transports for each
 matching BIS
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Fri, Apr 19, 2024 at 2:08=E2=80=AFPM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> Rename bt_bap_add_bis to bt_bap_check_bis as its scope has changed.

The scope being changed doesn't mean we need to change its name,
except if you add an explanation on why check is a better term than
add here, or perhaps we want to add something like
bt_bap_stream_new_bis? Which shall return the bt_bap_stream already
configured from BIS.

> Use the BIS index received in the BASE to synchronize to the BIG.
> Allow bt_bap_endpoint to be NULL.
> Remove the Broadcast Sink code from set_configuration.
> Update BASE parsing so that it creates streams and transports, without a
> remote PAC and endpoint.
> Update bap_find_setup_by_stream to find the setup in case the stream does
> not contain an endpoint.
> Update BAP Broadcast Sink state machine:
> * BIS matched over the air -> create stream and transport and set the
>   stream state to BT_BAP_STREAM_STATE_CONFIG
> * transport acquire sets stream state to BT_BAP_STREAM_STATE_ENABLING
>   and do BIG Create Sync

If we were to follow the BAP spec to the letter then there is no
Enabling state, nor Enable procedure:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/16212=
-BAP-html5/out/en/index-en.html#UUID-4a295bf2-6e50-be11-e827-c23e63569087_f=
igure-idm4631863059107233170457600297

Broadcast streams can only be on Idle, Configured or Streaming states,
so I suggest we follow that as closely as possible.

> * BIG Sync Established received sets stream state to
>   BT_BAP_STREAM_STATE_STREAMING
> ---
>  profiles/audio/bap.c | 184 +++++++++++++++++++++++++++++----------
>  src/shared/bap.c     | 199 ++++++++++++++++++++++---------------------
>  src/shared/bap.h     |   6 +-
>  3 files changed, 244 insertions(+), 145 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index ff6d6d881346..b59ef405ab74 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -109,6 +109,7 @@ struct bap_data {
>         struct queue *srcs;
>         struct queue *snks;
>         struct queue *bcast;
> +       struct queue *bcast_snks;
>         struct queue *streams;
>         GIOChannel *listen_io;
>         int selecting;
> @@ -125,7 +126,10 @@ struct bap_bcast_pa_req {
>         bool in_progress;
>         union {
>                 struct btd_service *service;
> -               struct bap_setup *setup;
> +               struct bap_accept {
> +                       struct bap_setup *setup;
> +                       struct bap_data *bap_data;
> +               } accept_data;
>         } data;
>  };
>
> @@ -197,6 +201,8 @@ static void ep_unregister(void *data)
>                                                 MEDIA_ENDPOINT_INTERFACE)=
;
>  }
>
> +static void setup_free(void *data);
> +
>  static void bap_data_free(struct bap_data *data)
>  {
>         if (data->listen_io) {
> @@ -213,6 +219,7 @@ static void bap_data_free(struct bap_data *data)
>         queue_destroy(data->srcs, ep_unregister);
>         queue_destroy(data->bcast, ep_unregister);
>         queue_destroy(data->streams, NULL);
> +       queue_destroy(data->bcast_snks, setup_free);
>         bt_bap_ready_unregister(data->bap, data->ready_id);
>         bt_bap_state_unregister(data->bap, data->state_id);
>         bt_bap_pac_unregister(data->bap, data->pac_id);
> @@ -850,7 +857,11 @@ static struct bap_setup *setup_new(struct bap_ep *ep=
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
> @@ -866,12 +877,14 @@ static struct bap_setup *setup_new(struct bap_ep *e=
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
> @@ -942,17 +955,6 @@ static DBusMessage *set_configuration(DBusConnection=
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
> @@ -988,20 +990,24 @@ static DBusMessage *set_configuration(DBusConnectio=
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
>         queue_remove(bcast_pa_requests, req);
>
> +       g_io_channel_unref(setup->io);
> +       g_io_channel_shutdown(setup->io, TRUE, NULL);
> +       setup->io =3D NULL;
> +
>         /* This device is no longer needed */
> -       btd_service_connecting_complete(setup->ep->data->service, 0);
> +       btd_service_connecting_complete(req->data.accept_data.bap_data->s=
ervice,
> +                       0);
>
>         fd =3D g_io_channel_unix_get_fd(io);
>
>         if (bt_bap_stream_set_io(setup->stream, fd)) {
> -               bt_bap_stream_enable(setup->stream, true, NULL, NULL, NUL=
L);
>                 g_io_channel_set_close_on_unref(io, FALSE);
>                 return;
>         }
> @@ -1014,8 +1020,54 @@ static void print_ltv(size_t i, uint8_t l, uint8_t=
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
> @@ -1087,11 +1139,20 @@ static bool parse_base(struct bt_bap *bap, struct=
 bt_iso_base *base,
>                 for (; num_bis; num_bis--) {
>                         uint8_t bis_index;
>                         struct iovec *l3_caps;
> +                       struct iovec *merged_caps;
> +                       struct bt_bap_pac *matched_lpac;
> +                       char *path;
> +                       int err;
>
>                         if (!util_iov_pull_u8(&iov, &bis_index))
>                                 goto fail;
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
> @@ -1110,9 +1171,16 @@ static bool parse_base(struct bt_bap *bap, struct =
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
>         }
> @@ -1155,7 +1223,9 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, =
void *user_data)
>         /* Analyze received BASE data and create remote media endpoints f=
or each
>          * BIS matching our capabilities
>          */
> -       parse_base(data->bap, &base, bap_debug);
> +       parse_base(data, &base, &qos, bap_debug);
> +
> +       service_set_connecting(pa_req->data.service);
>  }
>
>  static bool match_data_bap_data(const void *data, const void *match_data=
)
> @@ -1558,6 +1628,7 @@ static struct bap_setup *bap_find_setup_by_stream(s=
truct bap_data *data,
>                                         struct bt_bap_stream *stream)
>  {
>         struct bap_ep *ep =3D NULL;
> +       struct queue *queue =3D NULL;
>
>         switch (bt_bap_stream_get_type(stream)) {
>         case BT_BAP_STREAM_TYPE_UCAST:
> @@ -1572,9 +1643,11 @@ static struct bap_setup *bap_find_setup_by_stream(=
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
> @@ -2097,7 +2170,8 @@ static void setup_accept_io_broadcast(struct bap_da=
ta *data,
>          */
>         pa_req->type =3D BAP_PA_BIG_SYNC_REQ;
>         pa_req->in_progress =3D FALSE;
> -       pa_req->data.setup =3D setup;
> +       pa_req->data.accept_data.setup =3D setup;
> +       pa_req->data.accept_data.bap_data =3D data;
>         queue_push_tail(bcast_pa_requests, pa_req);
>  }
>
> @@ -2157,7 +2231,7 @@ static void setup_create_bcast_io(struct bap_data *=
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
> @@ -2399,12 +2473,7 @@ static void bap_state_bcast(struct bt_bap_stream *=
stream, uint8_t old_state,
>                 if (!setup || setup->id)
>                         break;
>                 if (bt_bap_stream_io_dir(stream) =3D=3D
> -                               BT_BAP_BCAST_SOURCE)
> -                       /* If the stream is attached to a
> -                        * broadcast sink endpoint.
> -                        */
> -                       setup_create_io(data, setup, stream, defer);
> -               else {
> +                               BT_BAP_BCAST_SINK) {
>                         /* If the stream attached to a broadcast
>                          * source endpoint generate the base.
>                          */
> @@ -2455,6 +2524,14 @@ static void bap_state_bcast(struct bt_bap_stream *=
stream, uint8_t old_state,
>                         }
>                 }
>                 break;
> +       case BT_BAP_STREAM_STATE_ENABLING:
> +               if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SOUR=
CE)
> +                       setup_create_io(data, setup, stream, defer);
> +               break;
> +       case BT_BAP_STREAM_STATE_RELEASING:
> +               if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SOUR=
CE)
> +                       setup_io_close(setup, NULL);
> +               break;
>         }
>  }
>
> @@ -2794,6 +2871,7 @@ static int short_lived_pa_sync(struct bap_bcast_pa_=
req *req)
>                 error("BAP unable to attach");
>                 return -EINVAL;
>         }
> +       data->bcast_snks =3D queue_new();
>
>         bap_data_add(data);
>
> @@ -2833,29 +2911,41 @@ static void iso_do_big_sync(GIOChannel *io, void =
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
> +       char device_name[40] =3D {0};
> +       int s_err;
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
> +       s_err =3D sscanf(path, "%s/bis%d", device_name, &bis_index);
> +       if (s_err =3D=3D -1)
> +               DBG("sscanf error");
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
> @@ -2898,8 +2988,8 @@ static void iso_do_big_sync(GIOChannel *io, void *u=
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
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 8c4868f4bf9f..e69f6cec99bf 100644
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
> @@ -2043,6 +2077,41 @@ static unsigned int bap_bcast_metadata(struct bt_b=
ap_stream *stream,
>         return 1;
>  }
>
> +static unsigned int bap_bcast_get_dir(struct bt_bap_stream *stream)
> +{
> +       if (bt_bap_pac_get_type(stream->lpac) =3D=3D BT_BAP_BCAST_SINK)
> +               return BT_BAP_BCAST_SOURCE;
> +       else
> +               return BT_BAP_BCAST_SINK;
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
> @@ -2052,11 +2121,12 @@ static unsigned int bap_bcast_release(struct bt_b=
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
> @@ -2064,26 +2134,40 @@ static unsigned int bap_bcast_release(struct bt_b=
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
>                         bap_bcast_start, bap_bcast_disable, NULL,
> -                       bap_bcast_metadata, bap_bcast_release),
> +                       bap_bcast_metadata, bap_bcast_get_dir,
> +                       bap_bcast_get_location,
> +                       bap_bcast_release),
>         STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
> +                       bap_bcast_get_state,
>                         bap_bcast_config, NULL, bap_bcast_enable,
>                         bap_bcast_start, bap_bcast_disable, NULL,
> -                       bap_bcast_metadata, bap_bcast_release),
> +                       bap_bcast_metadata, bap_bcast_get_dir,
> +                       bap_bcast_get_location,
> +                       bap_bcast_release),
>  };
>
>  static const struct bt_bap_stream_ops *
> @@ -5383,11 +5467,7 @@ uint8_t bt_bap_stream_get_state(struct bt_bap_stre=
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
> @@ -5571,53 +5651,15 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_strea=
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
> @@ -6459,17 +6501,13 @@ static struct bt_ltv_match bap_check_bis(struct b=
t_bap_db *ldb,
>         return compare_data;
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
>         struct bt_ltv_match match_data =3D {0};
>
> @@ -6488,43 +6526,14 @@ void bt_bap_add_bis(struct bt_bap *bap, uint8_t b=
is_index,
>          * Specific Capabilities and if the BIS matches create a PAC with=
 it
>          */
>         match_data =3D bap_check_bis(bap->ldb, merge_data.result);
> -       if (match_data.found =3D=3D false)
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
