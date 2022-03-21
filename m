Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8452DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 01:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbiCUBit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 21:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242906AbiCUBis (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 21:38:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A6DDD97A
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y32-20020a25ad20000000b006339fb8e18cso8411417ybi.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GXP6gytR/IH82JZglBDkMhSpMbMKKcfVk1giEr7fMLQ=;
        b=DH8mL8UPdPtPw/c+mZHBfeLAFMHKvyn92DMnEKnsIUeCF8pudXxyrgCgfA7L6odn9t
         EMaEIu4ECHCWGkm49IJ/BT4cuinyF9TB5/rc6aC4JUO3tdfU9Jr3sCpswxAi67Q2gdWk
         wCqwp70kyxUOzzcwmVgCkFmXQ4qFE7DvCRpGVWuMeyPO+KgPUExH0Aup+mbRM+dr7bmK
         qxi3ybBNwlhZYTQwLQMRKlUCWJcouDRpM2XxroAA9kX5LCRhe6nIZlZkLz0wj2ksx/Qo
         822a1Q3PKowPreuSe8nGYOu3PafCVnZZMFPTBo33e+aiQaqPMyush21w8AVzfBTH6ExM
         P1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GXP6gytR/IH82JZglBDkMhSpMbMKKcfVk1giEr7fMLQ=;
        b=hJXHOIyiHoxynFvdtyZQeYhRBddTWy/g1uqfbEHBSy7DsdthghyG/XkgQS9FJgTO8k
         AXPgfpjo3QQgMAhHwSnGyBPETjbGLwAkue6fk6VasBcVamgIk3bJFRGW707pmqOlNach
         PW6PWrDlML79UQU+y8Qj2KsmAn6uovoyv1uVAdOFN+Gm27PasbOaZ7+8JXijc67Z/hud
         fArYVv+N8kegtEj7OwbVsrmqvHfxjrsZdZuJM9A4RC2oaOsnARYUMNMOWqlQiNrFqjdx
         YDLTSDKp/B1HNSor4SX5a3bHJw9hiE3OU4N6GDjBGcwNspEOFGKbygn3566h9taTrbLa
         0RUQ==
X-Gm-Message-State: AOAM530otvCA6+npQ6Rn4VoOHMEM/LxmVQNYyakrofRQD9KHanfytalZ
        lbnl6m0EnAfqopZ68hDDZlsQAMfxUAc25Q==
X-Google-Smtp-Source: ABdhPJzMqOWGU8GbqSvdcoCvBq9DPyMmoluoHTUzGlOZmdfbLeRmRNFtV+Lm6ypYPRoLLuVhThy10mjEcd6trA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e0cb:81c1:7b8f:ab9f])
 (user=mmandlik job=sendgmr) by 2002:a25:5d0d:0:b0:633:25c8:380 with SMTP id
 r13-20020a255d0d000000b0063325c80380mr19732725ybb.167.1647826642982; Sun, 20
 Mar 2022 18:37:22 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:37:01 -0700
In-Reply-To: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220320183445.BlueZ.7.I668ef2477efd8fcdd9c44975c5f7b9f32af966ca@changeid>
Mime-Version: 1.0
References: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [BlueZ PATCH 7/9] adv_monitor: Add the monitor Release reason
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adv Monitor is released for various reasons. For example, incorrect RSSI
parameters, incorrect monitor type, non-overlapping RSSI thresholds,
etc.

Return this release reason along with the Release event for the better
visibility to clients.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 doc/advertisement-monitor-api.txt | 12 ++++++-
 src/adv_monitor.c                 | 56 ++++++++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
index 942d44b2f..fcbd9c5c2 100644
--- a/doc/advertisement-monitor-api.txt
+++ b/doc/advertisement-monitor-api.txt
@@ -17,12 +17,22 @@ Service		org.bluez
 Interface	org.bluez.AdvertisementMonitor1 [experimental]
 Object path	freely definable
 
