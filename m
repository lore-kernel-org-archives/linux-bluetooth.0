Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EA3C6FD1E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCGW0E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCGWZm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:25:42 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35191B06C4
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:25:07 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a9so15716220plh.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkQOloDQBql5f4S+4NOFgI3qikHTXcOuf3pdWCcDAMs=;
        b=LAW8ZI5ETLCtqyE5LJLFcmPS+wOy+qxBxn64zpSp6wJUU2H+DgNt33/LudPGe6ZKZ0
         jfQRPicFrprheZ1gDys5DoCktndIpLhsPpUBKE6DOCTLUrYRub4avrJH/CTXUnNcR3WQ
         gGYl0MtAiumuff5X6GhFre7Ihba5IHOAPRjL/IF0VNLkCDg8lGOF0EGUPNuctFyMWbTA
         zqmoaoa2oVc1nC8NvLWOyhcgqwD6waK+v9DjD6NmJSV4rmS4jTAQIozxnY9iulWBacPM
         SKi+LooDkhN5V9p1wQYcDz7esz5Z/2RT0roBTyTiANwwKmtRonSh3Bb6oJkVaUZth40s
         CxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkQOloDQBql5f4S+4NOFgI3qikHTXcOuf3pdWCcDAMs=;
        b=VUVJ+FCBIdASbTo5dyKLr96RVOzYN4Uiu962WImO8S+2uvkRmu+EKp+3rr8175DkDC
         DDbvUr2NQkMFfD6yiwkjJdMYsk1SzB1lYWDctmIbz+mhEQBIUKgN3yX5TV9fWsNQDCa3
         enqyG7q6AcIYxVDT6EbQXItacZV4r4B1A3VNPz0wAGNiMRMiLshY5eZs16L1BULyQYny
         DjmA89WXnYAtOcvf2pA9GWwDnqOYaoX3L2JANnWHu0T35kj8XNkLzFO5JhRtQgj8Bn7m
         7crFSJgz6Z1oxd3yf+9KvOjkFAeGA5A7Zn3PbJflR35/pySnCkZwBiYf+qUH5LM3OofL
         dCiQ==
X-Gm-Message-State: AO0yUKXZAb9KNOW3T0zGvCEmSTo2K9+zebs0o4i4wIYfkpcfwIjg9GxW
        88nVAvMCOBxs/5I6Groexje+K0NwL+o=
X-Google-Smtp-Source: AK7set+0HAdxADTN2FO/Z0fRf4ofzT2LR5rmVb8+PTmQOv+9aozgpMydP1xe5YnwORoBiu9TiNWbXw==
X-Received: by 2002:a17:902:d509:b0:19c:65bd:d44b with SMTP id b9-20020a170902d50900b0019c65bdd44bmr20072836plg.60.1678227874822;
        Tue, 07 Mar 2023 14:24:34 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902729200b0019c901b35ecsm8814392pll.106.2023.03.07.14.24.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:24:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2 09/12] profiles: Add initial code for csip plugin
Date:   Tue,  7 Mar 2023 14:24:19 -0800
Message-Id: <20230307222422.2608483-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narasimman <sathish.narasimman@intel.com>

This adds initial code for csip plugin which handles Coordinated
set identification Profile and Coordinated Set Identification
Service.
---
 Makefile.plugins      |   5 +
 configure.ac          |   4 +
 profiles/audio/csip.c | 363 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 372 insertions(+)
 create mode 100644 profiles/audio/csip.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 20cac384ef44..0f119e8714b7 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -131,3 +131,8 @@ if VCP
 builtin_modules += vcp
 builtin_sources += profiles/audio/vcp.c
 endif
+
+if CSIP
+builtin_modules += csip
+builtin_sources += profiles/audio/csip.c
+endif
diff --git a/configure.ac b/configure.ac
index 515cdf1461eb..6f890110f554 100644
--- a/configure.ac
+++ b/configure.ac
@@ -207,6 +207,10 @@ AC_ARG_ENABLE(vcp, AS_HELP_STRING([--disable-vcp],
 		[disable VCP profile]), [enable_vcp=${enableval}])
 AM_CONDITIONAL(VCP, test "${enable_vcp}" != "no")
 
+AC_ARG_ENABLE(csip, AS_HELP_STRING([--disable-csip],
+		[disable CSIP profile]), [enable_csip=${enableval}])
+AM_CONDITIONAL(CSIP, test "${enable_csip}" != "no")
+
 AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
