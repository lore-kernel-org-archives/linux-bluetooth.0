Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] android/bluetooth: Add support for storing link keys
Date: Wed, 18 Dec 2013 15:05:57 +0100
Message-Id: <1387375558-17976-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387375558-17976-1-git-send-email-szymon.janc@tieto.com>
References: <1387375558-17976-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When new linkkey event is received store linkkey in devices info file.
Stored info includes linkkey, linkkey type and pin length.
---
 android/bluetooth.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b8f078f..dd16a54 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -493,7 +493,35 @@ static void mgmt_dev_class_changed_event(uint16_t index, uint16_t length,
 static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
 					uint8_t type, uint8_t pin_length)
 {
-	/* TODO store link key */
+	GKeyFile *key_file;
+	char key_str[33];
+	gsize length = 0;
+	char addr[18];
+	char *data;
+	int i;
+
+	key_file = g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/devices",
+								0, NULL))
+		return;
+
+	ba2str(dst, addr);
+
+	DBG("%s type %u pin_len %u", addr, type, pin_length);
+
+	for (i = 0; i < 16; i++)
+		sprintf(key_str + (i * 2), "%2.2X", key[i]);
+
+	g_key_file_set_string(key_file, addr, "LinkKey", key_str);
+	g_key_file_set_integer(key_file, addr, "LinkKeyType", type);
+	g_key_file_set_integer(key_file, addr, "LinkKeyPINLength", pin_length);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(ANDROID_STORAGEDIR"/devices", data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
 }
 
 static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
@@ -720,6 +748,9 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
+	set_device_bond_state(&addr->bdaddr, HAL_STATUS_SUCCESS,
+							HAL_BOND_STATE_BONDED);
+
 	if (ev->store_hint) {
 		const struct mgmt_link_key_info *key = &ev->key;
 
@@ -727,9 +758,6 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 								key->pin_len);
 	}
 
-	set_device_bond_state(&addr->bdaddr, HAL_STATUS_SUCCESS,
-							HAL_BOND_STATE_BONDED);
-
 	browse_remote_sdp(&addr->bdaddr);
 }
 
-- 
1.8.3.2

