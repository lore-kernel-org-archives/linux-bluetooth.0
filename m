Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62219C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 22:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AFC2074B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 22:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy5d1sQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436919AbgE1WP0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 18:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436892AbgE1WPY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 18:15:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B64BC08C5C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 15:15:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x11so144181plv.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 15:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8394bsblGFqXCWgY7YSUKW/6orygLiOylZGjntxEjQ=;
        b=Jy5d1sQ6mODIHcenZO/99Per52eSkfd5WW6uE1HkOuaiOuHFam5FflswwsafBwDq84
         9IQV8JAGdqL42/0SDA/mRc7aBprmPjvTxOC3QNTqC+bk/v0TYZ0NVFH3MEnLh+g6w3qM
         MP5f4xGPLHVARQCEa2k1AOncos2kNJc3pQjDeB0suC57I6xPPcdD5malKRJ4hrlGAO1j
         0h6xDoAgcNFX3fRmF5CFB6/mIXUcb/FZcermL18yFR1fpr/42EyzO9y15mgKXh4XF6hO
         V6ph+7bLgsN5yha+bMoUpXeKmQrurCZ+pZxHgs9aE3ssxziyMhRWfPmT2y4ZSMQ3z7ut
         /IfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8394bsblGFqXCWgY7YSUKW/6orygLiOylZGjntxEjQ=;
        b=QDFgfUqZrLqZ0zaSF4Qk8p+iedzHVSOBb49J/2SfKuwuEarRQxjOHJ4hGoMSTmLY+m
         WksjApr+MjeS08DpA9JeARoKy4iT2jfBZLgEex1sM7WDeNdToq5iZ7UomcR6g9qxxkDO
         H9MsENK9hkoL1XtNkSDvQl8QP57PYsZ0pDdRBHbLYDREB9QQzk3W9ezMn2Q8LkMQKNZa
         G0YSew7ifZx2XchmQUDBVdr/BDXrcL0+zBc2UGJ7pz6dZnbbRsvUa0o1G1I+dd4CUM2z
         BlP7qxowyjCLm7S0K0CJqmvughbE74aCH2ok5jn/f+merHN1uYGuihWwmWdmR5/1znnS
         /XBQ==
X-Gm-Message-State: AOAM530xq0EOLOvNYD4Yqjcg/WXZvdHAG2PcxeSkr+VuXdDy5g0LqeEj
        oU/xrZncwHkoQ1ipwFsTpEYpjpbt
X-Google-Smtp-Source: ABdhPJw03VOOXCU/wmND3z9Em04f7ZpvU2EZpfWl9fryPPnMPnRLrCqUi3RbJhRkK9bKAhwwCaaCvA==
X-Received: by 2002:a17:902:9d94:: with SMTP id c20mr5780453plq.224.1590704121203;
        Thu, 28 May 2020 15:15:21 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m2sm5390292pfe.41.2020.05.28.15.15.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:15:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] adapter: Fix not removing client from discovery list
Date:   Thu, 28 May 2020 15:15:19 -0700
Message-Id: <20200528221519.227605-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If command MGMT_OP_START_DISCOVERY fails we reply with btd_error_busy
but we don't remove the client from the list which would prevent the
client to start it once again.
---
 src/adapter.c | 225 +++++++++++++++++++++++++-------------------------
 1 file changed, 113 insertions(+), 112 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 972d88772..c3d60697a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1468,6 +1468,118 @@ static void free_discovery_filter(struct discovery_filter *discovery_filter)
 	g_free(discovery_filter);
 }
 
+static void invalidate_rssi_and_tx_power(gpointer a)
+{
+	struct btd_device *dev = a;
+
+	device_set_rssi(dev, 0);
+	device_set_tx_power(dev, 127);
+}
+
+static gboolean remove_temp_devices(gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	GSList *l, *next;
+
+	DBG("%s", adapter->path);
+
+	adapter->temp_devices_timeout = 0;
+
+	for (l = adapter->devices; l != NULL; l = next) {
+		struct btd_device *dev = l->data;
+
+		next = g_slist_next(l);
+
+		if (device_is_temporary(dev) && !btd_device_is_connected(dev))
+			btd_adapter_remove_device(adapter, dev);
+	}
+
+	return FALSE;
+}
+
+static void discovery_cleanup(struct btd_adapter *adapter)
+{
+	GSList *l, *next;
+
+	adapter->discovery_type = 0x00;
+
+	if (adapter->discovery_idle_timeout > 0) {
+		g_source_remove(adapter->discovery_idle_timeout);
+		adapter->discovery_idle_timeout = 0;
+	}
+
+	if (adapter->temp_devices_timeout > 0) {
+		g_source_remove(adapter->temp_devices_timeout);
+		adapter->temp_devices_timeout = 0;
+	}
+
+	g_slist_free_full(adapter->discovery_found,
+						invalidate_rssi_and_tx_power);
+	adapter->discovery_found = NULL;
+
+	if (!adapter->devices)
+		return;
+
+	for (l = adapter->devices; l != NULL; l = next) {
+		struct btd_device *dev = l->data;
+
+		next = g_slist_next(l);
+
+		if (device_is_temporary(dev) && !device_is_connectable(dev))
+			btd_adapter_remove_device(adapter, dev);
+	}
+
+	adapter->temp_devices_timeout = g_timeout_add_seconds(TEMP_DEV_TIMEOUT,
+						remove_temp_devices, adapter);
+}
+
+static void discovery_free(void *user_data)
+{
+	struct watch_client *client = user_data;
+
+	if (client->watch)
+		g_dbus_remove_watch(dbus_conn, client->watch);
+
+	if (client->discovery_filter) {
+		free_discovery_filter(client->discovery_filter);
+		client->discovery_filter = NULL;
+	}
+
+	if (client->msg)
+		dbus_message_unref(client->msg);
+
+	g_free(client->owner);
+	g_free(client);
+}
+
+static void discovery_remove(struct watch_client *client, bool exit)
+{
+	struct btd_adapter *adapter = client->adapter;
+
+	DBG("owner %s", client->owner);
+
+	adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
+								client);
+
+	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
+								client);
+
+	if (!exit && client->discovery_filter)
+		adapter->set_filter_list = g_slist_prepend(
+					adapter->set_filter_list, client);
+	else
+		discovery_free(client);
+
+	/*
+	 * If there are other client discoveries in progress, then leave
+	 * it active. If not, then make sure to stop the restart timeout.
+	 */
+	if (adapter->discovery_list)
+		return;
+
+	discovery_cleanup(adapter);
+}
+
 static void trigger_start_discovery(struct btd_adapter *adapter, guint delay);
 
 static void start_discovery_complete(uint8_t status, uint16_t length,
@@ -1538,6 +1650,7 @@ fail:
 		reply = btd_error_busy(client->msg);
 		g_dbus_send_message(dbus_conn, reply);
 		g_dbus_remove_watch(dbus_conn, client->watch);
+		discovery_remove(client, false);
 		return;
 	}
 