diff --git a/profiles/audio/csip.c b/profiles/audio/csip.c
new file mode 100644
index 000000000000..c273c02b8e76
--- /dev/null
+++ b/profiles/audio/csip.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ * BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (C) 2022 Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+
+#include <ctype.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+#include "lib/sdp.h"
+#include "lib/uuid.h"
+
+#include "src/dbus-common.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/csip.h"
+
+#include "btio/btio.h"
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/gatt-database.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/log.h"
+#include "src/error.h"
+#include "src/btd.h"
+
+#define CSIS_UUID_STR "00001846-0000-1000-8000-00805f9b34fb"
+
+struct csip_data {
+	struct btd_device *device;
+	struct btd_service *service;
+	struct bt_csip *csip;
+	unsigned int ready_id;
+};
+
+static struct queue *sessions;
+
+static void csip_debug(const char *str, void *user_data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static struct csip_data *csip_data_new(struct btd_device *device)
+{
+	struct csip_data *data;
+
+	data = new0(struct csip_data, 1);
+	data->device = device;
+
+	return data;
+}
+
+static bool csip_ltk_read(struct bt_csip *csip, uint8_t k[16], void *user_data)
+{
+	/* TODO: Retrieve LTK using device object */
+	return false;
+}
+
+static void csip_data_add(struct csip_data *data)
+{
+	DBG("data %p", data);
+
+	if (queue_find(sessions, NULL, data)) {
+		error("data %p already added", data);
+		return;
+	}
+
+	bt_csip_set_debug(data->csip, csip_debug, NULL, NULL);
+
+	bt_csip_set_sirk(data->csip, btd_opts.csis.encrypt, btd_opts.csis.sirk,
+				btd_opts.csis.size, btd_opts.csis.rank,
+				csip_ltk_read, data);
+
+	if (!sessions)
+		sessions = queue_new();
+
+	queue_push_tail(sessions, data);
+
+	if (data->service)
+		btd_service_set_user_data(data->service, data);
+}
+
+static int csip_disconnect(struct btd_service *service)
+{
+	struct csip_data *data = btd_service_get_user_data(service);
+
+	bt_csip_detach(data->csip);
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
+static bool match_data(const void *data, const void *match_data)
+{
+	const struct csip_data *vdata = data;
+	const struct bt_csip *csip = match_data;
+
+	return vdata->csip == csip;
+}
+
+static void csip_data_free(struct csip_data *data)
+{
+	if (data->service) {
+		btd_service_set_user_data(data->service, NULL);
+		bt_csip_set_user_data(data->csip, NULL);
+	}
+
+	bt_csip_ready_unregister(data->csip, data->ready_id);
+	bt_csip_unref(data->csip);
+	free(data);
+}
+
+static void csip_data_remove(struct csip_data *data)
+{
+	DBG("data %p", data);
+
+	if (!queue_remove(sessions, data))
+		return;
+
+	csip_data_free(data);
+
+	if (queue_isempty(sessions)) {
+		queue_destroy(sessions, NULL);
+		sessions = NULL;
+	}
+}
+
+static void csip_detached(struct bt_csip *csip, void *user_data)
+{
+	struct csip_data *data;
+
+	DBG("%p", csip);
+
+	data = queue_find(sessions, match_data, csip);
+	if (!data) {
+		error("Unable to find csip session");
+		return;
+	}
+
+	/* If there is a service it means there is CSIS thus we can keep
+	 * instance allocated.
+	 */
+	if (data->service)
+		return;
+
+	csip_data_remove(data);
+}
+
+static void csip_attached(struct bt_csip *csip, void *user_data)
+{
+	struct csip_data *data;
+	struct bt_att *att;
+	struct btd_device *device;
+
+	DBG("%p", csip);
+
+	data = queue_find(sessions, match_data, csip);
+	if (data)
+		return;
+
+	att = bt_csip_get_att(csip);
+	if (!att)
+		return;
+
+	device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
+	if (!device) {
+		error("Unable to find device");
+		return;
+	}
+
+	data = csip_data_new(device);
+	data->csip = csip;
+
+	csip_data_add(data);
+
+}
+
+static int csip_server_probe(struct btd_profile *p,
+				struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+
+	DBG("CSIP path %s", adapter_get_path(adapter));
+
+	bt_csip_add_db(btd_gatt_database_get_db(database));
+
+	return 0;
+}
+
+static void csip_server_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	DBG("CSIP remove Adapter");
+}
+
+static int csip_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct csip_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!data) {
+		error("CSIP service not handled by profile");
+		return -EINVAL;
+	}
+
+	if (!bt_csip_attach(data->csip, client)) {
+		error("CSIP unable to attach");
+		return -EINVAL;
+	}
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
+static void csip_ready(struct bt_csip *csip, void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct btd_device *device = btd_service_get_device(service);
+	uint8_t type, size, rank;
+	uint8_t k[16];
+
+	DBG("csip %p", csip);
+
+	if (!bt_csip_get_sirk(csip, &type, k, &size, &rank)) {
+		error("Unable to read SIRK");
+		return;
+	}
+
+	btd_device_add_set(device, type == BT_CSIP_SIRK_ENCRYPT ? true : false,
+								k, size, rank);
+}
+
+static int csip_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct csip_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	/* Ignore, if we were probed for this device already */
+	if (data) {
+		error("Profile probed twice for the same device!");
+		return -EINVAL;
+	}
+
+	data = csip_data_new(device);
+	data->service = service;
+
+	data->csip = bt_csip_new(btd_gatt_database_get_db(database),
+					btd_device_get_gatt_db(device));
+	if (!data->csip) {
+		error("Unable to create CSIP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	csip_data_add(data);
+
+	data->ready_id = bt_csip_ready_register(data->csip, csip_ready, service,
+								NULL);
+
+	bt_csip_set_user_data(data->csip, service);
+
+	return 0;
+}
+
+static void csip_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct csip_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	data = btd_service_get_user_data(service);
+	if (!data) {
+		error("CSIP service not handled by profile");
+		return;
+	}
+
+	csip_data_remove(data);
+}
+
+static struct btd_profile csip_profile = {
+	.name		= "csip",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= CSIS_UUID_STR,
+
+	.device_probe	= csip_probe,
+	.device_remove	= csip_remove,
+
+	.accept		= csip_accept,
+	.disconnect	= csip_disconnect,
+
+	.adapter_probe	= csip_server_probe,
+	.adapter_remove	= csip_server_remove,
+};
+
+static unsigned int csip_id;
+
+static int csip_init(void)
+{
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		warn("D-Bus experimental not enabled");
+		return -ENOTSUP;
+	}
+
+	btd_profile_register(&csip_profile);
+	csip_id = bt_csip_register(csip_attached, csip_detached, NULL);
+
+	return 0;
+}
+
+static void csip_exit(void)
+{
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+		btd_profile_unregister(&csip_profile);
+		bt_csip_unregister(csip_id);
+	}
+}
+
+BLUETOOTH_PLUGIN_DEFINE(csip, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+						csip_init, csip_exit)
-- 
2.39.2

