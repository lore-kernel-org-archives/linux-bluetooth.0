Return-Path: <SRS0=4lpm=EG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A9AC00A89
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FC2208B6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DTrti4d9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgJaAxq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 20:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaAxq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 20:53:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE174C0613D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:53:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p17so3788710pli.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJFigMo5EVxTjfOJtnz2Tv+fqutb00rMLRe9RV1oomg=;
        b=DTrti4d9RHChTOVaHbv16GGDcEZQQ/i4bAHTBw0nKA3ynMkAroYmTfQagEWa261YGb
         Ji9PT/ec4Y8qpimR8/krDXP5mUCQpgcLFzLDCCcK1I6GFnoG80HsBfb2/Gugrn0xA7Jy
         zre5pwX/Y3VaQS7jNnXefW/gY+hciDNFyhigc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJFigMo5EVxTjfOJtnz2Tv+fqutb00rMLRe9RV1oomg=;
        b=PTobtEYtdywpTCU4Syzgn7ndk+VuIjoKGOnjs2RVt/tBhUFA+v2Pyhjnk18Utgz1wW
         1lY/9nc4zwAoUAnHMICp0VyFCiMFtPm6zsi1hRIIXwsks8enWk8ndjXrrdXY2VfoMmAG
         2r6ONBFaEUJ/yPHz/60rCvg3DoyZ8G8QvWNZROhG8wVbj6cq+IYQy+g2JcG8flJ3gKCr
         2ULq6++DAYuCeJBwlcXBJ9wwtVRcTV6CizOCvfk3AW6tmiwFHYXhHoSBlmNhrPDJaQF1
         CRHWAQ/v7Ulm1Fe2HOgJ1Ya4M1WLYufJJJNq3OkB3Hlg7QFYQUL793AYfGxgescAK1ko
         ZYlw==
X-Gm-Message-State: AOAM530eXSSNF/LoXfucMw51Z3qJL3f6odLwjZkkmYaelJKQxJJDMoZS
        sSwLej2TYU96+wM8ZhsFEck8kzKloWR36Q==
X-Google-Smtp-Source: ABdhPJykeW9i60DcMDeVN0DTTfCH09EQj+oTlhGhAaxIqMzhbetsy5CbgNuSyZ86rhJLucizocgkTA==
X-Received: by 2002:a17:90a:5892:: with SMTP id j18mr4582720pji.101.1604105624882;
        Fri, 30 Oct 2020 17:53:44 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id p22sm4394292pju.48.2020.10.30.17.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 17:53:44 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v8 2/6] adv_monitor: Implement RSSI filtering and content matching
Date:   Fri, 30 Oct 2020 17:52:48 -0700
Message-Id: <20201030175219.BlueZ.v8.2.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
References: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Manish Mandlik <mmandlik@google.com>

This implements the following logic for background scanning.
- Implement RSSI tracking based on high/low RSSI thresholds and timers.
- Create an entry point in adapter to start the matching of Adv based
on all monitors and invoke the RSSI tracking for Adv reporting.

Co-authored-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Howard Chung <howardchung@google.com>
---

Changes in v8:
- Merge the content matching patch to this commit.

Changes in v7:
- Add logs to NULL check of objects to reveal potential bugs
- Rename some members of struct adv_monitor_device
- Replace the use of GSList with struct queue
- Adopt bt_ad_pattern from shared/ad

Changes in v6:
- Fix the termination condition of AD data paring and remove unnecessary
length check

Changes in v5:
- Remove the use of unit test in commit message
- Remove unittest helper functions

