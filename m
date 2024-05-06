Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E1158D9D
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020225; cv=none; b=Ez23Xbq25ykvfxVXQrvyshXIKsK3Wsnqi4Zdk5P4IIWoHM8CJtKhaEAD5mb5biQFdo6+EPDLKgSqIJEA104aCXqu77G+14VW5SMNUvnCgMfDC+GFz/40/qbe83et1lugOvPpT/SAUJblQ67GMbX/Ep1kPlGB3GiOwljOtBRlNRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020225; c=relaxed/simple;
	bh=3dULno0Tr+lOcQq1CTHv0YMLDkY9SUl2xMPsi0kVfYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C8SHXT1Tja2g0wXSq/+wNR863yL+3HHb5x/rpCN41NHL+i1Rl3cEFfwZ7WT/IKPwkvRQzlN4x17RtaBS2IsLmmdXTXnWPHtBG0AXKuCXKE4T3dQMhcF1orf9EiPClVK25AoHm0bOXxmhhH7w+jgUVfAFkN6MA6wgzDBHHcEnwjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsFGymEm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsFGymEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715020223; x=1746556223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3dULno0Tr+lOcQq1CTHv0YMLDkY9SUl2xMPsi0kVfYg=;
  b=VsFGymEm2D/Jzw3kONlUy+HVw9y5hgDWeqgOHChhfMFZVYqJBHEt8BZG
   AQYoHF8TXKJQ6kkWcgg0ateqBA/iaS0KRiJtVpYsTLvC3L+9G0idY8+Df
   35PJAjPQCY1jGRJdKb4zlsxsAGiDijkAfsNNLoj69cXXkZyzBLIJt2eAm
   gOrecNN8DcTDDu3iJOWAmxyf9Uj8+gY32dqmckWdFeNhHd26z/jbReXad
   wHwOYNyni81A/kziQVR2yYTmyWWcluNJRLIFaBnfgyv19GMZNb/8nnhUi
   Gz52c5bH5pXrIW1yoTaTN3GMKTPx9TY0WyYgfeTVV1wweCGqc6/b4pXaf
   g==;
X-CSE-ConnectionGUID: IDK5sNoSRxCrkg8yRDUSIg==
X-CSE-MsgGUID: fCUVjqyUTnOJWwYKjanppQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="13733010"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="13733010"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 11:30:23 -0700
X-CSE-ConnectionGUID: 4xocfMLCTJK7EcvVEoJ/xA==
X-CSE-MsgGUID: HGLNa3PnTr29Bhu1uNy6dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="32721843"
Received: from weba0535.iind.intel.com ([10.224.186.30])
  by fmviesa005.fm.intel.com with ESMTP; 06 May 2024 11:30:21 -0700
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH BlueZ v2] bluetoothctl: Add submenu for Call control profile testing
Date: Tue,  7 May 2024 02:56:43 +0300
Message-Id: <20240506235643.114778-1-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds submeu in bluetoothctl for CCP Testing with
options like answer and reject the active call . This feature
is tested with windows machnine as CCP server which uses Teams
application to make calls

Signed-off-by: Ajay KV <ajay.k.v@intel.com>
---
 Makefile.tools    |   4 +-
 client/ccp_test.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++
 client/ccp_test.h |  12 +++
 client/main.c     |   5 +-
 4 files changed, 231 insertions(+), 2 deletions(-)
 create mode 100644 client/ccp_test.c
 create mode 100644 client/ccp_test.h

diff --git a/Makefile.tools b/Makefile.tools
index 679c914bf8cd..a5587427f549 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -13,7 +13,9 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/gatt.h client/gatt.c \
 					client/admin.h client/admin.c \
 					client/player.h client/player.c \
-					client/mgmt.h client/mgmt.c
+					client/mgmt.h client/mgmt.c \
+					client/ccp_test.c \
+					client/ccp_test.h
 client_bluetoothctl_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la src/libshared-glib.la \
 			$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
