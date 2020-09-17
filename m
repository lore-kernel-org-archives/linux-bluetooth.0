Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444FDC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CD821924
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NaH8GR0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgIQGT7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 02:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQGT6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 02:19:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523C4C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:19:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id y1so744195pgk.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/MBaGN18T5ClGzqvtrP9gRU0RypRFw+AxswImwVO7R4=;
        b=NaH8GR0wDG3D3HrHL+vUvMsnyBy+z1TdX7i5S0IeDebsOfhFfuOqo/BEmgQZG11jGm
         lcqoYEg0OHHx/VpH9Y5NMspkmh/dnemH24v64KPQVz6Fu7yets8jdX4kFH6YFYekG5T5
         7oKIu8+FOpto/Brp5VkbPpElIPxcSPmqNvNgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/MBaGN18T5ClGzqvtrP9gRU0RypRFw+AxswImwVO7R4=;
        b=CqXISSk6nus6FxX5aS2++kfh2uctfRNCXdmUYeng3/woh05jL0OVseuAVMD03ZAUqu
         klSH0OUnGxZfv8W78E9XjVSUUJl/aImVCf0rXqMUPPxASKtx9gW1Gf24g8xpFWOlYmyS
         Vhctim+4VNoKbvd2o0lC3cQaP+2EipHmqwUMwX3lVvtAo7hGmtYivj3o41tySjMPLI5w
         B4+OC0qm3jVzNztMEnTCKI2LIS+LNNJHtq2+dFjuKn40ToqHMbQeNJCEsoq82ZO0xmk0
         9qd+iJFYyzZbZGYPEYO2D6yqDUAhDRhQj0GifFmwMmbtdtxnUfIeweUkbKQH1OyNjyUJ
         Junw==
X-Gm-Message-State: AOAM532I6GY6YXXWsXr7NnMiWyD1QjR2eXKeatBzqqrqbo1GI2GOt7vZ
        NfnQJJ5QtkZikCm/omRveJBQ+t1z40hmsg==
X-Google-Smtp-Source: ABdhPJzh4sqfwnEU9/q5izXWTdDybFXILcU/4n9EDD3ZTYe30RB1jaNHxLeRIpaIYGZYscxBEMGEkQ==
X-Received: by 2002:a63:cc16:: with SMTP id x22mr20640481pgf.414.1600323595235;
        Wed, 16 Sep 2020 23:19:55 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id g23sm19264943pfh.133.2020.09.16.23.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 23:19:54 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2 1/8] adv_monitor: Implement RSSI Filter logic for background scanning
Date:   Wed, 16 Sep 2020 23:19:40 -0700
Message-Id: <20200916231935.BlueZ.v2.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Manish Mandlik <mmandlik@google.com>

This patch implements the RSSI Filter logic for background scanning.

This was unit-tested by running tests in unit/test-adv-monitor.c

     unit/test-adv-monitor.c file. Verified all tests PASS by running:
     USE="-bluez-next bluez-upstream" FEATURES=test emerge-hatch bluez

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Howard Chung <howardchung@google.com>
---

(no changes since v1)

 doc/advertisement-monitor-api.txt |   5 +
 src/adapter.c                     |   1 +
 src/adv_monitor.c                 | 286 +++++++++++++++++++++++++++++-
 src/adv_monitor.h                 |   4 +
 4 files changed, 292 insertions(+), 4 deletions(-)

diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
index e09b6fd25..92c8ffc38 100644
--- a/doc/advertisement-monitor-api.txt
+++ b/doc/advertisement-monitor-api.txt
@@ -70,6 +70,11 @@ Properties	string Type [read-only]
 			dBm indicates unset. The valid range of a timer is 1 to
 			300 seconds while 0 indicates unset.
 
+			If the peer device advertising interval is greater than the
+			HighRSSIThresholdTimer, the device will never be found. Similarly,
+			if it is greater than LowRSSIThresholdTimer, the device will be
+			considered as lost. Consider configuring these values accordingly.
+
 		array{(uint8, uint8, array{byte})} Patterns [read-only, optional]
 
 			If Type is set to 0x01, this must exist and has at least
