Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5183B781
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511295; cv=none; b=ZguVrIgXfNRUUHYjsafYajdgREGn0HJop5WlKarfGD9YdWpXz77g4Fc/tkQtTeSkidG1ivqQVjVF1jHGkk5fI5x1KDSzfSzFPRCcmMDr7GHxal/BKzKEFPY74fOeBuxmGUfzkNLVvdxBhk6eBLqR4BEUo7i7d0IFkcnDyuIuKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511295; c=relaxed/simple;
	bh=UYVabs0rlkpoCnSc1MSXtPzVaNv4JUd4iR1q04SMPDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RaaTW4cfxI0q+aH5mduLBsBLrw3USsbvQMoIVWkjXu9CZ46p4MQHRSuXv2lw3Cf8BLatPZ+NryyJgNXEZ1QsZ7opI3J+CroVKgALJXeRp6Ds5WoAU889HM/utEIm+Lb3Sg2YAm/yifdrpqSRz48/ezCT0a8AipPxHYkFHaWr2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWzo8SrM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWzo8SrM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708511293; x=1740047293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UYVabs0rlkpoCnSc1MSXtPzVaNv4JUd4iR1q04SMPDU=;
  b=nWzo8SrMRaEAQiE4hLrP4MaOTLyiWMchH7AVZET4cVBWS+SY79YLeXAO
   fByZNylFh7OgruMialEb/hlvcC9z2cmG/qgjcIy/fNPBdtFm9Ru6ZXMeZ
   sj7bMYYNH74m6uJC4mvIIgkq2WuWKp934BTYeWhzoZ/k/82Sz0wNmUbHg
   KNYn8ywO89uPwRMLthiw+ki0vbqjZbfx+yNN+a+GUCNv57zvhPifhkNVC
   J5ns//bJNj81vbYnKhV5Rpbin8Io1aX7czx9R2LMswKaZa8wn1kFMWVAC
   0ZbHVvs1s8MwdN20oSt2LlGQJcZvCI9H2hug6KURGbJOtsQ4vsg7828D0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="5617890"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5617890"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 02:28:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9730963"
Received: from lbtoe.iind.intel.com ([10.224.186.133])
  by orviesa003.jf.intel.com with ESMTP; 21 Feb 2024 02:28:11 -0800
From: Shahid Vichhi <shahid.bashir.vichhi@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Shahid Vichhi <shahid.bashir.vichhi@intel.com>
Subject: [ BlueZ,v3] profiles/audio/ccp: Add CCP plugin for call control profile
Date: Wed, 21 Feb 2024 05:22:22 +0200
Message-Id: <20240221032221.404011-1-shahid.bashir.vichhi@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds initial code for CCP plugin which handle CALL CONTROL PROFILE for
Telephone Bearer Services and Generic Telephone Bearer Services in the
client role.
This has been tested using teams application by initiating call between
Linux BTOE and Windows server with LE audio enabled.
---
 Makefile.plugins     |   5 +
 configure.ac         |   4 +
 profiles/audio/ccp.c | 235 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 profiles/audio/ccp.c

diff --git a/Makefile.plugins b/Makefile.plugins
index e960eedeabd3..4aa2c9c92854 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -138,6 +138,11 @@ builtin_modules += micp
 builtin_sources += profiles/audio/micp.c
 endif

+if CCP
+builtin_modules += ccp
+builtin_sources += profiles/audio/ccp.c
+endif
+
 if CSIP
 builtin_modules += csip
 builtin_sources += profiles/audio/csip.c
diff --git a/configure.ac b/configure.ac
index 70e9d4be8127..c7dadf79a565 100644
--- a/configure.ac
+++ b/configure.ac
@@ -200,6 +200,10 @@ AC_ARG_ENABLE(mcp, AS_HELP_STRING([--disable-mcp],
         [disable MCP profile]), [enable_mcp=${enableval}])
 AM_CONDITIONAL(MCP, test "${enable_mcp}" != "no")
 
