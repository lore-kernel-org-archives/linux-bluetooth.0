Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C313E03B
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895211; cv=none; b=YRaB1LcEJhxp+fYU8HdcYUwPHLYuG+Ts7VqAui7k3dQvOCdihiHxv8/V/rYTYitbSG+x4Ci7UaFUC0PEqyTB4oBBbHyNRNk7Uw3JlEo+Opd4b5qLT1NpXgnc5x0UXTDJ+Msm0WWjMu9MLFEWH+26U2s33q5jYsXj9BbmyKqtUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895211; c=relaxed/simple;
	bh=OkDZ51kIO3Ye+3g4KP+FZhsZJNUGRptUBeAG1rqDcCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qc9CcbjFvhlgqVbu9MFmt7epHDV9VPNnDaDi6D7OMCTG5BS7n6Y8BLjoheS6XPX052wG/EkfoadIs6ooaESQ7B5+Drkjkv/jWPI9NqiLraJNyM4OA0PX7VbGh7fNovDvPb4UGUAc48V+9akWAj3X/N5yJR4jz/stM1rEpQX+2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTffdLhm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTffdLhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713895209; x=1745431209;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OkDZ51kIO3Ye+3g4KP+FZhsZJNUGRptUBeAG1rqDcCk=;
  b=QTffdLhmjvy/sYk6+QB3RQ2DEvc2NzEFrl4UFMpM+233p0uzhIqx3dno
   1ln9bnr6tVaxxfXVhHO/DJeYPnQ9eUae+XmD6H/evHFE9+gI2XGDZlZTS
   PZdxIE2ajm+VxJpx+k5eE6nV5GjplSjRJEDDSZO7aBuAvYrsXaH7Gc3Sn
   QPPe4HZ06xJdsHnOMF+bJvjzzP9LasCpc3ksUcgFmGUW0DIWp6HUXf0bA
   +6B5SLN83W6KFzVkX0bjDqIdWqaceMYZSyLATycOPPMTU3rY/EBI5g16w
   5nP9iAcT/NwP0PpJHl9lyueclJoD6a86IfjjJodZ4dv3aKLowpoi81Wwt
   Q==;
X-CSE-ConnectionGUID: wR9R5UhBRWKuFELMADm6+Q==
X-CSE-MsgGUID: VtZKJ1mSSXGdEwDDuIhvXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34899286"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34899286"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:00:08 -0700
X-CSE-ConnectionGUID: /7AW6qbaSv+2t6++mSu8GQ==
X-CSE-MsgGUID: EZy5tLALQsqhQ8VyX/SagA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28931620"
Received: from unknown (HELO WEBA0535.iind.intel.com) ([10.224.186.30])
  by fmviesa003.fm.intel.com with ESMTP; 23 Apr 2024 11:00:07 -0700
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH v1] bluetoothctl: CCP client interface for bluetoothctl
Date: Wed, 24 Apr 2024 02:26:22 +0300
Message-Id: <20240423232622.1142256-1-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows bluetoothctl to send CCP client call control
commands like answer/reject call
---
 Makefile.plugins           |   3 +-
 Makefile.tools             |   4 +-
 client/main.c              |   4 +-
 client/telephony_client.c  | 213 +++++++++++++++++++++++++++++++
 client/telephony_client.h  |  12 ++
 profiles/audio/ccp.c       | 150 ++++++++++++++++++----
 profiles/audio/telephony.c | 173 ++++++++++++++++++++++++++
 profiles/audio/telephony.h |  65 ++++++++++
 src/shared/ccp.c           | 249 +++++++++++++++++++++++--------------
 src/shared/ccp.h           |  19 ++-
 10 files changed, 765 insertions(+), 127 deletions(-)
 create mode 100644 client/telephony_client.c
 create mode 100644 client/telephony_client.h
 create mode 100644 profiles/audio/telephony.c
 create mode 100644 profiles/audio/telephony.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 4aa2c9c92854..7c0e0bb23560 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -46,7 +46,8 @@ builtin_modules += avrcp
 builtin_sources += profiles/audio/control.h profiles/audio/control.c \
 			profiles/audio/avctp.h profiles/audio/avctp.c \
 			profiles/audio/avrcp.h profiles/audio/avrcp.c \
-			profiles/audio/player.h profiles/audio/player.c
+			profiles/audio/player.h profiles/audio/player.c\
+			profiles/audio/telephony.c profiles/audio/telephony.h
 endif
 
 if NETWORK
diff --git a/Makefile.tools b/Makefile.tools
index 27a753762d1c..e21f6e8e478e 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -13,7 +13,9 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/gatt.h client/gatt.c \
 					client/admin.h client/admin.c \
 					client/player.h client/player.c \
-					client/mgmt.h client/mgmt.c
+					client/mgmt.h client/mgmt.c \
+					client/telephony_client.c \
+					client/telephony_client.h
 client_bluetoothctl_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la src/libshared-glib.la \
 			$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
diff --git a/client/main.c b/client/main.c
index 51d08a67aa1a..438c45bb9c24 100644
--- a/client/main.c
+++ b/client/main.c
@@ -34,7 +34,7 @@
 #include "admin.h"
 #include "player.h"
 #include "mgmt.h"
-
+#include "telephony_client.h"
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
@@ -3199,6 +3199,7 @@ int main(int argc, char *argv[])
 
 	admin_add_submenu();
 	player_add_submenu();
