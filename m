Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 05/12] Add support for storing the SMP Long Term Key
Date: Fri, 19 Aug 2011 21:12:01 -0300
Message-Id: <1313799128-8842-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for receiving keys with arbitrary data following
it, this is because for SMP we may have different types of keys that
have different kind of data associated with them.

And we keep that associated data opaque, as only the communication
functions need to be aware of its contents, for storage there's no
need to export that information.
---
 plugins/hciops.c  |    2 +-
 plugins/mgmtops.c |    3 +-
 src/event.c       |   64 +++++++++++++++++++++++++++++++++++++++++++++++++---
 src/event.h       |    3 +-
 4 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 43f4f02..869a814 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -996,7 +996,7 @@ static void link_key_notify(int index, void *ptr)
 
 		err = btd_event_link_key_notify(&dev->bdaddr, dba,
 						evt->link_key, key_type,
-						dev->pin_length);
+						dev->pin_length, NULL, 0);
 
 		if (err == -ENODEV)
 			status = HCI_OE_LOW_RESOURCES;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 3cdb97e..bf9e9af 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -408,7 +408,8 @@ static void mgmt_new_key(int sk, uint16_t index, void *buf, size_t len)
 	if (ev->store_hint)
 		btd_event_link_key_notify(&info->bdaddr, &ev->key.bdaddr,
 						ev->key.val, ev->key.type,
-						ev->key.pin_len);
+						ev->key.pin_len, NULL, 0);
+
 
 	btd_event_bonding_complete(&info->bdaddr, &ev->key.bdaddr, 0);
 }
diff --git a/src/event.c b/src/event.c
index dc45bd3..ade882e 100644
--- a/src/event.c
+++ b/src/event.c
@@ -385,9 +385,48 @@ proceed:
 	adapter_set_state(adapter, STATE_IDLE);
 }
 
-int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
-				uint8_t *key, uint8_t key_type,
-				uint8_t pin_length)
+static gchar *buf2str(uint8_t *data, int datalen)
+{
+	char *buf;
+	int i;
+
+	buf = g_try_new0(gchar, (datalen * 2) + 1);
+	if (buf == NULL)
+		return NULL;
+
+	for (i = 0; i < datalen; i++)
+		sprintf(buf + (i * 2), "%2.2x", data[i]);
+
+	return buf;
+}
+
+static int store_longtermkey(bdaddr_t *local, bdaddr_t *peer, unsigned char *key,
+			uint8_t type, int length, int dlen, uint8_t *data)
+{
+	GString *newkey;
+	char *val, *str;
+	int err;
+
+	val = buf2str(key, 16);
+	newkey = g_string_new(val);
+	g_free(val);
+
+	g_string_append_printf(newkey, " %d %d %d ", type, length, dlen);
+
+	str = buf2str(data, dlen);
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
+int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
+					uint8_t key_type, uint8_t pin_length,
+					uint8_t *data, int dlen)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
@@ -398,7 +437,24 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 
 	DBG("storing link key of type 0x%02x", key_type);
 
-	ret = write_link_key(local, peer, key, key_type, pin_length);
+	switch (key_type) {
+	case HCI_LK_COMBINATION:
+	case HCI_LK_LOCAL_UNIT:
+	case HCI_LK_REMOTE_UNIT:
+	case HCI_LK_DEBUG_COMBINATION:
+	case HCI_LK_UNAUTH_COMBINATION:
+	case HCI_LK_AUTH_COMBINATION:
+	case HCI_LK_CHANGED_COMBINATION:
+		ret = write_link_key(local, peer, key, key_type, pin_length);
+		break;
+	case HCI_LK_SMP_LTK:
+		ret = store_longtermkey(local, peer, key, key_type, pin_length,
+								dlen, data);
+		break;
+	default:
+		ret = -ENOTSUP;
+		break;
+	}
 
 	if (ret == 0) {
 		device_set_bonded(device, TRUE);
diff --git a/src/event.h b/src/event.h
index 1268edf..5047db1 100644
--- a/src/event.h
+++ b/src/event.h
@@ -39,4 +39,5 @@ int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
 int btd_event_user_passkey(bdaddr_t *sba, bdaddr_t *dba);
 int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
-					uint8_t key_type, uint8_t pin_length);
+					uint8_t key_type, uint8_t pin_length,
+					uint8_t *data, int dlen);
-- 
1.7.6

