Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFEDC43461
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C54A20770
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K72CKhJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgILGuj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgILGui (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:50:38 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAFEC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:50:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s65so6926111pgb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6NkIUnCBg/W8FDg9bJf6d5T8R+Lpd4X8IBezpCyIGhk=;
        b=K72CKhJq0knAwZpQEG9H1GmylENRstHAaG9XcrLIjxX73+IgJzUhpU9hOh9p5CWd3D
         zGlejHonbgGmI5Tx5D6JwJNBryZXzaRW19aPlHywgSQqnxrF3rSYn7OmZ5cIsPdsk3+b
         OmMohJc6fUX7xiMUloKqZKZJehGGX8AFy91JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6NkIUnCBg/W8FDg9bJf6d5T8R+Lpd4X8IBezpCyIGhk=;
        b=Pg+iieSPpsn+CKQRRO51W1/WDUl/+XzRIOLOR6k0ZX8Rvzb7k/p0m9FqyeAfuZwOJK
         8Dn2Z85vR1QP4yWRtvMMyS1mXraG437zicbOs4t3CGyS2UJVxXJJNb9WOSIrep3Ud+I1
         tBTa7Mex7tLHq4m5e9RkXhcfEuN/bWmBCnu9WzKAjxIERWUUqecmw5f2wrAg5zGa/KjB
         WDxeMcV5SF6RhRoqqpXf5W9bjmPIZXyvfqZi5uruv+hXWQkLd6Oqvt1I/YI5YpddKNkD
         b1xozyqTKlzEM36fMDcTKZmPZo+1ZaU1wbhCMyt5krOKOjFzBsMVWvMId7FO8u27Wx+X
         BFsw==
X-Gm-Message-State: AOAM533omLqRi4tbyJPezr2ZcdLJcv2wZWlAXqdjzZwAKLg1DvF2WS8f
        NCZn9ZxGa25BgAeXsvitqmlRwTbU6DGwHA==
X-Google-Smtp-Source: ABdhPJyObEj4fifAF05XHAAWoBOSQdEPZZ3GkE7MoC+k48iCN0EPi1A7sP5hWknXTQBqf6NMOOUVHg==
X-Received: by 2002:a63:c705:: with SMTP id n5mr4099523pgg.19.1599893437357;
        Fri, 11 Sep 2020 23:50:37 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id 131sm4162467pfc.20.2020.09.11.23.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:50:36 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v5 2/8] PRE-UPSTREAM: adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1 interface
Date:   Fri, 11 Sep 2020 23:50:01 -0700
Message-Id: <20200911234949.BlueZ.v5.2.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911234949.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
References: <20200911234949.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This introduces the org.bluez.AdvertisementMonitorManager1 without
implementing handlers of methods and properties.

The following test was performed.
- Upon adapter registration, the info line of creating an ADV monitor
manager gets printed, and system bus emits the interface events of
org.bluez.AdvertisementMonitorManager1.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v4)

Changes in v4:
-Create the Adv Monitor Manager only if the experimental flag is in
place and mark all properties and methods experimental.

Changes in v2:
-Use new0 instead of g_new0
-Remove the reset of manager members
-Make methods/property experimental

 Makefile.am       |   3 +-
 src/adapter.c     |  23 ++++++++
 src/adv_monitor.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++
 src/adv_monitor.h |  32 ++++++++++
 4 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 src/adv_monitor.c
 create mode 100644 src/adv_monitor.h

diff --git a/Makefile.am b/Makefile.am
index 725fbe48d..22b4fa30c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -293,7 +293,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/gatt-client.h src/gatt-client.c \
 			src/device.h src/device.c \
 			src/dbus-common.c src/dbus-common.h \
-			src/eir.h src/eir.c
+			src/eir.h src/eir.c \
+			src/adv_monitor.h src/adv_monitor.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			src/libshared-glib.la \
diff --git a/src/adapter.c b/src/adapter.c
index 1435e2bd7..df628a7fd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -77,6 +77,7 @@
 #include "attrib-server.h"
 #include "gatt-database.h"
 #include "advertising.h"
+#include "adv_monitor.h"
 #include "eir.h"
 
 #define ADAPTER_INTERFACE	"org.bluez.Adapter1"
