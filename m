Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 5/7] Remove addr_type_t definition from adapter.h
Date: Tue, 24 Apr 2012 22:42:29 -0300
Message-Id: <1335318151-21063-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1335318151-21063-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1335318151-21063-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces addr_type_t by the new Bluetooth address type
constants defined in bluetooth.h
---
 plugins/hciops.c  |   51 ++++++++++++++++++++------------------
 plugins/mgmtops.c |   51 +++++++++++++++++++-------------------
 src/adapter.c     |   70 +++++++++++++++++++++++++++-------------------------
 src/adapter.h     |   44 ++++++++++++++-------------------
 src/device.c      |   62 +++++++++++++++++++++++-----------------------
 src/device.h      |    6 ++--
 src/event.c       |   29 +++++++++++----------
 src/event.h       |    6 ++--
 8 files changed, 160 insertions(+), 159 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index ef444da..678ca1b 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1242,7 +1242,7 @@ static void return_link_keys(int index, void *ptr)
 
 /* Simple Pairing handling */
 
-static int hciops_confirm_reply(int index, bdaddr_t *bdaddr, addr_type_t type,
+static int hciops_confirm_reply(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean success)
 {
 	struct dev_info *dev = &devs[index];
@@ -1305,7 +1305,7 @@ static void user_confirm_request(int index, void *ptr)
 		usleep(5000);
 
 		if (hciops_confirm_reply(index, &req->bdaddr,
-						ADDR_TYPE_BREDR, TRUE) < 0)
+						BDADDR_BREDR, TRUE) < 0)
 			goto fail;
 
 		return;
@@ -2070,7 +2070,7 @@ static inline void remote_version_information(int index, void *ptr)
 				btohs(evt->lmp_subver));
 }
 
