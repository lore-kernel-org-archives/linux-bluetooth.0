Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/6] event: Add type information to the mgmt "Device Connected" event
Date: Tue, 31 Jan 2012 14:10:48 -0300
Message-Id: <1328029853-21134-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the case of incomming connections we have to know the type of
the device that connected to us.

Through hciops we have the LE Connection Complete event, that
information was lost when Management interface was being used.
---
 plugins/hciops.c  |   30 +++++++++++++++++-------------
 plugins/mgmtops.c |   29 +++++++++++++++--------------
 src/device.c      |    8 ++++++++
 src/device.h      |    1 +
 src/event.c       |    4 +++-
 src/event.h       |    2 +-
 6 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index f4af637..be8b412 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2160,7 +2160,8 @@ static inline void conn_complete(int index, void *ptr)
 	conn = get_connection(dev, &evt->bdaddr);
 	conn->handle = btohs(evt->handle);
 
-	btd_event_conn_complete(&dev->bdaddr, &evt->bdaddr, NULL, NULL);
+	btd_event_conn_complete(&dev->bdaddr, &evt->bdaddr, ADDR_TYPE_BREDR,
+								NULL, NULL);
 
 	if (conn->secmode3)
 		bonding_complete(dev, conn, 0);
@@ -2179,6 +2180,17 @@ static inline void conn_complete(int index, void *ptr)
 		free(str);
 }
 
+static inline addr_type_t le_addr_type(uint8_t bdaddr_type)
+{
+	switch (bdaddr_type) {
+	case LE_RANDOM_ADDRESS:
+		return ADDR_TYPE_LE_RANDOM;
+	case LE_PUBLIC_ADDRESS:
+	default:
+		return ADDR_TYPE_LE_PUBLIC;
+	}
+}
+
 static inline void le_conn_complete(int index, void *ptr)
 {
 	struct dev_info *dev = &devs[index];
@@ -2186,6 +2198,7 @@ static inline void le_conn_complete(int index, void *ptr)
 	char filename[PATH_MAX];
 	char local_addr[18], peer_addr[18], *str;
 	struct bt_conn *conn;
+	addr_type_t type;
 
 	if (evt->status) {
 		btd_event_conn_failed(&dev->bdaddr, &evt->peer_bdaddr,
@@ -2196,7 +2209,9 @@ static inline void le_conn_complete(int index, void *ptr)
 	conn = get_connection(dev, &evt->peer_bdaddr);
 	conn->handle = btohs(evt->handle);
 
-	btd_event_conn_complete(&dev->bdaddr, &evt->peer_bdaddr, NULL, NULL);
+	type = le_addr_type(evt->peer_bdaddr_type);
+	btd_event_conn_complete(&dev->bdaddr, &evt->peer_bdaddr, type,
+								NULL, NULL);
 
 	/* check if the remote version needs be requested */
 	ba2str(&dev->bdaddr, local_addr);
@@ -2270,17 +2285,6 @@ static inline void conn_request(int index, void *ptr)
 	btd_event_remote_class(&dev->bdaddr, &evt->bdaddr, class);
 }
 
-static inline addr_type_t le_addr_type(uint8_t bdaddr_type)
-{
-	switch (bdaddr_type) {
-	case LE_RANDOM_ADDRESS:
-		return ADDR_TYPE_LE_RANDOM;
-	case LE_PUBLIC_ADDRESS:
-	default:
-		return ADDR_TYPE_LE_PUBLIC;
-	}
-}
-
 static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 {
 	struct dev_info *dev = &devs[index];
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index b409569..63af363 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -396,6 +396,20 @@ static void mgmt_new_link_key(int sk, uint16_t index, void *buf, size_t len)
 	bonding_complete(info, &ev->key.bdaddr, 0);
 }
 
+static inline addr_type_t mgmt_addr_type(uint8_t mgmt_addr_type)
+{
+	switch (mgmt_addr_type) {
+	case MGMT_ADDR_BREDR:
+		return ADDR_TYPE_BREDR;
+	case MGMT_ADDR_LE_PUBLIC:
+		return ADDR_TYPE_LE_PUBLIC;
+	case MGMT_ADDR_LE_RANDOM:
+		return ADDR_TYPE_LE_RANDOM;
+	default:
+		return ADDR_TYPE_BREDR;
+	}
+}
+
 static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_device_connected *ev = buf;
@@ -431,6 +445,7 @@ static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
 		eir_parse(&eir_data, ev->eir, eir_len);
 
 	btd_event_conn_complete(&info->bdaddr, &ev->addr.bdaddr,
+					mgmt_addr_type(ev->addr.type),
 					eir_data.name, eir_data.dev_class);
 }
 
@@ -1257,20 +1272,6 @@ static void mgmt_local_name_changed(int sk, uint16_t index, void *buf, size_t le
 		adapter_name_changed(adapter, (char *) ev->name);
 }
 
-static inline addr_type_t mgmt_addr_type(uint8_t mgmt_addr_type)
-{
-	switch (mgmt_addr_type) {
-	case MGMT_ADDR_BREDR:
-		return ADDR_TYPE_BREDR;
-	case MGMT_ADDR_LE_PUBLIC:
-		return ADDR_TYPE_LE_PUBLIC;
-	case MGMT_ADDR_LE_RANDOM:
-		return ADDR_TYPE_LE_RANDOM;
-	default:
-		return ADDR_TYPE_BREDR;
-	}
-}
-
 static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_device_found *ev = buf;
diff --git a/src/device.c b/src/device.c
index c19acd4..d39ca53 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2005,6 +2005,14 @@ void device_get_address(struct btd_device *device, bdaddr_t *bdaddr,
 		*type = device->type;
 }
 
+void device_set_addr_type(struct btd_device *device, addr_type_t type)
+{
+	if (device == NULL)
+		return;
+
+	device->type = type;
+}
+
 const gchar *device_get_path(struct btd_device *device)
 {
 	if (!device)
diff --git a/src/device.h b/src/device.h
index 13005ae..7cb9bb2 100644
--- a/src/device.h
+++ b/src/device.h
@@ -59,6 +59,7 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
 void device_get_address(struct btd_device *device, bdaddr_t *bdaddr,
 							addr_type_t *type);
+void device_set_addr_type(struct btd_device *device, addr_type_t type);
 const gchar *device_get_path(struct btd_device *device);
 struct agent *device_get_agent(struct btd_device *device);
 gboolean device_is_bredr(struct btd_device *device);
diff --git a/src/event.c b/src/event.c
index 0783b47..ff1896a 100644
--- a/src/event.c
+++ b/src/event.c
@@ -442,7 +442,7 @@ int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, addr_type_t addr_type,
 	return ret;
 }
 
-void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer,
+void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
 						char *name, uint8_t *dev_class)
 {
 	struct btd_adapter *adapter;
@@ -453,6 +453,8 @@ void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer,
 
 	update_lastused(local, peer);
 
+	device_set_addr_type(device, type);
+
 	adapter_add_connection(adapter, device);
 
 	if (name != NULL)
diff --git a/src/event.h b/src/event.h
index ccdd47c..c09350d 100644
--- a/src/event.h
+++ b/src/event.h
@@ -29,7 +29,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
 void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
-void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer,
+void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
 					char *name, uint8_t *dev_class);
 void btd_event_conn_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
 void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer);
-- 
1.7.8.1