@@ -272,6 +273,8 @@ struct btd_adapter {
 	struct btd_gatt_database *database;
 	struct btd_adv_manager *adv_manager;
 
+	struct btd_adv_monitor_manager *adv_monitor_manager;
+
 	gboolean initialized;
 
 	GSList *pin_callbacks;
@@ -6360,6 +6363,9 @@ static void adapter_remove(struct btd_adapter *adapter)
 	btd_adv_manager_destroy(adapter->adv_manager);
 	adapter->adv_manager = NULL;
 
+	btd_adv_monitor_manager_destroy(adapter->adv_monitor_manager);
+	adapter->adv_monitor_manager = NULL;
+
 	g_slist_free(adapter->pin_callbacks);
 	adapter->pin_callbacks = NULL;
 
@@ -8633,6 +8639,23 @@ static int adapter_register(struct btd_adapter *adapter)
 
 	adapter->adv_manager = btd_adv_manager_new(adapter, adapter->mgmt);
 
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+		if (adapter->supported_settings & MGMT_SETTING_LE) {
+			adapter->adv_monitor_manager =
+				btd_adv_monitor_manager_create(adapter,
+								adapter->mgmt);
+			if (!adapter->adv_monitor_manager) {
+				btd_error(adapter->dev_id,
+						"Failed to create Adv Monitor "
+						"Manager for adapter");
+				return -EINVAL;
+			}
+		} else {
+			btd_info(adapter->dev_id, "Adv Monitor Manager "
+					"skipped, LE unavailable");
+		}
+	}
+
 	db = btd_gatt_database_get_db(adapter->database);
 	adapter->db_id = gatt_db_register(db, services_modified,
 							services_modified,
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
new file mode 100644
index 000000000..ad3f64cbe
--- /dev/null
+++ b/src/adv_monitor.c
@@ -0,0 +1,147 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020 Google LLC
+ *
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdint.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+#include <gdbus/gdbus.h>
+
+#include "adapter.h"
+#include "dbus-common.h"
+#include "log.h"
+#include "src/shared/mgmt.h"
+#include "src/shared/util.h"
+
+#include "adv_monitor.h"
+
+#define ADV_MONITOR_MGR_INTERFACE	"org.bluez.AdvertisementMonitorManager1"
+
+struct btd_adv_monitor_manager {
+	struct btd_adapter *adapter;
+	struct mgmt *mgmt;
+	uint16_t adapter_id;
+};
+
+static const GDBusMethodTable adv_monitor_methods[] = {
+	{ GDBUS_EXPERIMENTAL_METHOD("RegisterMonitor",
+					GDBUS_ARGS({ "application", "o" }),
+					NULL, NULL) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterMonitor",
+					GDBUS_ARGS({ "application", "o" }),
+					NULL, NULL) },
+	{ }
+};
+
+static const GDBusPropertyTable adv_monitor_properties[] = {
+	{"SupportedMonitorTypes", "as", NULL, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
+	{"SupportedFeatures", "as", NULL, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
+	{ }
+};
+
+/* Allocates a manager object */
+static struct btd_adv_monitor_manager *manager_new(
+						struct btd_adapter *adapter,
+						struct mgmt *mgmt)
+{
+	struct btd_adv_monitor_manager *manager;
+
+	if (!adapter || !mgmt)
+		return NULL;
+
+	manager = new0(struct btd_adv_monitor_manager, 1);
+	if (!manager)
+		return NULL;
+
+	manager->adapter = adapter;
+	manager->mgmt = mgmt_ref(mgmt);
+	manager->adapter_id = btd_adapter_get_index(adapter);
+
+	return manager;
+}
+
+/* Frees a manager object */
+static void manager_free(struct btd_adv_monitor_manager *manager)
+{
+	mgmt_unref(manager->mgmt);
+
+	free(manager);
+}
+
+/* Destroys a manager object and unregisters its D-Bus interface */
+static void manager_destroy(struct btd_adv_monitor_manager *manager)
+{
+	if (!manager)
+		return;
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					adapter_get_path(manager->adapter),
+					ADV_MONITOR_MGR_INTERFACE);
+
+	manager_free(manager);
+}
+
+/* Creates a manager and registers its D-Bus interface */
+struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
+						struct btd_adapter *adapter,
+						struct mgmt *mgmt)
+{
+	struct btd_adv_monitor_manager *manager;
+
+	manager = manager_new(adapter, mgmt);
+	if (!manager)
+		return NULL;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					adapter_get_path(manager->adapter),
+					ADV_MONITOR_MGR_INTERFACE,
+					adv_monitor_methods, NULL,
+					adv_monitor_properties, manager,
+					NULL)) {
+		btd_error(manager->adapter_id,
+				"Failed to register "
+				ADV_MONITOR_MGR_INTERFACE);
+		manager_free(manager);
+		return NULL;
+	}
+
+	btd_info(manager->adapter_id,
+			"Adv Monitor Manager created for adapter %s",
+			adapter_get_path(manager->adapter));
+
+	return manager;
+}
+
+/* Destroys a manager and unregisters its D-Bus interface */
+void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager)
+{
+	if (!manager)
+		return;
+
+	btd_info(manager->adapter_id, "Destroy Adv Monitor Manager");
+
+	manager_destroy(manager);
+}
diff --git a/src/adv_monitor.h b/src/adv_monitor.h
new file mode 100644
index 000000000..69ea348f8
--- /dev/null
+++ b/src/adv_monitor.h
@@ -0,0 +1,32 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020 Google LLC
+ *
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifndef __ADV_MONITOR_H
+#define __ADV_MONITOR_H
+
+struct mgmt;
+struct btd_adapter;
+struct btd_adv_monitor_manager;
+
+struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
+						struct btd_adapter *adapter,
+						struct mgmt *mgmt);
+void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager);
+
+#endif /* __ADV_MONITOR_H */
-- 
2.26.2

