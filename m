Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6770EC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 21:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbjDYVZx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbjDYVZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 17:25:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6426A16F37
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 14:25:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24736790966so5327683a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682457948; x=1685049948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1T9FXrgaoNDinWfraZ7lixjel2DdmB4o1Uq+d1iNmk=;
        b=CxvkCEeKq4UHgAtuS0zY5xGsY2QSu9DYtfhxrQ1JsHQVoKMvcrp9zc1zEfK44N2rVy
         AsExyqLAAY0ygrubfrC3+eTD7VFEy5Y55U29NUb5WTnk0SifrSssMnaC8x5s7tEi2TrN
         tiPBSWuLLxMemUgbdGn15NT+Y25QaS8TcOw0iwvuqSNd89HhqxftK9fdOVfBxnYzsz9P
         Ih8WrX94ZHUuF8BcV1tDIRYdz2zMNLBJkCP4Zptv71MP6xR+JnuXh2Us1E0RnSOQMmnT
         EzH4OAhWvnWHssUZvIP1gccQRrQ/eaqZH7962EM75fCYGdY1eoMF7vUgvVgscHQSm9BT
         /3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682457948; x=1685049948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1T9FXrgaoNDinWfraZ7lixjel2DdmB4o1Uq+d1iNmk=;
        b=ENM5gg4BUPSRUri5/0Nm4/Gn3B9ozP9wcUpLq0Me10PYn+HCLDGbp934p7I2Vnwmc/
         gvp/hIOPYmLtFtRUeVwDY6YgnpYGrUx0DwhE5acG3jJiJTIyqF6cwj7zdRQ0Qfj4KC1A
         w2wt8cBiC76kFhSpR8KfvBdHUokG4YwfQb49YS2yLcdJzxSrVmebwCRjC7XTdKsmc5TR
         nO8x4raHg8bArCpu/nvA/1gjFKjENCaT0opTCbdk/qN4/txmnzuq4iYGu/yJWj2FQn2U
         iQVVtE4vAAfNP+cBDW+Wr4Y7HJh5ozv2cYGRqS2RpfW6inCq1Ojr2hY2zAGDFmHHrQeG
         l7Dw==
X-Gm-Message-State: AAQBX9fQhQVz5ezSwd2qN/lloQE3bIdI3dVVyxQSnA1qrnE7uL3vh3lP
        A6atgUjb8NdlcdInRStsHLqqoCuSJi8+CwgDlPIVWu6j
X-Google-Smtp-Source: AKy350YnaFYi/0iEhTX9C+GlLcBaD7WuGiBGdEwEAYh1TaoI80KC7969nP0Gxl72ae/bfKtNBE0ftWv0enQCrzPUVj0=
X-Received: by 2002:a17:90a:b798:b0:240:e532:d868 with SMTP id
 m24-20020a17090ab79800b00240e532d868mr18658078pjr.43.1682457947536; Tue, 25
 Apr 2023 14:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230424152457.28000-1-iulia.tanasescu@nxp.com> <20230424152457.28000-3-iulia.tanasescu@nxp.com>
