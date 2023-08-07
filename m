Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D21FC001DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjHGRut (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHGRur (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 13:50:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE4DF9
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 10:50:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so7085913e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Aug 2023 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691430642; x=1692035442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtWEijEhbeVCKOqPthJhn1mX3e57dFYQYFzvo/BG7AQ=;
        b=i/aa6jhEUKCisfThXqohYaGOAI9LoAvGP2oA9q+PC8CK53aPeq8BoQ5pnadKv4K1O5
         phe7Z3kZr6sm9R6YPgh7M1XLvSNym3HzRnVXG+VJZr1QuJZ4pZF+TpRUFJi/eY7QF6Vb
         rj7Y0IeoVKG//P+KvdCMtsFPcwuxUg2aU0wxLBen5ULsNNrCKGa5oAe+0D8wPWzRHDM/
         ItfLSeDJxDIqdOvYSGEPCooNlsOWbtQLaNyoVP4jqB7JB+AkADsQgLYbBcVtmMbnIPd9
         thEnaTe/IEttLaie+qcpxldnBqS33QXYwnerNYF8ZesoFGiN+01joQ5J1zFxq/dMdnoM
         sKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691430642; x=1692035442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtWEijEhbeVCKOqPthJhn1mX3e57dFYQYFzvo/BG7AQ=;
        b=WZsFWRixSjd0rPHvJKTa4g36pmM6b2gZUzOrH6qZJgjqVkeOlQQQF/iPOVDHjl8PMR
         ZGALfexEILzeqBgjaKZRhsPtL+QzzWY705tY4dHzf2GfosJxO2Lfh9RGGdvrNknK7IuN
         TCzd2iWnMOffA4ohnGvHx2JAML2h1GK3Z5/c6o7reo9mVRBrQu44Oese+Af6dMZ9Z+AL
         J9CDS8meRpFRj9vg8QX44yXvotCtY13atbKD9CrpzT5Mb+EbwWaxp0IS/DtS4vXNOiB8
         Mf8PgnVBTlVcVUslyRX+X9cJuwhMOdwMU2dthY3wquRsWhovaCwuGvmmC0CCxQ8vllsn
         VYdg==
X-Gm-Message-State: AOJu0YyQvR8P0s/Ms3l2LnVEVbeTWem/Q6tv5Rgs+vPIAG5LPk1/Sltv
        ADTSkRzzJoqN8ji39Pi2eOhCxYBvuzgPlaYQHzMkWEQ+
X-Google-Smtp-Source: AGHT+IHQapMkTvYIyVZzIIDiDiAwDQrMMxPdzIgrFMGuW2txBtStUWx3WKWu+lyf83kWQ9+yi/nVHhSfyW9Q7ZjylCc=
X-Received: by 2002:a2e:b784:0:b0:2b6:f85a:20af with SMTP id
 n4-20020a2eb784000000b002b6f85a20afmr2474079ljo.4.1691430641521; Mon, 07 Aug
 2023 10:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230803072011.191449-1-mahesh.talewad@nxp.com> <20230803072011.191449-2-mahesh.talewad@nxp.com>
In-Reply-To: <20230803072011.191449-2-mahesh.talewad@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Aug 2023 10:50:29 -0700
Message-ID: <CABBYNZ+TFMYM1JC_YWHm48tPBBU3a3WPN-W5GUYOx-Bnr3vmng@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/3] shared/micp: Add initial code for handling
 micp and mics
To:     Mahesh Talewad <mahesh.talewad@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mahesh,

On Thu, Aug 3, 2023 at 12:20=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.=
com> wrote:
>
> - This commit is for implementations of MICS and MICP
> - Specifications referred for implementation:
> MICS - MICS_v1.0.pdf
> MICP - MICP_v1.0.pdf
> ---
>  Makefile.am           |   1 +
>  Makefile.plugins      |   5 +
>  configure.ac          |   4 +
>  lib/uuid.h            |   4 +
>  profiles/audio/micp.c | 340 ++++++++++++++++
>  src/shared/micp.c     | 922 ++++++++++++++++++++++++++++++++++++++++++
>  src/shared/micp.h     |  46 +++
>  7 files changed, 1322 insertions(+)
>  create mode 100644 profiles/audio/micp.c
>  create mode 100644 src/shared/micp.c
>  create mode 100644 src/shared/micp.h
>
> diff --git a/Makefile.am b/Makefile.am
> index 4b9b7e5cd..6f40f2a74 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -233,6 +233,7 @@ shared_sources =3D src/shared/io.h src/shared/timeout=
.h \
>                         src/shared/bap.h src/shared/bap.c src/shared/ascs=
.h \
>                         src/shared/mcs.h src/shared/mcp.h src/shared/mcp.=
c \
>                         src/shared/vcp.c src/shared/vcp.h \
> +                       src/shared/micp.c src/shared/micp.h \

Please split the changes adding micp.c and micp.h to shared to the
micp plugin, they are 2 very distinct instances so there is no reason
to keep them together.

>                         src/shared/csip.c src/shared/csip.h \
>                         src/shared/bass.h src/shared/bass.c \
>                         src/shared/lc3.h src/shared/tty.h
> diff --git a/Makefile.plugins b/Makefile.plugins
> index fc19522e4..5880ed0df 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -137,6 +137,11 @@ builtin_modules +=3D vcp
>  builtin_sources +=3D profiles/audio/vcp.c
>  endif
>
> +if MICP
> +builtin_modules +=3D micp
> +builtin_sources +=3D profiles/audio/micp.c
> +endif
> +
>  if CSIP
>  builtin_modules +=3D csip
>  builtin_sources +=3D profiles/audio/csip.c
> diff --git a/configure.ac b/configure.ac
> index bc7edfcd3..9a8856380 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -211,6 +211,10 @@ AC_ARG_ENABLE(vcp, AS_HELP_STRING([--disable-vcp],
>                 [disable VCP profile]), [enable_vcp=3D${enableval}])
>  AM_CONDITIONAL(VCP, test "${enable_vcp}" !=3D "no")
>
> +AC_ARG_ENABLE(micp, AS_HELP_STRING([--disable-micp],
> +               [disable MICP profile]), [enable_micp=3D${enableval}])
> +AM_CONDITIONAL(MICP, test "${enable_micp}" !=3D "no")
> +
>  AC_ARG_ENABLE(csip, AS_HELP_STRING([--disable-csip],
>                 [disable CSIP profile]), [enable_csip=3D${enableval}])
>  AM_CONDITIONAL(CSIP, test "${enable_csip}" !=3D "no")
> diff --git a/lib/uuid.h b/lib/uuid.h
> index cd3b3655f..6661a537f 100644
> --- a/lib/uuid.h
> +++ b/lib/uuid.h
> @@ -206,6 +206,10 @@ extern "C" {
>  #define CS_LOCK                                                0x2B86
>  #define CS_RANK                                                0x2B87
>
> +/* Microphone Control Service(MICS) */
> +#define MICS_UUID                      0x184D
> +#define MUTE_CHRC_UUID         0x2BC3
> +
>  typedef struct {
>         enum {
>                 BT_UUID_UNSPEC =3D 0,
> diff --git a/profiles/audio/micp.c b/profiles/audio/micp.c
> new file mode 100644
> index 000000000..452027c75
> --- /dev/null
> +++ b/profiles/audio/micp.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
> + *
> + *
> + */
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define        _GNU_SOURCE
> +
> +#include <ctype.h>
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +
> +#include "gdbus/gdbus.h"
> +
> +#include "lib/bluetooth.h"
> +#include "lib/hci.h"
> +#include "lib/sdp.h"
> +#include "lib/uuid.h"
> +
> +#include "src/dbus-common.h"
> +#include "src/shared/util.h"
> +#include "src/shared/att.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/gatt-server.h"
> +#include "src/shared/micp.h"
> +
> +#include "btio/btio.h"
> +#include "src/plugin.h"
> +#include "src/adapter.h"
> +#include "src/gatt-database.h"
> +#include "src/device.h"
> +#include "src/profile.h"
> +#include "src/service.h"
> +#include "src/log.h"
> +#include "src/error.h"
> +
> +#define MICS_UUID_STR  "0000184D-0000-1000-8000-00805f9b34fb"
> +
> +struct micp_data {
> +       struct btd_device *device;
> +       struct btd_service *service;
> +       struct bt_micp *micp;
> +       unsigned int ready_id;
> +};
> +
> +static struct queue *sessions;
> +
> +static void micp_debug(const char *str, void *user_data)
> +{
> +       DBG_IDX(0xffff, "%s", str);
> +}
> +
> +static int micp_disconnect(struct btd_service *service)
> +{
> +       return 0;
> +}
> +
> +static struct micp_data *micp_data_new(struct btd_device *device)
> +{
> +       struct micp_data *data;
> +
> +       data =3D new0(struct micp_data, 1);
> +       g_assert(data);
> +       data->device =3D device;
> +
> +       return data;
> +}
> +
> +static void micp_data_add(struct micp_data *data)
> +{
> +       DBG("data %p", data);
> +
> +       if (queue_find(sessions, NULL, data)) {
> +               error("data %p allready added", data);
> +               return;
> +       }
> +
> +       bt_micp_set_debug(data->micp, micp_debug, NULL, NULL);
> +
> +       if (!sessions)
> +               sessions =3D queue_new();
> +
> +       queue_push_tail(sessions, data);
> +
> +       if (data->service)
> +               btd_service_set_user_data(data->service, data);
> +}
> +
> +static bool match_data(const void *data, const void *match_data)
> +{
> +       const struct micp_data *mdata =3D data;
> +       const struct bt_micp *micp =3D match_data;
> +
> +       return mdata->micp =3D=3D micp;
> +}
> +
> +static void micp_data_free(struct micp_data *data)
> +{
> +       if (data->service) {
> +               btd_service_set_user_data(data->service, NULL);
> +               bt_micp_set_user_data(data->micp, NULL);
> +       }
> +
> +       bt_micp_ready_unregister(data->micp, data->ready_id);
> +       bt_micp_unref(data->micp);
> +       free(data);
> +}
> +
> +static void micp_data_remove(struct micp_data *data)
> +{
> +       DBG("data %p", data);
> +
> +       if (!queue_remove(sessions, data))
> +               return;
> +
> +       micp_data_free(data);
> +
> +       if (queue_isempty(sessions)) {
> +               queue_destroy(sessions, NULL);
> +               sessions =3D NULL;
> +       }
> +}
> +
> +static void micp_detached(struct bt_micp *micp, void *user_data)
> +{
> +       struct micp_data *data;
> +
> +       DBG("%p", micp);
> +
> +       data =3D queue_find(sessions, match_data, micp);
> +       if (!data) {
> +               error("unable to find sessio");
> +               return;
> +       }
> +
> +       micp_data_remove(data);
> +}
> +
> +static void micp_ready(struct bt_micp *micp, void *user_data)
> +{
> +       DBG("micp %p\n", micp);
> +}
> +
> +static void micp_attached(struct bt_micp *micp, void *user_data)
> +{
> +       struct micp_data *data;
> +       struct bt_att *att;
> +       struct btd_device *device;
> +
> +       DBG("%p", micp);
> +
> +       data =3D queue_find(sessions, match_data, micp);
> +       if (data)
> +               return;
> +
> +       att =3D bt_micp_get_att(micp);
> +       if (!att)
> +               return;
> +
> +       device =3D btd_adapter_find_device_by_fd(bt_att_get_fd(att));
> +       if (!device) {
> +               error("unable to find device");
> +               return;
> +       }
> +
> +       data =3D micp_data_new(device);
> +       g_assert(data);
> +       data->micp =3D micp;
> +
> +       micp_data_add(data);
> +}
> +
> +static int micp_probe(struct btd_service *service)
> +{
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       struct btd_adapter *adapter =3D device_get_adapter(device);
> +       struct btd_gatt_database *database =3D btd_adapter_get_database(a=
dapter);
> +       struct micp_data *data =3D btd_service_get_user_data(service);
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("%s", addr);
> +
> +       /*Ignore, if we probed for this device allready */
> +       if (data) {
> +               error("Profile probed twice for this device");
> +               return -EINVAL;
> +       }
> +
> +       data =3D micp_data_new(device);
> +       data->service =3D service;
> +
> +       data->micp =3D bt_micp_new(btd_gatt_database_get_db(database),
> +                                       btd_device_get_gatt_db(device));
> +
> +       if (!data->micp) {
> +               error("unable to create MICP instance");
> +               free(data);
> +               return -EINVAL;
> +       }
> +
> +       micp_data_add(data);
> +
> +       data->ready_id =3D bt_micp_ready_register(data->micp, micp_ready,=
 service,
> +                                                               NULL);
> +
> +       bt_micp_set_user_data(data->micp, service);
> +
> +       return 0;
> +}
> +
> +static void micp_remove(struct btd_service *service)
> +{
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       struct micp_data *data;
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("%s", addr);
> +
> +       data =3D btd_service_get_user_data(service);
> +       if (!data) {
> +               error("MICP Service not handled by profile");
> +               return;
> +       }
> +
> +       micp_data_remove(data);
> +}
> +
> +static int micp_accept(struct btd_service *service)
> +{
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       struct bt_gatt_client *client =3D btd_device_get_gatt_client(devi=
ce);
> +       struct micp_data *data =3D btd_service_get_user_data(service);
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("%s", addr);
> +
> +       if (!data) {
> +               error("MICP Service not handled by profile");
> +               return -EINVAL;
> +       }
> +
> +       if (!bt_micp_attach(data->micp, client)) {
> +               error("MICP unable to attach");
> +               return -EINVAL;
> +       }
> +
> +       btd_service_connecting_complete(service, 0);
> +
> +       return 0;
> +}
> +
> +static int micp_connect(struct btd_service *service)
> +{
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("%s", addr);
> +
> +       return 0;
> +}
> +
> +static int micp_server_probe(struct btd_profile *p,
> +                               struct btd_adapter *adapter)
> +{
> +       struct btd_gatt_database *database =3D btd_adapter_get_database(a=
dapter);
> +
> +       DBG("MICP path %s", adapter_get_path(adapter));
> +
> +       bt_micp_add_db(btd_gatt_database_get_db(database));
> +
> +       return 0;
> +}
> +
> +static void micp_server_remove(struct btd_profile *p,
> +                                       struct btd_adapter *adapter)
> +{
> +       DBG("MICP remove adapter");
> +}
> +
> +static struct btd_profile micp_profile =3D {
> +       .name           =3D "micp",
> +       .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .remote_uuid    =3D MICS_UUID_STR,
> +
> +       .device_probe   =3D micp_probe,
> +       .device_remove  =3D micp_remove,
> +
> +       .accept =3D micp_accept,
> +       .connect        =3D micp_connect,
> +       .disconnect     =3D micp_disconnect,
> +
> +       .adapter_probe  =3D micp_server_probe,
> +       .adapter_remove =3D micp_server_remove,
> +};
> +
> +static unsigned int micp_id;
> +
> +static int micp_init(void)
> +{
> +       if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
> +               warn("D-Bus experimental not enabled");
> +               return -ENOTSUP;
> +       }
> +
> +       btd_profile_register(&micp_profile);
> +       micp_id =3D bt_micp_register(micp_attached, micp_detached, NULL);
> +
> +       return 0;
> +}
> +
> +static void micp_exit(void)
> +{
> +       if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
> +               btd_profile_unregister(&micp_profile);
> +               bt_micp_unregister(micp_id);
> +       }
> +}
> +
> +BLUETOOTH_PLUGIN_DEFINE(micp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT=
,
> +                                                       micp_init, micp_e=
xit)
> diff --git a/src/shared/micp.c b/src/shared/micp.c
> new file mode 100644
> index 000000000..25ffa6940
> --- /dev/null
> +++ b/src/shared/micp.c
> @@ -0,0 +1,922 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
> + *
> + */
> +#define _GNU_SOURCE
> +#include <inttypes.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <errno.h>
> +
> +#include "lib/bluetooth.h"
> +#include "lib/uuid.h"
> +
> +#include "src/shared/queue.h"
> +#include "src/shared/util.h"
> +#include "src/shared/timeout.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/gatt-server.h"
> +#include "src/shared/gatt-helpers.h"
> +#include "src/shared/micp.h"
> +
> +#define DBG(_micp, fmt, arg...) \
> +       micp_debug(_micp, "%s:%s() " fmt, __FILE__, __func__, ##arg)
> +
> +/* Application error codes */
> +#define MICP_ERROR_MUTE_DISABLED            0x80
> +#define MICP_ERROR_VALUE_NOT_ALLOWED        0x13
> +#define BT_ATT_ERROR_OPCODE_NOT_SUPPORTED   0x81
> +
> +/* Mute char values */
> +#define MICS_NOT_MUTED  0x00
> +#define MICS_MUTED      0x01
> +#define MICS_DISABLED   0x02
> +
> +struct bt_micp_db {
> +       struct gatt_db *db;
> +       struct bt_mics *mics;
> +};
> +
> +struct bt_mics {
> +       struct bt_micp_db *mdb;
> +       uint8_t mute_stat;
> +       struct gatt_db_attribute *service;
> +       struct gatt_db_attribute *ms;
> +       struct gatt_db_attribute *ms_ccc;
> +};
> +
> +struct bt_micp {
> +       int ref_count;
> +       struct bt_micp_db *ldb;
> +       struct bt_micp_db *rdb;
> +       struct bt_gatt_client *client;
> +       struct bt_att *att;
> +       unsigned int mute_id;
> +
> +       unsigned int idle_id;
> +       uint8_t mute;
> +
> +       struct queue *notify;
> +       struct queue *pending;
> +       struct queue *ready_cbs;
> +
> +       bt_micp_debug_func_t debug_func;
> +       bt_micp_destroy_func_t debug_destroy;
> +
> +       void *debug_data;
> +       void *user_data;
> +};
> +
> +static struct queue *micp_db;
> +static struct queue *micp_cbs;
> +static struct queue *sessions;
> +
> +struct bt_micp_cb {
> +       unsigned int id;
> +       bt_micp_func_t attached;
> +       bt_micp_func_t detached;
> +       void *user_data;
> +};
> +
> +typedef void (*micp_func_t)(struct bt_micp *micp, bool success,
> +                               uint8_t att_ecode, const uint8_t *value,
> +                               uint16_t length, void *user_data);
> +
> +struct bt_micp_pending {
> +       unsigned int id;
> +       struct bt_micp *micp;
> +       micp_func_t func;
> +       void *userdata;
> +};
> +
> +struct bt_micp_ready {
> +       unsigned int id;
> +       bt_micp_ready_func_t func;
> +       bt_micp_destroy_func_t destroy;
> +       void *data;
> +};
> +
> +typedef void (*micp_notify_t)(struct bt_micp *micp, uint16_t value_handl=
e,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data);
> +
> +struct bt_micp_notify {
> +       unsigned int id;
> +       struct bt_micp *micp;
> +       micp_notify_t func;
> +       void *user_data;
> +};
> +
> +static void *iov_pull_mem(struct iovec *iov, size_t len)
> +{
> +       void *data =3D iov->iov_base;
> +
> +       if (iov->iov_len < len)
> +               return NULL;
> +
> +       iov->iov_base +=3D len;
> +       iov->iov_len -=3D len;
> +
> +       return data;
> +}
> +
> +static struct bt_micp_db *micp_get_mdb(struct bt_micp *micp)
> +{
> +       if (!micp)
> +               return NULL;
> +
> +       if (micp->ldb)
> +               return micp->ldb;
> +
> +       return NULL;
> +}
> +
> +static uint8_t *mdb_get_mute_state(struct bt_micp_db *vdb)
> +{
> +       if (!vdb->mics)
> +               return NULL;
> +
> +       return &(vdb->mics->mute_stat);
> +}
> +
> +static struct bt_mics *micp_get_mics(struct bt_micp *micp)
> +{
> +       if (!micp)
> +               return NULL;
> +
> +       if (micp->rdb->mics)
> +               return micp->rdb->mics;
> +
> +       micp->rdb->mics =3D new0(struct bt_mics, 1);
> +       micp->rdb->mics->mdb =3D micp->rdb;
> +
> +       return micp->rdb->mics;
> +}
> +
> +static void micp_detached(void *data, void *user_data)
> +{
> +       struct bt_micp_cb *cb =3D data;
> +       struct bt_micp *micp =3D user_data;
> +
> +       cb->detached(micp, cb->user_data);
> +}
> +
> +void bt_micp_detach(struct bt_micp *micp)
> +{
> +       if (!queue_remove(sessions, micp))
> +               return;
> +
> +       bt_gatt_client_unref(micp->client);
> +       micp->client =3D NULL;
> +
> +       queue_foreach(micp_cbs, micp_detached, micp);
> +}
> +
> +static void micp_db_free(void *data)
> +{
> +       struct bt_micp_db *mdb =3D data;
> +
> +       if (!mdb)
> +               return;
> +
> +       gatt_db_unref(mdb->db);
> +
> +       free(mdb->mics);
> +       free(mdb);
> +}
> +
> +static void micp_ready_free(void *data)
> +{
> +       struct bt_micp_ready *ready =3D data;
> +
> +       if (ready->destroy)
> +               ready->destroy(ready->data);
> +
> +       free(ready);
> +}
> +
> +static void micp_free(void *data)
> +{
> +       struct bt_micp *micp =3D data;
> +
> +       bt_micp_detach(micp);
> +
> +       micp_db_free(micp->rdb);
> +
> +       queue_destroy(micp->pending, NULL);
> +       queue_destroy(micp->ready_cbs, micp_ready_free);
> +
> +       free(micp);
> +}
> +
> +bool bt_micp_set_user_data(struct bt_micp *micp, void *user_data)
> +{
> +
> +       if (!micp)
> +               return false;
> +
> +       micp->user_data =3D user_data;
> +
> +       return true;
> +}
> +
> +static bool micp_db_match(const void *data, const void *match_data)
> +{
> +       const struct bt_micp_db *mdb =3D data;
> +       const struct gatt_db *db =3D match_data;
> +
> +       return (mdb->db =3D=3D db);
> +}
> +
> +struct bt_att *bt_micp_get_att(struct bt_micp *micp)
> +{
> +       if (!micp)
> +               return NULL;
> +
> +       if (micp->att)
> +               return micp->att;
> +
> +       return bt_gatt_client_get_att(micp->client);
> +}
> +
> +struct bt_micp *bt_micp_ref(struct bt_micp *micp)
> +{
> +       if (!micp)
> +               return NULL;
> +
> +       __sync_fetch_and_add(&micp->ref_count, 1);
> +
> +       return micp;
> +}
> +
> +void bt_micp_unref(struct bt_micp *micp)
> +{
> +       if (!micp)
> +               return;
> +
> +       if (__sync_sub_and_fetch(&micp->ref_count, 1))
> +               return;
> +
> +       micp_free(micp);
> +}
> +
> +static void micp_debug(struct bt_micp *micp, const char *format, ...)
> +{
> +       va_list ap;
> +
> +       if (!micp || !format || !micp->debug_func)
> +               return;
> +
> +       va_start(ap, format);
> +       util_debug_va(micp->debug_func, micp->debug_data, format, ap);
> +       va_end(ap);
> +}
> +
> +static void micp_disconnected(int err, void *user_data)
> +{
> +       struct bt_micp *micp =3D user_data;
> +
> +       DBG(micp, "micp %p disconnected err %d", micp, err);
> +
> +       bt_micp_detach(micp);
> +}
> +
> +static struct bt_micp *micp_get_session(struct bt_att *att, struct gatt_=
db *db)
> +{
> +       const struct queue_entry *entry;
> +       struct bt_micp *micp;
> +
> +       for (entry =3D queue_get_entries(sessions); entry; entry =3D entr=
y->next) {
> +               struct bt_micp *micp =3D entry->data;
> +
> +               if (att =3D=3D bt_micp_get_att(micp))
> +                       return micp;
> +       }
> +
> +       micp =3D bt_micp_new(db, NULL);
> +       micp->att =3D att;
> +
> +       bt_att_register_disconnect(att, micp_disconnected, micp, NULL);
> +
> +       bt_micp_attach(micp, NULL);
> +
> +       return micp;
> +}
> +
> +static void mics_mute_read(struct gatt_db_attribute *attrib,
> +                       unsigned int id, uint16_t offset,
> +                       uint8_t opcode, struct bt_att *att,
> +                       void *user_data)
> +{
> +       struct bt_mics *mics =3D user_data;
> +       struct iovec iov;
> +
> +       iov.iov_base =3D &mics->mute_stat;
> +       iov.iov_len =3D sizeof(mics->mute_stat);
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> +                                                                 iov.iov=
_len);
> +}
> +
> +static uint8_t mics_not_muted(struct bt_mics *mics, struct bt_micp *micp=
,
> +                                                         struct iovec *i=
ov)
> +{
> +       struct bt_micp_db *mdb;
> +       uint8_t *mute_state;
> +
> +       DBG(micp, "Mute state OP: Not Muted");
> +
> +       mdb =3D micp_get_mdb(micp);
> +       if (!mdb) {
> +               DBG(micp, "error: MDB not available");
> +               return 0;
> +       }
> +
> +       mute_state =3D mdb_get_mute_state(mdb);
> +       if (!mute_state) {
> +               DBG(micp, "Error : Mute State not available");
> +               return 0;
> +       }
> +
> +       *mute_state =3D MICS_NOT_MUTED;
> +
> +       gatt_db_attribute_notify(mdb->mics->ms, (void *)mute_state,
> +                               sizeof(uint8_t), bt_micp_get_att(micp));
> +
> +       return 0;
> +}
> +
> +static uint8_t mics_muted(struct bt_mics *mics, struct bt_micp *micp,
> +                                                 struct iovec *iov)
> +{
> +       struct bt_micp_db *mdb;
> +       uint8_t *mute_state;
> +
> +       DBG(micp, "Mute state OP: Muted");
> +
> +       mdb =3D micp_get_mdb(micp);
> +       if (!mdb) {
> +               DBG(micp, "error: MDB not available");
> +               return 0;
> +       }
> +
> +       mute_state =3D mdb_get_mute_state(mdb);
> +
> +       *mute_state =3D MICS_MUTED;
> +
> +       gatt_db_attribute_notify(mdb->mics->ms, (void *)mute_state,
> +                               sizeof(uint8_t), bt_micp_get_att(micp));
> +
> +       return 0;
> +}
> +
> +#define MICS_OP(_str, _op, _size, _func) \
> +       {                                    \
> +               .str =3D _str,                     \
> +               .op =3D _op,                       \
> +               .size =3D _size,                   \
> +               .func =3D _func,                   \
> +       }
> +
> +struct mics_op_handler {
> +       const char *str;
> +       uint8_t op;
> +       size_t size;
> +       uint8_t (*func)(struct bt_mics *mics, struct bt_micp *micp,
> +                                       struct iovec *iov);
> +} micp_handlers[] =3D {
> +       MICS_OP("Not Muted", MICS_NOT_MUTED,
> +                       sizeof(uint8_t), mics_not_muted),
> +       MICS_OP("Muted", MICS_MUTED,
> +                       sizeof(uint8_t), mics_muted),
> +       {}};
> +
> +static void mics_mute_write(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, struct bt_att *at=
t,
> +                                       void *user_data)
> +{
> +       struct bt_mics *mics =3D user_data;
> +       struct bt_micp *micp =3D micp_get_session(att, mics->mdb->db);
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *)value,
> +               .iov_len =3D len,
> +       };
> +       uint8_t *micp_op, *mute_state;
> +       struct mics_op_handler *handler;
> +       uint8_t ret =3D BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
> +       struct bt_micp_db *mdb;
> +
> +       DBG(micp, "MICS Mute Char write: len: %ld: %ld", len, iov.iov_len=
);
> +
> +       if (offset) {
> +               DBG(micp, "invalid offset: %d", offset);
> +               ret =3D BT_ATT_ERROR_INVALID_OFFSET;
> +               goto respond;
> +       }
> +
> +       if (len < sizeof(*micp_op)) {
> +               DBG(micp, "invalid length: %ld < %ld sizeof(param)", len,
> +                       sizeof(*micp_op));
> +               ret =3D BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
> +               goto respond;
> +       }
> +
> +       micp_op =3D iov_pull_mem(&iov, sizeof(*micp_op));
> +
> +       if ((*micp_op =3D=3D MICS_DISABLED) || (*micp_op !=3D MICS_NOT_MU=
TED
> +               && *micp_op !=3D MICS_MUTED)) {
> +               DBG(micp, "Invalid operation - MICS DISABLED/RFU mics op:=
%d",
> +                                       micp_op);
> +               ret =3D MICP_ERROR_VALUE_NOT_ALLOWED;
> +               goto respond;
> +       }
> +
> +       mdb =3D micp_get_mdb(micp);
> +       if (!mdb) {
> +               DBG(micp, "error: MDB not available");
> +               goto respond;
> +       }
> +
> +       mute_state =3D mdb_get_mute_state(mdb);
> +       if (*mute_state =3D=3D MICS_DISABLED) {
> +               DBG(micp, "state: MICS DISABLED , can not write value: %d=
",
> +                               *micp_op);
> +               ret =3D MICP_ERROR_MUTE_DISABLED;
> +               goto respond;
> +       }
> +
> +       for (handler =3D micp_handlers; handler && handler->str; handler+=
+) {
> +               DBG(micp, "handler->op: %d micp_op: %d iov.iov_len: %ld",
> +                                       handler->op, *micp_op, iov.iov_le=
n);
> +               if (handler->op !=3D *micp_op)
> +                       continue;
> +
> +               if (len < handler->size) {
> +                       DBG(micp, "invalid len %ld : %ld < %ld handler->s=
ize",
> +                       len, iov.iov_len, handler->size);
> +                       ret =3D BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
> +                       goto respond;
> +               }
> +
> +               break;
> +       }
> +
> +       if (handler && handler->str) {
> +               DBG(micp, "%s", handler->str);
> +
> +               ret =3D handler->func(mics, micp, &iov);
> +       } else {
> +               DBG(micp, "unknown opcode 0x%02x", *micp_op);
> +               ret =3D BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
> +       }
> +
> +respond:
> +       gatt_db_attribute_write_result(attrib, id, ret);
> +}
> +
> +static struct bt_mics *mics_new(struct gatt_db *db)
> +{
> +       struct bt_mics *mics;
> +       bt_uuid_t uuid;
> +
> +       if (!db)
> +               return NULL;
> +
> +       mics =3D new0(struct bt_mics, 1);
> +
> +       mics->mute_stat =3D MICS_MUTED;
> +
> +       /* Populate DB with MICS attributes */
> +       bt_uuid16_create(&uuid, MICS_UUID);
> +       mics->service =3D gatt_db_add_service(db, &uuid, true, 4);
> +
> +       bt_uuid16_create(&uuid, MUTE_CHRC_UUID);
> +       mics->ms =3D gatt_db_service_add_characteristic(mics->service,
> +                               &uuid,
> +                               BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> +                               BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PRO=
P_WRITE
> +                               | BT_GATT_CHRC_PROP_NOTIFY,
> +                               mics_mute_read, mics_mute_write,
> +                               mics);
> +
> +       mics->ms_ccc =3D gatt_db_service_add_ccc(mics->service,
> +                               BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       gatt_db_service_set_active(mics->service, true);
> +
> +       return mics;
> +}
> +
> +static struct bt_micp_db *micp_db_new(struct gatt_db *db)
> +{
> +       struct bt_micp_db *mdb;
> +
> +       if (!db)
> +               return NULL;
> +
> +       mdb =3D new0(struct bt_micp_db, 1);
> +       mdb->db =3D gatt_db_ref(db);
> +
> +       if (!micp_db)
> +               micp_db =3D queue_new();
> +
> +       mdb->mics =3D mics_new(db);
> +       mdb->mics->mdb =3D mdb;
> +
> +       queue_push_tail(micp_db, mdb);
> +
> +       return mdb;
> +}
> +
> +static struct bt_micp_db *micp_get_db(struct gatt_db *db)
> +{
> +       struct bt_micp_db *mdb;
> +
> +       mdb =3D queue_find(micp_db, micp_db_match, db);
> +       if (mdb)
> +               return mdb;
> +
> +       return micp_db_new(db);
> +}
> +
> +void bt_micp_add_db(struct gatt_db *db)
> +{
> +       micp_db_new(db);
> +}
> +
> +bool bt_micp_set_debug(struct bt_micp *micp, bt_micp_debug_func_t func,
> +                       void *user_data, bt_micp_destroy_func_t destroy)
> +{
> +       if (!micp)
> +               return false;
> +
> +       if (micp->debug_destroy)
> +               micp->debug_destroy(micp->debug_data);
> +
> +       micp->debug_func =3D func;
> +       micp->debug_destroy =3D destroy;
> +       micp->debug_data =3D user_data;
> +
> +       return true;
> +}
> +
> +unsigned int bt_micp_register(bt_micp_func_t attached, bt_micp_func_t de=
tached,
> +                                                         void *user_data=
)
> +{
> +       struct bt_micp_cb *cb;
> +       static unsigned int id;
> +
> +       if (!attached && !detached)
> +               return 0;
> +
> +       if (!micp_cbs)
> +               micp_cbs =3D queue_new();
> +
> +       cb =3D new0(struct bt_micp_cb, 1);
> +       cb->id =3D ++id ? id : ++id;
> +       cb->attached =3D attached;
> +       cb->detached =3D detached;
> +       cb->user_data =3D user_data;
> +
> +       queue_push_tail(micp_cbs, cb);
> +
> +       return cb->id;
> +}
> +
> +static bool match_id(const void *data, const void *match_data)
> +{
> +       const struct bt_micp_cb *cb =3D data;
> +       unsigned int id =3D PTR_TO_UINT(match_data);
> +
> +       return (cb->id =3D=3D id);
> +}
> +
> +bool bt_micp_unregister(unsigned int id)
> +{
> +       struct bt_micp_cb *cb;
> +
> +       cb =3D queue_remove_if(micp_cbs, match_id, UINT_TO_PTR(id));
> +       if (!cb)
> +               return false;
> +
> +       free(cb);
> +
> +       return true;
> +}
> +
> +struct bt_micp *bt_micp_new(struct gatt_db *ldb, struct gatt_db *rdb)
> +{
> +       struct bt_micp *micp;
> +       struct bt_micp_db *mdb;
> +
> +       if (!ldb)
> +               return NULL;
> +
> +       mdb =3D micp_get_db(ldb);
> +       if (!mdb)
> +               return NULL;
> +
> +       micp =3D new0(struct bt_micp, 1);
> +       micp->ldb =3D mdb;
> +       micp->pending =3D queue_new();
> +       micp->ready_cbs =3D queue_new();
> +
> +       if (!rdb)
> +               goto done;
> +
> +       mdb =3D new0(struct bt_micp_db, 1);
> +       mdb->db =3D gatt_db_ref(rdb);
> +
> +       micp->rdb =3D mdb;
> +
> +done:
> +       bt_micp_ref(micp);
> +
> +       return micp;
> +}
> +
> +static void micp_pending_destroy(void *data)
> +{
> +       struct bt_micp_pending *pending =3D data;
> +       struct bt_micp *micp =3D pending->micp;
> +
> +       if (queue_remove_if(micp->pending, NULL, pending))
> +               free(pending);
> +}
> +
> +static void micp_pending_complete(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_micp_pending *pending =3D user_data;
> +
> +       if (pending->func)
> +               pending->func(pending->micp, success, att_ecode, value, l=
ength,
> +                                         pending->userdata);
> +}
> +
> +static void micp_read_value(struct bt_micp *micp, uint16_t value_handle,
> +                               micp_func_t func, void *user_data)
> +{
> +       struct bt_micp_pending *pending;
> +
> +       pending =3D new0(struct bt_micp_pending, 1);
> +       pending->micp =3D micp;
> +       pending->func =3D func;
> +       pending->userdata =3D user_data;
> +
> +       pending->id =3D bt_gatt_client_read_value(micp->client, value_han=
dle,
> +                                       micp_pending_complete, pending,
> +                                       micp_pending_destroy);
> +
> +       if (!pending->id) {
> +               DBG(micp, "unable to send read request");
> +               free(pending);
> +               return;
> +       }
> +
> +       queue_push_tail(micp->pending, pending);
> +}
> +
> +static void micp_register(uint16_t att_ecode, void *user_data)
> +{
> +       struct bt_micp_notify *notify =3D user_data;
> +
> +       if (att_ecode)
> +               DBG(notify->micp, "MICP register failed 0x%04x", att_ecod=
e);
> +}
> +
> +static void micp_notify(uint16_t value_handle, const uint8_t *value,
> +                               uint16_t length, void *user_data)
> +{
> +       struct bt_micp_notify *notify =3D user_data;
> +
> +       if (notify->func)
> +               notify->func(notify->micp, value_handle, value, length,
> +                                        notify->user_data);
> +}
> +
> +static void micp_notify_destroy(void *data)
> +{
> +       struct bt_micp_notify *notify =3D data;
> +       struct bt_micp *micp =3D notify->micp;
> +
> +       if (queue_remove_if(micp->notify, NULL, notify))
> +               free(notify);
> +}
> +
> +static unsigned int micp_register_notify(struct bt_micp *micp,
> +                                       uint16_t value_handle,
> +                                       micp_notify_t func,
> +                                       void *user_data)
> +{
> +       struct bt_micp_notify *notify;
> +
> +       notify =3D new0(struct bt_micp_notify, 1);
> +       notify->micp =3D micp;
> +       notify->func =3D func;
> +       notify->user_data =3D user_data;
> +
> +       notify->id =3D bt_gatt_client_register_notify(micp->client,
> +                                       value_handle, micp_register,
> +                                       micp_notify, notify,
> +                                       micp_notify_destroy);
> +       if (!notify->id) {
> +               DBG(micp, "Unable to register for notifications");
> +               free(notify);
> +               return 0;
> +       }
> +
> +       queue_push_tail(micp->notify, notify);
> +
> +       return notify->id;
> +}
> +
> +static void micp_mute_state_notify(struct bt_micp *micp, uint16_t value_=
handle,
> +                                       const uint8_t *value, uint16_t le=
ngth,
> +                                       void *user_data)
> +{
> +       uint8_t mute_state;
> +
> +       memcpy(&mute_state, value, sizeof(mute_state));
> +
> +       DBG(micp, "Mute state: 0x%x", mute_state);
> +}
> +
> +static void read_mute_state(struct bt_micp *micp, bool success,
> +                                       uint8_t att_ecode, const uint8_t =
*value,
> +                                       uint16_t length, void *user_data)
> +{
> +       uint8_t *mute_state;
> +       struct iovec iov =3D {
> +               .iov_base =3D (void *)value,
> +               .iov_len =3D length,
> +       };
> +
> +       if (!success) {
> +               DBG(micp, "Unable to read Mute state: error 0x%02x", att_=
ecode);
> +               return;
> +       }
> +
> +       mute_state =3D iov_pull_mem(&iov, sizeof(uint8_t));
> +       if (mute_state =3D=3D NULL) {
> +               DBG(micp, "Unable to get Mute state");
> +               return;
> +       }
> +
> +       DBG(micp, "Mute state: %x", *mute_state);
> +}
> +
> +static void foreach_mics_char(struct gatt_db_attribute *attr, void *user=
_data)
> +{
> +       struct bt_micp *micp =3D user_data;
> +       uint16_t value_handle;
> +       bt_uuid_t uuid, uuid_mute;
> +       struct bt_mics *mics;
> +
> +       if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
> +                       NULL, NULL, &uuid))
> +               return;
> +
> +       bt_uuid16_create(&uuid_mute, MUTE_CHRC_UUID);
> +       if (!bt_uuid_cmp(&uuid, &uuid_mute)) {
> +               DBG(micp, "MICS Mute characteristic found: handle 0x%04x"=
,
> +                               value_handle);
> +
> +               mics =3D micp_get_mics(micp);
> +               if (!mics || mics->ms)
> +                       return;
> +
> +               mics->ms =3D attr;
> +
> +               micp_read_value(micp, value_handle, read_mute_state, micp=
);
> +
> +               micp->mute_id =3D micp_register_notify(micp, value_handle=
,
> +                                               micp_mute_state_notify, N=
ULL);
> +       }
> +}
> +
> +static void foreach_mics_service(struct gatt_db_attribute *attr,
> +                                       void *user_data)
> +{
> +       struct bt_micp *micp =3D user_data;
> +       struct bt_mics *mics =3D micp_get_mics(micp);
> +
> +       mics->service =3D attr;
> +
> +       gatt_db_service_set_claimed(attr, true);
> +       gatt_db_service_foreach_char(attr, foreach_mics_char, micp);
> +}
> +
> +unsigned int bt_micp_ready_register(struct bt_micp *micp,
> +                               bt_micp_ready_func_t func, void *user_dat=
a,
> +                               bt_micp_destroy_func_t destroy)
> +{
> +       struct bt_micp_ready *ready;
> +       static unsigned int id;
> +
> +       DBG(micp, "bt_micp_ready_register_Entry\n");
> +       if (!micp)
> +               return 0;
> +
> +       ready =3D new0(struct bt_micp_ready, 1);
> +       ready->id =3D ++id ? id : ++id;
> +       ready->func =3D func;
> +       ready->destroy =3D destroy;
> +       ready->data =3D user_data;
> +
> +       queue_push_tail(micp->ready_cbs, ready);
> +
> +       return ready->id;
> +}
> +
> +static bool match_ready_id(const void *data, const void *match_data)
> +{
> +       const struct bt_micp_ready *ready =3D data;
> +       unsigned int id =3D PTR_TO_UINT(match_data);
> +
> +       return (ready->id =3D=3D id);
> +}
> +
> +bool bt_micp_ready_unregister(struct bt_micp *micp, unsigned int id)
> +{
> +       struct bt_micp_ready *ready;
> +
> +       ready =3D queue_remove_if(micp->ready_cbs, match_ready_id,
> +                                               UINT_TO_PTR(id));
> +       if (!ready)
> +               return false;
> +
> +       micp_ready_free(ready);
> +
> +       return true;
> +}
> +
> +static struct bt_micp *bt_micp_ref_safe(struct bt_micp *micp)
> +{
> +       if (!micp || !micp->ref_count)
> +               return NULL;
> +
> +       return bt_micp_ref(micp);
> +}
> +
> +static void micp_notify_ready(struct bt_micp *micp)
> +{
> +       const struct queue_entry *entry;
> +
> +       if (!bt_micp_ref_safe(micp))
> +               return;
> +
> +       for (entry =3D queue_get_entries(micp->ready_cbs); entry;
> +                                                       entry =3D entry->=
next) {
> +               struct bt_micp_ready *ready =3D entry->data;
> +
> +               ready->func(micp, ready->data);
> +       }
> +
> +       bt_micp_unref(micp);
> +}
> +
> +static void micp_idle(void *data)
> +{
> +       struct bt_micp *micp =3D data;
> +
> +       micp->idle_id =3D 0;
> +       micp_notify_ready(micp);
> +}
> +
> +bool bt_micp_attach(struct bt_micp *micp, struct bt_gatt_client *client)
> +{
> +       bt_uuid_t uuid;
> +
> +       if (!sessions)
> +               sessions =3D queue_new();
> +
> +       queue_push_tail(sessions, micp);
> +
> +       if (!client)
> +               return true;
> +
> +       if (micp->client)
> +               return false;
> +
> +       micp->client =3D bt_gatt_client_clone(client);
> +       if (!micp->client)
> +               return false;
> +
> +       bt_gatt_client_idle_register(micp->client, micp_idle, micp, NULL)=
;
> +
> +       bt_uuid16_create(&uuid, MICS_UUID);
> +       gatt_db_foreach_service(micp->ldb->db, &uuid, foreach_mics_servic=
e,
> +                                               micp);
> +       return true;
> +}
> diff --git a/src/shared/micp.h b/src/shared/micp.h
> new file mode 100644
> index 000000000..b307ac9f4
> --- /dev/null
> +++ b/src/shared/micp.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
> + *
> + */
> +#include <stdbool.h>
> +#include <inttypes.h>
> +
> +#include "src/shared/io.h"
> +#include "src/shared/gatt-client.h"
> +
> +struct bt_micp;
> +
> +typedef void (*bt_micp_ready_func_t)(struct bt_micp *micp, void *user_da=
ta);
> +typedef void (*bt_micp_destroy_func_t)(void *user_data);
> +typedef void (*bt_micp_debug_func_t)(const char *str, void *user_data);
> +typedef void (*bt_micp_func_t)(struct bt_micp *micp, void *user_data);
> +
> +struct bt_micp *bt_micp_ref(struct bt_micp *micp);
> +void bt_micp_unref(struct bt_micp *micp);
> +
> +void bt_micp_add_db(struct gatt_db *db);
> +
> +bool bt_micp_attach(struct bt_micp *micp, struct bt_gatt_client *client)=
;
> +void bt_micp_detach(struct bt_micp *micp);
> +
> +bool bt_micp_set_debug(struct bt_micp *micp, bt_micp_debug_func_t func,
> +               void *user_data, bt_micp_destroy_func_t destroy);
> +
> +struct bt_att *bt_micp_get_att(struct bt_micp *micp);
> +
> +bool bt_micp_set_user_data(struct bt_micp *micp, void *user_data);
> +
> +/* session related functions */
> +unsigned int bt_micp_register(bt_micp_func_t attached, bt_micp_func_t de=
tached,
> +                                       void *user_data);
> +unsigned int bt_micp_ready_register(struct bt_micp *micp,
> +                               bt_micp_ready_func_t func, void *user_dat=
a,
> +                               bt_micp_destroy_func_t destroy);
> +bool bt_micp_ready_unregister(struct bt_micp *micp, unsigned int id);
> +
> +bool bt_micp_unregister(unsigned int id);
> +struct bt_micp *bt_micp_new(struct gatt_db *ldb, struct gatt_db *rdb);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
