Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0429AC4363A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 00:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AB22076B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 00:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GxZZx8MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgJFAuo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Oct 2020 20:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAuo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Oct 2020 20:50:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33640C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2020 17:50:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so7030581pgi.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2020 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a3y4/iXJ82sUfPikzjAApT2ODq7HsU8L7vrV1LZ819k=;
        b=GxZZx8MFu7oh7Qscxs+1tzP/dQmVEgSiu3y9L3gAnLHV9Njwrrlf46ZLYfkoq+yCS9
         dzm8xRC48vSGv7ADHwh7NdE6yIF9BZWMWZ4g37omfaunJiu/R91Cday+pYthwyW5eqDN
         QpiS0I8rhGG3WGRiY0mMzMqJkB8rDT641xbt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3y4/iXJ82sUfPikzjAApT2ODq7HsU8L7vrV1LZ819k=;
        b=kYmnrccOv7N6uBITsbXUneKm9QBkOZy0fX79CYOVgFYr5uIxI6bS8L0untfBPN0InT
         sOqyEpiff/G3UGCpK9IxK4ATivD88vDDbDSTj1HhjAmiWeyCyPQxPZhIsGRSrkwXsV7e
         /6C32PiB1NrNBVO4iFEVSiHvF+FGQUJ8jBOx6je6faZWkt6nA/2nj3IXz+MbLh+0Ab7b
         lX6O4wIg06KNqlVYj6lW6vVmLRGQQTyPRAP7YIpj9h29jzl8ZQ35ySc2VfiJBDyOB0d4
         +JD4/piJ0d8DIhLeFGGK9ur/sDEIyq44EeDGaMNaNfIjWabHNJG9DeizJrakSCxHY+0+
         +w7A==
X-Gm-Message-State: AOAM532twCDRdSj2RixLNAeJjUmhITxwiowyHRsVmBuUYRKUBWDEj69v
        bCZQeACq9kyR9rZqa2oaI8gPDj9N4VzMXw==
X-Google-Smtp-Source: ABdhPJwhBcRmim7WmntUfYzyelpmLPUdhhavs9hVYEOp91yoKEceEg/xT7OhGHkoHUdJuJf3UaSCLg==
X-Received: by 2002:a63:4d57:: with SMTP id n23mr1893279pgl.43.1601945442880;
        Mon, 05 Oct 2020 17:50:42 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id h2sm776947pjv.4.2020.10.05.17.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 17:50:42 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org
Subject: [BlueZ PATCH v5 6/6] adv_monitor: Issue Remove Adv Monitor mgmt call
Date:   Mon,  5 Oct 2020 17:48:10 -0700
Message-Id: <20201005174640.BlueZ.v5.6.Ifda683c92ff520bf58ac37c02dc40b8d9598d1b0@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005174640.BlueZ.v5.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201005174640.BlueZ.v5.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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
index f56c2cab2..2bba6bbb3 100644
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

