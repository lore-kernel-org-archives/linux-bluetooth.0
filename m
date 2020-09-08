Return-Path: <SRS0=n2jO=CR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6657C43461
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Sep 2020 17:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E67C2087D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Sep 2020 17:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxXz2aEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbgIHRUB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbgIHRTu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Sep 2020 13:19:50 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C1CC061573
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2020 10:19:50 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w16so17203524oia.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2020 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0Tpz6iiGOH9jKWx+vYGwwElkU9D2IqTxybE7t8fGbQ=;
        b=TxXz2aEFkK9new76IPz1OGB4Uaf37ewDVDcMYsFsyqFCjH5BoL6nxFiaG3HcgCYUTF
         GRgag4KfiXXh0Nm8u1W6uMgoxOz1CAI0XOgysUIC9g2saeM0NdGVpEa0YByq+u9I+aZz
         E6PURQCBF6/tLq/zy1p8faVbrFd8dP2f9cT4EhjC21LpxBW7nsaQAMKYdjZp+G1Hyx9w
         Ct+w1RgS326PbIhyje3pBas3lML2lZdFNNFYUJiuo6haSl33lFQzsE5gjCgIxEu+uqLS
         CxwEWAQ4Zx8xY29hpYImISkDo+EzWR34WwRKZljYoCipnJ8MZoyjNeIX19pJEqMGOYbh
         qcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0Tpz6iiGOH9jKWx+vYGwwElkU9D2IqTxybE7t8fGbQ=;
        b=Oyci7oZ+1vOKhqdfXRp3zcDNP4O9otXPxPLUYZBVuDWxl5M0sbRTSj/slNN/q/fte1
         udywFG9mUy3oBbqxdw5zOcE4WbUYKeRk7S1fws1Hk5bdSItBhwCiWbY7gNLgqm/7wmZ6
         2XqPk1eKRgX2P+kepF39CgtTqcj0z45MY2UiStliurJ+o9nG+6xUExNesjr/XUhQGQ7/
         3Py2enb2nUyQuwOnuK0N9boDnmkRoXmNEnyrLPdVF4Couh6a3zvweJGsDqOJDDhamWCo
         qffjhVYdsT3xU9P8uTQv24Es14nBlwo9oYcZ68OtyewXtPhof+o4KT9ac5XLAnkQCH9C
         63+w==
X-Gm-Message-State: AOAM533pmiqbjuHv9AjdQ3Wbwchu3/p3MpQaobh9GTpE9QoM+pcTo2o/
        jCIxDF/v1Kz/Jivgm60UcBkko1tVDgCV+sXaECU=
X-Google-Smtp-Source: ABdhPJy4gG3wUMZ3EHdLBh5tlp5OJ9orIYeEEqiRmsLPzGDVee74sBqAYxCYmib4WNJIhF30OQdC4Pagl9Jc4mUsaVk=
X-Received: by 2002:aca:aad0:: with SMTP id t199mr6800oie.48.1599585589523;
 Tue, 08 Sep 2020 10:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
In-Reply-To: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Sep 2020 10:19:38 -0700
Message-ID: <CABBYNZLoGG8_f-8Vr=FW-mVe1uFsz-ob3-=tuk_c90kqhtLMVg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1 1/7] adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1
 interface
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Tue, Aug 18, 2020 at 3:30 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This introduces the org.bluez.AdvertisementMonitorManager1 without
> implementing handlers of methods and properties.
>
> The following test was performed.
> - Upon adapter registration, the info line of creating an ADV monitor
> manager gets printed, and system bus emits the interface events of
> org.bluez.AdvertisementMonitorManager1.
>
> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
>  Makefile.am       |   3 +-
>  src/adapter.c     |  14 +++++
>  src/adapter.h     |   3 +
>  src/adv_monitor.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++
>  src/adv_monitor.h |  32 ++++++++++
>  5 files changed, 200 insertions(+), 1 deletion(-)
>  create mode 100644 src/adv_monitor.c
>  create mode 100644 src/adv_monitor.h
>
> diff --git a/Makefile.am b/Makefile.am
> index 7719c06f8..b14ee950e 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -293,7 +293,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
>                         src/gatt-client.h src/gatt-client.c \
>                         src/device.h src/device.c \
>                         src/dbus-common.c src/dbus-common.h \
> -                       src/eir.h src/eir.c
> +                       src/eir.h src/eir.c \
> +                       src/adv_monitor.h src/adv_monitor.c

