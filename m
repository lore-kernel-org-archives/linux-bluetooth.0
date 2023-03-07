Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98F1C6FD1E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCGW0J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjCGWZq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:25:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D87B06D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:25:09 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kb15so14745617pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8B2lXwNrFIHbcQjST1r7bCRbxcqRLF67pR9ltHnW/U=;
        b=Z+L/NsIyf+qDxs8Ibln4mT+e767e5F5eTELkXRYM/8PURXtjLf0df9OlszFjQIWVUk
         ayPDBDE2aSUPESdSs7uGZuolhpJRelHYEBnkxuWisJFqRah735mCIMNjILzuyOpAZq0o
         Ei/6WieImpJNuFbZK6CUMpjjLN1pq4CU2NrqUSbHGwB7VEmORjdV8Xz9+dhVEjJCaVaE
         yj3jWrLL+iU17ZG2brSIDWOcgLdaSLJQatY+6pTt498W3cODmhS1vpC0+MZDt7SyNqdP
         TMf108ICXiV1gwEXW7WbWjG051LA8xvwAwNAXA6cORfO7iW0jhomqFSFIJKKbSt8x9M7
         f0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8B2lXwNrFIHbcQjST1r7bCRbxcqRLF67pR9ltHnW/U=;
        b=XNqhaQ3WcEuyHEgEnMrXkQlztYPtXn+WOUhHp+pD7sOtimUqF/vuaM3JpihIkm9Hmm
         9GH+kUUjm0jf5P6NO1dGTU3IyWbtBMZdDSYG9+6MG3+VmlGeTERIs129XU6kGUdhxAEP
         x8urztEBTSrDFZkjlYM/Gph6foCSf2X9zGoM7ohmdiANKzlc/qiQX/1HBy3TCl8ZgWkL
         RCYMSi/pK2g9auyPnP71HHwYfS8avBmNKz8sU1W2h5ETxDTB4DtqDd5c6b+j4ebQ2IAs
         m+ToP8GjzXyiqrW9UzW6QxfvE7U6xjR05/kX5n+Jux5tfvbR4m678bRTfUFv3oWQCsp4
         ZVFw==
X-Gm-Message-State: AO0yUKVVqSIno4JtghTii7NhMElc5xw7PGwhUHChOhGT9IDZGHF3rF1Y
        0Ta1z+2EG5INedrX+g3eEsArFnj7s5I=
X-Google-Smtp-Source: AK7set8it+YfeA8ZtDJc4B2LL9/up1PBgBfa5z4eBM+IBhqzjfq/e6vDkdorCz+319sW4FVkWh7YLA==
X-Received: by 2002:a17:902:d512:b0:196:704e:2c9a with SMTP id b18-20020a170902d51200b00196704e2c9amr18977455plg.22.1678227877399;
        Tue, 07 Mar 2023 14:24:37 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902729200b0019c901b35ecsm8814392pll.106.2023.03.07.14.24.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:24:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2 11/12] client: Add support for DeviceSet proxy
Date:   Tue,  7 Mar 2023 14:24:21 -0800
Message-Id: <20230307222422.2608483-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/main.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 10 deletions(-)

diff --git a/client/main.c b/client/main.c
index e5cf1e203ed1..e4a39896b2c6 100644
--- a/client/main.c
+++ b/client/main.c
@@ -51,6 +51,7 @@ struct adapter {
 	GDBusProxy *ad_proxy;
 	GDBusProxy *adv_monitor_proxy;
 	GList *devices;
+	GList *sets;
 };
 
 static struct adapter *default_ctrl;
@@ -232,7 +233,7 @@ static void print_experimental(GDBusProxy *proxy)
 	}
 }
 
-static gboolean device_is_child(GDBusProxy *device, GDBusProxy *parent)
+static gboolean proxy_is_child(GDBusProxy *device, GDBusProxy *parent)
 {
 	DBusMessageIter iter;
 	const char *adapter, *path;
@@ -269,14 +270,14 @@ static gboolean service_is_child(GDBusProxy *service)
 					"org.bluez.Device1") != NULL;
 }
 
-static struct adapter *find_parent(GDBusProxy *device)
+static struct adapter *find_parent(GDBusProxy *proxy)
 {
 	GList *list;
 
 	for (list = g_list_first(ctrl_list); list; list = g_list_next(list)) {
 		struct adapter *adapter = list->data;
 
-		if (device_is_child(device, adapter->proxy) == TRUE)
+		if (proxy_is_child(proxy, adapter->proxy) == TRUE)
 			return adapter;
 	}
 	return NULL;
@@ -399,6 +400,27 @@ static void admon_manager_added(GDBusProxy *proxy)
 	adv_monitor_register_app(dbus_conn);
 }
 
+static void print_set(GDBusProxy *proxy, const char *description)
+{
+	bt_shell_printf("%s%s%sDeviceSet %s\n",
+				description ? "[" : "",
+				description ? : "",
+				description ? "] " : "",
+				g_dbus_proxy_get_path(proxy));
+}
+
+static void set_added(GDBusProxy *proxy)
+{
+	struct adapter *adapter = find_parent(proxy);
+
+	if (!adapter)
+		return;
+
+	adapter->sets = g_list_append(adapter->sets, proxy);
+	print_set(proxy, COLORED_NEW);
+	bt_shell_set_env(g_dbus_proxy_get_path(proxy), proxy);
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -434,6 +456,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface,
 				"org.bluez.AdvertisementMonitorManager1")) {
 		admon_manager_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.DeviceSet1")) {
+		set_added(proxy);
 	}
 }
 
