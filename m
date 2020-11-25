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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A72AC56202
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 20:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3554207BC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 20:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zs4Igh0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgKYUSw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Nov 2020 15:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgKYUSw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Nov 2020 15:18:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4609C0613D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 12:18:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r4so1114212ybs.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 12:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WAMiLvVDV3ukDWbsvwQ/iKjjKPj8liDfWUiBOm9jQhE=;
        b=Zs4Igh0XpFqFUHhU4ScFQr1NTTTgbmvu30GoUXoAB0+1v7TK7jh0Byv20TWrxJKIvx
         seaO66oZt/69Nr1qsV7+6axGf+73PjNP9NnWMV0N4bADXOmMdrqutBMnRnRMJV3644ef
         8EWcw2EACiTNxEbOnsYb/cAGdHzLHHKl3+G1jjdcLBte3DFSZwHq19a55cA0R48J3tuA
         y+4pFHu7WBIsRd+mbX/SV53Rb7lyzzFrcRfv3YPVQLQpZXclG+UX0osFot1M7goZG21e
         8UjZdAhvbKaiSTr/hMJjvI9I2KD6ChOVI2UtfSXoW5hpLLyoCe7ezoMXuip5YTvSIG8H
         dlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WAMiLvVDV3ukDWbsvwQ/iKjjKPj8liDfWUiBOm9jQhE=;
        b=nwzyQpboNLKbdi0n14MEg2uhhY9EuCttS3Od0TQRASz1ppIa6FHMrL3TLhVoFNcRof
         Coyx0bHRf4gdbmcJmF5O1Pbm8Dsup9KakhvSRdVkjuh4sMK3l1QOqY7SPwQmtgwZpHLE
         iMAbDYQrYjj8dBjCq/vgjpUgzvBQZ0Cf/wo8e0lv4qTuhGWlj7CvkvJ8ARUoQRzwES2x
         VaJe2Vxe4+1Cf77NWVtUcLmLcjijY7qcVjhnOBiBCPCinHFJD4FNOKOPp809qnUJflhM
         A3+jdw/84dByIzu8YJPyKrCAVWzjoyXV33SIMtyCdZeRRNi3WRLwDij6nkW7K+EtZwIi
         QU2Q==
X-Gm-Message-State: AOAM533gfhVtGIVnqKGtBBlPVy5Tifo8IW4+m7shooF+pgt5XanDOGPv
        U3V55JGQtJX2HKrPsglYQGSLNLc8hLhVAw==
X-Google-Smtp-Source: ABdhPJzt69RPmqStLcQ19xv/HE56QBwy0/mRwj5x5hCKmcR224zP1m5tK+UMC9z2V2oDXSP1+qgqBLjDYEZ0zw==
Sender: "mmandlik via sendgmr" <mmandlik@mmandlik.mtv.corp.google.com>
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:e50e])
 (user=mmandlik job=sendgmr) by 2002:a25:3a86:: with SMTP id
 h128mr5366248yba.401.1606335530896; Wed, 25 Nov 2020 12:18:50 -0800 (PST)
Date:   Wed, 25 Nov 2020 12:18:46 -0800
Message-Id: <20201125121844.bluez.v2.1.I4dd1c737d5f8806fe2aa99b8c2d8154fe58871ed@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [bluez PATCH v2] adv_monitor: Update log messages
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>, mcchou@chromium.org,
        alainm@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update log messages to avoid breaking of user-visible log strings
to make it easy to grep for them.

Reviewed-by: mcchou@chromium.org
Reviewed-by: alainm@chromium.org
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

Changes in v2:
- Fix merge conflicts

 src/adv_monitor.c | 58 +++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index fc058dbf1..767c1c82d 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -318,8 +318,9 @@ static void app_disconnect_cb(DBusConnection *conn, void *user_data)
 		return;
 	}
 
-	btd_info(app->manager->adapter_id, "Adv Monitor app %s disconnected "
-			"from D-Bus", app->owner);
+	btd_info(app->manager->adapter_id,
+			"Adv Monitor app %s disconnected from D-Bus",
+			app->owner);
 
 	if (queue_remove(app->manager->apps, app)) {
 		queue_foreach(app->monitors, monitor_state_released, NULL);
@@ -396,8 +397,9 @@ static bool parse_monitor_type(struct adv_monitor *monitor, const char *path)
 	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
 	if (!g_dbus_proxy_get_property(monitor->proxy, "Type", &iter)) {
-		btd_error(adapter_id, "Failed to retrieve property Type from "
-			"the Adv Monitor at path %s", path);
+		btd_error(adapter_id,
+				"Failed to retrieve property Type from the "
+				"Adv Monitor at path %s", path);
 		return false;
 	}
 
@@ -414,8 +416,9 @@ static bool parse_monitor_type(struct adv_monitor *monitor, const char *path)
 	}
 
 failed:
