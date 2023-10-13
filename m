Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6706DCDB47E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Oct 2023 17:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjJMRaG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Oct 2023 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjJMRaF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Oct 2023 13:30:05 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C655CA9
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 10:30:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so18455701fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697218199; x=1697822999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETA7g0EnPSb0udVWSA5mNbhq5B9PY3i+DMop8ci97rc=;
        b=bE+w3XH6qf+aRI+vIGDaVf6XDzP+Ssi5ycNZXtcOg7/LBHapzZFtTQbUgXJakdhl55
         7oftYYKWeJ2baStJei0Jy4bgDWij1IkXwsBmsntW08Ei64MjtRnHIELLXab2SajalOr9
         G/rPSA9wVr5qwZw8IIug9Qk5WaJotLq/wQCE3KCZEE6vqTwynR4HdlQN1Tc9rhDZeZsX
         pevAWZUJ5LvNPfUzQjMpFjA/rliOvRnDpl5lbfhTOlx8IPWdsOUTiDfZ3bWJWrG/AWBr
         tSEYv4QF5T5TaF0QqVwHEJcyFmuAjYHj27hJja70DyJC3YMBkUJrsTgMnPyMlucocls4
         9RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218199; x=1697822999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETA7g0EnPSb0udVWSA5mNbhq5B9PY3i+DMop8ci97rc=;
        b=v4pImLhNwK+m9M4G7YaSA9V50lIG1KBb4dgh0ew9vWLPPo0I88YBTk+crD5P6e1TT9
         LUpXM4JcAmPGyTNaDHVeAzhAoQOViDZJ+srYqHeXoVUNpY1qEQoZhytp/bMNnoQA/3iG
         6kr0YbpapcAF7tAhnI/4O/MG3r1hfk9+deoC9mdUCkcwYzfhv/Hs/F+kj5nAe4K9oqET
         Ah+xlawxiK9wpaEZjAphSbeDdlfWnPcCuax1yd4KtODGkaj/cA6bMPnernd3ZZvjbSlG
         Yfpk2tMaAjYppQjNYBTfqvl53FoUQAsfFLafDuao5F04U7sOD9MEfqfkb65OCPrkolQi
         W2XQ==
X-Gm-Message-State: AOJu0YxVRY5Hpap+KNO9wITnzSsj82d7vYkRFyBOp0SbDBHbtWDuxk15
        Nl4J9dnEKzreYCO9fUUuK0K/KUq7FMHStCWKnIChqNOfRy+Yju2Q
X-Google-Smtp-Source: AGHT+IEn1Z/r2sYl3rrf+8O4bFKjY3chxqsPhe4NyvP60bhgTkt0hEnJ1uZgxQhOPBHBtRuuoW9WDrhR3IqeQtYrUSc=
X-Received: by 2002:a2e:3e18:0:b0:2c2:c32f:b158 with SMTP id
 l24-20020a2e3e18000000b002c2c32fb158mr25812168lja.12.1697218198523; Fri, 13
 Oct 2023 10:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231013100537.3867-1-claudia.rosu@nxp.com> <20231013100537.3867-2-claudia.rosu@nxp.com>
In-Reply-To: <20231013100537.3867-2-claudia.rosu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 13 Oct 2023 10:29:46 -0700
Message-ID: <CABBYNZL1UJkH8_bUv-qRW9TZSAwhrw29_-R5xjnz9B5b+EO5ng@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] bap: Fix source+sink endpoint registration
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

On Fri, Oct 13, 2023 at 3:06=E2=80=AFAM Claudia Draghicescu
<claudia.rosu@nxp.com> wrote:
>
> Create new endpoint name for the simulated broadcast sink that is
> created when registering a broadcast source endpoint.
> This removes the ambiguity when having registered a local
> broadcast sink and fixes the situation when multiple remote
> endpoints are created when discovering a broadcast source.
>
> ---
>  src/shared/bap.c | 54 +++++++++++++++++++++++++++---------------------
>  src/shared/bap.h |  1 +
>  2 files changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 925501c48..266116235 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -644,7 +644,7 @@ static struct bt_bap_endpoint *bap_endpoint_new_broad=
cast(struct bt_bap_db *bdb,
>         if (type =3D=3D BT_BAP_BCAST_SINK)
>                 ep->dir =3D BT_BAP_BCAST_SOURCE;
>         else
> -               ep->dir =3D BT_BAP_BCAST_SINK;
> +               ep->dir =3D BT_BAP_SIMULATED_BCAST_SINK;
>
>         return ep;
>  }
> @@ -1500,12 +1500,12 @@ static void ep_config_cb(struct bt_bap_stream *st=
ream, int err)
>                 return;
>
>         if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_BCAS=
T) {
> -               if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SINK=
)
> +               if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_SIMULATED_=
BCAST_SINK)
>                         stream_set_state_broadcast(stream,
> -                                               BT_BAP_STREAM_STATE_QOS);
> +                               BT_BAP_STREAM_STATE_QOS);
>                 else if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST=
_SOURCE)
>                         stream_set_state_broadcast(stream,
> -                                               BT_BAP_STREAM_STATE_CONFI=
G);
> +                               BT_BAP_STREAM_STATE_CONFIG);
>                 return;
>         }
>
> @@ -2710,15 +2710,15 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct g=
att_db *db,
>                 break;
>         case BT_BAP_BCAST_SOURCE:
>                 bap_add_broadcast_source(pac);
> -               if (queue_isempty(bdb->broadcast_sinks)) {
> -                       /* When adding a local broadcast source, add also=
 a
> -                        * local broadcast sink
> -                        */
> -                       pac_broadcast_sink =3D bap_pac_new(bdb, name,
> -                                       BT_BAP_BCAST_SINK, &codec, qos,
> -                                       data, metadata);
> -                       bap_add_broadcast_sink(pac_broadcast_sink);
> -               }
> +               /* When adding a local broadcast source, add also a
> +                * local broadcast sink
> +                */
> +               pac_broadcast_sink =3D bap_pac_new(bdb, name,
> +                       BT_BAP_SIMULATED_BCAST_SINK, &codec, qos,
> +                       data, metadata);