diff --git a/src/adapter.c b/src/adapter.c
index b2bd8b3f1..415d6e06b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1227,6 +1227,7 @@ void btd_adapter_remove_device(struct btd_adapter *adapter,
 	adapter->connect_list = g_slist_remove(adapter->connect_list, dev);
 
 	adapter->devices = g_slist_remove(adapter->devices, dev);
+	btd_adv_monitor_device_remove(adapter->adv_monitor_manager, dev);
 
 	adapter->discovery_found = g_slist_remove(adapter->discovery_found,
 									dev);
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 737da1c90..7baa5317f 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -35,6 +35,7 @@
 
 #include "adapter.h"
 #include "dbus-common.h"
+#include "device.h"
 #include "log.h"
 #include "src/error.h"
 #include "src/shared/ad.h"
@@ -44,6 +45,8 @@
 
 #include "adv_monitor.h"
 
+static void monitor_device_free(void *data);
+
 #define ADV_MONITOR_INTERFACE		"org.bluez.AdvertisementMonitor1"
 #define ADV_MONITOR_MGR_INTERFACE	"org.bluez.AdvertisementMonitorManager1"
 
@@ -104,15 +107,36 @@ struct adv_monitor {
 
 	enum monitor_state state;	/* MONITOR_STATE_* */
 
-	int8_t high_rssi;		/* high RSSI threshold */
-	uint16_t high_rssi_timeout;	/* high RSSI threshold timeout */
-	int8_t low_rssi;		/* low RSSI threshold */
-	uint16_t low_rssi_timeout;	/* low RSSI threshold timeout */
+	int8_t high_rssi;		/* High RSSI threshold */
+	uint16_t high_rssi_timeout;	/* High RSSI threshold timeout */
+	int8_t low_rssi;		/* Low RSSI threshold */
+	uint16_t low_rssi_timeout;	/* Low RSSI threshold timeout */
+	struct queue *devices;		/* List of adv_monitor_device objects */
 
 	enum monitor_type type;		/* MONITOR_TYPE_* */
 	struct queue *patterns;
 };
 
+/* Some data like last_seen, timer/timeout values need to be maintained
+ * per device. struct adv_monitor_device maintains such data.
+ */
+struct adv_monitor_device {
+	struct adv_monitor *monitor;
+	struct btd_device *device;
+
+	time_t high_rssi_first_seen;	/* Start time when RSSI climbs above
+					 * the high RSSI threshold
+					 */
+	time_t low_rssi_first_seen;	/* Start time when RSSI drops below
+					 * the low RSSI threshold
+					 */
+	time_t last_seen;		/* Time when last Adv was received */
+	bool device_found;		/* State of the device - lost/found */
+	guint device_lost_timer;	/* Timer to track if the device goes
+					 * offline/out-of-range
+					 */
+};
+
 struct app_match_data {
 	const char *owner;
 	const char *path;
@@ -159,6 +183,9 @@ static void monitor_free(void *data)
 	g_dbus_proxy_unref(monitor->proxy);
 	g_free(monitor->path);
 
+	queue_destroy(monitor->devices, monitor_device_free);
+	monitor->devices = NULL;
+
 	queue_destroy(monitor->patterns, pattern_free);
 
 	free(monitor);
@@ -257,6 +284,7 @@ static struct adv_monitor *monitor_new(struct adv_monitor_app *app,
 	monitor->high_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
 	monitor->low_rssi = ADV_MONITOR_UNSET_RSSI;
 	monitor->low_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
+	monitor->devices = queue_new();
 
 	monitor->type = MONITOR_TYPE_NONE;
 	monitor->patterns = NULL;
@@ -932,3 +960,253 @@ void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager)
 
 	manager_destroy(manager);
 }
+
+/* Matches a device based on btd_device object */
+static bool monitor_device_match(const void *a, const void *b)
+{
+	const struct adv_monitor_device *dev = a;
+	const struct btd_device *device = b;
+
+	if (!dev)
+		return false;
+
+	if (dev->device != device)
+		return false;
+
+	return true;
+}
+
+/* Frees a monitor device object */
+static void monitor_device_free(void *data)
+{
+	struct adv_monitor_device *dev = data;
+
+	if (!dev)
+		return;
+
+	if (dev->device_lost_timer) {
+		g_source_remove(dev->device_lost_timer);
+		dev->device_lost_timer = 0;
+	}
+
+	dev->monitor = NULL;
+	dev->device = NULL;
+
+	g_free(dev);
+}
+
+/* Removes a device from monitor->devices list */
+static void remove_device_from_monitor(void *data, void *user_data)
+{
+	struct adv_monitor *monitor = data;
+	struct btd_device *device = user_data;
+	struct adv_monitor_device *dev = NULL;
+
+	if (!monitor)
+		return;
+
+	dev = queue_remove_if(monitor->devices, monitor_device_match, device);
+	if (dev) {
+		DBG("Device removed from the Adv Monitor at path %s",
+		    monitor->path);
+		monitor_device_free(dev);
+	}
+}
+
+/* Removes a device from every monitor in an app */
+static void remove_device_from_app(void *data, void *user_data)
+{
+	struct adv_monitor_app *app = data;
+	struct btd_device *device = user_data;
+
+	if (!app)
+		return;
+
+	queue_foreach(app->monitors, remove_device_from_monitor, device);
+}
+
+/* Removes a device from every monitor in all apps */
+void btd_adv_monitor_device_remove(struct btd_adv_monitor_manager *manager,
+				   struct btd_device *device)
+{
+	if (!manager || !device)
+		return;
+
+	queue_foreach(manager->apps, remove_device_from_app, device);
+}
+
+/* Creates a device object to track the per-device information */
+static struct adv_monitor_device *monitor_device_create(
+			struct adv_monitor *monitor,
+			struct btd_device *device)
+{
+	struct adv_monitor_device *dev = NULL;
+
+	dev = g_try_malloc0(sizeof(struct adv_monitor_device));
+	if (!dev)
+		return NULL;
+
+	dev->monitor = monitor;
+	dev->device = device;
+
+	queue_push_tail(monitor->devices, dev);
+
+	return dev;
+}
+
+/* Includes found/lost device's object path into the dbus message */
+static void report_device_state_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *path = device_get_path(user_data);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+/* Handles a situation where the device goes offline/out-of-range */
+static gboolean handle_device_lost_timeout(gpointer user_data)
+{
+	struct adv_monitor_device *dev = user_data;
+	struct adv_monitor *monitor = dev->monitor;
+	time_t curr_time = time(NULL);
+
+	DBG("Device Lost timeout triggered for device %p "
+	    "for the Adv Monitor at path %s", dev->device, monitor->path);
+
+	dev->device_lost_timer = 0;
+
+	if (dev->device_found && dev->last_seen) {
+		/* We were tracking for the Low RSSI filter. Check if there is
+		 * any Adv received after the timeout function is invoked.
+		 * If not, report the Device Lost event.
+		 */
+		if (difftime(curr_time, dev->last_seen) >=
+		    monitor->low_rssi_timeout) {
+			dev->device_found = false;
+
+			DBG("Calling DeviceLost() on Adv Monitor of owner %s "
+			    "at path %s", monitor->app->owner, monitor->path);
+
+			g_dbus_proxy_method_call(monitor->proxy, "DeviceLost",
+						 report_device_state_setup,
+						 NULL, dev->device, NULL);
+		}
+	}
+
+	return FALSE;
+}
+
+/* Filters an Adv based on its RSSI value */
+static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
+				    struct btd_device *device, int8_t rssi)
+{
+	struct adv_monitor_device *dev = NULL;
+	time_t curr_time = time(NULL);
+	uint16_t adapter_id = monitor->app->manager->adapter_id;
+
+	/* If the RSSI thresholds and timeouts are not specified, report the
+	 * DeviceFound() event without tracking for the RSSI as the Adv has
+	 * already matched the pattern filter.
+	 */
+	if (monitor->high_rssi == ADV_MONITOR_UNSET_RSSI &&
+		monitor->low_rssi == ADV_MONITOR_UNSET_RSSI &&
+		monitor->high_rssi_timeout == ADV_MONITOR_UNSET_TIMER &&
+		monitor->low_rssi_timeout == ADV_MONITOR_UNSET_TIMER) {
+		DBG("Calling DeviceFound() on Adv Monitor of owner %s "
+		    "at path %s", monitor->app->owner, monitor->path);
+
+		g_dbus_proxy_method_call(monitor->proxy, "DeviceFound",
+					 report_device_state_setup, NULL,
+					 device, NULL);
+
+		return;
+	}
+
+	dev = queue_find(monitor->devices, monitor_device_match, device);
+	if (!dev)
+		dev = monitor_device_create(monitor, device);
+	if (!dev) {
+		btd_error(adapter_id, "Failed to create Adv Monitor "
+				      "device object.");
+		return;
+	}
+
+	if (dev->device_lost_timer) {
+		g_source_remove(dev->device_lost_timer);
+		dev->device_lost_timer = 0;
+	}
+
+	/* Reset the timings of found/lost if a device has been offline for
+	 * longer than the high/low timeouts.
+	 */
+	if (dev->last_seen) {
+		if (difftime(curr_time, dev->last_seen) >
+		    monitor->high_rssi_timeout) {
+			dev->high_rssi_first_seen = 0;
+		}
+
+		if (difftime(curr_time, dev->last_seen) >
+		    monitor->low_rssi_timeout) {
+			dev->low_rssi_first_seen = 0;
+		}
+	}
+	dev->last_seen = curr_time;
+
+	/* Check for the found devices (if the device is not already found) */
+	if (!dev->device_found && rssi > monitor->high_rssi) {
+		if (dev->high_rssi_first_seen) {
+			if (difftime(curr_time, dev->high_rssi_first_seen) >=
+			    monitor->high_rssi_timeout) {
+				dev->device_found = true;
+
+				DBG("Calling DeviceFound() on Adv Monitor "
+				    "of owner %s at path %s",
+				    monitor->app->owner, monitor->path);
+
+				g_dbus_proxy_method_call(
+					monitor->proxy, "DeviceFound",
+					report_device_state_setup, NULL,
+					dev->device, NULL);
+			}
+		} else {
+			dev->high_rssi_first_seen = curr_time;
+		}
+	} else {
+		dev->high_rssi_first_seen = 0;
+	}
+
+	/* Check for the lost devices (only if the device is already found, as
+	 * it doesn't make any sense to report the Device Lost event if the
+	 * device is not found yet)
+	 */
+	if (dev->device_found && rssi < monitor->low_rssi) {
+		if (dev->low_rssi_first_seen) {
+			if (difftime(curr_time, dev->low_rssi_first_seen) >=
+			    monitor->low_rssi_timeout) {
+				dev->device_found = false;
+
+				DBG("Calling DeviceLost() on Adv Monitor "
+				    "of owner %s at path %s",
+				    monitor->app->owner, monitor->path);
+
+				g_dbus_proxy_method_call(
+					monitor->proxy, "DeviceLost",
+					report_device_state_setup, NULL,
+					dev->device, NULL);
+			}
+		} else {
+			dev->low_rssi_first_seen = curr_time;
+		}
+	} else {
+		dev->low_rssi_first_seen = 0;
+	}
+
+	/* Setup a timer to track if the device goes offline/out-of-range, only
+	 * if we are tracking for the Low RSSI Threshold. If we are tracking
+	 * the High RSSI Threshold, nothing needs to be done.
+	 */
+	if (dev->device_found) {
+		dev->device_lost_timer =
+			g_timeout_add_seconds(monitor->low_rssi_timeout,
+					      handle_device_lost_timeout, dev);
+	}
+}
diff --git a/src/adv_monitor.h b/src/adv_monitor.h
index 69ea348f8..14508e7d1 100644
--- a/src/adv_monitor.h
+++ b/src/adv_monitor.h
@@ -21,6 +21,7 @@
 #define __ADV_MONITOR_H
 
 struct mgmt;
+struct btd_device;
 struct btd_adapter;
 struct btd_adv_monitor_manager;
 
@@ -29,4 +30,7 @@ struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
 						struct mgmt *mgmt);
 void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager);
 
+void btd_adv_monitor_device_remove(struct btd_adv_monitor_manager *manager,
+				   struct btd_device *device);
+
 #endif /* __ADV_MONITOR_H */
-- 
2.26.2

