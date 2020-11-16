Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33685C4742C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 18:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23E2206F9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 18:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yexe/DiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbgKPS0c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbgKPS0c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 13:26:32 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7F6C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 10:26:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m186so7497709ybm.22
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 10:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tO18+90EOV2bHOTSdvoYawjZxj6UFLMMK348UGkcVfY=;
        b=Yexe/DiT8zwIxXCi4QezLU2wpijCrDrRD3D9KijcNAi0wm4v5kJq4OFaG/WDPCHTm9
         gWKNe5H7z8K7qy1BJjpp7cWezr5gsd5XUjA18bcVJeblkG77L/2B+U6IcGtaXlg9Eg0E
         MRE6zmzGALrOBhtqeEt3BVE0dyQqmWMHyk92Q7Sdf076oUudUSbbkVIY8vArCotE3NSl
         YbuxTEqnuLQj2iLfS9AgLhVfYI7R+3ZtrtRIgQ+l1WSBC6Ute/tirWUN2QuZ0+jrnvpT
         +qHN/NS8e/jAYEhQeyoHi5UC5KMQccnWjigKrfiR1eUEYA05jrdP4YJqkllzZGX+iK9A
         yHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tO18+90EOV2bHOTSdvoYawjZxj6UFLMMK348UGkcVfY=;
        b=IrJ/omu9dzaWXDipNpHuZFwpksyCXdoRX4sOPBSX++2H+0J9yT7rnKlsyAT8ISerR/
         D7+kJvU8wFg8ECVf6gqQgJYs3ReJMNC8c5chAy3cqPhBuJf04eeSAtlB/MQyu7JQESv5
         sZnBVCdWNrTNChtDDYz/jhpRsACYRG1T4qn7kYGBmVvLXLpYsnd0OtIpAvcFUiRGHDca
         31mP8LkJu9cS2pVhDMzaI3I/b13+40HGf+Rn9say0MDw+0658YjrVGMH4ESZqcA/itTe
         F71EijAk8R7H0MXY0bUcK5aSaOJcy+t8TUZEPZbnWR3ck0W4jMZwowtR3bHJvEW2LCEG
         My2A==
X-Gm-Message-State: AOAM531OrkXH0M9/waP4A5t9M70eL2qKGGTKVx73w/13yaFfi4J/WnJP
        mJol/xWdxiuX+RMGU/5QzsAz2oZwM+eIDA==
X-Google-Smtp-Source: ABdhPJzTs+oxz+A+qv8jRchWxZcOaiHb2hWYXuHctkrZRWHmFsNSCusffqJ3Tm+toeD8FuF4Dln4mVzvRDerrw==
Sender: "mmandlik via sendgmr" <mmandlik@mmandlik.mtv.corp.google.com>
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:e50e])
 (user=mmandlik job=sendgmr) by 2002:a25:8884:: with SMTP id
 d4mr22486683ybl.58.1605551190073; Mon, 16 Nov 2020 10:26:30 -0800 (PST)
Date:   Mon, 16 Nov 2020 10:25:53 -0800
Message-Id: <20201116102547.bluez.v1.1.I4dd1c737d5f8806fe2aa99b8c2d8154fe58871ed@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [bluez PATCH v1] adv_monitor: Update log messages
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

 src/adv_monitor.c | 58 +++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index c786015c8..d4300c033 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -237,8 +237,9 @@ static void app_disconnect_cb(DBusConnection *conn, void *user_data)
 {
 	struct adv_monitor_app *app = user_data;
 
-	btd_info(app->manager->adapter_id, "Adv Monitor app %s disconnected "
-			"from D-Bus", app->owner);
+	btd_info(app->manager->adapter_id,
+			"Adv Monitor app %s disconnected from D-Bus",
+			app->owner);
 	if (app && queue_remove(app->manager->apps, app))
 		app_destroy(app);
 }
@@ -312,8 +313,9 @@ static bool parse_monitor_type(struct adv_monitor *monitor, const char *path)
 	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
 	if (!g_dbus_proxy_get_property(monitor->proxy, "Type", &iter)) {
-		btd_error(adapter_id, "Failed to retrieve property Type from "
-			"the Adv Monitor at path %s", path);
+		btd_error(adapter_id,
+				"Failed to retrieve property Type from the "
+				"Adv Monitor at path %s", path);
 		return false;
 	}
 
@@ -330,8 +332,9 @@ static bool parse_monitor_type(struct adv_monitor *monitor, const char *path)
 	}
 
 failed:
-	btd_error(adapter_id, "Invalid argument of property Type of the Adv "
-			"Monitor at path %s", path);
+	btd_error(adapter_id,
+			"Invalid argument of property Type of the Adv Monitor "
+			"at path %s", path);
 
 	return false;
 }
@@ -431,8 +434,9 @@ failed:
 	monitor->high_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
 	monitor->low_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
 
-	btd_error(adapter_id, "Invalid argument of property "
-			"RSSIThresholdsAndTimers of the Adv Monitor at path %s",
+	btd_error(adapter_id,
+			"Invalid argument of property RSSIThresholdsAndTimers "
+			"of the Adv Monitor at path %s",
 			path);
 
 	return false;
@@ -447,8 +451,9 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
 	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
 	if (!g_dbus_proxy_get_property(monitor->proxy, "Patterns", &array)) {
-		btd_error(adapter_id, "Failed to retrieve property Patterns "
-				"from the Adv Monitor at path %s", path);
+		btd_error(adapter_id,
+				"Failed to retrieve property Patterns from the "
+				"Adv Monitor at path %s", path);
 		return false;
 	}
 
@@ -556,8 +561,9 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
 	if (status != MGMT_STATUS_SUCCESS || !param) {
-		btd_error(adapter_id, "Failed to Add Adv Patterns Monitor "
-				"with status 0x%02x", status);
+		btd_error(adapter_id,
+				"Failed to Add Adv Patterns Monitor with status"
+				" 0x%02x", status);
 		monitor_release(monitor, NULL);
 		return;
 	}
@@ -610,15 +616,17 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
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
 
@@ -852,8 +860,9 @@ static DBusMessage *unregister_monitor(DBusConnection *conn,
 	queue_remove(manager->apps, app);
 	app_destroy(app);
 
-	btd_info(manager->adapter_id, "Path %s removed along with Adv Monitor "
-			"app %s", match.path, match.owner);
+	btd_info(manager->adapter_id,
+			"Path %s removed along with Adv Monitor app %s",
+			match.path, match.owner);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -972,8 +981,8 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
 	const uint16_t adapter_id = manager->adapter_id;
 
 	if (length < sizeof(*ev)) {
-		btd_error(adapter_id, "Wrong size of Adv Monitor Removed "
-				"event");
+		btd_error(adapter_id,
+				"Wrong size of Adv Monitor Removed event");
 		return;
 	}
 
@@ -1044,8 +1053,9 @@ static void read_adv_monitor_features_cb(uint8_t status, uint16_t length,
 	struct btd_adv_monitor_manager *manager = user_data;
 
 	if (status != MGMT_STATUS_SUCCESS || !param) {
-		btd_error(manager->adapter_id, "Failed to Read Adv Monitor "
-				"Features with status 0x%02x", status);
+		btd_error(manager->adapter_id,
+				"Failed to Read Adv Monitor Features with "
+				"status 0x%02x", status);
 		return;
 	}
 
@@ -1387,8 +1397,8 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
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
2.29.2.299.gdc1121823c-goog

