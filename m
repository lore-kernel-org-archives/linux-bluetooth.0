Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2BEC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 16:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbjFHQaO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjFHQ3o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 12:29:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46991FDC
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 09:29:41 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b203360d93so8064131fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jun 2023 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686241780; x=1688833780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c515tqo+CFh0BUFv94selyttVY4awDrYbEVfofRDmWI=;
        b=XeCOOG39Ph7085Q8/IoB3XxGffehwlKTG483oSlMEF9WX1NYmu8LgFdzNuT+/xYLYG
         4lSUBymH4FN9OK3qiOte9a0/nqqisL+drNkBYEuHqZLNHlMilB+zJehpmn7HEyGumbH7
         CipV/Hi4MoPCD54NbCtzqevSmEB2FgziUHnZo5XI8c2iqTrtcIiBatQxOPSpEXK+XJJ2
         Dlo4ngY+/yKrP+hRPw5hnxj8TOQcjPseuZioLgdBrUQ/5TcbxYdTWbSYEv/GVBCaYwSB
         EcUPHUnokPHnkkfl7PP6O0LLHNAZdEBm+b6Kkg/4Fl23ESQOOPvh/IWIz8Ek+MWoHrMJ
         QcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241780; x=1688833780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c515tqo+CFh0BUFv94selyttVY4awDrYbEVfofRDmWI=;
        b=lB2yrZJzcL4QGC98CSwPPGlqOK5bs/M22YTS4BAifFwd+tRDlBV1HoLiFfDlbvWI1y
         leq7GZZzRXtCPLO72a/WdST+k9bH3OuHbII1LREsdYgHa6t5fHYi3vk60jCKXNwLNxZ4
         QUV9JM6NbVJv0AZrdXnA8tq0eKutdN6IuvVj6UFiBO+j8vShSfi0wb/lIx3fR/dI/cE2
         eScqDDPxbeBJjgJA6ynjgFpNW6waRRKLcu3F9bM8rd5nYzkZC3Gz+ZctrwCwcHfbLMtk
         JUHAcG7+QGzcl660x6gCymvFtLeTiVkUx/I33JQ569+Dv+2PjbHqozFN9jAPUCfHTKN+
         gVag==
X-Gm-Message-State: AC+VfDwWPAhgpdY7GKSztKvUzlLZbw80APi9f6gtwZSzG6jyJLk6vQE0
        Lmx/jFrcs0UHp9ztsLvXnQkor9/nSOKzNXYw7QRNMbbUg14=
X-Google-Smtp-Source: ACHHUZ4+ZylWPPtfzrDQtBOV1dOEJ86+Ezu9Csu+t6HUDLx6Mfjii4v9zvxfoxzsYhxu9xJiJz+G0p9IhZMVt/l35nc=
X-Received: by 2002:a2e:3013:0:b0:2ab:19a0:667b with SMTP id
 w19-20020a2e3013000000b002ab19a0667bmr3437765ljw.0.1686241779359; Thu, 08 Jun
 2023 09:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230608120945.4478-1-nitin.jadhav@nxp.com> <20230608120945.4478-2-nitin.jadhav@nxp.com>
In-Reply-To: <20230608120945.4478-2-nitin.jadhav@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 8 Jun 2023 09:29:26 -0700
Message-ID: <CABBYNZK5=wcO0AGiQ_945K=+QCuF-67o8fdOeGQPBfAE9NGVhA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/2] Title: Added initial code for handling VOCS
To:     Nitin Jadhav <nitin.jadhav@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nitin,

On Thu, Jun 8, 2023 at 5:24=E2=80=AFAM Nitin Jadhav <nitin.jadhav@nxp.com> =
wrote:
>
> Summary:
> - This adds implementation for VOCS service and characteristics
> - Implementation based on VOCS_v1.0.pdf specification
> - Tested using PTS with reference to VOCS.TS.p1.pdf
> ---

Note, for the patch subject I usually recommend the following format:
<subdir/file>: <subject>, so in this case shared/vcp: Add initial code
for handling VOCS

