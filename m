Return-Path: <SRS0=4lpm=EG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A214C00A89
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DE1221EB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="drnWc/4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgJaAzu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 20:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJaAzt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 20:55:49 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA18C0613D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:55:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so6549775pgb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdaUfJz7jmPFx2W5HccvMKbsFaBAEhWGV3O/WxZs7oI=;
        b=drnWc/4/MtEWrmmqokp7IdUs/SXhYoPoVNnhtRsnx7jNh4dbqtAtXUwNEWsve76+n9
         3PX3zAg3aRefdv/wWxVoMtq4kN1tkZGhshwy7CWLN3nE2lgqNRSuOs5womGD57isKu1/
         //OQcI0AA07BIJ7QcC+1hTy9kcqE8Y6t0AWCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdaUfJz7jmPFx2W5HccvMKbsFaBAEhWGV3O/WxZs7oI=;
        b=tiyrYclakxXoivEMIb4oG7rCu5bBiETxYDLZjLRc0YzO4GDRNw7QDfrkbTHV0uCGQF
         4DNYYtecqD+ZCrbXXCOaEwpqSxYdjX2Zhj+nOPjGjlWanHWgmJXUWW8YgJ9SGWT3/xtn
         3s1BBrxVxMC/hlfDhB9k6JLjWCCASGe+Hvth3pQeWsPu8NcFn+9rFJLz10jqHpZWwPu7
         j1sEuIhHNoyY7ykuLBM7qP5yTqTWxLByXbDricaRNMTlS5QHAasUrq9rx4Pe2b2osu1R
         ZU+hoRonX5bKXzQFaU56HfERTS87XCtU5jq0R0mKxdD0502Lsx7O9xTs4KYcCiO3Yn6y
         Lyug==
X-Gm-Message-State: AOAM533rR9Tj+C6hT5gxd9NYhCFoLo6BLyH3QtbN4Smwwn5KOejqyLMd
        6v0aAYg54l4Rx90GDyuqBkIn7Xsoxpzt6w==
X-Google-Smtp-Source: ABdhPJzXVHmhegh4q4aJbuuRXI8ZTgpGXjD7a/E5GNucvzN1GyEYw7mG0E/GlZD7EwK+yoz7nt/w1A==
X-Received: by 2002:a63:731e:: with SMTP id o30mr4257264pgc.179.1604105748955;
        Fri, 30 Oct 2020 17:55:48 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id p22sm4394292pju.48.2020.10.30.17.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 17:55:48 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [BlueZ PATCH v8 6/6] adv_monitor: Issue Remove Adv Monitor mgmt call
Date:   Fri, 30 Oct 2020 17:52:56 -0700
Message-Id: <20201030175219.BlueZ.v8.6.Ifda683c92ff520bf58ac37c02dc40b8d9598d1b0@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
References: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
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

(no changes since v7)

Changes in v7:
- Rename MONITOR_STATE_HONORED to MONITOR_STATE_ACTIVE

Changes in v4:
- Fix build error

Changes in v3:
- Fix const qualifier of a pointer

 src/adv_monitor.c | 132 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 124 insertions(+), 8 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index dbc3b2a92..c786015c8 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -79,6 +79,7 @@ enum monitor_state {
 	MONITOR_STATE_FAILED,	/* Failed to be init'ed */
 	MONITOR_STATE_INITED,	/* Init'ed but not yet sent to kernel */
 	MONITOR_STATE_ACTIVE,	/* Accepted by kernel */
+	MONITOR_STATE_REMOVING,	/* Removing from kernel */
 };
 
 struct adv_monitor {
@@ -87,6 +88,7 @@ struct adv_monitor {
 	char *path;
 
 	enum monitor_state state;	/* MONITOR_STATE_* */
+	uint16_t monitor_handle;	/* Kernel Monitor Handle */
 
 	int8_t high_rssi;		/* High RSSI threshold */
 	uint16_t high_rssi_timeout;	/* High RSSI threshold timeout */
@@ -567,6 +569,7 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 		return;
 	}
 
+	monitor->monitor_handle = le16_to_cpu(rp->monitor_handle);
 	monitor->state = MONITOR_STATE_ACTIVE;
 
 	DBG("Calling Activate() on Adv Monitor of owner %s at path %s",
@@ -575,8 +578,7 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 	g_dbus_proxy_method_call(monitor->proxy, "Activate", NULL, NULL, NULL,
 					NULL);
 
-	DBG("Adv Monitor with handle:0x%04x added",
-					le16_to_cpu(rp->monitor_handle));
+	DBG("Adv monitor with handle:0x%04x added", monitor->monitor_handle);
 }
 
 static void monitor_copy_patterns(void *data, void *user_data)
@@ -650,20 +652,77 @@ done:
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
+	if (monitor->state != MONITOR_STATE_ACTIVE)
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
@@ -872,6 +931,59 @@ static const GDBusPropertyTable adv_monitor_properties[] = {
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
+		if (monitor->state == MONITOR_STATE_ACTIVE)
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
@@ -891,6 +1003,10 @@ static struct btd_adv_monitor_manager *manager_new(
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

