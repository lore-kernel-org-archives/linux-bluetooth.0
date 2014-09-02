Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 06/16] android/gatt: Add API to autoconnect GATT based devices
Date: Tue,  2 Sep 2014 12:09:51 +0200
Message-Id: <1409652601-28689-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 30 ++++++++++++++++++++++++++++++
 android/gatt.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index f526c16..5d04ad8 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6725,3 +6725,33 @@ bool bt_gatt_disconnect_app(unsigned int id, const bdaddr_t *addr)
 
 	return true;
 }
+
+bool bt_gatt_add_autoconnect(unsigned int id, const bdaddr_t *addr)
+{
+	struct gatt_device *dev;
+	struct gatt_app *app;
+
+	DBG("");
+
+	app = find_app_by_id(id);
+	if (!app) {
+		error("gatt: App ID=%d not found", id);
+		return false;
+	}
+
+	dev = find_device_by_addr(addr);
+	if (!dev) {
+		error("gatt: Device not found");
+		return false;
+	}
+
+	/* Take reference of device for auto connect purpose */
+	if (queue_isempty(dev->autoconnect_apps))
+		device_ref(dev);
+
+	if (!queue_find(dev->autoconnect_apps, match_by_value,
+							INT_TO_PTR(id)))
+		return queue_push_head(dev->autoconnect_apps, INT_TO_PTR(id));
+
+	return true;
+}
diff --git a/android/gatt.h b/android/gatt.h
index 027dda3..40699b2 100644
--- a/android/gatt.h
+++ b/android/gatt.h
@@ -39,3 +39,4 @@ bool bt_gatt_unregister_app(unsigned int id);
 bool bt_gatt_connect_app(unsigned int id, const bdaddr_t *addr);
 bool bt_gatt_disconnect_app(unsigned int id, const bdaddr_t *addr);
 bool bt_gatt_set_security(const bdaddr_t *bdaddr, int sec_level);
+bool bt_gatt_add_autoconnect(unsigned int id, const bdaddr_t *addr);
-- 
1.8.4

