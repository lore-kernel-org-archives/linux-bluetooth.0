Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C714F11A
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074690; cv=none; b=MtnIbZ+4YCYZOvJWXU0dCdOSPZaj+DSXeiXhMiz+095ShlOcm2e+BaxWqC+PeLlUefxkKhMoEwDLNOf3EZaCWw/LcizkvzmJFydtjgiI6RY/K4b363tzuLsSVadwLh8NmrZF+Bzvs/6893Q4gtAJP9aXG/kvUCZLuxuUpRAMzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074690; c=relaxed/simple;
	bh=mLOdjEDXxcawAfcIKTW1TD6/CsHlyHU8zkn48HRyP9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bAa6mY6aY753XX2cSZkPfnO9QlSR/BAuirUhGNnRwtgGuybOmjSymC5gUAoVtjEcUOUw7NE3Ai7tRGgUX8mz9RQsp4GAuFb+mJtGpaM+nbFr0I0FJnhqcI0V6+6BFRh7XcdUEMI/27vvI/JPCesy/JnHXWFnLuS/mGq+b8SgNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bA45C8MW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bA45C8MW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715074688; x=1746610688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mLOdjEDXxcawAfcIKTW1TD6/CsHlyHU8zkn48HRyP9A=;
  b=bA45C8MWlEcz+D9us8M4m0kQf77QiP7bpJjdc8fuBMUbxG7h5PjeAs+U
   3HOlGGrysPd/5L0uvhFU99l+wxkxim+1fLlxE0QEN0cgE3t1RaYP77GzY
   6qU9mwrMX/9TuAwLlTwCll5CvlKJewf4JpMkIkm1wZgXCtsLt4dF1eNj/
   3tTK0lFtDoJKEI+P1JTaxbDvoaZQ8CT0DBd5KD9BM3eoNxNbDDWUX+YSr
   CVj7KtUTPFkP02hOD9xzjedImvmMFNhwj6IpNEoMkYk9IQ6qX3/L67b75
   xLcjiUxMIB+zADnyiRFAqiCK1g6wvR8Fxq36wDR/tUMGAxks9RFghh4pC
   g==;
X-CSE-ConnectionGUID: 75OA4NSxTEKaeNiRcRNc3A==
X-CSE-MsgGUID: I1vEgTeaSsOH8Mjay27BCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="28330007"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28330007"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 02:38:07 -0700
X-CSE-ConnectionGUID: 0Q/pGAVwTQq04XRNoobMJQ==
X-CSE-MsgGUID: TsBxw0M3SmWHWMY/s6RD6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="33029581"
Received: from weba0535.iind.intel.com ([10.224.186.30])
  by fmviesa004.fm.intel.com with ESMTP; 07 May 2024 02:38:06 -0700
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH BlueZ v3] bluetoothctl: Add submenu for Call control profile testing
Date: Tue,  7 May 2024 18:04:30 +0300
Message-Id: <20240507150430.689504-1-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds submenu in bluetoothctl for CCP Testing with
options like answer and reject the active call. This feature
is tested with windows machine as CCP server which uses Teams
application to make calls

Signed-off-by: Ajay KV <ajay.k.v@intel.com>
---
 Makefile.tools    |   4 +-
 client/ccp_test.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++
 client/ccp_test.h |  12 +++
 client/main.c     |   3 +
 4 files changed, 230 insertions(+), 1 deletion(-)
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
index 000000000000..c7d5d173f179
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
+	str = proxy_description(proxy, "CCP", description);
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
+	.name = "ccp",
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
index c8b0f7f1c2d8..e3836d5ed3f9 100644
--- a/client/main.c
+++ b/client/main.c
@@ -34,6 +34,7 @@
 #include "admin.h"
 #include "player.h"
 #include "mgmt.h"
+#include "ccp_test.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
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

