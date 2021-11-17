Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CF1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 110EC61BB6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbhKQTSJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbhKQTSH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 14:18:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9D0C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y3-20020a25ad03000000b005e52103ed80so5469206ybi.19
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gos2naxGKWfULEQNzy8c4dBRogK6Y5j4KagBjXSK2y0=;
        b=r73WZaSipY23x+CmBZiwUm2ctUvuB8p2c/eCLCPRJubN6xlAj1GMG2w+pjG3nNaPUg
         NU4wBYbc1Z2KDUriY4+/l7JalYhN20gAmvP2jwkubzHKLXJCH4c2aLixNxxm01c8WAjS
         zGOB2HT/gk8iTvDd+A0uOIZUrzTHteelwMPfz5sNg3l2DW6ilj3w5r4hYUcxuIvHHYGN
         7RmLwQY1IqZnDJCVq76wqYt1mk0gv/BrCRHRFFqHTceYtnnPgUvMtmzYdEqmlswGG1Ca
         ULS83l0J+a7i8IiL9qnjzGeJVvBvenQReN3fLRprl4DCOIVyTbAwehWLU0YRGsnvVH+z
         JKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gos2naxGKWfULEQNzy8c4dBRogK6Y5j4KagBjXSK2y0=;
        b=BFoa1Fo1lVAtYJ9MVeNpFQlEfiqR63aNQNn5+8AwusnU1OojLSJHE/IHduMeqw3D+O
         zT+AiwynktDjW4WjUBbde/g9R6EMtAinA0uF+cXbGMiY/W7GuUHdsEDP2gQBJRiBo4qx
         euQyASDESPmvQxLQRjVq37PMYG2ytq/8Sr8Y8mRgyjSMlWZmpMImM4o2SyhOjsHj4fn6
         4AYiyim5ea1fMRSMo5r+vqvneXNDzbrE+vPBrxWcMbSKxJxGNaHT7FxrjC1Vr5OPU10j
         6kxh/dh3kp/fIjaZKJrK3NNTYDvjEvKXP1qCr3LXy2nC9HYVOYHsxLwhD7vosMiUfOAG
         oamg==
X-Gm-Message-State: AOAM530h04bOfhw4553bix15lSuZU/xk7krPaWeIh4FXHI/Qx4ZOAd+V
        NOCDsKAHzfupK3qcBs99+a2zCBOv3QZ4ZQ==
X-Google-Smtp-Source: ABdhPJz1AEvx2C+k22ZIiz+K2ysnww+VPTyENTe4pM8LWUArrV4IBuLH5sjIIQR70gCMONHjU9RM5VaIRvNBkQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:b1b3:555c:d0fb:8921])
 (user=mmandlik job=sendgmr) by 2002:a25:104:: with SMTP id
 4mr19657447ybb.27.1637176507835; Wed, 17 Nov 2021 11:15:07 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:14:47 -0800
In-Reply-To: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Message-Id: <20211117110627.BlueZ.v5.3.I68039747acc3c63f758278452889d6ed2bfff065@changeid>
Mime-Version: 1.0
References: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [BlueZ PATCH v5 3/6] adv_monitor: Receive the Device Found/Lost events
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch registers callback functions to receive the Advertisement
Monitor Device Found and Device Lost events. It also disables software
based filtering whenever controller offloading support is available.

Test performed:
- Verified by logs that the MSFT Monitor Device is received from the
  controller and the bluetoothd is notified whenever the controller
  starts/stops monitoring a device.

Reviewed-by: Miao-chen Chou <mcchou@google.com>
---

Changes in v5:
- Update the Adv Monitor Device Found event to include fields from the
  existing Device Found event and update the device object.
- Disable the software based filtering whenever controller offloading is
  available.

Changes in v4:
- Add Advertisement Monitor Device Found event.

Changes in v3:
- Fix indentation of the adv_monitor_device_lost_callback() name and
  it's arguments.

Changes in v2:
- Update function name adv_monitor_tracking_callback() to
  adv_monitor_device_lost_callback() as it will receive only Device Lost
  event.

 src/adapter.c     | 47 +++++++++++++-----------
 src/adapter.h     |  8 +++++
 src/adv_monitor.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 src/adv_monitor.h |  2 ++
 4 files changed, 128 insertions(+), 20 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d0d38621b..42463a3c1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6984,12 +6984,13 @@ static bool device_is_discoverable(struct btd_adapter *adapter,
 	return discoverable;
 }
 
