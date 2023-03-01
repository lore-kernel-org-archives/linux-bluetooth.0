Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ED6C678D4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 22:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCAWaG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 17:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCAWaF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 17:30:05 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B4367D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 14:29:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i28so6959390lfv.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Mar 2023 14:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0e49kqVy2PWjeRop9ClvU353ZBdpBlL0z1vflYUaR8=;
        b=YWUfu8i+QuFfUf/H+fx/eNtdSH4R6R275ARp6DpuYQFMW+JZLrFajJtpX+MEgIY9G4
         /fVM7hRpwkgmpcdld8OYoNVuOLerYCwjLgokVGMWJhFOEbstuzOwfuiwhF2Az4oqVn92
         2RGiKdhPEbs9QJawrjqVxe5Am/szP4Gea8eu6B/sAbHmHgthLg9JY20k3VIzxFjdoimn
         iY4SJvwcO919OeOiWaMq9qAg1vCwNXfn39HxyFWtmjBdOziMdd618K0IW2jiopIqwbch
         GZwxpST7iSCkHzR1GUxqVKCUFMA10dGFibrfelZiqxAlHqIWZ4UwlqKd40ad34n2T4wW
         AkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0e49kqVy2PWjeRop9ClvU353ZBdpBlL0z1vflYUaR8=;
        b=w60PB8wf82dPMOHGU7tR1KzVgF11MNc+2IR2XM7U0X2MoZcIujdMHSM2DrtBDv/Oq0
         PiXuT82/C+7tZMjNBnxdMdbuh0453hCMZi9qSPSVK43fLl2txxTHJAOo1/T0R0q+6L/h
         LP/4z1LsK/KP8uIivVZngAzyrAFtpBXbtIBTH73bn2kUfD+uJQTgR8RKgEZY3OJzyNr0
         gwnaUhMFavXHG5hdglh6esHeBf8RFqF1zVIRllXRd+yp5lGAsQ0puFFGghPa5HoiKVdH
         tTXuHbQGI151QpN7DbWOgFcB4vLpSR1LSeWQ1UJ5v8p4+Aa+f9y+t6Gj0578n9Wv1qWp
         PTlw==
X-Gm-Message-State: AO0yUKW5Rc8mA4Xqqcd8fQc8BMsarBATBYNsU0ZofDj2R/Xv6MR0iE1k
        82lgrgjmwJq7bx0OqX0oum40etPp1AQbT7tX7cGFNGuXtNs=
X-Google-Smtp-Source: AK7set96ladsXdv5Actjoy97qfgJe0KIfOOj+U7KNVAv5trZGOJc1QU9W51XOHZMIEVGUuusTAoveeeRWffIiIEgS2w=
X-Received: by 2002:a19:750c:0:b0:4dd:a058:f088 with SMTP id
 y12-20020a19750c000000b004dda058f088mr2332811lfe.8.1677709797361; Wed, 01 Mar
 2023 14:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20230301153322.12555-1-iulia.tanasescu@nxp.com> <20230301153322.12555-3-iulia.tanasescu@nxp.com>
In-Reply-To: <20230301153322.12555-3-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Mar 2023 14:29:45 -0800
Message-ID: <CABBYNZLOe+MECyHsZOrH23E_1Q6cCZNXKHm3de4u6ErdGg5OyA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] shared: Add initial BASS code
To:     iulia-tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Wed, Mar 1, 2023 at 7:40=E2=80=AFAM iulia-tanasescu <iulia.tanasescu@nxp=
.com> wrote:
>
> Added initial BASS code - added support for the Broadcast
> Receive State characteristic and for the Set Broadcast_Code
> operation from the Broadcast Audio Scan Control Point
> characteristic.
> The BASS implementation exposes HCI event callbacks that
> enable the BASS server to autonomously synchronize
> to BIGs.
>
> ---
>  src/shared/att-types.h |    1 +
>  src/shared/bap.c       | 1065 ++++++++++++++++++++++++++++++++++++++++
>  src/shared/bap.h       |   25 +
>  src/shared/bass.h      |   43 ++

Let's have it implemented in bass.c with a dedicated instance e.g.
bt_bass that bap.c can instantiate, that makes it easier to create
dedicated tests for bass, etc.

