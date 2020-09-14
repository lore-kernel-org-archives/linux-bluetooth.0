Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4458DC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 03:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2ADB208DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 03:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mndusJc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgINDWy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Sep 2020 23:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgINDWr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Sep 2020 23:22:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E31EC06174A
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2020 20:22:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u128so15401584ybg.17
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2020 20:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=EnBy+dhGK+KU7s14UMNaacLXhV3/ZJibQx2NZUdPjao=;
        b=mndusJc1ci82hhpnqhA4908SlHU5VY/cMLeJpIP3FHXtgrJO/eBuMpbSLfaSe33cud
         GfCeFjX/khAapiWdAbbe+CQdRZfCmnrA1IZUymBLqf0vSVo0ZCfhTO0Z1QkYq2nmd2PI
         V8COz+/UMOLRH5fAGKpqmavrImUf31gJzPHYwrwAapkee+zozfMQtIT0wR4rdPfK5o42
         iHQ6hY3QyLqdgyCVhB2rvfdy6DXXrgMdWycPOCBoNT1dgcQCEPiQsfVPWbrsIY7zzAx9
         MqCISvg/dj7UmVXTPW3eu84qKgRisDLVlYVqgmvhSo9bJAsbG5RfXuXXbBzsi1oFZyZO
         PwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=EnBy+dhGK+KU7s14UMNaacLXhV3/ZJibQx2NZUdPjao=;
        b=mZh/cwS4X016psswZcOFX1MWReQcc+oKO3rvcW5XzA8nnpNhxD5LL0KsrD6uJ7mSYC
         NfAPXCZQG+B7IqzOM8tYucWiWBXxNohL9G2hu8O4g09JmFgoylTPJU6IPA2bPJHcMrTH
         6yXw5T0a3BQGtTlaSRe+xHKDQpnfMlaxFkJFdggb51jJJbk1eLO6+aukb674RaNNkdsN
         38EPp5cKkylHrCgmJlbHMWPznI9KZdzqS5ylCKbccw2XxdSDsuvCVYBnOOdv4RaULGWY
         vKhMDhBj3mA7Cw9oh26YmThLfRGmVp8bxmAC6i13KxfhidQqdPMHcxyfuhmrCPbETMb6
         SDVA==
X-Gm-Message-State: AOAM531Uy/xxSiR/5Gf3cWb5N1+2LmxH01sYcr3PS54+mH+lhoa82Jpk
        tWpkNauaZpTKsC0+lYjJO55XWR/tev+f9qhl7KrWAJWlE6xFqpxwA9HVRg9LDMplXnmuyzd26Ka
        dcSUl5R4yg6CqSU6FfLZLeGkVIcYBjyRJ1b2zmkAnZXG5sYL8zDiouVfrAai/I4jc0cQvPVov16
        wKakMBr+unHS8=
X-Google-Smtp-Source: ABdhPJw622upNuKdruRy6J4qYSM9lAq/ePD+ZqVxk1tkUaJtFDfbqKrMRKDquWyK4xLU8Zvc39d5hHkaXzxFktnBWg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:301:: with SMTP id
 1mr17154522ybd.255.1600053763881; Sun, 13 Sep 2020 20:22:43 -0700 (PDT)
Date:   Mon, 14 Sep 2020 11:22:30 +0800
Message-Id: <20200914112137.BlueZ.v4.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v4 1/4] client: Implement basic interface of ADV monitor
 in bluetoothctl
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, luiz.von.dentz@intel.com,
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

Changes in v4:
- Remove PRE-UPSTREAM in commit title

Changes in v3:
- Rename advertisement_monitor to adv_monitor

Changes in v2:
- Update the add-pattern usage
- Fix styling issue in patch 1
- Fix storage class declaration issue

 Makefile.tools       |   2 +
 client/adv_monitor.c | 161 +++++++++++++++++++++++++++++++++++++++++++
 client/adv_monitor.h |  23 +++++++
 client/main.c        |  28 ++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 client/adv_monitor.c
 create mode 100644 client/adv_monitor.h

diff --git a/Makefile.tools b/Makefile.tools
index 9b9236609..ed0fbf8a3 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -7,6 +7,8 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/agent.h client/agent.c \
 					client/advertising.h \
 					client/advertising.c \
+					client/adv_monitor.h \
+					client/adv_monitor.c \
 					client/gatt.h client/gatt.c
 client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
diff --git a/client/adv_monitor.c b/client/adv_monitor.c
new file mode 100644
index 000000000..2a62389d9
--- /dev/null
+++ b/client/adv_monitor.c
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
+#include "adv_monitor.h"
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
diff --git a/client/adv_monitor.h b/client/adv_monitor.h
new file mode 100644
index 000000000..77b0b62c6
--- /dev/null
+++ b/client/adv_monitor.h
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
index da877b546..75f8bc462 100644
--- a/client/main.c
+++ b/client/main.c
@@ -41,6 +41,7 @@
 #include "agent.h"
 #include "gatt.h"
 #include "advertising.h"
+#include "adv_monitor.h"
 
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
2.28.0.618.gf4bc123cb7-goog

