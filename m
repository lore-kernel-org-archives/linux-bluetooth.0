Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4] android/bluetooth: Enable LE privacy mode on BfA startup
Date: Thu, 18 Dec 2014 12:28:48 +0100
Message-Id: <1418902128-15766-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lets follow Android Lollipop behaviour and enable privacy on
startup.
---
v4: Rework all patches so now we have all in one. Because we set privacy always
we don't need to keep local irk in struct adapter. This is also way we could remove
some patches comparing to previous patch version.

 android/bluetooth.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 48085e9..ba4cf67 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -39,6 +39,7 @@
 #include "lib/sdp.h"
 #include "lib/mgmt.h"
 #include "lib/uuid.h"
+#include "src/shared/crypto.h"
 #include "src/shared/util.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
@@ -3371,6 +3372,103 @@ static void clear_auto_connect_list(void)
 	error("Could not clear auto connect list");
 }
 
+static void set_privacy_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS)
+		error("Failed to set privacy mode: %s (0x%02x)",
+						mgmt_errstr(status), status);
+}
+
+static void store_local_irk(const uint8_t *irk)
+{
+	GKeyFile *key_file;
+	char key_str[33];
+	int i;
+	gsize length = 0;
+	char *data;
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, SETTINGS_FILE, 0, NULL)) {
+		g_key_file_free(key_file);
+		return;
+	}
+
+	for (i = 0; i < 16; i++)
+		sprintf(key_str + (i * 2), "%2.2X", irk[i]);
+
+	g_key_file_set_string(key_file, "General", "IRK", key_str);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(SETTINGS_FILE, data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
+}
+
+static bool generate_irk(uint8_t *irk)
+{
+	struct bt_crypto *c;
+
+	c = bt_crypto_new();
+	if (!c) {
+		error("Could not create bt crypto and generate IRK");
+		return false;
+	}
+
+	bt_crypto_random_bytes(c, irk, 16);
+	bt_crypto_unref(c);
+
+	store_local_irk(irk);
+
+	return true;
+}
+
+static bool get_local_irk(uint8_t *irk)
+{
+	GKeyFile *key_file;
+	char *str;
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, SETTINGS_FILE, 0, NULL))
+		goto done;
+
+	str = g_key_file_get_string(key_file, "General", "IRK", NULL);
+	if (str) {
+		int i;
+
+		for (i = 0; i < 16; i++)
+			sscanf(str + (i * 2), "%02hhX", &irk[i]);
+
+		g_free(str);
+		g_key_file_free(key_file);
+
+		return true;
+	}
+
+done:
+	g_key_file_free(key_file);
+
+	return generate_irk(irk);
+}
+
+static void set_privacy(void)
+{
+	struct mgmt_cp_set_privacy cp;
+
+	if (!get_local_irk(cp.irk))
+		goto failed;
+
+	cp.privacy = 0x01;
+
+	if (mgmt_send(mgmt_if, MGMT_OP_SET_PRIVACY, adapter.index, sizeof(cp),
+				&cp, set_privacy_complete, NULL, NULL) > 0)
+		return;
+
+failed:
+	error("Could not set privacy mode");
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -3445,6 +3543,10 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	if (missing_settings & MGMT_SETTING_BONDABLE)
 		set_mode(MGMT_OP_SET_BONDABLE, 0x01);
 
+	/* TODO: Consider static random for LE only devices */
+	if (missing_settings & MGMT_SETTING_PRIVACY)
+		set_privacy();
+
 	load_devices_info(cb);
 	load_devices_cache();
 
-- 
1.8.4