+	telephony_add_submenu();
 	mgmt_add_submenu();
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
@@ -3216,6 +3217,7 @@ int main(int argc, char *argv[])
 
 	admin_remove_submenu();
 	player_remove_submenu();
+	telephony_remove_submenu();
 	mgmt_remove_submenu();
 
 	g_dbus_client_unref(client);
diff --git a/client/telephony_client.c b/client/telephony_client.c
new file mode 100644
index 000000000000..121255920dd0
--- /dev/null
+++ b/client/telephony_client.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024  Intel Corporation. All rights reserved.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include "gdbus/gdbus.h"
+#include "lib/bluetooth.h"
+#include "src/shared/shell.h"
+#include "print.h"
+#include "telephony_client.h"
+
+/* String display constants */
+#define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
+#define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
+
+#define BLUEZ_TELEPHONY_INTERFACE "org.bluez.telephonyCtrl"
+
+static DBusConnection *dbus_conn;
+static GDBusProxy *default_call = NULL;
+static GList *callList = NULL;
+static GDBusClient *client = NULL;
+
+static char *proxy_description(GDBusProxy *proxy, const char *title,
+			       const char *description)
+{
+	const char *path;
+
+	path = g_dbus_proxy_get_path(proxy);
+	return g_strdup_printf("%s%s%s%s %s ",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					title, path);
+}
+
+static void print_info(void *data, void *user_data)
+{
+	GDBusProxy *proxy = data;
+	const char *description = user_data;
+	char *str;
+
+	str = proxy_description(proxy, "Telephony", description);
+
+	bt_shell_printf("%s%s\n", str,
+			default_call == proxy ? "[default]" : "");
+
+	g_free(str);
+}
+
+static void call_reject_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to reject call: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("operation completed\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_reject(int argc, char *argv[])
+{
+	if (!default_call) {
+		bt_shell_printf("No active calls present\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (g_dbus_proxy_method_call(default_call, "reject", NULL,
+				     call_reject_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to reject call\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+}
+
+static void call_answer_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to answer call: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("operation completed\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_answer(int argc, char *argv[])
+{
+	if (!default_call)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (g_dbus_proxy_method_call(default_call, "answer", NULL,
+				     call_answer_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to answer the call\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
+static const struct bt_shell_menu call_menu = {
+	.name = "telephony",
+	.desc = "telephony Settings Submenu",
+	.entries = {
+	{ "answer", NULL, cmd_answer, "answer the active call" },
+	{ "reject", NULL, cmd_reject, "reject the active call" },
+	{} },
+};
+
+static void call_added(GDBusProxy *proxy)
+{
+	bt_shell_printf("[CHG] Telephony caller Added\n");
+	callList = g_list_append(callList, proxy);
+
+	if (!default_call)
+		default_call = proxy;
+
+	print_info(proxy, COLORED_NEW);
+}
+
+static void call_removed(GDBusProxy *proxy)
+{
+	bt_shell_printf("[CHG] Telephony caller Removed\n");
+
+	if (default_call == proxy)
+		default_call = NULL;
+
+	callList = g_list_remove(callList, proxy);
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_TELEPHONY_INTERFACE))
+		call_added(proxy);
+}
+
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_TELEPHONY_INTERFACE))
+		call_removed(proxy);
+}
+
+static void telephony_property_changed(GDBusProxy *proxy, const char *name,
+				       DBusMessageIter *iter)
+{
+	char *str;
+
+	str = proxy_description(proxy, "Telephony", COLORED_CHG);
+	print_iter(str, name, iter);
+	g_free(str);
+
+	bt_shell_printf("[CHG] Telephony property : %s\n", name);
+}
+
+static void property_changed(GDBusProxy *proxy, const char *name,
+			     DBusMessageIter *iter, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_TELEPHONY_INTERFACE))
+		telephony_property_changed(proxy, name, iter);
+}
+
+void telephony_add_submenu(void)
+{
+	bt_shell_add_submenu(&call_menu);
+
+	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
+	if (!dbus_conn || client)
+		return;
+
+	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+
+	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
+					 property_changed, NULL);
+	g_dbus_client_set_disconnect_watch(client, NULL, NULL);
+}
+
+void telephony_remove_submenu(void)
+{
+	g_dbus_client_unref(client);
+}
diff --git a/client/telephony_client.h b/client/telephony_client.h
new file mode 100644
index 000000000000..15c73f0051e0
--- /dev/null
+++ b/client/telephony_client.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024 Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+void telephony_add_submenu(void);
+void telephony_remove_submenu(void);
diff --git a/profiles/audio/ccp.c b/profiles/audio/ccp.c
index fe678de9fede..21f98cfbcfb7 100644
--- a/profiles/audio/ccp.c
+++ b/profiles/audio/ccp.c
@@ -40,7 +40,6 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
 #include "src/shared/gatt-server.h"
-#include "src/shared/ccp.h"
 
 #include "btio/btio.h"
 #include "src/plugin.h"
@@ -51,6 +50,8 @@
 #include "src/service.h"
 #include "src/log.h"
 #include "src/error.h"
+#include "src/shared/ccp.h"
+#include "telephony.h"
 
 #define GTBS_UUID_STR "0000184C-0000-1000-8000-00805f9b34fb"
 
@@ -58,9 +59,132 @@ struct ccp_data {
 	struct btd_device *device;
 	struct btd_service *service;
 	struct bt_ccp *ccp;
-	unsigned int state_id;
+	unsigned int call_state_id;
+	struct telephony_ctrl *tc;
 };
 
