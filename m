Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885A8CDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 17:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjJPRi7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 13:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPRi6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 13:38:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F248B9F
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:38:56 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so56777571fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697477935; x=1698082735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghMcYpkILOBuDxVmUFZtc7IfK/aJdU94Act/Au6z7OM=;
        b=OcSN9jjvp6c9XzyJCHLkxkYRCSaGX016k1lXwLdh5tt1/CXDXXsEq4BRLxoU0PPyKP
         ZAPdZftZGp7yrR2/jXBKRaFG+2388GoJIAVO1jlUZ++8o1bZ5T31i7yTDdw6aIbF1E+2
         I5XtS5aFIb1+K8qSndsqcdDTJsrk/PiMpV4RDLB9bAUW47DzJax9GhX72SpsLlCgDgOQ
         TJD4p1F2z+ADEKp2qQNeuksvd9Pf1KQD2Rk1otYnsVr/+/SyeytlBVcmLT6MwZIzqgcz
         WZDmyPT9WFCU6oHVCX1CmaIrZ6rDpTEE9G+JCTJZNr5X29Z0bDZYqTn9i2i2GkEMz3e4
         pDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477935; x=1698082735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghMcYpkILOBuDxVmUFZtc7IfK/aJdU94Act/Au6z7OM=;
        b=CCuFBp0YQ1qAFIY4Vr24Z5bwE+JU75LGUoYlxYF+0b/GRa037+xVGHxnkJXIcelE8E
         6eOG5hEmflX96jiffSB7lqChVN6uHhky56ZNJf/udTJKizGB9ZhGwzC8e1nLnVabkH/n
         0GiIgdx6hP2V89rE8vIZpmktwo+MhulV6fD2NgGpzIJBwqitscPj9B39xrK1tqIBxVkS
         iFCD8ya5ims2E6iZ/3pa2Hrnbm5GqC2G2fHYhSSKJiAB9YxRh6CIA+aze6n9m6KM5MfJ
         Kfa+4h8Kf0NIs7A1/fZmAnKJCYEMlj+BemFNnjopQ+uk8O6w72FcAPHdUFpchQB7trdL
         6KfA==
X-Gm-Message-State: AOJu0YwQQL83oktUyXK6WKULXgManwnc9MdrvvhkbOpJ5EfkqYXnjeEJ
        UCoLjkAo+ir1WhpCCW7/5GDtKkx1dFmrJyhraouObmDzaal6EtHy
X-Google-Smtp-Source: AGHT+IFImubqMCBJ4LGRz/GMdHDwilavdcYuhIKBT+MHmSafYjBiKlFsFkJyl0K6BKYLNc/L77/VunTCMjRBr7dZX8k=
X-Received: by 2002:a05:651c:90:b0:2c5:31de:6c07 with SMTP id
 16-20020a05651c009000b002c531de6c07mr445626ljq.14.1697477934920; Mon, 16 Oct
 2023 10:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231016065228.424400-1-kiran.k@intel.com> <20231016065228.424400-2-kiran.k@intel.com>
