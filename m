Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752173E558F
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106150; cv=none; b=O8wBH+4fWvd/B7g1ocLgHXo41QoeZI53mKWiVXLyr5Eu4lzuh2SWQD83NFXfZ+dsHDaUDq+Zq65kXHZhoBGshpFoq3ctpqju0+WxkQbiCWCXPzcv1g7H41MQb0FFaPwUHDK1c0M3TvGqeFtyuTLhbpCVWhg0GUQZ3jGUEHE69SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106150; c=relaxed/simple;
	bh=yIOZupxsXJTLr/7IAkr2LHb6AKXwcSSxMTxNPONUFss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjLqw86BaOa2VU4EzEv+MEDC2m81BS0X4qzTLmyt92QE22D5tCwC43yOY4nS6pUO/r//ypK+nm6+/fBQnTZqJAyxb5wGaLdtcX6/H5PKgB+eoLl6ek8w83ISZh4FqWhZWGAdxApikSJJtPoBKISF+20X0Di18GA137KMwz87HGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TLFh25q2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TLFh25q2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784106134;
	bh=yIOZupxsXJTLr/7IAkr2LHb6AKXwcSSxMTxNPONUFss=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TLFh25q29QgPr+6HYxOmuR75DiKRAKN7tHVhEE2Clioo/vbKNqP/ZKOWOIMc1fQ8o
	 8DWId5JbARUSo8WJHlooFVgV6j6E4nSOVX1C35PWajSux4Av1H16VUuH+2suZkrc2a
	 gfmmLx88CV99ez/GNpluE8HVFRaFjfgaWuTdsi71WJsa2kEFLEdd7DNvRFJCp+uOEF
	 X/+VKMFT/DjVj/S0wocr3cp+i3W5DiVr4mC+3KTWzrLoQBgt31Z4h9SJHU+IOB6MhE
	 vH3suKVQFtR4pbmmannl1g5XRb6OJxEow5Tcw59s/+Bp/+f14jMh6zJq8UsK41CcHU
	 o7MEPQTONEelQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3AF9117E010F
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:02:14 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/8] client/bluetoothctl: make admin.allow controller-aware
Date: Wed, 15 Jul 2026 11:02:00 +0200
Message-ID: <20260715090206.212130-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715090206.212130-1-frederic.danis@collabora.com>
References: <20260715090206.212130-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Teach admin.allow to target the selected default controller when no
controller is provided, and to accept an explicit [ctrl] argument.

Replace single cached AdminPolicy proxies with per-controller proxy
lookup keyed by controller object path, so controller selection changes
are respected.

Export controller lookup/default helpers and shared controller
completion from main.c for reuse by admin.c.

Assisted-by: GPT:GPT-5.3-Codex
---
 client/admin.c | 114 ++++++++++++++++++++++++++++++++++++++-----------
 client/admin.h |   4 ++
 client/main.c  |  25 +++++++++--
 3 files changed, 116 insertions(+), 27 deletions(-)

diff --git a/client/admin.c b/client/admin.c
index dc218ed2c..584d4630b 100644
--- a/client/admin.c
+++ b/client/admin.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include "bluetooth/bluetooth.h"
 #include "gdbus/gdbus.h"
 #include "src/shared/shell.h"
 
@@ -23,27 +24,79 @@
 #define _GNU_SOURCE
 
 static DBusConnection *dbus_conn;
-static GList *admin_proxies;
-static GDBusProxy *set_proxy;
-static GDBusProxy *status_proxy;
+static GList *set_proxies;
+static GList *status_proxies;
 
 static void admin_menu_pre_run(const struct bt_shell_menu *menu);
 
-static void admin_policy_set_set_proxy(GDBusProxy *proxy)
+static GDBusProxy *admin_policy_find_proxy(GList *proxies,
+						const char *path)
 {
-	set_proxy = proxy;
+	GList *list;
+
+	for (list = g_list_first(proxies); list; list = g_list_next(list)) {
+		GDBusProxy *proxy = list->data;
+
+		if (!strcmp(g_dbus_proxy_get_path(proxy), path))
+			return proxy;
+	}
+
+	return NULL;
+}
+
+static GDBusProxy *admin_policy_get_status_proxy(const char *controller_path)
+{
+	if (!controller_path)
+		return NULL;
+
+	return admin_policy_find_proxy(status_proxies, controller_path);
+}
+
+static GDBusProxy *admin_policy_get_set_proxy(const char *controller_path)
+{
+	if (!controller_path)
+		return NULL;
+
+	return admin_policy_find_proxy(set_proxies, controller_path);
 }
 
