Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA12C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 03:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiKVDX6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 22:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiKVDXw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 22:23:52 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DFA240A1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 19:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669087431; x=1700623431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VauXNm2Sz7lxFMas+Ok2oVuVoItYXUxXvFr3woD7rqA=;
  b=C3Z/Bodx12IZBPCjvCa3wi5tSN2h9MOTpbB5FREAHj4LbT8wfGexu87a
   0PDQU8EmovZI04L/Cj3b+plnxm4FUBqsil4q0AValFwfolyoXg6VhG17S
   Gm+vkWU6sq1FRhsWTv/wEyyXwZG1n2HactcG1/FMiYUEggrEbPJ3sli2/
   IOv5FMWi7Wz/A+tgkRz7fcWnd2mpFqO0XIwC8NR/fsgWkfd8Q1AYW0GxP
   xQ/KH6/05ki+FsJK+Si5OG+GbKMuikh+6O86cg56ts3H/y+dPc20rxR4l
   EcTaZoFa0q3tschhxFFI18nKr66/rnpsda+OggrLAITJEyTc+jZhJYQGc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="340583281"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="340583281"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 19:23:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672331733"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="672331733"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2022 19:23:50 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ V2 4/6] profiles: Add initial code for csip plugin
Date:   Tue, 22 Nov 2022 08:55:28 +0530
Message-Id: <20221122032530.3842-5-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122032530.3842-1-sathish.narasimman@intel.com>
References: <20221122032530.3842-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds initial code for csip plugin which handles Coordinated
set identification Profile and Coordinated Set Identification
Service.
---
 Makefile.plugins      |   5 +
 configure.ac          |   4 +
 profiles/audio/csip.c | 319 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 328 insertions(+)
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
index f9f0faf573ca..17c5f904a5c2 100644
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
index 000000000000..7b50d5cec88e
--- /dev/null
+++ b/profiles/audio/csip.c
@@ -0,0 +1,319 @@
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
+
+#define CSIS_UUID_STR "00001846-0000-1000-8000-00805f9b34fb"
+
+struct csip_data {
+	struct btd_device *device;
+	struct btd_service *service;
+	struct bt_csip *csip;
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
+	DBG("");
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
+	bt_csip_unref(data->csip);
+	free(data);
+}
+
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
+static unsigned int csip_id = 0;
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
2.25.1

