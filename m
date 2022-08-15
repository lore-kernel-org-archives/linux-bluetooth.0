Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D6BC25B0F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 06:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiHPGBo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 02:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiHPGBX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 02:01:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944486B58
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 16:26:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso15799945pjq.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 16:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=n4peG6lER0isLk6vDkj25mV3GFwO3PVFXZ2sR+VQZFo=;
        b=IKEg4SqkJ5+PRfjtKYVTAvtfib6XMPRB6FBzYIhuNyDhhkZQ6Iiidbz9xUKiO6B37r
         BcbxJLpVrncdY/S4TlNoHz4E0ZOTvhxpHNgizhpZ8yRPy7H6mgv+KUfDAvTxUQfX9FBL
         lRG2Nkko8F1ZDVsDFvlkKenydzz0sN3ak12epFUcAhEGayWiIx7TSZBTyu4Ma1BmdF2v
         Sa1k3DScbmpxrIO/1Np87BPQ/unuFjlDG7lpkEY6C99oJ8Ao7E3YfvVTtvpv7RHFsj2o
         tQTuTEwc2bbVE+G0nB8mGK1yBSS9Cm5MKRNk7NqcFBEMNzNk6DQkpZCBJH7QesZakFbF
         rEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=n4peG6lER0isLk6vDkj25mV3GFwO3PVFXZ2sR+VQZFo=;
        b=cKZp07cJ1IivMGcGx10yM04oPXJew3rCTawAOugdg4zx9mkzL1/QHuAkdfON4bAQ8n
         0TmDaCD9XB/niPEGqLYjyOiHyRMuvpQcSLCgFPf5mKYIAqycxsJ7K3iZD5Wko9/l7J8h
         EvKehX6vpBMecMjNHlhpL5gQTZvQ+P/Xfmuh84DuNSjrteUPTyIj+Awu9SD7FpW1UVlm
         2LFnKj2VOGJg2C8fzE2k4gmGWwK8t+okUniaUNkPqx6XI8ErYkAUeY7e2mOveLGcKo5N
         RfK/0UzrQZ0NjNOEVVngaXJI29ZpBUyoPWrPgJ3hjU9RSsBz6K54JktuSTd9iW89Z/d3
         lX1A==
X-Gm-Message-State: ACgBeo3HZ4bAMRT4NSMO8SVxmNoYwhQ39FUgyFSXf/Lrvi1p8w62Xxv5
        h/UGL0e3ZFhMdzl7xD7IXuv6J6chA7/Otw==
X-Google-Smtp-Source: AA6agR7MRbvcw2uMQDWgKq2s5Dg9fEFB9Hio+vr6m3PTOTRniWsFOyskkwCyTCmlVJs/m582YUbjoQ==
X-Received: by 2002:a17:90a:982:b0:1ef:f525:9801 with SMTP id 2-20020a17090a098200b001eff5259801mr21104732pjo.191.1660605995879;
        Mon, 15 Aug 2022 16:26:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b0016d23e941f2sm7474276pli.258.2022.08.15.16.26.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 16:26:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] client: Move admin submenu
Date:   Mon, 15 Aug 2022 16:26:30 -0700
Message-Id: <20220815232631.1275861-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves admin submenu to admin.c so it is not mixed up with other
submenus code.
---
 client/admin.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++---
 client/admin.h |  8 ++---
 client/main.c  | 82 ++----------------------------------------
 3 files changed, 96 insertions(+), 91 deletions(-)

diff --git a/client/admin.c b/client/admin.c
index 863590172428..cd9af6f955da 100644
--- a/client/admin.c
+++ b/client/admin.c
@@ -31,20 +31,22 @@
 #include "admin.h"
 #define _GNU_SOURCE
 
+static DBusConnection *dbus_conn;
+static GList *admin_proxies;
 static GDBusProxy *set_proxy;
 static GDBusProxy *status_proxy;
 
-void admin_policy_set_set_proxy(GDBusProxy *proxy)
+static void admin_policy_set_set_proxy(GDBusProxy *proxy)
 {
 	set_proxy = proxy;
 }
 
-void admin_policy_set_status_proxy(GDBusProxy *proxy)
+static void admin_policy_set_status_proxy(GDBusProxy *proxy)
 {
 	status_proxy = proxy;
 }
 
