Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9A5C7EE2F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jun 2023 23:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbjFFXMN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jun 2023 19:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjFFXML (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jun 2023 19:12:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BA7E7E
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jun 2023 16:12:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1bb2fc9c6so49769571fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jun 2023 16:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686093127; x=1688685127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4sDXU475Yxsi2w+Hz/m2M8AVg2K4bPex4xd7e3xwBI=;
        b=iSVvDiCjQzZpwSWuTQ661hmasWx9Nrfx0h15Zs/1OOm4/S5oLJsaPcRxjnQ+JGXh9P
         GHL6rEy5PqTm7T69FDle8qJSt9x89gcoTyGYOJETT94Wp3IF+GIaCY6d7TAv/jsaErii
         ZAJi2TWGw3FTeDqeZOXCOTwBXCEBBFVEh6dEIu+P7HuCwYVK9/BqcCXI0/fmIvQeRWrn
         tj0FjBlzeF9fXVhWqxmOntRFIlQphhpqpTbP9b43QYF9XJMNAs6pBrtmSFrH81A3Eyug
         3fc6URi1oYw1MX9Omuj30Jfw3Zl2+hak+EhxTEEUIxCR/sxaADAsnDWVL4eK5GzYXhaH
         9aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686093127; x=1688685127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4sDXU475Yxsi2w+Hz/m2M8AVg2K4bPex4xd7e3xwBI=;
        b=QJkY00pqMt/W/Hc0uAG14rXT5XWUYROtAO4IYVKJvPj5tyyZN2SoGH2MZPEGb57muq
         pNGKLFRABy8mIUZV0dumqFejnejH8wW4/7z6PkhQxFjLtxJTpsRW+iTwX51W3cPRMcqk
         Km2QoAgOzmIb1ZPTB9zsxgwmjjNy7QJeZA2RRUhUXkqtLGUTbKc3rge2uJws5PqNxiJ+
         XKjag0vqlue47uGpPEQQW0kpIDQQE77nUVRxdtrlY2bjUzvYRTqw3AVqpUHEalCNxQ8K
         puYwXWTIXlqm59cMa9cC/mi+8sQhJy3phDbViwAJoKNz8XONYQJe0VoqzarkrGoSIL9U
         SjHA==
X-Gm-Message-State: AC+VfDyvb7RCD25NOwg1bcblxDMuYEwrfnLwvnO2Yf+SYQs8qqqwfn4Z
        h21/daYXD58Isd2op8vsE8u+T8QaqFBaqDpuT7y9x1TV
X-Google-Smtp-Source: ACHHUZ5MWDMxZZeJCYfabXtUkMUOYFYgsNk850wWjGwwhH9pz+cQ6eEmwM1MCpB4I0EBoYs3EbzohIACqjD69zEbtXY=
X-Received: by 2002:a2e:9599:0:b0:2b1:bcf2:68a5 with SMTP id
 w25-20020a2e9599000000b002b1bcf268a5mr1566622ljh.8.1686093126775; Tue, 06 Jun
 2023 16:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230606120824.4705-1-nitin.jadhav@nxp.com> <20230606120824.4705-2-nitin.jadhav@nxp.com>
In-Reply-To: <20230606120824.4705-2-nitin.jadhav@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 6 Jun 2023 16:11:54 -0700
Message-ID: <CABBYNZK+=A+hQtnH=jZCgiL0q6x=11iMTUbE=xDNi4oMPr3vRA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/2] Added initial code for handling VOCS
To:     NJNXP <nitin.jadhav@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nitin,