In-Reply-To: <20230424152457.28000-3-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 Apr 2023 14:25:33 -0700
Message-ID: <CABBYNZK70qisom+iSyCoTh2XF70zNAcZUN6bKT2G6k2RoBRq8g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] shared/bass: Add initial code for handling BASS
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Mon, Apr 24, 2023 at 8:32=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This adds initial code for Broadcast Audio Scan Service.
>
> ---
>  Makefile.am            |   1 +
>  src/shared/att-types.h |   4 +-
>  src/shared/bap.c       |  57 +---
>  src/shared/bap.h       |  51 +++
>  src/shared/bass.c      | 703 +++++++++++++++++++++++++++++++++++++++++
>  src/shared/bass.h      | 124 ++++++++
>  6 files changed, 896 insertions(+), 44 deletions(-)
>  create mode 100644 src/shared/bass.c
>  create mode 100644 src/shared/bass.h
>
> diff --git a/Makefile.am b/Makefile.am
> index 7ded3ba75..f4425a003 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -231,6 +231,7 @@ shared_sources =3D src/shared/io.h src/shared/timeout=
.h \
>                         src/shared/gap.h src/shared/gap.c \
>                         src/shared/log.h src/shared/log.c \
>                         src/shared/bap.h src/shared/bap.c src/shared/ascs=
.h \
> +                       src/shared/bass.h src/shared/bass.c \
>                         src/shared/mcs.h src/shared/mcp.h src/shared/mcp.=
c \
>                         src/shared/vcp.c src/shared/vcp.h \
>                         src/shared/csip.c src/shared/csip.h \
> diff --git a/src/shared/att-types.h b/src/shared/att-types.h
> index a08b24155..6783b0980 100644
> --- a/src/shared/att-types.h
> +++ b/src/shared/att-types.h
> @@ -4,6 +4,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2014  Google Inc.
> + *  Copyright 2023 NXP
>   *
>   *
>   */
> @@ -101,9 +102,10 @@ struct bt_att_pdu_error_rsp {
>  /*
>   * Common Profile and Service Error Code descriptions (see Supplement to=
 the
>   * Bluetooth Core Specification, sections 1.2 and 2). The error codes wi=
thin
> - * 0xE0-0xFC are reserved for future use. The remaining 3 are defined as=
 the
> + * 0xE0-0xFB are reserved for future use. The remaining 3 are defined as=
 the
>   * following:
>   */
> +#define BT_ERROR_WRITE_REQUEST_REJECTED         0xfc

Please split this change on its own patch, it is probably a good idea
to update the comments above since there are now 4 errors defined in
this region.

>  #define BT_ERROR_CCC_IMPROPERLY_CONFIGURED      0xfd
>  #define BT_ERROR_ALREADY_IN_PROGRESS            0xfe
>  #define BT_ERROR_OUT_OF_RANGE                   0xff
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 1fff7e0fd..70aa89a79 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -4,6 +4,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> + *  Copyright 2023 NXP
>   *
>   */
>
> @@ -28,6 +29,7 @@
>  #include "src/shared/gatt-client.h"
>  #include "src/shared/bap.h"
>  #include "src/shared/ascs.h"
> +#include "src/shared/bass.h"
>
>  /* Maximum number of ASE(s) */
>  #define NUM_SINKS 2
> @@ -114,14 +116,6 @@ struct bt_ascs {
>         struct gatt_db_attribute *ase_cp_ccc;
>  };
>
> -struct bt_bap_db {
> -       struct gatt_db *db;
> -       struct bt_pacs *pacs;
> -       struct bt_ascs *ascs;
> -       struct queue *sinks;
> -       struct queue *sources;
> -};
> -
>  struct bt_bap_req {
>         unsigned int id;
>         struct bt_bap_stream *stream;
> @@ -133,10 +127,6 @@ struct bt_bap_req {
>         void *user_data;
>  };
>
> -typedef void (*bap_notify_t)(struct bt_bap *bap, uint16_t value_handle,
> -                               const uint8_t *value, uint16_t length,
> -                               void *user_data);
> -
>  struct bt_bap_notify {
>         unsigned int id;
>         struct bt_bap *bap;
> @@ -144,35 +134,6 @@ struct bt_bap_notify {
>         void *user_data;
>  };
>
> -struct bt_bap {
> -       int ref_count;
> -       struct bt_bap_db *ldb;
> -       struct bt_bap_db *rdb;
> -       struct bt_gatt_client *client;
> -       struct bt_att *att;
> -       struct bt_bap_req *req;
> -
> -       unsigned int cp_id;
> -       unsigned int process_id;
> -       unsigned int disconn_id;
> -       unsigned int idle_id;
> -
> -       struct queue *reqs;
> -       struct queue *notify;
> -       struct queue *streams;
> -       struct queue *local_eps;
> -       struct queue *remote_eps;
> -
> -       struct queue *pac_cbs;
> -       struct queue *ready_cbs;
> -       struct queue *state_cbs;
> -
> -       bt_bap_debug_func_t debug_func;
> -       bt_bap_destroy_func_t debug_destroy;
> -       void *debug_data;
> -       void *user_data;
> -};
> -
>  struct bt_bap_pac {
>         struct bt_bap_db *bdb;
>         char *name;
> @@ -569,7 +530,7 @@ static void bap_disconnected(int err, void *user_data=
)
>         bt_bap_detach(bap);
>  }
>
> -static struct bt_bap *bap_get_session(struct bt_att *att, struct gatt_db=
 *db)
> +struct bt_bap *bap_get_session(struct bt_att *att, struct gatt_db *db)
>  {
>         const struct queue_entry *entry;
>         struct bt_bap *bap;
> @@ -2189,6 +2150,7 @@ static struct bt_bap_db *bap_db_new(struct gatt_db =
*db)
>         bdb->db =3D gatt_db_ref(db);
>         bdb->sinks =3D queue_new();
>         bdb->sources =3D queue_new();
> +       bdb->bass_bcast_srcs =3D queue_new();
>
>         if (!bap_db)
>                 bap_db =3D queue_new();
> @@ -2199,6 +2161,9 @@ static struct bt_bap_db *bap_db_new(struct gatt_db =
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
> @@ -2518,10 +2483,12 @@ static void bap_db_free(void *data)
>
>         queue_destroy(bdb->sinks, bap_pac_free);
>         queue_destroy(bdb->sources, bap_pac_free);
> +       queue_destroy(bdb->bass_bcast_srcs, bass_bcast_src_free);
>         gatt_db_unref(bdb->db);
>
>         free(bdb->pacs);
>         free(bdb->ascs);
> +       free(bdb->bass);
>         free(bdb);
>  }
>
> @@ -2669,6 +2636,7 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, stru=
ct gatt_db *rdb)
>         bdb->db =3D gatt_db_ref(rdb);
>         bdb->sinks =3D queue_new();
>         bdb->sources =3D queue_new();
> +       bdb->bass_bcast_srcs =3D queue_new();
>
>         bap->rdb =3D bdb;
>         bap->remote_eps =3D queue_new();
> @@ -3382,7 +3350,7 @@ static void bap_notify_destroy(void *data)
>                 free(notify);
>  }
>
> -static unsigned int bap_register_notify(struct bt_bap *bap,
> +unsigned int bap_register_notify(struct bt_bap *bap,
>                                         uint16_t value_handle,
>                                         bap_notify_t func,
>                                         void *user_data)
> @@ -3835,6 +3803,9 @@ clone:
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
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index bd13abef9..44b0d1535 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -4,6 +4,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> + *  Copyright 2023 NXP
>   *
>   */
>
> @@ -62,9 +63,49 @@ struct bt_bap_qos {
>         uint8_t  target_latency;        /* Target Latency */
>  };
>
> +struct bt_bap_db {
> +       struct gatt_db *db;
> +       struct bt_pacs *pacs;
> +       struct bt_ascs *ascs;
> +       struct bt_bass *bass;
> +       struct queue *sinks;
> +       struct queue *sources;
> +       struct queue *bass_bcast_srcs;
> +};
> +
>  typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data)=
;
>  typedef void (*bt_bap_destroy_func_t)(void *user_data);
>  typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
> +
> +struct bt_bap {
> +       int ref_count;
> +       struct bt_bap_db *ldb;
> +       struct bt_bap_db *rdb;
> +       struct bt_gatt_client *client;
> +       struct bt_att *att;
> +       struct bt_bap_req *req;
> +
> +       unsigned int cp_id;
> +       unsigned int process_id;
> +       unsigned int disconn_id;
> +       unsigned int idle_id;
> +
> +       struct queue *reqs;
> +       struct queue *notify;
> +       struct queue *streams;
> +       struct queue *local_eps;
> +       struct queue *remote_eps;
> +
> +       struct queue *pac_cbs;
> +       struct queue *ready_cbs;
> +       struct queue *state_cbs;
> +
> +       bt_bap_debug_func_t debug_func;
> +       bt_bap_destroy_func_t debug_destroy;
> +       void *debug_data;
> +       void *user_data;
> +};

Don't really like the idea of exposing these as public API, I know BAP
also incorporate the BASS client functionality but BASS server
shouldn't use bt_bap section, so Id keep client and server
independent, client being part of bap.c and server on bass.c, also it
probably makes sense to have a dedicated plugin for bass as standalone
so if the platform is not interested in exposing BASS it can just
disable the plugin so no instance of bt_bass shall exist.

>  typedef void (*bt_bap_pac_func_t)(struct bt_bap_pac *pac, void *user_dat=
a);
>  typedef bool (*bt_bap_pac_foreach_t)(struct bt_bap_pac *lpac,
>                                         struct bt_bap_pac *rpac,
> @@ -86,6 +127,10 @@ typedef void (*bt_bap_stream_func_t)(struct bt_bap_st=
ream *stream,
>                                         void *user_data);
>  typedef void (*bt_bap_func_t)(struct bt_bap *bap, void *user_data);
>
> +typedef void (*bap_notify_t)(struct bt_bap *bap, uint16_t value_handle,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data);
> +
>  /* Local PAC related functions */
>  struct bt_bap_pac_qos {
>         uint8_t  framing;
> @@ -265,3 +310,9 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *st=
ream);
>
>  int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd);
>  bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *f=
d);
> +
> +struct bt_bap *bap_get_session(struct bt_att *att, struct gatt_db *db);
> +unsigned int bap_register_notify(struct bt_bap *bap,
> +                                       uint16_t value_handle,
> +                                       bap_notify_t func,
> +                                       void *user_data);
> diff --git a/src/shared/bass.c b/src/shared/bass.c
> new file mode 100644
> index 000000000..1be36ef75
> --- /dev/null
> +++ b/src/shared/bass.c
> @@ -0,0 +1,703 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright 2023 NXP
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <inttypes.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <poll.h>
> +
> +#include "lib/bluetooth.h"
> +#include "lib/uuid.h"
> +#include "lib/iso.h"
> +
> +#include "src/shared/queue.h"
> +#include "src/shared/util.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/gatt-client.h"
> +#include "src/shared/bap.h"
> +#include "src/shared/bass.h"
> +
> +#define DBG(_bap, fmt, arg...) \
> +       bass_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
> +
> +static void bass_debug(struct bt_bap *bap, const char *format, ...)
> +{
> +       va_list ap;
> +
> +       if (!bap || !format || !bap->debug_func)
> +               return;
> +
> +       va_start(ap, format);
> +       util_debug_va(bap->debug_func, bap->debug_data, format, ap);
> +       va_end(ap);
> +}
> +
> +static int
> +bass_build_bcast_src_from_notif(struct bt_bcast_src *bcast_src,
> +                               const uint8_t *value, uint16_t length)
> +{
> +       struct bt_bass_subgroup_data *subgroup_data =3D NULL;
> +       uint8_t *id;
> +       uint8_t *addr_type;
> +       uint8_t *addr;
> +       uint8_t *sid;
> +       uint8_t *bid;
> +       uint8_t *pa_sync_state;
> +       uint8_t *enc;
> +       uint8_t *bad_code =3D NULL;
> +       uint8_t *num_subgroups;
> +       uint8_t *bis_sync_state;
> +       uint8_t *meta_len;
> +       uint8_t *meta;
> +
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *) value,
> +               .iov_len =3D length,
> +       };
> +
> +       /* Extract all fields from notification */
> +       id =3D util_iov_pull_mem(&iov, sizeof(*id));
> +       if (!id) {
> +               DBG(bcast_src->bap, "Unable to parse Broadcast Receive St=
ate");
> +               return -1;
> +       }
> +
> +       addr_type =3D util_iov_pull_mem(&iov, sizeof(*addr_type));
> +       if (!addr_type) {
> +               DBG(bcast_src->bap, "Unable to parse Broadcast Receive St=
ate");
> +               return -1;
> +       }
> +
> +       addr =3D util_iov_pull_mem(&iov, sizeof(bdaddr_t));
> +       if (!addr) {
> +               DBG(bcast_src->bap, "Unable to parse Broadcast Receive St=
ate");
> +               return -1;
> +       }
> +
> +       sid =3D util_iov_pull_mem(&iov, sizeof(*sid));
> +       if (!sid) {
> +               DBG(bcast_src->bap, "Unable to parse Broadcast Receive St=
ate");
> +               return -1;
> +       }
> +
> +       bid =3D util_iov_pull_mem(&iov, 3);
> +       if (!bid) {
> +               DBG(bcast_src->bap, "Unable to parse Broadcast Receive St=
ate");
> +               return -1;
> +       }
> +
> +       pa_sync_state =3D util_iov_pull_mem(&iov, sizeof(*pa_sync_state))=
;
> +       if (!pa_sync_state) {
> +               DBG(bcast_src->bap, "Unable to parse Broadcast Receive St=
ate");
> +               return -1;
> +       }
> +
> +       enc =3D util_iov_pull_mem(&iov, sizeof(*enc));
> +       if (!enc) {
> +               DBG(bcast_src->bap, "Unable to parse Broadcast Receive St=
ate");
> +               return -1;
> +       }
> +
> +       if (*enc =3D=3D BT_BASS_BIG_ENC_STATE_BAD_CODE) {
> +               bad_code =3D util_iov_pull_mem(&iov, BT_BASS_BCAST_CODE_S=
IZE);
> +               if (!bad_code) {
> +                       DBG(bcast_src->bap, "Unable to parse "
> +                               "Broadcast Receive State");
> +                       return -1;
> +               }
> +       }
> +
> +       num_subgroups =3D util_iov_pull_mem(&iov, sizeof(*num_subgroups))=
;
> +       if (!num_subgroups) {
> +               DBG(bcast_src->bap, "Unable to parse Broadcast Receive St=
ate");
> +               return -1;
> +       }
> +
> +       if (*num_subgroups =3D=3D 0)
> +               goto done;
> +
> +       subgroup_data =3D malloc((*num_subgroups) * sizeof(*subgroup_data=
));
> +       if (!subgroup_data) {
> +               DBG(bcast_src->bap, "Unable to allocate memory");
> +               return -1;
> +       }
> +
> +       memset(subgroup_data, 0, (*num_subgroups) * sizeof(*subgroup_data=
));
> +
> +       for (int i =3D 0; i < *num_subgroups; i++) {
> +               bis_sync_state =3D util_iov_pull_mem(&iov,
> +                                               sizeof(uint32_t));
> +               if (!bis_sync_state) {
> +                       DBG(bcast_src->bap, "Unable to parse "
> +                               "Broadcast Receive State");
> +
> +                       for (int j =3D 0; j < i; j++)
> +                               free(subgroup_data[j].meta);
> +
> +                       free(subgroup_data);
> +                       return -1;
> +               }
> +
> +               subgroup_data[i].bis_sync =3D get_le32(bis_sync_state);
> +
> +               meta_len =3D util_iov_pull_mem(&iov, sizeof(*meta_len));
> +               if (!meta_len) {
> +                       DBG(bcast_src->bap, "Unable to parse "
> +                               "Broadcast Receive State");
> +
> +                       for (int j =3D 0; j < i; j++)
> +                               free(subgroup_data[j].meta);
> +
> +                       free(subgroup_data);
> +                       return -1;
> +               }
> +
> +               subgroup_data[i].meta_len =3D *meta_len;
> +
> +               if (*meta_len =3D=3D 0)
> +                       continue;
> +
> +               subgroup_data[i].meta =3D malloc(*meta_len);
> +               if (!subgroup_data[i].meta) {
> +                       DBG(bcast_src->bap, "Unable to allocate memory");
> +
> +                       for (int j =3D 0; j < i; j++)
> +                               free(subgroup_data[j].meta);
> +
> +                       free(subgroup_data);
> +                       return -1;
> +               }
> +
> +               meta =3D util_iov_pull_mem(&iov, *meta_len);
> +               if (!meta) {
> +                       DBG(bcast_src->bap, "Unable to parse "
> +                               "Broadcast Receive State");
> +
> +                       for (int j =3D 0; j < i; j++)
> +                               free(subgroup_data[j].meta);
> +
> +                       free(subgroup_data);
> +                       return -1;
> +               }
> +
> +               memcpy(subgroup_data[i].meta, meta, *meta_len);
> +       }
> +
> +done:
> +       /*
> +        * If no errors occurred, copy extracted fields into
> +        * the broadcast source structure
> +        */
> +       if (bcast_src->subgroup_data) {
> +               for (int i =3D 0; i < bcast_src->num_subgroups; i++)
> +                       free(bcast_src->subgroup_data[i].meta);
> +
> +               free(bcast_src->subgroup_data);
> +       }
> +
> +       bcast_src->id =3D *id;
> +       bcast_src->addr_type =3D *addr_type;
> +       memcpy(&bcast_src->addr, addr, sizeof(bdaddr_t));
> +       bcast_src->sid =3D *sid;
> +       bcast_src->bid =3D get_le24(bid);
> +       bcast_src->sync_state =3D *pa_sync_state;
> +       bcast_src->enc =3D *enc;
> +
> +       if (*enc =3D=3D BT_BASS_BIG_ENC_STATE_BAD_CODE)
> +               memcpy(bcast_src->bad_code, bad_code, BT_BASS_BCAST_CODE_=
SIZE);
> +       else
> +               memset(bcast_src->bad_code, 0, BT_BASS_BCAST_CODE_SIZE);
> +
> +       bcast_src->num_subgroups =3D *num_subgroups;
> +
> +       bcast_src->subgroup_data =3D subgroup_data;
> +
> +       return 0;
> +}
> +
> +static int
> +bass_build_bcast_src_from_read_rsp(struct bt_bcast_src *bcast_src,
> +                               const uint8_t *value, uint16_t length)
> +{
> +       return bass_build_bcast_src_from_notif(bcast_src, value, length);
> +}
> +
> +static uint8_t *bass_build_notif_from_bcast_src(struct bt_bcast_src *bca=
st_src,
> +                                                       size_t *notif_len=
)
> +{
> +       size_t len =3D 0;
> +       uint8_t *notif =3D NULL;
> +       struct iovec iov;
> +
> +       *notif_len =3D 0;
> +
> +       if (!bcast_src)
> +               return NULL;
> +
> +       len =3D BT_BASS_BCAST_SRC_LEN + bcast_src->num_subgroups *
> +                       BT_BASS_BCAST_SRC_SUBGROUP_LEN;
> +
> +       if (bcast_src->enc =3D=3D BT_BASS_BIG_ENC_STATE_BAD_CODE)
> +               len +=3D BT_BASS_BCAST_CODE_SIZE;
> +
> +       for (size_t i =3D 0; i < bcast_src->num_subgroups; i++) {
> +               /* Add length for subgroup metadata */
> +               len +=3D bcast_src->subgroup_data[i].meta_len;
> +       }
> +
> +       notif =3D malloc(len);
> +       if (!notif)
> +               return NULL;
> +
> +       memset(notif, 0, len);
> +
> +       iov.iov_base =3D notif;
> +       iov.iov_len =3D 0;
> +
> +       util_iov_push_mem(&iov, sizeof(bcast_src->id),
> +                       &bcast_src->id);
> +       util_iov_push_mem(&iov, sizeof(bcast_src->addr_type),
> +                       &bcast_src->addr_type);
> +       util_iov_push_mem(&iov, sizeof(bcast_src->addr),
> +                       &bcast_src->addr);
> +       util_iov_push_mem(&iov, sizeof(bcast_src->sid),
> +                       &bcast_src->sid);
> +       util_iov_push_mem(&iov, 3, &bcast_src->bid);
> +       util_iov_push_mem(&iov, sizeof(bcast_src->sync_state),
> +                       &bcast_src->sync_state);

Don't we need to convert the endianess for multibyte fields or are
they stored in LE format? I usually recommend storing in host order so
we only convert when encoding a PDU to be sent over the air, It would
probably be a good idea to add something like util_iov_push_le32
though, etc, which internally could use cpu_to_le32 to convert in
place, this would apply to util_iov_pull_le32 as well.

> +       util_iov_push_mem(&iov, sizeof(bcast_src->enc),
> +                       &bcast_src->enc);
> +
> +       if (bcast_src->enc =3D=3D BT_BASS_BIG_ENC_STATE_BAD_CODE)
> +               util_iov_push_mem(&iov, sizeof(bcast_src->bad_code),
> +                                       bcast_src->bad_code);
> +
> +       util_iov_push_mem(&iov, sizeof(bcast_src->num_subgroups),
> +                               &bcast_src->num_subgroups);
> +
> +       for (size_t i =3D 0; i < bcast_src->num_subgroups; i++) {
> +               /* Add subgroup bis_sync */
> +               util_iov_push_mem(&iov,
> +                       sizeof(bcast_src->subgroup_data[i].bis_sync),
> +                       &bcast_src->subgroup_data[i].bis_sync);
> +
> +               /* Add subgroup meta_len */
> +               util_iov_push_mem(&iov,
> +                       sizeof(bcast_src->subgroup_data[i].meta_len),
> +                       &bcast_src->subgroup_data[i].meta_len);
> +
> +               /* Add subgroup metadata */
> +               if (bcast_src->subgroup_data[i].meta_len > 0)
> +                       util_iov_push_mem(&iov,
> +                               bcast_src->subgroup_data[i].meta_len,
> +                               bcast_src->subgroup_data[i].meta);
> +       }
> +
> +       *notif_len =3D len;
> +       return notif;
> +}
> +
> +static uint8_t *
> +bass_build_read_rsp_from_bcast_src(struct bt_bcast_src *bcast_src,
> +                                       size_t *rsp_len)
> +{
> +       return bass_build_notif_from_bcast_src(bcast_src, rsp_len);
> +}
> +
> +static bool bass_check_cp_command_subgroup_data_len(uint8_t num_subgroup=
s,
> +                                                       struct iovec *iov=
)
> +{
> +       uint32_t *bis_sync_state;
> +       uint8_t *meta_len;
> +       uint8_t *meta;
> +
> +       for (int i =3D 0; i < num_subgroups; i++) {
> +               bis_sync_state =3D util_iov_pull_mem(iov,
> +                                       sizeof(*bis_sync_state));
> +               if (!bis_sync_state)
> +                       return false;
> +
> +               meta_len =3D util_iov_pull_mem(iov,
> +                                       sizeof(*meta_len));
> +               if (!meta_len)
> +                       return false;
> +
> +               meta =3D util_iov_pull_mem(iov, *meta_len);
> +               if (!meta)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static bool bass_check_cp_command_len(struct iovec *iov)
> +{
> +       struct bt_bass_bcast_audio_scan_cp_hdr *hdr;
> +       union {
> +               struct bt_bass_add_src_params *add_src_params;
> +               struct bt_bass_mod_src_params *mod_src_params;
> +               struct bt_bass_set_bcast_code_params *set_bcast_code_para=
ms;
> +               struct bt_bass_remove_src_params *remove_src_params;
> +       } params;
> +
> +       /* Get command header */
> +       hdr =3D util_iov_pull_mem(iov, sizeof(*hdr));
> +
> +       if (!hdr)
> +               return false;
> +
> +       /* Check command parameters */
> +       switch (hdr->op) {
> +       case BT_BASS_ADD_SRC:
> +               params.add_src_params =3D util_iov_pull_mem(iov,
> +                                               sizeof(*params.add_src_pa=
rams));
> +               if (!params.add_src_params)
> +                       return false;
> +
> +               if (!bass_check_cp_command_subgroup_data_len(
> +                                       params.add_src_params->num_subgro=
ups,
> +                                       iov))
> +                       return false;
> +
> +               break;
> +       case BT_BASS_MOD_SRC:
> +               params.mod_src_params =3D util_iov_pull_mem(iov,
> +                                               sizeof(*params.mod_src_pa=
rams));
> +               if (!params.mod_src_params)
> +                       return false;
> +
> +               if (!bass_check_cp_command_subgroup_data_len(
> +                                       params.mod_src_params->num_subgro=
ups,
> +                                       iov))
> +                       return false;
> +
> +               break;
> +       case BT_BASS_SET_BCAST_CODE:
> +               params.set_bcast_code_params =3D util_iov_pull_mem(iov,
> +                                       sizeof(*params.set_bcast_code_par=
ams));
> +               if (!params.set_bcast_code_params)
> +                       return false;
> +
> +               break;
> +       case BT_BASS_REMOVE_SRC:
> +               params.remove_src_params =3D util_iov_pull_mem(iov,
> +                                       sizeof(*params.remove_src_params)=
);
> +               if (!params.remove_src_params)
> +                       return false;
> +
> +               break;
> +       case BT_BASS_REMOTE_SCAN_STOPPED:
> +       case BT_BASS_REMOTE_SCAN_STARTED:
> +               break;
> +       default:
> +               return true;
> +       }
> +
> +       if (iov->iov_len > 0)
> +               return false;
> +
> +       return true;
> +}
> +
> +static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *att=
rib,
> +                               unsigned int id, uint16_t offset,
> +                               const uint8_t *value, size_t len,
> +                               uint8_t opcode, struct bt_att *att,
> +                               void *user_data)
> +{
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *)value,
> +               .iov_len =3D len,
> +       };
> +
> +       /* Validate written command length */
> +       if (!bass_check_cp_command_len(&iov)) {
> +               if (opcode =3D=3D BT_ATT_OP_WRITE_REQ) {
> +                       gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ERROR_WRITE_REQUEST_REJECTED);
> +               }
> +               return;
> +       }
> +
> +       /* TODO: Implement handlers for the written opcodes */
> +       gatt_db_attribute_write_result(attrib, id,
> +                       BT_BASS_ERROR_OPCODE_NOT_SUPPORTED);
> +}
> +
> +static bool bass_src_match_attrib(const void *data, const void *match_da=
ta)
> +{
> +       const struct bt_bcast_src *bcast_src =3D data;
> +       const struct gatt_db_attribute *attr =3D match_data;
> +
> +       return (bcast_src->attr =3D=3D attr);
> +}
> +
> +static void bass_bcast_recv_state_read(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, struct bt_att *at=
t,
> +                                       void *user_data)
> +{
> +       struct bt_bass *bass =3D user_data;
> +       struct bt_bap *bap =3D bap_get_session(att, bass->bdb->db);
> +       uint8_t *rsp;
> +       size_t rsp_len;
> +       struct bt_bcast_src *bcast_src;
> +
> +       bcast_src =3D queue_find(bap->ldb->bass_bcast_srcs,
> +                                       bass_src_match_attrib,
> +                                       attrib);
> +
> +       if (!bcast_src) {
> +               gatt_db_attribute_read_result(attrib, id, 0, NULL,
> +                                                       0);
> +               return;
> +       }
> +
> +       /* Build read response */
> +       rsp =3D bass_build_read_rsp_from_bcast_src(bcast_src, &rsp_len);
> +
> +       if (!rsp) {
> +               gatt_db_attribute_read_result(attrib, id,
> +                                       BT_ATT_ERROR_UNLIKELY,
> +                                       NULL, 0);
> +               return;
> +       }
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, (void *)rsp,
> +                                               rsp_len);
> +
> +       free(rsp);
> +}
> +
> +static void bcast_recv_new(struct bt_bass *bass, int i)
> +{
> +       struct bt_bcast_recv_state *bcast_recv_state;
> +       bt_uuid_t uuid;
> +
> +       if (!bass)
> +               return;
> +
> +       bcast_recv_state =3D new0(struct bt_bcast_recv_state, 1);
> +       bcast_recv_state->bass =3D bass;
> +
> +       bt_uuid16_create(&uuid, BCAST_RECV_STATE_UUID);
> +       bcast_recv_state->attr =3D
> +               gatt_db_service_add_characteristic(bass->service, &uuid,
> +                               BT_ATT_PERM_READ | BT_ATT_PERM_READ_ENCRY=
PT,
> +                               BT_GATT_CHRC_PROP_READ |
> +                               BT_GATT_CHRC_PROP_NOTIFY,
> +                               bass_bcast_recv_state_read, NULL,
> +                               bass);
> +
> +       bcast_recv_state->ccc =3D gatt_db_service_add_ccc(bass->service,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE);
> +
> +       bass->bcast_recv_states[i] =3D bcast_recv_state;
> +}
> +
> +struct bt_bass *bass_new(struct gatt_db *db)
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
> +                                       3 + (NUM_BCAST_RECV_STATES * 3));
> +
> +       for (i =3D 0; i < NUM_BCAST_RECV_STATES; i++)
> +               bcast_recv_new(bass, i);
> +
> +       bt_uuid16_create(&uuid, BCAST_AUDIO_SCAN_CP_UUID);
> +       bass->bcast_audio_scan_cp =3D
> +               gatt_db_service_add_characteristic(bass->service,
> +                               &uuid,
> +                               BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_ENC=
RYPT,
> +                               BT_GATT_CHRC_PROP_WRITE,
> +                               NULL, bass_bcast_audio_scan_cp_write,
> +                               bass);
> +
> +       gatt_db_service_set_active(bass->service, true);
> +
> +       return bass;
> +}
> +
> +void bass_bcast_src_free(void *data)
> +{
> +       struct bt_bcast_src *bcast_src =3D data;
> +
> +       for (int i =3D 0; i < bcast_src->num_subgroups; i++)
> +               free(bcast_src->subgroup_data[i].meta);
> +
> +       free(bcast_src->subgroup_data);
> +       free(bcast_src);
> +}
> +
> +static void read_bcast_recv_state(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_bcast_src *bcast_src =3D user_data;
> +
> +       if (!success) {
> +               DBG(bcast_src->bap, "Unable to read "
> +                       "Broadcast Receive State: error 0x%02x",
> +                       att_ecode);
> +               return;
> +       }
> +
> +       if (length =3D=3D 0) {
> +               queue_remove(bcast_src->bap->rdb->bass_bcast_srcs, bcast_=
src);
> +               bass_bcast_src_free(bcast_src);
> +               return;
> +       }
> +
> +       if (bass_build_bcast_src_from_read_rsp(bcast_src, value, length))=
 {
> +               queue_remove(bcast_src->bap->rdb->bass_bcast_srcs, bcast_=
src);
> +               bass_bcast_src_free(bcast_src);
> +               return;
> +       }
> +}
> +
> +static void bcast_recv_state_notify(struct bt_bap *bap, uint16_t value_h=
andle,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct gatt_db_attribute *attr =3D user_data;
> +       struct bt_bcast_src *bcast_src;
> +       bool new_src =3D false;
> +
> +       bcast_src =3D queue_find(bap->rdb->bass_bcast_srcs,
> +                                       bass_src_match_attrib, attr);
> +       if (!bcast_src) {
> +               new_src =3D true;
> +               bcast_src =3D malloc(sizeof(*bcast_src));
> +
> +               if (!bcast_src) {
> +                       DBG(bap, "Failed to allocate "
> +                               "memory for broadcast source");
> +                       return;
> +               }
> +
> +               memset(bcast_src, 0, sizeof(struct bt_bcast_src));
> +               bcast_src->bap =3D bap;
> +               bcast_src->attr =3D attr;
> +       }
> +
> +       if (bass_build_bcast_src_from_notif(bcast_src, value, length)
> +                                               && new_src) {
> +               bass_bcast_src_free(bcast_src);
> +               return;
> +       }
> +
> +       if (new_src)
> +               queue_push_tail(bap->rdb->bass_bcast_srcs, bcast_src);
> +}
> +
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
> +static void foreach_bass_char(struct gatt_db_attribute *attr, void *user=
_data)
> +{
> +       struct bt_bap *bap =3D user_data;
> +       uint16_t value_handle;
> +       bt_uuid_t uuid, uuid_bcast_audio_scan_cp, uuid_bcast_recv_state;
> +       struct bt_bass *bass;
> +
> +       /* Get attribute value handle and uuid */
> +       if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
> +                                               NULL, NULL, &uuid))
> +               return;
> +
> +       bt_uuid16_create(&uuid_bcast_audio_scan_cp, BCAST_AUDIO_SCAN_CP_U=
UID);
> +       bt_uuid16_create(&uuid_bcast_recv_state, BCAST_RECV_STATE_UUID);
> +
> +       if (!bt_uuid_cmp(&uuid, &uuid_bcast_audio_scan_cp)) {
> +               /* Found Broadcast Audio Scan Control Point characteristi=
c */
> +               bass =3D bap_get_bass(bap);
> +
> +               if (!bass || bass->bcast_audio_scan_cp)
> +                       return;
> +
> +               /* Store characteristic reference */
> +               bass->bcast_audio_scan_cp =3D attr;
> +
> +               DBG(bap, "Broadcast Audio Scan Control Point "
> +                       "found: handle 0x%04x", value_handle);
> +       }
> +
> +       if (!bt_uuid_cmp(&uuid, &uuid_bcast_recv_state)) {
> +               /* Found Broadcast Receive State characteristic */
> +               struct bt_bcast_src *bcast_src =3D
> +                               queue_find(bap->rdb->bass_bcast_srcs,
> +                                               bass_src_match_attrib, at=
tr);
> +
> +               if (!bcast_src) {
> +                       bcast_src =3D malloc(sizeof(struct bt_bcast_src))=
;
> +
> +                       if (bcast_src =3D=3D NULL) {
> +                               DBG(bap, "Failed to allocate "
> +                                       "memory for broadcast source");
> +                               return;
> +                       }
> +
> +                       memset(bcast_src, 0, sizeof(struct bt_bcast_src))=
;
> +                       bcast_src->bap =3D bap;
> +                       bcast_src->attr =3D attr;
> +
> +                       queue_push_tail(bap->rdb->bass_bcast_srcs, bcast_=
src);
> +               }
> +
> +               bt_gatt_client_read_value(bap->client, value_handle,
> +                                               read_bcast_recv_state,
> +                                               bcast_src, NULL);
> +
> +               (void)bap_register_notify(bap, value_handle,
> +                                               bcast_recv_state_notify,
> +                                               attr);
> +
> +               DBG(bap, "Broadcast Receive State found: handle 0x%04x",
> +                                                       value_handle);
> +       }
> +}
> +
> +void foreach_bass_service(struct gatt_db_attribute *attr,
> +                                               void *user_data)
> +{
> +       struct bt_bap *bap =3D user_data;
> +       struct bt_bass *bass =3D bap_get_bass(bap);
> +
> +       /* Store BASS attribute reference */
> +       bass->service =3D attr;
> +
> +       /* Handle BASS attributes */
> +       gatt_db_service_foreach_char(attr, foreach_bass_char, bap);
> +}
> diff --git a/src/shared/bass.h b/src/shared/bass.h
> new file mode 100644
> index 000000000..8edd73502
> --- /dev/null
> +++ b/src/shared/bass.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright 2023 NXP
> + *
> + */
> +
> +#define NUM_BCAST_RECV_STATES                          2
> +#define BT_BASS_BCAST_CODE_SIZE                                16
> +#define BT_BASS_BIG_SYNC_FAILED_BITMASK                        0xFFFFFFF=
F
> +#define BT_BASS_BCAST_SRC_LEN                          15
> +#define BT_BASS_BCAST_SRC_SUBGROUP_LEN                 5
> +
> +/* Application error codes */
> +#define BT_BASS_ERROR_OPCODE_NOT_SUPPORTED             0x80
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
> +/* BASS subgroup field of the Broadcast
> + * Receive State characteristic
> + */
> +struct bt_bass_subgroup_data {
> +       uint32_t bis_sync;
> +       uint32_t pending_bis_sync;
> +       uint8_t meta_len;
> +       uint8_t *meta;
> +};
> +
> +/* BASS Broadcast Source structure */
> +struct bt_bcast_src {
> +       struct bt_bap *bap;
> +       struct gatt_db_attribute *attr;
> +       uint8_t id;
> +       uint8_t addr_type;
> +       bdaddr_t addr;
> +       uint8_t sid;
> +       uint32_t bid;
> +       uint8_t sync_state;
> +       uint8_t enc;
> +       uint8_t bad_code[BT_BASS_BCAST_CODE_SIZE];
> +       uint8_t num_subgroups;
> +       struct bt_bass_subgroup_data *subgroup_data;
> +};
> +
> +/* Broadcast Receive State characteristic structure */
> +struct bt_bcast_recv_state {
> +       struct bt_bass *bass;
> +       struct gatt_db_attribute *attr;
> +       struct gatt_db_attribute *ccc;
> +};
> +
> +/* BASS instance structure */
> +struct bt_bass {
> +       struct bt_bap_db *bdb;
> +       struct gatt_db_attribute *service;
> +       struct gatt_db_attribute *bcast_audio_scan_cp;
> +       struct bt_bcast_recv_state *bcast_recv_states[NUM_BCAST_RECV_STAT=
ES];
> +};
> +
> +/* Broadcast Audio Scan Control Point
> + * header structure
> + */
> +struct bt_bass_bcast_audio_scan_cp_hdr {
> +       uint8_t op;
> +} __packed;
> +
> +#define BT_BASS_REMOTE_SCAN_STOPPED                    0x00
> +
> +#define BT_BASS_REMOTE_SCAN_STARTED                    0x01
> +
> +#define BT_BASS_ADD_SRC                                        0x02
> +
> +struct bt_bass_add_src_params {
> +       uint8_t addr_type;
> +       bdaddr_t addr;
> +       uint8_t sid;
> +       uint8_t bid[3];
> +       uint8_t pa_sync;
> +       uint16_t pa_interval;
> +       uint8_t num_subgroups;
> +       uint8_t subgroup_data[];
> +} __packed;
> +
> +#define BT_BASS_MOD_SRC                                        0x03
> +
> +struct bt_bass_mod_src_params {
> +       uint8_t id;
> +       uint8_t pa_sync;
> +       uint16_t pa_interval;
> +       uint8_t num_subgroups;
> +       uint8_t subgroup_data[];
> +} __packed;
> +
> +#define BT_BASS_SET_BCAST_CODE                         0x04
> +
> +struct bt_bass_set_bcast_code_params {
> +       uint8_t id;
> +       uint8_t bcast_code[BT_BASS_BCAST_CODE_SIZE];
> +} __packed;
> +
> +#define BT_BASS_REMOVE_SRC                             0x05
> +
> +struct bt_bass_remove_src_params {
> +       uint8_t id;
> +} __packed;
> +
> +struct bt_bass *bass_new(struct gatt_db *db);
> +void bass_bcast_src_free(void *data);
> +void foreach_bass_service(struct gatt_db_attribute *attr,
> +                                               void *user_data);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
