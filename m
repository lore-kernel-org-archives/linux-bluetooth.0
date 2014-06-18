Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/4] android/gatt: Expose function to set security on GATT
Date: Thu, 19 Jun 2014 00:41:25 +0200
Message-Id: <1403131286-15028-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1403131286-15028-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1403131286-15028-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 10 ++++++++++
 android/gatt.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 7061924..9471eaf 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6286,3 +6286,13 @@ bool bt_gatt_disconnect_app(unsigned int id, const bdaddr_t *addr)
 
 	return true;
 }
+
+void bt_gatt_set_security(const bdaddr_t *addr, int sec_level)
+{
+	struct gatt_device *dev = find_device_by_addr(addr);
+
+	if (!dev)
+		return;
+
+	set_security_level(dev, sec_level);
+}
diff --git a/android/gatt.h b/android/gatt.h
index 5ba9161..d4f8a8e 100644
--- a/android/gatt.h
+++ b/android/gatt.h
@@ -38,3 +38,5 @@ bool bt_gatt_unregister_app(unsigned int id);
 
 bool bt_gatt_connect_app(unsigned int id, const bdaddr_t *addr);
 bool bt_gatt_disconnect_app(unsigned int id, const bdaddr_t *addr);
+
+void bt_gatt_set_security(const bdaddr_t *addr, int sec_level);
-- 
1.8.4

