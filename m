Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1575CC4363D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 00:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9B0206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 00:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XoYPdBfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgJGAPo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 20:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJGAPo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 20:15:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBF8C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 17:15:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x5so101664plo.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 17:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZCn9oH2uJ0FfOYiLVTz7nvZ+6XiseTudHsjrzTgHz4=;
        b=XoYPdBfcjuVOHPMYX6eHopm/kXh1YERsbeimaewLctuJsy3WQRh8OXr1WFrSmKUcKX
         GrZNqu4Rg1fYlGkpJY/DxWnOThS+1aO1VhKexbXrriwS9j/8EUsP3f/X/KV6hizn3utQ
         kwvD+dq0B87y+5nbMg+VvqkqL85fgZiDNX+3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZCn9oH2uJ0FfOYiLVTz7nvZ+6XiseTudHsjrzTgHz4=;
        b=f+bXTa/VlcD+FZrKwfg09EdidDO/8uzDAf4J/E9MjIFfN8mbEOpUObfwdS5TmvTk4h
         psqq5NHB0PrPSkPtpbAnN+AnHVAh8Z3WNWKs4eprC5I2Aan6IN+ZZyLAfFJMqQ43CxeI
         h5dJgYmL0gsWUZKoK/w3WfMf6sjiOWI5YxH4L0jl68nQK7o3K2XKjUHKxJ0EXUwk8VH3
         MCs9oDgZBOh/gjtQFME8Y1rMKwWUGZwH8ZmJhgPQwcZdIPMnXMxAOOyb/mbfCdLblYrl
         cxJEtjV9Otu/Uj0CGN3OWrdtjKasipiRrChftqKkVY7HiQRloeoxWTOymH33ozoiBAJB
         ONLg==
X-Gm-Message-State: AOAM532XXFUcYMpHWNMJqXJHXxY/Q/uC5/7Ec6Pg2jntKEw8liYlMpuZ
        jf+k8xTnWVapmWUJIdn8lE+K4saZ/MAnng==
X-Google-Smtp-Source: ABdhPJwlLJnRjkNKFiy4buk4eXMYuVx6eWnJXUUMfvxrRBvNcxJRpWx+zVd42ywrNWDp5I2vPnHH2g==
X-Received: by 2002:a17:90a:fd03:: with SMTP id cv3mr540277pjb.137.1602029743417;
        Tue, 06 Oct 2020 17:15:43 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id s13sm329722pgo.56.2020.10.06.17.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 17:15:42 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>
Subject: [BlueZ PATCH v6 6/6] adv_monitor: Issue Remove Adv Monitor mgmt call
Date:   Tue,  6 Oct 2020 17:14:16 -0700
Message-Id: <20201006171333.BlueZ.v6.6.Ifda683c92ff520bf58ac37c02dc40b8d9598d1b0@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Alain Michaud <alainm@chromium.org>

This calls Remove Adv Monitor command to kernel and handles the callback
during a monitor removal initiated by a D-Bus client. This also
registers callback for getting notified on Adv Monitor Removed event, so
that the Adv monitor manager can invalidate the monitor by calling
Release() on its proxy.

The following tests were performed.
- In bluetoothctl console, add a monitor and remove the monitor by its
index and verify the removal in both the output of btmgmt and syslog.
- In bluetoothctl console, add a monitor, remove the monitor via
btmgmt and verify the removal in syslog.

Reviewed-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

(no changes since v4)

Changes in v4:
- Fix build error

Changes in v3:
- Fix const qualifier of a pointer

 src/adv_monitor.c | 132 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 124 insertions(+), 8 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 33edbf00c..08adc7fa4 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -79,6 +79,7 @@ enum monitor_state {
 	MONITOR_STATE_FAILED,	/* Failed to be init'ed */
 	MONITOR_STATE_INITED,	/* Init'ed but not yet sent to kernel */
 	MONITOR_STATE_HONORED,	/* Accepted by kernel */
+	MONITOR_STATE_REMOVING, /* Removing from kernel */
 };
 
 struct btd_adv_monitor_pattern {
@@ -94,6 +95,7 @@ struct adv_monitor {
 	char *path;
 
 	enum monitor_state state;	/* MONITOR_STATE_* */
+	uint16_t monitor_handle;	/* Kernel Monitor Handle */
 
 	int8_t high_rssi;		/* High RSSI threshold */
 	uint16_t high_rssi_timeout;	/* High RSSI threshold timeout */
@@ -610,6 +612,7 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 		return;
 	}
 
+	monitor->monitor_handle = le16_to_cpu(rp->monitor_handle);
 	monitor->state = MONITOR_STATE_HONORED;
 
 	DBG("Calling Activate() on Adv Monitor of owner %s at path %s",
@@ -618,8 +621,7 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 	g_dbus_proxy_method_call(monitor->proxy, "Activate", NULL, NULL, NULL,
 					NULL);
 
-	DBG("Adv Monitor with handle:0x%04x added",
-					le16_to_cpu(rp->monitor_handle));
+	DBG("Adv monitor with handle:0x%04x added", monitor->monitor_handle);
 }
 
 static void monitor_copy_patterns(void *data, void *user_data)
@@ -693,20 +695,77 @@ done:
 	free(cp);
 }
 
