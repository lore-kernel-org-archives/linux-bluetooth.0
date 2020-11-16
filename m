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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C555CC64EBC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 17:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF6722265
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 17:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/ctiKcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbgKPRix (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbgKPRiw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 12:38:52 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084E5C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 09:38:51 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id y8so11186738qvu.22
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 09:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=hKeiINDda9FuuYrJ4vCD3C8Hhuflf5hO3cNGoJL11MA=;
        b=M/ctiKcfSVdH+m5c+dhuztP3nYMI/uvla/m3I7gmxmhNuB7ams/mda5KXXk+b1lVke
         fotUL9pfFSuCreLuosSTS0aaMlzBv149EQogG4bEPNbjLQepBIftvEBeQHoi5TqMD78U
         drPRwDt0Esl4rZnZj0uxg2qxV4EYAxxxc7eDrljxEhHUeCnNMgpt6ahy9mrYu4nvajnL
         7i4kpW/PVAexE8y4krdiNPywo/vumemBy1bXLqxFUacGd762DNPtb2R0joRSDmjRFxCt
         mcDghzMzDCdxJPj/Lgrkc1lGy1Fhv8mAN1ZqTrVy8VlNZkihyhJOnymB+L1gijQy/cC7
         h9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=hKeiINDda9FuuYrJ4vCD3C8Hhuflf5hO3cNGoJL11MA=;
        b=lRmbIVBCHCaJUcr1zHx7RjPchE2uK8j38FF7CPUglKajiCE7Lou+uWJNyFDMQ7rOro
         kDFNRHJQA1QoxClBMfePQZfwY2PLkPKtBrd8isskfFVKnMEraxDgt5zfDHkGx+6m1eKH
         PdcYUACYT7Kejq/flaGbyuk04uOHzcZsh34Te8NBlhcdIu4C6+xwrNxbofR05OF36kTe
         LQGQ/odCpBIEVlKpIj0Q80JGe1uCvi6ScpPZYaOvJJNszEseSK1BPo68gY8Zb1uf3coz
         BR8vZg75z25io03dxfQBss7nT9NxDF1kGp5T7KfxjXRv27PqjYInHtjy7+6p4YXLOi8i
         5Gfg==
X-Gm-Message-State: AOAM533CWssbD2Su08NJAJ+fZC6FzqUb3nrcilvgc7rBf2AhH0k1DcDM
        2Cn4Hn/JyygOgFxgwfQWPOahlAXsbmHbeg==
X-Google-Smtp-Source: ABdhPJwEkWadVQMQsr7KDaVhc/8c+FrR3oE/dEk5bLb+q+IVd7Trgg31l0IF6TdcZMWXzLQoS8S0Dl9DUBZPnQ==
Sender: "mmandlik via sendgmr" <mmandlik@mmandlik.mtv.corp.google.com>
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:e50e])
 (user=mmandlik job=sendgmr) by 2002:ad4:46f2:: with SMTP id
 h18mr11609806qvw.4.1605548330198; Mon, 16 Nov 2020 09:38:50 -0800 (PST)
Date:   Mon, 16 Nov 2020 09:38:38 -0800
Message-Id: <20201116093746.bluez.v1.1.If5b2e2990c2c57e237708d8cbbf038e376ad0c7a@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [bluez PATCH v1] adv_monitor: Fix remove monitor from the kernel
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     mcchou@chromium.org, alainm@chromium.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>, howardchung@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A monitor is removed in the following scenarios:
- monitor dbus object removed by the app
- monitor removed by the kernel
- client app invokes UnregisterMonitor()
- client app is killed/disconnected
- AdvMonitorManager is destroyed

In the first case, we need to remove the corresponding monitor from the
kernel and free the bluez monitor object.

In the second case, we need to call the Release() method on the
corresponding dbus monitor object and free the bluez monitor object.

Kernel may remove all monitors and send MGMT_EV_ADV_MONITOR_REMOVED
event to bluez. In such case, we need to call Release() method on all
monitors from all registered apps, and free the bluez monitor objects.

In the third case, we need to call the Release() method on the monitor
objects created by the app, remove corresponding monitors from the
kernel and then free the bluez monitor object.

