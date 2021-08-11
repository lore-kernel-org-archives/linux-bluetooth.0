Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE52C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C27360E78
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhHKHJc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbhHKHJa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Aug 2021 03:09:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD399C061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:09:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c63-20020a25e5420000b0290580b26e708aso1487676ybh.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=blN+Whzr5BIjFcDe7GB4iaKkhWCUHMU+Ef4bI+uMwTc=;
        b=sUZyF0Ey5NaKAD8QZm8iHiqnJOnu8vTG3HwQxLsbunxRy4bG1mDjZ4LJW2Fj0+qZJH
         AffSdrAzjv05KhzDF2PJ0ZGv780wccWU2msGgL1D0kMx7mubcVRYMiO++vGWsVvMsqjq
         fWQyMRQWWlglECEjJzEsYE5aLeB7JyQTJG5pJpn20azujH28KlFdiCUh/o86yqqnxtjI
         d1klR2j+fBSfB8Xe36+G7sezk/VF+otdBceQPqumElpCdnu4ykZkbOfyVfpUtXhGHcpm
         EuPYL4FIehMZ64SbIK6iTJYRW84oJsx66A7FkfCzffOyWvE0X8HF1be6cW+Lp2UzWDdm
         CpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=blN+Whzr5BIjFcDe7GB4iaKkhWCUHMU+Ef4bI+uMwTc=;
        b=mMW8add9v4DlODYmaPIi4Qp4EVl2sjsp+rqgZ7xZG6ytKAZbf3VCjo49rFnxpfKntT
         03rsoQW70duOXI1V6lMrJ8hP+rbdKFJ25H5CRslyxU/uZx25ZuxjsZSUE+FovhTebH6c
         VpdTK3iq928QdL5JqWFBkoqPP2LzVRkzbmBn+ZgcgMr1HlHNTeX+PPE+QSZ2CtMXJQgD
         uzySnrLlbs6UIhXc9tT/SWPAzNTjFCHho4uzuw7XOlcYILyU1ptxnF75sbiiv+7vo77+
         xzkZQd7Wu/7BkZ5XJuPgHez/Ctl5d8rCJo2YJfKNABEHs+hhQEtiFgYOB9uyoDmxjE3N
         SWrg==
X-Gm-Message-State: AOAM533i/NDpeVV5jTiCW4qTzcYR8m7pJchV8JRS4it8o8E4xUQgsSna
        fhUDTeLtLA/eLvReaxtVPNz0Y7H+z+kyICDMosmxHkQmiQDJGRi74Xvjems9qmaeZQS5sLe0VX3
        UiHpqB9b1wxc6TDiPkkClgqcgjT8gdcbh0gZ2FvQXB9sT2/NPz7utH9cMiENGKgux8fXDoDBtsL
        U4f1TBXHFD78g=
X-Google-Smtp-Source: ABdhPJwzfadTkLDbCdZ3HGe0hKMoVdu8duSzRU8pieon1ngCv7LxKoH+1x3tu2gVDR0b8vkSlf/oohatLK4YCzZtKg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:42fe:de1a:97f8:9006])
 (user=howardchung job=sendgmr) by 2002:a05:6902:120a:: with SMTP id
 s10mr2933136ybu.31.1628665746080; Wed, 11 Aug 2021 00:09:06 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:08:56 +0800
In-Reply-To: <20210811150752.v3.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
Message-Id: <20210811150752.v3.2.I1d1cf4fbc02b11d62f186f0db23c2c537e296a64@changeid>
Mime-Version: 1.0
References: <20210811150752.v3.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v3 2/3] client: add admin submenu and allow command
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This creates a menu - admin and add a commands to bluetoothctl
- allow [clear/uuid1 uuid2 ...]

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
The following test steps were performed:
1. [bluetooth]# menu admin
2. [bluetooth]# allow 1124 180A 180F 1812 1801
3. [bluetooth]# allow
   Service AllowedList:
        00001801-0000-1000-8000-00805f9b34fb
        00001812-0000-1000-8000-00805f9b34fb
        0000180f-0000-1000-8000-00805f9b34fb
        0000180a-0000-1000-8000-00805f9b34fb
        00001124-0000-1000-8000-00805f9b34fb