+static int ct_call_answer(struct telephony_ctrl *tc, void *user_data)
+{
+	struct bt_ccp *ccp = user_data;
+
+	DBG(" status %d index %d", tc->call_status, tc->call_index);
+
+	if (tc->call_status == CALL_DISCONNECTED)
+		return -1;
+
+	return bt_ccp_call_answer(ccp, tc->call_index);
+}
+
+static int ct_call_reject(struct telephony_ctrl *tc, void *user_data)
+{
+	struct bt_ccp *ccp = user_data;
+
+	DBG(" status %d  index %d", tc->call_status, tc->call_index);
+
+	if (tc->call_status == CALL_DISCONNECTED)
+		return -1;
+
+	return bt_ccp_call_reject(ccp, tc->call_index);
+}
+
+static const struct telephony_control_callback ct_cbs = {
+	.call_answer = &ct_call_answer,
+	.call_reject = &ct_call_reject,
+};
+
+static void cb_call_list_update(struct bt_ccp *ccp,  const uint8_t *buf,
+				uint16_t length)
+{
+	struct telephony_ctrl *tc = bt_ccp_get_user_data(ccp);
+	struct ccp_call_list_evt *evt;
+
+	DBG("");
+
+	if (length < sizeof(struct ccp_call_list_evt))
+		return;
+
+	evt = (struct ccp_call_list_evt *)buf;
+	tc->call_index = evt->index;
+	tc->call_status = evt->state;
+
+	DBG(" status %d  index %d", tc->call_status, tc->call_index);
+
+	telephony_update_call_Info(tc);
+}
+
+static void cb_incoming_call(struct bt_ccp *ccp,  const uint8_t *buf,
+			     uint16_t length)
+{
+	struct ccp_incoming_call_evt *evt;
+	struct telephony_ctrl *tc = bt_ccp_get_user_data(ccp);
+
+	DBG("");
+
+	if (length < sizeof(struct ccp_incoming_call_evt))
+		return;
+
+	evt = (struct ccp_incoming_call_evt *)buf;
+	tc->call_index = evt->index;
+	tc->call_status = INCOMING_CALL;
+
+	DBG(" status %d  index %d", tc->call_status, tc->call_index);
+
+	telephony_update_call_Info(tc);
+}
+
+static void cb_terminate_call(struct bt_ccp *ccp,  const uint8_t *buf,
+			      uint16_t length)
+{
+	struct ccp_call_terminate_evt *evt;
+	struct telephony_ctrl *tc = bt_ccp_get_user_data(ccp);
+
+	DBG("");
+
+	if (length < sizeof(struct ccp_call_terminate_evt))
+		return;
+
+	evt = (struct ccp_call_terminate_evt *)buf;
+	tc->call_index = evt->index;
+	tc->call_status = CALL_DISCONNECTED;
+
+	DBG(" status %d  index %d", tc->call_status, tc->call_index);
+
+	telephony_update_call_Info(tc);
+}
+
+static const struct bt_ccp_event_callback cbs = {
+	.incoming_call =  cb_incoming_call,
+	.terminate_call =  cb_terminate_call,
+	.call_list_update = cb_call_list_update
+};
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
+	bt_ccp_attach(data->ccp, client);
+
+	data->tc = telephony_create_device(device_get_path(device), 0);
+	if (!data->tc) {
+		DBG("Unable to create telephony device object");
+		data->tc = NULL;
+		return -EINVAL;
+	}
+
+	telephony_set_callbacks(data->tc, &ct_cbs, data->ccp);
+	bt_ccp_set_user_data(data->ccp, data->tc);
+	bt_ccp_set_event_callbacks(data->ccp, &cbs, data->tc);
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
 static void ccp_debug(const char *str, void *user_data)
 {
 	DBG_IDX(0xffff, "%s", str);
@@ -140,28 +264,6 @@ static void ccp_remove(struct btd_service *service)
 	ccp_data_remove(data);
 }
 