-static void dev_found(struct dev_info *info, bdaddr_t *dba, addr_type_t type,
+static void dev_found(struct dev_info *info, bdaddr_t *dba, uint8_t bdaddr_type,
 				uint8_t *cod, int8_t rssi, uint8_t cfm_name,
 				uint8_t *eir, size_t eir_len)
 {
@@ -2098,7 +2098,7 @@ static void dev_found(struct dev_info *info, bdaddr_t *dba, addr_type_t type,
 	info->found_devs = g_slist_prepend(info->found_devs, dev);
 
 event:
-	btd_event_device_found(&info->bdaddr, dba, type, rssi, cfm_name,
+	btd_event_device_found(&info->bdaddr, dba, bdaddr_type, rssi, cfm_name,
 								eir, eir_len);
 }
 
@@ -2113,7 +2113,7 @@ static inline void inquiry_result(int index, int plen, void *ptr)
 		uint8_t eir[5];
 
 		memset(eir, 0, sizeof(eir));
-		dev_found(dev, &info->bdaddr, ADDR_TYPE_BREDR, info->dev_class,
+		dev_found(dev, &info->bdaddr, BDADDR_BREDR, info->dev_class,
 								0, 1, eir, 0);
 		ptr += INQUIRY_INFO_SIZE;
 	}
@@ -2134,7 +2134,7 @@ static inline void inquiry_result_with_rssi(int index, int plen, void *ptr)
 			inquiry_info_with_rssi_and_pscan_mode *info = ptr;
 
 			memset(eir, 0, sizeof(eir));
-			dev_found(dev, &info->bdaddr, ADDR_TYPE_BREDR,
+			dev_found(dev, &info->bdaddr, BDADDR_BREDR,
 						info->dev_class, info->rssi,
 						1, eir, 0);
 			ptr += INQUIRY_INFO_WITH_RSSI_AND_PSCAN_MODE_SIZE;
@@ -2144,7 +2144,7 @@ static inline void inquiry_result_with_rssi(int index, int plen, void *ptr)
 			inquiry_info_with_rssi *info = ptr;
 
 			memset(eir, 0, sizeof(eir));
-			dev_found(dev, &info->bdaddr, ADDR_TYPE_BREDR,
+			dev_found(dev, &info->bdaddr, BDADDR_BREDR,
 						info->dev_class, info->rssi,
 						1, eir, 0);
 			ptr += INQUIRY_INFO_WITH_RSSI_SIZE;
@@ -2174,7 +2174,7 @@ static inline void extended_inquiry_result(int index, int plen, void *ptr)
 		else
 			cfm_name = TRUE;
 
-		dev_found(dev, &info->bdaddr, ADDR_TYPE_BREDR, info->dev_class,
+		dev_found(dev, &info->bdaddr, BDADDR_BREDR, info->dev_class,
 					info->rssi, cfm_name, eir, eir_len);
 		ptr += EXTENDED_INQUIRY_INFO_SIZE;
 	}
@@ -2280,7 +2280,7 @@ static inline void conn_complete(int index, void *ptr)
 	conn = get_connection(dev, &evt->bdaddr);
 	conn->handle = btohs(evt->handle);
 
-	btd_event_conn_complete(&dev->bdaddr, &evt->bdaddr, ADDR_TYPE_BREDR,
+	btd_event_conn_complete(&dev->bdaddr, &evt->bdaddr, BDADDR_BREDR,
 								NULL, NULL);
 
 	if (conn->secmode3)
@@ -2300,14 +2300,14 @@ static inline void conn_complete(int index, void *ptr)
 		free(str);
 }
 
-static inline addr_type_t le_addr_type(uint8_t bdaddr_type)
+static inline uint8_t le_addr_type(uint8_t bdaddr_type)
 {
 	switch (bdaddr_type) {
 	case LE_RANDOM_ADDRESS:
-		return ADDR_TYPE_LE_RANDOM;
+		return BDADDR_LE_RANDOM;
 	case LE_PUBLIC_ADDRESS:
 	default:
-		return ADDR_TYPE_LE_PUBLIC;
+		return BDADDR_LE_PUBLIC;
 	}
 }
 
@@ -2318,7 +2318,7 @@ static inline void le_conn_complete(int index, void *ptr)
 	char filename[PATH_MAX];
 	char local_addr[18], peer_addr[18], *str;
 	struct bt_conn *conn;
-	addr_type_t type;
+	uint8_t bdaddr_type;
 
 	if (evt->status) {
 		btd_event_conn_failed(&dev->bdaddr, &evt->peer_bdaddr,
@@ -2329,8 +2329,8 @@ static inline void le_conn_complete(int index, void *ptr)
 	conn = get_connection(dev, &evt->peer_bdaddr);
 	conn->handle = btohs(evt->handle);
 
-	type = le_addr_type(evt->peer_bdaddr_type);
-	btd_event_conn_complete(&dev->bdaddr, &evt->peer_bdaddr, type,
+	bdaddr_type = le_addr_type(evt->peer_bdaddr_type);
+	btd_event_conn_complete(&dev->bdaddr, &evt->peer_bdaddr, bdaddr_type,
 								NULL, NULL);
 
 	/* check if the remote version needs be requested */
@@ -3380,7 +3380,8 @@ static int hciops_read_bdaddr(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int hciops_block_device(int index, bdaddr_t *bdaddr, addr_type_t type)
+static int hciops_block_device(int index, bdaddr_t *bdaddr,
+						uint8_t bdaddr_type)
 {
 	struct dev_info *dev = &devs[index];
 	char addr[18];
@@ -3394,7 +3395,8 @@ static int hciops_block_device(int index, bdaddr_t *bdaddr, addr_type_t type)
 	return 0;
 }
 
-static int hciops_unblock_device(int index, bdaddr_t *bdaddr, addr_type_t type)
+static int hciops_unblock_device(int index, bdaddr_t *bdaddr,
+						uint8_t bdaddr_type)
 {
 	struct dev_info *dev = &devs[index];
 	char addr[18];
@@ -3427,14 +3429,15 @@ static int hciops_get_conn_list(int index, GSList **conns)
 	return 0;
 }
 
-static int hciops_disconnect(int index, bdaddr_t *bdaddr, addr_type_t type)
+static int hciops_disconnect(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	DBG("hci%d", index);
 
 	return disconnect_addr(index, bdaddr, HCI_OE_USER_ENDED_CONNECTION);
 }
 
-static int hciops_remove_bonding(int index, bdaddr_t *bdaddr, addr_type_t type)
+static int hciops_remove_bonding(int index, bdaddr_t *bdaddr,
+							uint8_t bdaddr_type)
 {
 	struct dev_info *dev = &devs[index];
 	delete_stored_link_key_cp cp;
@@ -3493,8 +3496,8 @@ static int hciops_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin,
 	return err;
 }
 
-static int hciops_passkey_reply(int index, bdaddr_t *bdaddr, addr_type_t type,
-							uint32_t passkey)
+static int hciops_passkey_reply(int index, bdaddr_t *bdaddr,
+					uint8_t bdaddr_type, uint32_t passkey)
 {
 	struct dev_info *dev = &devs[index];
 	char addr[18];
@@ -3726,7 +3729,7 @@ failed:
 }
 
 static int hciops_create_bonding(int index, bdaddr_t *bdaddr,
-					uint8_t addr_type, uint8_t io_cap)
+					uint8_t bdaddr_type, uint8_t io_cap)
 {
 	struct dev_info *dev = &devs[index];
 	BtIOSecLevel sec_level;
@@ -3846,8 +3849,8 @@ static int hciops_remove_remote_oob_data(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int hciops_confirm_name(int index, bdaddr_t *bdaddr, addr_type_t type,
-							gboolean name_known)
+static int hciops_confirm_name(int index, bdaddr_t *bdaddr,
+				uint8_t bdaddr_type, gboolean name_known)
 {
 	struct dev_info *info = &devs[index];
 	struct found_dev *dev;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 5663ef7..9ff1a75 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -463,28 +463,28 @@ static void mgmt_new_link_key(int sk, uint16_t index, void *buf, size_t len)
 	bonding_complete(info, &ev->key.addr.bdaddr, 0);
 }
 
-static inline addr_type_t addr_type(uint8_t mgmt_addr_type)
+static inline uint8_t addr_type(uint8_t mgmt_addr_type)
 {
 	switch (mgmt_addr_type) {
 	case MGMT_ADDR_BREDR:
-		return ADDR_TYPE_BREDR;
+		return BDADDR_BREDR;
 	case MGMT_ADDR_LE_PUBLIC:
-		return ADDR_TYPE_LE_PUBLIC;
+		return BDADDR_LE_PUBLIC;
 	case MGMT_ADDR_LE_RANDOM:
-		return ADDR_TYPE_LE_RANDOM;
+		return BDADDR_LE_RANDOM;
 	default:
-		return ADDR_TYPE_BREDR;
+		return BDADDR_BREDR;
 	}
 }
 
-static inline uint8_t mgmt_addr_type(addr_type_t addr_type)
+static inline uint8_t mgmt_addr_type(uint8_t addr_type)
 {
 	switch (addr_type) {
-	case ADDR_TYPE_BREDR:
+	case BDADDR_BREDR:
 		return MGMT_ADDR_BREDR;
-	case ADDR_TYPE_LE_PUBLIC:
+	case BDADDR_LE_PUBLIC:
 		return MGMT_ADDR_LE_PUBLIC;
-	case ADDR_TYPE_LE_RANDOM:
+	case BDADDR_LE_RANDOM:
 		return MGMT_ADDR_LE_RANDOM;
 	default:
 		return MGMT_ADDR_BREDR;
@@ -668,7 +668,7 @@ static void mgmt_pin_code_request(int sk, uint16_t index, void *buf, size_t len)
 	}
 }
 
-static int mgmt_confirm_reply(int index, bdaddr_t *bdaddr, addr_type_t type,
+static int mgmt_confirm_reply(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean success)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_user_confirm_reply)];
@@ -691,7 +691,7 @@ static int mgmt_confirm_reply(int index, bdaddr_t *bdaddr, addr_type_t type,
 
 	cp = (void *) &buf[sizeof(*hdr)];
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(type);
+	cp->addr.type = mgmt_addr_type(bdaddr_type);
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
 		return -errno;
@@ -699,7 +699,7 @@ static int mgmt_confirm_reply(int index, bdaddr_t *bdaddr, addr_type_t type,
 	return 0;
 }
 
-static int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, addr_type_t type,
+static int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							uint32_t passkey)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_user_passkey_reply)];
@@ -721,7 +721,7 @@ static int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, addr_type_t type,
 
 		cp = (void *) &buf[sizeof(*hdr)];
 		bacpy(&cp->addr.bdaddr, bdaddr);
-		cp->addr.type = mgmt_addr_type(type);
+		cp->addr.type = mgmt_addr_type(bdaddr_type);
 
 		buf_len = sizeof(*hdr) + sizeof(*cp);
 	} else {
@@ -732,7 +732,7 @@ static int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, addr_type_t type,
 
 		cp = (void *) &buf[sizeof(*hdr)];
 		bacpy(&cp->addr.bdaddr, bdaddr);
-		cp->addr.type = mgmt_addr_type(type);
+		cp->addr.type = mgmt_addr_type(bdaddr_type);
 		cp->passkey = htobl(passkey);
 
 		buf_len = sizeof(*hdr) + sizeof(*cp);
@@ -2015,7 +2015,7 @@ static int mgmt_read_bdaddr(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int mgmt_block_device(int index, bdaddr_t *bdaddr, addr_type_t type)
+static int mgmt_block_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_block_device)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -2034,7 +2034,7 @@ static int mgmt_block_device(int index, bdaddr_t *bdaddr, addr_type_t type)
 
 	cp = (void *) &buf[sizeof(*hdr)];
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(type);
+	cp->addr.type = mgmt_addr_type(bdaddr_type);
 
 	buf_len = sizeof(*hdr) + sizeof(*cp);
 
@@ -2044,7 +2044,8 @@ static int mgmt_block_device(int index, bdaddr_t *bdaddr, addr_type_t type)
 	return 0;
 }
 
-static int mgmt_unblock_device(int index, bdaddr_t *bdaddr, addr_type_t type)
+static int mgmt_unblock_device(int index, bdaddr_t *bdaddr,
+							uint8_t bdaddr_type)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_unblock_device)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -2063,7 +2064,7 @@ static int mgmt_unblock_device(int index, bdaddr_t *bdaddr, addr_type_t type)
 
 	cp = (void *) &buf[sizeof(*hdr)];
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(type);
+	cp->addr.type = mgmt_addr_type(bdaddr_type);
 
 	buf_len = sizeof(*hdr) + sizeof(*cp);
 
@@ -2085,7 +2086,7 @@ static int mgmt_get_conn_list(int index, GSList **conns)
 	return 0;
 }
 
-static int mgmt_disconnect(int index, bdaddr_t *bdaddr, addr_type_t type)
+static int mgmt_disconnect(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_disconnect)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -2101,7 +2102,7 @@ static int mgmt_disconnect(int index, bdaddr_t *bdaddr, addr_type_t type)
 	hdr->index = htobs(index);
 
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(type);
+	cp->addr.type = mgmt_addr_type(bdaddr_type);
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
 		error("write: %s (%d)", strerror(errno), errno);
@@ -2109,7 +2110,7 @@ static int mgmt_disconnect(int index, bdaddr_t *bdaddr, addr_type_t type)
 	return 0;
 }
 
-static int mgmt_unpair_device(int index, bdaddr_t *bdaddr, addr_type_t type)
+static int mgmt_unpair_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_unpair_device)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -2125,7 +2126,7 @@ static int mgmt_unpair_device(int index, bdaddr_t *bdaddr, addr_type_t type)
 	hdr->index = htobs(index);
 
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(type);
+	cp->addr.type = mgmt_addr_type(bdaddr_type);
 	cp->disconnect = 1;
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
@@ -2370,7 +2371,7 @@ static int mgmt_remove_remote_oob_data(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int mgmt_confirm_name(int index, bdaddr_t *bdaddr, addr_type_t type,
+static int mgmt_confirm_name(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean name_known)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_confirm_name)];
@@ -2388,7 +2389,7 @@ static int mgmt_confirm_name(int index, bdaddr_t *bdaddr, addr_type_t type,
 	hdr->len = htobs(sizeof(*cp));
 
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(type);
+	cp->addr.type = mgmt_addr_type(bdaddr_type);
 	cp->name_known = name_known;
 
 	if (write(mgmt_sock, &buf, sizeof(buf)) < 0)
@@ -2429,7 +2430,7 @@ static int mgmtops_load_ltks(int index, GSList *keys)
 		struct smp_ltk_info *info = l->data;
 
 		bacpy(&key->addr.bdaddr, &info->bdaddr);
-		key->addr.type = info->addr_type;
+		key->addr.type = info->bdaddr_type;
 		memcpy(key->val, info->val, sizeof(info->val));
 		memcpy(key->rand, info->rand, sizeof(info->rand));
 		memcpy(&key->ediv, &info->ediv, sizeof(key->ediv));
diff --git a/src/adapter.c b/src/adapter.c
index 94df0a2..93b55e8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -472,7 +472,7 @@ static GSList *remove_bredr(GSList *all)
 
 	for (l = all, le = NULL; l; l = l->next) {
 		struct remote_dev_info *dev = l->data;
-		if (dev->type == ADDR_TYPE_BREDR) {
+		if (dev->bdaddr_type == BDADDR_BREDR) {
 			dev_info_free(dev);
 			continue;
 		}
@@ -926,14 +926,14 @@ void adapter_service_remove(struct btd_adapter *adapter, void *r)
 static struct btd_device *adapter_create_device(DBusConnection *conn,
 						struct btd_adapter *adapter,
 						const char *address,
-						addr_type_t type)
+						uint8_t bdaddr_type)
 {
 	struct btd_device *device;
 	const char *path;
 
 	DBG("%s", address);
 
-	device = device_create(conn, adapter, address, type);
+	device = device_create(conn, adapter, address, bdaddr_type);
 	if (!device)
 		return NULL;
 
@@ -993,7 +993,7 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 		return device;
 
 	return adapter_create_device(conn, adapter, address,
-						ADDR_TYPE_BREDR);
+						BDADDR_BREDR);
 }
 
 static gboolean discovery_cb(gpointer user_data)
@@ -1386,17 +1386,17 @@ static struct btd_device *create_device_internal(DBusConnection *conn,
 	struct remote_dev_info *dev;
 	struct btd_device *device;
 	bdaddr_t addr;
-	addr_type_t type;
+	uint8_t bdaddr_type;
 
 	str2ba(address, &addr);
 
 	dev = adapter_search_found_devices(adapter, &addr);
 	if (dev)
-		type = dev->type;
+		bdaddr_type = dev->bdaddr_type;
 	else
-		type = ADDR_TYPE_BREDR;
+		bdaddr_type = BDADDR_BREDR;
 
-	device = adapter_create_device(conn, adapter, address, type);
+	device = adapter_create_device(conn, adapter, address, bdaddr_type);
 	if (!device && err)
 		*err = -ENOMEM;
 
@@ -1705,7 +1705,7 @@ static void create_stored_device_from_profiles(char *key, char *value,
 				key, (GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key, ADDR_TYPE_BREDR);
+	device = device_create(connection, adapter, key, BDADDR_BREDR);
 	if (!device)
 		return;
 
@@ -1792,7 +1792,7 @@ static struct smp_ltk_info *get_ltk_info(const char *addr, const char *value)
 	ptr = (char *) value + 2 * sizeof(ltk->val) + 1;
 
 	ret = sscanf(ptr, " %hhd %hhd %hhd %hhd %hd %n",
-					(uint8_t *) &ltk->addr_type,
+					(uint8_t *) &ltk->bdaddr_type,
 					&ltk->authenticated, &ltk->master,
 					&ltk->enc_size, &ltk->ediv, &i);
 	if (ret < 2) {
@@ -1822,7 +1822,7 @@ static void create_stored_device_from_linkkeys(char *key, char *value,
 					(GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key, ADDR_TYPE_BREDR);
+	device = device_create(connection, adapter, key, BDADDR_BREDR);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
@@ -1855,7 +1855,7 @@ static void create_stored_device_from_ltks(char *key, char *value,
 	if (g_strcmp0(srcaddr, key) == 0)
 		return;
 
-	device = device_create(connection, adapter, key, info->addr_type);
+	device = device_create(connection, adapter, key, info->bdaddr_type);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
@@ -1872,7 +1872,7 @@ static void create_stored_device_from_blocked(char *key, char *value,
 				key, (GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key, ADDR_TYPE_BREDR);
+	device = device_create(connection, adapter, key, BDADDR_BREDR);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
@@ -1926,7 +1926,7 @@ static void create_stored_device_from_primary(char *key, char *value,
 		return;
 
 	/* FIXME: Get the correct LE addr type (public/random) */
-	device = device_create(connection, adapter, key, ADDR_TYPE_LE_PUBLIC);
+	device = device_create(connection, adapter, key, BDADDR_LE_PUBLIC);
 	if (!device)
 		return;
 
@@ -2000,15 +2000,16 @@ static void load_devices(struct btd_adapter *adapter)
 }
 
 int btd_adapter_block_address(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							addr_type_t type)
+							uint8_t bdaddr_type)
 {
-	return adapter_ops->block_device(adapter->dev_id, bdaddr, type);
+	return adapter_ops->block_device(adapter->dev_id, bdaddr, bdaddr_type);
 }
 
 int btd_adapter_unblock_address(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							addr_type_t type)
+							uint8_t bdaddr_type)
 {
-	return adapter_ops->unblock_device(adapter->dev_id, bdaddr, type);
+	return adapter_ops->unblock_device(adapter->dev_id, bdaddr,
+								bdaddr_type);
 }
 
 static void clear_blocked(struct btd_adapter *adapter)
@@ -2699,7 +2700,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	} else
 		alias = g_strdup(dev->alias);
 
-	if (dev->type != ADDR_TYPE_BREDR) {
+	if (dev->bdaddr_type != BDADDR_BREDR) {
 		gboolean broadcaster;
 		uint16_t app;
 
@@ -2749,7 +2750,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 }
 
 static struct remote_dev_info *found_device_new(const bdaddr_t *bdaddr,
-					addr_type_t type, const char *name,
+					uint8_t bdaddr_type, const char *name,
 					const char *alias, uint32_t class,
 					gboolean legacy, int flags)
 {
@@ -2757,7 +2758,7 @@ static struct remote_dev_info *found_device_new(const bdaddr_t *bdaddr,
 
 	dev = g_new0(struct remote_dev_info, 1);
 	bacpy(&dev->bdaddr, bdaddr);
-	dev->type = type;
+	dev->bdaddr_type = bdaddr_type;
 	dev->name = g_strdup(name);
 	dev->alias = g_strdup(alias);
 	dev->class = class;
@@ -2826,7 +2827,7 @@ static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer, const char *file)
 }
 
 void adapter_update_found_devices(struct btd_adapter *adapter,
-					bdaddr_t *bdaddr, addr_type_t type,
+					bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, uint8_t confirm_name,
 					uint8_t *data, uint8_t data_len)
 {
@@ -2881,7 +2882,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 
 	name = read_stored_data(&adapter->bdaddr, bdaddr, "names");
 
-	if (type == ADDR_TYPE_BREDR) {
+	if (bdaddr_type == BDADDR_BREDR) {
 		legacy = pairing_is_legacy(&adapter->bdaddr, bdaddr, data,
 									name);
 
@@ -2896,13 +2897,13 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	}
 
 	if (confirm_name)
-		adapter_ops->confirm_name(adapter->dev_id, bdaddr, type,
+		adapter_ops->confirm_name(adapter->dev_id, bdaddr, bdaddr_type,
 								name_known);
 
 	alias = read_stored_data(&adapter->bdaddr, bdaddr, "aliases");
 
-	dev = found_device_new(bdaddr, type, name, alias, dev_class, legacy,
-							eir_data.flags);
+	dev = found_device_new(bdaddr, bdaddr_type, name, alias, dev_class,
+						legacy, eir_data.flags);
 	free(name);
 	free(alias);
 
@@ -3453,16 +3454,17 @@ int btd_adapter_read_clock(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 }
 
 int btd_adapter_disconnect_device(struct btd_adapter *adapter,
-					bdaddr_t *bdaddr, addr_type_t type)
+					bdaddr_t *bdaddr, uint8_t bdaddr_type)
 
 {
-	return adapter_ops->disconnect(adapter->dev_id, bdaddr, type);
+	return adapter_ops->disconnect(adapter->dev_id, bdaddr, bdaddr_type);
 }
 
 int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							addr_type_t type)
+							uint8_t bdaddr_type)
 {
-	return adapter_ops->remove_bonding(adapter->dev_id, bdaddr, type);
+	return adapter_ops->remove_bonding(adapter->dev_id, bdaddr,
+								bdaddr_type);
 }
 
 int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
@@ -3473,16 +3475,16 @@ int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 }
 
 int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-					addr_type_t type, gboolean success)
+					uint8_t bdaddr_type, gboolean success)
 {
-	return adapter_ops->confirm_reply(adapter->dev_id, bdaddr, type,
+	return adapter_ops->confirm_reply(adapter->dev_id, bdaddr, bdaddr_type,
 								success);
 }
 
 int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-					addr_type_t type, uint32_t passkey)
+					uint8_t bdaddr_type, uint32_t passkey)
 {
-	return adapter_ops->passkey_reply(adapter->dev_id, bdaddr, type,
+	return adapter_ops->passkey_reply(adapter->dev_id, bdaddr, bdaddr_type,
 								passkey);
 }
 
diff --git a/src/adapter.h b/src/adapter.h
index 29b5ad5..b7ea62b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -41,12 +41,6 @@
 /* Invalid SSP passkey value used to indicate negative replies */
 #define INVALID_PASSKEY		0xffffffff
 
-typedef enum {
-	ADDR_TYPE_BREDR,
-	ADDR_TYPE_LE_PUBLIC,
-	ADDR_TYPE_LE_RANDOM,
-} addr_type_t;
-
 struct btd_adapter;
 
 struct link_key_info {
@@ -58,7 +52,7 @@ struct link_key_info {
 
 struct smp_ltk_info {
 	bdaddr_t bdaddr;
-	addr_type_t addr_type;
+	uint8_t bdaddr_type;
 	uint8_t authenticated;
 	uint8_t master;
 	uint8_t enc_size;
@@ -69,7 +63,7 @@ struct smp_ltk_info {
 
 struct remote_dev_info {
 	bdaddr_t bdaddr;
-	addr_type_t type;
+	uint8_t bdaddr_type;
 	int8_t rssi;
 	uint32_t class;
 	char *name;
@@ -115,7 +109,7 @@ void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 							bdaddr_t *bdaddr);
 void adapter_update_found_devices(struct btd_adapter *adapter,
-					bdaddr_t *bdaddr, addr_type_t type,
+					bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, uint8_t confirm_name,
 					uint8_t *data, uint8_t data_len);
 void adapter_emit_device_found(struct btd_adapter *adapter,
@@ -195,16 +189,16 @@ struct btd_adapter_ops {
 	int (*read_clock) (int index, bdaddr_t *bdaddr, int which, int timeout,
 					uint32_t *clock, uint16_t *accuracy);
 	int (*read_bdaddr) (int index, bdaddr_t *bdaddr);
-	int (*block_device) (int index, bdaddr_t *bdaddr, addr_type_t type);
-	int (*unblock_device) (int index, bdaddr_t *bdaddr, addr_type_t type);
+	int (*block_device) (int index, bdaddr_t *bdaddr, uint8_t bdaddr_type);
+	int (*unblock_device) (int index, bdaddr_t *bdaddr, uint8_t bdaddr_type);
 	int (*get_conn_list) (int index, GSList **conns);
-	int (*disconnect) (int index, bdaddr_t *bdaddr, addr_type_t type);
-	int (*remove_bonding) (int index, bdaddr_t *bdaddr, addr_type_t type);
+	int (*disconnect) (int index, bdaddr_t *bdaddr, uint8_t bdaddr_type);
+	int (*remove_bonding) (int index, bdaddr_t *bdaddr, uint8_t bdaddr_type);
 	int (*pincode_reply) (int index, bdaddr_t *bdaddr, const char *pin,
 							size_t pin_len);
-	int (*confirm_reply) (int index, bdaddr_t *bdaddr, addr_type_t type,
+	int (*confirm_reply) (int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean success);
-	int (*passkey_reply) (int index, bdaddr_t *bdaddr, addr_type_t type,
+	int (*passkey_reply) (int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							uint32_t passkey);
 	int (*encrypt_link) (int index, bdaddr_t *bdaddr, bt_hci_result_t cb,
 							gpointer user_data);
@@ -216,14 +210,14 @@ struct btd_adapter_ops {
 	int (*restore_powered) (int index);
 	int (*load_keys) (int index, GSList *keys, gboolean debug_keys);
 	int (*set_io_capability) (int index, uint8_t io_capability);
-	int (*create_bonding) (int index, bdaddr_t *bdaddr, uint8_t addr_type,
-							uint8_t io_cap);
+	int (*create_bonding) (int index, bdaddr_t *bdaddr,
+					uint8_t bdaddr_type, uint8_t io_cap);
 	int (*cancel_bonding) (int index, bdaddr_t *bdaddr);
 	int (*read_local_oob_data) (int index);
 	int (*add_remote_oob_data) (int index, bdaddr_t *bdaddr, uint8_t *hash,
 							uint8_t *randomizer);
 	int (*remove_remote_oob_data) (int index, bdaddr_t *bdaddr);
-	int (*confirm_name) (int index, bdaddr_t *bdaddr, addr_type_t type,
+	int (*confirm_name) (int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean name_known);
 	int (*load_ltks) (int index, GSList *keys);
 };
@@ -250,22 +244,22 @@ int btd_adapter_read_clock(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				uint16_t *accuracy);
 
 int btd_adapter_block_address(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							addr_type_t type);
+							uint8_t bdaddr_type);
 int btd_adapter_unblock_address(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							addr_type_t type);
+							uint8_t bdaddr_type);
 
 int btd_adapter_disconnect_device(struct btd_adapter *adapter,
-					bdaddr_t *bdaddr, addr_type_t type);
+					bdaddr_t *bdaddr, uint8_t bdaddr_type);
 
 int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							addr_type_t type);
+							uint8_t bdaddr_type);
 
 int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 					const char *pin, size_t pin_len);
 int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-					addr_type_t type, gboolean success);
+					uint8_t bdaddr_type, gboolean success);
 int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-					addr_type_t type, uint32_t passkey);
+					uint8_t bdaddr_type, uint32_t passkey);
 
 int btd_adapter_encrypt_link(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				bt_hci_result_t cb, gpointer user_data);
@@ -275,7 +269,7 @@ int btd_adapter_set_did(struct btd_adapter *adapter, uint16_t vendor,
 					uint16_t source);
 
 int adapter_create_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-				uint8_t addr_type, uint8_t io_cap);
+				uint8_t bdaddr_type, uint8_t io_cap);
 
 int adapter_cancel_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 
diff --git a/src/device.c b/src/device.c
index 1ea4854..021b200 100644
--- a/src/device.c
+++ b/src/device.c
@@ -130,7 +130,7 @@ struct att_callbacks {
 
 struct btd_device {
 	bdaddr_t	bdaddr;
-	addr_type_t	type;
+	uint8_t		bdaddr_type;
 	gchar		*path;
 	char		name[MAX_NAME_LENGTH + 1];
 	char		*alias;
@@ -291,12 +291,12 @@ static void device_free(gpointer user_data)
 
 gboolean device_is_bredr(struct btd_device *device)
 {
-	return (device->type == ADDR_TYPE_BREDR);
+	return (device->bdaddr_type == BDADDR_BREDR);
 }
 
 gboolean device_is_le(struct btd_device *device)
 {
-	return (device->type != ADDR_TYPE_BREDR);
+	return (device->bdaddr_type != BDADDR_BREDR);
 }
 
 gboolean device_is_paired(struct btd_device *device)
@@ -516,7 +516,7 @@ static gboolean do_disconnect(gpointer user_data)
 	device->disconn_timer = 0;
 
 	btd_adapter_disconnect_device(device->adapter, &device->bdaddr,
-								device->type);
+							device->bdaddr_type);
 
 	return FALSE;
 }
@@ -537,7 +537,7 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 
 	if (!update_only)
 		err = btd_adapter_block_address(device->adapter,
-						&device->bdaddr, device->type);
+					&device->bdaddr, device->bdaddr_type);
 
 	if (err < 0)
 		return err;
