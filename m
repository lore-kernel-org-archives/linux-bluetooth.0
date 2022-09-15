Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867FFECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Sep 2022 09:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIOJ6I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Sep 2022 05:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIOJ5g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Sep 2022 05:57:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C789D64B
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663235596; x=1694771596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0lYuQvPFb3/vWBRfmfsL+RYMmcVMs9a/xNkc+wwWHrY=;
  b=VfO7w/hg1L+z8CoBu9xjffYMp55JoaeNiG37XR7s/wyDjD+7wsLvQw2V
   m2k+lppwD8TJpgBOPeZ+9SiIjYqrlWzDfBhOKMi6grQr6nUY7uEN4tR8u
   jq6sgERYvjzfK7aMugKBVcqge6RkO5lH6vDFKBMNi8KnivudPAt3rsNOF
   Wi0d8SJl6QsrlrpnIFjAUuljIfu/DkqeI3n8AkPRTJJGHXxQ71tFEWGSO
   Px0Rp67UZDldVKUwdMYBaMq13TpEOMVc2XpjL3z2fV7ftoWoOIp0Hr/Kg
   /Xkvoct1FuCgFUjbW9hfJ+g29OruO1sxMharjFq1m8+ZwqoG/hn2JGs8j
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="285709673"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="285709673"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 02:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="945886006"
Received: from bsblt022.iind.intel.com ([10.224.186.21])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2022 02:52:42 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v2 3/4] profiles: Add initial code for vcp plugin
Date:   Thu, 15 Sep 2022 15:24:11 +0530
Message-Id: <20220915095412.462210-3-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915095412.462210-1-sathish.narasimman@intel.com>
References: <20220915095412.462210-1-sathish.narasimman@intel.com>
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

