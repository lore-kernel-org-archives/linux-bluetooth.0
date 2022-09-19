Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B614DECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 08:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiISIGN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 04:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiISIF6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 04:05:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89026B4A8
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 01:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663574752; x=1695110752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0lYuQvPFb3/vWBRfmfsL+RYMmcVMs9a/xNkc+wwWHrY=;
  b=VcHRDWHxEa0GEdpiatFeXteKG1SxNsBzHB8DssXBeHppE98+NOf93OMs
   tdifPacP8NNTmip9QzwOjPaNIsO6I5fP0wpMkJgQsrfx9UjYCDk1Tq9xZ
   ZLfJhIAxA1U6atxkciR5QFEhKu6AKyJkiQKLLLmjFELqqdXQE1M0/JZm7
   7Bbbv9wPVMjjrUq/AGIRrmTFKpy2R0gC7nrvOhp5iZwwRHIR6ai7jJyT3
   xCfaMDWLvMpK7h5dIoNPqZFrIsDudtI3nIU69q6feb/RfXzK3irbAgX26
   aH0BQGF8uJKXIkkYXrcNQI2P5+iUtK1RklghlJY+6E97OmjP6idbWpI07
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="279718273"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="279718273"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 01:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="947113951"
Received: from bsblt022.iind.intel.com ([10.224.186.21])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2022 01:05:51 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v3 2/3] profiles: Add initial code for vcp plugin
Date:   Mon, 19 Sep 2022 13:37:21 +0530
Message-Id: <20220919080722.562080-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919080722.562080-1-sathish.narasimman@intel.com>
References: <20220919080722.562080-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds initial code for vcp plugin which handles Volume Control
Profile and Volume Control Service.
---
 Makefile.plugins     |   5 +
 configure.ac         |   4 +
 profiles/audio/vcp.c | 312 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 profiles/audio/vcp.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 213ed99edf2d..a3654980f86d 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -121,3 +121,8 @@ if BAP
 builtin_modules += bap
 builtin_sources += profiles/audio/bap.c
 endif
+
+if VCP
+builtin_modules += vcp
+builtin_sources += profiles/audio/vcp.c
+endif
diff --git a/configure.ac b/configure.ac
index 1f76915b4349..79645e6917cc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -199,6 +199,10 @@ AC_ARG_ENABLE(bap, AS_HELP_STRING([--disable-bap],
 		[disable BAP profile]), [enable_bap=${enableval}])
 AM_CONDITIONAL(BAP, test "${enable_bap}" != "no")
 
+AC_ARG_ENABLE(vcp, AS_HELP_STRING([--disable-vcp],
+		[disable VCP profile]), [enable_vcp=${enableval}])
+AM_CONDITIONAL(VCP, test "${enable_vcp}" != "no")
+
 AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