@@ -569,7 +569,7 @@ int device_unblock(DBusConnection *conn, struct btd_device *device,
 
 	if (!update_only)
 		err = btd_adapter_unblock_address(device->adapter,
-						&device->bdaddr, device->type);
+					&device->bdaddr, device->bdaddr_type);
 
 	if (err < 0)
 		return err;
@@ -1036,7 +1036,7 @@ static void device_set_version(struct btd_device *device, uint16_t value)
 
 struct btd_device *device_create(DBusConnection *conn,
 				struct btd_adapter *adapter,
-				const gchar *address, addr_type_t type)
+				const gchar *address, uint8_t bdaddr_type)
 {
 	gchar *address_up;
 	struct btd_device *device;
@@ -1065,7 +1065,7 @@ struct btd_device *device_create(DBusConnection *conn,
 
 	str2ba(address, &device->bdaddr);
 	device->adapter = adapter;
-	device->type = type;
+	device->bdaddr_type = bdaddr_type;
 	adapter_get_address(adapter, &src);
 	ba2str(&src, srcaddr);
 	read_device_name(srcaddr, address, device->name);
@@ -1158,7 +1158,7 @@ static void device_remove_stored(struct btd_device *device)
 		device_set_bonded(device, FALSE);
 		device->paired = FALSE;
 		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
-								device->type);
+							device->bdaddr_type);
 	}
 	delete_entry(&src, "profiles", addr);
 	delete_entry(&src, "trusts", addr);