-static int ccp_accept(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
-	struct ccp_data *data = btd_service_get_user_data(service);
-	char addr[18];
-
-	ba2str(device_get_address(device), addr);
-	DBG("%s", addr);
-
-	if (!bt_ccp_attach(data->ccp, client)) {
-		error("CCP unable to attach");
-		return -EINVAL;
-	}
-
-	/* TODO: register telephony operations here */
-
-	btd_service_connecting_complete(service, 0);
-
-	return 0;
-}
-
 static int ccp_connect(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
diff --git a/profiles/audio/telephony.c b/profiles/audio/telephony.c
new file mode 100644
index 000000000000..68f27b5471cc
--- /dev/null
+++ b/profiles/audio/telephony.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024  Intel Corporation
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+#include "gdbus/gdbus.h"
+
+#include "src/log.h"
+#include "src/dbus-common.h"
+#include "src/error.h"
+#include "telephony.h"
+
+#define BLUEZ_TELEPHONY_INTERFACE "org.bluez.telephonyCtrl"
+
+struct call_callback {
+	const struct telephony_control_callback *cbs;
+	void *user_data;
+};
+
+void telephony_update_call_Info(struct telephony_ctrl *tc)
+{
+	DBG("");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), tc->path,
+				     BLUEZ_TELEPHONY_INTERFACE, "call_state");
+}
+
+static DBusMessage *telephony_answer_call(DBusConnection *conn,
+					  DBusMessage *msg, void *data)
+{
+	struct telephony_ctrl *tc = data;
+	struct call_callback *cb = tc->cb;
+	int err;
+
+	DBG("");
+	if (!cb->cbs->call_answer)
+		return btd_error_not_supported(msg);
+
+	err = cb->cbs->call_answer(tc, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *telephony_reject_call(DBusConnection *conn,
+					  DBusMessage *msg, void *data)
+{
+	struct telephony_ctrl *tc = data;
+	struct call_callback *cb = tc->cb;
+	int err;
+
+	DBG("");
+
+	if (!cb->cbs->call_reject)
+		return btd_error_not_supported(msg);
+
+	err = cb->cbs->call_reject(tc, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static gboolean ccp_get_index(const GDBusPropertyTable *property,
+			      DBusMessageIter *iter, void *data)
+{
+	struct telephony_ctrl *tc = data;
+	uint32_t index = tc->call_index;
+
+	DBG("");
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &index);
+
+	return TRUE;
+}
+
+static const GDBusSignalTable telephony_signals[] = {
+};
+
+/* methods exposed to client to perform call operations */
+static const GDBusMethodTable telephony_methods[] = {
+	{ GDBUS_METHOD("answer", NULL, NULL, telephony_answer_call) },
+	{ GDBUS_METHOD("reject", NULL, NULL, telephony_reject_call) },
+	{ }
+};
+
+/*
+ * Inform registered clients on property changed events
+ * use g_dbus_emit_property_changed() API
+ */
+static const GDBusPropertyTable telephony_properties[] = {
+	{ "call_state", "u", ccp_get_index, NULL, NULL },
+	{ }
+};
+
+void telephony_destroy_device(struct telephony_ctrl *tc)
+{
+	DBG("%s", tc->path);
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				    tc->path, BLUEZ_TELEPHONY_INTERFACE);
+
+	if (tc->path)
+		g_free(tc->cb);
+	if (tc->path)
+		g_free(tc->path);
+	if (tc->device)
+		g_free(tc->device);
+
+	if (tc)
+		g_free(tc);
+}
+
+struct telephony_ctrl *telephony_create_device(const char *path, uint16_t id)
+{
+	struct telephony_ctrl *tc;
+
+	DBG("");
+	tc = g_new0(struct telephony_ctrl, 1);
+	tc->device = g_strdup(path);
+	tc->path = g_strdup_printf("%s/Caller%u", path, id);
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+				       tc->path, BLUEZ_TELEPHONY_INTERFACE,
+				       telephony_methods,
+				       telephony_signals,
+				       telephony_properties, tc, NULL)) {
+		error("D-Bus failed to register %s path", tc->path);
+		telephony_destroy_device(tc);
+		return NULL;
+	}
+
+	DBG("%s", tc->path);
+
+	return tc;
+}
+
+void telephony_set_callbacks(struct telephony_ctrl *tp,
+			     const struct telephony_control_callback *cbs,
+			     void *user_data)
+{
+	struct call_callback *cb;
+
+	DBG("");
+
+	if (tp->cb)
+		g_free(tp->cb);
+
+	cb = g_new0(struct call_callback, 1);
+	cb->cbs = cbs;
+	cb->user_data = user_data;
+
+	tp->cb = cb;
+}
diff --git a/profiles/audio/telephony.h b/profiles/audio/telephony.h
new file mode 100644
index 000000000000..e321fb881beb
--- /dev/null
+++ b/profiles/audio/telephony.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024  Intel Corporation
+ *
+ */
+
+struct telephony_ctrl {
+	char	*device;	/* Device path */
+	char	*path;		/* Telephony object path */
+	char    *status;
+	uint8_t	call_status;   /* call status of active call*/
+	uint8_t call_index;    /* call index of active call */
+	struct  call_callback	*cb;
+};
+
+struct telephony_control_callback {
+	int (*call_answer)(struct telephony_ctrl *tc, void *user_data);
+	int (*call_reject)(struct telephony_ctrl *tc, void *user_data);
+};
+
+struct telephony_ctrl *telephony_create_device(const char *path, uint16_t id);
+
+void telephony_set_callbacks(struct telephony_ctrl *tc,
+			     const struct telephony_control_callback *cbs,
+			     void *user_data);
+
+void telephony_destroy_device(struct telephony_ctrl *tc);
+
+void telephony_set_incom_call_settings(struct telephony_ctrl *tc,
+				       const char *key, void *data, size_t len);
+void telephony_set_call_termination(struct telephony_ctrl *tc,
+				    const char *key, void *data, size_t len);
+
+void telephony_update_call_Info(struct telephony_ctrl *tc);
+
+struct ccp_call_list_evt {
+	uint8_t length;
+	uint8_t index;
+	uint8_t state;
+	uint8_t flag;
+};
+
+struct ccp_incoming_call_evt {
+	uint8_t length;
+	uint8_t index;
+};
+
+struct ccp_call_terminate_evt {
+	uint8_t length;
+	uint8_t index;
+	uint8_t reason;
+};
+
+enum call_state {
+	INCOMING_CALL = 0,
+	DIALLING_CALL,
+	ALERTING_CALL,
+	ACTIVE_CALL,
+	LOCAL_HOLD,
+	REMOTE_HOLD,
+	CALL_DISCONNECTED = 10
+};
diff --git a/src/shared/ccp.c b/src/shared/ccp.c
index 8e1b0b58f93b..25bb39713a13 100644
--- a/src/shared/ccp.c
+++ b/src/shared/ccp.c
@@ -3,7 +3,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2023  Intel Corporation. All rights reserved.
  *
  */
 