@@ -1784,90 +1897,6 @@ static void discovering_callback(uint16_t index, uint16_t length,
 	}
 }
 
-static void invalidate_rssi_and_tx_power(gpointer a)
-{
-	struct btd_device *dev = a;
-
-	device_set_rssi(dev, 0);
-	device_set_tx_power(dev, 127);
-}
-
-static gboolean remove_temp_devices(gpointer user_data)
-{
-	struct btd_adapter *adapter = user_data;
-	GSList *l, *next;
-
-	DBG("%s", adapter->path);
-
-	adapter->temp_devices_timeout = 0;
-
-	for (l = adapter->devices; l != NULL; l = next) {
-		struct btd_device *dev = l->data;
-
-		next = g_slist_next(l);
-
-		if (device_is_temporary(dev) && !btd_device_is_connected(dev))
-			btd_adapter_remove_device(adapter, dev);
-	}
-
-	return FALSE;
-}
-
-static void discovery_cleanup(struct btd_adapter *adapter)
-{
-	GSList *l, *next;
-
-	adapter->discovery_type = 0x00;
-
-	if (adapter->discovery_idle_timeout > 0) {
-		g_source_remove(adapter->discovery_idle_timeout);
-		adapter->discovery_idle_timeout = 0;
-	}
-
-	if (adapter->temp_devices_timeout > 0) {
-		g_source_remove(adapter->temp_devices_timeout);
-		adapter->temp_devices_timeout = 0;
-	}
-
-	g_slist_free_full(adapter->discovery_found,
-						invalidate_rssi_and_tx_power);
-	adapter->discovery_found = NULL;
-
-	if (!adapter->devices)
-		return;
-
-	for (l = adapter->devices; l != NULL; l = next) {
-		struct btd_device *dev = l->data;
-
-		next = g_slist_next(l);
-
-		if (device_is_temporary(dev) && !device_is_connectable(dev))
-			btd_adapter_remove_device(adapter, dev);
-	}
-
-	adapter->temp_devices_timeout = g_timeout_add_seconds(TEMP_DEV_TIMEOUT,
-						remove_temp_devices, adapter);
-}
-
-static void discovery_free(void *user_data)
-{
-	struct watch_client *client = user_data;
-
-	if (client->watch)
-		g_dbus_remove_watch(dbus_conn, client->watch);
-
-	if (client->discovery_filter) {
-		free_discovery_filter(client->discovery_filter);
-		client->discovery_filter = NULL;
-	}
-
-	if (client->msg)
-		dbus_message_unref(client->msg);
-
-	g_free(client->owner);
-	g_free(client);
-}
-
 static bool set_discovery_discoverable(struct btd_adapter *adapter, bool enable)
 {
 	if (adapter->discovery_discoverable == enable)
@@ -1882,34 +1911,6 @@ static bool set_discovery_discoverable(struct btd_adapter *adapter, bool enable)
 	return set_discoverable(adapter, enable, 0);
 }
 
-static void discovery_remove(struct watch_client *client, bool exit)
-{
-	struct btd_adapter *adapter = client->adapter;
-
-	DBG("owner %s", client->owner);
-
-	adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
-								client);
-
-	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
-								client);
-
-	if (!exit && client->discovery_filter)
-		adapter->set_filter_list = g_slist_prepend(
-					adapter->set_filter_list, client);
-	else
-		discovery_free(client);
-
-	/*
-	 * If there are other client discoveries in progress, then leave
-	 * it active. If not, then make sure to stop the restart timeout.
-	 */
-	if (adapter->discovery_list)
-		return;
-
-	discovery_cleanup(adapter);
-}
-
 static void stop_discovery_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-- 
2.25.3