In-Reply-To: <20231016065228.424400-2-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Oct 2023 10:38:41 -0700
Message-ID: <CABBYNZKOzgP5ordRNK9UX=i3r=BMM4OushpaN2nO=Ntuexe_kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] shared/bap: Add support for Audio Locations
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Sun, Oct 15, 2023 at 11:40=E2=80=AFPM Kiran K <kiran.k@intel.com> wrote:
>
> This adds support to provide Audio Locations for BAP Sink and Source Endp=
oints
> ---
>  profiles/audio/media.c |  2 +-
>  src/shared/bap.c       | 56 ++++++++++++++++++++++++++++++++----------
>  src/shared/bap.h       |  6 +++--
>  3 files changed, 48 insertions(+), 16 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 51e3ab65d12d..d063bbf11cf9 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1250,7 +1250,7 @@ static bool endpoint_init_pac(struct media_endpoint=
 *endpoint, uint8_t type,
>
>         endpoint->pac =3D bt_bap_add_vendor_pac(db, name, type, endpoint-=
>codec,
>                                 endpoint->cid, endpoint->vid, &endpoint->=
qos,
> -                               &data, metadata);
> +                               &data, metadata, endpoint->location);
>         if (!endpoint->pac) {
>                 error("Unable to create PAC");
>                 free(metadata);
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 925501c48d98..bee19039900f 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -190,6 +190,7 @@ struct bt_bap_pac {
>         uint8_t type;
>         struct bt_bap_codec codec;
>         struct bt_bap_pac_qos qos;
> +       uint32_t location;
>         struct iovec *data;
>         struct iovec *metadata;
>         struct bt_bap_pac_ops *ops;
> @@ -368,6 +369,14 @@ static void pac_foreach(void *data, void *user_data)
>                 meta->len =3D 0;
>  }
>
> +static void get_pac_loc(void *data, void *user_data)
> +{
> +       struct bt_bap_pac *pac =3D data;
> +       uint32_t *location =3D user_data;
> +
> +       *location |=3D pac->location;
> +}
> +
>  static void pacs_sink_read(struct gatt_db_attribute *attrib,
>                                 unsigned int id, uint16_t offset,
>                                 uint8_t opcode, struct bt_att *att,
> @@ -395,7 +404,15 @@ static void pacs_sink_loc_read(struct gatt_db_attrib=
ute *attrib,
>                                 void *user_data)
>  {
>         struct bt_pacs *pacs =3D user_data;
> -       uint32_t value =3D cpu_to_le32(pacs->sink_loc_value);
> +       struct bt_bap_db *bdb =3D pacs->bdb;
> +       uint32_t value;
> +
> +       queue_foreach(bdb->sinks, get_pac_loc, &pacs->sink_loc_value);
> +       if (pacs->sink_loc_value)
> +               value =3D cpu_to_le32(pacs->sink_loc_value);
> +       else
> +               /* Set default value */
> +               value =3D cpu_to_le32(PACS_SNK_LOCATION);
>
>         gatt_db_attribute_read_result(attrib, id, 0, (void *) &value,
>                                                         sizeof(value));
> @@ -428,7 +445,15 @@ static void pacs_source_loc_read(struct gatt_db_attr=
ibute *attrib,
>                                 void *user_data)
>  {
>         struct bt_pacs *pacs =3D user_data;
> -       uint32_t value =3D cpu_to_le32(pacs->source_loc_value);
> +       struct bt_bap_db *bdb =3D pacs->bdb;
> +       uint32_t value;
> +
> +       queue_foreach(bdb->sources, get_pac_loc, &pacs->source_loc_value)=
;
> +       if (pacs->source_loc_value)
> +               value =3D cpu_to_le32(pacs->source_loc_value);
> +       else
> +               /* Set default value */
> +               value =3D cpu_to_le32(PACS_SRC_LOCATION);
>
>         gatt_db_attribute_read_result(attrib, id, 0, (void *) &value,
>                                                         sizeof(value));
> @@ -474,9 +499,8 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
>
>         pacs =3D new0(struct bt_pacs, 1);
>
> -       /* Set default values */
> -       pacs->sink_loc_value =3D PACS_SNK_LOCATION;
> -       pacs->source_loc_value =3D PACS_SRC_LOCATION;
> +       pacs->sink_loc_value =3D 0;
> +       pacs->source_loc_value =3D 0;
>         pacs->sink_context_value =3D PACS_SNK_CTXT;
>         pacs->source_context_value =3D PACS_SRC_CTXT;
>         pacs->supported_sink_context_value =3D PACS_SUPPORTED_SNK_CTXT;
> @@ -2451,7 +2475,8 @@ static struct bt_bap_pac *bap_pac_new(struct bt_bap=
_db *bdb, const char *name,
>                                         struct bt_bap_codec *codec,
>                                         struct bt_bap_pac_qos *qos,
>                                         struct iovec *data,
> -                                       struct iovec *metadata)
> +                                       struct iovec *metadata,
> +                                       uint32_t location)
>  {
>         struct bt_bap_pac *pac;
>
> @@ -2468,6 +2493,8 @@ static struct bt_bap_pac *bap_pac_new(struct bt_bap=
_db *bdb, const char *name,
>         if (qos)
>                 pac->qos =3D *qos;
>
> +       pac->location =3D location;
> +
>         return pac;
>  }
>
> @@ -2679,7 +2706,8 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gat=
t_db *db,
>                                         uint8_t id, uint16_t cid, uint16_=
t vid,
>                                         struct bt_bap_pac_qos *qos,
>                                         struct iovec *data,
> -                                       struct iovec *metadata)
> +                                       struct iovec *metadata,
> +                                       uint32_t location)
>  {
>         struct bt_bap_db *bdb;
>         struct bt_bap_pac *pac, *pac_broadcast_sink;
> @@ -2699,7 +2727,8 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gat=
t_db *db,
>         codec.cid =3D cid;
>         codec.vid =3D vid;
>
> -       pac =3D bap_pac_new(bdb, name, type, &codec, qos, data, metadata)=
;
> +       pac =3D bap_pac_new(bdb, name, type, &codec, qos, data, metadata,
> +                               location);
>
>         switch (type) {
>         case BT_BAP_SINK:
> @@ -2716,7 +2745,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gat=
t_db *db,
>                          */
>                         pac_broadcast_sink =3D bap_pac_new(bdb, name,
>                                         BT_BAP_BCAST_SINK, &codec, qos,
> -                                       data, metadata);
> +                                       data, metadata, 0);
>                         bap_add_broadcast_sink(pac_broadcast_sink);
>                 }
>                 break;
> @@ -2737,10 +2766,11 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db =
*db, const char *name,
>                                         uint8_t type, uint8_t id,
>                                         struct bt_bap_pac_qos *qos,
>                                         struct iovec *data,
> -                                       struct iovec *metadata)
> +                                       struct iovec *metadata,
> +                                       uint32_t location)
>  {
>         return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, =
qos,
> -                                                       data, metadata);
> +                                               data, metadata, location)=
;
>  }
>
>  uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
> @@ -3256,7 +3286,7 @@ static void bap_parse_pacs(struct bt_bap *bap, uint=
8_t type,
>                 }
>
>                 pac =3D bap_pac_new(bap->rdb, NULL, type, &p->codec, NULL=
, &data,
> -                                                               &metadata=
);
> +                                                       &metadata, 0);
>                 if (!pac)
>                         continue;
>
> @@ -5481,7 +5511,7 @@ bool bt_bap_new_bcast_source(struct bt_bap *bap, co=
nst char *name)
>                 return true;
>
>         pac_broadcast_source =3D bap_pac_new(bap->rdb, name, BT_BAP_BCAST=
_SOURCE,
> -                       NULL, NULL, NULL, NULL);
> +                       NULL, NULL, NULL, NULL, 0);
>         queue_push_tail(bap->rdb->broadcast_sources, pac_broadcast_source=
);
>
>         if (!pac_broadcast_source)
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index ebe4dbf7d858..10e82f35e547 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -141,13 +141,15 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gat=
t_db *db,
>                                         uint8_t id, uint16_t cid, uint16_=
t vid,
>                                         struct bt_bap_pac_qos *qos,
>                                         struct iovec *data,
> -                                       struct iovec *metadata);
> +                                       struct iovec *metadata,
> +                                       uint32_t location);
>
>  struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
>                                         uint8_t type, uint8_t id,
>                                         struct bt_bap_pac_qos *qos,
>                                         struct iovec *data,
> -                                       struct iovec *metadata);
> +                                       struct iovec *metadata,
> +                                       uint32_t location);

If you change the API you will need to fix their users as well
otherwise it won't build and CI will fail.

>  struct bt_bap_pac_ops {
>         int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> --
> 2.34.1



--=20
Luiz Augusto von Dentz