-static void admin_policy_set_status_proxy(GDBusProxy *proxy)
+static GDBusProxy *admin_policy_get_controller(int argc, char *argv[],
+						int *arg_index)
 {
-	status_proxy = proxy;
+	GDBusProxy *controller;
+
+	*arg_index = 1;
+
+	if (argc > 1 && strlen(argv[1])) {
+		controller = bluetoothctl_find_controller(argv[1]);
+		if (controller) {
+			*arg_index = 2;
+			return controller;
+		}
+
+		if (bachk(argv[1]) == 0) {
+			bt_shell_printf("Controller %s not available\n",
+								argv[1]);
+			return NULL;
+		}
+	}
+
+	controller = bluetoothctl_get_default_controller();
+	if (controller)
+		return controller;
+
+	bt_shell_printf("No default controller available\n");
+	return NULL;
 }
 
-static void admin_policy_read_service_allowlist(DBusConnection *dbus_conn)
+static void admin_policy_read_service_allowlist(GDBusProxy *controller)
 {
 	DBusMessageIter iter, subiter;
+	GDBusProxy *status_proxy;
 	char *uuid = NULL;
+	const char *controller_path = g_dbus_proxy_get_path(controller);
 
+	status_proxy = admin_policy_get_status_proxy(controller_path);
 	if (!status_proxy || !g_dbus_proxy_get_property(status_proxy,
 						"ServiceAllowList", &iter)) {
 		bt_shell_printf("Failed to get property\n");
@@ -106,10 +159,14 @@ static void set_service_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
-static void admin_policy_set_service_allowlist(int argc, char *argv[])
+static void admin_policy_set_service_allowlist(GDBusProxy *controller,
+						int argc, char *argv[])
 {
 	struct uuid_list_data data;
+	GDBusProxy *set_proxy;
+	const char *controller_path = g_dbus_proxy_get_path(controller);
 
+	set_proxy = admin_policy_get_set_proxy(controller_path);
 	if (!set_proxy) {
 		bt_shell_printf("Set proxy not ready\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -128,15 +185,23 @@ static void admin_policy_set_service_allowlist(int argc, char *argv[])
 
 static void cmd_admin_allow(int argc, char *argv[])
 {
-	if (argc <= 1) {
-		admin_policy_read_service_allowlist(dbus_conn);
+	GDBusProxy *controller;
+	int arg_index;
+
+	controller = admin_policy_get_controller(argc, argv, &arg_index);
+	if (!controller)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (argc <= arg_index) {
+		admin_policy_read_service_allowlist(controller);
 		return;
 	}
 
-	if (strcmp(argv[1], "clear") == 0)
-		argc--;
+	if (strcmp(argv[arg_index], "clear") == 0)
+		arg_index++;
 
-	admin_policy_set_service_allowlist(argc - 1, argv + 1);
+	admin_policy_set_service_allowlist(controller, argc - arg_index,
+						argv + arg_index);
 }
 
 static const struct bt_shell_menu admin_menu = {
@@ -144,15 +209,15 @@ static const struct bt_shell_menu admin_menu = {
 	.desc = "Admin Policy Submenu",
 	.pre_run = admin_menu_pre_run,
 	.entries = {
-	{ "allow", "[clear/uuid1 uuid2 ...]", cmd_admin_allow,
-				"Allow service UUIDs and block rest of them"},
+	{ "allow", "[ctrl] [clear/uuid1 uuid2 ...]", cmd_admin_allow,
+				"Allow service UUIDs and block rest of them",
+				bluetoothctl_controller_generator},
 	{} },
 };
 
 static void admin_policy_status_added(GDBusProxy *proxy)
 {
-	admin_proxies = g_list_append(admin_proxies, proxy);
-	admin_policy_set_status_proxy(proxy);
+	status_proxies = g_list_append(status_proxies, proxy);
 }
 
 static void proxy_added(GDBusProxy *proxy, void *user_data)
@@ -162,15 +227,14 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	interface = g_dbus_proxy_get_interface(proxy);
 
 	if (!strcmp(interface, "org.bluez.AdminPolicySet1"))
-		admin_policy_set_set_proxy(proxy);
+		set_proxies = g_list_append(set_proxies, proxy);
 	else if (!strcmp(interface, "org.bluez.AdminPolicyStatus1"))
 		admin_policy_status_added(proxy);
 }
 
 static void admin_policy_status_removed(GDBusProxy *proxy)
 {
-	admin_proxies = g_list_remove(admin_proxies, proxy);
-	admin_policy_set_status_proxy(NULL);
+	status_proxies = g_list_remove(status_proxies, proxy);
 }
 
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
@@ -180,7 +244,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	interface = g_dbus_proxy_get_interface(proxy);
 
 	if (!strcmp(interface, "org.bluez.AdminPolicySet1"))
-		admin_policy_set_set_proxy(NULL);
+		set_proxies = g_list_remove(set_proxies, proxy);
 	else if (!strcmp(interface, "org.bluez.AdminPolicyStatus1"))
 		admin_policy_status_removed(proxy);
 }
@@ -189,8 +253,10 @@ static GDBusClient *client;
 
 static void disconnect_handler(DBusConnection *connection, void *user_data)
 {
-	g_list_free_full(admin_proxies, NULL);
-	admin_proxies = NULL;
+	g_list_free_full(set_proxies, NULL);
+	set_proxies = NULL;
+	g_list_free_full(status_proxies, NULL);
+	status_proxies = NULL;
 }
 
 void admin_add_submenu(void)
diff --git a/client/admin.h b/client/admin.h
index 0047770dc..be58fb2fa 100644
--- a/client/admin.h
+++ b/client/admin.h
@@ -10,3 +10,7 @@
 
 void admin_add_submenu(void);
 void admin_remove_submenu(void);
+
+GDBusProxy *bluetoothctl_get_default_controller(void);
+GDBusProxy *bluetoothctl_find_controller(const char *address);
+char *bluetoothctl_controller_generator(const char *text, int state);
diff --git a/client/main.c b/client/main.c
index 9d9ac8b14..5e9f2eeb5 100644
--- a/client/main.c
+++ b/client/main.c
@@ -881,6 +881,25 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
 	return NULL;
 }
 
+GDBusProxy *bluetoothctl_get_default_controller(void)
+{
+	if (!default_ctrl)
+		return NULL;
+
+	return default_ctrl->proxy;
+}
+
+GDBusProxy *bluetoothctl_find_controller(const char *address)
+{
+	struct adapter *adapter;
+
+	adapter = find_ctrl_by_address(ctrl_list, address);
+	if (!adapter)
+		return NULL;
+
+	return adapter->proxy;
+}
+
 static GDBusProxy *find_proxies_by_iface(GList *source, const char *path,
 							const char *iface)
 {
@@ -2788,7 +2807,7 @@ static char *generic_generator(const char *text, int state,
 	return NULL;
 }
 
-static char *ctrl_generator(const char *text, int state)
+char *bluetoothctl_controller_generator(const char *text, int state)
 {
 	static int index = 0;
 	static int len = 0;
@@ -3876,9 +3895,9 @@ static const struct bt_shell_menu main_menu = {
 	.entries = {
 	{ "list",         NULL,       cmd_list, "List available controllers" },
 	{ "show",         "[ctrl]",   cmd_show, "Controller information",
-							ctrl_generator },
+					bluetoothctl_controller_generator },
 	{ "select",       "<ctrl>",   cmd_select, "Select default controller",
-							ctrl_generator },
+					bluetoothctl_controller_generator },
 	{ "devices",      "[Paired/Bonded/Trusted/Connected]", cmd_devices,
 					"List available devices, with an "
 					"optional property as the filter" },
-- 
2.43.0