new file mode 100644
index 000000000000..34950d4070f2
--- /dev/null
+++ b/profiles/audio/vcp.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation. All rights reserved.
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
+#include "src/shared/vcp.h"
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
+#define VCS_UUID_STR "00001844-0000-1000-8000-00805f9b34fb"
+#define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+
+struct vcp_data {
+	struct btd_device *device;
+	struct btd_service *service;
+	struct bt_vcp *vcp;
+};
+
+static struct queue *sessions;
+
+static int vcp_disconnect(struct btd_service *service)
+{
+	DBG("");
+	return 0;
+}
+
+static struct vcp_data *vcp_data_new(struct btd_device *device)
+{
+	struct vcp_data *data;
+
+	data = new0(struct vcp_data, 1);
+	data->device = device;
+
+	return data;
+}
+
+static void vcp_data_add(struct vcp_data *data)
+{
+	DBG("data %p", data);
+
+	if (queue_find(sessions, NULL, data)) {
+		error("data %p already added", data);
+		return;
+	}
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
+static bool match_data(const void *data, const void *match_data)
+{
+	const struct vcp_data *vdata = data;
+	const struct bt_vcp *vcp = match_data;
+
+	return vdata->vcp == vcp;
+}
+
+static void vcp_data_free(struct vcp_data *data)
+{
+	if (data->service) {
+		btd_service_set_user_data(data->service, NULL);
+		bt_vcp_set_user_data(data->vcp, NULL);
+	}
+
+	bt_vcp_unref(data->vcp);
+	free(data);
+}
+
+static void vcp_data_remove(struct vcp_data *data)
+{
+	DBG("data %p", data);
+
+	if (!queue_remove(sessions, data))
+		return;
+
+	vcp_data_free(data);
+
+	if (queue_isempty(sessions)) {
+		queue_destroy(sessions, NULL);
+		sessions = NULL;
+	}
+}
+
+static void vcp_detached(struct bt_vcp *vcp, void *user_data)
+{
+	struct vcp_data *data;
+
+	DBG("%p", vcp);
+
+	data = queue_find(sessions, match_data, vcp);
+	if (!data) {
+		error("Unable to find vcp session");
+		return;
+	}
+
+	vcp_data_remove(data);
+}
+
+static void vcp_attached(struct bt_vcp *vcp, void *user_data)
+{
+	struct vcp_data *data;
+	struct bt_att *att;
+	struct btd_device *device;
+
+	DBG("%p", vcp);
+
+	data = queue_find(sessions, match_data, vcp);
+	if (data)
+		return;
+
+	att = bt_vcp_get_att(vcp);
+	if (!att)
+		return;
+
+	device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
+	if (!device) {
+		error("Unable to find device");
+		return;
+	}
+
+	data = vcp_data_new(device);
+	data->vcp = vcp;
+
+	vcp_data_add(data);
+
+}
+
+static int vcp_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct vcp_data *data = btd_service_get_user_data(service);
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
+	data = vcp_data_new(device);
+	data->service = service;
+
+	data->vcp = bt_vcp_new(btd_gatt_database_get_db(database),
+					btd_device_get_gatt_db(device));
+	if (!data->vcp) {
+		error("Unable to create VCP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	vcp_data_add(data);
+
+	bt_vcp_set_user_data(data->vcp, service);
+
+	return 0;
+}
+
+static void vcp_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct vcp_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	data = btd_service_get_user_data(service);
+	if (!data) {
+		error("VCP service not handled by profile");
+		return;
+	}
+
+	vcp_data_remove(data);
+}
+
+static int vcp_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct vcp_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!data) {
+		error("VCP service not handled by profile");
+		return -EINVAL;
+	}
+
+	if (!bt_vcp_attach(data->vcp, client)) {
+		error("VCP unable to attach");
+		return -EINVAL;
+	}
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
+static int vcp_server_probe(struct btd_profile *p,
+				  struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+
+	DBG("VCP path %s", adapter_get_path(adapter));
+
+	bt_vcp_add_db(btd_gatt_database_get_db(database));
+
+	return 0;
+}
+
+static void vcp_server_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	DBG("VCP remove Adapter");
+}
+
+static struct btd_profile vcp_profile = {
+	.name		= "vcp",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= VCS_UUID_STR,
+
+	.device_probe	= vcp_probe,
+	.device_remove	= vcp_remove,
+
+	.accept		= vcp_accept,
+	.disconnect	= vcp_disconnect,
+
+	.adapter_probe = vcp_server_probe,
+	.adapter_remove = vcp_server_remove,
+};
+
+static unsigned int vcp_id = 0;
+
+static int vcp_init(void)
+{
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		warn("D-Bus experimental not enabled");
+		return -ENOTSUP;
+	}
+
+	btd_profile_register(&vcp_profile);
+	vcp_id = bt_vcp_register(vcp_attached, vcp_detached, NULL);
+
+	return 0;
+}
+
+static void vcp_exit(void)
+{
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+		btd_profile_unregister(&vcp_profile);
+		bt_vcp_unregister(vcp_id);
+	}
+}
+
+BLUETOOTH_PLUGIN_DEFINE(vcp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							vcp_init, vcp_exit)
-- 
2.25.1