@@ -112,6 +112,55 @@ struct bt_ccs {
 };
 
 static struct queue *ccp_db;
+static struct bt_ccs *ccp_get_ccs(struct bt_ccp *ccp)
+{
+	if (!ccp)
+		return NULL;
+
+	if (ccp->rdb->ccs)
+		return ccp->rdb->ccs;
+
+	ccp->rdb->ccs = new0(struct bt_ccs, 1);
+	ccp->rdb->ccs->mdb = ccp->rdb;
+
+	return ccp->rdb->ccs;
+}
+
+static unsigned int ccp_send(struct bt_ccp *ccp, uint8_t index,
+			     uint8_t operation)
+{
+	int ret;
+	uint16_t handle;
+	uint8_t cmd[2];
+	struct bt_ccs *ccs = ccp_get_ccs(ccp);
+
+	cmd[0] = operation;
+	cmd[1] = index;
+
+	if (!ccp->client)
+		return -1;
+
+	if (!gatt_db_attribute_get_char_data(ccs->call_ctrl_point, NULL,
+					     &handle, NULL, NULL, NULL))
+		return -1;
+
+	ret = bt_gatt_client_write_without_response(ccp->client, handle, false,
+						    cmd, 2);
+	if (!ret)
+		return -1;
+
+	return 0;
+}
+
+unsigned int bt_ccp_call_answer(struct bt_ccp *ccp, uint8_t index)
+{
+	return ccp_send(ccp, index, 0);
+}
+
+unsigned int bt_ccp_call_reject(struct bt_ccp *ccp, uint8_t index)
+{
+	return ccp_send(ccp, index, 1);
+}
 
 static void ccp_debug(struct bt_ccp *ccp, const char *format, ...)
 {
@@ -429,20 +478,6 @@ static struct bt_ccs *ccs_new(struct gatt_db *db)
 	return ccs;
 }
 
-static struct bt_ccs *ccp_get_ccs(struct bt_ccp *ccp)
-{
-	if (!ccp)
-		return NULL;
-
-	if (ccp->rdb->ccs)
-		return ccp->rdb->ccs;
-
-	ccp->rdb->ccs = new0(struct bt_ccs, 1);
-	ccp->rdb->ccs->mdb = ccp->rdb;
-
-	return ccp->rdb->ccs;
-}
-
 static void ccp_pending_destroy(void *data)
 {
 	struct bt_ccp_pending *pending = data;
@@ -503,6 +538,8 @@ static void ccp_cb_register(uint16_t att_ecode, void *user_data)
 {
 	struct bt_ccp *ccp = user_data;
 
+	DBG(ccp, "");
+
 	if (att_ecode)
 		DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode);
 
@@ -515,27 +552,41 @@ static void ccp_cb_notify(uint16_t value_handle, const uint8_t *value,
 	 /* TODO: generic handler for non-mandatory CCP notifications */
 }
 
-static void ccp_cb_status_flag_register(uint16_t att_ecode, void *user_data)
+static void ccp_tc_update_call_list(struct bt_ccp *ccp,
+				    const uint8_t *value, uint16_t length)
 {
-	struct bt_ccp *ccp = user_data;
+	struct event_callback *cb = ccp->cb;
 
-	if (att_ecode)
-		DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode);
+	DBG(ccp, " ");
+
+	if (cb && cb->cbs && cb->cbs->call_list_update)
+		cb->cbs->call_list_update(ccp, value, length);
 }
 
-static void ccp_cb_status_flag_notify(uint16_t value_handle,
-				      const uint8_t *value,
-				      uint16_t length, void *user_data)
+static void ccp_tc_handle_incoming_call(struct bt_ccp *ccp,
+					const uint8_t *value, uint16_t length)
 {
-	struct bt_ccp *ccp = user_data;
+	struct event_callback *cb = ccp->cb;
 
-	DBG(ccp, "");
+	DBG(ccp, " ");
 
-	if (!length)
-		return;
+	if (cb && cb->cbs && cb->cbs->incoming_call)
+		cb->cbs->incoming_call(ccp, value, length);
 }
 
-static void ccp_cb_terminate_register(uint16_t att_ecode, void *user_data)
+static void ccp_tc_handle_terminate_call(struct bt_ccp *ccp,
+					 const uint8_t *value, uint16_t length)
+{
+	struct event_callback *cb = ccp->cb;
+
+	DBG(ccp, " ");
+
+	if (cb && cb->cbs && cb->cbs->terminate_call)
+		cb->cbs->terminate_call(ccp, value, length);
+}
+
+/* callback registered function */
+static void ccp_cb_status_flag_register(uint16_t att_ecode, void *user_data)
 {
 	struct bt_ccp *ccp = user_data;
 
@@ -543,20 +594,15 @@ static void ccp_cb_terminate_register(uint16_t att_ecode, void *user_data)
 		DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode);
 }
 
-static void ccp_cb_terminate_notify(uint16_t value_handle, const uint8_t *value,
-				    uint16_t length, void *user_data)
+static void ccp_cb_terminate_register(uint16_t att_ecode, void *user_data)
 {
 	struct bt_ccp *ccp = user_data;
 
-	DBG(ccp, "");
-
-	if (!length)
-		return;
-
-	/* TODO: update call state in Local context */
+	if (att_ecode)
+		DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode);
 }
 
-static void ccp_cb_bearer_name_register(uint16_t att_ecode, void *user_data)
+static void ccp_cb_call_list_register(uint16_t att_ecode, void *user_data)
 {
 	struct bt_ccp *ccp = user_data;
 
@@ -566,21 +612,17 @@ static void ccp_cb_bearer_name_register(uint16_t att_ecode, void *user_data)
 		DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode);
 }
 