Id just name it monitor.{c, h}

>  src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
>                         gdbus/libgdbus-internal.la \
>                         src/libshared-glib.la \
> diff --git a/src/adapter.c b/src/adapter.c
> index 5e896a9f0..41e9de286 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -77,6 +77,7 @@
>  #include "attrib-server.h"
>  #include "gatt-database.h"
>  #include "advertising.h"
> +#include "adv_monitor.h"
>  #include "eir.h"
>
>  #define ADAPTER_INTERFACE      "org.bluez.Adapter1"
> @@ -272,6 +273,8 @@ struct btd_adapter {
>         struct btd_gatt_database *database;
>         struct btd_adv_manager *adv_manager;
>
> +       struct btd_adv_monitor_manager *adv_monitor_manager;
> +
>         gboolean initialized;
>
>         GSList *pin_callbacks;
> @@ -6346,6 +6349,9 @@ static void adapter_remove(struct btd_adapter *adapter)
>         btd_adv_manager_destroy(adapter->adv_manager);
>         adapter->adv_manager = NULL;
>
> +       btd_adv_monitor_manager_destroy(adapter->adv_monitor_manager);
> +       adapter->adv_monitor_manager = NULL;
> +
>         g_slist_free(adapter->pin_callbacks);
>         adapter->pin_callbacks = NULL;
>
> @@ -8623,6 +8629,14 @@ static int adapter_register(struct btd_adapter *adapter)
>
>         adapter->adv_manager = btd_adv_manager_new(adapter, adapter->mgmt);
>
> +       adapter->adv_monitor_manager = btd_adv_monitor_manager_create(
> +                                                       adapter, adapter->mgmt);
> +       if (!adapter->adv_monitor_manager) {
> +               btd_error(adapter->dev_id,
> +                       "Failed to create Adv Monitor Manager for adapter");
> +               return -EINVAL;
> +       }
> +
>         db = btd_gatt_database_get_db(adapter->database);
>         adapter->db_id = gatt_db_register(db, services_modified,
>                                                         services_modified,
> diff --git a/src/adapter.h b/src/adapter.h
> index f8ac20261..5cb467141 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -26,6 +26,9 @@
>  #include <dbus/dbus.h>
>  #include <glib.h>
>
> +#include "lib/bluetooth.h"
> +#include "lib/sdp.h"
> +

It might be better to have this included locally in a .c file needing them.

>  #define MAX_NAME_LENGTH                248
>
>  /* Invalid SSP passkey value used to indicate negative replies */
> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> new file mode 100644
> index 000000000..7044d3cca
> --- /dev/null
> +++ b/src/adv_monitor.c
> @@ -0,0 +1,149 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2020 Google LLC
> + *
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <stdint.h>
> +
> +#include <glib.h>
> +#include <dbus/dbus.h>
> +#include <gdbus/gdbus.h>
> +
> +#include "adapter.h"
> +#include "dbus-common.h"
> +#include "log.h"
> +#include "src/shared/mgmt.h"
> +
> +#include "adv_monitor.h"
> +
> +#define ADV_MONITOR_MGR_INTERFACE      "org.bluez.AdvertisementMonitorManager1"
> +
> +struct btd_adv_monitor_manager {
> +       struct btd_adapter *adapter;
> +       struct mgmt *mgmt;
> +       uint16_t adapter_id;
> +       char *path;
> +};
> +
> +static const GDBusMethodTable adv_monitor_methods[] = {
> +       { GDBUS_METHOD("RegisterMonitor",
> +                                       GDBUS_ARGS({ "application", "o" }),
> +                                       NULL, NULL) },
> +       { GDBUS_ASYNC_METHOD("UnregisterMonitor",
> +                                       GDBUS_ARGS({ "application", "o" }),
> +                                       NULL, NULL) },
> +       { }
> +};
> +
> +static const GDBusPropertyTable adv_monitor_properties[] = {
> +       {"SupportedMonitorTypes", "as", NULL, NULL, NULL},
> +       {"SupportedFeatures", "as", NULL, NULL, NULL},
> +       { }
> +};
> +
> +/* Allocates a manager object */
> +static struct btd_adv_monitor_manager *manager_new(
> +                                               struct btd_adapter *adapter,
> +                                               struct mgmt *mgmt)
> +{
> +       struct btd_adv_monitor_manager *manager;
> +
> +       if (!adapter || !mgmt)
> +               return NULL;
> +
> +       manager = g_new0(struct btd_adv_monitor_manager, 1);

Use new0.

> +       if (!manager)
> +               return NULL;
> +
> +       manager->adapter = adapter;
> +       manager->mgmt = mgmt_ref(mgmt);
> +       manager->adapter_id = btd_adapter_get_index(adapter);
> +       manager->path = g_strdup(adapter_get_path(manager->adapter));

If we are doing to reference the adapter we don't really need the
duplicate its path since we can just use adapter_get_path.

> +
> +       return manager;
> +}
> +
> +/* Frees a manager object */
> +static void manager_free(struct btd_adv_monitor_manager *manager)
> +{
> +       manager->adapter = NULL;

No need to assign NULL if you are going to free the whole object at the end.

> +       mgmt_unref(manager->mgmt);
> +       manager->mgmt = NULL;

Ditto.

> +       g_free(manager->path);
> +       manager->path = NULL;

Ditto.

> +
> +       g_free(manager);
> +}
> +
> +/* Destroys a manager object and unregisters its D-Bus interface */
> +static void manager_destroy(struct btd_adv_monitor_manager *manager)
> +{
> +       if (!manager)
> +               return;
> +
> +       g_dbus_unregister_interface(btd_get_dbus_connection(),
> +                                       manager->path,
> +                                       ADV_MONITOR_MGR_INTERFACE);
> +
> +       manager_free(manager);
> +}
> +
> +/* Creates a manager and registers its D-Bus interface */
> +struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
> +                                               struct btd_adapter *adapter,
> +                                               struct mgmt *mgmt)
> +{
> +       struct btd_adv_monitor_manager *manager;
> +
> +       manager = manager_new(adapter, mgmt);
> +       if (!manager)
> +               return NULL;
> +
> +       if (g_dbus_register_interface(btd_get_dbus_connection(), manager->path,
> +                                       ADV_MONITOR_MGR_INTERFACE,
> +                                       adv_monitor_methods, NULL,
> +                                       adv_monitor_properties, manager, NULL)
> +               == FALSE) {

We haven't been consistent with boolean checks but lately we start
using more the ! form instead of == FALSE.

> +               btd_error(manager->adapter_id,
> +                               "Failed to register "
> +                               ADV_MONITOR_MGR_INTERFACE);
> +               manager_free(manager);
> +               return NULL;
> +       }
> +
> +       btd_info(manager->adapter_id,
> +                       "Adv Monitor Manager created for adapter %s",
> +                       adapter_get_path(manager->adapter));
> +
> +       return manager;
> +}
> +
> +/* Destroys a manager and unregisters its D-Bus interface */
> +void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager)
> +{
> +       if (!manager)
> +               return;
> +
> +       btd_info(manager->adapter_id, "Destroy Adv Monitor Manager");
> +
> +       manager_destroy(manager);
> +}
> diff --git a/src/adv_monitor.h b/src/adv_monitor.h
> new file mode 100644
> index 000000000..69ea348f8
> --- /dev/null
> +++ b/src/adv_monitor.h
> @@ -0,0 +1,32 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2020 Google LLC
> + *
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + */
> +
> +#ifndef __ADV_MONITOR_H
> +#define __ADV_MONITOR_H
> +
> +struct mgmt;
> +struct btd_adapter;
> +struct btd_adv_monitor_manager;
> +
> +struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
> +                                               struct btd_adapter *adapter,
> +                                               struct mgmt *mgmt);
> +void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager);
> +
> +#endif /* __ADV_MONITOR_H */
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
