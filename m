Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/5] Add stubs for storing SMP keys
Date: Tue,  7 Jun 2011 20:08:10 -0300
Message-Id: <1307488094-19464-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As we begin to support pairing over LE links, we need to store those
keys in permanent storage.

This patch changes the data types according to the current kernel interface
and adds new methods that will be used to store those keys. The documentation
of the Management API is updated to reflect this.
---
 doc/mgmt-api.txt  |    2 ++
 lib/mgmt.h        |    2 ++
 plugins/hciops.c  |    2 +-
 plugins/mgmtops.c |    5 +++--
 src/adapter.h     |    2 ++
 src/event.c       |   10 ++++++----
 src/event.h       |    2 +-
 src/storage.c     |    5 +++++
 src/storage.h     |    1 +
 9 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 353705e..97eb4d3 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -172,6 +172,8 @@ Load Keys Command
 					Type (1 Octet)
 					Value (16 Octets)
 					PIN_Length (1 Octet)
+					Data Length (1 Octet)
+					Data (Data Length Octets)
 				}
 				Key2 { }
 				...
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 57e7603..222dc1f 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -111,6 +111,8 @@ struct mgmt_key_info {
 	uint8_t type;
 	uint8_t val[16];
 	uint8_t pin_len;
+	uint8_t dlen;
+	uint8_t data[0];
 } __packed;
 
 #define MGMT_OP_LOAD_KEYS		0x000D
diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9b1225c..101e287 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -993,7 +993,7 @@ static void link_key_notify(int index, void *ptr)
 
 		err = btd_event_link_key_notify(&dev->bdaddr, dba,
 						evt->link_key, key_type,
-						dev->pin_length);
+						dev->pin_length, 0, NULL);
 
 		if (err == -ENODEV)
 			status = HCI_OE_LOW_RESOURCES;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 95de3d1..e950fff 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -407,8 +407,9 @@ static void mgmt_new_key(int sk, uint16_t index, void *buf, size_t len)
 
 	if (ev->store_hint)
 		btd_event_link_key_notify(&info->bdaddr, &ev->key.bdaddr,
-						ev->key.val, ev->key.type,
-						ev->key.pin_len);
+					ev->key.val, ev->key.type,
+					ev->key.pin_len, ev->key.dlen,
+					ev->key.data);
 
 	btd_event_bonding_complete(&info->bdaddr, &ev->key.bdaddr, 0);
 }
diff --git a/src/adapter.h b/src/adapter.h
index 3526849..a9e8102 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -61,6 +61,8 @@ struct link_key_info {
 	unsigned char key[16];
 	uint8_t type;
 	uint8_t pin_len;
+	uint8_t dlen;
+	uint8_t data[0];
 };
 
 struct remote_dev_info {
diff --git a/src/event.c b/src/event.c
index 0b43884..b258dda 100644
--- a/src/event.c
+++ b/src/event.c
@@ -395,9 +395,8 @@ proceed:
 	adapter_set_state(adapter, STATE_IDLE);
 }
 
-int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
-				uint8_t *key, uint8_t key_type,
-				uint8_t pin_length)
+int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
+		uint8_t key_type, uint8_t pin_length, int dlen, uint8_t *data)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
@@ -408,7 +407,10 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 
 	DBG("storing link key of type 0x%02x", key_type);
 
-	ret = write_link_key(local, peer, key, key_type, pin_length);
+	if (key_type < 0x10)
+		ret = write_link_key(local, peer, key, key_type, pin_length);
+	else
+		ret = write_longtermkeys(local, peer, NULL);
 
 	if (ret == 0 && device_is_temporary(device))
 		device_set_temporary(device, FALSE);
diff --git a/src/event.h b/src/event.h
index 22c199e..d83a04e 100644
--- a/src/event.h
+++ b/src/event.h
@@ -39,4 +39,4 @@ int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
 int btd_event_user_passkey(bdaddr_t *sba, bdaddr_t *dba);
 int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
-					uint8_t key_type, uint8_t pin_length);
+		uint8_t key_type, uint8_t pin_length, int dlen, uint8_t *data);
diff --git a/src/storage.c b/src/storage.c
index d416d75..786e24b 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1343,3 +1343,8 @@ device_type_t read_device_type(const bdaddr_t *sba, const bdaddr_t *dba)
 
 	return type;
 }
+
+int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key)
+{
+	return 0;
+}
diff --git a/src/storage.h b/src/storage.h
index 6929ada..923e819 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -87,6 +87,7 @@ int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data);
 int write_device_type(const bdaddr_t *sba, const bdaddr_t *dba,
 						device_type_t type);
 device_type_t read_device_type(const bdaddr_t *sba, const bdaddr_t *dba);
+int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key);
 
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
 
-- 
1.7.5.4