+/* Handles the callback of Remove Adv Monitor command */
+static void remove_adv_monitor_cb(uint8_t status, uint16_t length,
+				const void *param, void *user_data)
+{
+	struct adv_monitor *monitor = user_data;
+	const struct mgmt_rp_remove_adv_monitor *rp = param;
+	uint16_t adapter_id = monitor->app->manager->adapter_id;
+
+	if (status != MGMT_STATUS_SUCCESS || !param) {
+		btd_error(adapter_id, "Failed to Remove Adv Monitor with "
+			"status 0x%02x", status);
+		goto done;
+	}
+
+	if (length < sizeof(*rp)) {
+		btd_error(adapter_id, "Wrong size of Remove Adv Monitor "
+				"response");
+		goto done;
+	}
+
+done:
+	queue_remove(monitor->app->monitors, monitor);
+
+	DBG("Adv Monitor removed with handle:0x%04x, path %s",
+		monitor->monitor_handle, monitor->path);
+
+	monitor_free(monitor);
+}
+
+
 /* Handles the removal of an Adv Monitor D-Bus proxy */
 static void monitor_proxy_removed_cb(GDBusProxy *proxy, void *user_data)
 {
 	struct adv_monitor *monitor;
+	struct mgmt_cp_remove_adv_monitor cp;
 	struct adv_monitor_app *app = user_data;
+	uint16_t adapter_id = app->manager->adapter_id;
 
-	monitor = queue_remove_if(app->monitors, monitor_match, proxy);
-	if (monitor) {
-		DBG("Adv Monitor removed for the object at path %s",
-			monitor->path);
+	monitor = queue_find(app->monitors, monitor_match, proxy);
 
-		/* The object was gone, so we don't need to call Release() */
-		monitor_free(monitor);
+	/* A monitor removed event from kernel can remove a monitor and notify
+	 * the app on Release() where this callback can be invoked, so we
+	 * simply skip here.
+	 */
+	if (!monitor)
+		return;
+
+	if (monitor->state != MONITOR_STATE_HONORED)
+		goto done;
+
+	monitor->state = MONITOR_STATE_REMOVING;
+
+	cp.monitor_handle = cpu_to_le16(monitor->monitor_handle);
+
+	if (!mgmt_send(app->manager->mgmt, MGMT_OP_REMOVE_ADV_MONITOR,
+			adapter_id, sizeof(cp), &cp, remove_adv_monitor_cb,
+			monitor, NULL)) {
+		btd_error(adapter_id, "Unable to send Remove Advt Monitor "
+				"command");
+		goto done;
 	}
+
+	return;
+
+done:
+	queue_remove(app->monitors, monitor);
+
+	DBG("Adv Monitor removed in state %02x with path %s", monitor->state,
+		monitor->path);
+
+	monitor_free(monitor);
 }
 
 /* Creates an app object, initiates it and sets D-Bus event handlers */
@@ -915,6 +974,59 @@ static const GDBusPropertyTable adv_monitor_properties[] = {
 	{ }
 };
 
+/* Matches a monitor based on its handle */
+static bool removed_monitor_match(const void *data, const void *user_data)
+{
+	const uint16_t *handle = user_data;
+	const struct adv_monitor *monitor = data;
+
+	if (!data || !handle)
+		return false;
+
+	return monitor->monitor_handle == *handle;
+}
+
+/* Remove the matched monitor and reports the removal to the app */
+static void app_remove_monitor(void *data, void *user_data)
+{
+	struct adv_monitor_app *app = data;
+	struct adv_monitor *monitor;
+
+	monitor = queue_find(app->monitors, removed_monitor_match, user_data);
+	if (monitor) {
+		if (monitor->state == MONITOR_STATE_HONORED)
+			monitor_release(monitor, NULL);
+
+		queue_remove(app->monitors, monitor);
+
+		DBG("Adv Monitor at path %s removed", monitor->path);
+
+		monitor_free(monitor);
+	}
+}
+
+/* Processes Adv Monitor removed event from kernel */
+static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adv_monitor_manager *manager = user_data;
+	const struct mgmt_ev_adv_monitor_removed *ev = param;
+	uint16_t handle = ev->monitor_handle;
+	const uint16_t adapter_id = manager->adapter_id;
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter_id, "Wrong size of Adv Monitor Removed "
+				"event");
+		return;
+	}
+
+	/* Traverse the apps to find the monitor */
+	queue_foreach(manager->apps, app_remove_monitor, &handle);
+
+	DBG("Adv Monitor removed event with handle 0x%04x processed",
+		ev->monitor_handle);
+}
+
 /* Allocates a manager object */
 static struct btd_adv_monitor_manager *manager_new(
 						struct btd_adapter *adapter,
@@ -934,6 +1046,10 @@ static struct btd_adv_monitor_manager *manager_new(
 	manager->adapter_id = btd_adapter_get_index(adapter);
 	manager->apps = queue_new();
 
+	mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_REMOVED,
+			manager->adapter_id, adv_monitor_removed_callback,
+			manager, NULL);
+
 	return manager;
 }
 
-- 
2.26.2