-static void ccp_cb_bearer_name_notify(uint16_t value_handle,
-				      const uint8_t *value,
-				      uint16_t length, void *user_data)
+static void ccp_cb_call_state_register(uint16_t att_ecode, void *user_data)
 {
 	struct bt_ccp *ccp = user_data;
 
 	DBG(ccp, "");
 
-	if (!length)
-		return;
-
-	/* TODO: update call details in Local context */
+	if (att_ecode)
+		DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode);
 }
 
-static void ccp_cb_call_list_register(uint16_t att_ecode, void *user_data)
+static void ccp_cb_incom_call_register(uint16_t att_ecode, void *user_data)
 {
 	struct bt_ccp *ccp = user_data;
 
@@ -590,51 +632,52 @@ static void ccp_cb_call_list_register(uint16_t att_ecode, void *user_data)
 		DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode);
 }
 
-static void ccp_cb_call_list_notify(uint16_t value_handle, const uint8_t *value,
-				    uint16_t length, void *user_data)
+static void ccp_cb_bearer_name_register(uint16_t att_ecode, void *user_data)
 {
 	struct bt_ccp *ccp = user_data;
 
 	DBG(ccp, "");
 
-	if (!length)
-		return;
-
-	 /* TODO: update call list in Local context */
+	if (att_ecode)
+		DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode);
 }
 
-static void ccp_cb_call_state_register(uint16_t att_ecode, void *user_data)
+static void ccp_cb_status_flag_notify(uint16_t value_handle,
+				      const uint8_t *value,
+				      uint16_t length, void *user_data)
 {
 	struct bt_ccp *ccp = user_data;
+	DBG(ccp, "length  %d", length);
 
-	DBG(ccp, "");
-
-	if (att_ecode)
-		DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode);
+	if (!length)
+		return;
 }
 
-static void ccp_cb_call_state_notify(uint16_t value_handle,
-				     const uint8_t *value,
-				     uint16_t length, void *user_data)
+static void ccp_cb_terminate_notify(uint16_t value_handle,
+				    const uint8_t *value,
+				    uint16_t length, void *user_data)
 {
 	struct bt_ccp *ccp = user_data;
 
-	DBG(ccp, "");
+	DBG(ccp, "length  %d", length);
 
 	if (!length)
 		return;
 
-	/* TODO: update call state in Local context */
+	ccp_tc_handle_terminate_call(ccp, value, length);
 }
 
-static void ccp_cb_incom_call_register(uint16_t att_ecode, void *user_data)
+static void ccp_cb_call_list_notify(uint16_t value_handle, const uint8_t *value,
+				    uint16_t length, void *user_data)
 {
 	struct bt_ccp *ccp = user_data;
 
-	DBG(ccp, "");
+	DBG(ccp, "length  %d", length);
 
-	if (att_ecode)
-		DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode);
+	if (!length)
+		return;
+
+	ccp_tc_update_call_list(ccp, value, length);
 }
 
 static void ccp_cb_incom_call_notify(uint16_t value_handle,
@@ -643,12 +686,12 @@ static void ccp_cb_incom_call_notify(uint16_t value_handle,
 {
 	struct bt_ccp *ccp = user_data;
 
-	DBG(ccp, "");
+	DBG(ccp, "length  %d", length);
 
 	if (!length)
 		return;
 
-	/* TODO: Handle incoming call notofiation, Answer/reject etc */
+	ccp_tc_handle_incoming_call(ccp, value, length);
 }
 
 static void bt_ccp_incom_call_attach(struct bt_ccp *ccp)
@@ -691,7 +734,7 @@ static void bt_ccp_call_state_attach(struct bt_ccp *ccp)
 		bt_gatt_client_register_notify(ccp->client,
 					       value_handle,
 					       ccp_cb_call_state_register,
-					       ccp_cb_call_state_notify, ccp,
+					       NULL, ccp,
 					       NULL);
 }
 
@@ -735,7 +778,7 @@ static void bt_ccp_name_attach(struct bt_ccp *ccp)
 		bt_gatt_client_register_notify(ccp->client,
 					       value_handle,
 					       ccp_cb_bearer_name_register,
-					       ccp_cb_bearer_name_notify, ccp,
+					       NULL, ccp,
 					       NULL);
 }
 
@@ -799,7 +842,7 @@ static void bt_ccp_uci_attach(struct bt_ccp *ccp)
 	ccp->bearer_uci_id = bt_gatt_client_register_notify(ccp->client,
 							    value_handle,
 							    ccp_cb_register,
-							    ccp_cb_notify, ccp,
+							    NULL, ccp,
 							    NULL);
 }
 
@@ -820,7 +863,7 @@ static void bt_ccp_technology_attach(struct bt_ccp *ccp)
 	ccp->bearer_technology_id =
 		bt_gatt_client_register_notify(ccp->client,
 					       value_handle, ccp_cb_register,
-					       ccp_cb_notify, ccp, NULL);
+					       NULL, ccp, NULL);
 }
 
 static void bt_ccp_strength_attach(struct bt_ccp *ccp)
@@ -839,7 +882,7 @@ static void bt_ccp_strength_attach(struct bt_ccp *ccp)
 
 	ccp->signal_strength_id =
 		bt_gatt_client_register_notify(ccp->client, value_handle,
-					       ccp_cb_register, ccp_cb_notify,
+					       ccp_cb_register, NULL,
 					       ccp, NULL);
 }
 
