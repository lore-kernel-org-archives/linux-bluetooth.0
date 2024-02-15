Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070810798
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708062522; cv=none; b=nr1OTlgwzBd9j4KGKybaG3sdPnZIdouEZ0TWOtZciLWqiT27QNsMd47ObhNGA8fkJPILekg+asePELJ2JjW+b4yFI5GsswZF7sMkBk6j56mfNzOtskc+yOre+hdgEQiRcdtKFu2WmQyLhIsgJ3bnUu2tgToM2tv5cU6A5yVv1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708062522; c=relaxed/simple;
	bh=4AdoLCd6eXSSX9L768o5IlVRkxZZmdfDnlW4GI0/SSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=COydVRQy58yS38Uovo9SMWOCeDQn61FL6dw1CdPy0LibIc03DEHkF4mDkdlNUn8ussmhpc9ePUnV8cTXEr/gYOjULAw/nI0/H7w1XxVBegrZI3o4x1vc15DNMa7zUK33L/Fu6ceWfsMnApdL0PB/1rr0qQIzD5vVh2GlRctCLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLssGtD1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLssGtD1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708062520; x=1739598520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4AdoLCd6eXSSX9L768o5IlVRkxZZmdfDnlW4GI0/SSU=;
  b=hLssGtD1GB1H+uoksUvKvdhJJpKE9qnWhLTGRDTbVAkK1dzDtOsum80Y
   210RsZZdwlSqJctkwChA7brTmDSPMxXc9GMQ9++BGQS+AGdTpZKaxJeOu
   tA0hB4N2adZYaPGGxzO5bES2/aNBOEF8IFo1PKPoZxdI+qBX6ES6x2JFN
   fCLqWVJ7qDWv1BfzYIP8qkZiF3xmhJZBQ6cEos3uM+iQT1y3IfdQQ3Tna
   BS3vM0wX0X6Ozv3IZBese0B/XbgieRr+3qAWSLwKnGxkubiA0ql9TOphL
   wI6jzrTypJhTBniKvo35pReAZN9ZLlTT0vDxvFHgXlQcddU95TVLZRCkm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="13287077"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="13287077"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:48:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="3681378"
Received: from lbtoe.iind.intel.com ([10.224.186.133])
  by fmviesa007.fm.intel.com with ESMTP; 15 Feb 2024 21:48:38 -0800
From: Shahid Vichhi <shahid.bashir.vichhi@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Shahid Vichhi <shahid.bashir.vichhi@intel.com>
Subject: [PATCH v1] profiles/audio/ccp: Add initial code for ccp plugin
Date: Fri, 16 Feb 2024 00:50:08 +0200
Message-Id: <20240215225008.3996772-1-shahid.bashir.vichhi@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds initial code for ccp plugin which handle call control profile and
Telephone Bearer Services and Generic Telephone Bearer Services for
client role.
---
 Makefile.plugins     |   5 +
 configure.ac         |   4 +
 profiles/audio/ccp.c | 238 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+)
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
index 000000000000..a1992e5687eb
--- /dev/null
+++ b/profiles/audio/ccp.c
@@ -0,0 +1,238 @@
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
+	/* Ignore, if we were probed for this device already */
+	if (data) {
+		error("Profile probed twice for the same device!");
+		return -EINVAL;
+	}
+
+	data = ccp_data_new(device);
+	data->service = service;
+
+	data->ccp = bt_ccp_new(btd_gatt_database_get_db(database),
+												 btd_device_get_gatt_db(device));
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
+		error("VCP unable to attach");
+		return -EINVAL;
+	}
+
+	/*TODO: register telephony operations here*/
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
+static int
+ccp_server_probe(struct btd_profile *p,
+								 struct btd_adapter *adapter)
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
+									struct btd_adapter *adapter)
+{
+	DBG("CCP remove Adapter");
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
+												ccp_init, ccp_exit)
-- 
2.34.1

