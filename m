Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C3AC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BEF2078B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GFkdBbML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIJEwZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgIJEwV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:52:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57200C061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:52:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so6404504ljg.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5II68IKO1dIiGrC/s2Rycfyj2FmICgmM5WKX4TH4LY=;
        b=GFkdBbML4vO8FWESwqrSXTpLhGfDxqAi7CcGQ0iMOsUBCbfgyBbHljATg50p/Q2ScV
         t0jv0JaHso0TkTvK9TKA93CpnDY/Fg5FxtI+sMjbJPDLqcieSpD8YC0z0qWNr2r1xHhe
         GoZFvX/6xnDYnSEwPUbDDbQKRkObjDxbjz2AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5II68IKO1dIiGrC/s2Rycfyj2FmICgmM5WKX4TH4LY=;
        b=GK3BJf+Y+D2hOqaDXLrdP4Q3Vsl6m9eFSXAOT9Iq5uCB+1pvBFjbHOkbwPOGB/8rpK
         m1DZpFS+eKsOfHvHnEUFHO6TiS1/0sjvTvZi/fpjsSuiSPIY0fDCJIHtvUKXMncN66Lg
         cn52gT2uKS1bvZpqCmHTZvNGNGEkunm9AnudjoQwQkfjmZtOLfBQIMKhwWkuVcf6VzA0
         NkyuInN63U4CzRWVoaykb1kzBhlG6tzES2fDqTStb3Vg6ab9BFE6pf2irMdDJ9i6qWZY
         m+zkLehz4CfJfO8QWkmtgMSPITQB4qru9DqhdXi/nne/VXsGRgB/FRkB5VyTZH8RUFiP
         eZwg==
X-Gm-Message-State: AOAM53055awGGTPQU6c4M0ZjAjal4Hf1Ko5at7EccAbgCf41bvZwWpV0
        E4dpfhoBM7cyCGo2LJZ4UJ+XrMwcnsV8dAfwAZJW+Q==
X-Google-Smtp-Source: ABdhPJz6RqNyN9HkNcEz5//OnLv7be99VU5paGhxJsfwWGNSC7/LClUN9E0wrLRgO7BJDRWTvkM8OdMpAdPqh0V0VLw=
X-Received: by 2002:a2e:9c15:: with SMTP id s21mr3510428lji.27.1599713539688;
 Wed, 09 Sep 2020 21:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
 <CABBYNZLoGG8_f-8Vr=FW-mVe1uFsz-ob3-=tuk_c90kqhtLMVg@mail.gmail.com>
In-Reply-To: <CABBYNZLoGG8_f-8Vr=FW-mVe1uFsz-ob3-=tuk_c90kqhtLMVg@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Wed, 9 Sep 2020 21:52:08 -0700
Message-ID: <CABmPvSHWTr+v5jKbBDWus5RRZBprzrwb5UiT0jn4hJVqv0vbug@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1 1/7] adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1
 interface
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
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

Hi Luiz,

