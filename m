Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26DDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Nov 2021 15:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhKTPdF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbhKTPdE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Nov 2021 10:33:04 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E8C061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:30:01 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id v32-20020a05622a18a000b002b04d0d410dso8947534qtc.11
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZRxuidxB40H/T2WQ7bK2a/emOFuJ6J+zg0ZcDF0pEew=;
        b=ZLIHqI4iqVcaCd2vjgWSj6QGyH1mJ6BjPuZriK04QuFOozTD2sCtPaBm7mXjeKkpVI
         Mf7ed4LKkniBHjVhcE+2NPU+CVIvPD9SdVKPFWr5Bos3Ko0LZoN/Yn25Ohe7MCCnBh3I
         NEmdstQ1qzpZwE30oH5lQoIPx81RnERoiLJdPJHd4Jw1OI69Q2dfW577f9Tl7Y/q+4b7
         OFwrbr1HtoQ+gmlQJNV9P/cFT79AV60njiP3zlsquBRKrKCIttYLANfb72fpH4j2DwMB
         v5cxsFMSb65fXsGAgrOXCUYaXOs9kUK88uFk8zXE4OXTMvOb83x75wgUQ62ROKtOTnG1
         kxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZRxuidxB40H/T2WQ7bK2a/emOFuJ6J+zg0ZcDF0pEew=;
        b=p69cPRaO7DgIiZPrimMDJtJWR79BpKHJjCBP3IZJLD2asVTs00zfvcm1l8heMXEtlV
         sI1Qi2Ka5sHhSIuoPAbMxG2bdSzHrws0+csS1+Cyx+BWs/qUH8I1goRjkkiU+gWVoH6K
         77Z4WpGJ+EA6u9cgsSEPdrzrE3LJz8eJ3ZcG76D7YjBhVcpZW9vCnTHJBTV7zQMnmu2V
         KJtPTgku8mp4EWICW6B3Aqi4wqoH/jC4kAt7tBOIOO2rnyCN22n3Hp1mUZchnutLw3Lz
         /Wq9KphBNAbFx8nIilyeWye49kn8ko+EIrEKWvuAWia1dniU2EZZZcJBnlrjMZPxiGJ1
         synQ==
X-Gm-Message-State: AOAM531QrbsqS8fbm0VPnRR4ktGd/nUY3FtvYUpqa1r+PNRmEvfsDuBl
        HrUtBTCbYFPK+N4ljjSfu9uwsFaemXGaWQ==
X-Google-Smtp-Source: ABdhPJxG/uP9Si6D9pqu7mLSInGUhg54egFKFqwIX8rZPdXvqq9ALE6OoaX+RPv9LadFoI4Fs21B/c6GHt/Zvw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:8437:70f3:c03b:1c71])
 (user=mmandlik job=sendgmr) by 2002:a05:622a:1115:: with SMTP id
 e21mr15376830qty.315.1637422200216; Sat, 20 Nov 2021 07:30:00 -0800 (PST)
Date:   Sat, 20 Nov 2021 07:29:39 -0800
In-Reply-To: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Message-Id: <20211120072449.BlueZ.v6.4.If3927b0228004494a5eb09d9226370119ddf4d8b@changeid>
Mime-Version: 1.0
References: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [BlueZ PATCH v6 4/6] adv_monitor: Invoke DeviceFound/Lost on tracked monitors
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

Changes in v6:
- Moved the definition of 'handle' variable to this patch

Changes in v5:
- Add this new patch in series to deliver DeviceFound/Lost to apps

 src/adv_monitor.c | 104 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 8 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index ca8aa976c..27d5f3308 100644
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
@@ -1540,6 +1578,8 @@ static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
 	struct btd_adv_monitor_manager *manager = user_data;
 	const uint16_t adapter_id = manager->adapter_id;
 	struct btd_adapter *adapter = manager->adapter;
+	uint16_t handle = le16_to_cpu(ev->monitor_handle);
+	struct monitored_device_info info;
 	const uint8_t *ad_data = NULL;
 	uint16_t ad_data_len;
 	uint32_t flags;
@@ -1578,6 +1618,49 @@ static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
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
@@ -1589,6 +1672,8 @@ static void adv_monitor_device_lost_callback(uint16_t index, uint16_t length,
 	const struct mgmt_ev_adv_monitor_device_lost *ev = param;
 	uint16_t handle = le16_to_cpu(ev->monitor_handle);
 	const uint16_t adapter_id = manager->adapter_id;
+	struct btd_adapter *adapter = manager->adapter;
+	struct monitored_device_info info;
 	char addr[18];
 
 	if (length < sizeof(*ev)) {
@@ -1600,6 +1685,17 @@ static void adv_monitor_device_lost_callback(uint16_t index, uint16_t length,
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
@@ -1961,14 +2057,6 @@ static struct adv_monitor_device *monitor_device_create(
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
2.34.0.rc2.393.gf8c9666880-goog

