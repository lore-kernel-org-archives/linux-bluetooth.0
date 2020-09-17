Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B1AC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B8E2075E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DElzKW60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIQHMI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgIQHMH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 03:12:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9561C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:12:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z18so653256pfg.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rRwiC+DDU1Y36GFikHuTKEZhj0osqiQgXYTeZEu+do=;
        b=DElzKW60fXrp36aMCuwLCroEmRdI/QLe4f+mF6g2FWosJuaX/BF5B3uUQfwTlEjI9F
         xBRJHk7GBuFgtcE7eMe1zfkrQedSlmE0joUUxexwNYL9/dpyfeXzrYosbu49x4mclhOL
         TfBj3bI5Zsbx/kAq7ocPJ2xaZx7UgJGDcDoM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rRwiC+DDU1Y36GFikHuTKEZhj0osqiQgXYTeZEu+do=;
        b=XV4Ji5ZTPslDn9jWmJFlnhhqe8t8eP2mYP3fhKMmNmRYc6MYhEi1//7hqRMVcfqQvh
         wCHgIN6MAhn/0IgVC1GWYjdeZr6M/EBjCs0N1wcnxZkpltd0qGRDn+wsu+Dewn7SW0T0
         YTOlvH6uvKprZx6I1NUdkqePvaFE/EMvDIwJ8MqR+NEvlc1Nn0gjrVdtGEowxVfK8rfE
         cMsM94TvzJACAkQiQOmpR3jjmUJ4WneWdvFVmrVWMpCnrsXLl1Kpt6Vw/lSlbQmS/Oua
         09vmmIqMV0Nd+JVRfXlNb71fpOfmYQIPjKA5LYlazk6nIGfkiHPOG7PeqRePVpoGeOxf
         Zrcw==
X-Gm-Message-State: AOAM5301bR8nX/5AzQr/zxtlRMtPMaUmgYVWkjD+G+kNjZDr/HESXiRa
        CMa/2wGI8xU/KmPJd0chCQu1kvAQfod3EQ==
X-Google-Smtp-Source: ABdhPJzx9zzM0V7Xsu7M5ozkvlJNQZYAMUIGCIFdhb5cmPAW9IbizanGc4ZYyNGjngjsc0zPF1BqyA==
X-Received: by 2002:a05:6a00:14cc:b029:142:2501:3988 with SMTP id w12-20020a056a0014ccb029014225013988mr9829677pfu.77.1600326725778;
        Thu, 17 Sep 2020 00:12:05 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id j26sm933478pgl.91.2020.09.17.00.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 00:12:05 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>
Subject: [BlueZ PATCH v4 8/8] adv_monitor: Issue Remove Adv Monitor mgmt call
Date:   Thu, 17 Sep 2020 00:10:45 -0700
Message-Id: <20200917001020.BlueZ.v4.8.Ifda683c92ff520bf58ac37c02dc40b8d9598d1b0@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917001020.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200917001020.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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
---

(no changes since v3)

Changes in v3:
- Fix const qualifier of a pointer

 src/adv_monitor.c | 128 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 120 insertions(+), 8 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index b4fe39eff..27da30b51 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -88,6 +88,7 @@ enum monitor_state {
 	MONITOR_STATE_FAILED,	/* Failed to be init'ed */
 	MONITOR_STATE_INITED,	/* Init'ed but not yet sent to kernel */
 	MONITOR_STATE_HONORED,	/* Accepted by kernel */
+	MONITOR_STATE_REMOVING, /* Removing from kernel */
 };
 
 struct btd_adv_monitor_pattern {
@@ -103,6 +104,7 @@ struct adv_monitor {
 	char *path;
 
 	enum monitor_state state;	/* MONITOR_STATE_* */
+	uint16_t monitor_handle;	/* Kernel Monitor Handle */
 
 	int8_t high_rssi;		/* High RSSI threshold */
 	uint16_t high_rssi_timeout;	/* High RSSI threshold timeout */
@@ -631,6 +633,7 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 		return;
 	}
 
+	monitor->monitor_handle = le16_to_cpu(rp->monitor_handle);
 	monitor->state = MONITOR_STATE_HONORED;
 
 	DBG("Calling Activate() on Adv Monitor of owner %s at path %s",
@@ -639,8 +642,7 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 	g_dbus_proxy_method_call(monitor->proxy, "Activate", NULL, NULL, NULL,
 					NULL);
 
-	DBG("Adv Monitor with handle:0x%04x added",
-					le16_to_cpu(rp->monitor_handle));
+	DBG("Adv monitor with handle:0x%04x added", monitor->monitor_handle);
 }
 
 static void monitor_copy_patterns(void *data, void *user_data)
@@ -714,20 +716,77 @@ done:
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
@@ -936,6 +995,55 @@ static const GDBusPropertyTable adv_monitor_properties[] = {
 	{ }
 };
 
+/* Matches a monitor based on its handle */
+static bool removed_monitor_match(const void *data, const void *user_data)
+{
+	const struct adv_monitor *monitor = data;
+	const struct mgmt_ev_adv_monitor_removed *ev = user_data;
+
+	return monitor->monitor_handle == ev->monitor_handle;
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
+	const uint16_t adapter_id = manager->adapter_id;
+	struct btd_adv_monitor_manager *manager = user_data;
+	const struct mgmt_ev_adv_monitor_removed *ev = param;
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter_id, "Wrong size of Adv Monitor Removed "
+				"event");
+		return;
+	}
+
+	/* Traverse the apps to find the monitor */
+	queue_foreach(manager->apps, app_remove_monitor, ev);
+
+	DBG("Adv Monitor removed event with handle 0x%04x processed",
+		ev->monitor_handle);
+}
+
 /* Allocates a manager object */
 static struct btd_adv_monitor_manager *manager_new(
 						struct btd_adapter *adapter,
@@ -955,6 +1063,10 @@ static struct btd_adv_monitor_manager *manager_new(
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

