Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9BCC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 20:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbiDMU5v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbiDMU5e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 16:57:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48FC71EE6
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ec44c52e7fso26878137b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a23uLrJWCTVuPqhHAD1RnUrrvwzZp5GFR9yUk8PVJ9A=;
        b=QSTqoaRzgdjMdMjTGM9wmgiFAKgneL281psoxWXXgW5MO606dTZp04PHTho617a3RD
         wm4KnMhvhEMRaxtXfTrWt5PfC9Zsz/csw0U3s8Q9snvviwqopHCphhHSg1WVmq5szF8q
         jKUgZmYaSoA9g+SduL+b/tYG6DdfGC2sK1+LB6MJV2eD+bWS6mjCAxHIL21RiCEfSRks
         mkqmfsp+yHqYf0PGOvUrJdkHS1DTS+jUYPlS93PxrJbsqnkDYHhFcx2vwHHyqgO/wRSd
         IXZS/k6O1xfRbgKeze1NWr1KHijnb4PM8UHxoBwgudpekQeGmrJRp/a82xmEc/apYikH
         z1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a23uLrJWCTVuPqhHAD1RnUrrvwzZp5GFR9yUk8PVJ9A=;
        b=C8KDhXbEMBv/TuZ8wWzxiv/YTiQMiGPbC9sud5dCkHyAkZK3siZsPScWoJAzKL7ABi
         CavFXwtzZGH5HmY2AZUo3WJVynJcpIqC2P0bkzyoKXwxPhhluRJ35sfqkhFcBxSaWoBx
         fnZN3eZVjaQFHup2u/mCmb9agHdVJevQT8SzJYU19KmjaIeB5JiUXMCGqzBwC1yv9jV1
         ON2IzMoJbI9Kf/jCi2ihT4iAZavG5GwXbJIhPK3d1Tn/IKzypgg7jVdXrVGxu/cX5ZuE
         cW+adEwN4bTroi1K3KTxQaIET2hIhUNyJvwq6DyAZivHWbeOYrKBVV1CGkMFeizb3lRy
         q+fg==
X-Gm-Message-State: AOAM532NoPjrrKekNi6CW0z8He8/w7usgHsu/AArGfBj7Qz3pJHhRuiX
        s/OvOSxW/pm9li8y5W4o7f5FX3Kl4j5xdw==
X-Google-Smtp-Source: ABdhPJxdcGbSgcrIHlResa37GO6IqNc7VdnGYiRgpBCqpg73M4+ZxE+FU57hC8J3L1RvBFhCiviQL7Umw0937g==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:2620:46aa:79ff:778d])
 (user=mmandlik job=sendgmr) by 2002:a05:6902:1103:b0:641:b707:1b10 with SMTP
 id o3-20020a056902110300b00641b7071b10mr689277ybu.569.1649883311074; Wed, 13
 Apr 2022 13:55:11 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:54:47 -0700
In-Reply-To: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220413135223.BlueZ.v2.7.I668ef2477efd8fcdd9c44975c5f7b9f32af966ca@changeid>
Mime-Version: 1.0
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [BlueZ PATCH v2 7/9] adv_monitor: Add the monitor Release reason
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

(no changes since v1)

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
index d88e1bbbb..9e67d984b 100644
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
2.36.0.rc0.470.gd361397f0d-goog

