Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC V3 09/12] event: Store link key infos in device info file
Date: Fri, 30 Nov 2012 15:47:03 +0100
Message-Id: <1354286826-24016-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/event.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/src/event.c b/src/event.c
index 7fc8f02..5e83c09 100644
--- a/src/event.c
+++ b/src/event.c
@@ -354,33 +354,68 @@ static int store_longtermkey(bdaddr_t *local, bdaddr_t *peer,
 	return err;
 }
 
+static void store_link_key(struct btd_adapter *adapter,
+				struct btd_device *device, uint8_t *key,
+				uint8_t type, uint8_t pin_length)
+{
+	char adapter_addr[18];
+	char device_addr[18];
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char key_str[35];
+	char *str;
+	int i;
+	gsize length = 0;
+
+	ba2str(adapter_get_address(adapter), adapter_addr);
+	ba2str(device_get_address(device), device_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
+								device_addr);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	key_str[0] = '0';
+	key_str[1] = 'x';
+	for (i = 0; i < 16; i++)
+		sprintf(key_str + 2 + (i * 2), "%2.2X", key[i]);
+
+	g_key_file_set_string(key_file, "LinkKey", "Key", key_str);
+
+	g_key_file_set_integer(key_file, "LinkKey", "Type", type);
+	g_key_file_set_integer(key_file, "LinkKey", "PINLength", pin_length);
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, str, length, NULL);
+	g_free(str);
+
+	g_key_file_free(key_file);
+}
+
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 				uint8_t *key, uint8_t key_type,
 				uint8_t pin_length)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
-	uint8_t peer_type;
-	int ret;
 
 	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
 		return -ENODEV;
 
 	DBG("storing link key of type 0x%02x", key_type);
 
-	peer_type = device_get_addr_type(device);
+	store_link_key(adapter, device, key, key_type, pin_length);
 
-	ret = write_link_key(local, peer, peer_type, key, key_type,
-								pin_length);
+	device_set_bonded(device, TRUE);
 
-	if (ret == 0) {
-		device_set_bonded(device, TRUE);
-
-		if (device_is_temporary(device))
-			device_set_temporary(device, FALSE);
-	}
+	if (device_is_temporary(device))
+		device_set_temporary(device, FALSE);
 
-	return ret;
+	return 0;
 }
 
 int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-- 
1.7.9.5

