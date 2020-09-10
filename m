Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA99BC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 10:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8386921556
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 10:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VqeeXAZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIJKef (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgIJKeO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 06:34:14 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E651C061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 03:34:08 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w126so3261746qka.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 03:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Zpwn8gvMJpxff1Ws3zTTj/vOYLQA3DOLwBZC5xvqpwM=;
        b=VqeeXAZTCFsGyXW/CvnYnxrPu/IJREt9iwRCl+24a+ACrEHcecUpQsEy0OLRQiM0GR
         h7qEYMGfFtO+gCnFCSMDUST0QwkapPnNzCEl+4zqFgptCcxobkTM1Plfy1NY+MjgEkmn
         2ukSl87QMQYiTCLja7/W75KAh9hz5IlLoihpDz4RHci0XNhDoZoETpeZ4Hn8VO0IAuU8
         56SAe62OmcPCazQMy20OXb/8NIMzgr+pEez/BAmDhoINiBkvGBpO7mX8IaxyQHEHnIPE
         TU2nfwZOgYUUqOUXywnZAJwm57DSzR4MvNmf00kltcONV1rXQwcJMPnc5D+4zrxIAToy
         9upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Zpwn8gvMJpxff1Ws3zTTj/vOYLQA3DOLwBZC5xvqpwM=;
        b=uYmR1QEuLwCNyS2jbWdsT/ATg0c9rppmBIM92sRXb+8A05uEMus/yp06W8fKzUwFVg
         y29T4juQqNDeP24EKOTcRS0g/nsoCxj5nx8ss3GmQB5syNUL7YS1L7x06ohMw+ySFLJj
         L0muVT/iktURhbjmxle7GG3ZM5tOe22+h2KV4eTqewqa7v8azyNAO3uAthhYJbm1tmM2
         Yhv2WTM1k6xJ2lmsphbbL1m71x0xrwvnR/alQ87975xsEmk1ojK7gBdoNpWjdzUSmiMz
         1o0oQXzg8qXtbd4T0VZQiDr322zyRCDb1z0FyRdKhTHkbihMM5+Ce7POBf5GIXGyWAIp
         ayNg==
X-Gm-Message-State: AOAM532WXk1sQSEgwFiyd3ulgVlA0H9QwvE8M3LUZlUbXajGtEzMfHqP
        Uc8HiUd/n0T6ZEjUGsu3BF8vm21jF1qcFYJjlBaqdMpCk3AP5khqcCWiFsRlSOa8WmDmn9okmQ+
        RaxA9B5+XuYqGS8JbrW45CvaYyxjBq4EQBMka1duZeZYHeR8IMcRLvKRwbKg1c/GNpggNLrWI33
        qLxrKrP5qArzw=
X-Google-Smtp-Source: ABdhPJx3gattaCXPEmv0BwIxj4mHNnUO5EkxymphX3zmvwdglS23T6+hstqPOZZq7Phi7wymn+FqWjYwj1nkOlaUTQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:4891:: with SMTP id
 bv17mr8255883qvb.23.1599734047055; Thu, 10 Sep 2020 03:34:07 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:33:59 +0800
Message-Id: <20200910183329.BlueZ.v2.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [BlueZ PATCH v2 1/4] PRE-UPSTREAM: client: Implement basic interface
 of ADV monitor in bluetoothctl
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, mcchou@chromium.org,
        mmandlik@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements some basic functions for ADV monitor in
bluetoothctl

[bluetooth]# show
...
Advertisement Monitor Features:
	SupportedMonitorTypes: or_patterns

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

Changes in v2:
- Update the add-pattern usage
- Fix storage class declaration issue

 Makefile.tools                 |   2 +
 client/advertisement_monitor.c | 161 +++++++++++++++++++++++++++++++++
 client/advertisement_monitor.h |  23 +++++
 client/main.c                  |  28 ++++++
 4 files changed, 214 insertions(+)
 create mode 100644 client/advertisement_monitor.c
 create mode 100644 client/advertisement_monitor.h

diff --git a/Makefile.tools b/Makefile.tools
index 9b9236609..88d9684a7 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -7,6 +7,8 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/agent.h client/agent.c \
 					client/advertising.h \
 					client/advertising.c \
+					client/advertisement_monitor.h \
+					client/advertisement_monitor.c \
 					client/gatt.h client/gatt.c
 client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
diff --git a/client/advertisement_monitor.c b/client/advertisement_monitor.c
new file mode 100644
index 000000000..a3218fa02
--- /dev/null
+++ b/client/advertisement_monitor.c
@@ -0,0 +1,161 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020 Google LLC
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
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+
+#include "gdbus/gdbus.h"
+#include "src/shared/util.h"
+#include "src/shared/shell.h"
+#include "advertisement_monitor.h"
+
+#define ADV_MONITOR_APP_PATH	"/org/bluez/adv_monitor_app"
+#define ADV_MONITOR_INTERFACE	"org.bluez.AdvertisementMonitor1"
+
+static struct adv_monitor_manager {
+	GSList *supported_types;
+	GSList *supported_features;
+	GDBusProxy *proxy;
+	gboolean app_registered;
+} manager = { NULL, NULL, NULL, FALSE };
+
+static void set_supported_list(GSList **list, DBusMessageIter *iter)
+{
+	char *str;
+	DBusMessageIter subiter;
+
+	dbus_message_iter_recurse(iter, &subiter);
+	while (dbus_message_iter_get_arg_type(&subiter) ==
+						DBUS_TYPE_STRING) {
+		dbus_message_iter_get_basic(&subiter, &str);
+		*list = g_slist_append(*list, str);
+		dbus_message_iter_next(&subiter);
+	}
+}
+
+void adv_monitor_add_manager(DBusConnection *conn, GDBusProxy *proxy)
+{
+	DBusMessageIter iter;
+
+	if (manager.proxy != NULL || manager.supported_types != NULL ||
+					manager.supported_features != NULL) {
+		bt_shell_printf("advertisement monitor manager already "
+				"added\n");
+		return;
+	}
+
+	manager.proxy = proxy;
+
+	if (g_dbus_proxy_get_property(proxy, "SupportedMonitorTypes", &iter))
+		set_supported_list(&(manager.supported_types), &iter);
+
+	if (g_dbus_proxy_get_property(proxy, "SupportedFeatures", &iter))
+		set_supported_list(&(manager.supported_features), &iter);
+
+}
+
+void adv_monitor_remove_manager(DBusConnection *conn)
+{
+	if (manager.supported_types != NULL)
+		g_slist_free(g_steal_pointer(&(manager.supported_types)));
+	if (manager.supported_features != NULL)
+		g_slist_free(g_steal_pointer(&(manager.supported_features)));
+	manager.proxy = NULL;
+	manager.app_registered = FALSE;
+}
+
+static void register_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *path = ADV_MONITOR_APP_PATH;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+static void register_reply(DBusMessage *message, void *user_data)
+{
+	DBusConnection *conn = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == FALSE) {
+		bt_shell_printf("AdvertisementMonitor path registered\n");
+	} else {
+		bt_shell_printf("Failed to register path: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
+static void unregister_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *path = ADV_MONITOR_APP_PATH;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+static void unregister_reply(DBusMessage *message, void *user_data)
+{
+	DBusConnection *conn = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == FALSE) {
+		bt_shell_printf("AdvertisementMonitor path unregistered\n");
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	bt_shell_printf("Failed to unregister Advertisement Monitor:"
+			" %s\n", error.name);
+	dbus_error_free(&error);
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+void adv_monitor_register_app(DBusConnection *conn)
+{
+	if (manager.supported_types == NULL || manager.app_registered == TRUE ||
+		g_dbus_proxy_method_call(manager.proxy, "RegisterMonitor",
+					register_setup, register_reply,
+					NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to register Advertisement Monitor\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+	manager.app_registered = TRUE;
+}
+
+void adv_monitor_unregister_app(DBusConnection *conn)
+{
+	if (manager.app_registered == FALSE ||
+		g_dbus_proxy_method_call(manager.proxy, "UnregisterMonitor",
+					unregister_setup, unregister_reply,
+					NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to unregister Advertisement Monitor\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+	manager.app_registered = FALSE;
+}
diff --git a/client/advertisement_monitor.h b/client/advertisement_monitor.h
new file mode 100644
index 000000000..77b0b62c6
--- /dev/null
+++ b/client/advertisement_monitor.h
@@ -0,0 +1,23 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020 Google LLC
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
+void adv_monitor_add_manager(DBusConnection *conn, GDBusProxy *proxy);
+void adv_monitor_remove_manager(DBusConnection *conn);
+void adv_monitor_register_app(DBusConnection *conn);
+void adv_monitor_unregister_app(DBusConnection *conn);
diff --git a/client/main.c b/client/main.c
index da877b546..6bca738a0 100644
--- a/client/main.c
+++ b/client/main.c
@@ -41,6 +41,7 @@
 #include "agent.h"
 #include "gatt.h"
 #include "advertising.h"
+#include "advertisement_monitor.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -58,6 +59,7 @@ static char *auto_register_agent = NULL;
 struct adapter {
 	GDBusProxy *proxy;
 	GDBusProxy *ad_proxy;
+	GDBusProxy *adv_monitor_proxy;
 	GList *devices;
 };
 
@@ -528,6 +530,19 @@ static void ad_manager_added(GDBusProxy *proxy)
 	adapter->ad_proxy = proxy;
 }
 
+static void admon_manager_added(GDBusProxy *proxy)
+{
+	struct adapter *adapter;
+
+	adapter = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
+	if (!adapter)
+		adapter = adapter_new(proxy);
+
+	adapter->adv_monitor_proxy = proxy;
+	adv_monitor_add_manager(dbus_conn, proxy);
+	adv_monitor_register_app(dbus_conn);
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -560,6 +575,9 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		ad_manager_added(proxy);
 	} else if (!strcmp(interface, "org.bluez.Battery1")) {
 		battery_added(proxy);
+	} else if (!strcmp(interface,
+				"org.bluez.AdvertisementMonitorManager1")) {
+		admon_manager_added(proxy);
 	}
 }
 
@@ -653,6 +671,9 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		ad_unregister(dbus_conn, NULL);
 	} else if (!strcmp(interface, "org.bluez.Battery1")) {
 		battery_removed(proxy);
+	} else if (!strcmp(interface,
+			"org.bluez.AdvertisementMonitorManager1")) {
+		adv_monitor_remove_manager(dbus_conn);
 	}
 }
 
@@ -935,6 +956,13 @@ static void cmd_show(int argc, char *argv[])
 		print_property(adapter->ad_proxy, "SupportedSecondaryChannels");
 	}
 
+	if (adapter->adv_monitor_proxy) {
+		bt_shell_printf("Advertisement Monitor Features:\n");
+		print_property(adapter->adv_monitor_proxy,
+						"SupportedMonitorTypes");
+		print_property(adapter->adv_monitor_proxy, "SupportedFeatures");
+	}
+
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-- 
2.28.0.526.ge36021eeef-goog

