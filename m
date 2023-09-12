Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16B5EE3F0B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 18:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjILSon (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjILSom (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 14:44:42 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E521C10D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 11:44:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so96637131fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 11:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694544276; x=1695149076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHTeaXWUdZVddvHMf1/OUQRqRHd72N11rSxf4Q8vN/4=;
        b=nDMl/6amUdWik/PVluTirekRUcvyqhk1BVRLFSVvHkKlGJbPZpthK7Sgbxw5li1ntS
         iVAOlNcRH+6Xo+Ah71vJoN8bLyoqKv9XsP+4uEb25OutnkLPp7Dx6lVUaqaCqDmrQvix
         qE5X9POrmAPGsx4QFqv3Zny8JcjzTEyVpXT3gc+aXL4aoY2GLs3XsLmnzvOQf2ti3WbG
         NrFcyt36WBJt818VP970h+UM+4cF/JHoNTjs395yT1Tt35O7d8ZyoG/vbKcBRhHiwxWk
         24b7SyWw306a7zn4+FjgskmXgTCPobx5nJxSDZdASu1B4rFGfI95yUXVo6RjFczwP9pE
         /u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694544276; x=1695149076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHTeaXWUdZVddvHMf1/OUQRqRHd72N11rSxf4Q8vN/4=;
        b=UuQ5J95q2R75Aq/670XMcCBk5GpgcIY5JOOiYJI17np0biFDJjNfsMYxxb+A+Ke2t1
         dmI7DS7Z2O+7TnhEN7/+lvRRyeD/tVQpPs4SZ0PU89X4RhjW3Qc8+aQtoMSzfgNQuJWF
         6d2dGjES8zQoXN5llab1c9DiFHSkjbfV+0jMYhM5M3tUejz1nHuA1yr73AFhgdQ5fk2u
         4UoNYE0uUJX4Pjn6JA+1Vbh5XiCCMUvJooQwoaDTllK4hzd35udNQ9bLYa/P82ASGz1f
         /zX9hy/8v8N0lconT3eT1nqIXUief5oRhr1l4HyJcl8jZIrTymbkNZ8JKiWAp0XTQ3Tu
         nWFQ==
X-Gm-Message-State: AOJu0YxxaZdXEXSlY6kjmraS7xURmOZr8CVO6KKrRtk2n3fsJOzPi6oZ
        ksSfQk9KhwDB3u73cwwWR0AFWyuyJ0yYhc1VJ+E=
X-Google-Smtp-Source: AGHT+IFAkmLswHwtKyXQ9H3iYGqJhPI4VAiXzhc7Kf1dolrf1kJnua7/rUtXMd8AiXnocZ1qec/uj1Zp1HZw4AH8B3k=
X-Received: by 2002:a2e:80d3:0:b0:2b6:df23:2117 with SMTP id
 r19-20020a2e80d3000000b002b6df232117mr544988ljg.43.1694544276003; Tue, 12 Sep
 2023 11:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230911074711.62493-1-silviu.barbulescu@nxp.com> <20230911074711.62493-2-silviu.barbulescu@nxp.com>
In-Reply-To: <20230911074711.62493-2-silviu.barbulescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Sep 2023 11:44:23 -0700
Message-ID: <CABBYNZ+PaBnLr8tkaaXhvpBK4qf9hK4VMZc-Eji7xUwbWjQ9Xw@mail.gmail.com>
Subject: Re: [PATCH 1/2] shared/bap:Update stream enable/disable flow bcast source
To:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Silviu,

On Mon, Sep 11, 2023 at 12:47=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Update stream enable/disable flow for BAP broadcast source
>
> ---
>  src/shared/bap.c | 51 +++++++++++++++++++++++++++++++++++-------------
>  src/shared/bap.h |  2 ++
>  2 files changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 1c43680c2..801716dd9 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -1331,6 +1331,11 @@ static void stream_set_state_broadcast(struct bt_b=
ap_stream *stream,
>         ep->old_state =3D ep->state;
>         ep->state =3D state;
>
> +       DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
> +                       bt_bap_stream_get_dir(stream),
> +                       bt_bap_stream_statestr(stream->ep->old_state),
> +                       bt_bap_stream_statestr(stream->ep->state));
> +
>         bt_bap_ref(bap);
>
>         for (entry =3D queue_get_entries(bap->state_cbs); entry;
> @@ -1492,7 +1497,7 @@ static void ep_config_cb(struct bt_bap_stream *stre=
am, int err)
>                 return;
>
>         if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_BCAS=
T) {
> -               stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_CO=
NFIG);
> +               stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_QO=
S);
>                 return;
>         }
>
> @@ -4698,13 +4703,19 @@ unsigned int bt_bap_stream_enable(struct bt_bap_s=
tream *stream,
>                 break;
>         case BT_BAP_STREAM_TYPE_BCAST:
>                 stream_set_state_broadcast(stream,
> -                                       BT_BAP_STREAM_STATE_STREAMING);
> +                                       BT_BAP_STREAM_STATE_CONFIG);
>                 return 1;
>         }
>
>         return ret;
>  }
>
> +void bt_bap_stream_streaming(struct bt_bap_stream *stream)
> +{
> +               stream_set_state_broadcast(stream,
> +                                       BT_BAP_STREAM_STATE_STREAMING);
> +}
> +
>  unsigned int bt_bap_stream_start(struct bt_bap_stream *stream,
>                                         bt_bap_stream_func_t func,
>                                         void *user_data)
> @@ -4779,24 +4790,36 @@ unsigned int bt_bap_stream_disable(struct bt_bap_=
stream *stream,
>                 return 0;
>         }
>
> -       memset(&disable, 0, sizeof(disable));
> +       switch (bt_bap_stream_get_type(stream)) {
> +       case BT_BAP_STREAM_TYPE_UCAST:
> +               memset(&disable, 0, sizeof(disable));
>
> -       disable.ase =3D stream->ep->id;
> +               disable.ase =3D stream->ep->id;
>
> -       iov.iov_base =3D &disable;
> -       iov.iov_len =3D sizeof(disable);
> +               iov.iov_base =3D &disable;
> +               iov.iov_len =3D sizeof(disable);
>
> -       req =3D bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, func, user_=
data);
> +               req =3D bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, fun=
c,
> +                                                       user_data);
>
> -       if (!bap_queue_req(stream->bap, req)) {
> -               bap_req_free(req);
> -               return 0;
> -       }
> +               if (!bap_queue_req(stream->bap, req)) {
> +                       bap_req_free(req);
> +                       return 0;
> +               }
>
> -       if (disable_links)
> -               queue_foreach(stream->links, bap_stream_disable_link, NUL=
L);
> +               if (disable_links)
> +                       queue_foreach(stream->links, bap_stream_disable_l=
ink,
> +                                                       NULL);
>
> -       return req->id;
> +               return req->id;
> +
> +       case BT_BAP_STREAM_TYPE_BCAST:
> +               stream_set_state_broadcast(stream,
> +                                       BT_BAP_STREAM_STATE_RELEASING);
> +               return 1;
> +       }
> +
> +       return 0;
>  }
>
>  unsigned int bt_bap_stream_stop(struct bt_bap_stream *stream,
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index edb5c1bed..d3c9b241e 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -264,6 +264,8 @@ unsigned int bt_bap_stream_start(struct bt_bap_stream=
 *stream,
>                                         bt_bap_stream_func_t func,
>                                         void *user_data);
>
> +void bt_bap_stream_streaming(struct bt_bap_stream *stream);
> +

Lets use bt_bap_stream_start and handle this internally instead of
introducing new APIs specific to broadcast.

>  unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
>                                         bool disable_links,
>                                         bt_bap_stream_func_t func,
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
