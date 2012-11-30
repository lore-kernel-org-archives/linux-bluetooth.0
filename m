Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC V3 12/12] event: Store long term key infos in device info file
Date: Fri, 30 Nov 2012 15:47:06 +0100
Message-Id: <1354286826-24016-12-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/event.c |   89 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 46 insertions(+), 43 deletions(-)

diff --git a/src/event.c b/src/event.c
index 5e83c09..61fa0f4 100644
--- a/src/event.c
+++ b/src/event.c
@@ -304,54 +304,59 @@ void btd_event_remote_name(const bdaddr_t *local, bdaddr_t *peer,
 		device_set_name(device, name);
 }
 
-static char *buf2str(uint8_t *data, int datalen)
+static void store_longtermkey(bdaddr_t *local, bdaddr_t *peer,
+				uint8_t bdaddr_type, unsigned char *key,
+				uint8_t master, uint8_t authenticated,
+				uint8_t enc_size, uint16_t ediv,
+				uint8_t rand[8])
 {
-	char *buf;
+	char adapter_addr[18];
+	char device_addr[18];
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char key_str[35];
+	char rand_str[19];
+	char *str;
 	int i;
+	gsize length = 0;
 
-	buf = g_try_new0(char, (datalen * 2) + 1);
-	if (buf == NULL)
-		return NULL;
-
-	for (i = 0; i < datalen; i++)
-		sprintf(buf + (i * 2), "%2.2x", data[i]);
+	ba2str(local, adapter_addr);
+	ba2str(peer, device_addr);
 
-	return buf;
-}
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
+								device_addr);
+	filename[PATH_MAX] = '\0';
 
-static int store_longtermkey(bdaddr_t *local, bdaddr_t *peer,
-				uint8_t bdaddr_type, unsigned char *key,
-				uint8_t master, uint8_t authenticated,
-				uint8_t enc_size, uint16_t ediv, uint8_t rand[8])
-{
-	GString *newkey;
-	char *val, *str;
-	int err;
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	val = buf2str(key, 16);
-	if (val == NULL)
-		return -ENOMEM;
+	key_str[0] = '0';
+	key_str[1] = 'x';
+	for (i = 0; i < 16; i++)
+		sprintf(key_str + 2 + (i * 2), "%2.2X", key[i]);
 
-	newkey = g_string_new(val);
-	g_free(val);
+	g_key_file_set_string(key_file, "LongTermKey", "Key", key_str);
 
-	g_string_append_printf(newkey, " %d %d %d %d ", authenticated, master,
-								enc_size, ediv);
+	g_key_file_set_integer(key_file, "LongTermKey", "Authenticated",
+				authenticated);
+	g_key_file_set_integer(key_file, "LongTermKey", "Master", master);
+	g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
+	g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
 
-	str = buf2str(rand, 8);
-	if (str == NULL) {
-		g_string_free(newkey, TRUE);
-		return -ENOMEM;
-	}
+	rand_str[0] = '0';
+	rand_str[1] = 'x';
+	for (i = 0; i < 8; i++)
+		sprintf(rand_str + 2 + (i * 2), "%2.2X", rand[i]);
 
-	newkey = g_string_append(newkey, str);
-	g_free(str);
+	g_key_file_set_string(key_file, "LongTermKey", "Rand", rand_str);
 
-	err = write_longtermkeys(local, peer, bdaddr_type, newkey->str);
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	g_string_free(newkey, TRUE);
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, str, length, NULL);
+	g_free(str);
 
-	return err;
+	g_key_file_free(key_file);
 }
 
 static void store_link_key(struct btd_adapter *adapter,
@@ -425,21 +430,19 @@ int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
-	int ret;
 
 	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
 		return -ENODEV;
 
-	ret = store_longtermkey(local, peer, bdaddr_type, key, master,
+	store_longtermkey(local, peer, bdaddr_type, key, master,
 					authenticated, enc_size, ediv, rand);
-	if (ret == 0) {
-		device_set_bonded(device, TRUE);
 
-		if (device_is_temporary(device))
-			device_set_temporary(device, FALSE);
-	}
+	device_set_bonded(device, TRUE);
 
-	return ret;
+	if (device_is_temporary(device))
+		device_set_temporary(device, FALSE);
+
+	return 0;
 }
 
 void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-- 
1.7.9.5

