Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B64C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDFAC20809
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O2PiiEWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgIJEmH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgIJEmE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:42:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE0DC061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:42:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d16so288951pll.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ku7StIItobDQpZNzzTw010eLm24wM3HDjZ2DFx/1Eho=;
        b=O2PiiEWZoXapjaiVwF8hMiTBrI/nMsPZEBYgOIYuc0PiRHNuj9kOpHkgjt4xKTzFD4
         rXZQHxGosk8vbFTWNcp76vBAj0Jh4xANzH6QAbV+agQHN7kIVqVONMm/j9HYABiFdGPd
         im0lbtdvfVCGKKhN1n2Uda/q8nqwaBWZm/+Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ku7StIItobDQpZNzzTw010eLm24wM3HDjZ2DFx/1Eho=;
        b=kuMejZU3mWr0aJ4gER+HAENeJdO8s9rsaPBV4FAaXHyDjqWL4EMS8wZA/nl8Lwhb+q
         m8r40jm1dJ7tI3XG+ZUkHkfZCA51xUyDrlXCbaUknIzCO+4gBDkoJoxy2/wStfGJN4vG
         D5NqA6/j8YbgJmqsUw2fXMogiNDCCbyeBOIn+Qy4ujMvbd0BI0rk8/zVivgQlSp2wicD
         v3ilLWkb312k5XQ5aT9SJhx6eKcCoWd2KQ6nA52j9UI34dPTg1YUqKVCbqM9EGQ7r60V
         YvSDFpi1V95Sj/COeUKVThaZkwap0zw/ZV3S9nVRQ2+ZEnIKja4SNNx98w31obIdohn9
         Fc/g==
X-Gm-Message-State: AOAM533B9i+YOYlIMHGHSIUmk3R0PTDcgzrblaFKJJRa+/6iPN2XuvhZ
        d5hVFbrqnLratshhf6FlLUz9CHoeE90Ipw==
X-Google-Smtp-Source: ABdhPJz24uC3vUHtgFac0XqrMTFwhjR8eajnPJOemAV30Y1G9V2kbyZrPVXfM59tdznUgek9sTIBnQ==
X-Received: by 2002:a17:902:8509:b029:d0:cbe1:e746 with SMTP id bj9-20020a1709028509b02900d0cbe1e746mr3822130plb.33.1599712921761;
        Wed, 09 Sep 2020 21:42:01 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id k4sm644888pjl.10.2020.09.09.21.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 21:42:01 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v3 1/7] adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1 interface
Date:   Wed,  9 Sep 2020 21:41:24 -0700
Message-Id: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
X-Mailer: git-send-email 2.26.2
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

(no changes since v2)

Changes in v2:
-Use new0 instead of g_new0
-Remove the reset of manager members
-Make methods/property experimental

 Makefile.am       |   3 +-
 src/adapter.c     |  14 +++++
 src/adapter.h     |   3 +
 src/adv_monitor.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++
 src/adv_monitor.h |  32 ++++++++++
 5 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 src/adv_monitor.c
 create mode 100644 src/adv_monitor.h

diff --git a/Makefile.am b/Makefile.am
index 7719c06f8..b14ee950e 100644
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
index 1435e2bd7..de327dc98 100644
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
 
@@ -8633,6 +8639,14 @@ static int adapter_register(struct btd_adapter *adapter)
 
 	adapter->adv_manager = btd_adv_manager_new(adapter, adapter->mgmt);
 
+	adapter->adv_monitor_manager = btd_adv_monitor_manager_create(
+							adapter, adapter->mgmt);
+	if (!adapter->adv_monitor_manager) {
+		btd_error(adapter->dev_id,
+			"Failed to create Adv Monitor Manager for adapter");
+		return -EINVAL;
+	}
+
 	db = btd_gatt_database_get_db(adapter->database);
 	adapter->db_id = gatt_db_register(db, services_modified,
 							services_modified,
diff --git a/src/adapter.h b/src/adapter.h
index f8ac20261..5cb467141 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -26,6 +26,9 @@
 #include <dbus/dbus.h>
 #include <glib.h>
 
+#include "lib/bluetooth.h"
+#include "lib/sdp.h"
+
 #define MAX_NAME_LENGTH		248
 
 /* Invalid SSP passkey value used to indicate negative replies */
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
new file mode 100644
index 000000000..8e7dad8dd
--- /dev/null
+++ b/src/adv_monitor.c
@@ -0,0 +1,148 @@
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
+	char *path;
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
+	{"SupportedFeatures", "as", NULL, NULL, NULL},
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
+	manager->path = g_strdup(adapter_get_path(manager->adapter));
+
+	return manager;
+}
+
+/* Frees a manager object */
+static void manager_free(struct btd_adv_monitor_manager *manager)
+{
+	mgmt_unref(manager->mgmt);
+	free(manager->path);
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
+					manager->path,
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
+	if (!g_dbus_register_interface(btd_get_dbus_connection(), manager->path,
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

