Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED2DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 19:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B5C20760
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 19:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NQuG+Pir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgGATWa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGATW3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 15:22:29 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520CC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 12:22:29 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y2so26274539ioy.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6TlhrelhU8fdJUNlU1isvDCohx4f+8EV5ngRMY2hFfw=;
        b=NQuG+PirxnU/5vrjbV6BgXfINOlX4vcGT30WLG/GuqaFuFg12VkWnFPXqMxkLo0yTT
         Km77VknOYqThXBKAADpUuHXkWa91hw+kmvD1/1bxkf1sEOaAzpM4pDYsBP77LVuwvWdM
         kDYTLR/Qs/RCDlNYDD1lzlyd0uZEphasb1G8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6TlhrelhU8fdJUNlU1isvDCohx4f+8EV5ngRMY2hFfw=;
        b=ofJftQTpUGibPjIOAnq6O7YSoMhDiGoRspvT5J5ZxIFISqNBGenQyYayA4K1gV6hiN
         cPs9eniDNwybt36rd2gXcKjn5iHlkFkwZr8ay2nes2febfNttZKi1FKZKEMY2j2YzVpQ
         55FUl4t+yGTSgE680dTu8TbZ3t2Y3LTQumBme8G19fqOiF92zLFjD6dNFN0F2PnuRf3K
         27Ml+yQLCYzJmrpeDBpPaUjUeQubGwlsc2KNHUNoUQmmvr50dygKGhZDzc1+K4mPOAuj
         7KtkCCbkKvVtDcBY4HGaGNa751e3s0ZDylj9HYaWu6o9i1q7Sxj62VZo6BT9rLgoZ/gm
         Q5Nw==
X-Gm-Message-State: AOAM531jS/jMrXLuL5L8Gmafl+OguB2sLV3YtR3FaH3rD95sAzjORiNA
        jr97tyaQXA2KPOP4EQAraUWmtyoUS0ooVg==
X-Google-Smtp-Source: ABdhPJwY+awYWBCzem7yJ/upDongUzw/WbCaxnXSADtjN1JAHkw4fw+Y4CQMW6Bw7qLSQcAil6bo8g==
X-Received: by 2002:a6b:90c:: with SMTP id t12mr3862455ioi.152.1593631348754;
        Wed, 01 Jul 2020 12:22:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id d77sm3862513ill.67.2020.07.01.12.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 12:22:28 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH v2] client: Add battery percentage to info command
Date:   Wed,  1 Jul 2020 12:22:02 -0700
Message-Id: <20200701192202.9508-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the Battery Percentage to the info command based on
org.bluez.Battery1 API. Example usage:

[bluetooth]# info XX:XX:XX:XX:XX:XX
Device XX:XX:XX:XX:XX:XX (random)
        Name: ...
        Alias: ...
        ...
        Modalias: ...
        Battery Percentage: 100%
---
 client/main.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/client/main.c b/client/main.c
index 422da5593..4b787240e 100644
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
@@ -1606,8 +1637,10 @@ static struct GDBusProxy *find_device(int argc, char *argv[])
 static void cmd_info(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
+	GDBusProxy *battery_proxy;
 	DBusMessageIter iter;
 	const char *address;
+	unsigned char percentage;
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
@@ -1647,6 +1680,16 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "AdvertisingFlags");
 	print_property(proxy, "AdvertisingData");
 
+	battery_proxy = find_battery_by_path(battery_proxies,
+					g_dbus_proxy_get_path(proxy));
+	if (battery_proxy && g_dbus_proxy_get_property(
+				battery_proxy, "Percentage", &iter)) {
+		dbus_message_iter_get_basic(&iter, &percentage);
+		bt_shell_printf("\tBattery Percentage: %d%%\n", percentage);
+	} else {
+		bt_shell_printf("\tNo battery information\n");
+	}
+
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-- 
2.17.1