@@ -1998,13 +1998,13 @@ static gboolean att_connect(gpointer user_data)
 					BT_IO_OPT_INVALID);
 	} else {
 		io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
-					attcb, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, &sba,
-					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
-					BT_IO_OPT_DEST_TYPE, device->type,
-					BT_IO_OPT_CID, ATT_CID,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-					BT_IO_OPT_INVALID);
+				attcb, NULL, &gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &sba,
+				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
+				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
+				BT_IO_OPT_CID, ATT_CID,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_INVALID);
 	}
 
 	if (io == NULL) {
@@ -2087,7 +2087,7 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 				attcb, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
-				BT_IO_OPT_DEST_TYPE, device->type,
+				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
 				BT_IO_OPT_CID, ATT_CID,
 				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
@@ -2182,19 +2182,19 @@ struct btd_adapter *device_get_adapter(struct btd_device *device)
 }
 
 void device_get_address(struct btd_device *device, bdaddr_t *bdaddr,
-							addr_type_t *type)
+							uint8_t *bdaddr_type)
 {
 	bacpy(bdaddr, &device->bdaddr);
-	if (type != NULL)
-		*type = device->type;
+	if (bdaddr_type != NULL)
+		*bdaddr_type = device->bdaddr_type;
 }
 
-void device_set_addr_type(struct btd_device *device, addr_type_t type)
+void device_set_addr_type(struct btd_device *device, uint8_t bdaddr_type)
 {
 	if (device == NULL)
 		return;
 
-	device->type = type;
+	device->bdaddr_type = bdaddr_type;
 }
 
 const gchar *device_get_path(struct btd_device *device)