@@ -859,7 +902,7 @@ static void bt_ccp_ccid_attach(struct bt_ccp *ccp)
 	ccp->ccid_id = bt_gatt_client_register_notify(ccp->client,
 						      value_handle,
 						      ccp_cb_register,
-						      ccp_cb_notify, ccp, NULL);
+						      NULL, ccp, NULL);
 }
 
 static void bt_ccp_tar_uri_attach(struct bt_ccp *ccp)
@@ -879,7 +922,7 @@ static void bt_ccp_tar_uri_attach(struct bt_ccp *ccp)
 	ccp->target_bearer_uri_id =
 		bt_gatt_client_register_notify(ccp->client,
 					       value_handle, ccp_cb_register,
-					       ccp_cb_notify, ccp,
+					       NULL, ccp,
 					       NULL);
 }
 
@@ -900,7 +943,7 @@ static void bt_ccp_ctrl_point_attach(struct bt_ccp *ccp)
 	ccp->call_control_pt_id =
 		bt_gatt_client_register_notify(ccp->client,
 					       value_handle, ccp_cb_register,
-					       ccp_cb_notify, ccp, NULL);
+					       NULL, ccp, NULL);
 }
 
 static void bt_ccp_ctrl_opcode_attach(struct bt_ccp *ccp)
@@ -920,7 +963,7 @@ static void bt_ccp_ctrl_opcode_attach(struct bt_ccp *ccp)
 	ccp->call_control_opt_opcode_id =
 		bt_gatt_client_register_notify(ccp->client,
 					       value_handle, ccp_cb_register,
-					       ccp_cb_notify, ccp, NULL);
+					       NULL, ccp, NULL);
 }
 
 static void bt_ccp_friendly_name_attach(struct bt_ccp *ccp)
@@ -940,7 +983,7 @@ static void bt_ccp_friendly_name_attach(struct bt_ccp *ccp)
 	ccp->friendly_name_id =
 		bt_gatt_client_register_notify(ccp->client,
 					       value_handle, ccp_cb_register,
-					       ccp_cb_notify, ccp, NULL);
+					       NULL, ccp, NULL);
 }
 
 static void bt_ccp_signal_intrvl_attach(struct bt_ccp *ccp)
@@ -960,7 +1003,7 @@ static void bt_ccp_signal_intrvl_attach(struct bt_ccp *ccp)
 	ccp->signal_reporting_intrvl_id =
 		bt_gatt_client_register_notify(ccp->client,
 					       value_handle, ccp_cb_register,
-					       ccp_cb_notify, ccp, NULL);
+					       NULL, ccp, NULL);
 }
 
 static void bt_ccp_uri_list_attach(struct bt_ccp *ccp)
@@ -980,7 +1023,7 @@ static void bt_ccp_uri_list_attach(struct bt_ccp *ccp)
 	ccp->bearer_uri_schemes_list_id =
 		bt_gatt_client_register_notify(ccp->client,
 					       value_handle, ccp_cb_register,
-					       ccp_cb_notify, ccp, NULL);
+					       NULL, ccp, NULL);
 }
 
 static void foreach_ccs_char(struct gatt_db_attribute *attr, void *user_data)
@@ -988,7 +1031,8 @@ static void foreach_ccs_char(struct gatt_db_attribute *attr, void *user_data)
 	struct bt_ccp *ccp = user_data;
 	struct bt_ccs *ccs;
 	uint16_t value_handle;
-	bt_uuid_t uuid;
+	bt_uuid_t uuid, uuid16;
+	uint16_t be16;
 
 	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
 					     NULL, NULL, &uuid))
@@ -998,105 +1042,122 @@ static void foreach_ccs_char(struct gatt_db_attribute *attr, void *user_data)
 	if (!ccs || ccs->call_state)
 		return;
 
