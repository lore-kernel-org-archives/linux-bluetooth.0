Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/6] android/bluetooth: Add support for CSRK authetication level
Date: Fri, 27 Feb 2015 16:01:11 +0100
Message-Id: <1425049274-11552-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
References: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to get information if CSRK is authenticated or not.
For client it is don't care if CSRK is authenticated or not.
---
 android/bluetooth.c | 35 ++++++++++++++++++++++-------------
 android/bluetooth.h | 12 +++---------
 android/gatt.c      |  8 ++++----
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index dca6f48..e684d31 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -4098,22 +4098,33 @@ bool bt_read_device_rssi(const bdaddr_t *addr, bt_read_device_rssi_done cb,
 	return true;
 }
 
-bool bt_get_csrk(const bdaddr_t *addr, enum bt_csrk_type type, uint8_t key[16],
-							uint32_t *sign_cnt)
+bool bt_get_csrk(const bdaddr_t *addr, bool local, uint8_t key[16],
+					uint32_t *sign_cnt, bool *authenticated)
 {
 	struct device *dev;
-	bool local = (type == LOCAL_CSRK);
 
 	dev = find_device(addr);
 	if (!dev)
 		return false;
 
 	if (local && dev->valid_local_csrk) {
-		memcpy(key, dev->local_csrk, 16);
-		*sign_cnt = dev->local_sign_cnt;
+		if (key)
+			memcpy(key, dev->local_csrk, 16);
+
+		if (sign_cnt)
+			*sign_cnt = dev->local_sign_cnt;
+
+		if (authenticated)
+			*authenticated = dev->local_csrk_auth;
 	} else if (!local && dev->valid_remote_csrk) {
-		memcpy(key, dev->remote_csrk, 16);
-		*sign_cnt = dev->remote_sign_cnt;
+		if (key)
+			memcpy(key, dev->remote_csrk, 16);
+
+		if (sign_cnt)
+			*sign_cnt = dev->remote_sign_cnt;
+
+		if (authenticated)
+			*authenticated = dev->remote_csrk_auth;
 	} else {
 		return false;
 	}
@@ -4121,12 +4132,11 @@ bool bt_get_csrk(const bdaddr_t *addr, enum bt_csrk_type type, uint8_t key[16],
 	return true;
 }
 
-static void store_sign_counter(struct device *dev, enum bt_csrk_type type)
+static void store_sign_counter(struct device *dev, bool local)
 {
 	const char *sign_cnt_s;
 	uint32_t sign_cnt;
 	GKeyFile *key_file;
-	bool local = (type == LOCAL_CSRK);
 
 	gsize length = 0;
 	char addr[18];
@@ -4152,8 +4162,7 @@ static void store_sign_counter(struct device *dev, enum bt_csrk_type type)
 	g_key_file_free(key_file);
 }
 
-void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type,
-								uint32_t val)
+void bt_update_sign_counter(const bdaddr_t *addr, bool local, uint32_t val)
 {
 	struct device *dev;
 
@@ -4161,12 +4170,12 @@ void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type,
 	if (!dev)
 		return;
 
-	if (type == LOCAL_CSRK)
+	if (local)
 		dev->local_sign_cnt = val;
 	else
 		dev->remote_sign_cnt = val;
 
-	store_sign_counter(dev, type);
+	store_sign_counter(dev, local);
 }
 
 static uint8_t set_adapter_scan_mode(const void *buf, uint16_t len)
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 9e7ab2c..8b8a1f0 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -21,11 +21,6 @@
  *
  */
 
-enum bt_csrk_type {
-	LOCAL_CSRK,
-	REMOTE_CSRK,
-};
-
 typedef void (*bt_bluetooth_ready)(int err, const bdaddr_t *addr);
 bool bt_bluetooth_start(int index, bool mgmt_dbg, bt_bluetooth_ready cb);
 
@@ -69,11 +64,10 @@ typedef void (*bt_read_device_rssi_done)(uint8_t status, const bdaddr_t *addr,
 bool bt_read_device_rssi(const bdaddr_t *addr, bt_read_device_rssi_done cb,
 							void *user_data);
 
-bool bt_get_csrk(const bdaddr_t *addr, enum bt_csrk_type type,
-					uint8_t key[16], uint32_t *sign_cnt);
+bool bt_get_csrk(const bdaddr_t *addr, bool local, uint8_t key[16],
+				uint32_t *sign_cnt, bool *authenticated);
 
-void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type,
-								uint32_t val);
+void bt_update_sign_counter(const bdaddr_t *addr, bool local, uint32_t val);
 
 void bt_store_gatt_ccc(const bdaddr_t *addr, uint16_t value);
 
diff --git a/android/gatt.c b/android/gatt.c
index 9e348d7..3f98e71 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3263,7 +3263,7 @@ static guint signed_write_cmd(struct gatt_device *dev, uint16_t handle,
 
 	memset(csrk, 0, 16);
 
-	if (!bt_get_csrk(&dev->bdaddr, LOCAL_CSRK, csrk, &sign_cnt)) {
+	if (!bt_get_csrk(&dev->bdaddr, true, csrk, &sign_cnt, NULL)) {
 		error("gatt: Could not get csrk key");
 		return 0;
 	}
@@ -3275,7 +3275,7 @@ static guint signed_write_cmd(struct gatt_device *dev, uint16_t handle,
 		return 0;
 	}
 
-	bt_update_sign_counter(&dev->bdaddr, LOCAL_CSRK, ++sign_cnt);
+	bt_update_sign_counter(&dev->bdaddr, true, ++sign_cnt);
 
 	return res;
 }
@@ -6396,7 +6396,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 		return;
 	}
 
-	if (!bt_get_csrk(&dev->bdaddr, REMOTE_CSRK, csrk, &sign_cnt)) {
+	if (!bt_get_csrk(&dev->bdaddr, false, csrk, &sign_cnt, NULL)) {
 		error("gatt: No valid csrk from remote device");
 		return;
 	}
@@ -6438,7 +6438,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 			return;
 		}
 		/* Signature OK, proceed with write */
-		bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, r_sign_cnt);
+		bt_update_sign_counter(&dev->bdaddr, false, r_sign_cnt);
 		gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
 						g_attrib_get_att(dev->attrib),
 						write_confirm, NULL);
-- 
1.9.3