+AC_ARG_ENABLE(ccp, AS_HELP_STRING([--disable-ccp],
+        [disable CCP profile]), [enable_ccp=${enableval}])
+AM_CONDITIONAL(CCP, test "${enable_ccp}" != "no")
+
 AC_ARG_ENABLE(vcp, AS_HELP_STRING([--disable-vcp],
 		[disable VCP profile]), [enable_vcp=${enableval}])
 AM_CONDITIONAL(VCP, test "${enable_vcp}" != "no")
diff --git a/profiles/audio/ccp.c b/profiles/audio/ccp.c
new file mode 100644
index 000000000000..fe678de9fede
--- /dev/null
+++ b/profiles/audio/ccp.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024  Intel Corporation. All rights reserved.
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
+#include <string.h>
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
+#include "src/shared/ccp.h"
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
+#define GTBS_UUID_STR "0000184C-0000-1000-8000-00805f9b34fb"
+
+struct ccp_data {
+	struct btd_device *device;
+	struct btd_service *service;
+	struct bt_ccp *ccp;
+	unsigned int state_id;
+};
+
+static void ccp_debug(const char *str, void *user_data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static struct ccp_data *ccp_data_new(struct btd_device *device)
+{
+	struct ccp_data *data;
+
+	data = new0(struct ccp_data, 1);
+	data->device = device;
+
+	return data;
+}
+
+static int ccp_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct ccp_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (data) {
+		error("Profile probed twice for the same device!");
+		return -EINVAL;
+	}
+
+	data = ccp_data_new(device);
+	data->service = service;
+
+	data->ccp = bt_ccp_new(btd_gatt_database_get_db(database),
+			       btd_device_get_gatt_db(device));
+
+	bt_ccp_set_debug(data->ccp, ccp_debug, NULL, NULL);
+	btd_service_set_user_data(service, data);
+
+	return 0;
+}
+
+static void ccp_data_free(struct ccp_data *data)
+{
+	if (data->service) {
+		btd_service_set_user_data(data->service, NULL);
+		bt_ccp_set_user_data(data->ccp, NULL);
+	}
+
+	bt_ccp_unref(data->ccp);
+	free(data);
+}
+
+static void ccp_data_remove(struct ccp_data *data)
+{
+	DBG("data %p", data);
+
+	ccp_data_free(data);
+}
+
+static void ccp_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct ccp_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	data = btd_service_get_user_data(service);
+	if (!data) {
+		error("CCP service not handled by profile");
+		return;
+	}
+
+	ccp_data_remove(data);
+}
+
+static int ccp_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct ccp_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!bt_ccp_attach(data->ccp, client)) {
+		error("CCP unable to attach");
+		return -EINVAL;
+	}
+
+	/* TODO: register telephony operations here */
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
+static int ccp_connect(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	return 0;
+}
+
+static int ccp_disconnect(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct ccp_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	bt_ccp_detach(data->ccp);
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
+static int ccp_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+
+	bt_ccp_register(btd_gatt_database_get_db(database));
+
+	return 0;
+}
+
+static void
+ccp_server_remove(struct btd_profile *p,
+		  struct btd_adapter *adapter)
+{
+	DBG("CCP remove adapter");
+}
+
+static struct btd_profile ccp_profile = {
+	.name			= "ccp",
+	.priority		= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= GTBS_UUID_STR,
+	.device_probe	= ccp_probe,
+	.device_remove	= ccp_remove,
+	.accept			= ccp_accept,
+	.connect		= ccp_connect,
+	.disconnect		= ccp_disconnect,
+
+	.adapter_probe	= ccp_server_probe,
+	.adapter_remove = ccp_server_remove,
+
+	.experimental	= true,
+};
+
+static int ccp_init(void)
+{
+	return btd_profile_register(&ccp_profile);
+}
+
+static void ccp_exit(void)
+{
+	btd_profile_unregister(&ccp_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(ccp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			ccp_init, ccp_exit)
-- 
2.34.1