-	if (bt_uuid16_cmp(&uuid, BEARER_PROVIDER_NAME_CHRC_UUID)) {
+	uuid16.type  =  uuid.type;
+
+	if (uuid.type == BT_UUID16) {
+		DBG(ccp, "uuid %x", uuid.value.u16);
+		uuid16.value.u16 = uuid.value.u16;
+	} else if (uuid.type == BT_UUID128) {
+		DBG(ccp, "uuid is u128 ");
+		uuid16.type = BT_UUID16;
+		memcpy(&be16, &uuid.value.u128.data[2], 2);
+		uuid16.value.u16 = htons(be16);
+	} else {
+		DBG(ccp, "unexpected uuid type %d", uuid16.type);
+		return;
+	}
+
+	DBG(ccp, "uuid read from gatt database %x", uuid16.value.u16);
+
+	if (bt_uuid16_cmp(&uuid16, BEARER_PROVIDER_NAME_CHRC_UUID)) {
 		DBG(ccp, "Found Bearer Name, handle 0x%04x", value_handle);
 
 		ccs->bearer_name = attr;
 		bt_ccp_name_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, BEARER_UCI_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, BEARER_UCI_CHRC_UUID)) {
 		DBG(ccp, "Found Bearer Uci, handle 0x%04x", value_handle);
 
 		ccs->bearer_uci = attr;
 		bt_ccp_uci_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, BEARER_TECH_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, BEARER_TECH_CHRC_UUID)) {
 		DBG(ccp, "Found Bearer Technology, handle %x", value_handle);
 
 		ccs->bearer_technology = attr;
 		bt_ccp_technology_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, BEARER_SIGNAL_STR_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, BEARER_SIGNAL_STR_CHRC_UUID)) {
 		DBG(ccp, "Found Signal Strength, handle 0x%04x", value_handle);
 
 		ccs->signal_strength = attr;
 		bt_ccp_strength_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, BEARER_SIGNAL_INTRVL_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, BEARER_SIGNAL_INTRVL_CHRC_UUID)) {
 		DBG(ccp, "Found Signal Interval, handle 0x%04x", value_handle);
 
 		ccs->signal_reporting_intrvl = attr;
 		bt_ccp_signal_intrvl_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, CALL_STATUS_FLAG_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, CALL_STATUS_FLAG_CHRC_UUID)) {
 		DBG(ccp, "Found Status Flag, handle 0x%04x", value_handle);
 
 		ccs->status_flag = attr;
 		bt_ccp_status_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, BEARER_URI_SCHEME_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, BEARER_URI_SCHEME_CHRC_UUID)) {
 		DBG(ccp, "Found URI Scheme, handle 0x%04x", value_handle);
 
 		ccs->bearer_uri_schemes_list = attr;
 		bt_ccp_uri_list_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, CURR_CALL_LIST_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, CURR_CALL_LIST_CHRC_UUID)) {
 		DBG(ccp, "Found Call List, handle 0x%04x", value_handle);
 
 		ccs->current_call_list = attr;
 		bt_ccp_call_list_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, BEARER_CCID_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, BEARER_CCID_CHRC_UUID)) {
 		DBG(ccp, "Found CCID, handle 0x%04x", value_handle);
 
 		ccs->ccid = attr;
 		bt_ccp_ccid_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, INCOM_CALL_TARGET_URI_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, INCOM_CALL_TARGET_URI_CHRC_UUID)) {
 		DBG(ccp, "Found Bearer Uri, handle 0x%04x", value_handle);
 
 		ccs->target_bearer_uri = attr;
 		bt_ccp_tar_uri_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, CALL_CTRL_POINT_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, CALL_CTRL_POINT_CHRC_UUID)) {
 		DBG(ccp, "Found Control Point, handle 0x%04x", value_handle);
 
 		ccs->call_ctrl_point = attr;
 		bt_ccp_ctrl_point_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, CALL_CTRL_POINT_OPT_OPCODE_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, CALL_CTRL_POINT_OPT_OPCODE_CHRC_UUID)) {
 		DBG(ccp, "Found Control opcode, handle 0x%04x", value_handle);
 
 		ccs->call_ctrl_opt_opcode = attr;
 		bt_ccp_ctrl_opcode_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, TERMINATION_REASON_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, TERMINATION_REASON_CHRC_UUID)) {
 		DBG(ccp, "Found Termination Reason, handle %x", value_handle);
 
 		ccs->termination_reason = attr;
 		bt_ccp_term_reason_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, INCOMING_CALL_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, INCOMING_CALL_CHRC_UUID)) {
 		DBG(ccp, "Found Incoming call, handle 0x%04x", value_handle);
 
 		ccs->incoming_call = attr;
 		bt_ccp_incom_call_attach(ccp);
 	}
 
-	if (bt_uuid16_cmp(&uuid, CALL_FRIENDLY_NAME_CHRC_UUID)) {
+	if (bt_uuid16_cmp(&uuid16, CALL_FRIENDLY_NAME_CHRC_UUID)) {
 		DBG(ccp, "Found Friendly name, handle 0x%04x", value_handle);
 
 		ccs->friendly_name = attr;
diff --git a/src/shared/ccp.h b/src/shared/ccp.h
index 28b8b034ece3..3298abe9014c 100644
--- a/src/shared/ccp.h
+++ b/src/shared/ccp.h
@@ -3,7 +3,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2023  Intel Corporation. All rights reserved.
  *
  */
 
@@ -18,14 +18,18 @@ struct bt_ccp;
 struct bt_ccp_db;
 struct bt_ccp_session_info;
 
-typedef void (*bt_ccp_debug_func_t)(const char *str, void *user_data);
-typedef void (*bt_ccp_destroy_func_t)(void *user_data);
-
 struct bt_ccp_event_callback {
-	void (*call_state)(struct bt_ccp *ccp,  const uint8_t *value,
-			   uint16_t length);
+	void (*incoming_call)(struct bt_ccp *ccp,
+			      const uint8_t *value, uint16_t len);
+	void (*terminate_call)(struct bt_ccp *ccp,
+			       const uint8_t *value, uint16_t len);
+	void (*call_list_update)(struct bt_ccp *ccp,
+				 const uint8_t *value, uint16_t len);
 };
 
+typedef void (*bt_ccp_debug_func_t)(const char *str, void *user_data);
+typedef void (*bt_ccp_destroy_func_t)(void *user_data);
+
 void bt_ccp_set_event_callbacks(struct bt_ccp *ccp,
 				const struct bt_ccp_event_callback *cbs,
 				void *user_data);
@@ -43,3 +47,6 @@ void bt_ccp_unref(struct bt_ccp *ccp);
 
 bool bt_ccp_set_user_data(struct bt_ccp *ccp, void *user_data);
 void *bt_ccp_get_user_data(struct bt_ccp *ccp);
+
+unsigned int bt_ccp_call_answer(struct bt_ccp *ccp, uint8_t index);
+unsigned int bt_ccp_call_reject(struct bt_ccp *ccp, uint8_t index);
-- 
2.34.1

