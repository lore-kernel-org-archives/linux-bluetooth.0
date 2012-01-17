Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 06/11] Add support for storing a LTK when it enters bluetoothd
Date: Tue, 17 Jan 2012 20:28:45 -0300
Message-Id: <1326842930-31623-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/event.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/event.h |    4 +++
 2 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/src/event.c b/src/event.c
index d0e192b..e1d49a1 100644
--- a/src/event.c
+++ b/src/event.c
@@ -345,6 +345,56 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 		device_set_name(device, name);
 }
 
+static char *buf2str(uint8_t *data, int datalen)
+{
+	char *buf;
+	int i;
+
+	buf = g_try_new0(char, (datalen * 2) + 1);
+	if (buf == NULL)
+		return NULL;
+
+	for (i = 0; i < datalen; i++)
+		sprintf(buf + (i * 2), "%2.2x", data[i]);
+
+	return buf;
+}
+
+static int store_longtermkey(bdaddr_t *local, bdaddr_t *peer,
+				addr_type_t addr_type, 	unsigned char *key,
+				uint8_t master, uint8_t authenticated,
+				uint8_t enc_size, uint16_t ediv, uint8_t rand[8])
+{
+	GString *newkey;
+	char *val, *str;
+	int err;
+
+	val = buf2str(key, 16);
+	if (val == NULL)
+		return -ENOMEM;
+
+	newkey = g_string_new(val);
+	g_free(val);
+
+	g_string_append_printf(newkey, " %d %d %d %d %d ", addr_type,
+					authenticated, master, enc_size, ediv);
+
+	str = buf2str(rand, 8);
+	if (str == NULL) {
+		g_string_free(newkey, TRUE);
+		return -ENOMEM;
+	}
+
+	newkey = g_string_append(newkey, str);
+	g_free(str);
+
+	err = write_longtermkeys(local, peer, newkey->str);
+
+	g_string_free(newkey, TRUE);
+
+	return err;
+}
+
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 				uint8_t *key, uint8_t key_type,
 				uint8_t pin_length)
@@ -370,6 +420,30 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 	return ret;
 }
 
+int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, addr_type_t addr_type,
+					uint8_t *key, uint8_t master,
+					uint8_t authenticated, uint8_t enc_size,
+					uint16_t ediv, 	uint8_t rand[8])
+{
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+	int ret;
+
+	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
+		return -ENODEV;
+
+	ret = store_longtermkey(local, peer, addr_type, key, master,
+					authenticated, enc_size, ediv, rand);
+	if (ret == 0) {
+		device_set_bonded(device, TRUE);
+
+		if (device_is_temporary(device))
+			device_set_temporary(device, FALSE);
+	}
+
+	return ret;
+}
+
 void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer,
 						char *name, uint8_t *dev_class)
 {
diff --git a/src/event.h b/src/event.h
index 57b7fd9..ec38e3e 100644
--- a/src/event.h
+++ b/src/event.h
@@ -42,3 +42,7 @@ void btd_event_device_blocked(bdaddr_t *local, bdaddr_t *peer);
 void btd_event_device_unblocked(bdaddr_t *local, bdaddr_t *peer);
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 					uint8_t key_type, uint8_t pin_length);
+int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, addr_type_t addr_type,
+					uint8_t *key, uint8_t master,
+					uint8_t authenticated, uint8_t enc_size,
+					uint16_t ediv, 	uint8_t rand[8]);
-- 
1.7.8.1