@@ -484,6 +508,7 @@ static void adapter_removed(GDBusProxy *proxy)
 
 			ctrl_list = g_list_remove_link(ctrl_list, ll);
 			g_list_free(adapter->devices);
+			g_list_free(adapter->sets);
 			g_free(adapter);
 			g_list_free(ll);
 			return;
@@ -491,6 +516,19 @@ static void adapter_removed(GDBusProxy *proxy)
 	}
 }
 
+static void set_removed(GDBusProxy *proxy)
+{
+	struct adapter *adapter = find_parent(proxy);
+
+	if (!adapter)
+		return;
+
+	adapter->sets = g_list_remove(adapter->sets, proxy);
+
+	print_set(proxy, COLORED_DEL);
+	bt_shell_set_env(g_dbus_proxy_get_path(proxy), NULL);
+}
+
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -531,6 +569,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface,
 			"org.bluez.AdvertisementMonitorManager1")) {
 		adv_monitor_remove_manager(dbus_conn);
+	} else if (!strcmp(interface, "org.bluez.DeviceSet1")) {
+		set_removed(proxy);
 	}
 }
 
@@ -557,7 +597,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 	interface = g_dbus_proxy_get_interface(proxy);
 
 	if (!strcmp(interface, "org.bluez.Device1")) {
-		if (default_ctrl && device_is_child(proxy,
+		if (default_ctrl && proxy_is_child(proxy,
 					default_ctrl->proxy) == TRUE) {
 			DBusMessageIter addr_iter;
 			char *str;
@@ -1559,6 +1599,39 @@ static struct GDBusProxy *find_device(int argc, char *argv[])
 	return proxy;
 }
 
+static struct GDBusProxy *find_set(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (check_default_ctrl() == FALSE)
+		return NULL;
+
+	proxy = find_proxies_by_path(default_ctrl->sets, argv[1]);
+	if (!proxy) {
+		bt_shell_printf("DeviceSet %s not available\n", argv[1]);
+		return NULL;
+	}
+
+	return proxy;
+}
+
+static void cmd_set_info(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	proxy = find_set(argc, argv);
+	if (!proxy)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	bt_shell_printf("DeviceSet %s\n", g_dbus_proxy_get_path(proxy));
+
+	print_property(proxy, "AutoConnect");
+	print_property(proxy, "Devices");
+	print_property(proxy, "Size");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_info(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -1568,7 +1641,7 @@ static void cmd_info(int argc, char *argv[])
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		return cmd_set_info(argc, argv);
 
 	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -1605,6 +1678,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "TxPower");
 	print_property(proxy, "AdvertisingFlags");
 	print_property(proxy, "AdvertisingData");
+	print_property(proxy, "Sets");
 
 	battery_proxy = find_proxies_by_path(battery_proxies,
 					g_dbus_proxy_get_path(proxy));
@@ -2298,11 +2372,13 @@ static char *generic_generator(const char *text, int state,
 
 		index++;
 
-		if (g_dbus_proxy_get_property(proxy, property, &iter) == FALSE)
+		if (!property)
+			str = g_dbus_proxy_get_path(proxy);
+		else if (g_dbus_proxy_get_property(proxy, property, &iter))
+			dbus_message_iter_get_basic(&iter, &str);
+		else
 			continue;
 
-		dbus_message_iter_get_basic(&iter, &str);
-
 		if (!strncasecmp(str, text, len))
 			return strdup(str);
 	}
@@ -2348,6 +2424,23 @@ static char *dev_generator(const char *text, int state)
 			default_ctrl ? default_ctrl->devices : NULL, "Address");
 }
 
+static char *set_generator(const char *text, int state)
+{
+	return generic_generator(text, state,
+			default_ctrl ? default_ctrl->sets : NULL, NULL);
+}
+
+static char *dev_set_generator(const char *text, int state)
+{
+	char *str;
+
+	str = dev_generator(text, state);
+	if (str)
+		return str;
+
+	return set_generator(text, state);
+}
+
 static char *attribute_generator(const char *text, int state)
 {
 	return gatt_attribute_generator(text, state);
@@ -2965,8 +3058,8 @@ static const struct bt_shell_menu main_menu = {
 	{ "set-alias",    "<alias>",  cmd_set_alias, "Set device alias" },
 	{ "scan",         "<on/off/bredr/le>", cmd_scan,
 				"Scan for devices", scan_generator },
-	{ "info",         "[dev]",    cmd_info, "Device information",
-							dev_generator },
+	{ "info",         "[dev/set]",    cmd_info, "Device/Set information",
+							dev_set_generator },
 	{ "pair",         "[dev]",    cmd_pair, "Pair with device",
 							dev_generator },
 	{ "cancel-pairing",  "[dev]",    cmd_cancel_pairing,
-- 
2.39.2

