Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60445C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 18:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32ADA2068F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 18:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GaJ1mEru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgF3Sqh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgF3Sqf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 14:46:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F2C061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2020 11:46:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so9459293pgc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2020 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FgQAnwFRb0SbuGIiJ1g2NGG0KnctO//2a2EL3+ivRY=;
        b=GaJ1mEru3nSXAtMvW7DyRFUK0ctXtZwpM2jc8aD/rt8xt9U3FBBhrjk4MoAxNK8fXU
         njBZPDVMm14/Q563shxWzDscFUo8sFS0w+fhNO5NMGcldcsFOM+HbuS4NzD/6GdNFioo
         y7r+vYAcS5f2O8UwcYvQG5q/E6r3HlkAI/Jhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FgQAnwFRb0SbuGIiJ1g2NGG0KnctO//2a2EL3+ivRY=;
        b=jACLIxdAlVs9igBmCx7OhmC4fSXsZ3ZXv7SSuYFUnebta8TYlx1+lAkNkxXTM+bZ+n
         7L03GeThSCo5eRb1B2D5uB+ONvjzjuuRoPh6LcGc89Tn9JRtyNsGbKOnDPpyMUxjNnta
         CUYQI6PwDBCiS+nX9uySNgGwPYU1TUbO77+jkHybILOhQhCI/disvG87pMpqm3zSbFK+
         kFjOAuoHZzLuyOqac6TtaJqfEF9+2rdnq9kLoIavhfqR9LZH35yter3JETql0A3Lhmx3
         cYW5889/pR20cVbTCKF4mwGpBzrO98fxwAnIBRzFfNBtJ1Dn3NJiAVp1SKvW6r1IvNbS
         y0xg==
X-Gm-Message-State: AOAM531RBT1fvJijz+gzD42Eff0vf8m8hBctw01V9rnE5+MD3BLi5Q3O
        TOX9oIclco+FM+WjlFrKU+N3kKYJ78A=
X-Google-Smtp-Source: ABdhPJxjNzsJTaS4QWJcts+5c6Ix9KTR0kIMPzWLISnTonBdPW88+5h20uOMnVWMXi8JpToDU228bw==
X-Received: by 2002:a63:e114:: with SMTP id z20mr14165925pgh.300.1593542795031;
        Tue, 30 Jun 2020 11:46:35 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:b7e2:9910:bd78:608d])
        by smtp.gmail.com with ESMTPSA id x10sm3488663pfp.80.2020.06.30.11.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 11:46:33 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH v2] client: Add battery command
Date:   Tue, 30 Jun 2020 11:46:29 -0700
Message-Id: <20200630184629.95013-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the "battery" command to show battery information of a peer
device based on org.bluez.Battery1 API. Example usage:

[bluetooth]# battery XX:XX:XX:XX:XX:XX
Percentage: 100%
---
 client/main.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/client/main.c b/client/main.c
index 422da5593..8c1ed00fb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -65,6 +65,7 @@ static struct adapter *default_ctrl;
 static GDBusProxy *default_dev;
 static GDBusProxy *default_attr;
 static GList *ctrl_list;
+static GList *battery_proxies;
 
 static const char *agent_arguments[] = {
 	"on",
@@ -107,7 +108,9 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 	bt_shell_set_prompt(PROMPT_OFF);
 
 	g_list_free_full(ctrl_list, proxy_leak);
+	g_list_free_full(battery_proxies, proxy_leak);
 	ctrl_list = NULL;
+	battery_proxies = NULL;
 
 	default_ctrl = NULL;
 }
@@ -445,6 +448,16 @@ done:
 	g_free(desc);
 }
 
+static void battery_added(GDBusProxy *proxy)
+{
+	battery_proxies = g_list_append(battery_proxies, proxy);
+}
+
+static void battery_removed(GDBusProxy *proxy)
+{
+	battery_proxies = g_list_remove(battery_proxies, proxy);
+}
+
 static void device_added(GDBusProxy *proxy)
 {
 	DBusMessageIter iter;
@@ -539,6 +552,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		gatt_add_manager(proxy);
 	} else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
 		ad_manager_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.Battery1")) {
+		battery_added(proxy);
 	}
 }
 
@@ -630,6 +645,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		gatt_remove_manager(proxy);
 	} else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
 		ad_unregister(dbus_conn, NULL);
+	} else if (!strcmp(interface, "org.bluez.Battery1")) {
+		battery_removed(proxy);
 	}
 }
 
@@ -763,6 +780,20 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
 	return NULL;
 }
 
+static GDBusProxy *find_battery_by_path(GList *source, const char *path)
+{
+	GList *list;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		GDBusProxy *proxy = list->data;
+
+		if (strcmp(g_dbus_proxy_get_path(proxy), path) == 0)
+			return proxy;
+	}
+
+	return NULL;
+}
+
 static GDBusProxy *find_proxy_by_address(GList *source, const char *address)
 {
 	GList *list;
@@ -1650,6 +1681,35 @@ static void cmd_info(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_battery(int argc, char *argv[])
+{
+	DBusMessageIter iter;
+	GDBusProxy *device_proxy;
+	GDBusProxy *battery_proxy;
+	unsigned char percentage;
+
+	device_proxy = find_device(argc, argv);
+	if (!device_proxy)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	battery_proxy = find_battery_by_path(battery_proxies,
+					g_dbus_proxy_get_path(device_proxy));
+	if (!battery_proxy) {
+		bt_shell_printf("Device %s does not have battery information\n",
+				argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (g_dbus_proxy_get_property(battery_proxy, "Percentage", &iter) ==
+									FALSE)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	dbus_message_iter_get_basic(&iter, &percentage);
+	bt_shell_printf("Percentage: %d%%\n", percentage);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void pair_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
@@ -2785,6 +2845,8 @@ static const struct bt_shell_menu main_menu = {
 							dev_generator },
 	{ "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
 							dev_generator },
+	{ "battery",      "[dev]",    cmd_battery, "Show device battery",
+							dev_generator },
 	{ } },
 };
 
-- 
2.26.2

