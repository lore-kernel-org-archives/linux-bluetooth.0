Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834D3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAC761B04
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbhKQTSJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbhKQTSI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 14:18:08 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D95C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:10 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id e9-20020a170902ed8900b00143a3f40299so1607553plj.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fik3+aUxkJOy7w+csONhe1xUYP5DVD9aKI/SS7545MU=;
        b=KF3/W8rPei0uW0CEwYkt+tDxoGVeiWKE3iGzxl59j43LCZgqWiIPS+l/Wlg0d6iE0d
         UFZGqaOEY0nMylzv1BBscK9guZ2rWipucVbdOV/uR0lsvhOMjYSWq+DMrkPDgYA7y4Dr
         xtAYpCy7X9XVOgry1wi6sTefXRYZZohU3Q1HjQSvGkIg7twsqCvN3/IJplD+Wm60Tr7v
         XeKQYYj8SPiQKYJCzQ2+GsYKJgbVCpLqHRkXIvjJkzV1uQE9NSApANAiDv9SmrVKOCD8
         zZU+As3zDD9DsOkHHdJ4FtaC59ehQ+yC5Mnk+sEg5PvhN+CEFgJ8FtIVoYIqID1HvA7T
         S7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fik3+aUxkJOy7w+csONhe1xUYP5DVD9aKI/SS7545MU=;
        b=yNVNX2YYJdgemC3iI/nHzaqcMmVYtfKeyWPjxjfr975ILMU8YpU7jyKqyT12kZDKVR
         z75N0bQxOUgrkeZyVuqBU0BERfsBj5oPyj3yag0WKgvKvvEvMmujVvxqAZBhzFOxjq4p
         30OI1PNCHlcxCnfjG2uxdie6lQnsZbCcLHE2QDT49d5Ri3m4OhCpnfJpHv7aHTbAc8KU
         QkWpagrFqdfuipPVf3mk7X0+YLc4vMANXlb4iNO9z7bOCsZ2aKZRSKI01sDDUw+GW0Gm
         m/qHS9WusqtYVQwlyPjuLtiyXQ1FPcrCTenyx6COIq2P5fL3AfFSL1HoAWoyYLRbEqiJ
         0r5g==
X-Gm-Message-State: AOAM531VhXM51zD9ukQ+9tAGh/Y415/LhKlPPgn4LMe8knvgRIhzgaJG
        GjoOqKSE9oiHuyFBOxCfH5lnssRfJjgoeA==
X-Google-Smtp-Source: ABdhPJwGeJNldwXus6T+5MK7SmdumQFLiiWc4jtfYi0YtqBfuPve0JJUv2Hwe/yD2ApLf/Qfasy5XV85zO3lwA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:b1b3:555c:d0fb:8921])
 (user=mmandlik job=sendgmr) by 2002:a63:5813:: with SMTP id
 m19mr6780980pgb.441.1637176509679; Wed, 17 Nov 2021 11:15:09 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:14:48 -0800
In-Reply-To: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Message-Id: <20211117110627.BlueZ.v5.4.If3927b0228004494a5eb09d9226370119ddf4d8b@changeid>
Mime-Version: 1.0
References: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [BlueZ PATCH v5 4/6] adv_monitor: Invoke DeviceFound/Lost on tracked monitors
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

This patch delivers DeviceFound/DeviceLost events to apps over D-Bus
whenever controller starts/stops tracking a device.

Tests performed:
- Add a monitor and verify that DeviceFound/DeviceLost events are
  received whenever controller starts/stops monitoring.
- Verify from logs that only one Adv Report is received from the
  controller when Sampling_Period is set to 0xFF and the
  DeviceFound/DeviceLost functionality still works as intended.
- Verify that DeviceFound/DeviceLost is reported appropriately even
  when the Active Scanning is in progress.
- Verify that the reconnection also works properly with and without
  any active Advertisement Monitor.

Reviewed-by: Miao-chen Chou <mcchou@google.com>
---

Changes in v5:
- Add this new patch in series to deliver DeviceFound/Lost to apps

 src/adv_monitor.c | 103 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 8 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index e5bdfb6ef..1a8397259 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -174,6 +174,11 @@ struct adv_rssi_filter_info {
 	int8_t rssi;
 };
 
+struct monitored_device_info {
+	uint16_t monitor_handle;	/* Kernel Monitor Handle */
+	struct btd_device *device;
+};
+
 static void monitor_device_free(void *data);
 static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 					struct btd_device *device, int8_t rssi);
@@ -1531,6 +1536,39 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
 		ev->monitor_handle);
 }
 
