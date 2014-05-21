Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 09/12] android/bluetooth: Store sign counter needed for aes-cmac sign
Date: Wed, 21 May 2014 14:44:59 +0200
Message-Id: <1400676302-13626-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If CSRK is valid between sessions we should remember sign counter.
Therefor store it.
---
 android/bluetooth.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 0fe1e9a..d08161d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1876,8 +1876,6 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 
 	if (ev->store_hint)
 		store_csrk(dev);
-
-	/*TODO: Store sign counter */
 }
 
 static void register_mgmt_handlers(void)
@@ -2351,6 +2349,9 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 			sscanf(str + (i * 2), "%02hhX", &dev->local_csrk[i]);
 
 		g_free(str);
+
+		dev->local_sign_cnt = g_key_file_get_integer(key_file, peer,
+						"LocalCSRKSignCounter", NULL);
 	}
 
 	str = g_key_file_get_string(key_file, peer, "RemoteCSRK", NULL);
@@ -2362,6 +2363,9 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 			sscanf(str + (i * 2), "%02hhX", &dev->remote_csrk[i]);
 
 		g_free(str);
+
+		dev->remote_sign_cnt = g_key_file_get_integer(key_file, peer,
+						"RemoteCSRKSignCounter", NULL);
 	}
 
 	str = g_key_file_get_string(key_file, peer, "Name", NULL);
@@ -3331,6 +3335,36 @@ bool bt_get_csrk(const bdaddr_t *addr, bool local, uint8_t key[16],
 	return true;
 }
 
+static void store_sign_counter(struct device *dev, bool local)
+{
+	const char *sign_cnt_s;
+	uint32_t sign_cnt;
+	GKeyFile *key_file;
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
 void bt_update_sign_counter(const bdaddr_t *addr, bool local)
 {
 	struct device *dev;
@@ -3343,6 +3377,8 @@ void bt_update_sign_counter(const bdaddr_t *addr, bool local)
 		dev->local_sign_cnt++;
 	else
 		dev->remote_sign_cnt++;
+
+	store_sign_counter(dev, local);
 }
 
 static uint8_t set_adapter_scan_mode(const void *buf, uint16_t len)
-- 
1.8.4