4. [bluetooth]# allow clear
5. [bluetooth]# allow
   Service AllowedList:

Changes in v3:
- Rename client/admin_policy.* -> client/admin.*
- Remove a line added by mistake in cmd_admin_allow

Changes in v2:
- Merge command set-service-allowlist and get-service-allowlist to allow
- Update commit messages

 Makefile.tools |   4 +-
 client/admin.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++
 client/admin.h |  25 ++++++++++
 client/main.c  |  69 +++++++++++++++++++++++++
 4 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 client/admin.c
 create mode 100644 client/admin.h

diff --git a/Makefile.tools b/Makefile.tools
index c836b5984934..8cfaf8972150 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -9,7 +9,9 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/advertising.c \
 					client/adv_monitor.h \
 					client/adv_monitor.c \
-					client/gatt.h client/gatt.c
+					client/gatt.h client/gatt.c \
+					client/admin.h \
+					client/admin.c
 client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
 endif
diff --git a/client/admin.c b/client/admin.c
new file mode 100644
index 000000000000..863590172428
--- /dev/null
+++ b/client/admin.c
@@ -0,0 +1,133 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2021 Google LLC
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include "gdbus/gdbus.h"
+#include "src/shared/shell.h"
+
+#include "admin.h"
+#define _GNU_SOURCE
+
+static GDBusProxy *set_proxy;
+static GDBusProxy *status_proxy;
+
+void admin_policy_set_set_proxy(GDBusProxy *proxy)
+{
+	set_proxy = proxy;
+}
+
+void admin_policy_set_status_proxy(GDBusProxy *proxy)
+{
+	status_proxy = proxy;
+}
+
+void admin_policy_read_service_allowlist(DBusConnection *dbus_conn)
+{
+	DBusMessageIter iter, subiter;
+	char *uuid = NULL;
+
+	if (!status_proxy || !g_dbus_proxy_get_property(status_proxy,
+						"ServiceAllowList", &iter)) {
+		bt_shell_printf("Failed to get property\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		bt_shell_printf("Unexpected return type\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Service AllowedList:\n");
+	dbus_message_iter_recurse(&iter, &subiter);
+	while (dbus_message_iter_get_arg_type(&subiter) ==
+						DBUS_TYPE_STRING) {
+		dbus_message_iter_get_basic(&subiter, &uuid);
+		bt_shell_printf("\t%s\n", uuid);
+		dbus_message_iter_next(&subiter);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+struct uuid_list_data {
+	char **uuid_list;
+	size_t num;
+};
+
+static void set_service_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct uuid_list_data *data = user_data;
+	DBusMessageIter arr_iter;
+	size_t i;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+						DBUS_TYPE_STRING_AS_STRING,
+						&arr_iter);
+
+	for (i = 0; i < data->num; i++) {
+		dbus_message_iter_append_basic(&arr_iter, DBUS_TYPE_STRING,
+							&data->uuid_list[i]);
+	}
+
+	dbus_message_iter_close_container(iter, &arr_iter);
+}
+
+static void set_service_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (!dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("Set allowed service successfully\n");
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	bt_shell_printf("Failed to set service allowed list: %s\n", error.name);
+	dbus_error_free(&error);
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+void admin_policy_set_service_allowlist(DBusConnection *dbus_connd,
+							int argc, char *argv[])
+{
+	struct uuid_list_data data;
+
+	if (!set_proxy) {
+		bt_shell_printf("Set proxy not ready\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	data.uuid_list = argv;
+	data.num = argc;
+
+	if (!g_dbus_proxy_method_call(set_proxy, "SetServiceAllowList",
+					set_service_setup, set_service_reply,
+					&data, NULL)) {
+		bt_shell_printf("Failed to call method\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
diff --git a/client/admin.h b/client/admin.h
new file mode 100644
index 000000000000..1c8c2152d59d
--- /dev/null
+++ b/client/admin.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2021 Google LLC
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+void admin_policy_set_set_proxy(GDBusProxy *proxy);
+void admin_policy_set_status_proxy(GDBusProxy *proxy);
+
+void admin_policy_read_service_allowlist(DBusConnection *dbus_conn);
+void admin_policy_set_service_allowlist(DBusConnection *dbus_conn,
+							int argc, char *argv[]);
diff --git a/client/main.c b/client/main.c
index c1a62edb7f99..a983066eda34 100644
--- a/client/main.c
+++ b/client/main.c
@@ -29,6 +29,7 @@
 #include "gatt.h"
 #include "advertising.h"
 #include "adv_monitor.h"
+#include "admin.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -530,6 +531,23 @@ static void admon_manager_added(GDBusProxy *proxy)
 	adv_monitor_register_app(dbus_conn);
 }
 
+static void admin_policy_set_added(GDBusProxy *proxy)
+{
+	admin_policy_set_set_proxy(proxy);
+}
+
+static void admin_policy_status_added(GDBusProxy *proxy)
+{
+	struct adapter *adapter;
+
+	adapter = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
+
+	if (!adapter)
+		return;
+
+	admin_policy_set_status_proxy(proxy);
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -565,6 +583,10 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface,
 				"org.bluez.AdvertisementMonitorManager1")) {
 		admon_manager_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.AdminPolicySet1")) {
+		admin_policy_set_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.AdminPolicyStatus1")) {
+		admin_policy_status_added(proxy);
 	}
 }
 
@@ -621,6 +643,23 @@ static void adapter_removed(GDBusProxy *proxy)
 	}
 }
 
+static void admin_policy_set_removed(GDBusProxy *proxy)
+{
+	admin_policy_set_set_proxy(NULL);
+}
+
+static void admin_policy_status_removed(GDBusProxy *proxy)
+{
+	struct adapter *adapter;
+
+	adapter = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
+
+	if (!adapter)
+		return;
+
+	admin_policy_set_status_proxy(NULL);
+}
+
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -661,6 +700,10 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface,
 			"org.bluez.AdvertisementMonitorManager1")) {
 		adv_monitor_remove_manager(dbus_conn);
+	} else if (!strcmp(interface, "org.bluez.AdminPolicySet1")) {
+		admin_policy_set_removed(proxy);
+	} else if (!strcmp(interface, "org.bluez.AdminPolicyStatus1")) {
+		admin_policy_status_removed(proxy);
 	}
 }
 