diff --git a/client/ccp_test.c b/client/ccp_test.c
new file mode 100644
index 000000000000..d53fc2393c13
--- /dev/null
+++ b/client/ccp_test.c
@@ -0,0 +1,212 @@
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
+#include "ccp_test.h"
+
+/* String display constants */
+#define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
+#define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
+
+#define BLUEZ_CCP_TEST_INTERFACE "org.bluez.CCPTest1"
+
+static DBusConnection *dbus_conn;
+static GDBusProxy *default_call;
+static GList *callList;
+static GDBusClient *client;
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
+	str = proxy_description(proxy, "CCPTest", description);
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
+	.name = "ccp test",
+	.desc = "ccp test settings submenu",
+	.entries = {
+		    { "answer", NULL, cmd_answer, "answer the active call" },
+		    { "reject", NULL, cmd_reject, "reject the active call" },
+		   },
+};
+
+static void ccp_add_call(GDBusProxy *proxy)
+{
+	bt_shell_printf("[CHG] CCP Test caller added\n");
+	callList = g_list_append(callList, proxy);
+
+	if (!default_call)
+		default_call = proxy;
+
+	print_info(proxy, COLORED_NEW);
+}
+
+static void ccp_remove_call(GDBusProxy *proxy)
+{
+	bt_shell_printf("[CHG] CCP Test caller removed\n");
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
+	if (!strcmp(interface, BLUEZ_CCP_TEST_INTERFACE))
+		ccp_add_call(proxy);
+}
+
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_CCP_TEST_INTERFACE))
+		ccp_remove_call(proxy);
+}
+
+static void ccptest_property_changed(GDBusProxy *proxy, const char *name,
+				     DBusMessageIter *iter)
+{
+	char *str;
+
+	str = proxy_description(proxy, "CCP Test", COLORED_CHG);
+	print_iter(str, name, iter);
+	g_free(str);
+
+	bt_shell_printf("[CHG] CCP Test property : %s\n", name);
+}
+
+static void property_changed(GDBusProxy *proxy, const char *name,
+			     DBusMessageIter *iter, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_CCP_TEST_INTERFACE))
+		ccptest_property_changed(proxy, name, iter);
+}
+
+void ccptest_add_submenu(void)
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
+void ccptest_remove_submenu(void)
+{
+	g_dbus_client_unref(client);
+}
diff --git a/client/ccp_test.h b/client/ccp_test.h
new file mode 100644
index 000000000000..fc2ab2042bb8
--- /dev/null
+++ b/client/ccp_test.h
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
+void ccptest_add_submenu(void);
+void ccptest_remove_submenu(void);
diff --git a/client/main.c b/client/main.c
index c8b0f7f1c2d8..dba6dea639d9 100644
--- a/client/main.c
+++ b/client/main.c
@@ -34,6 +34,7 @@
 #include "admin.h"
 #include "player.h"
 #include "mgmt.h"
+#include "ccp_test.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -3060,7 +3061,7 @@ static const struct bt_shell_menu gatt_menu = {
 					"Unregister application service" },
 	{ "register-includes", "<UUID> [handle]", cmd_register_includes,
 					"Register as Included service in." },
-	{ "unregister-includes", "<Service-UUID> <Inc-UUID>",
+	{ "unregister-includes", "<Service-UUID><Inc-UUID>",
 			cmd_unregister_includes,
 				 "Unregister Included service." },
 	{ "register-characteristic",
@@ -3199,6 +3200,7 @@ int main(int argc, char *argv[])
 
 	admin_add_submenu();
 	player_add_submenu();
+	ccptest_add_submenu();
 	mgmt_add_submenu();
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
@@ -3216,6 +3218,7 @@ int main(int argc, char *argv[])
 
 	admin_remove_submenu();
 	player_remove_submenu();
+	ccptest_remove_submenu();
 	mgmt_remove_submenu();
 
 	g_dbus_client_unref(client);
-- 
2.34.1

