Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 09/12] android/bluetooth: Store sign counter needed for aes-cmac sign
Date: Thu, 22 May 2014 10:07:39 +0200
Message-Id: <1400746062-24766-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If CSRK is valid between sessions we should remember sign counter.
Therefor store it.
---
 android/bluetooth.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 83aae9f..082441f 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1877,8 +1877,6 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 
 	if (ev->store_hint)
 		store_csrk(dev);
-
-	/*TODO: Store sign counter */
 }
 
 static void register_mgmt_handlers(void)
@@ -2352,6 +2350,9 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 			sscanf(str + (i * 2), "%02hhX", &dev->local_csrk[i]);
 
 		g_free(str);
+
+		dev->local_sign_cnt = g_key_file_get_integer(key_file, peer,
+						"LocalCSRKSignCounter", NULL);
 	}
 
 	str = g_key_file_get_string(key_file, peer, "RemoteCSRK", NULL);
@@ -2363,6 +2364,9 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 			sscanf(str + (i * 2), "%02hhX", &dev->remote_csrk[i]);
 
 		g_free(str);
+
+		dev->remote_sign_cnt = g_key_file_get_integer(key_file, peer,
+						"RemoteCSRKSignCounter", NULL);
 	}
 
 	str = g_key_file_get_string(key_file, peer, "Name", NULL);
@@ -3333,6 +3337,37 @@ bool bt_get_csrk(const bdaddr_t *addr, enum bt_csrk_type type, uint8_t key[16],
 	return true;
 }
 
+static void store_sign_counter(struct device *dev, enum bt_csrk_type type)
+{
+	const char *sign_cnt_s;
+	uint32_t sign_cnt;
+	GKeyFile *key_file;
+	bool local = (type == LOCAL_CSRK);
+
+	gsize length = 0;
+	char addr[18];
+	char *data;
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL)) {
+		g_key_file_free(key_file);
+		return;
+	}
+
+	ba2str(&dev->bdaddr, addr);
+
+	sign_cnt_s = local ? "LocalCSRKSignCounter" : "RemoteCSRKSignCounter";
+	sign_cnt = local ? dev->local_sign_cnt : dev->remote_sign_cnt;
+
+	g_key_file_set_integer(key_file, addr, sign_cnt_s, sign_cnt);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(DEVICES_FILE, data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
+}
+
 void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type)
 {
 	struct device *dev;
@@ -3345,6 +3380,8 @@ void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type)
 		dev->local_sign_cnt++;
 	else
 		dev->remote_sign_cnt++;
+
+	store_sign_counter(dev, type);
 }
 
 static uint8_t set_adapter_scan_mode(const void *buf, uint16_t len)
-- 
1.8.4

