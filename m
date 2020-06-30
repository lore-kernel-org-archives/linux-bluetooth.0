Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2A920768
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 17:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HnUjlPya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbgF3RrU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgF3RrU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 13:47:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C62C061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2020 10:47:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so9735605pfe.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2020 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFSRSERRZijSFK7hRNe5Kg4vhWLebcNBDc/HGzP5nvo=;
        b=HnUjlPya3iLGWP7NtsZaQx/gpDW4DyxWcsrfcHYKarn+GsaGar5Mnp4ddrVqu3XT/B
         CGWX0UiahrC29hK/Ff4FnZnJEFlrZxE2jGdAWwQjfCpdlbj8tjAs/6xeiN5obpZ3jmXL
         gLLYIo9bQq2W+2QtU6PBsL7Hk2DejIgROjjqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFSRSERRZijSFK7hRNe5Kg4vhWLebcNBDc/HGzP5nvo=;
        b=faITIJ31OxMTxdDCuAcSyqvzaULW2vjB+v672ICnfj8LkpZgl2O3IvETmlklk3Y7UG
         kpCqrqGY1zW1ZcS6cSJHyKcUm1bcyBArDm6ZbdCwcSRe0ERvuje78z4yOalrltsOBovA
         20d9nMJe6PfjGUrvMVo1Grg8PJg8xHvaumg5mts7dGIlTVWyctE8dneMVODhBo8dPptD
         OpqRj1x1dltaEWY4lwFhcSJ1ED9F3tZsZ46mNkth5GiI9tqOlFJqux27GUx93AoLgAaK
         2dyplyzS2jMjQIGrxCnBT1Mcz3All1m4/C0dNjO7uCw92TfzJuzxkL8WdUllnEvHaO4a
         DI1Q==
X-Gm-Message-State: AOAM5302YW1p9gGKNtuWU9Fn35qmWCUt9GYeHG/1JFc5qwuarSJGjeHd
        prJR5TCE/mTpZI7423UGED2ZdRycayc=
X-Google-Smtp-Source: ABdhPJwmBhOcrmpvrr1GchxHE/h9pOTtNfP4mgFzhm7maqlOhaCwAWZ3aZu0HJ7ztTVZzuxNFL5O4A==
X-Received: by 2002:a63:457:: with SMTP id 84mr16203374pge.219.1593539239383;
        Tue, 30 Jun 2020 10:47:19 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:b7e2:9910:bd78:608d])
        by smtp.gmail.com with ESMTPSA id u8sm2850417pjn.24.2020.06.30.10.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 10:47:18 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH 1/1] client: Add battery command
Date:   Tue, 30 Jun 2020 10:47:07 -0700
Message-Id: <20200630174707.214317-1-sonnysasaka@chromium.org>
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
 client/main.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/client/main.c b/client/main.c
index 422da5593..cc5eb7ce8 100644
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
 
@@ -763,6 +780,19 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
 	return NULL;
 }
 
+static GDBusProxy *find_battery_by_path(GList *source, const char *path)
+{
+	GList *list;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		GDBusProxy *proxy = list->data;
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
@@ -1650,6 +1680,35 @@ static void cmd_info(int argc, char *argv[])
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
@@ -2785,6 +2844,8 @@ static const struct bt_shell_menu main_menu = {
 							dev_generator },
 	{ "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
 							dev_generator },
+	{ "battery",      "[dev]",    cmd_battery, "Show device battery",
+							dev_generator },
 	{ } },
 };
 
-- 
2.26.2

