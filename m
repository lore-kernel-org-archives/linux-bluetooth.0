Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19C2770F2
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277144; cv=none; b=jus6NuvaWvvq8XtjvLiqdz5ivofrucH7lJBTA2kaCxWa6WwTSMzKhndcdqcU8rRqYBuB4ZOop2iNw+27X8Sv4iTKvTpSLUvnKWOymUDf+bf88IkliHptQ+ukMVVnA3xpie2IkJW8sRXi8MEOs0yTOGq5fdAlDq5p87GWv5Mqvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277144; c=relaxed/simple;
	bh=mLOdjEDXxcawAfcIKTW1TD6/CsHlyHU8zkn48HRyP9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqyVS2ZCLdAISBtABmIzs6QpQJrMmP8FdWcUyup9QDRZvFuTKNxZjmd9Ttgssnr/xmK/Zcw6A3pSnITTaAWve9hqkdUhGn6l7lk3bRcVZGsMK0SlxVEaPXjZnk6Rlw9wT+yUZn1om/Mr3fuuwvTkoTRrFP1YKjg3P9e64pm5fFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3nZY2sP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3nZY2sP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715277143; x=1746813143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mLOdjEDXxcawAfcIKTW1TD6/CsHlyHU8zkn48HRyP9A=;
  b=m3nZY2sPGSfTrzEF0xepOKBX2+Wz4Fwy7db2rHSuBrbY+XStFPGeeVPu
   GYiuHcgnTHrRpFcyE/zZ6g45WS/SNX9zdxgvh7/up/rMiGXJK1x/cB237
   I2gDZXSUt5Dxg0nwNeteYnAEOQaYTmkSoHycC3mWZQEuQ/TzmVJMv6x5N
   LBPwzJHnMLfVFN69gJxZpY2/s++v9qRyOAOjK5KeSePGe9RiMW4SgKqsY
   MakiQ0F5Ani31aPIrSqkBh76cyl+a6cPRiYkA3G5AaGtD9Pqqk9S0ZJeL
   9HrLeBl+OG6EpThsngDNUitUrTYSy97bPrddoI02o9agwJ8U/yXjfCh/O
   w==;
X-CSE-ConnectionGUID: fUmLakI/TsSO/6NLMmF26Q==
X-CSE-MsgGUID: RGqdYlRGQPqUMiZOGZ1uEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28727816"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="28727816"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 10:52:22 -0700
X-CSE-ConnectionGUID: VaUifb+cTR28hrYG2LyE5A==
X-CSE-MsgGUID: X7k0rNS8TKCO3BEy72+vkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="29268254"
Received: from weba0535.iind.intel.com ([10.224.186.30])
  by fmviesa008.fm.intel.com with ESMTP; 09 May 2024 10:52:21 -0700
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH v4 2/2] bluetoothctl: Add submenu for Call control profile testing
Date: Fri, 10 May 2024 02:18:39 +0300
Message-Id: <20240509231839.3005270-2-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509231839.3005270-1-ajay.k.v@intel.com>
References: <20240509231839.3005270-1-ajay.k.v@intel.com>
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