@@ -2393,7 +2393,7 @@ void device_set_paired(struct btd_device *device, gboolean value)
 
 	if (!value)
 		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
-								device->type);
+							device->bdaddr_type);
 
 	device->paired = value;
 
@@ -2488,13 +2488,13 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 		attcb->user_data = device;
 
 		device->att_io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
-					attcb, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, &sba,
-					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
-					BT_IO_OPT_DEST_TYPE, device->type,
-					BT_IO_OPT_CID, ATT_CID,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-					BT_IO_OPT_INVALID);
+				attcb, NULL, &gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &sba,
+				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
+				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
+				BT_IO_OPT_CID, ATT_CID,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
 
 		if (device->att_io == NULL) {
 			DBusMessage *reply = btd_error_failed(msg,
@@ -2508,7 +2508,7 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 	}
 
 	err = adapter_create_bonding(adapter, &device->bdaddr,
-					device->type, capability);
+					device->bdaddr_type, capability);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
diff --git a/src/device.h b/src/device.h
index 690c64d..51140c7 100644
--- a/src/device.h
+++ b/src/device.h
@@ -36,7 +36,7 @@ typedef enum {
 
 struct btd_device *device_create(DBusConnection *conn,
 					struct btd_adapter *adapter,
-					const char *address, addr_type_t type);
+					const char *address, uint8_t bdaddr_type);
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 uint16_t btd_device_get_vendor(struct btd_device *device);
@@ -60,8 +60,8 @@ GSList *device_services_from_record(struct btd_device *device,
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
 void device_get_address(struct btd_device *device, bdaddr_t *bdaddr,
-							addr_type_t *type);
-void device_set_addr_type(struct btd_device *device, addr_type_t type);
+							uint8_t *bdaddr_type);
+void device_set_addr_type(struct btd_device *device, uint8_t bdaddr_type);
 const gchar *device_get_path(struct btd_device *device);
 struct agent *device_get_agent(struct btd_device *device);
 gboolean device_is_bredr(struct btd_device *device);