-static void update_found_devices(struct btd_adapter *adapter,
+void btd_adapter_update_found_device(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
 					bool confirm, bool legacy,
 					bool not_connectable,
-					const uint8_t *data, uint8_t data_len)
+					const uint8_t *data, uint8_t data_len,
+					bool monitoring)
 {
 	struct btd_device *dev;
 	struct bt_ad *ad = NULL;
@@ -6999,20 +7000,24 @@ static void update_found_devices(struct btd_adapter *adapter,
 	bool duplicate = false;
 	struct queue *matched_monitors = NULL;
 
-	if (bdaddr_type != BDADDR_BREDR)
-		ad = bt_ad_new_with_data(data_len, data);
+	if (!btd_adv_monitor_offload_supported(adapter->adv_monitor_manager)) {
+		if (bdaddr_type != BDADDR_BREDR)
+			ad = bt_ad_new_with_data(data_len, data);
 
-	/* During the background scanning, update the device only when the data
-	 * match at least one Adv monitor
-	 */
-	if (ad) {
-		matched_monitors = btd_adv_monitor_content_filter(
-					adapter->adv_monitor_manager, ad);
-		bt_ad_unref(ad);
-		ad = NULL;
+		/* During the background scanning, update the device only when
+		 * the data match at least one Adv monitor
+		 */
+		if (ad) {
+			matched_monitors = btd_adv_monitor_content_filter(
+						adapter->adv_monitor_manager,
+						ad);
+			bt_ad_unref(ad);
+			ad = NULL;
+			monitoring = matched_monitors ? true : false;
+		}
 	}
 
-	if (!adapter->discovering && !matched_monitors)
+	if (!adapter->discovering && !monitoring)
 		return;
 
 	memset(&eir_data, 0, sizeof(eir_data));
@@ -7025,7 +7030,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	dev = btd_adapter_find_device(adapter, bdaddr, bdaddr_type);
 	if (!dev) {
-		if (!discoverable && !matched_monitors) {
+		if (!discoverable && !monitoring) {
 			eir_data_free(&eir_data);
 			return;
 		}
@@ -7064,7 +7069,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 	 */
 	if (!btd_device_is_connected(dev) &&
 		(device_is_temporary(dev) && !adapter->discovery_list) &&
-		!matched_monitors) {
+		!monitoring) {
 		eir_data_free(&eir_data);
 		return;
 	}
@@ -7072,7 +7077,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 	/* If there is no matched Adv monitors, don't continue if not
 	 * discoverable or if active discovery filter don't match.
 	 */
-	if (!matched_monitors && (!discoverable ||
+	if (!monitoring && (!discoverable ||
 		(adapter->filtered_discovery && !is_filter_match(
 				adapter->discovery_list, &eir_data, rssi)))) {
 		eir_data_free(&eir_data);
@@ -7202,6 +7207,7 @@ static void device_found_callback(uint16_t index, uint16_t length,
 	bool confirm_name;
 	bool legacy;
 	char addr[18];
+	bool not_connectable;
 
 	if (length < sizeof(*ev)) {
 		btd_error(adapter->dev_id,
@@ -7230,11 +7236,12 @@ static void device_found_callback(uint16_t index, uint16_t length,
 
 	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
 	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
+	not_connectable = (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
 
-	update_found_devices(adapter, &ev->addr.bdaddr, ev->addr.type,
-					ev->rssi, confirm_name, legacy,
-					flags & MGMT_DEV_FOUND_NOT_CONNECTABLE,
-					eir, eir_len);
+	btd_adapter_update_found_device(adapter, &ev->addr.bdaddr,
+					ev->addr.type, ev->rssi, confirm_name,
+					legacy, not_connectable, eir, eir_len,
+					false);
 }
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter)
diff --git a/src/adapter.h b/src/adapter.h
index db3c17f23..cd0d037af 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -87,6 +87,14 @@ struct btd_device *btd_adapter_find_device(struct btd_adapter *adapter,
 struct btd_device *btd_adapter_find_device_by_path(struct btd_adapter *adapter,
 						   const char *path);
 
+void btd_adapter_update_found_device(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr,
+					uint8_t bdaddr_type, int8_t rssi,
+					bool confirm, bool legacy,
+					bool not_connectable,
+					const uint8_t *data, uint8_t data_len,
+					bool monitored);
+
 const char *adapter_get_path(struct btd_adapter *adapter);
 const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter);
 uint8_t btd_adapter_get_address_type(struct btd_adapter *adapter);
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index a3b33188b..e5bdfb6ef 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1531,6 +1531,78 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
 		ev->monitor_handle);
 }
 
+/* Processes Adv Monitor Device Found event from kernel */
+static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
+						const void *param,
+						void *user_data)
+{
+	const struct mgmt_ev_adv_monitor_device_found *ev = param;
+	struct btd_adv_monitor_manager *manager = user_data;
+	uint16_t handle = le16_to_cpu(ev->monitor_handle);
+	const uint16_t adapter_id = manager->adapter_id;
+	struct btd_adapter *adapter = manager->adapter;
+	const uint8_t *ad_data = NULL;
+	uint16_t ad_data_len;
+	uint32_t flags;
+	bool confirm_name;
+	bool legacy;
+	char addr[18];
+	bool not_connectable;
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter_id,
+				"Too short Adv Monitor Device Found event");
+		return;
+	}
+
+	ad_data_len = btohs(ev->ad_data_len);
+	if (length != sizeof(*ev) + ad_data_len) {
+		btd_error(adapter_id,
+				"Wrong size of Adv Monitor Device Found event");
+		return;
+	}
+
+	if (ad_data_len > 0)
+		ad_data = ev->ad_data;
+
+	flags = btohl(ev->flags);
+
+	ba2str(&ev->addr.bdaddr, addr);
+	DBG("hci%u addr %s, rssi %d flags 0x%04x ad_data_len %u",
+			index, addr, ev->rssi, flags, ad_data_len);
+
+	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
+	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
+	not_connectable = (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
+
+	btd_adapter_update_found_device(adapter, &ev->addr.bdaddr,
+					ev->addr.type, ev->rssi, confirm_name,
+					legacy, not_connectable, ad_data,
+					ad_data_len, true);
+}
+
+/* Processes Adv Monitor Device Lost event from kernel */
+static void adv_monitor_device_lost_callback(uint16_t index, uint16_t length,
+						const void *param,
+						void *user_data)
+{
+	struct btd_adv_monitor_manager *manager = user_data;
+	const struct mgmt_ev_adv_monitor_device_lost *ev = param;
+	uint16_t handle = le16_to_cpu(ev->monitor_handle);
+	const uint16_t adapter_id = manager->adapter_id;
+	char addr[18];
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter_id,
+				"Wrong size of Adv Monitor Device Lost event");
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+	DBG("Adv Monitor with handle 0x%04x stopped tracking the device %s",
+		handle, addr);
+}
+
 /* Allocates a manager object */
 static struct btd_adv_monitor_manager *manager_new(
 						struct btd_adapter *adapter,
@@ -1555,6 +1627,14 @@ static struct btd_adv_monitor_manager *manager_new(
 			manager->adapter_id, adv_monitor_removed_callback,
 			manager, NULL);
 
+	mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
+			manager->adapter_id, adv_monitor_device_found_callback,
+			manager, NULL);
+
+	mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_DEVICE_LOST,
+			manager->adapter_id, adv_monitor_device_lost_callback,
+			manager, NULL);
+
 	return manager;
 }
 
@@ -1666,6 +1746,17 @@ void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager)
 	manager_destroy(manager);
 }
 
+bool btd_adv_monitor_offload_supported(struct btd_adv_monitor_manager *manager)
+{
+	if (!manager) {
+		error("Manager is NULL, get offload support failed");
+		return false;
+	}
+
+	return !!(manager->enabled_features &
+				MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS);
+}
+
 /* Processes the content matching based pattern(s) of a monitor */
 static void adv_match_per_monitor(void *data, void *user_data)
 {
diff --git a/src/adv_monitor.h b/src/adv_monitor.h
index d9cb9ccbb..bed6572d0 100644
--- a/src/adv_monitor.h
+++ b/src/adv_monitor.h
@@ -27,6 +27,8 @@ struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
 						struct mgmt *mgmt);
 void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager);
 
+bool btd_adv_monitor_offload_supported(struct btd_adv_monitor_manager *manager);
+
 struct queue *btd_adv_monitor_content_filter(
 				struct btd_adv_monitor_manager *manager,
 				struct bt_ad *ad);
-- 
2.34.0.rc1.387.gb447b232ab-goog

