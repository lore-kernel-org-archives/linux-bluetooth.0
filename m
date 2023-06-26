Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953CBEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jun 2023 19:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjFZTzX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZTzW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 15:55:22 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371CDE7B
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 12:55:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b69ea3b29fso25356911fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 12:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687809319; x=1690401319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJHr43ETmdQF5k4COj21CqvW11WxmS13eatfPxe+o28=;
        b=KjF621Y0G0nPN5zvuuDxOXsN2eRlfqnOncmLcDXZW9LSTvM5XBa/mYwU/4hYw7BEU8
         R7h2JXnIZFUIkv7afVcbJd86FJHeAlLtfr0ZmuyDSygH84x+Vrl81nFcxF2mkZmdgq+y
         utTrc5YRxeMkA5ywop0CCr+cx11FW0rzJldMfSFRLHOD/ppswSx4GgWWNs1Kj4sUeuy5
         1JrWI09ZD2cXj2WUjsVU58Mttu0LCvNTC2HYfYq96RJhAyjycPfwD0GJRy8kAQ/a0c/0
         4CFZlLAobDuIS1zSaOLKPsAtmnBBxdBWa5CDnJGNFdN95zd1aku2Q6u00cWSZ8aDEaVe
         Fu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687809319; x=1690401319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJHr43ETmdQF5k4COj21CqvW11WxmS13eatfPxe+o28=;
        b=gQruutj3JJMBqhFT7KZwKszEPylAqeNoHw2DSxjXDfWy3SYN4hb0DTFOSegsJqIzdD
         BbSD8dBnNQckIpSoJwtrCYJtwhyghnN622nTqu8ZV+DW4yjIbO50PeQOnv/8HYuZdvqF
         XWnd/1YgwBL7RRSi6M6uO8JE0NjgAvuYxwvBTFLC36K5mofNv3jj85yVdCoqN6XYI80g
         iv1g22zw34Y/mthoji5hKkXIjiSET6VuqiT1YGKsUtGZVRUZx/Uu0CgnnYNEMlHVHW0I
         5dSRJH58eMiF27B1qLoL7iPMVIkXCOe+O87WCXksVTdkLxXthHO5ZxnRPGrOjsU7zOno
         LctA==
X-Gm-Message-State: AC+VfDzppuXwJP6m/h8f+UJCiI7+ykrJ52++Y0xR0bICcPyKUMGLlmlG
        7NHISGkSonaY5V+KXW9sworNv4xG84heNBtTkhQ=
X-Google-Smtp-Source: ACHHUZ7bZ87EIM6s0Ul2kTOHK3myLWA/ZRZ8ydYSJEgPm5nspxu4jCRjxO9PzALu+o5AR95oPrRHr6UqDTpY/A+J8AI=
X-Received: by 2002:a2e:3508:0:b0:2b4:5b9c:a019 with SMTP id
 z8-20020a2e3508000000b002b45b9ca019mr18097522ljz.8.1687809319228; Mon, 26 Jun
 2023 12:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230623074657.16618-1-iulia.tanasescu@nxp.com> <20230623074657.16618-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230623074657.16618-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Jun 2023 12:55:07 -0700