+/* Includes found/lost device's object path into the dbus message */
+static void report_device_state_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *path = device_get_path(user_data);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+/* Invokes DeviceFound on the matched monitor */
+static void notify_device_found_per_monitor(void *data, void *user_data)
+{
+	struct adv_monitor *monitor = data;
+	struct monitored_device_info *info = user_data;
+
+	if (monitor->merged_pattern->monitor_handle == info->monitor_handle) {
+		DBG("Calling DeviceFound() on Adv Monitor of owner %s "
+		    "at path %s", monitor->app->owner, monitor->path);
+
+		g_dbus_proxy_method_call(monitor->proxy, "DeviceFound",
+					 report_device_state_setup, NULL,
+					 info->device, NULL);
+	}
+}
+
+/* Checks all monitors for match in the app to invoke DeviceFound */
+static void notify_device_found_per_app(void *data, void *user_data)
+{
+	struct adv_monitor_app *app = data;
+
+	queue_foreach(app->monitors, notify_device_found_per_monitor,
+		      user_data);
+}
+
 /* Processes Adv Monitor Device Found event from kernel */
 static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
 						const void *param,
@@ -1548,6 +1586,7 @@ static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
 	bool legacy;
 	char addr[18];
 	bool not_connectable;
+	struct monitored_device_info info;
 
 	if (length < sizeof(*ev)) {
 		btd_error(adapter_id,
@@ -1579,6 +1618,49 @@ static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
 					ev->addr.type, ev->rssi, confirm_name,
 					legacy, not_connectable, ad_data,
 					ad_data_len, true);
+
+	if (handle) {
+		DBG("Adv Monitor with handle 0x%04x started tracking "
+		    "the device %s", handle, addr);
+
+		info.device = btd_adapter_find_device(adapter, &ev->addr.bdaddr,
+						      ev->addr.type);
+		if (!info.device) {
+			btd_error(adapter_id, "Device object not found for %s",
+				  addr);
+			return;
+		}
+
+		/* Check for matched monitor in all apps */
+		info.monitor_handle = handle;
+		queue_foreach(manager->apps, notify_device_found_per_app,
+			      &info);
+	}
+}
+
+/* Invokes DeviceLost on the matched monitor */
+static void notify_device_lost_per_monitor(void *data, void *user_data)
+{
+	struct adv_monitor *monitor = data;
+	struct monitored_device_info *info = user_data;
+
+	if (monitor->merged_pattern->monitor_handle == info->monitor_handle) {
+		DBG("Calling DeviceLost() on Adv Monitor of owner %s "
+		    "at path %s", monitor->app->owner, monitor->path);
+
+		g_dbus_proxy_method_call(monitor->proxy, "DeviceLost",
+					 report_device_state_setup, NULL,
+					 info->device, NULL);
+	}
+}
+
+/* Checks all monitors for match in the app to invoke DeviceLost */
+static void notify_device_lost_per_app(void *data, void *user_data)
+{
+	struct adv_monitor_app *app = data;
+
+	queue_foreach(app->monitors, notify_device_lost_per_monitor,
+		      user_data);
 }
 
 /* Processes Adv Monitor Device Lost event from kernel */
@@ -1590,7 +1672,9 @@ static void adv_monitor_device_lost_callback(uint16_t index, uint16_t length,
 	const struct mgmt_ev_adv_monitor_device_lost *ev = param;
 	uint16_t handle = le16_to_cpu(ev->monitor_handle);
 	const uint16_t adapter_id = manager->adapter_id;
+	struct btd_adapter *adapter = manager->adapter;
 	char addr[18];
+	struct monitored_device_info info;
 
 	if (length < sizeof(*ev)) {
 		btd_error(adapter_id,
@@ -1601,6 +1685,17 @@ static void adv_monitor_device_lost_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, addr);
 	DBG("Adv Monitor with handle 0x%04x stopped tracking the device %s",
 		handle, addr);
+
+	info.device = btd_adapter_find_device(adapter, &ev->addr.bdaddr,
+					      ev->addr.type);
+	if (!info.device) {
+		btd_error(adapter_id, "Device object not found for %s", addr);
+		return;
+	}
+
+	/* Check for matched monitor in all apps */
+	info.monitor_handle = handle;
+	queue_foreach(manager->apps, notify_device_lost_per_app, &info);
 }
 
 /* Allocates a manager object */
@@ -1962,14 +2057,6 @@ static struct adv_monitor_device *monitor_device_create(
 	return dev;
 }
 
-/* Includes found/lost device's object path into the dbus message */
-static void report_device_state_setup(DBusMessageIter *iter, void *user_data)
-{
-	const char *path = device_get_path(user_data);
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
-}
-
 /* Handles a situation where the device goes offline/out-of-range */
 static bool handle_device_lost_timeout(gpointer user_data)
 {
-- 
2.34.0.rc1.387.gb447b232ab-goog