> v2: Corrected prefixs and cosmetic changes (Luiz Augusto von Dentz)
> v3: Commit message modified and fixed long line length warning (Paul
> Menzel)
> ---
>  lib/uuid.h       |   5 +
>  src/shared/vcp.c | 547 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 552 insertions(+)
>
> diff --git a/lib/uuid.h b/lib/uuid.h
> index 5cdfedb4b..cd3b3655f 100644
> --- a/lib/uuid.h
> +++ b/lib/uuid.h
> @@ -179,6 +179,11 @@ extern "C" {
>  #define VOL_CP_CHRC_UUID                               0x2B7E
>  #define VOL_FLAG_CHRC_UUID                             0x2B7F
>
> +#define VOCS_STATE_CHAR_UUID                   0x2B80
> +#define VOCS_AUDIO_LOC_CHRC_UUID               0x2B81
> +#define VOCS_CP_CHRC_UUID                      0x2B82
> +#define VOCS_AUDIO_OP_DESC_CHAR_UUID           0x2B83
> +
>  #define GMCS_UUID                               0x1849
>  #define MEDIA_PLAYER_NAME_CHRC_UUID             0x2b93
>  #define MEDIA_TRACK_CHNGD_CHRC_UUID             0x2b96

Split the uuid.h changes on its own patch.

> diff --git a/src/shared/vcp.c b/src/shared/vcp.c
> index 5459cf892..aa75f498a 100644
> --- a/src/shared/vcp.c
> +++ b/src/shared/vcp.c
> @@ -36,9 +36,40 @@
>  #define BT_ATT_ERROR_INVALID_CHANGE_COUNTER    0x80
>  #define BT_ATT_ERROR_OPCODE_NOT_SUPPORTED      0x81
>
> +#define BT_VCP_NA                   0x00000000
> +#define BT_VCP_FRONT_LEFT           0x00000001
> +#define BT_VCP_FRONT_RIGHT          0x00000002
> +#define BT_VCP_FRONT_CENTER         0x00000004
> +#define BT_VCP_LOW_FRQ_EFF_1        0x00000008
> +#define BT_VCP_BACK_LEFT            0x00000010
> +#define BT_VCP_BACK_RIGHT           0x00000020
> +#define BT_VCP_FRONT_LEFT_CENTER    0x00000040
> +#define BT_VCP_FRONT_RIGHT_CENTER   0x00000080
> +#define BT_VCP_BACK_CENTER          0x00000100
> +#define BT_VCP_LOW_FRQ_EFF_2        0x00000200
> +#define BT_VCP_SIDE_LEFT            0x00000400
> +#define BT_VCP_SIDE_RIGHT           0x00000800
> +#define BT_VCP_TOP_FRONT_LEFT       0x00001000
> +#define BT_VCP_TOP_FRONT_RIGHT      0x00002000
> +#define BT_VCP_TOP_FRONT_CENTER     0x00004000
> +#define BT_VCP_TOP_CENTER           0x00008000
> +#define BT_VCP_TOP_BACK_LEFT        0x00010000
> +#define BT_VCP_TOP_BACK_RIGHT       0x00020000
> +#define BT_VCP_TOP_SIDE_LEFT        0x00040000
> +#define BT_VCP_TOP_SIDE_RIGHT       0x00080000
> +#define BT_VCP_TOP_BACK_CENTER      0x00100000
> +#define BT_VCP_BOTTOM_FRONT_CENTER  0x00200000
> +#define BT_VCP_BOTTOM_FRONT_LEFT    0x00400000
> +#define BT_VCP_BOTTOM_FRONT_RIGHT   0x00800000
> +#define BT_VCP_FRONT_LEFT_WIDE      0x01000000
> +#define BT_VCP_FRONT_RIGHT_WIDE     0x02000000
> +#define BT_VCP_LEFT_SURROUND        0x04000000
> +#define BT_VCP_RIGHT_SURROUND       0x08000000

You should probably use BIT macro to define the above values.

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
> +       unsigned int state_id;
> +       unsigned int audio_loc_id;
> +       unsigned int ao_dec_id;
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
> +       vocs->vocs_audio_loc =3D BT_VCP_FRONT_LEFT;
> +       vocs->vocs_ao_dec =3D "Left Speaker";
> +
> +       /* Populate DB with VOCS attributes */
> +       bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
> +       vocs->service =3D gatt_db_add_service(db, &uuid, true, 9);
> +
> +       bt_uuid16_create(&uuid, VOCS_STATE_CHAR_UUID);
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
> +       bt_uuid16_create(&uuid, VOCS_AUDIO_LOC_CHRC_UUID);
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
> +       bt_uuid16_create(&uuid, VOCS_CP_CHRC_UUID);
> +       vocs->vo_cp =3D gatt_db_service_add_characteristic(vocs->service,
> +                                       &uuid,
> +                                       BT_ATT_PERM_WRITE,
> +                                       BT_GATT_CHRC_PROP_WRITE,
> +                                       NULL, vocs_cp_write,
> +                                       vocs);
> +
> +       bt_uuid16_create(&uuid, VOCS_AUDIO_OP_DESC_CHAR_UUID);
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
> @@ -911,6 +1240,44 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, u=
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
> +       if (value !=3D NULL)
> +               memcpy(vocs_audio_loc_n, value, sizeof(uint32_t));
> +
> +       DBG(vcp, "VOCS Audio Location 0x%x", *vocs_audio_loc_n);
> +}
> +
> +
> +static void vcp_audio_descriptor_notify(struct bt_vcp *vcp,
> +                                       uint16_t value_handle,
> +                                       const uint8_t *value,
> +                                       uint16_t length,
> +                                       void *user_data)
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
> @@ -972,6 +1339,86 @@ static void read_vol_state(struct bt_vcp *vcp, bool=
 success, uint8_t att_ecode,
>         DBG(vcp, "Vol Counter:%x", vs->counter);
>  }
>
> +static void read_vol_offset_state(struct bt_vcp *vcp, bool success,
> +                                 uint8_t att_ecode,
> +                                 const uint8_t *value, uint16_t length,
> +                                 void *user_data)
> +{
> +       struct vol_offset_state *vos;
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *) value,
> +               .iov_len =3D length,
> +       };
> +
> +       if (!success) {
> +               DBG(vcp, "Unable to read Vol Offset State: error 0x%02x",
> +                   att_ecode);
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
> +static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
> +                                    uint8_t att_ecode,
> +                                    const uint8_t *value, uint16_t lengt=
h,
> +                                    void *user_data)
> +{
> +       uint32_t *vocs_audio_loc;
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *) value,
> +               .iov_len =3D length,
> +       };
> +
> +       if (!success) {
> +               DBG(vcp, "Unable to read VOCS Audio Location: error 0x%02=
x",
> +                   att_ecode);
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
> +static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
> +                                      uint8_t att_ecode,
> +                                      const uint8_t *value, uint16_t len=
gth,
> +                                      void *user_data)
> +{
> +       char *vocs_ao_dec_r;
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *) value,
> +               .iov_len =3D length,
> +       };
> +
> +       if (!success) {
> +               DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%=
02x",
> +                       att_ecode);
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
> @@ -1128,6 +1575,90 @@ static void foreach_vcs_char(struct gatt_db_attrib=
ute *attr, void *user_data)
>         }
>  }
>
> +static void foreach_vocs_char(struct gatt_db_attribute *attr, void *user=
_data)
> +{
> +       struct bt_vcp *vcp =3D user_data;
> +       uint16_t value_handle;
> +       bt_uuid_t uuid, uuid_vostate, uuid_audio_loc, uuid_vo_cp,
> +                       uuid_audio_op_decs;
> +       struct bt_vocs *vocs;
> +
> +       if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
> +                                               NULL, NULL, &uuid))
> +               return;
> +
> +       bt_uuid16_create(&uuid_vostate, VOCS_STATE_CHAR_UUID);
> +       bt_uuid16_create(&uuid_audio_loc, VOCS_AUDIO_LOC_CHRC_UUID);
> +       bt_uuid16_create(&uuid_vo_cp, VOCS_CP_CHRC_UUID);
> +       bt_uuid16_create(&uuid_audio_op_decs, VOCS_AUDIO_OP_DESC_CHAR_UUI=
D);
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
> +               vcp->state_id =3D vcp_register_notify(vcp, value_handle,
> +                                       vcp_voffset_state_notify, NULL);
> +
> +               return;
> +       }
> +
> +       if (!bt_uuid_cmp(&uuid, &uuid_audio_loc)) {
> +               DBG(vcp, "VOCS Volume Audio Location found: handle 0x%04x=
",
> +                       value_handle);
> +
> +               vocs =3D vcp_get_vocs(vcp);
> +               if (!vocs || vocs->voal)
> +                       return;
> +
> +               vocs->voal =3D attr;
> +
> +               vcp_read_value(vcp, value_handle, read_vocs_audio_locatio=
n,
> +                                      vcp);
> +
> +               vcp->audio_loc_id =3D vcp_register_notify(vcp, value_hand=
le,
> +                                               vcp_audio_loc_notify, NUL=
L);
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
,
> +                       value_handle);
> +
> +               vocs =3D vcp_get_vocs(vcp);
> +               if (!vocs || vocs->voaodec)
> +                       return;
> +
> +               vocs->voaodec =3D attr;
> +
> +               vcp_read_value(vcp, value_handle, read_vocs_audio_descrip=
tor,
> +                              vcp);
> +               vcp->ao_dec_id =3D vcp_register_notify(vcp, value_handle,
> +                                       vcp_audio_descriptor_notify, NULL=
);
> +
> +       }
> +
> +}
> +
>  static void foreach_vcs_service(struct gatt_db_attribute *attr,
>                                                 void *user_data)
>  {
> @@ -1141,6 +1672,19 @@ static void foreach_vcs_service(struct gatt_db_att=
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
> @@ -1163,6 +1707,9 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_ga=
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