Message-ID: <CABBYNZL=b8Ts6pZY3=XJTt_TtdNnGtqs8gNkgq=3Wz6XEQnH=g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] btio: Add option for binding iso broadcast address
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Fri, Jun 23, 2023 at 1:14=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This adds the BT_IO_OPT_ISO_BC_ADDR btio option, to allow the user
> to set the iso_bc field of an address at bind.
>
> ---
>  btio/btio.c | 56 +++++++++++++++++++++++++++++++++++++++++++----------
>  btio/btio.h |  3 ++-
>  2 files changed, 48 insertions(+), 11 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index b68bfb14c..00e46abb0 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -16,6 +16,7 @@
>
>  #include <stdarg.h>
>  #include <stdlib.h>
> +#include <stdbool.h>
>  #include <unistd.h>
>  #include <errno.h>
>  #include <poll.h>
> @@ -71,6 +72,8 @@ struct set_opts {
>         uint16_t voice;
>         struct bt_iso_qos qos;
>         struct bt_iso_base base;
> +       struct sockaddr_iso_bc iso_bc_addr;
> +       bool bc_addr_set;

I guess we could just check for BDADDR_ANY instead of using a dedicated fie=
ld.

>  };
>
>  struct connect {
> @@ -771,21 +774,40 @@ static int sco_bind(int sock, const bdaddr_t *src, =
GError **err)
>  }
>
>  static int iso_bind(int sock, const bdaddr_t *src, uint8_t src_type,
> -                                                       GError **err)
> +                                       struct sockaddr_iso_bc *bc_addr,
> +                                       GError **err)
>  {
> -       struct sockaddr_iso addr;
> +       struct sockaddr_iso *addr =3D NULL;
> +       size_t addr_len;
> +       int ret =3D 0;
>
> -       memset(&addr, 0, sizeof(addr));
> -       addr.iso_family =3D AF_BLUETOOTH;
> -       bacpy(&addr.iso_bdaddr, src);
> -       addr.iso_bdaddr_type =3D src_type;
> +       if (bc_addr)
> +               addr_len =3D sizeof(*addr) + sizeof(*addr->iso_bc);
> +       else
> +               addr_len =3D sizeof(*addr);
> +
> +       addr =3D malloc(addr_len);
> +
> +       if (!addr)
> +               return -ENOMEM;
>
> -       if (!bind(sock, (struct sockaddr *) &addr, sizeof(addr)))
> -               return 0;
> +       memset(addr, 0, addr_len);
> +       addr->iso_family =3D AF_BLUETOOTH;
> +       bacpy(&addr->iso_bdaddr, src);
> +       addr->iso_bdaddr_type =3D src_type;
>
> +       if (bc_addr)
> +               memcpy(addr->iso_bc, bc_addr, sizeof(*bc_addr));
> +
> +       if (!bind(sock, (struct sockaddr *)addr, addr_len))
> +               goto done;
> +
> +       ret =3D -errno;
>         ERROR_FAILED(err, "iso_bind", errno);
>
> -       return -errno;
> +done:
> +       free(addr);
> +       return ret;
>  }
>
>  static int sco_connect(int sock, const bdaddr_t *dst)
> @@ -980,6 +1002,11 @@ static gboolean parse_set_opts(struct set_opts *opt=
s, GError **err,
>                 case BT_IO_OPT_BASE:
>                         opts->base =3D *va_arg(args, struct bt_iso_base *=
);
>                         break;
> +               case BT_IO_OPT_ISO_BC_ADDR:
> +                       opts->iso_bc_addr =3D *va_arg(args,
> +                                               struct sockaddr_iso_bc *)=
;
> +                       opts->bc_addr_set =3D true;
> +                       break;
>                 case BT_IO_OPT_INVALID:
>                 case BT_IO_OPT_KEY_SIZE:
>                 case BT_IO_OPT_SOURCE_CHANNEL:
> @@ -1305,6 +1332,7 @@ parse_opts:
>                 case BT_IO_OPT_VOICE:
>                 case BT_IO_OPT_QOS:
>                 case BT_IO_OPT_BASE:
> +               case BT_IO_OPT_ISO_BC_ADDR:
>                 default:
>                         g_set_error(err, BT_IO_ERROR, EINVAL,
>                                         "Unknown option %d", opt);
> @@ -1460,6 +1488,7 @@ static gboolean rfcomm_get(int sock, GError **err, =
BtIOOption opt1,
>                 case BT_IO_OPT_VOICE:
>                 case BT_IO_OPT_QOS:
>                 case BT_IO_OPT_BASE:
> +               case BT_IO_OPT_ISO_BC_ADDR:
>                 case BT_IO_OPT_INVALID:
>                 default:
>                         g_set_error(err, BT_IO_ERROR, EINVAL,
> @@ -1571,6 +1600,7 @@ static gboolean sco_get(int sock, GError **err, BtI=
OOption opt1, va_list args)
>                 case BT_IO_OPT_VOICE:
>                 case BT_IO_OPT_QOS:
>                 case BT_IO_OPT_BASE:
> +               case BT_IO_OPT_ISO_BC_ADDR:
>                 case BT_IO_OPT_INVALID:
>                 default:
>                         g_set_error(err, BT_IO_ERROR, EINVAL,
> @@ -1660,6 +1690,7 @@ static gboolean iso_get(int sock, GError **err, BtI=
OOption opt1, va_list args)
>                 case BT_IO_OPT_FLUSHABLE:
>                 case BT_IO_OPT_PRIORITY:
>                 case BT_IO_OPT_VOICE:
> +               case BT_IO_OPT_ISO_BC_ADDR:
>                 case BT_IO_OPT_INVALID:
>                 default:
>                         g_set_error(err, BT_IO_ERROR, EINVAL,
> @@ -1790,6 +1821,7 @@ static GIOChannel *create_io(gboolean server, struc=
t set_opts *opts,
>  {
>         int sock;
>         GIOChannel *io;
> +       struct sockaddr_iso_bc *iso_bc_addr =3D NULL;
>
>         switch (opts->type) {
>         case BT_IO_L2CAP:
> @@ -1836,7 +1868,11 @@ static GIOChannel *create_io(gboolean server, stru=
ct set_opts *opts,
>                         ERROR_FAILED(err, "socket(SEQPACKET, ISO)", errno=
);
>                         return NULL;
>                 }
> -               if (iso_bind(sock, &opts->src, opts->src_type, err) < 0)
> +               if (opts->bc_addr_set)
> +                       iso_bc_addr =3D &opts->iso_bc_addr;
> +
> +               if (iso_bind(sock, &opts->src, opts->src_type,
> +                                        iso_bc_addr, err) < 0)
>                         goto failed;
>                 if (!iso_set_qos(sock, &opts->qos, err))
>                         goto failed;
> diff --git a/btio/btio.h b/btio/btio.h
> index e9a8a01a3..516220504 100644
> --- a/btio/btio.h
> +++ b/btio/btio.h
> @@ -46,7 +46,8 @@ typedef enum {
>         BT_IO_OPT_VOICE,
>         BT_IO_OPT_PHY,
>         BT_IO_OPT_QOS,
> -       BT_IO_OPT_BASE
> +       BT_IO_OPT_BASE,
> +       BT_IO_OPT_ISO_BC_ADDR,
>  } BtIOOption;
>
>  typedef enum {
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