>  4 files changed, 1134 insertions(+)
>  create mode 100644 src/shared/bass.h
>
> diff --git a/src/shared/att-types.h b/src/shared/att-types.h
> index a08b24155..35bf41118 100644
> --- a/src/shared/att-types.h
> +++ b/src/shared/att-types.h
> @@ -104,6 +104,7 @@ struct bt_att_pdu_error_rsp {
>   * 0xE0-0xFC are reserved for future use. The remaining 3 are defined as=
 the
>   * following:
>   */
> +#define BT_ERROR_WRITE_REQUEST_REJECTED         0xfc
>  #define BT_ERROR_CCC_IMPROPERLY_CONFIGURED      0xfd
>  #define BT_ERROR_ALREADY_IN_PROGRESS            0xfe
>  #define BT_ERROR_OUT_OF_RANGE                   0xff
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index db7def799..86374967f 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -17,6 +17,8 @@
>
>  #include "lib/bluetooth.h"
>  #include "lib/uuid.h"
> +#include "lib/hci.h"
> +#include "lib/hci_lib.h"
>
>  #include "src/shared/io.h"
>  #include "src/shared/queue.h"
> @@ -28,6 +30,8 @@
>  #include "src/shared/gatt-client.h"
>  #include "src/shared/bap.h"
>  #include "src/shared/ascs.h"
> +#include "src/shared/bass.h"
> +#include "src/shared/ad.h"
>
>  /* Maximum number of ASE(s) */
>  #define NUM_SINKS 2
> @@ -108,13 +112,55 @@ struct bt_ascs {
>         struct gatt_db_attribute *ase_cp_ccc;
>  };
>
> +/*
> + * BASS subgroup field of the Broadcast
> + * Receive State characteristic
> + */
> +struct bt_bass_subgroup_data {
> +       uint32_t bis_sync;
> +       uint8_t meta_len;
> +       uint8_t *meta;
> +} __packed;
> +
> +/* BASS Broadcast Source structure */
> +struct bt_bcst_source {
> +       struct gatt_db_attribute *attr;
> +       uint8_t id;
> +       uint8_t addr_type;
> +       uint8_t addr[6];
> +       uint8_t sid;
> +       uint8_t bid[BT_BAP_BROADCAST_ID_SIZE];
> +       uint8_t sync_state;
> +       uint8_t encryption;
> +       uint8_t bad_code[BT_BAP_BROADCAST_CODE_SIZE];
> +       uint8_t num_subgroups;
> +       struct bt_bass_subgroup_data *subgroup_data;
> +} __packed;
> +
> +/* Broadcast Receive State characteristic structure */
> +struct bt_bcst_recv_state {
> +       struct bt_bass *bass;
> +       struct gatt_db_attribute *attr;
> +       struct gatt_db_attribute *ccc;
> +};
> +
> +/* BASS instance structure */
> +struct bt_bass {
> +       struct bt_bap_db *bdb;
> +       struct gatt_db_attribute *service;
> +       struct gatt_db_attribute *broadcast_audio_scan_cp;
> +       struct bt_bcst_recv_state *bcst_recv_states[NUM_BCST_RECV_STATES]=
;
> +};
> +
>  struct bt_bap_db {
>         struct gatt_db *db;
>         struct bt_pacs *pacs;
>         struct bt_ascs *ascs;
> +       struct bt_bass *bass;
>         struct queue *sinks;
>         struct queue *sources;
>         struct queue *endpoints;
> +       struct queue *bass_bcst_sources;
>  };
>
>  struct bt_bap_req {
> @@ -255,6 +301,15 @@ static struct queue *bap_db;
>  static struct queue *bap_cbs;
>  static struct queue *sessions;
>
> +static int hci_fd =3D -1;
> +
> +static struct bt_hci_cmd_le_big_create_sync *big_sync_cmd;
> +static int big_sync_cmd_len;
> +
> +static struct bt_hci_le_pa_report *pa_report;
> +
> +static uint8_t next_available_source_id;
> +
>  static bool bap_db_match(const void *data, const void *match_data)
>  {
>         const struct bt_bap_db *bdb =3D data;
> @@ -2170,6 +2225,643 @@ static struct bt_ascs *ascs_new(struct gatt_db *d=
b)
>         return ascs;
>  }
>
> +static int bass_build_bcst_source_from_notif(struct bt_bcst_source *bcst=
_source,
> +                                                       const uint8_t *va=
lue)
> +{
> +       struct bt_bass_subgroup_data *subgroup_data;
> +
> +       if (!bcst_source || !value)
> +               return -1;
> +
> +       bcst_source->id =3D *value;
> +       value++;
> +
> +       bcst_source->addr_type =3D *value;
> +       value++;
> +
> +       memcpy(bcst_source->addr, value, 6);
> +       value +=3D 6;
> +
> +       bcst_source->sid =3D *value;
> +       value++;
> +
> +       memcpy(bcst_source->bid, value, BT_BAP_BROADCAST_ID_SIZE);
> +       value +=3D BT_BAP_BROADCAST_ID_SIZE;
> +
> +       bcst_source->sync_state =3D *value;
> +       value++;
> +
> +       bcst_source->encryption =3D *value;
> +       value++;
> +
> +       if (bcst_source->encryption =3D=3D BT_BASS_BIG_ENC_STATE_BAD_CODE=
) {
> +               memcpy(bcst_source->bad_code, value, BT_BAP_BROADCAST_COD=
E_SIZE);
> +               value +=3D BT_BAP_BROADCAST_CODE_SIZE;
> +       } else {
> +               memset(bcst_source->bad_code, 0, BT_BAP_BROADCAST_CODE_SI=
ZE);
> +       }
> +
> +       bcst_source->num_subgroups =3D *value;
> +       value++;
> +
> +       free(bcst_source->subgroup_data);
> +       bcst_source->subgroup_data =3D malloc(bcst_source->num_subgroups =
*
> +                                       sizeof(struct bt_bass_subgroup_da=
ta));
> +
> +       if (!bcst_source->subgroup_data)
> +               return -1;
> +
> +       for (int i =3D 0; i < bcst_source->num_subgroups; i++) {
> +               subgroup_data =3D &bcst_source->subgroup_data[i];
> +
> +               memcpy(&subgroup_data->bis_sync, value, sizeof(uint32_t))=
;
> +               value +=3D sizeof(uint32_t);
> +
> +               subgroup_data->meta_len =3D *value;
> +               value++;
> +
> +               free(subgroup_data->meta);
> +               subgroup_data->meta =3D malloc(subgroup_data->meta_len);
> +               if (!subgroup_data->meta) {
> +                       for (int j =3D 0; j < i; j++)
> +                               free(bcst_source->subgroup_data[j].meta);
> +
> +                       free(bcst_source->subgroup_data);
> +                       return -1;
> +               }
> +
> +               memcpy(subgroup_data->meta, value, subgroup_data->meta_le=
n);
> +               value +=3D subgroup_data->meta_len;
> +       }
> +
> +       return 0;
> +}
> +
> +static int bass_build_bcst_source_from_read_rsp(
> +                                       struct bt_bcst_source *bcst_sourc=
e,
> +                                       const uint8_t *value)
> +{
> +       return bass_build_bcst_source_from_notif(bcst_source, value);
> +}
> +
> +static uint8_t *bass_build_notif_from_bcst_source(struct bt_bcst_source =
*source,
> +                                                       size_t *notif_len=
)
> +{
> +       size_t len =3D 0;
> +       uint8_t *notif =3D NULL;
> +       uint8_t *ptr;
> +
> +       *notif_len =3D 0;
> +
> +       if (!source)
> +               return NULL;
> +
> +       len =3D 15 + source->num_subgroups * 5;
> +
> +       if (source->encryption =3D=3D BT_BASS_BIG_ENC_STATE_BAD_CODE)
> +               len +=3D BT_BAP_BROADCAST_CODE_SIZE;
> +
> +       for (size_t i =3D 0; i < source->num_subgroups; i++) {
> +               /* add length for subgroup metadata */
> +               len +=3D source->subgroup_data[i].meta_len;
> +       }
> +
> +       notif =3D malloc(len);
> +       if (!notif)
> +               return NULL;
> +
> +       memset(notif, 0, len);
> +       ptr =3D notif;
> +
> +       /* add source_id field */
> +       *ptr =3D source->id;
> +       ptr++;
> +
> +       /* add addr_type field */
> +       *ptr =3D source->addr_type;
> +       ptr++;
> +
> +       /* add addr field */
> +       memcpy(ptr, source->addr, 6);
> +       ptr +=3D 6;
> +
> +       /* add sid field */
> +       *ptr =3D source->sid;
> +       ptr++;
> +
> +       /* add bid field */
> +       memcpy(ptr, source->bid, BT_BAP_BROADCAST_ID_SIZE);
> +       ptr +=3D 3;
> +
> +       /* add sync_state field */
> +       *ptr =3D source->sync_state;
> +       ptr++;
> +
> +       /* add encryption field */
> +       *ptr =3D source->encryption;
> +       ptr++;
> +
> +       if (source->encryption =3D=3D BT_BASS_BIG_ENC_STATE_BAD_CODE) {
> +               memcpy(ptr, source->bad_code, BT_BAP_BROADCAST_CODE_SIZE)=
;
> +               ptr +=3D BT_BAP_BROADCAST_CODE_SIZE;
> +       }
> +
> +       /* add num_subgroups field */
> +       *ptr =3D source->num_subgroups;
> +       ptr++;
> +
> +       for (size_t i =3D 0; i < source->num_subgroups; i++) {
> +               /* add subgroup bis_sync */
> +               memcpy(ptr, &source->subgroup_data[i].bis_sync,
> +                                               sizeof(uint32_t));
> +               ptr +=3D sizeof(uint32_t);
> +
> +               /* add subgroup meta_len */
> +               *ptr =3D source->subgroup_data[i].meta_len;
> +               ptr++;
> +
> +               /* add subgroup metadata */
> +               if (source->subgroup_data[i].meta_len > 0) {
> +                       memcpy(ptr, source->subgroup_data[i].meta,
> +                                       source->subgroup_data[i].meta_len=
);
> +                       ptr +=3D source->subgroup_data[i].meta_len;
> +               }
> +       }
> +
> +       *notif_len =3D len;
> +       return notif;
> +}
> +
> +static uint8_t *bass_build_read_rsp_from_bcst_source(struct bt_bcst_sour=
ce *source,
> +                                                               size_t *r=
sp_len)
> +{
> +       return bass_build_notif_from_bcst_source(source, rsp_len);
> +}
> +
> +static bool bass_src_id_match(const void *data, const void *match_data)
> +{
> +       const struct bt_bcst_source *src =3D data;
> +       const uint8_t *id =3D match_data;
> +
> +       return (src->id =3D=3D *id);
> +}
> +
> +static void bass_fill_create_big_sync_cmd_from_pa_report(
> +                               struct bt_hci_cmd_le_big_create_sync *cmd=
)
> +{
> +       struct iovec iov;
> +       struct bt_ad_structure *ad_structure;
> +       uint16_t uuid;
> +       struct bt_hci_le_pa_base_data *base_data;
> +       uint8_t *bis_index =3D (uint8_t *)cmd->bis;
> +
> +       if (!pa_report)
> +               return;
> +
> +       iov.iov_base =3D pa_report->data;
> +       iov.iov_len =3D pa_report->data_len;
> +
> +       ad_structure =3D util_iov_pull_mem(&iov, sizeof(*ad_structure));
> +       if (ad_structure->ad_type !=3D BT_AD_SERVICE_DATA16)
> +               return;
> +
> +       uuid =3D bt_get_le16(util_iov_pull_mem(&iov, sizeof(uint16_t)));
> +       if (uuid !=3D BASIC_AUDIO_ANNOUNCEMENT_SERVICE_UUID)
> +               return;
> +
> +       base_data =3D util_iov_pull_mem(&iov, sizeof(*base_data));
> +
> +       for (int i =3D 0; i < base_data->num_subgroups; i++) {
> +               struct bt_hci_le_pa_base_subgroup *subgroup;
> +               struct bt_hci_lv_data *codec_cfg;
> +               struct bt_hci_lv_data *metadata;
> +
> +               subgroup =3D util_iov_pull_mem(&iov, sizeof(*subgroup));
> +
> +               codec_cfg =3D util_iov_pull_mem(&iov, sizeof(*codec_cfg))=
;
> +               util_iov_pull_mem(&iov, codec_cfg->len);
> +
> +               metadata =3D util_iov_pull_mem(&iov, sizeof(*metadata));
> +               util_iov_pull_mem(&iov, metadata->len);
> +
> +               for (int j =3D 0; j < subgroup->num_bis; j++) {
> +                       struct bt_hci_le_pa_base_bis *bis;
> +                       struct bt_hci_lv_data *codec_cfg;
> +
> +                       bis =3D util_iov_pull_mem(&iov, sizeof(*bis));
> +                       *bis_index =3D bis->index;
> +                       bis_index++;
> +
> +                       codec_cfg =3D util_iov_pull_mem(&iov,
> +                                               sizeof(*codec_cfg));
> +                       util_iov_pull_mem(&iov, codec_cfg->len);
> +               }
> +       }
> +}
> +
> +static void bass_fill_bcst_source_from_pa_report(
> +                               struct bt_bcst_source *bcst_source)
> +{
> +       struct iovec iov;
> +       struct bt_ad_structure *ad_structure;
> +       uint16_t uuid;
> +       struct bt_hci_le_pa_base_data *base_data;
> +
> +       if (!pa_report)
> +               return;
> +
> +       iov.iov_base =3D pa_report->data;
> +       iov.iov_len =3D pa_report->data_len;
> +
> +       ad_structure =3D util_iov_pull_mem(&iov, sizeof(*ad_structure));
> +       if (ad_structure->ad_type !=3D BT_AD_SERVICE_DATA16)
> +               return;
> +
> +       uuid =3D bt_get_le16(util_iov_pull_mem(&iov, sizeof(uint16_t)));
> +       if (uuid !=3D BASIC_AUDIO_ANNOUNCEMENT_SERVICE_UUID)
> +               return;
> +
> +       base_data =3D util_iov_pull_mem(&iov, sizeof(*base_data));
> +
> +       if (bcst_source->sync_state =3D=3D BT_BASS_NOT_SYNCHRONIZED_TO_PA=
) {
> +               bcst_source->sync_state =3D BT_BASS_SYNCHRONIZED_TO_PA;
> +               bcst_source->num_subgroups =3D base_data->num_subgroups;
> +
> +               bcst_source->subgroup_data =3D malloc(base_data->num_subg=
roups *
> +                                               sizeof(struct bt_bcst_sou=
rce));
> +               if (!bcst_source->subgroup_data)
> +                       return;
> +
> +               memset(bcst_source->subgroup_data, 0, base_data->num_subg=
roups *
> +                                               sizeof(struct bt_bcst_sou=
rce));
> +       }
> +
> +       if (bcst_source->num_subgroups !=3D base_data->num_subgroups)
> +               return;
> +
> +       for (int i =3D 0; i < base_data->num_subgroups; i++) {
> +               struct bt_hci_le_pa_base_subgroup *subgroup;
> +               struct bt_hci_lv_data *codec_cfg;
> +               struct bt_hci_lv_data *metadata;
> +
> +               subgroup =3D util_iov_pull_mem(&iov, sizeof(*subgroup));
> +               codec_cfg =3D util_iov_pull_mem(&iov, sizeof(*codec_cfg))=
;
> +               util_iov_pull_mem(&iov, codec_cfg->len);
> +
> +               metadata =3D util_iov_pull_mem(&iov, sizeof(*metadata));
> +               util_iov_pull_mem(&iov, metadata->len);
> +
> +               bcst_source->subgroup_data[i].meta_len =3D metadata->len;
> +               free(bcst_source->subgroup_data[i].meta);
> +
> +               bcst_source->subgroup_data[i].meta =3D malloc(metadata->l=
en);
> +               if (!bcst_source->subgroup_data[i].meta)
> +                       return;
> +
> +               memcpy(bcst_source->subgroup_data[i].meta,
> +                                       metadata->data, metadata->len);
> +
> +               for (int j =3D 0; j < subgroup->num_bis; j++) {
> +                       struct bt_hci_le_pa_base_bis *bis;
> +                       struct bt_hci_lv_data *codec_cfg;
> +
> +                       bis =3D util_iov_pull_mem(&iov, sizeof(*bis));
> +                       codec_cfg =3D util_iov_pull_mem(&iov, sizeof(*cod=
ec_cfg));
> +                       util_iov_pull_mem(&iov, codec_cfg->len);
> +               }
> +       }
> +}
> +
> +static void bass_fill_bcst_source_bis_sync_bitmask(
> +                                       struct bt_bcst_source *bcst_sourc=
e)
> +{
> +       struct iovec iov;
> +       struct bt_ad_structure *ad_structure;
> +       uint16_t uuid;
> +       struct bt_hci_le_pa_base_data *base_data;
> +
> +       if (!pa_report)
> +               return;
> +
> +       iov.iov_base =3D pa_report->data;
> +       iov.iov_len =3D pa_report->data_len;
> +
> +       ad_structure =3D util_iov_pull_mem(&iov, sizeof(*ad_structure));
> +       if (ad_structure->ad_type !=3D BT_AD_SERVICE_DATA16)
> +               return;
> +
> +       uuid =3D bt_get_le16(util_iov_pull_mem(&iov, sizeof(uint16_t)));
> +       if (uuid !=3D BASIC_AUDIO_ANNOUNCEMENT_SERVICE_UUID)
> +               return;
> +
> +       base_data =3D util_iov_pull_mem(&iov, sizeof(*base_data));
> +
> +       for (int i =3D 0; i < base_data->num_subgroups; i++) {
> +               struct bt_hci_le_pa_base_subgroup *subgroup;
> +               struct bt_hci_lv_data *codec_cfg;
> +               struct bt_hci_lv_data *metadata;
> +
> +               subgroup =3D util_iov_pull_mem(&iov, sizeof(*subgroup));
> +
> +               codec_cfg =3D util_iov_pull_mem(&iov, sizeof(*codec_cfg))=
;
> +               util_iov_pull_mem(&iov, codec_cfg->len);
> +
> +               metadata =3D util_iov_pull_mem(&iov, sizeof(*metadata));
> +               util_iov_pull_mem(&iov, metadata->len);
> +
> +               for (int j =3D 0; j < subgroup->num_bis; j++) {
> +                       struct bt_hci_le_pa_base_bis *bis;
> +                       struct bt_hci_lv_data *codec_cfg;
> +
> +                       bis =3D util_iov_pull_mem(&iov, sizeof(*bis));
> +                       bcst_source->subgroup_data[i].bis_sync |=3D
> +                                               (1 << (bis->index - 1));
> +
> +                       codec_cfg =3D util_iov_pull_mem(&iov,
> +                                               sizeof(*codec_cfg));
> +                       util_iov_pull_mem(&iov, codec_cfg->len);
> +               }
> +       }
> +}
> +
> +static void bass_handle_set_broadcast_code_opcode(struct bt_bass *bass,
> +                                               struct gatt_db_attribute =
*attrib,
> +                                               uint8_t opcode,
> +                                               unsigned int id,
> +                                               struct iovec *iov,
> +                                               struct bt_att *att)
> +{
> +       struct bt_bap *bap =3D bap_get_session(att, bass->bdb->db);
> +       struct bt_bass_set_bcst_code_params *params;
> +       struct bt_bcst_source *bcst_source;
> +       uint8_t *notify_data;
> +       size_t notify_data_len;
> +       struct hci_request rq;
> +
> +       struct bt_hci_evt_le_big_sync_estabilished *big_sync_established_=
evt =3D NULL;
> +       int big_sync_established_evt_len =3D 0;
> +
> +       if (!big_sync_cmd)
> +               goto done;
> +
> +       big_sync_established_evt_len =3D
> +                       sizeof(struct bt_hci_evt_le_big_sync_estabilished=
) +
> +                       big_sync_cmd->num_bis * sizeof(uint16_t);
> +
> +       big_sync_established_evt =3D malloc(big_sync_established_evt_len)=
;
> +       if (big_sync_established_evt =3D=3D NULL)
> +               goto done;
> +
> +       /* validate Set Broadcast_Code command length */
> +       if (iov->iov_len < sizeof(struct bt_bass_set_bcst_code_params)) {
> +               if (opcode =3D=3D BT_ATT_OP_WRITE_REQ)
> +                       gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ERROR_WRITE_REQUEST_REJECTED);
> +
> +               goto done;
> +       }
> +
> +       /* get Set Broadcast_Code command parameters */
> +       params =3D util_iov_pull_mem(iov, sizeof(*params));
> +
> +       bcst_source =3D queue_find(bap->ldb->bass_bcst_sources,
> +                                               bass_src_id_match,
> +                                               &params->source_id);
> +
> +       if (bcst_source =3D=3D NULL) {
> +               /* no source matches the written source_id */
> +               if (opcode =3D=3D BT_ATT_OP_WRITE_REQ)
> +                       gatt_db_attribute_write_result(attrib, id,
> +                                       BT_BASS_ERROR_INVALID_SOURCE_ID);
> +
> +               goto done;
> +       }
> +
> +       memcpy(big_sync_cmd->bcode, params->bcst_code,
> +                       BT_BAP_BROADCAST_CODE_SIZE);
> +
> +       rq.ogf          =3D OGF_LE_CTL;
> +       rq.ocf          =3D OCF_LE_BIG_CREATE_SYNC;
> +       rq.event        =3D BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED;
> +       rq.cparam       =3D big_sync_cmd;
> +       rq.clen         =3D big_sync_cmd_len;
> +       rq.rparam       =3D big_sync_established_evt;
> +       rq.rlen         =3D big_sync_established_evt_len;
> +
> +       if (hci_send_req(hci_fd, &rq, 0) < 0) {
> +               DBG(bap, "Failed to send Big Sync Create command: %s",
> +                                               strerror(errno));
> +               goto done;
> +       }

Code for submitting BIG Create Sync already exists in the kernel:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/net/bluetooth/hci_conn.c#n2117

Instead what we should probably do is to listen using an ISO socket
with broadcast address but instead of accepting it we just inform what
peers we have found over the air.

> +       if (big_sync_established_evt->status =3D=3D 0x00) {
> +               bcst_source->encryption =3D BT_BASS_BIG_ENC_STATE_DEC;
> +
> +               bass_fill_bcst_source_bis_sync_bitmask(bcst_source);
> +       } else {
> +               bcst_source->encryption =3D BT_BASS_BIG_ENC_STATE_BAD_COD=
E;
> +               memcpy(bcst_source->bad_code, params->bcst_code,
> +                                       BT_BAP_BROADCAST_CODE_SIZE);
> +       }
> +
> +       notify_data =3D bass_build_notif_from_bcst_source(bcst_source,
> +                                                       &notify_data_len)=
;
> +
> +       gatt_db_attribute_notify(bcst_source->attr,
> +                                       (void *)notify_data,
> +                                       notify_data_len, att);
> +
> +       free(notify_data);
> +
> +done:
> +
> +       free(big_sync_cmd);
> +       big_sync_cmd =3D NULL;
> +       free(big_sync_established_evt);
> +       free(pa_report);
> +       pa_report =3D NULL;
> +       big_sync_cmd_len =3D 0;
> +}
> +
> +#define BASS_OP(_str, _op, _size, _func) \
> +       { \
> +               .str =3D _str, \
> +               .op =3D _op, \
> +               .size =3D _size, \
> +               .func =3D _func, \
> +       }
> +
> +struct bass_op_handler {
> +       const char      *str;
> +       uint8_t         op;
> +       size_t          size;
> +       void            (*func)(struct bt_bass *bass,
> +                                               struct gatt_db_attribute =
*attrib,
> +                                               uint8_t opcode,
> +                                               unsigned int id,
> +                                               struct iovec *iov,
> +                                               struct bt_att *att);
> +} bass_handlers[] =3D {
> +       BASS_OP("Set Broadcast_Code", BT_BASS_SET_BCST_CODE,
> +               sizeof(struct bt_bass_set_bcst_code_params),
> +               bass_handle_set_broadcast_code_opcode)
> +};
> +
> +static void bass_broadcast_audio_scan_cp_write(struct gatt_db_attribute =
*attrib,
> +                               unsigned int id, uint16_t offset,
> +                               const uint8_t *value, size_t len,
> +                               uint8_t opcode, struct bt_att *att,
> +                               void *user_data)
> +{
> +       struct bt_bass *bass =3D user_data;
> +       struct bt_bass_bcst_audio_scan_cp_hdr *hdr;
> +       struct bass_op_handler *handler;
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *)value,
> +               .iov_len =3D len,
> +       };
> +
> +       /* validate written command length */
> +       if (len < (sizeof(*hdr))) {
> +               if (opcode =3D=3D BT_ATT_OP_WRITE_REQ) {
> +                       gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ERROR_WRITE_REQUEST_REJECTED);
> +               }
> +               return;
> +       }
> +
> +       /* get command header */
> +       hdr =3D util_iov_pull_mem(&iov, sizeof(*hdr));
> +
> +       if (hdr->op !=3D BT_BASS_SET_BCST_CODE) {
> +               if (opcode =3D=3D BT_ATT_OP_WRITE_REQ) {
> +                       gatt_db_attribute_write_result(attrib, id,
> +                                       BT_BASS_ERROR_OPCODE_NOT_SUPPORTE=
D);
> +               }
> +
> +               return;
> +       }
> +
> +       /* call the appropriate opcode handler */
> +       for (handler =3D bass_handlers; handler && handler->str; handler+=
+) {
> +               if (handler->op =3D=3D hdr->op) {
> +                       handler->func(bass, attrib, opcode, id, &iov, att=
);
> +                       break;
> +               }
> +       }
> +
> +       gatt_db_attribute_write_result(attrib, id, 0x00);
> +}
> +
> +static bool bass_source_match_attrib(const void *data, const void *match=
_data)
> +{
> +       const struct bt_bcst_source *src =3D data;
> +       const struct gatt_db_attribute *attr =3D match_data;
> +
> +       return (src->attr =3D=3D attr);
> +}
> +
> +static bool bass_source_match_sid(const void *data, const void *match_da=
ta)
> +{
> +       const struct bt_bcst_source *src =3D data;
> +       const uint8_t sid =3D *(const uint8_t *)match_data;
> +
> +       return (src->sid =3D=3D sid);
> +}
> +
> +static void bass_bcst_receive_state_read(struct gatt_db_attribute *attri=
b,
> +                                                       unsigned int id, =
uint16_t offset,
> +                                                       uint8_t opcode, s=
truct bt_att *att,
> +                                                       void *user_data)
> +{
> +       struct bt_bass *bass =3D user_data;
> +       struct bt_bap *bap =3D bap_get_session(att, bass->bdb->db);
> +       uint8_t *rsp;
> +       size_t rsp_len;
> +       struct bt_bcst_source *bcst_source;
> +
> +       bcst_source =3D queue_find(bap->ldb->bass_bcst_sources,
> +                                                       bass_source_match=
_attrib,
> +                                                       attrib);
> +
> +       if (!bcst_source) {
> +               gatt_db_attribute_read_result(attrib, id, 0, NULL,
> +                                                       0);
> +               return;
> +       }
> +
> +       /* build read response */
> +       rsp =3D bass_build_read_rsp_from_bcst_source(bcst_source, &rsp_le=
n);
> +
> +       if (!rsp) {
> +               gatt_db_attribute_read_result(attrib, id, BT_ATT_ERROR_UN=
LIKELY,
> +                                                               NULL, 0);
> +               return;
> +       }
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, (void *)rsp,
> +                                               rsp_len);
> +
> +       free(rsp);
> +}
> +
> +static void bcst_recv_new(struct bt_bass *bass, int i)
> +{
> +       struct bt_bcst_recv_state *bcst_recv_state;
> +       bt_uuid_t uuid;
> +
> +       if (!bass)
> +               return;
> +
> +       bcst_recv_state =3D new0(struct bt_bcst_recv_state, 1);
> +       bcst_recv_state->bass =3D bass;
> +
> +       bt_uuid16_create(&uuid, BCST_RECV_STATE_UUID);
> +       bcst_recv_state->attr =3D gatt_db_service_add_characteristic(bass=
->service, &uuid,
> +                                       BT_ATT_PERM_READ,
> +                                       BT_GATT_CHRC_PROP_READ |
> +                                       BT_GATT_CHRC_PROP_NOTIFY,
> +                                       bass_bcst_receive_state_read, NUL=
L,
> +                                       bass);
> +
> +       bcst_recv_state->ccc =3D gatt_db_service_add_ccc(bass->service,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE);
> +
> +       bass->bcst_recv_states[i] =3D bcst_recv_state;
> +}
> +
> +static struct bt_bass *bass_new(struct gatt_db *db)
> +{
> +       struct bt_bass *bass;
> +       bt_uuid_t uuid;
> +       int i;
> +
> +       if (!db)
> +               return NULL;
> +
> +       bass =3D new0(struct bt_bass, 1);
> +
> +       /* Populate DB with BASS attributes */
> +       bt_uuid16_create(&uuid, BASS_UUID);
> +       bass->service =3D gatt_db_add_service(db, &uuid, true,
> +                                               3 + (NUM_BCST_RECV_STATES=
 * 3));
> +
> +       for (i =3D 0; i < NUM_BCST_RECV_STATES; i++)
> +               bcst_recv_new(bass, i);
> +
> +       bt_uuid16_create(&uuid, BCST_AUDIO_SCAN_CP_UUID);
> +       bass->broadcast_audio_scan_cp =3D gatt_db_service_add_characteris=
tic(bass->service,
> +                                                       &uuid,
> +                                                       BT_ATT_PERM_WRITE=
,
> +                                                       BT_GATT_CHRC_PROP=
_WRITE,
> +                                                       NULL, bass_broadc=
ast_audio_scan_cp_write,
> +                                                       bass);
> +
> +       gatt_db_service_set_active(bass->service, true);
> +
> +       return bass;
> +}
> +
>  static struct bt_bap_db *bap_db_new(struct gatt_db *db)
>  {
>         struct bt_bap_db *bdb;
> @@ -2182,6 +2874,7 @@ static struct bt_bap_db *bap_db_new(struct gatt_db =
*db)
>         bdb->sinks =3D queue_new();
>         bdb->sources =3D queue_new();
>         bdb->endpoints =3D queue_new();
> +       bdb->bass_bcst_sources =3D queue_new();
>
>         if (!bap_db)
>                 bap_db =3D queue_new();
> @@ -2192,6 +2885,9 @@ static struct bt_bap_db *bap_db_new(struct gatt_db =
*db)
>         bdb->ascs =3D ascs_new(db);
>         bdb->ascs->bdb =3D bdb;
>
> +       bdb->bass =3D bass_new(db);
> +       bdb->bass->bdb =3D bdb;
> +
>         queue_push_tail(bap_db, bdb);
>
>         return bdb;
> @@ -2236,6 +2932,20 @@ static struct bt_ascs *bap_get_ascs(struct bt_bap =
*bap)
>         return bap->rdb->ascs;
>  }
>
> +static struct bt_bass *bap_get_bass(struct bt_bap *bap)
> +{
> +       if (!bap)
> +               return NULL;
> +
> +       if (bap->rdb->bass)
> +               return bap->rdb->bass;
> +
> +       bap->rdb->bass =3D new0(struct bt_bass, 1);
> +       bap->rdb->bass->bdb =3D bap->rdb;
> +
> +       return bap->rdb->bass;
> +}
> +
>  static bool match_codec(const void *data, const void *user_data)
>  {
>         const struct bt_bap_pac *pac =3D data;
> @@ -2321,6 +3031,17 @@ static void bap_pac_free(void *data)
>         free(pac);
>  }
>
> +static void bass_bcst_source_free(void *data)
> +{
> +       struct bt_bcst_source *bcst_source =3D data;
> +
> +       for (int i =3D 0; i < bcst_source->num_subgroups; i++)
> +               free(bcst_source->subgroup_data[i].meta);
> +
> +       free(bcst_source->subgroup_data);
> +       free(bcst_source);
> +}
> +
>  static void bap_add_sink(struct bt_bap_pac *pac)
>  {
>         struct iovec iov;
> @@ -2512,10 +3233,12 @@ static void bap_db_free(void *data)
>         queue_destroy(bdb->sinks, bap_pac_free);
>         queue_destroy(bdb->sources, bap_pac_free);
>         queue_destroy(bdb->endpoints, free);
> +       queue_destroy(bdb->bass_bcst_sources, bass_bcst_source_free);
>         gatt_db_unref(bdb->db);
>
>         free(bdb->pacs);
>         free(bdb->ascs);
> +       free(bdb->bass);
>         free(bdb);
>  }
>
> @@ -2663,6 +3386,7 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, stru=
ct gatt_db *rdb)
>         bdb->sinks =3D queue_new();
>         bdb->sources =3D queue_new();
>         bdb->endpoints =3D queue_new();
> +       bdb->bass_bcst_sources =3D queue_new();
>
>         bap->rdb =3D bdb;
>
> @@ -3670,6 +4394,119 @@ static void foreach_ascs_char(struct gatt_db_attr=
ibute *attr, void *user_data)
>         }
>  }
>
> +static void read_broadcast_receive_state(struct bt_bap *bap, bool succes=
s, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct gatt_db_attribute *attr =3D user_data;
> +       struct bt_bcst_source *bcst_source =3D NULL;
> +
> +       if (!success) {
> +               DBG(bap, "Unable to read Broadcast Receive State: error 0=
x%02x", att_ecode);
> +               return;
> +       }
> +
> +       if (length =3D=3D 0)
> +               return;
> +
> +       bcst_source =3D queue_find(bap->rdb->bass_bcst_sources,
> +                               bass_source_match_attrib, attr);
> +
> +       if (!bcst_source) {
> +               bcst_source =3D malloc(sizeof(struct bt_bcst_source));
> +
> +               if (bcst_source =3D=3D NULL) {
> +                       DBG(bap, "Failed to allocate memory for broadcast=
 source");
> +                       return;
> +               }
> +
> +               memset(bcst_source, 0, sizeof(struct bt_bcst_source));
> +               bcst_source->attr =3D attr;
> +
> +               queue_push_tail(bap->rdb->bass_bcst_sources, bcst_source)=
;
> +       }
> +
> +       if (bass_build_bcst_source_from_read_rsp(bcst_source, value)) {
> +               free(bcst_source);
> +               DBG(bap, "Failed to populate broadcast source data");
> +               return;
> +       }
> +}
> +
> +static void bcst_recv_state_notify(struct bt_bap *bap, uint16_t value_ha=
ndle,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct gatt_db_attribute *attr =3D user_data;
> +       struct bt_bcst_source *bcst_source =3D NULL;
> +
> +       bcst_source =3D queue_find(bap->rdb->bass_bcst_sources,
> +                               bass_source_match_attrib, attr);
> +
> +       if (!bcst_source) {
> +               bcst_source =3D malloc(sizeof(struct bt_bcst_source));
> +
> +               if (bcst_source =3D=3D NULL) {
> +                       DBG(bap, "Failed to allocate memory for broadcast=
 source");
> +                       return;
> +               }
> +
> +               memset(bcst_source, 0, sizeof(struct bt_bcst_source));
> +               bcst_source->attr =3D attr;
> +
> +               queue_push_tail(bap->rdb->bass_bcst_sources, bcst_source)=
;
> +       }
> +
> +       if (bass_build_bcst_source_from_notif(bcst_source, value)) {
> +               free(bcst_source);
> +               DBG(bap, "Failed to populate broadcast source data");
> +               return;
> +       }
> +}
> +
> +static void foreach_bass_char(struct gatt_db_attribute *attr, void *user=
_data)
> +{
> +       struct bt_bap *bap =3D user_data;
> +       uint16_t value_handle;
> +       bt_uuid_t uuid, uuid_bcst_audio_scan_cp, uuid_bcst_recv_state;
> +       struct bt_bass *bass;
> +
> +       /* get attribute value handle and uuid */
> +       if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
> +                                               NULL, NULL, &uuid))
> +               return;
> +
> +       bt_uuid16_create(&uuid_bcst_audio_scan_cp, BCST_AUDIO_SCAN_CP_UUI=
D);
> +       bt_uuid16_create(&uuid_bcst_recv_state, BCST_RECV_STATE_UUID);
> +
> +       if (!bt_uuid_cmp(&uuid, &uuid_bcst_audio_scan_cp)) {
> +
> +               /* found Broadcast Audio Scan Control Point characteristi=
c */
> +               bass =3D bap_get_bass(bap);
> +
> +               if (!bass || bass->broadcast_audio_scan_cp)
> +                       return;
> +
> +               /* store characteristic reference */
> +               bass->broadcast_audio_scan_cp =3D attr;
> +
> +               DBG(bap, "Broadcast Audio Scan Control Point found: handl=
e 0x%04x",
> +                                                       value_handle);
> +       }
> +
> +       if (!bt_uuid_cmp(&uuid, &uuid_bcst_recv_state)) {
> +
> +               /* found Broadcast Receive State characteristic */
> +               bap_read_value(bap, value_handle, read_broadcast_receive_=
state, attr);
> +
> +               (void)bap_register_notify(bap, value_handle,
> +                                               bcst_recv_state_notify, a=
ttr);
> +
> +               DBG(bap, "Broadcast receive State found: handle 0x%04x",
> +                                                       value_handle);
> +       }
> +}
> +
>  static void foreach_ascs_service(struct gatt_db_attribute *attr,
>                                                 void *user_data)
>  {
> @@ -3683,6 +4520,19 @@ static void foreach_ascs_service(struct gatt_db_at=
tribute *attr,
>         gatt_db_service_foreach_char(attr, foreach_ascs_char, bap);
>  }
>
> +static void foreach_bass_service(struct gatt_db_attribute *attr,
> +                                               void *user_data)
> +{
> +       struct bt_bap *bap =3D user_data;
> +       struct bt_bass *bass =3D bap_get_bass(bap);
> +
> +       /* store BASS attribute reference */
> +       bass->service =3D attr;
> +
> +       /* handle BASS attributes */
> +       gatt_db_service_foreach_char(attr, foreach_bass_char, bap);
> +}
> +
>  static void bap_endpoint_foreach(void *data, void *user_data)
>  {
>         struct bt_bap_endpoint *ep =3D data;
> @@ -3778,6 +4628,9 @@ clone:
>         bt_uuid16_create(&uuid, ASCS_UUID);
>         gatt_db_foreach_service(bap->rdb->db, &uuid, foreach_ascs_service=
, bap);
>
> +       bt_uuid16_create(&uuid, BASS_UUID);
> +       gatt_db_foreach_service(bap->rdb->db, &uuid, foreach_bass_service=
, bap);
> +
>         return true;
>  }
>
> @@ -4834,3 +5687,215 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap=
_stream *stream, int *fd)
>
>         return io->connecting;
>  }
> +
> +void bap_big_info_adv_report_received_cb(struct gatt_db *db, uint8_t sou=
rce_id,
> +               struct bt_hci_evt_le_big_info_adv_report *big_info_adv_re=
port)
> +{
> +       struct bt_bap_db *bdb =3D bap_get_db(db);
> +       struct bt_bcst_source *bcst_source =3D NULL;
> +       size_t notify_data_len =3D 0;
> +       uint8_t *notify_data;
> +       struct hci_request rq;
> +       struct bt_hci_evt_le_big_sync_estabilished *big_sync_established_=
evt =3D NULL;
> +       int big_sync_established_evt_len =3D 0;
> +
> +       if (!pa_report)
> +               return;
> +
> +       bcst_source =3D queue_find(bdb->bass_bcst_sources,
> +                                       bass_src_id_match,
> +                                       &source_id);
> +
> +       if (bcst_source =3D=3D NULL) {
> +               free(pa_report);
> +               pa_report =3D NULL;
> +               return;
> +       }
> +
> +       big_sync_cmd_len =3D sizeof(struct bt_hci_cmd_le_big_create_sync)
> +                               + big_info_adv_report->num_bis *
> +                               sizeof(struct bt_hci_bis_sync);
> +
> +       free(big_sync_cmd);
> +       big_sync_cmd =3D malloc(big_sync_cmd_len);
> +
> +       if (!big_sync_cmd) {
> +               free(pa_report);
> +               pa_report =3D NULL;
> +               return;
> +       }
> +
> +       memset(big_sync_cmd, 0, big_sync_cmd_len);
> +
> +       big_sync_cmd->sync_handle =3D big_info_adv_report->sync_handle;
> +       big_sync_cmd->encryption =3D big_info_adv_report->encryption;
> +       big_sync_cmd->timeout =3D 0x4000;
> +       big_sync_cmd->num_bis =3D big_info_adv_report->num_bis;
> +
> +       bass_fill_create_big_sync_cmd_from_pa_report(big_sync_cmd);
> +
> +       if (big_info_adv_report->encryption =3D=3D 0x01) {
> +               bcst_source->encryption =3D BT_BASS_BIG_ENC_STATE_BCODE_R=
EQ;
> +       } else {
> +               bcst_source->encryption =3D BT_BASS_BIG_ENC_STATE_NO_ENC;
> +
> +               big_sync_established_evt_len =3D
> +                               sizeof(struct bt_hci_evt_le_big_sync_esta=
bilished) +
> +                               big_sync_cmd->num_bis * sizeof(uint16_t);
> +
> +               big_sync_established_evt =3D malloc(big_sync_established_=
evt_len);
> +               if (big_sync_established_evt =3D=3D NULL) {
> +                       free(pa_report);
> +                       pa_report =3D NULL;
> +
> +                       free(big_sync_cmd);
> +                       big_sync_cmd =3D NULL;
> +                       big_sync_cmd_len =3D 0;
> +
> +                       goto done;
> +               }
> +
> +               /* create BIG sync */
> +               rq.ogf          =3D OGF_LE_CTL;
> +               rq.ocf          =3D 0x006B;
> +               rq.event        =3D BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED;
> +               rq.cparam       =3D big_sync_cmd;
> +               rq.clen         =3D big_sync_cmd_len;
> +               rq.rparam       =3D big_sync_established_evt;
> +               rq.rlen         =3D big_sync_established_evt_len;
> +
> +               if (hci_send_req(hci_fd, &rq, 0) < 0) {
> +                       free(pa_report);
> +                       pa_report =3D NULL;
> +
> +                       free(big_sync_cmd);
> +                       big_sync_cmd =3D NULL;
> +                       big_sync_cmd_len =3D 0;
> +
> +                       free(big_sync_established_evt);
> +
> +                       goto done;
> +               }
> +
> +               if (!big_sync_established_evt->status)
> +                       bass_fill_bcst_source_bis_sync_bitmask(bcst_sourc=
e);
> +       }
> +
> +done:
> +
> +       notify_data =3D bass_build_notif_from_bcst_source(bcst_source,
> +                                                       &notify_data_len)=
;
> +
> +       gatt_db_attribute_notify(bcst_source->attr, (void *)notify_data,
> +                               notify_data_len, NULL);
> +
> +       free(notify_data);
> +}
> +
> +void bap_pa_report_received_cb(struct gatt_db *db, uint8_t source_id,
> +                               struct bt_hci_le_pa_report *report)
> +{
> +       struct bt_bcst_source *bcst_source =3D NULL;
> +       struct bt_bap_db *bdb =3D bap_get_db(db);
> +       uint8_t report_len =3D sizeof(struct bt_hci_le_pa_report) +
> +                                               report->data_len;
> +
> +       printf("Report len =3D %d\n\n", report->data_len);
> +
> +       free(pa_report);
> +       pa_report =3D malloc(report_len);
> +       if (!pa_report)
> +               return;
> +
> +       memcpy(pa_report, report, report_len);
> +
> +       bcst_source =3D queue_find(bdb->bass_bcst_sources,
> +                                       bass_src_id_match,
> +                                       &source_id);
> +
> +       if (!bcst_source)
> +               return;
> +
> +       bass_fill_bcst_source_from_pa_report(bcst_source);
> +}
> +
> +int bap_ext_adv_report_received_cb(struct gatt_db *db,
> +                               struct bt_hci_le_ext_adv_report *ext_adv_=
report)
> +{
> +       struct bt_bcst_source *bcst_source =3D NULL;
> +       struct gatt_db_attribute *attr =3D NULL;
> +       struct bt_bap_db *bdb =3D bap_get_db(db);
> +       struct bt_ad_structure *ad_structure;
> +       uint16_t uuid;
> +       uint8_t *bid;
> +
> +       struct iovec iov =3D {
> +               .iov_base =3D ext_adv_report->data,
> +               .iov_len =3D ext_adv_report->data_len,
> +       };
> +
> +       bcst_source =3D queue_find(bdb->bass_bcst_sources,
> +                                       bass_source_match_sid,
> +                                       &ext_adv_report->sid);
> +
> +       if (bcst_source !=3D NULL)
> +               return -1;
> +
> +       bcst_source =3D malloc(sizeof(struct bt_bcst_source));
> +
> +       if (bcst_source =3D=3D NULL)
> +               return -1;
> +
> +       memset(bcst_source, 0, sizeof(struct bt_bcst_source));
> +
> +       bcst_source->id =3D next_available_source_id++;
> +       bcst_source->addr_type =3D ext_adv_report->addr_type;
> +       memcpy(bcst_source->addr, ext_adv_report->addr, 6);
> +       bcst_source->sid =3D ext_adv_report->sid;
> +
> +       ad_structure =3D util_iov_pull_mem(&iov, sizeof(*ad_structure));
> +
> +       while (ad_structure) {
> +               if (ad_structure->ad_type =3D=3D BT_AD_SERVICE_DATA16) {
> +                       uuid =3D bt_get_le16(util_iov_pull_mem(&iov, size=
of(uint16_t)));
> +                       if (uuid =3D=3D BCST_AUDIO_ANNOUNCEMENT_SERVICE_U=
UID) {
> +                               bid =3D util_iov_pull_mem(&iov,
> +                                                       BT_BAP_BROADCAST_=
ID_SIZE);
> +                               memcpy(bcst_source->bid, bid,
> +                                                       BT_BAP_BROADCAST_=
ID_SIZE);
> +                               break;
> +                       }
> +               }
> +
> +               ad_structure =3D util_iov_pull_mem(&iov, sizeof(*ad_struc=
ture));
> +       }
> +
> +       for (int i =3D 0; i < NUM_BCST_RECV_STATES; i++) {
> +               attr =3D bdb->bass->bcst_recv_states[i]->attr;
> +
> +               if (queue_find(bdb->bass_bcst_sources,
> +                       bass_source_match_attrib, attr) =3D=3D NULL) {
> +                       bcst_source->attr =3D attr;
> +                       break;
> +               }
> +       }
> +
> +       queue_push_tail(bdb->bass_bcst_sources, bcst_source);
> +
> +       return bcst_source->id;
> +}
> +
> +int bt_bap_register_device(int dev_id)
> +{
> +       /* Open HCI */
> +       hci_fd =3D hci_open_dev(dev_id);
> +       if (hci_fd =3D=3D -1)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +void bt_bap_register_db(struct gatt_db *db)
> +{
> +       bap_db_new(db);
> +}
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 47a15636c..f72ecbd76 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -9,6 +9,7 @@
>
>  #include <stdbool.h>
>  #include <inttypes.h>
> +#include "monitor/bt.h"
>
>  #ifndef __packed
>  #define __packed __attribute__((packed))
> @@ -33,6 +34,9 @@
>  #define BT_BAP_CONFIG_PHY_2M           0x02
>  #define BT_BAP_CONFIG_PHY_CODEC                0x03
>
> +#define BT_BAP_BROADCAST_CODE_SIZE     16
> +#define BT_BAP_BROADCAST_ID_SIZE       3
> +
>  struct bt_bap;
>  struct bt_bap_pac;
>  struct bt_bap_stream;
> @@ -62,6 +66,17 @@ struct bt_bap_qos {
>         uint8_t  target_latency;        /* Target Latency */
>  };
>
> +struct bt_ad_structure {
> +       uint8_t  ad_len;
> +       uint8_t  ad_type;
> +       uint8_t  value[0];
> +} __packed;
> +
> +struct bt_broadcast_audio_announcement {
> +       uint16_t uuid;
> +       uint8_t  bid[BT_BAP_BROADCAST_ID_SIZE];
> +} __packed;
> +
>  typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data)=
;
>  typedef void (*bt_bap_destroy_func_t)(void *user_data);
>  typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
> @@ -267,3 +282,13 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *s=
tream);
>
>  int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd);
>  bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *f=
d);
> +
> +int bap_ext_adv_report_received_cb(struct gatt_db *db,
> +                               struct bt_hci_le_ext_adv_report *ext_adv_=
report);
> +void bap_pa_report_received_cb(struct gatt_db *db, uint8_t source_id,
> +                                       struct bt_hci_le_pa_report *repor=
t);
> +void bap_big_info_adv_report_received_cb(struct gatt_db *db, uint8_t sou=
rce_id,
> +               struct bt_hci_evt_le_big_info_adv_report *big_info_adv_re=
port);
> +
> +int bt_bap_register_device(int dev_id);
> +void bt_bap_register_db(struct gatt_db *db);
> diff --git a/src/shared/bass.h b/src/shared/bass.h
> new file mode 100644
> index 000000000..cdcb5a700
> --- /dev/null
> +++ b/src/shared/bass.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> + *
> + */
> +
> +#define NUM_BCST_RECV_STATES                           2
> +
> +/* Application error codes */
> +#define BT_BASS_ERROR_OPCODE_NOT_SUPPORTED             0x80
> +
> +#define BT_BASS_ERROR_INVALID_SOURCE_ID                        0x81
> +
> +/* PA_Sync_State values */
> +#define BT_BASS_NOT_SYNCHRONIZED_TO_PA                 0x00
> +#define BT_BASS_SYNC_INFO_RE                           0x01
> +#define BT_BASS_SYNCHRONIZED_TO_PA                     0x02
> +#define BT_BASS_FAILED_TO_SYNCHRONIZE_TO_PA            0x03
> +#define BT_BASS_NO_PAST                                        0x04
> +
> +/* BIG_Encryption values */
> +#define BT_BASS_BIG_ENC_STATE_NO_ENC                   0x00
> +#define BT_BASS_BIG_ENC_STATE_BCODE_REQ                        0x01
> +#define BT_BASS_BIG_ENC_STATE_DEC                      0x02
> +#define BT_BASS_BIG_ENC_STATE_BAD_CODE                 0x03
> +
> +/*
> + * Broadcast Audio Scan Control Point
> + * header structure
> + */
> +struct bt_bass_bcst_audio_scan_cp_hdr {
> +       uint8_t op;
> +} __packed;
> +
> +#define BT_BASS_SET_BCST_CODE                          0x04
> +
> +struct bt_bass_set_bcst_code_params {
> +       uint8_t source_id;
> +       uint8_t bcst_code[BT_BAP_BROADCAST_CODE_SIZE];
> +} __packed;
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
