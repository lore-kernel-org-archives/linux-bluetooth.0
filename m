Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D7418373
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150637; cv=none; b=dtMdeJcDlldNAZkX4DAz+UNAXW95jN8ZT7jFrdCnHKc7wGfgC3uyXSpC8iNMEoiL2lRU25HXvVud3ME4zC8oaaXyY6OfpZP0tr6osdUOpkKpn/lyxqidIOow3n7o2K1iGk1OMaqXU2PuBgrEMCTzs5UPDXNyEL2nL6KNoJ/wNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150637; c=relaxed/simple;
	bh=V06hnxC9YWF+cB2cv0PPraxjnda8LUbZ67GlBJVQrpI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWgETDEuZbUVDksWSHJWr8OoZoh415OAfUm8c60aUfaYuLx49XUXZ6fKw01NfhFxigMoGEtD/mR/1RQ3kBpZduVZNU6N4GYhtZ9nDUonxkS7sXivYGmWcPyH63ebr/RUsquMCw2JbQjtWb5Yz5IOlk/4fzeNgeXks0uHIeJgX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SyjpyEKl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SyjpyEKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787150627;
	bh=V06hnxC9YWF+cB2cv0PPraxjnda8LUbZ67GlBJVQrpI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SyjpyEKl5Y/kOBa2bkWIVqDzsnydrDkEaeM14hkGaS77xTIJ5AkM8T0SIMHmoQuBS
	 HDpfPAeWCniRcPKOlmR1sDXs/hdRHoe8VU/ngOTyqplhFFKdyR8Z3yj8RGeJ+s2ldg
	 20co9cxCyi2K5nRvic9NcquDRZFChRcw3+9eRt6NFcyb95iit9SWkaQSgEBU3iykcT
	 ipb3i4WuUCeXMdb3cvukXWrqQOJclsigdAWIZTQpOJd3gJJ9yggaKwwmCBAHskxnIG
	 RiekGb4eFn6xUdjJ1sV3sCzjQhPS79hhdRzTnH6bzMHn4T8z5ujtoG1o6axbY+wQm8
	 4ygcS0IhvK4Fg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A750917E0851
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 16:43:47 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/7] client/bluetoothctl: make admin.allow controller-aware
Date: Wed, 19 Aug 2026 16:43:32 +0200
Message-ID: <20260819144337.889893-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819144337.889893-1-frederic.danis@collabora.com>
References: <20260819144337.889893-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Teach admin.allow to target the selected default controller.

Replace single cached AdminPolicy proxies with per-controller proxy
lookup keyed by controller object path, so controller selection changes
are respected.

Export controller default helpers from main.c for reuse by admin.c.

Assisted-by: GPT:GPT-5.3-Codex
---
 client/admin.c | 74 +++++++++++++++++++++++++++++++++++++-------------
 client/admin.h |  2 ++
 client/main.c  |  8 ++++++
 3 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/client/admin.c b/client/admin.c
index dc218ed2c..a6fba2f1c 100644
--- a/client/admin.c
+++ b/client/admin.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include "bluetooth/bluetooth.h"
 #include "gdbus/gdbus.h"
 #include "src/shared/shell.h"
 
@@ -23,27 +24,50 @@
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
 }
 
-static void admin_policy_set_status_proxy(GDBusProxy *proxy)
+static GDBusProxy *admin_policy_get_status_proxy(const char *controller_path)
 {
-	status_proxy = proxy;
+	if (!controller_path)
+		return NULL;
+
+	return admin_policy_find_proxy(status_proxies, controller_path);
 }
 
-static void admin_policy_read_service_allowlist(DBusConnection *dbus_conn)
+static GDBusProxy *admin_policy_get_set_proxy(const char *controller_path)
+{
+	if (!controller_path)
+		return NULL;
+
+	return admin_policy_find_proxy(set_proxies, controller_path);
+}
+
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
@@ -106,10 +130,14 @@ static void set_service_reply(DBusMessage *message, void *user_data)
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
@@ -128,15 +156,23 @@ static void admin_policy_set_service_allowlist(int argc, char *argv[])
 
 static void cmd_admin_allow(int argc, char *argv[])
 {
+	GDBusProxy *controller;
+
+	controller = bluetoothctl_get_default_controller();
+	if (!controller) {
+		bt_shell_printf("No default controller available\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	if (argc <= 1) {
-		admin_policy_read_service_allowlist(dbus_conn);
+		admin_policy_read_service_allowlist(controller);
 		return;
 	}
 
 	if (strcmp(argv[1], "clear") == 0)
 		argc--;
 
-	admin_policy_set_service_allowlist(argc - 1, argv + 1);
+	admin_policy_set_service_allowlist(controller, argc - 1, argv + 1);
 }
 
 static const struct bt_shell_menu admin_menu = {
@@ -151,8 +187,7 @@ static const struct bt_shell_menu admin_menu = {
 
 static void admin_policy_status_added(GDBusProxy *proxy)
 {
-	admin_proxies = g_list_append(admin_proxies, proxy);
-	admin_policy_set_status_proxy(proxy);
+	status_proxies = g_list_append(status_proxies, proxy);
 }
 
 static void proxy_added(GDBusProxy *proxy, void *user_data)
@@ -162,15 +197,14 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
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
@@ -180,7 +214,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	interface = g_dbus_proxy_get_interface(proxy);
 
 	if (!strcmp(interface, "org.bluez.AdminPolicySet1"))
-		admin_policy_set_set_proxy(NULL);
+		set_proxies = g_list_remove(set_proxies, proxy);
 	else if (!strcmp(interface, "org.bluez.AdminPolicyStatus1"))
 		admin_policy_status_removed(proxy);
 }
@@ -189,8 +223,10 @@ static GDBusClient *client;
 
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
index 0047770dc..00423d9d3 100644
--- a/client/admin.h
+++ b/client/admin.h
@@ -10,3 +10,5 @@
 
 void admin_add_submenu(void);
 void admin_remove_submenu(void);
+
+GDBusProxy *bluetoothctl_get_default_controller(void);
diff --git a/client/main.c b/client/main.c
index 069e20485..95828902d 100644
--- a/client/main.c
+++ b/client/main.c
@@ -903,6 +903,14 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
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
 static GDBusProxy *find_proxies_by_iface(GList *source, const char *path,
 							const char *iface)
 {
-- 
2.43.0