Changes in v3:
- Fix commit message
- Remove unused variables
- Fix signature of queue_find()

 doc/advertisement-monitor-api.txt |   5 +
 src/adapter.c                     |  45 ++-
 src/adv_monitor.c                 | 443 +++++++++++++++++++++++++++---
 src/adv_monitor.h                 |  18 ++
 4 files changed, 467 insertions(+), 44 deletions(-)

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
index c0053000a..0e3fd57f3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1214,6 +1214,7 @@ void btd_adapter_remove_device(struct btd_adapter *adapter,
 	adapter->connect_list = g_slist_remove(adapter->connect_list, dev);
 
 	adapter->devices = g_slist_remove(adapter->devices, dev);
+	btd_adv_monitor_device_remove(adapter->adv_monitor_manager, dev);
 
 	adapter->discovery_found = g_slist_remove(adapter->discovery_found,
 									dev);
@@ -6596,10 +6597,28 @@ static void update_found_devices(struct btd_adapter *adapter,
 					const uint8_t *data, uint8_t data_len)
 {
 	struct btd_device *dev;
+	struct bt_ad *ad = NULL;
 	struct eir_data eir_data;
 	bool name_known, discoverable;
 	char addr[18];
 	bool duplicate = false;
+	struct queue *matched_monitors = NULL;
+
+	if (bdaddr_type != BDADDR_BREDR)
+		ad = bt_ad_new_with_data(data_len, data);
+
+	/* During the background scanning, update the device only when the data
+	 * match at least one Adv monitor
+	 */
+	if (ad) {
+		matched_monitors = btd_adv_monitor_content_filter(
+					adapter->adv_monitor_manager, ad);
+		bt_ad_unref(ad);
+		ad = NULL;
+	}
+
+	if (!adapter->discovering && !matched_monitors)
+		return;
 
 	memset(&eir_data, 0, sizeof(eir_data));
 	eir_parse(&eir_data, data, data_len);
@@ -6645,18 +6664,22 @@ static void update_found_devices(struct btd_adapter *adapter,
 		device_store_cached_name(dev, eir_data.name);
 
 	/*
-	 * Only skip devices that are not connected, are temporary and there
-	 * is no active discovery session ongoing.
+	 * Only skip devices that are not connected, are temporary, and there
+	 * is no active discovery session ongoing and no matched Adv monitors
 	 */
-	if (!btd_device_is_connected(dev) && (device_is_temporary(dev) &&
-						 !adapter->discovery_list)) {
+	if (!btd_device_is_connected(dev) &&
+		(device_is_temporary(dev) && !adapter->discovery_list) &&
+		!matched_monitors) {
 		eir_data_free(&eir_data);
 		return;
 	}
 
-	/* Don't continue if not discoverable or if filter don't match */
-	if (!discoverable || (adapter->filtered_discovery &&
-	    !is_filter_match(adapter->discovery_list, &eir_data, rssi))) {
+	/* If there is no matched Adv monitors, don't continue if not
+	 * discoverable or if active discovery filter don't match.
+	 */
+	if (!matched_monitors && (!discoverable ||
+		(adapter->filtered_discovery && !is_filter_match(
+				adapter->discovery_list, &eir_data, rssi)))) {
 		eir_data_free(&eir_data);
 		return;
 	}
@@ -6713,6 +6736,14 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	eir_data_free(&eir_data);
 
+	/* After the device is updated, notify the matched Adv monitors */
+	if (matched_monitors) {
+		btd_adv_monitor_notify_monitors(adapter->adv_monitor_manager,
+						dev, rssi, matched_monitors);
+		queue_destroy(matched_monitors, NULL);
+		matched_monitors = NULL;
+	}
+
 	/*
 	 * Only if at least one client has requested discovery, maintain
 	 * list of found devices and name confirming for legacy devices.
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index e441a5566..9a04da6e1 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -26,9 +26,9 @@
 
 #include "adapter.h"
 #include "dbus-common.h"
+#include "device.h"
 #include "log.h"
 #include "src/error.h"
-#include "src/shared/ad.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
@@ -81,13 +81,6 @@ enum monitor_state {
 	MONITOR_STATE_HONORED,	/* Accepted by kernel */
 };
 
-struct pattern {
-	uint8_t ad_type;
-	uint8_t offset;
-	uint8_t length;
-	uint8_t value[BT_AD_MAX_DATA_LEN];
-};
-
 struct adv_monitor {
 	struct adv_monitor_app *app;
 	GDBusProxy *proxy;
@@ -95,13 +88,34 @@ struct adv_monitor {
 
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
-	struct queue *patterns;
+	struct queue *patterns;		/* List of bt_ad_pattern objects */
+};
+
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
+	bool found;			/* State of the device - lost/found */
+	guint lost_timer;		/* Timer to track if the device goes
+					 * offline/out-of-range
+					 */
 };
 
 struct app_match_data {
@@ -109,6 +123,20 @@ struct app_match_data {
 	const char *path;
 };
 
+struct adv_content_filter_info {
+	struct bt_ad *ad;
+	struct queue *matched_monitors;	/* List of matched monitors */
+};
+
+struct adv_rssi_filter_info {
+	struct btd_device *device;
+	int8_t rssi;
+};
+
+static void monitor_device_free(void *data);
+static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
+					struct btd_device *device, int8_t rssi);
+
 const struct adv_monitor_type {
 	enum monitor_type type;
 	const char *name;
@@ -131,10 +159,7 @@ static void app_reply_msg(struct adv_monitor_app *app, DBusMessage *reply)
 /* Frees a pattern */
 static void pattern_free(void *data)
 {
-	struct pattern *pattern = data;
-
-	if (!pattern)
-		return;
+	struct bt_ad_pattern *pattern = data;
 
 	free(pattern);
 }
@@ -150,6 +175,9 @@ static void monitor_free(void *data)
 	g_dbus_proxy_unref(monitor->proxy);
 	g_free(monitor->path);
 
+	queue_destroy(monitor->devices, monitor_device_free);
+	monitor->devices = NULL;
+
 	queue_destroy(monitor->patterns, pattern_free);
 
 	free(monitor);
@@ -248,6 +276,7 @@ static struct adv_monitor *monitor_new(struct adv_monitor_app *app,
 	monitor->high_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
 	monitor->low_rssi = ADV_MONITOR_UNSET_RSSI;
 	monitor->low_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
+	monitor->devices = queue_new();
 
 	monitor->type = MONITOR_TYPE_NONE;
 	monitor->patterns = NULL;
@@ -436,7 +465,7 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
 		int value_len;
 		uint8_t *value;
 		uint8_t offset, ad_type;
-		struct pattern *pattern;
+		struct bt_ad_pattern *pattern;
 		DBusMessageIter struct_iter, value_iter;
 
 		dbus_message_iter_recurse(&array_iter, &struct_iter);
@@ -468,28 +497,10 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
 		dbus_message_iter_get_fixed_array(&value_iter, &value,
 							&value_len);
 
-		// Verify the values
-		if (offset > BT_AD_MAX_DATA_LEN - 1)
-			goto failed;
-
-		if ((ad_type > BT_AD_3D_INFO_DATA &&
-			ad_type != BT_AD_MANUFACTURER_DATA) ||
-			ad_type < BT_AD_FLAGS) {
-			goto failed;
-		}
-
-		if (!value || value_len <= 0 || value_len > BT_AD_MAX_DATA_LEN)
-			goto failed;
-
-		pattern = new0(struct pattern, 1);
+		pattern = bt_ad_pattern_new(ad_type, offset, value_len, value);
 		if (!pattern)
 			goto failed;
 
-		pattern->ad_type = ad_type;
-		pattern->offset = offset;
-		pattern->length = value_len;
-		memcpy(pattern->value, value, pattern->length);
-
 		queue_push_tail(monitor->patterns, pattern);
 
 		dbus_message_iter_next(&array_iter);
@@ -923,3 +934,361 @@ void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager)
 
 	manager_destroy(manager);
 }
+
+/* Processes the content matching based pattern(s) of a monitor */
+static void adv_match_per_monitor(void *data, void *user_data)
+{
+	struct adv_monitor *monitor = data;
+	struct adv_content_filter_info *info = user_data;
+
+	if (!monitor) {
+		error("Unexpected NULL adv_monitor object upon match");
+		return;
+	}
+
+	if (monitor->state != MONITOR_STATE_HONORED)
+		return;
+
+	if (monitor->type == MONITOR_TYPE_OR_PATTERNS &&
+		bt_ad_pattern_match(info->ad, monitor->patterns)) {
+		goto matched;
+	}
+
+	return;
+
+matched:
+	if (!info->matched_monitors)
+		info->matched_monitors = queue_new();
+
+	queue_push_tail(info->matched_monitors, monitor);
+}
+
+/* Processes the content matching for the monitor(s) of an app */
+static void adv_match_per_app(void *data, void *user_data)
+{
+	struct adv_monitor_app *app = data;
+
+	if (!app) {
+		error("Unexpected NULL adv_monitor_app object upon match");
+		return;
+	}
+
+	queue_foreach(app->monitors, adv_match_per_monitor, user_data);
+}
+
+/* Processes the content matching for every app without RSSI filtering and
+ * notifying monitors. The caller is responsible of releasing the memory of the
+ * list but not the ad data.
+ * Returns the list of monitors whose content match the ad data.
+ */
+struct queue *btd_adv_monitor_content_filter(
+				struct btd_adv_monitor_manager *manager,
+				struct bt_ad *ad)
+{
+	struct adv_content_filter_info info;
+
+	if (!manager || !ad)
+		return NULL;
+
+	info.ad = ad;
+	info.matched_monitors = NULL;
+
+	queue_foreach(manager->apps, adv_match_per_app, &info);
+
+	return info.matched_monitors;
+}
+
+/* Wraps adv_monitor_filter_rssi() to processes the content-matched monitor with
+ * RSSI filtering and notifies it on device found/lost event
+ */
+static void monitor_filter_rssi(void *data, void *user_data)
+{
+	struct adv_monitor *monitor = data;
+	struct adv_rssi_filter_info *info = user_data;
+
+	if (!monitor || !info)
+		return;
+
+	adv_monitor_filter_rssi(monitor, info->device, info->rssi);
+}
+
+/* Processes every content-matched monitor with RSSI filtering and notifies on
+ * device found/lost event. The caller is responsible of releasing the memory
+ * of matched_monitors list but not its data.
+ */
+void btd_adv_monitor_notify_monitors(struct btd_adv_monitor_manager *manager,
+					struct btd_device *device, int8_t rssi,
+					struct queue *matched_monitors)
+{
+	struct adv_rssi_filter_info info;
+
+	if (!manager || !device || !matched_monitors ||
+		queue_isempty(matched_monitors)) {
+		return;
+	}
+
+	info.device = device;
+	info.rssi = rssi;
+
+	queue_foreach(matched_monitors, monitor_filter_rssi, &info);
+}
+
+/* Matches a device based on btd_device object */
+static bool monitor_device_match(const void *a, const void *b)
+{
+	const struct adv_monitor_device *dev = a;
+	const struct btd_device *device = b;
+
+	if (!dev) {
+		error("Unexpected NULL adv_monitor_device object upon match");
+		return false;
+	}
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
+	if (!dev) {
+		error("Unexpected NULL adv_monitor_device object upon free");
+		return;
+	}
+
+	if (dev->lost_timer) {
+		g_source_remove(dev->lost_timer);
+		dev->lost_timer = 0;
+	}
+
+	dev->monitor = NULL;
+	dev->device = NULL;
+
+	free(dev);
+}
+
+/* Removes a device from monitor->devices list */
+static void remove_device_from_monitor(void *data, void *user_data)
+{
+	struct adv_monitor *monitor = data;
+	struct btd_device *device = user_data;
+	struct adv_monitor_device *dev = NULL;
+
+	if (!monitor) {
+		error("Unexpected NULL adv_monitor object upon device remove");
+		return;
+	}
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
+	if (!app) {
+		error("Unexpected NULL adv_monitor_app object upon device "
+			"remove");
+		return;
+	}
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
+	dev = new0(struct adv_monitor_device, 1);
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
+	dev->lost_timer = 0;
+
+	if (dev->found && dev->last_seen) {
+		/* We were tracking for the Low RSSI filter. Check if there is
+		 * any Adv received after the timeout function is invoked.
+		 * If not, report the Device Lost event.
+		 */
+		if (difftime(curr_time, dev->last_seen) >=
+		    monitor->low_rssi_timeout) {
+			dev->found = false;
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
+	if (!dev) {
+		dev = monitor_device_create(monitor, device);
+		if (!dev) {
+			btd_error(adapter_id, "Failed to create Adv Monitor "
+					      "device object.");
+			return;
+		}
+	}
+
+	if (dev->lost_timer) {
+		g_source_remove(dev->lost_timer);
+		dev->lost_timer = 0;
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
+	if (!dev->found && rssi > monitor->high_rssi) {
+		if (dev->high_rssi_first_seen) {
+			if (difftime(curr_time, dev->high_rssi_first_seen) >=
+			    monitor->high_rssi_timeout) {
+				dev->found = true;
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
+	if (dev->found && rssi < monitor->low_rssi) {
+		if (dev->low_rssi_first_seen) {
+			if (difftime(curr_time, dev->low_rssi_first_seen) >=
+			    monitor->low_rssi_timeout) {
+				dev->found = false;
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
+	if (dev->found) {
+		dev->lost_timer =
+			g_timeout_add_seconds(monitor->low_rssi_timeout,
+					      handle_device_lost_timeout, dev);
+	}
+}
diff --git a/src/adv_monitor.h b/src/adv_monitor.h
index 5cb372217..2b4f68abf 100644
--- a/src/adv_monitor.h
+++ b/src/adv_monitor.h
@@ -11,13 +11,31 @@
 #ifndef __ADV_MONITOR_H
 #define __ADV_MONITOR_H
 
+#include <glib.h>
+
+#include "src/shared/ad.h"
+
 struct mgmt;
+struct queue;
+struct btd_device;
 struct btd_adapter;
 struct btd_adv_monitor_manager;
+struct btd_adv_monitor_pattern;
 
 struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
 						struct btd_adapter *adapter,
 						struct mgmt *mgmt);
 void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager);
 
+struct queue *btd_adv_monitor_content_filter(
+				struct btd_adv_monitor_manager *manager,
+				struct bt_ad *ad);
+
+void btd_adv_monitor_notify_monitors(struct btd_adv_monitor_manager *manager,
+					struct btd_device *device, int8_t rssi,
+					struct queue *matched_monitors);
+
+void btd_adv_monitor_device_remove(struct btd_adv_monitor_manager *manager,
+				   struct btd_device *device);
+
 #endif /* __ADV_MONITOR_H */
-- 
2.26.2