diff --git a/src/event.c b/src/event.c
index 876bd37..f576102 100644
--- a/src/event.c
+++ b/src/event.c
@@ -144,11 +144,12 @@ static int confirm_reply(struct btd_adapter *adapter,
 				struct btd_device *device, gboolean success)
 {
 	bdaddr_t bdaddr;
-	addr_type_t type;
+	uint8_t bdaddr_type;
 
-	device_get_address(device, &bdaddr, &type);
+	device_get_address(device, &bdaddr, &bdaddr_type);
 
-	return btd_adapter_confirm_reply(adapter, &bdaddr, type, success);
+	return btd_adapter_confirm_reply(adapter, &bdaddr, bdaddr_type,
+								success);
 }
 
 static void confirm_cb(struct agent *agent, DBusError *err, void *user_data)
@@ -166,14 +167,14 @@ static void passkey_cb(struct agent *agent, DBusError *err, uint32_t passkey,
 	struct btd_device *device = user_data;
 	struct btd_adapter *adapter = device_get_adapter(device);
 	bdaddr_t bdaddr;
-	addr_type_t type;
+	uint8_t bdaddr_type;
 
-	device_get_address(device, &bdaddr, &type);
+	device_get_address(device, &bdaddr, &bdaddr_type);
 
 	if (err)
 		passkey = INVALID_PASSKEY;
 
-	btd_adapter_passkey_reply(adapter, &bdaddr, type, passkey);
+	btd_adapter_passkey_reply(adapter, &bdaddr, bdaddr_type, passkey);
 }
 
 int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