-	btd_error(adapter_id, "Invalid argument of property Type of the Adv "
-			"Monitor at path %s", path);
+	btd_error(adapter_id,
+			"Invalid argument of property Type of the Adv Monitor "
+			"at path %s", path);
 
 	return false;
 }
@@ -515,8 +518,9 @@ failed:
 	monitor->high_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
 	monitor->low_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
 
-	btd_error(adapter_id, "Invalid argument of property "
-			"RSSIThresholdsAndTimers of the Adv Monitor at path %s",
+	btd_error(adapter_id,
+			"Invalid argument of property RSSIThresholdsAndTimers "
+			"of the Adv Monitor at path %s",
 			path);
 
 	return false;
@@ -531,8 +535,9 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
 	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
 	if (!g_dbus_proxy_get_property(monitor->proxy, "Patterns", &array)) {
-		btd_error(adapter_id, "Failed to retrieve property Patterns "
-				"from the Adv Monitor at path %s", path);
+		btd_error(adapter_id,
+				"Failed to retrieve property Patterns from the "
+				"Adv Monitor at path %s", path);
 		return false;
 	}
 
@@ -640,8 +645,9 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
 	if (status != MGMT_STATUS_SUCCESS || !param) {
-		btd_error(adapter_id, "Failed to Add Adv Patterns Monitor "
-				"with status 0x%02x", status);
+		btd_error(adapter_id,
+				"Failed to Add Adv Patterns Monitor with status"
+				" 0x%02x", status);
 		monitor->state = MONITOR_STATE_FAILED;
 		monitor_destroy(monitor);
 		return;
@@ -696,15 +702,17 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 	}
 
 	if (queue_find(app->monitors, monitor_match, proxy)) {
-		btd_error(adapter_id, "Adv Monitor proxy already exists with "
-				"path %s", path);
+		btd_error(adapter_id,
+				"Adv Monitor proxy already exists with path %s",
+				path);
 		return;
 	}
 
 	monitor = monitor_new(app, proxy);
 	if (!monitor) {
-		btd_error(adapter_id, "Failed to allocate an Adv Monitor for "
-				"the object at %s", path);
+		btd_error(adapter_id,
+				"Failed to allocate an Adv Monitor for the "
+				"object at %s", path);
 		return;
 	}
 
@@ -882,8 +890,9 @@ static DBusMessage *unregister_monitor(DBusConnection *conn,
 	queue_remove(manager->apps, app);
 	app_destroy(app);
 
-	btd_info(manager->adapter_id, "Path %s removed along with Adv Monitor "
-			"app %s", match.path, match.owner);
+	btd_info(manager->adapter_id,
+			"Path %s removed along with Adv Monitor app %s",
+			match.path, match.owner);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -1021,8 +1030,8 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
 	const uint16_t adapter_id = manager->adapter_id;
 
 	if (length < sizeof(*ev)) {
-		btd_error(adapter_id, "Wrong size of Adv Monitor Removed "
-				"event");
+		btd_error(adapter_id,
+				"Wrong size of Adv Monitor Removed event");
 		return;
 	}
 
@@ -1093,8 +1102,9 @@ static void read_adv_monitor_features_cb(uint8_t status, uint16_t length,
 	struct btd_adv_monitor_manager *manager = user_data;
 
 	if (status != MGMT_STATUS_SUCCESS || !param) {
-		btd_error(manager->adapter_id, "Failed to Read Adv Monitor "
-				"Features with status 0x%02x", status);
+		btd_error(manager->adapter_id,
+				"Failed to Read Adv Monitor Features with "
+				"status 0x%02x", status);
 		return;
 	}
 
@@ -1436,8 +1446,8 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 	if (!dev) {
 		dev = monitor_device_create(monitor, device);
 		if (!dev) {
-			btd_error(adapter_id, "Failed to create Adv Monitor "
-					      "device object.");
+			btd_error(adapter_id,
+				"Failed to create Adv Monitor device object.");
 			return;
 		}
 	}
-- 
2.29.2.454.gaff20da3a2-goog