On Tue, Sep 8, 2020 at 10:19 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Tue, Aug 18, 2020 at 3:30 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > This introduces the org.bluez.AdvertisementMonitorManager1 without
> > implementing handlers of methods and properties.
> >
> > The following test was performed.
> > - Upon adapter registration, the info line of creating an ADV monitor
> > manager gets printed, and system bus emits the interface events of
> > org.bluez.AdvertisementMonitorManager1.
> >
> > Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> > Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> >  Makefile.am       |   3 +-
> >  src/adapter.c     |  14 +++++
> >  src/adapter.h     |   3 +
> >  src/adv_monitor.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++
> >  src/adv_monitor.h |  32 ++++++++++
> >  5 files changed, 200 insertions(+), 1 deletion(-)
> >  create mode 100644 src/adv_monitor.c
> >  create mode 100644 src/adv_monitor.h
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 7719c06f8..b14ee950e 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -293,7 +293,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
> >                         src/gatt-client.h src/gatt-client.c \
> >                         src/device.h src/device.c \
> >                         src/dbus-common.c src/dbus-common.h \
> > -                       src/eir.h src/eir.c
> > +                       src/eir.h src/eir.c \
> > +                       src/adv_monitor.h src/adv_monitor.c
>
> Id just name it monitor.{c, h}
It'd be preferable to avoid confusion by specifying "adv_" as the
prefix, since there is the other "monitor" (btmon) in BlueZ. Besides,
we also name the corresponding system configuration values by
"adv_monitor".
>
> >  src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
> >                         gdbus/libgdbus-internal.la \
> >                         src/libshared-glib.la \
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 5e896a9f0..41e9de286 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -77,6 +77,7 @@
> >  #include "attrib-server.h"
> >  #include "gatt-database.h"
> >  #include "advertising.h"
> > +#include "adv_monitor.h"
> >  #include "eir.h"
> >
> >  #define ADAPTER_INTERFACE      "org.bluez.Adapter1"
> > @@ -272,6 +273,8 @@ struct btd_adapter {
> >         struct btd_gatt_database *database;
> >         struct btd_adv_manager *adv_manager;
> >
> > +       struct btd_adv_monitor_manager *adv_monitor_manager;
> > +
> >         gboolean initialized;
> >
> >         GSList *pin_callbacks;
> > @@ -6346,6 +6349,9 @@ static void adapter_remove(struct btd_adapter *adapter)
> >         btd_adv_manager_destroy(adapter->adv_manager);
> >         adapter->adv_manager = NULL;
> >
> > +       btd_adv_monitor_manager_destroy(adapter->adv_monitor_manager);
> > +       adapter->adv_monitor_manager = NULL;
> > +
> >         g_slist_free(adapter->pin_callbacks);
> >         adapter->pin_callbacks = NULL;
> >
> > @@ -8623,6 +8629,14 @@ static int adapter_register(struct btd_adapter *adapter)
> >
> >         adapter->adv_manager = btd_adv_manager_new(adapter, adapter->mgmt);
> >
> > +       adapter->adv_monitor_manager = btd_adv_monitor_manager_create(
> > +                                                       adapter, adapter->mgmt);
> > +       if (!adapter->adv_monitor_manager) {
> > +               btd_error(adapter->dev_id,
> > +                       "Failed to create Adv Monitor Manager for adapter");
> > +               return -EINVAL;
> > +       }
> > +
> >         db = btd_gatt_database_get_db(adapter->database);
> >         adapter->db_id = gatt_db_register(db, services_modified,
> >                                                         services_modified,
> > diff --git a/src/adapter.h b/src/adapter.h
> > index f8ac20261..5cb467141 100644
> > --- a/src/adapter.h
> > +++ b/src/adapter.h
> > @@ -26,6 +26,9 @@
> >  #include <dbus/dbus.h>
> >  #include <glib.h>
> >
> > +#include "lib/bluetooth.h"
> > +#include "lib/sdp.h"
> > +
>
> It might be better to have this included locally in a .c file needing them.
>
This fixes the complaint from the compiler where the symbols referred
adapter.h was not found. This was revealed due to the circular
dependency between adv_monitor and adapter where adv_monitor needs to
include adapter.h for calling btd_adapter_get_index(), and adv_monitor
doesn't have these two includes. In other words, adapter.h has been
relying on other headers to include lib/sdp.h and lib/bluetooth.h
which was not a good pattern in the first place. Besides, adapter.h
does refer to symbols from lib/bluetooth.h and lib/sdp.h, so it makes
sense to have them here.
> >  #define MAX_NAME_LENGTH                248
> >
> >  /* Invalid SSP passkey value used to indicate negative replies */
> > diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> > new file mode 100644
> > index 000000000..7044d3cca
> > --- /dev/null
> > +++ b/src/adv_monitor.c
> > @@ -0,0 +1,149 @@
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2020 Google LLC
> > + *
> > + *
> > + *  This program is free software; you can redistribute it and/or
> > + *  modify it under the terms of the GNU Lesser General Public
> > + *  License as published by the Free Software Foundation; either
> > + *  version 2.1 of the License, or (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + *  Lesser General Public License for more details.
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#define _GNU_SOURCE
> > +#include <stdint.h>
> > +
> > +#include <glib.h>
> > +#include <dbus/dbus.h>
> > +#include <gdbus/gdbus.h>
> > +
> > +#include "adapter.h"
> > +#include "dbus-common.h"
> > +#include "log.h"
> > +#include "src/shared/mgmt.h"
> > +
> > +#include "adv_monitor.h"
> > +
> > +#define ADV_MONITOR_MGR_INTERFACE      "org.bluez.AdvertisementMonitorManager1"
> > +
> > +struct btd_adv_monitor_manager {
> > +       struct btd_adapter *adapter;
> > +       struct mgmt *mgmt;
> > +       uint16_t adapter_id;
> > +       char *path;
> > +};
> > +
> > +static const GDBusMethodTable adv_monitor_methods[] = {
> > +       { GDBUS_METHOD("RegisterMonitor",
> > +                                       GDBUS_ARGS({ "application", "o" }),
> > +                                       NULL, NULL) },
> > +       { GDBUS_ASYNC_METHOD("UnregisterMonitor",
> > +                                       GDBUS_ARGS({ "application", "o" }),
> > +                                       NULL, NULL) },
> > +       { }
> > +};
> > +
> > +static const GDBusPropertyTable adv_monitor_properties[] = {
> > +       {"SupportedMonitorTypes", "as", NULL, NULL, NULL},
> > +       {"SupportedFeatures", "as", NULL, NULL, NULL},
> > +       { }
> > +};
> > +
> > +/* Allocates a manager object */
> > +static struct btd_adv_monitor_manager *manager_new(
> > +                                               struct btd_adapter *adapter,
> > +                                               struct mgmt *mgmt)
> > +{
> > +       struct btd_adv_monitor_manager *manager;
> > +
> > +       if (!adapter || !mgmt)
> > +               return NULL;
> > +
> > +       manager = g_new0(struct btd_adv_monitor_manager, 1);
>
> Use new0.
>
> > +       if (!manager)
> > +               return NULL;
> > +
> > +       manager->adapter = adapter;
> > +       manager->mgmt = mgmt_ref(mgmt);
> > +       manager->adapter_id = btd_adapter_get_index(adapter);
> > +       manager->path = g_strdup(adapter_get_path(manager->adapter));
>
> If we are doing to reference the adapter we don't really need the
> duplicate its path since we can just use adapter_get_path.
As a part of adapter bring-down, the adv monitor manager would be
destroyed too, and we should avoid accessing adapter's resource(s)
during the bring-down to avoid incorrect values. By making a copy of
the path, the code would be less error-prone since the adv monitor
manager does not depend on the unknown state of the adapter.
>
> > +
> > +       return manager;
> > +}
> > +
> > +/* Frees a manager object */
> > +static void manager_free(struct btd_adv_monitor_manager *manager)
> > +{
> > +       manager->adapter = NULL;
>
> No need to assign NULL if you are going to free the whole object at the end.
Done.
>
> > +       mgmt_unref(manager->mgmt);
> > +       manager->mgmt = NULL;
>
> Ditto.
Done.
>
> > +       g_free(manager->path);
> > +       manager->path = NULL;
>
> Ditto.
Done.
>
> > +
> > +       g_free(manager);
> > +}
> > +
> > +/* Destroys a manager object and unregisters its D-Bus interface */
> > +static void manager_destroy(struct btd_adv_monitor_manager *manager)
> > +{
> > +       if (!manager)
> > +               return;
> > +
> > +       g_dbus_unregister_interface(btd_get_dbus_connection(),
> > +                                       manager->path,
> > +                                       ADV_MONITOR_MGR_INTERFACE);
> > +
> > +       manager_free(manager);
> > +}
> > +
> > +/* Creates a manager and registers its D-Bus interface */
> > +struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
> > +                                               struct btd_adapter *adapter,
> > +                                               struct mgmt *mgmt)
> > +{
> > +       struct btd_adv_monitor_manager *manager;
> > +
> > +       manager = manager_new(adapter, mgmt);
> > +       if (!manager)
> > +               return NULL;
> > +
> > +       if (g_dbus_register_interface(btd_get_dbus_connection(), manager->path,
> > +                                       ADV_MONITOR_MGR_INTERFACE,
> > +                                       adv_monitor_methods, NULL,
> > +                                       adv_monitor_properties, manager, NULL)
> > +               == FALSE) {
>
> We haven't been consistent with boolean checks but lately we start
> using more the ! form instead of == FALSE.
Done.

Thanks,
Miao


>
> > +               btd_error(manager->adapter_id,
> > +                               "Failed to register "
> > +                               ADV_MONITOR_MGR_INTERFACE);
> > +               manager_free(manager);
> > +               return NULL;
> > +       }
> > +
> > +       btd_info(manager->adapter_id,
> > +                       "Adv Monitor Manager created for adapter %s",
> > +                       adapter_get_path(manager->adapter));
> > +
> > +       return manager;
> > +}
> > +
> > +/* Destroys a manager and unregisters its D-Bus interface */
> > +void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager)
> > +{
> > +       if (!manager)
> > +               return;
> > +
> > +       btd_info(manager->adapter_id, "Destroy Adv Monitor Manager");
> > +
> > +       manager_destroy(manager);
> > +}
> > diff --git a/src/adv_monitor.h b/src/adv_monitor.h
> > new file mode 100644
> > index 000000000..69ea348f8
> > --- /dev/null
> > +++ b/src/adv_monitor.h
> > @@ -0,0 +1,32 @@
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2020 Google LLC
> > + *
> > + *
> > + *  This program is free software; you can redistribute it and/or
> > + *  modify it under the terms of the GNU Lesser General Public
> > + *  License as published by the Free Software Foundation; either
> > + *  version 2.1 of the License, or (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + *  Lesser General Public License for more details.
> > + *
> > + */
> > +
> > +#ifndef __ADV_MONITOR_H
> > +#define __ADV_MONITOR_H
> > +
> > +struct mgmt;
> > +struct btd_adapter;
> > +struct btd_adv_monitor_manager;
> > +
> > +struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
> > +                                               struct btd_adapter *adapter,
> > +                                               struct mgmt *mgmt);
> > +void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager);
> > +
> > +#endif /* __ADV_MONITOR_H */
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz
