Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF6BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Nov 2021 15:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhKTPdE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbhKTPdC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Nov 2021 10:33:02 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1F7C061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:29:58 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id n6-20020a17090a670600b001a9647fd1aaso8553433pjj.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=smKACWAoQoueNUR+pRVMh86fOTRKhFr4+ViV3tZpMak=;
        b=qeeDoBhibimiFQn42Dta7qLsDA3aNqx/Wizn9xCKSuMigXNhW/qNHJGwB3xWftyki9
         Hp/2ti4Dm9twEXenFNgNNe7rZeWwZus9kvJKpEwniblGl3exfSy/1Y9bA7CWpkzo5LFG
         v1ePrH7ngxBPkJUsnaBZka1vyu4cuO4y9kh6OoDduByRxuZi+2J8nEo4h2QzoIJxzd3N
         ce1/xr6N/vScpsB3MQxxBuMH7SdNwb8iyVQqUg91MmdraOHaF+EZr7EbfWCbMmlraj5w
         ftC9JzApzz2GNuSq6Se1FQ8PN5YJDPnjPfYN1ZvFrtdAtoz1KTsrp9PdOXO26QCrhvb2
         6zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=smKACWAoQoueNUR+pRVMh86fOTRKhFr4+ViV3tZpMak=;
        b=wHZXD9E1cOQ3x0RpAl/ASASX7mIPeh8WV35dpsBc1J6v4MeJWEPsiLNvjjGMJTdTU4
         9A7BWuOOHA4PNT8RH0cNY+H1Jno/oyIzICGYVp8T0g43XzxzSQQbYb0xoUFim4as7UW1
         89t8CfxmD6pz74bI+JOHdYzQHSqUIgXx6wu124F6BX9C0aucl+ICaxPV3ufgvf4g1g+k
         ewSBCcGOKY+LhRjS8s0xgSGYhCmVICiz1EGMArEDwCjYFbqPP4EBGFrNdD99URL9A7cs
         dvIk/mo5M6af5OaqFgQyRqMLNGEIt1vo3e1IfVsbIuiSliuFMrcPIi1NfPxOny5zVaP2
         FypQ==
X-Gm-Message-State: AOAM533nO8Uo0JMx30L401WnvLWGAJCvOgEZNxpZ/13itY7+hpWDirMO
        zrFIlo2uAbY53f+8TWcDz9nXH0YVPcGxQQ==
X-Google-Smtp-Source: ABdhPJyVi3qpYhgNnFsyrhA5YwEHyeYt5gtkxfemsomipYpCgq7EBnWCQEp6f8igvI+D8mQx8UJoTGFNubqLCw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:8437:70f3:c03b:1c71])
 (user=mmandlik job=sendgmr) by 2002:aa7:84d7:0:b0:49f:aa6d:8745 with SMTP id
 x23-20020aa784d7000000b0049faa6d8745mr71923623pfn.50.1637422198336; Sat, 20
 Nov 2021 07:29:58 -0800 (PST)
Date:   Sat, 20 Nov 2021 07:29:38 -0800
In-Reply-To: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Message-Id: <20211120072449.BlueZ.v6.3.I68039747acc3c63f758278452889d6ed2bfff065@changeid>
Mime-Version: 1.0
References: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [BlueZ PATCH v6 3/6] adv_monitor: Receive the Device Found/Lost events
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

Changes in v6:
- Removed unused variable 'handle'.

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

 src/adapter.c     | 47 ++++++++++++++-----------
 src/adapter.h     |  8 +++++
 src/adv_monitor.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 src/adv_monitor.h |  2 ++
 4 files changed, 127 insertions(+), 20 deletions(-)

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
index a3b33188b..ca8aa976c 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1531,6 +1531,77 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
 		ev->monitor_handle);
 }
 
+/* Processes Adv Monitor Device Found event from kernel */
+static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
+						const void *param,
+						void *user_data)
+{
+	const struct mgmt_ev_adv_monitor_device_found *ev = param;
+	struct btd_adv_monitor_manager *manager = user_data;
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
@@ -1555,6 +1626,14 @@ static struct btd_adv_monitor_manager *manager_new(
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
 
@@ -1666,6 +1745,17 @@ void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager)
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
2.34.0.rc2.393.gf8c9666880-goog