In the fourth case, since the app is not available, all the dbus monitor
objects created by that app are also unavailable. So, we just need to
remove corresponding monitors from the kernel and then free the bluez
monitor objects.

In the fifth case, we need to call Release() method on all monitors from
all registered apps, remove corresponding monitors from the kernel and
then free the bluez monitor objects.

When app exits or gets killed without removing the dbus monitor objects
and without invoking the UnregisterMonitor() method, a race condition
could happen between app_destroy and monitor_proxy_removed since dbus
objects hosted by the app are destroyed on app exit.

This patch fixes the first, second and fourth cases ensuring that
monitors from the kernel are removed correctly, Release() method is
invoked whenever necessary and bluez monitor objects are freed only
once.

Reviewed-by: alainm@chromium.org
Reviewed-by: mcchou@chromium.org
Reviewed-by: howardchung@google.com
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 src/adv_monitor.c | 212 ++++++++++++++++++++++++++++------------------
 1 file changed, 131 insertions(+), 81 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index c786015c8..606f1d3e4 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -79,7 +79,8 @@ enum monitor_state {
 	MONITOR_STATE_FAILED,	/* Failed to be init'ed */
 	MONITOR_STATE_INITED,	/* Init'ed but not yet sent to kernel */
 	MONITOR_STATE_ACTIVE,	/* Accepted by kernel */
-	MONITOR_STATE_REMOVING,	/* Removing from kernel */
+	MONITOR_STATE_REMOVED,	/* Removed from kernel */
+	MONITOR_STATE_RELEASED,	/* Dbus Object removed by app */
 };
 
 struct adv_monitor {
@@ -167,13 +168,8 @@ static void pattern_free(void *data)
 }
 
 /* Frees a monitor object */
-static void monitor_free(void *data)
+static void monitor_free(struct adv_monitor *monitor)
 {
-	struct adv_monitor *monitor = data;
-
-	if (!monitor)
-		return;
-
 	g_dbus_proxy_unref(monitor->proxy);
 	g_free(monitor->path);
 
@@ -186,12 +182,18 @@ static void monitor_free(void *data)
 }
 
 /* Calls Release() method of the remote Adv Monitor */
-static void monitor_release(void *data, void *user_data)
+static void monitor_release(struct adv_monitor *monitor)
 {
-	struct adv_monitor *monitor = data;
-
-	if (!monitor)
+	/* Release() method on a monitor can be called when -
+	 * 1. monitor initialization failed
+	 * 2. app calls UnregisterMonitor and monitors held by app are released
+	 * 3. monitor is removed by kernel
+	 */
+	if (monitor->state != MONITOR_STATE_FAILED &&
+	    monitor->state != MONITOR_STATE_ACTIVE &&
+	    monitor->state != MONITOR_STATE_REMOVED) {
 		return;
+	}
 
 	DBG("Calling Release() on Adv Monitor of owner %s at path %s",
 		monitor->app->owner, monitor->path);
@@ -200,6 +202,71 @@ static void monitor_release(void *data, void *user_data)
 					NULL);
 }
 