On Tue, Jun 6, 2023 at 5:09=E2=80=AFAM NJNXP <nitin.jadhav@nxp.com> wrote:
>
> This commit handles the code implementation of VOCS service and character=
istics
> ---
>  lib/uuid.h       |   5 +
>  src/shared/vcp.c | 533 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 538 insertions(+)
>
> diff --git a/lib/uuid.h b/lib/uuid.h
> index 5cdfedb4b..e8c7f8e37 100644
> --- a/lib/uuid.h
> +++ b/lib/uuid.h
> @@ -179,6 +179,11 @@ extern "C" {
>  #define VOL_CP_CHRC_UUID                               0x2B7E
>  #define VOL_FLAG_CHRC_UUID                             0x2B7F
>
> +#define VOL_OFFSET_STATE_CHAR_UUID             0x2B80
> +#define AUDIO_LOCATION_CHRC_UUID               0x2B81
> +#define VOL_OFFSET_CP_CHRC_UUID                        0x2B82
> +#define AUDIO_OUTPUT_DESC_CHAR_UUID            0x2B83

It might be a good idea to prefix these with VCS just to make sure,
something like:

<SERVICE>_<ATTRIBUTE NAME>_UUID

>  #define GMCS_UUID                               0x1849
>  #define MEDIA_PLAYER_NAME_CHRC_UUID             0x2b93
>  #define MEDIA_TRACK_CHNGD_CHRC_UUID             0x2b96
> diff --git a/src/shared/vcp.c b/src/shared/vcp.c
> index 5459cf892..05e341108 100644
> --- a/src/shared/vcp.c
> +++ b/src/shared/vcp.c
> @@ -36,9 +36,40 @@
>  #define BT_ATT_ERROR_INVALID_CHANGE_COUNTER    0x80
>  #define BT_ATT_ERROR_OPCODE_NOT_SUPPORTED      0x81
>
> +#define GEN_AUDIO_AUDLOC_NA                   0x00000000
> +#define GEN_AUDIO_AUDLOC_FL                   0x00000001
> +#define GEN_AUDIO_AUDLOC_FR                   0x00000002
> +#define GEN_AUDIO_AUDLOC_FC                   0x00000004
> +#define GEN_AUDIO_AUDLOC_LOW_FRQ_EFF_1        0x00000008
> +#define GEN_AUDIO_AUDLOC_BL                   0x00000010
> +#define GEN_AUDIO_AUDLOC_BR                   0x00000020
> +#define GEN_AUDIO_AUDLOC_FLC                  0x00000040
> +#define GEN_AUDIO_AUDLOC_FRC                  0x00000080
> +#define GEN_AUDIO_AUDLOC_BC                   0x00000100
> +#define GEN_AUDIO_AUDLOC_LOW_FRQ_EFF_2        0x00000200
> +#define GEN_AUDIO_AUDLOC_SL                   0x00000400
> +#define GEN_AUDIO_AUDLOC_SR                   0x00000800
> +#define GEN_AUDIO_AUDLOC_TFL                  0x00001000
> +#define GEN_AUDIO_AUDLOC_TFR                  0x00002000
> +#define GEN_AUDIO_AUDLOC_TFC                  0x00004000
> +#define GEN_AUDIO_AUDLOC_TC                   0x00008000
> +#define GEN_AUDIO_AUDLOC_TBL                  0x00010000
> +#define GEN_AUDIO_AUDLOC_TBR                  0x00020000
> +#define GEN_AUDIO_AUDLOC_TSL                  0x00040000
> +#define GEN_AUDIO_AUDLOC_TSR                  0x00080000
> +#define GEN_AUDIO_AUDLOC_TBC                  0x00100000
> +#define GEN_AUDIO_AUDLOC_BFC                  0x00200000
> +#define GEN_AUDIO_AUDLOC_BFL                  0x00400000
> +#define GEN_AUDIO_AUDLOC_BFR                  0x00800000
> +#define GEN_AUDIO_AUDLOC_FLW                  0x01000000
> +#define GEN_AUDIO_AUDLOC_FRW                  0x02000000
> +#define GEN_AUDIO_AUDLOC_LS                   0x04000000
> +#define GEN_AUDIO_AUDLOC_RS                   0x08000000

Id prefer we do something like: BT_VCP_FRONT_LEFT, BT_VCP_FRONT_RIGHT,
or we have it in a common header since it appears this is shared with
the likes of PACS.

>  struct bt_vcp_db {
>         struct gatt_db *db;
>         struct bt_vcs *vcs;
> +       struct bt_vocs *vocs;
>  };
>
>  typedef void (*vcp_func_t)(struct bt_vcp *vcp, bool success, uint8_t att=
_ecode,
> @@ -57,11 +88,21 @@ struct bt_vcs_param {
>         uint8_t change_counter;
>  } __packed;
>
> +struct bt_vocs_param {
> +       uint8_t op;
> +       uint8_t change_counter;
> +} __packed;
> +
>  struct bt_vcs_ab_vol {
>         uint8_t change_counter;
>         uint8_t vol_set;
>  } __packed;
>
> +struct bt_vocs_set_vol_off {
> +       uint8_t change_counter;
> +       uint8_t set_vol_offset;
> +} __packed;
> +
>  struct bt_vcp_cb {
>         unsigned int id;
>         bt_vcp_func_t attached;
> @@ -89,6 +130,10 @@ struct bt_vcp {
>         unsigned int vstate_id;
>         unsigned int vflag_id;
>
> +       unsigned int vostate_id;
> +       unsigned int vocs_audio_loc_id;
> +       unsigned int vocs_ao_dec_id;

No need to prefix these if they can be inferred by the struct name, so
you can use state_id, location_id, etc.

> +
>         struct queue *notify;
>         struct queue *pending;
>
> @@ -120,6 +165,27 @@ struct bt_vcs {
>         struct gatt_db_attribute *vf_ccc;
>  };
>
> +/* Contains local bt_vcp_db */
> +struct vol_offset_state {
> +       uint16_t vol_offset;
> +       uint8_t counter;
> +} __packed;
> +
> +struct bt_vocs {
> +       struct bt_vcp_db *vdb;
> +       struct vol_offset_state *vostate;
> +       uint32_t vocs_audio_loc;
> +       char *vocs_ao_dec;
> +       struct gatt_db_attribute *service;
> +       struct gatt_db_attribute *vos;
> +       struct gatt_db_attribute *vos_ccc;
> +       struct gatt_db_attribute *voal;
> +       struct gatt_db_attribute *voal_ccc;
> +       struct gatt_db_attribute *vo_cp;
> +       struct gatt_db_attribute *voaodec;
> +       struct gatt_db_attribute *voaodec_ccc;
> +};
> +
>  static struct queue *vcp_db;
>  static struct queue *vcp_cbs;
>  static struct queue *sessions;
> @@ -159,6 +225,17 @@ static struct vol_state *vdb_get_vstate(struct bt_vc=
p_db *vdb)
>         return NULL;
>  }
>
> +static struct vol_offset_state *vdb_get_vostate(struct bt_vcp_db *vdb)
> +{
> +       if (!vdb->vocs)
> +               return NULL;
> +
> +       if (vdb->vocs->vostate)
> +               return vdb->vocs->vostate;
> +
> +       return NULL;
> +}
> +
>  static struct bt_vcs *vcp_get_vcs(struct bt_vcp *vcp)
>  {
>         if (!vcp)
> @@ -173,6 +250,20 @@ static struct bt_vcs *vcp_get_vcs(struct bt_vcp *vcp=
)
>         return vcp->rdb->vcs;
>  }
>
> +static struct bt_vocs *vcp_get_vocs(struct bt_vcp *vcp)
> +{
> +       if (!vcp)
> +               return NULL;
> +
> +       if (vcp->rdb->vocs)
> +               return vcp->rdb->vocs;
> +
> +       vcp->rdb->vocs =3D new0(struct bt_vocs, 1);
> +       vcp->rdb->vocs->vdb =3D vcp->rdb;
> +
> +       return vcp->rdb->vocs;
> +}
> +
>  static void vcp_detached(void *data, void *user_data)
>  {
>         struct bt_vcp_cb *cb =3D data;
> @@ -202,6 +293,7 @@ static void vcp_db_free(void *data)
>         gatt_db_unref(vdb->db);
>
>         free(vdb->vcs);
> +       free(vdb->vocs);
>         free(vdb);
>  }
>
> @@ -583,6 +675,45 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct b=
t_vcp *vcp,
>         return 0;
>  }
>
> +static uint8_t vocs_set_vol_offset(struct bt_vocs *vocs, struct bt_vcp *=
vcp,
> +                               struct iovec *iov)
> +{
> +       struct bt_vcp_db *vdb;
> +       struct vol_offset_state *vstate;
> +       struct bt_vocs_set_vol_off *req;
> +
> +       DBG(vcp, "Set Volume Offset");
> +
> +       vdb =3D vcp_get_vdb(vcp);
> +       if (!vdb) {
> +               DBG(vcp, "error: VDB not available");
> +               return 0;
> +       }
> +
> +       vstate =3D vdb_get_vostate(vdb);
> +       if (!vstate) {
> +               DBG(vcp, "error: VSTATE not available");
> +               return 0;
> +       }
> +
> +       req =3D iov_pull_mem(iov, sizeof(*req));
> +       if (!req)
> +               return 0;
> +
> +       if (req->change_counter !=3D vstate->counter) {
> +               DBG(vcp, "Change Counter Mismatch Volume not decremented!=
");
> +               return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
> +       }
> +
> +       vstate->vol_offset =3D req->set_vol_offset;
> +       vstate->counter =3D -~vstate->counter; /*Increment Change Counter=
*/
> +
> +       gatt_db_attribute_notify(vdb->vocs->vos, (void *)vstate,
> +                                sizeof(struct vol_offset_state),
> +                                bt_vcp_get_att(vcp));
> +       return 0;
> +}
> +
>  #define        BT_VCS_REL_VOL_DOWN             0x00
>  #define        BT_VCS_REL_VOL_UP               0x01
>  #define        BT_VCS_UNMUTE_REL_VOL_DOWN      0x02
> @@ -591,6 +722,8 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct bt=
_vcp *vcp,
>  #define        BT_VCS_UNMUTE                   0x05
>  #define        BT_VCS_MUTE                     0x06
>
> +#define BT_VOCS_SET_VOL_OFFSET 0x01
> +
>  #define VCS_OP(_str, _op, _size, _func) \
>         { \
>                 .str =3D _str, \
> @@ -623,6 +756,26 @@ struct vcs_op_handler {
>         {}
>  };
>
> +#define VOCS_OP(_str, _op, _size, _func) \
> +       { \
> +               .str =3D _str, \
> +               .op =3D _op, \
> +               .size =3D _size, \
> +               .func =3D _func, \
> +       }
> +
> +struct vocs_op_handler {
> +       const char *str;
> +       uint8_t op;
> +       size_t  size;
> +       uint8_t (*func)(struct bt_vocs *vocs, struct bt_vcp *vcp,
> +                       struct iovec *iov);
> +} vocp_handlers[] =3D {
> +       VOCS_OP("Set Volume Offset", BT_VOCS_SET_VOL_OFFSET,
> +               sizeof(uint8_t), vocs_set_vol_offset),
> +       {}
> +};
> +
>  static void vcs_cp_write(struct gatt_db_attribute *attrib,
>                                 unsigned int id, uint16_t offset,
>                                 const uint8_t *value, size_t len,
> @@ -683,6 +836,66 @@ respond:
>         gatt_db_attribute_write_result(attrib, id, ret);
>  }
>
> +static void vocs_cp_write(struct gatt_db_attribute *attrib,
> +                               unsigned int id, uint16_t offset,
> +                               const uint8_t *value, size_t len,
> +                               uint8_t opcode, struct bt_att *att,
> +                               void *user_data)
> +{
> +       struct bt_vocs *vocs =3D user_data;
> +       struct bt_vcp *vcp =3D vcp_get_session(att, vocs->vdb->db);
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *) value,
> +               .iov_len =3D len,
> +       };
> +       uint8_t *vcp_op;
> +       struct vocs_op_handler *handler;
> +       uint8_t ret =3D BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
> +
> +       DBG(vcp, "VOCP Control Point Write");
> +
> +       if (offset) {
> +               DBG(vcp, "invalid offset %d", offset);
> +               ret =3D BT_ATT_ERROR_INVALID_OFFSET;
> +               goto respond;
> +       }
> +
> +       if (len < sizeof(*vcp_op)) {
> +               DBG(vcp, "invalid len %ld < %ld sizeof(*param)", len,
> +                                                       sizeof(*vcp_op));
> +               ret =3D BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
> +               goto respond;
> +       }
> +
> +       vcp_op =3D iov_pull_mem(&iov, sizeof(*vcp_op));
> +
> +       for (handler =3D vocp_handlers; handler && handler->str; handler+=
+) {
> +               if (handler->op !=3D *vcp_op)
> +                       continue;
> +
> +               if (iov.iov_len < handler->size) {
> +                       DBG(vcp, "invalid len %ld < %ld handler->size", l=
en,
> +                           handler->size);
> +                       ret =3D BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
> +                       goto respond;
> +               }
> +
> +               break;
> +       }
> +
> +       if (handler && handler->str) {
> +               DBG(vcp, "%s", handler->str);
> +
> +               ret =3D handler->func(vocs, vcp, &iov);
> +       } else {
> +               DBG(vcp, "Unknown opcode 0x%02x", *vcp_op);
> +               ret =3D BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
> +       }
> +
> +respond:
> +       gatt_db_attribute_write_result(attrib, id, ret);
> +}
> +
>  static void vcs_state_read(struct gatt_db_attribute *attrib,
>                                 unsigned int id, uint16_t offset,
>                                 uint8_t opcode, struct bt_att *att,
> @@ -698,6 +911,21 @@ static void vcs_state_read(struct gatt_db_attribute =
*attrib,
>                                                         iov.iov_len);
>  }
>
> +static void vocs_state_read(struct gatt_db_attribute *attrib,
> +                               unsigned int id, uint16_t offset,
> +                               uint8_t opcode, struct bt_att *att,
> +                               void *user_data)
> +{
> +       struct bt_vocs *vocs =3D user_data;
> +       struct iovec iov;
> +
> +       iov.iov_base =3D vocs->vostate;
> +       iov.iov_len =3D sizeof(*vocs->vostate);
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> +                                                       iov.iov_len);
> +}
> +
>  static void vcs_flag_read(struct gatt_db_attribute *attrib,
>                                 unsigned int id, uint16_t offset,
>                                 uint8_t opcode, struct bt_att *att,
> @@ -713,6 +941,36 @@ static void vcs_flag_read(struct gatt_db_attribute *=
attrib,
>                                                         iov.iov_len);
>  }
>
> +static void vocs_voal_read(struct gatt_db_attribute *attrib,
> +                               unsigned int id, uint16_t offset,
> +                               uint8_t opcode, struct bt_att *att,
> +                               void *user_data)
> +{
> +       struct bt_vocs *vocs =3D user_data;
> +       struct iovec iov;
> +
> +       iov.iov_base =3D &vocs->vocs_audio_loc;
> +       iov.iov_len =3D sizeof(vocs->vocs_audio_loc);
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> +                                                       iov.iov_len);
> +}
> +
> +static void vocs_voaodec_read(struct gatt_db_attribute *attrib,
> +                               unsigned int id, uint16_t offset,
> +                               uint8_t opcode, struct bt_att *att,
> +                               void *user_data)
> +{
> +       struct bt_vocs *vocs =3D user_data;
> +       struct iovec iov;
> +
> +       iov.iov_base =3D &vocs->vocs_ao_dec;
> +       iov.iov_len =3D strlen(vocs->vocs_ao_dec);
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> +                                                       iov.iov_len);
> +}
> +
>  static struct bt_vcs *vcs_new(struct gatt_db *db)
>  {
>         struct bt_vcs *vcs;
> @@ -771,6 +1029,74 @@ static struct bt_vcs *vcs_new(struct gatt_db *db)
>         return vcs;
>  }
>
> +static struct bt_vocs *vocs_new(struct gatt_db *db)
> +{
> +       struct bt_vocs *vocs;
> +       struct vol_offset_state *vostate;
> +       bt_uuid_t uuid;
> +
> +       if (!db)
> +               return NULL;
> +
> +       vocs =3D new0(struct bt_vocs, 1);
> +
> +       vostate =3D new0(struct vol_offset_state, 1);
> +
> +       vocs->vostate =3D vostate;
> +       vocs->vocs_audio_loc =3D GEN_AUDIO_AUDLOC_FL;
> +       vocs->vocs_ao_dec =3D "Left Speaker";
> +
> +       /* Populate DB with VOCS attributes */
> +       bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
> +       vocs->service =3D gatt_db_add_service(db, &uuid, true, 9);
> +
> +       bt_uuid16_create(&uuid, VOL_OFFSET_STATE_CHAR_UUID);
> +       vocs->vos =3D gatt_db_service_add_characteristic(vocs->service,
> +                                       &uuid,
> +                                       BT_ATT_PERM_READ,
> +                                       BT_GATT_CHRC_PROP_READ |
> +                                       BT_GATT_CHRC_PROP_NOTIFY,
> +                                       vocs_state_read, NULL,
> +                                       vocs);
> +
> +       vocs->vos_ccc =3D gatt_db_service_add_ccc(vocs->service,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE);
> +
> +       bt_uuid16_create(&uuid, AUDIO_LOCATION_CHRC_UUID);
> +       vocs->voal =3D gatt_db_service_add_characteristic(vocs->service,
> +                                       &uuid,
> +                                       BT_ATT_PERM_READ,
> +                                       BT_GATT_CHRC_PROP_READ |
> +                                       BT_GATT_CHRC_PROP_NOTIFY,
> +                                       vocs_voal_read, NULL,
> +                                       vocs);
> +
> +       vocs->voal_ccc =3D gatt_db_service_add_ccc(vocs->service,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE);
> +
> +       bt_uuid16_create(&uuid, VOL_OFFSET_CP_CHRC_UUID);
> +       vocs->vo_cp =3D gatt_db_service_add_characteristic(vocs->service,
> +                                       &uuid,
> +                                       BT_ATT_PERM_WRITE,
> +                                       BT_GATT_CHRC_PROP_WRITE,
> +                                       NULL, vocs_cp_write,
> +                                       vocs);
> +
> +       bt_uuid16_create(&uuid, AUDIO_OUTPUT_DESC_CHAR_UUID);
> +       vocs->voaodec =3D gatt_db_service_add_characteristic(vocs->servic=
e,
> +                                       &uuid,
> +                                       BT_ATT_PERM_READ,
> +                                       BT_GATT_CHRC_PROP_READ |
> +                                       BT_GATT_CHRC_PROP_NOTIFY,
> +                                       vocs_voaodec_read, NULL,
> +                                       vocs);
> +
> +       vocs->voaodec_ccc =3D gatt_db_service_add_ccc(vocs->service,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE);
> +
> +       return vocs;
> +}
> +
>  static struct bt_vcp_db *vcp_db_new(struct gatt_db *db)
>  {
>         struct bt_vcp_db *vdb;
> @@ -787,6 +1113,9 @@ static struct bt_vcp_db *vcp_db_new(struct gatt_db *=
db)
>         vdb->vcs =3D vcs_new(db);
>         vdb->vcs->vdb =3D vdb;
>
> +       vdb->vocs =3D vocs_new(db);
> +       vdb->vocs->vdb =3D vdb;
> +
>         queue_push_tail(vcp_db, vdb);
>
>         return vdb;
> @@ -911,6 +1240,41 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, u=
int16_t value_handle,
>         DBG(vcp, "Vol Counter 0x%x", vstate.counter);
>  }
>
> +static void vcp_voffset_state_notify(struct bt_vcp *vcp, uint16_t value_=
handle,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct vol_offset_state vostate;
> +
> +       memcpy(&vostate, value, sizeof(struct vol_offset_state));
> +
> +       DBG(vcp, "Vol Offset 0x%x", vostate.vol_offset);
> +       DBG(vcp, "Vol Offset Counter 0x%x", vostate.counter);
> +}
> +
> +static void vcp_audio_loc_notify(struct bt_vcp *vcp, uint16_t value_hand=
le,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       uint32_t *vocs_audio_loc_n =3D 0;
> +
> +       memcpy(vocs_audio_loc_n, value, sizeof(uint32_t));
> +
> +       DBG(vcp, "VOCS Audio Location 0x%x", *vocs_audio_loc_n);
> +}
> +
> +
> +static void vcp_audio_descriptor_notify(struct bt_vcp *vcp, uint16_t val=
ue_handle,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       char vocs_audio_dec_n[256] =3D {'\0'};
> +
> +       memcpy(vocs_audio_dec_n, value, length);
> +
> +       DBG(vcp, "VOCS Audio Descriptor 0x%s", *vocs_audio_dec_n);
> +}
> +
>  static void vcp_vflag_notify(struct bt_vcp *vcp, uint16_t value_handle,
>                              const uint8_t *value, uint16_t length,
>                              void *user_data)
> @@ -972,6 +1336,80 @@ static void read_vol_state(struct bt_vcp *vcp, bool=
 success, uint8_t att_ecode,
>         DBG(vcp, "Vol Counter:%x", vs->counter);
>  }
>
> +static void read_vol_offset_state(struct bt_vcp *vcp, bool success, uint=
8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct vol_offset_state *vos;
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *) value,
> +               .iov_len =3D length,
> +       };
> +
> +       if (!success) {
> +               DBG(vcp, "Unable to read Vol Offset State: error 0x%02x",=
 att_ecode);
> +               return;
> +       }
> +
> +       vos =3D iov_pull_mem(&iov, sizeof(*vos));
> +       if (!vos) {
> +               DBG(vcp, "Unable to get Vol Offset State");
> +               return;
> +       }
> +
> +       DBG(vcp, "Vol Set:%x", vos->vol_offset);
> +       DBG(vcp, "Vol Counter:%x", vos->counter);
> +}
> +
> +static void read_vocs_audio_location(struct bt_vcp *vcp, bool success, u=
int8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       uint32_t *vocs_audio_loc;
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *) value,
> +               .iov_len =3D length,
> +       };
> +
> +       if (!success) {
> +               DBG(vcp, "Unable to read VOCS Audio Location: error 0x%02=
x", att_ecode);
> +               return;
> +       }
> +
> +       vocs_audio_loc =3D iov_pull_mem(&iov, sizeof(uint32_t));
> +       if (!*vocs_audio_loc) {
> +               DBG(vcp, "Unable to get VOCS Audio Location");
> +               return;
> +       }
> +
> +       DBG(vcp, "VOCS Audio Loc:%x", *vocs_audio_loc);
> +}
> +
> +
> +static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,=
 uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       char *vocs_ao_dec_r;
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *) value,
> +               .iov_len =3D length,
> +       };
> +
> +       if (!success) {
> +               DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%=
02x", att_ecode);
> +               return;
> +       }
> +
> +       vocs_ao_dec_r =3D iov_pull_mem(&iov, length);
> +       if (!*vocs_ao_dec_r) {
> +               DBG(vcp, "Unable to get VOCS Audio Descriptor");
> +               return;
> +       }
> +
> +       DBG(vcp, "VOCS Audio Descriptor:%s", *vocs_ao_dec_r);
> +}
> +
>  static void vcp_pending_destroy(void *data)
>  {
>         struct bt_vcp_pending *pending =3D data;
> @@ -1128,6 +1566,85 @@ static void foreach_vcs_char(struct gatt_db_attrib=
ute *attr, void *user_data)
>         }
>  }
>
> +static void foreach_vocs_char(struct gatt_db_attribute *attr, void *user=
_data)
> +{
> +       struct bt_vcp *vcp =3D user_data;
> +       uint16_t value_handle;
> +       bt_uuid_t uuid, uuid_vostate, uuid_audio_loc, uuid_vo_cp, uuid_au=
dio_op_decs;
> +       struct bt_vocs *vocs;
> +
> +       if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
> +                                               NULL, NULL, &uuid))
> +               return;
> +
> +       bt_uuid16_create(&uuid_vostate, VOL_OFFSET_STATE_CHAR_UUID);
> +       bt_uuid16_create(&uuid_audio_loc, AUDIO_LOCATION_CHRC_UUID);
> +       bt_uuid16_create(&uuid_vo_cp, VOL_OFFSET_CP_CHRC_UUID);
> +       bt_uuid16_create(&uuid_audio_op_decs, AUDIO_OUTPUT_DESC_CHAR_UUID=
);
> +
> +       if (!bt_uuid_cmp(&uuid, &uuid_vostate)) {
> +               DBG(vcp, "VOCS Vol state found: handle 0x%04x", value_han=
dle);
> +
> +               vocs =3D vcp_get_vocs(vcp);
> +               if (!vocs || vocs->vos)
> +                       return;
> +
> +               vocs->vos =3D attr;
> +
> +               vcp_read_value(vcp, value_handle, read_vol_offset_state, =
vcp);
> +
> +               vcp->vostate_id =3D vcp_register_notify(vcp, value_handle=
,
> +                                                    vcp_voffset_state_no=
tify, NULL);
> +
> +               return;
> +       }
> +
> +       if (!bt_uuid_cmp(&uuid, &uuid_audio_loc)) {
> +               DBG(vcp, "VOCS Volume Audio Location found: handle 0x%04x=
", value_handle);
> +
> +               vocs =3D vcp_get_vocs(vcp);
> +               if (!vocs || vocs->voal)
> +                       return;
> +
> +               vocs->voal =3D attr;
> +
> +               vcp_read_value(vcp, value_handle, read_vocs_audio_locatio=
n, vcp);
> +
> +               vcp->vocs_audio_loc_id =3D vcp_register_notify(vcp, value=
_handle,
> +                                                    vcp_audio_loc_notify=
, NULL);
> +
> +               return;
> +       }
> +
> +       if (!bt_uuid_cmp(&uuid, &uuid_vo_cp)) {
> +               DBG(vcp, "VOCS Volume CP found: handle 0x%04x", value_han=
dle);
> +
> +               vocs =3D vcp_get_vocs(vcp);
> +               if (!vocs || vocs->vo_cp)
> +                       return;
> +
> +               vocs->vo_cp =3D attr;
> +
> +               return;
> +       }
> +
> +       if (!bt_uuid_cmp(&uuid, &uuid_audio_op_decs)) {
> +               DBG(vcp, "VOCS Vol Audio Descriptor found: handle 0x%04x"=
, value_handle);
> +
> +               vocs =3D vcp_get_vocs(vcp);
> +               if (!vocs || vocs->voaodec)
> +                       return;
> +
> +               vocs->voaodec =3D attr;
> +
> +               vcp_read_value(vcp, value_handle, read_vocs_audio_descrip=
tor, vcp);
> +               vcp->vocs_ao_dec_id =3D vcp_register_notify(vcp, value_ha=
ndle,
> +                                                   vcp_audio_descriptor_=
notify, NULL);
> +
> +       }
> +
> +}
> +
>  static void foreach_vcs_service(struct gatt_db_attribute *attr,
>                                                 void *user_data)
>  {
> @@ -1141,6 +1658,19 @@ static void foreach_vcs_service(struct gatt_db_att=
ribute *attr,
>         gatt_db_service_foreach_char(attr, foreach_vcs_char, vcp);
>  }
>
> +static void foreach_vocs_service(struct gatt_db_attribute *attr,
> +                                               void *user_data)
> +{
> +       struct bt_vcp *vcp =3D user_data;
> +       struct bt_vocs *vocs =3D vcp_get_vocs(vcp);
> +
> +       vocs->service =3D attr;
> +
> +       gatt_db_service_set_claimed(attr, true);
> +
> +       gatt_db_service_foreach_char(attr, foreach_vocs_char, vcp);
> +}
> +
>  bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
>  {
>         bt_uuid_t uuid;
> @@ -1163,6 +1693,9 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_ga=
tt_client *client)
>         bt_uuid16_create(&uuid, VCS_UUID);
>         gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vcs_service,=
 vcp);
>
> +       bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
> +       gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vocs_service=
, vcp);
> +
>         return true;
>  }
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