-Methods		void Release() [noreply]
+Methods		void Release(Int8 reason) [noreply]
 
 			This gets called as a signal for a client to perform
 			clean-up when (1)a monitor cannot be activated after it
 			was exposed or (2)a monitor has been deactivated.
 
+			Possible reasons:  0  Unknown reason
+					   1  Invalid monitor type
+					   2  Invalid RSSI parameter(s)
+					   3  Invalid pattern(s)
+					   4  Monitor already exists
+					   5  Kernel failed to add monitor
+					   6  Kernel failed to remove monitor
+					   7  Monitor removed by kernel
+					   8  App unregistered/destroyed
+
 		void Activate() [noreply]
 
 			After a monitor was exposed, this gets called as a
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 85231557e..6ee3736d2 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -90,6 +90,18 @@ enum monitor_state {
 	MONITOR_STATE_RELEASED,	/* Dbus Object removed by app */
 };
 
+enum monitor_release_reason {
+	REASON_UNKNOWN,
+	REASON_INVALID_TYPE,
+	REASON_INVALID_RSSI_PARAMS,
+	REASON_INVALID_PATTERNS,
+	REASON_ALREADY_EXISTS,
+	REASON_FAILED_TO_ADD,
+	REASON_FAILED_TO_REMOVE,
+	REASON_REMOVED_BY_KERNEL,
+	REASON_APP_DESTROYED,
+};
+
 enum merged_pattern_state {
 	MERGED_PATTERN_STATE_ADDING,	/* Adding pattern to kernel */
 	MERGED_PATTERN_STATE_REMOVING,	/* Removing pattern from kernel */
@@ -113,6 +125,7 @@ struct adv_monitor {
 	char *path;
 
 	enum monitor_state state;	/* MONITOR_STATE_* */
+	enum monitor_release_reason release_reason;
 
 	struct rssi_parameters rssi;	/* RSSI parameter for this monitor */
 	struct adv_monitor_merged_pattern *merged_pattern;
@@ -137,6 +150,7 @@ struct adv_monitor_merged_pattern {
 	struct queue *patterns;		/* List of bt_ad_pattern objects */
 	enum merged_pattern_state current_state; /* MERGED_PATTERN_STATE_* */
 	enum merged_pattern_state next_state;	 /* MERGED_PATTERN_STATE_* */
+	enum monitor_release_reason release_reason;
 };
 
 /* Some data like last_seen, timer/timeout values need to be maintained
@@ -541,6 +555,18 @@ static void monitor_free(struct adv_monitor *monitor)
 	free(monitor);
 }
 
+/* Includes monitor release reason into the dbus message */
+static void report_release_reason_setup(DBusMessageIter *iter, void *user_data)
+{
+	const struct adv_monitor *monitor = user_data;
+	int8_t release_reason = REASON_UNKNOWN;
+
+	if (monitor)
+		release_reason = monitor->release_reason;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &release_reason);
+}
+
 /* Calls Release() method of the remote Adv Monitor */
 static void monitor_release(struct adv_monitor *monitor)
 {
@@ -560,8 +586,9 @@ static void monitor_release(struct adv_monitor *monitor)
 	DBG("Calling Release() on Adv Monitor of owner %s at path %s",
 		monitor->app->owner, monitor->path);
 
-	g_dbus_proxy_method_call(monitor->proxy, "Release", NULL, NULL, NULL,
-					NULL);
+	g_dbus_proxy_method_call(monitor->proxy, "Release",
+					report_release_reason_setup, NULL,
+					monitor, NULL);
 }
 
 /* Removes monitor from the merged_pattern. This would result in removing it
@@ -635,13 +662,20 @@ static void monitor_destroy(void *data)
 static void app_destroy(void *data)
 {
 	struct adv_monitor_app *app = data;
+	const struct queue_entry *e;
 
 	if (!app)
 		return;
 
 	DBG("Destroy Adv Monitor app %s at path %s", app->owner, app->path);
 
-	queue_destroy(app->monitors, monitor_destroy);
+	for (e = queue_get_entries(app->monitors); e; e = e->next) {
+		struct adv_monitor *m = e->data;
+
+		m->release_reason = REASON_APP_DESTROYED;
+		monitor_destroy(m);
+	}
+	queue_destroy(app->monitors, NULL);
 
 	if (app->reg) {
 		app_reply_msg(app, btd_error_failed(app->reg,
@@ -793,6 +827,7 @@ static bool parse_monitor_type(struct adv_monitor *monitor, const char *path)
 	}
 
 failed:
+	monitor->release_reason = REASON_INVALID_TYPE;
 	btd_error(adapter_id,
 			"Invalid argument of property Type of the Adv Monitor "
 			"at path %s", path);
@@ -919,6 +954,7 @@ done:
 	return true;
 
 failed:
+	monitor->release_reason = REASON_INVALID_RSSI_PARAMS;
 	btd_error(adapter_id,
 			"Invalid argument of RSSI thresholds and timeouts "
 			"of the Adv Monitor at path %s",
@@ -1005,6 +1041,7 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
 	return true;
 
 failed:
+	monitor->release_reason = REASON_INVALID_PATTERNS;
 	btd_error(adapter_id, "Invalid argument of property Patterns of the "
 			"Adv Monitor at path %s", path);
 
@@ -1053,6 +1090,7 @@ static void merged_pattern_destroy_monitors(
 		struct adv_monitor *monitor = e->data;
 
 		monitor->merged_pattern = NULL;
+		monitor->release_reason = merged_pattern->release_reason;
 		monitor_destroy(monitor);
 	}
 }
@@ -1086,6 +1124,7 @@ static void remove_adv_monitor_cb(uint8_t status, uint16_t length,
 	return;
 
 fail:
+	merged_pattern->release_reason = REASON_FAILED_TO_REMOVE;
 	merged_pattern_destroy_monitors(merged_pattern);
 	merged_pattern_free(merged_pattern);
 }
@@ -1142,6 +1181,7 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 	return;
 
 fail:
+	merged_pattern->release_reason = REASON_FAILED_TO_ADD;
 	merged_pattern_destroy_monitors(merged_pattern);
 	merged_pattern_free(merged_pattern);
 }
@@ -1285,6 +1325,7 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 		merged_pattern_add(monitor->merged_pattern);
 	} else {
 		if (!merge_is_possible(existing_pattern, monitor)) {
+			monitor->release_reason = REASON_ALREADY_EXISTS;
 			monitor_destroy(monitor);
 			DBG("Adv Monitor at path %s released due to existing "
 				"monitor", path);
@@ -1551,6 +1592,7 @@ static void remove_merged_pattern(void *data, void *user_data)
 {
 	struct adv_monitor_merged_pattern *merged_pattern = data;
 	uint16_t *handle = user_data;
+	const struct queue_entry *e;
 
 	if (!handle)
 		return;
@@ -1562,8 +1604,14 @@ static void remove_merged_pattern(void *data, void *user_data)
 	DBG("Adv monitor with handle:0x%04x removed by kernel",
 		merged_pattern->monitor_handle);
 
+	for (e = queue_get_entries(merged_pattern->monitors); e; e = e->next) {
+		struct adv_monitor *m = e->data;
+
+		m->release_reason = REASON_REMOVED_BY_KERNEL;
+		monitor_destroy(m);
+	}
 	queue_foreach(merged_pattern->monitors, monitor_state_removed, NULL);
-	queue_destroy(merged_pattern->monitors, monitor_destroy);
+	queue_destroy(merged_pattern->monitors, NULL);
 	merged_pattern_free(merged_pattern);
 }
 
-- 
2.35.1.894.gb6a874cedc-goog