-void admin_policy_read_service_allowlist(DBusConnection *dbus_conn)
+static void admin_policy_read_service_allowlist(DBusConnection *dbus_conn)
 {
 	DBusMessageIter iter, subiter;
 	char *uuid = NULL;
@@ -111,8 +113,7 @@ static void set_service_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
-void admin_policy_set_service_allowlist(DBusConnection *dbus_connd,
-							int argc, char *argv[])
+static void admin_policy_set_service_allowlist(int argc, char *argv[])
 {
 	struct uuid_list_data data;
 
@@ -131,3 +132,89 @@ void admin_policy_set_service_allowlist(DBusConnection *dbus_connd,
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 }
+
+static void cmd_admin_allow(int argc, char *argv[])
+{
+	if (argc <= 1) {
+		admin_policy_read_service_allowlist(dbus_conn);
+		return;
+	}
+
+	if (strcmp(argv[1], "clear") == 0)
+		argc--;
+
+	admin_policy_set_service_allowlist(argc - 1, argv + 1);
+}
+
+static const struct bt_shell_menu admin_menu = {
+	.name = "admin",
+	.desc = "Admin Policy Submenu",
+	.entries = {
+	{ "allow", "[clear/uuid1 uuid2 ...]", cmd_admin_allow,
+				"Allow service UUIDs and block rest of them"},
+	{} },
+};
+
+static void admin_policy_status_added(GDBusProxy *proxy)
+{
+	admin_proxies = g_list_append(admin_proxies, proxy);
+	admin_policy_set_status_proxy(proxy);
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, "org.bluez.AdminPolicySet1"))
+		admin_policy_set_set_proxy(proxy);
+	else if (!strcmp(interface, "org.bluez.AdminPolicyStatus1"))
+		admin_policy_status_added(proxy);
+}
+
+static void admin_policy_status_removed(GDBusProxy *proxy)
+{
+	admin_proxies = g_list_remove(admin_proxies, proxy);
+	admin_policy_set_status_proxy(NULL);
+}
+
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, "org.bluez.AdminPolicySet1"))
+		admin_policy_set_set_proxy(NULL);
+	else if (!strcmp(interface, "org.bluez.AdminPolicyStatus1"))
+		admin_policy_status_removed(proxy);
+}
+
+static GDBusClient *client;
+
+static void disconnect_handler(DBusConnection *connection, void *user_data)
+{
+	g_list_free_full(admin_proxies, NULL);
+	admin_proxies = NULL;
+}
+
+void admin_add_submenu(void)
+{
+	bt_shell_add_submenu(&admin_menu);
+
+	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
+	if (!dbus_conn || client)
+		return;
+
+	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
+							NULL, NULL);
+	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
+}
+
+void admin_remove_submenu(void)
+{
+	g_dbus_client_unref(client);
+	client = NULL;
+}
diff --git a/client/admin.h b/client/admin.h
index 1c8c2152d59d..4da83e4e36ba 100644
--- a/client/admin.h
+++ b/client/admin.h
@@ -17,9 +17,5 @@
  *
  */
 
-void admin_policy_set_set_proxy(GDBusProxy *proxy);
-void admin_policy_set_status_proxy(GDBusProxy *proxy);
-
-void admin_policy_read_service_allowlist(DBusConnection *dbus_conn);
-void admin_policy_set_service_allowlist(DBusConnection *dbus_conn,
-							int argc, char *argv[]);
+void admin_add_submenu(void);
+void admin_remove_submenu(void);
diff --git a/client/main.c b/client/main.c
index 1df94f000cea..19139d15b38e 100644
--- a/client/main.c
+++ b/client/main.c
@@ -57,7 +57,6 @@ static GDBusProxy *default_dev;
 static GDBusProxy *default_attr;
 static GList *ctrl_list;
 static GList *battery_proxies;
-static GList *admin_devices_proxies;
 
 static const char *agent_arguments[] = {
 	"on",
@@ -563,26 +562,6 @@ static void admon_manager_added(GDBusProxy *proxy)
 	adv_monitor_register_app(dbus_conn);
 }
 
