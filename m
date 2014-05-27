Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 1/3] android: Add gatt CCC value storage
Date: Tue, 27 May 2014 16:33:41 +0200
Message-Id: <1401201223-17852-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401201223-17852-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401201223-17852-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Client Characteristic Configuration for Service Changed Characteristic
should be stored for every bonded device, so we know if we should be
sending value (range affected by changes) indication.
---
 android/bluetooth.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 android/bluetooth.h |  4 ++++
 2 files changed, 49 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 8ee2025..dea9be1 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -158,6 +158,7 @@ struct device {
 	bool valid_local_csrk;
 	uint8_t local_csrk[16];
 	uint32_t local_sign_cnt;
+	uint16_t gatt_ccc;
 };
 
 struct browse_req {
@@ -645,6 +646,44 @@ static void mgmt_dev_class_changed_event(uint16_t index, uint16_t length,
 	/* TODO: Gatt attrib set*/
 }
 
+void bt_store_gatt_ccc(const bdaddr_t *dst, uint16_t value)
+{
+	GKeyFile *key_file;
+	gsize length = 0;
+	char addr[18];
+	char *data;
+
+	key_file = g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL)) {
+		g_key_file_free(key_file);
+		return;
+	}
+
+	ba2str(dst, addr);
+
+	DBG("%s Gatt CCC %d", addr, value);
+
+	g_key_file_set_integer(key_file, addr, "GattCCC", value);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(DEVICES_FILE, data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
+}
+
+uint16_t bt_get_gatt_ccc(const bdaddr_t *addr)
+{
+	struct device *dev;
+
+	dev = find_device(addr);
+	if (!dev)
+		return 0;
+
+	return dev->gatt_ccc;
+}
+
 static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
 					uint8_t type, uint8_t pin_length)
 {
@@ -2408,6 +2447,12 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 						"RemoteCSRKSignCounter", NULL);
 	}
 
+	str = g_key_file_get_string(key_file, peer, "GattCCC", NULL);
+	if (str) {
+		dev->gatt_ccc = atoi(str);
+		g_free(str);
+	}
+
 	str = g_key_file_get_string(key_file, peer, "Name", NULL);
 	if (str) {
 		g_free(dev->name);
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 1c14377..b4a5f32 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -66,3 +66,7 @@ bool bt_get_csrk(const bdaddr_t *addr, enum bt_csrk_type type,
 					uint8_t key[16], uint32_t *sign_cnt);
 
 void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type);
+
+void bt_store_gatt_ccc(const bdaddr_t *addr, uint16_t value);
+
+uint16_t bt_get_gatt_ccc(const bdaddr_t *addr);
-- 
1.9.3

