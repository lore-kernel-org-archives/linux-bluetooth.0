Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8A8C55179
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3802076E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b8O/IRDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbgJ1XGf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgJ1XGe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 19:06:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993BBC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:06:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x13so753615pgp.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rS5fB+JtyzQgwlCyXJorJ7zYMrUa4XcGnS1nwIb9UM0=;
        b=b8O/IRDyPbCv8vWs/MkBGEbRUss0zWTUe4WYs402zhNcy2piIPQ1OUtIvx6zUi5f6j
         DKpj2Sub34RE75rhD7s2xAeviaeT6Z6qhY9HCYv+9zBj6cVylXobrn9QBoXjlONxZe88
         UAvRxFB5kooAdaq28PXE/IGgMCTXjIwZLPKJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rS5fB+JtyzQgwlCyXJorJ7zYMrUa4XcGnS1nwIb9UM0=;
        b=QmF2Ni92wTm0kazXkhQ23+89d44wWezdDXtEustx9vOm7Fi0zMJNMyf6nk74NKysLG
         CVdKvsZj3E1pZ8lpggxdomVLpVfdhHwPwVkLPChdkt7LVFn1SNxycEt/CHaBgmaSgzh9
         V+C9RgxqFFVCe7GzVELzxwLM9nGKx7iY6HX9uEKKYGgGsivgho6HBbrtcYZhNozpJdOl
         +Uw1xs80z5W3Sif9VVfvhaN3dmh5qfv6yNohs9XDeXo07jSAKiJBCBUwaJEsHoO24hTQ
         4WyKz/J862s/mrhIRfrQ8aY35MI74TQwqPxUrInms1k5dXv+i9TNFZUl8fQZES+p+d4J
         D5Fg==
X-Gm-Message-State: AOAM530c/6NaNMQxT9jPcwF0Q6YXb6eQDYpKg6j77+aRRJIfmgjQpRid
        +UbS4qd/+gIlcYVxHuKYopij92qlwV4SVQ==
X-Google-Smtp-Source: ABdhPJwZrQsiR/3JK8CIy98JkrHfacBzlKRDg5EeNTVLW5vpZKti74dvAbGlV3KfmvteBp9Pwe2GtQ==
X-Received: by 2002:aa7:8055:0:b029:15f:cbe9:1aad with SMTP id y21-20020aa780550000b029015fcbe91aadmr1510577pfm.71.1603926393585;
        Wed, 28 Oct 2020 16:06:33 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y137sm644134pfc.77.2020.10.28.16.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 16:06:32 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v7 3/7] adv_monitor: Implement Adv matching based on stored monitors
Date:   Wed, 28 Oct 2020 16:05:30 -0700
Message-Id: <20201028160433.BlueZ.v7.3.I578ae5e76fcf7243206a27d4f5a25783662a5f14@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements create an entry point in adapter to start the matching of
Adv based on all monitors and invoke the RSSI tracking for Adv reporting.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

Changes in v7:
- Replace the use of GSList with struct queue
- Adopt bt_ad_pattern from shared/ad
- Add error logs

Changes in v6:
- Fix the termination condition of AD data paring and remove unnecessary
length check

Changes in v5:
- Remove unittest helper functions

Changes in v3:
- Remove unused variables
- Fix signature of queue_find()

 src/adapter.c     |  44 +++++++++++---
 src/adv_monitor.c | 151 +++++++++++++++++++++++++++++++++++-----------
 src/adv_monitor.h |  14 +++++
 3 files changed, 167 insertions(+), 42 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6d0114a6b..0e3fd57f3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6597,10 +6597,28 @@ static void update_found_devices(struct btd_adapter *adapter,
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
@@ -6646,18 +6664,22 @@ static void update_found_devices(struct btd_adapter *adapter,
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
@@ -6714,6 +6736,14 @@ static void update_found_devices(struct btd_adapter *adapter,
 
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
index 74351d91e..9a04da6e1 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -29,15 +29,12 @@
 #include "device.h"
 #include "log.h"
 #include "src/error.h"
-#include "src/shared/ad.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 
 #include "adv_monitor.h"
 
-static void monitor_device_free(void *data);
-
 #define ADV_MONITOR_INTERFACE		"org.bluez.AdvertisementMonitor1"
 #define ADV_MONITOR_MGR_INTERFACE	"org.bluez.AdvertisementMonitorManager1"
 
@@ -84,13 +81,6 @@ enum monitor_state {
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
@@ -105,7 +95,7 @@ struct adv_monitor {
 	struct queue *devices;		/* List of adv_monitor_device objects */
 
 	enum monitor_type type;		/* MONITOR_TYPE_* */
-	struct queue *patterns;
+	struct queue *patterns;		/* List of bt_ad_pattern objects */
 };
 
 /* Some data like last_seen, timer/timeout values need to be maintained
@@ -133,6 +123,20 @@ struct app_match_data {
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
@@ -155,10 +159,7 @@ static void app_reply_msg(struct adv_monitor_app *app, DBusMessage *reply)
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
@@ -464,7 +465,7 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
 		int value_len;
 		uint8_t *value;
 		uint8_t offset, ad_type;
-		struct pattern *pattern;
+		struct bt_ad_pattern *pattern;
 		DBusMessageIter struct_iter, value_iter;
 
 		dbus_message_iter_recurse(&array_iter, &struct_iter);
@@ -496,28 +497,10 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
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
@@ -952,6 +935,104 @@ void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager)
 	manager_destroy(manager);
 }
 
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
 /* Matches a device based on btd_device object */
 static bool monitor_device_match(const void *a, const void *b)
 {
diff --git a/src/adv_monitor.h b/src/adv_monitor.h
index 13d5d7282..2b4f68abf 100644
--- a/src/adv_monitor.h
+++ b/src/adv_monitor.h
@@ -11,16 +11,30 @@
 #ifndef __ADV_MONITOR_H
 #define __ADV_MONITOR_H
 
+#include <glib.h>
+
+#include "src/shared/ad.h"
+
 struct mgmt;
+struct queue;
 struct btd_device;
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
 void btd_adv_monitor_device_remove(struct btd_adv_monitor_manager *manager,
 				   struct btd_device *device);
 
-- 
2.26.2