+/* Handles the callback of Remove Adv Monitor command */
+static void remove_adv_monitor_cb(uint8_t status, uint16_t length,
+				const void *param, void *user_data)
+{
+	struct btd_adv_monitor_manager *manager = user_data;
+	const struct mgmt_rp_remove_adv_monitor *rp = param;
+
+	if (status != MGMT_STATUS_SUCCESS || !param) {
+		error("Failed to Remove Adv Monitor with status 0x%02x",
+				status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size of Remove Adv Monitor response");
+		return;
+	}
+
+	DBG("Adv monitor with handle:0x%04x removed from kernel",
+		le16_to_cpu(rp->monitor_handle));
+}
+
+/* Sends Remove Adv Monitor command to the kernel */
+static void monitor_remove(struct adv_monitor *monitor)
+{
+	struct adv_monitor_app *app = monitor->app;
+	uint16_t adapter_id = app->manager->adapter_id;
+	struct mgmt_cp_remove_adv_monitor cp;
+
+	/* Monitor from kernel can be removed when -
+	 * 1. already activated monitor object is deleted by app
+	 * 2. app is destroyed and monitors held by app are marked as released
+	 */
+	if (monitor->state != MONITOR_STATE_ACTIVE &&
+	    monitor->state != MONITOR_STATE_RELEASED) {
+		return;
+	}
+
+	monitor->state = MONITOR_STATE_REMOVED;
+
+	cp.monitor_handle = cpu_to_le16(monitor->monitor_handle);
+
+	if (!mgmt_send(app->manager->mgmt, MGMT_OP_REMOVE_ADV_MONITOR,
+			adapter_id, sizeof(cp), &cp, remove_adv_monitor_cb,
+			app->manager, NULL)) {
+		btd_error(adapter_id,
+				"Unable to send Remove Advt Monitor command");
+	}
+}
+
+/* Destroys a monitor object */
+static void monitor_destroy(void *data)
+{
+	struct adv_monitor *monitor = data;
+
+	if (!monitor)
+		return;
+
+	queue_remove(monitor->app->monitors, monitor);
+
+	monitor_release(monitor);
+	monitor_remove(monitor);
+	monitor_free(monitor);
+}
+
 /* Destroys an app object along with related D-Bus handlers */
 static void app_destroy(void *data)
 {
@@ -210,8 +277,7 @@ static void app_destroy(void *data)
 
 	DBG("Destroy Adv Monitor app %s at path %s", app->owner, app->path);
 
-	queue_foreach(app->monitors, monitor_release, NULL);
-	queue_destroy(app->monitors, monitor_free);
+	queue_destroy(app->monitors, monitor_destroy);
 
 	if (app->reg) {
 		app_reply_msg(app, btd_error_failed(app->reg,
@@ -232,15 +298,34 @@ static void app_destroy(void *data)
 	free(app);
 }
 
+/* Updates monitor state to 'released' */
+static void monitor_state_released(void *data, void *user_data)
+{
+	struct adv_monitor *monitor = data;
+
+	if (!monitor && monitor->state != MONITOR_STATE_ACTIVE)
+		return;
+
+	monitor->state = MONITOR_STATE_RELEASED;
+}
+
 /* Handles a D-Bus disconnection event of an app */
 static void app_disconnect_cb(DBusConnection *conn, void *user_data)
 {
 	struct adv_monitor_app *app = user_data;
 
+	if (!app) {
+		error("Unexpected NULL app object upon app disconnect");
+		return;
+	}
+
 	btd_info(app->manager->adapter_id, "Adv Monitor app %s disconnected "
 			"from D-Bus", app->owner);
-	if (app && queue_remove(app->manager->apps, app))
+
+	if (queue_remove(app->manager->apps, app)) {
+		queue_foreach(app->monitors, monitor_state_released, NULL);
 		app_destroy(app);
+	}
 }
 
 /* Handles the ready signal of Adv Monitor app */
@@ -558,14 +643,16 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 	if (status != MGMT_STATUS_SUCCESS || !param) {
 		btd_error(adapter_id, "Failed to Add Adv Patterns Monitor "
 				"with status 0x%02x", status);
-		monitor_release(monitor, NULL);
+		monitor->state = MONITOR_STATE_FAILED;
+		monitor_destroy(monitor);
 		return;
 	}
 
 	if (length < sizeof(*rp)) {
 		btd_error(adapter_id, "Wrong size of Add Adv Patterns Monitor "
 				"response");
-		monitor_release(monitor, NULL);
+		monitor->state = MONITOR_STATE_FAILED;
+		monitor_destroy(monitor);
 		return;
 	}
 
@@ -623,8 +710,7 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 	}
 
 	if (!monitor_process(monitor, app)) {
-		monitor_release(monitor, NULL);
-		monitor_free(monitor);
+		monitor_destroy(monitor);
 		DBG("Adv Monitor at path %s released due to invalid content",
 			path);
 		return;
@@ -652,77 +738,22 @@ done:
 	free(cp);
 }
 
-/* Handles the callback of Remove Adv Monitor command */
-static void remove_adv_monitor_cb(uint8_t status, uint16_t length,
-				const void *param, void *user_data)
-{
-	struct adv_monitor *monitor = user_data;
-	const struct mgmt_rp_remove_adv_monitor *rp = param;
-	uint16_t adapter_id = monitor->app->manager->adapter_id;
-
-	if (status != MGMT_STATUS_SUCCESS || !param) {
-		btd_error(adapter_id, "Failed to Remove Adv Monitor with "
-			"status 0x%02x", status);
-		goto done;
-	}
-
-	if (length < sizeof(*rp)) {
-		btd_error(adapter_id, "Wrong size of Remove Adv Monitor "
-				"response");
-		goto done;
-	}
-
-done:
-	queue_remove(monitor->app->monitors, monitor);
-
-	DBG("Adv Monitor removed with handle:0x%04x, path %s",
-		monitor->monitor_handle, monitor->path);
-
-	monitor_free(monitor);
-}
-
-
 /* Handles the removal of an Adv Monitor D-Bus proxy */
 static void monitor_proxy_removed_cb(GDBusProxy *proxy, void *user_data)
 {
 	struct adv_monitor *monitor;
-	struct mgmt_cp_remove_adv_monitor cp;
 	struct adv_monitor_app *app = user_data;
-	uint16_t adapter_id = app->manager->adapter_id;
 
 	monitor = queue_find(app->monitors, monitor_match, proxy);
 
-	/* A monitor removed event from kernel can remove a monitor and notify
-	 * the app on Release() where this callback can be invoked, so we
-	 * simply skip here.
-	 */
 	if (!monitor)
 		return;
 
-	if (monitor->state != MONITOR_STATE_ACTIVE)
-		goto done;
-
-	monitor->state = MONITOR_STATE_REMOVING;
-
-	cp.monitor_handle = cpu_to_le16(monitor->monitor_handle);
-
-	if (!mgmt_send(app->manager->mgmt, MGMT_OP_REMOVE_ADV_MONITOR,
-			adapter_id, sizeof(cp), &cp, remove_adv_monitor_cb,
-			monitor, NULL)) {
-		btd_error(adapter_id, "Unable to send Remove Advt Monitor "
-				"command");
-		goto done;
-	}
-
-	return;
-
-done:
-	queue_remove(app->monitors, monitor);
-
 	DBG("Adv Monitor removed in state %02x with path %s", monitor->state,
 		monitor->path);
 
-	monitor_free(monitor);
+	monitor_state_released(monitor, NULL);
+	monitor_destroy(monitor);
 }
 
 /* Creates an app object, initiates it and sets D-Bus event handlers */
@@ -943,22 +974,41 @@ static bool removed_monitor_match(const void *data, const void *user_data)
 	return monitor->monitor_handle == *handle;
 }
 
+/* Updates monitor state to 'removed' */
+static void monitor_state_removed(void *data, void *user_data)
+{
+	struct adv_monitor *monitor = data;
+
+	if (!monitor && monitor->state != MONITOR_STATE_ACTIVE)
+		return;
+
+	monitor->state = MONITOR_STATE_REMOVED;
+
+	DBG("Adv monitor with handle:0x%04x removed by kernel",
+		monitor->monitor_handle);
+}
+
 /* Remove the matched monitor and reports the removal to the app */
 static void app_remove_monitor(void *data, void *user_data)
 {
 	struct adv_monitor_app *app = data;
 	struct adv_monitor *monitor;
+	uint16_t *handle = user_data;
 
-	monitor = queue_find(app->monitors, removed_monitor_match, user_data);
-	if (monitor) {
-		if (monitor->state == MONITOR_STATE_ACTIVE)
-			monitor_release(monitor, NULL);
+	if (handle && *handle == 0) {
+		/* handle = 0 indicates kernel has removed all monitors */
+		queue_foreach(app->monitors, monitor_state_removed, NULL);
+		queue_destroy(app->monitors, monitor_destroy);
 
-		queue_remove(app->monitors, monitor);
+		return;
+	}
 
+	monitor = queue_find(app->monitors, removed_monitor_match, handle);
+	if (monitor) {
 		DBG("Adv Monitor at path %s removed", monitor->path);
 
-		monitor_free(monitor);
+		monitor_state_removed(monitor, NULL);
+		monitor_destroy(monitor);
 	}
 }
 
-- 
2.29.2.299.gdc1121823c-goog