-static void admin_policy_set_added(GDBusProxy *proxy)
-{
-	admin_policy_set_set_proxy(proxy);
-}
-
-static void admin_policy_status_added(GDBusProxy *proxy)
-{
-	struct adapter *adapter;
-
-	adapter = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
-
-	if (!adapter) {
-		admin_devices_proxies = g_list_append(admin_devices_proxies,
-									proxy);
-		return;
-	}
-
-	admin_policy_set_status_proxy(proxy);
-}
-
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -618,10 +597,6 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface,
 				"org.bluez.AdvertisementMonitorManager1")) {
 		admon_manager_added(proxy);
-	} else if (!strcmp(interface, "org.bluez.AdminPolicySet1")) {
-		admin_policy_set_added(proxy);
-	} else if (!strcmp(interface, "org.bluez.AdminPolicyStatus1")) {
-		admin_policy_status_added(proxy);
 	}
 }
 
@@ -678,26 +653,6 @@ static void adapter_removed(GDBusProxy *proxy)
 	}
 }
 
-static void admin_policy_set_removed(GDBusProxy *proxy)
-{
-	admin_policy_set_set_proxy(NULL);
-}
-
-static void admin_policy_status_removed(GDBusProxy *proxy)
-{
-	struct adapter *adapter;
-
-	adapter = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
-
-	if (!adapter) {
-		admin_devices_proxies = g_list_remove(admin_devices_proxies,
-									proxy);
-		return;
-	}
-
-	admin_policy_set_status_proxy(NULL);
-}
-
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -738,10 +693,6 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface,
 			"org.bluez.AdvertisementMonitorManager1")) {
 		adv_monitor_remove_manager(dbus_conn);
-	} else if (!strcmp(interface, "org.bluez.AdminPolicySet1")) {
-		admin_policy_set_removed(proxy);
-	} else if (!strcmp(interface, "org.bluez.AdminPolicyStatus1")) {
-		admin_policy_status_removed(proxy);
 	}
 }
 
@@ -1772,7 +1723,6 @@ static struct GDBusProxy *find_device(int argc, char *argv[])
 static void cmd_info(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
-	GDBusProxy *admin_proxy;
 	GDBusProxy *battery_proxy;
 	DBusMessageIter iter;
 	const char *address;
@@ -1819,12 +1769,8 @@ static void cmd_info(int argc, char *argv[])
 
 	battery_proxy = find_proxies_by_path(battery_proxies,
 					g_dbus_proxy_get_path(proxy));
-	admin_proxy = find_proxies_by_path(admin_devices_proxies,
-					g_dbus_proxy_get_path(proxy));
 	print_property_with_label(battery_proxy, "Percentage",
 					"Battery Percentage");
-	print_property_with_label(admin_proxy, "AffectedByPolicy",
-					"Affected by Policy");
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -2948,22 +2894,6 @@ static void cmd_adv_monitor_get_supported_info(int argc, char *argv[])
 	adv_monitor_get_supported_info();
 }
 
-static void cmd_admin_allow(int argc, char *argv[])
-{
-	if (check_default_ctrl() == FALSE)
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-
-	if (argc <= 1) {
-		admin_policy_read_service_allowlist(dbus_conn);
-		return;
-	}
-
-	if (strcmp(argv[1], "clear") == 0)
-		argc--;
-
-	admin_policy_set_service_allowlist(dbus_conn, argc - 1, argv + 1);
-}
-
 static const struct bt_shell_menu advertise_menu = {
 	.name = "advertise",
 	.desc = "Advertise Options Submenu",
@@ -3118,15 +3048,6 @@ static const struct bt_shell_menu gatt_menu = {
 	{ } },
 };
 
-static const struct bt_shell_menu admin_menu = {
-	.name = "admin",
-	.desc = "Admin Policy Submenu",
-	.entries = {
-	{ "allow", "[clear/uuid1 uuid2 ...]", cmd_admin_allow,
-				"Allow service UUIDs and block rest of them"},
-	{} },
-};
-
 static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
@@ -3225,7 +3146,6 @@ int main(int argc, char *argv[])
 	bt_shell_add_submenu(&advertise_monitor_menu);
 	bt_shell_add_submenu(&scan_menu);
 	bt_shell_add_submenu(&gatt_menu);
-	bt_shell_add_submenu(&admin_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 
 	if (agent_option)
@@ -3238,6 +3158,7 @@ int main(int argc, char *argv[])
 
 	bt_shell_set_env("DBUS_CONNECTION", dbus_conn);
 
+	admin_add_submenu();
 	player_add_submenu();
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
@@ -3253,6 +3174,7 @@ int main(int argc, char *argv[])
 
 	status = bt_shell_run();
 
+	admin_remove_submenu();
 	player_remove_submenu();
 
 	g_dbus_client_unref(client);
-- 
2.37.2

