Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] android/gatt: Expose API to elevate security level
Date: Wed, 30 Jul 2014 11:38:47 +0200
Message-Id: <1406713130-3825-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1406713130-3825-1-git-send-email-marcin.kraglak@tieto.com>
References: <1406713130-3825-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will allow to change security from external profile,
for example in hog implementation.
---
 android/gatt.c | 11 +++++++++++
 android/gatt.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 31558d0..49ca2b6 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2860,6 +2860,17 @@ static bool set_security(struct gatt_device *device, int req_sec_level)
 	return true;
 }
 
+bool bt_gatt_set_security(const bdaddr_t *bdaddr, int sec_level)
+{
+	struct gatt_device *device;
+
+	device = find_device_by_addr(bdaddr);
+	if (!device)
+		return false;
+
+	return set_security(device, sec_level);
+}
+
 static bool set_auth_type(struct gatt_device *device, int auth_type)
 {
 	int sec_level;
diff --git a/android/gatt.h b/android/gatt.h
index 5ba9161..027dda3 100644
--- a/android/gatt.h
+++ b/android/gatt.h
@@ -38,3 +38,4 @@ bool bt_gatt_unregister_app(unsigned int id);
 
 bool bt_gatt_connect_app(unsigned int id, const bdaddr_t *addr);
 bool bt_gatt_disconnect_app(unsigned int id, const bdaddr_t *addr);
+bool bt_gatt_set_security(const bdaddr_t *bdaddr, int sec_level);
-- 
1.9.3