I'm not really sure why this is needed to begin with, if that is to
have a remote endpoint I'd say we need to change the logic so
broadcast src role is allowed to create streams without a remote
endpoint, anyway we should probably have better documentation around
this logic.

> +               bap_add_broadcast_sink(pac_broadcast_sink);
> +               queue_foreach(sessions, notify_session_pac_added, pac_bro=
adcast_sink);
> +               return pac;
>                 break;
>         case BT_BAP_BCAST_SINK:
>                 bap_add_broadcast_sink(pac);
> @@ -4457,13 +4457,23 @@ static void bap_foreach_pac(struct queue *l, stru=
ct queue *r,
>                 for (er =3D queue_get_entries(r); er; er =3D er->next) {
>                         struct bt_bap_pac *rpac =3D er->data;
>
> +                       if ((lpac->type =3D=3D BT_BAP_BCAST_SOURCE)
> +                               && (rpac->type !=3D BT_BAP_SIMULATED_BCAS=
T_SINK))
> +                               continue;
> +                       if ((rpac->type =3D=3D BT_BAP_SIMULATED_BCAST_SIN=
K)
> +                               && (lpac->type =3D=3D BT_BAP_BCAST_SOURCE=
)) {
> +                               func(lpac, rpac, user_data);
> +                               return;
> +                       }
> +
>                         /* Skip checking codec for bcast source,
>                          * it will be checked when BASE info are received
>                          */
>                         if ((rpac->type !=3D BT_BAP_BCAST_SOURCE) &&
>                                 (!bap_codec_equal(&lpac->codec, &rpac->co=
dec)))
>                                 continue;
> -
> +                       if (rpac->type =3D=3D BT_BAP_SIMULATED_BCAST_SINK=
)
> +                               continue;
>                         if (!func(lpac, rpac, user_data))
>                                 return;
>                 }
> @@ -4484,12 +4494,6 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_=
t type,
>                 return bap_foreach_pac(bap->ldb->sinks, bap->rdb->sources=
,
>                                                            func, user_dat=
a);
>         case BT_BAP_BCAST_SOURCE:
> -               if (queue_isempty(bap->rdb->broadcast_sources)
> -                       && queue_isempty(bap->rdb->broadcast_sinks))
> -                       return bap_foreach_pac(bap->ldb->broadcast_source=
s,
> -                                       bap->ldb->broadcast_sinks,
> -                                       func, user_data);
> -
>                 return bap_foreach_pac(bap->ldb->broadcast_sinks,
>                                         bap->rdb->broadcast_sources,
>                                         func, user_data);
> @@ -4497,6 +4501,10 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_=
t type,
>                 return bap_foreach_pac(bap->ldb->broadcast_sinks,
>                                         bap->rdb->broadcast_sources,
>                                         func, user_data);
> +       case BT_BAP_SIMULATED_BCAST_SINK:
> +               return bap_foreach_pac(bap->ldb->broadcast_sources,
> +                                       bap->ldb->broadcast_sinks,
> +                                       func, user_data);
>         }
>  }
>
> @@ -4927,12 +4935,12 @@ unsigned int bt_bap_stream_enable(struct bt_bap_s=
tream *stream,
>                 queue_foreach(stream->links, bap_stream_enable_link, meta=
data);
>                 break;
>         case BT_BAP_STREAM_TYPE_BCAST:
> -               if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SINK=
)
> +               if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_SIMULATED_=
BCAST_SINK)
>                         stream_set_state_broadcast(stream,
> -                                               BT_BAP_STREAM_STATE_CONFI=
G);
> +                               BT_BAP_STREAM_STATE_CONFIG);
>                 else if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST=
_SOURCE)
>                         stream_set_state_broadcast(stream,
> -                                               BT_BAP_STREAM_STATE_STREA=
MING);
> +                                BT_BAP_STREAM_STATE_STREAMING);
>
>                 return 1;
>         }
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index ebe4dbf7d..af3b6be71 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -19,6 +19,7 @@
>  #define        BT_BAP_SOURCE                   0x02
>  #define        BT_BAP_BCAST_SOURCE             0x03
>  #define        BT_BAP_BCAST_SINK               0x04
> +#define BT_BAP_SIMULATED_BCAST_SINK    0x05
>
>  #define BT_BAP_STREAM_TYPE_UCAST       0x01
>  #define        BT_BAP_STREAM_TYPE_BCAST        0x02
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
