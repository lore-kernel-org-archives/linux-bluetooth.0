Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/11] android/bluetooth: Add bt_device_set_uuids
Date: Fri, 13 Jun 2014 14:33:54 +0300
Message-Id: <1402659239-26558-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402659239-26558-1-git-send-email-luiz.dentz@gmail.com>
References: <1402659239-26558-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/bluetooth.c | 13 +++++++++++++
 android/bluetooth.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4ec7c7a..9d17faa 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1409,6 +1409,19 @@ bool bt_device_is_bonded(const bdaddr_t *bdaddr)
 	return false;
 }
 
+bool bt_device_set_uuids(const bdaddr_t *addr, GSList *uuids)
+{
+	struct device *dev;
+
+	dev = find_device(addr);
+	if (!dev)
+		return false;
+
+	set_device_uuids(dev, uuids);
+
+	return true;
+}
+
 static bool rssi_above_threshold(int old, int new)
 {
 	/* only 8 dBm or more */
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 7c64bab..eb50fe1 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -61,6 +61,7 @@ bool bt_is_device_le(const bdaddr_t *addr);
 
 const char *bt_get_adapter_name(void);
 bool bt_device_is_bonded(const bdaddr_t *bdaddr);
+bool bt_device_set_uuids(const bdaddr_t *bdaddr, GSList *uuids);
 
 typedef void (*bt_read_device_rssi_done)(uint8_t status, const bdaddr_t *addr,
 						int8_t rssi, void *user_data);
-- 
1.9.3

