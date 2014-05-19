Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 3/3] adapter: Improve handling of unpaired event
Date: Mon, 19 May 2014 12:16:06 +0200
Message-Id: <1400494566-8135-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400494566-8135-1-git-send-email-szymon.janc@tieto.com>
References: <1400494566-8135-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unpaired event is per bearer and and bluetoothd should unpair device
only on that bearer.
---
 src/adapter.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 5bc6990..1b72f1a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6336,6 +6336,42 @@ static void connect_failed_callback(uint16_t index, uint16_t length,
 		btd_adapter_remove_device(adapter, device);
 }
 
+static void remove_keys(struct btd_adapter *adapter,
+					struct btd_device *device, uint8_t type)
+{
+	char adapter_addr[18];
+	char device_addr[18];
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	gsize length = 0;
+	char *str;
+
+	ba2str(btd_adapter_get_address(adapter), adapter_addr);
+	ba2str(device_get_address(device), device_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
+								device_addr);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	if (type == BDADDR_BREDR) {
+		g_key_file_remove_group(key_file, "LinkKey", NULL);
+	} else {
+		g_key_file_remove_group(key_file, "LongTermKey", NULL);
+		g_key_file_remove_group(key_file, "LocalSignatureKey", NULL);
+		g_key_file_remove_group(key_file, "RemoteSignatureKey", NULL);
+		g_key_file_remove_group(key_file, "IdentityResolvingKey", NULL);
+	}
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, str, length, NULL);
+	g_free(str);
+
+	g_key_file_free(key_file);
+}
+
 static void unpaired_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -6360,6 +6396,17 @@ static void unpaired_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
+	remove_keys(adapter, device, ev->addr.type);
+	device_set_paired(device, ev->addr.type, false);
+
+	if (device_is_paired_any(device)) {
+		/* TODO disconnect only unpaired bearer */
+		if (btd_device_is_connected(device))
+			device_request_disconnect(device, NULL);
+
+		return;
+	}
+
 	btd_device_set_temporary(device, TRUE);
 
 	if (btd_device_is_connected(device))
-- 
1.9.1