@@ -254,7 +255,7 @@ static void update_lastused(bdaddr_t *sba, bdaddr_t *dba)
 	write_lastused_info(sba, dba, tm);
 }
 
-void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
+void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					int8_t rssi, uint8_t confirm_name,
 					uint8_t *data, uint8_t data_len)
 {
@@ -271,7 +272,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
 	if (data)
 		write_remote_eir(local, peer, data, data_len);
 
-	adapter_update_found_devices(adapter, peer, type, rssi,
+	adapter_update_found_devices(adapter, peer, bdaddr_type, rssi,
 						confirm_name, data, data_len);
 }
 
@@ -367,7 +368,7 @@ static char *buf2str(uint8_t *data, int datalen)
 }
 
 static int store_longtermkey(bdaddr_t *local, bdaddr_t *peer,
-				addr_type_t addr_type, 	unsigned char *key,
+				uint8_t bdaddr_type, unsigned char *key,
 				uint8_t master, uint8_t authenticated,
 				uint8_t enc_size, uint16_t ediv, uint8_t rand[8])
 {
@@ -382,7 +383,7 @@ static int store_longtermkey(bdaddr_t *local, bdaddr_t *peer,
 	newkey = g_string_new(val);
 	g_free(val);
 
-	g_string_append_printf(newkey, " %d %d %d %d %d ", addr_type,
+	g_string_append_printf(newkey, " %d %d %d %d %d ", bdaddr_type,
 					authenticated, master, enc_size, ediv);
 
 	str = buf2str(rand, 8);
@@ -426,7 +427,7 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 	return ret;
 }
 
-int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, addr_type_t addr_type,
+int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					uint8_t *key, uint8_t master,
 					uint8_t authenticated, uint8_t enc_size,
 					uint16_t ediv, 	uint8_t rand[8])
@@ -438,7 +439,7 @@ int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, addr_type_t addr_type,
 	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
 		return -ENODEV;
 
-	ret = store_longtermkey(local, peer, addr_type, key, master,
+	ret = store_longtermkey(local, peer, bdaddr_type, key, master,
 					authenticated, enc_size, ediv, rand);
 	if (ret == 0) {
 		device_set_bonded(device, TRUE);
@@ -450,7 +451,7 @@ int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, addr_type_t addr_type,
 	return ret;
 }
 
-void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
+void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 						char *name, uint8_t *dev_class)
 {
 	struct btd_adapter *adapter;
@@ -469,7 +470,7 @@ void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
 			write_remote_class(local, peer, class);
 	}
 
-	device_set_addr_type(device, type);
+	device_set_addr_type(device, bdaddr_type);
 
 	adapter_add_connection(adapter, device);
 
diff --git a/src/event.h b/src/event.h
index 503d35f..c4ae18f 100644
--- a/src/event.h
+++ b/src/event.h
@@ -23,13 +23,13 @@
  */
 
 int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure);
-void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
+void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					int8_t rssi, uint8_t confirm_name,
 					uint8_t *data, uint8_t data_len);
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
 void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
-void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, addr_type_t type,
+void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					char *name, uint8_t *dev_class);
 void btd_event_conn_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
 void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer);
@@ -43,7 +43,7 @@ void btd_event_device_unblocked(bdaddr_t *local, bdaddr_t *peer);
 void btd_event_device_unpaired(bdaddr_t *local, bdaddr_t *peer);
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 					uint8_t key_type, uint8_t pin_length);
-int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, addr_type_t addr_type,
+int btd_event_ltk_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 					uint8_t *key, uint8_t master,
 					uint8_t authenticated, uint8_t enc_size,
 					uint16_t ediv, 	uint8_t rand[8]);
-- 
1.7.8.5