@@ -2824,6 +2867,22 @@ static void cmd_adv_monitor_get_supported_info(int argc, char *argv[])
 	adv_monitor_get_supported_info();
 }
 
+static void cmd_admin_allow(int argc, char *argv[])
+{
+	if (check_default_ctrl() == FALSE)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (argc <= 1) {
+		admin_policy_read_service_allowlist(dbus_conn);
+		return;
+	}
+
+	if (strcmp(argv[1], "clear") == 0)
+		argc--;
+
+	admin_policy_set_service_allowlist(dbus_conn, argc - 1, argv + 1);
+}
+
 static const struct bt_shell_menu advertise_menu = {
 	.name = "advertise",
 	.desc = "Advertise Options Submenu",
@@ -2978,6 +3037,15 @@ static const struct bt_shell_menu gatt_menu = {
 	{ } },
 };
 
+static const struct bt_shell_menu admin_menu = {
+	.name = "admin",
+	.desc = "Admin Policy Submenu",
+	.entries = {
+	{ "allow", "[clear/uuid1 uuid2 ...]", cmd_admin_allow,
+				"Allow service UUIDs and block rest of them"},
+	{} },
+};
+
 static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
@@ -3075,6 +3143,7 @@ int main(int argc, char *argv[])
 	bt_shell_add_submenu(&advertise_monitor_menu);
 	bt_shell_add_submenu(&scan_menu);
 	bt_shell_add_submenu(&gatt_menu);
+	bt_shell_add_submenu(&admin_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 
 	if (agent_option)
-- 
2.32.0.605.g8dce9f2422-goog

