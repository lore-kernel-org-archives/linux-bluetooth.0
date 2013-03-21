Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org,
	marcel@holtmann.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH 4/6] core: retry bonding attempt until the iterator reachs the end.
Date: Wed, 20 Mar 2013 21:10:06 -0700
Message-Id: <1363839008-8405-5-git-send-email-deymo@chromium.org>
In-Reply-To: <1363839008-8405-1-git-send-email-deymo@chromium.org>
References: <1363839008-8405-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

When a bonding fails with an authentication error, retry with the
next function (or next call to the same function) in the pincode callback
list.
---
 src/adapter.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
 src/adapter.h |  3 +++
 src/device.c  | 48 ++++++++++++++++++++++++++++++++++-----
 src/device.h  |  2 ++
 4 files changed, 109 insertions(+), 16 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 862f64c..7be7ee3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4932,6 +4932,41 @@ static void bonding_complete(struct btd_adapter *adapter,
 	check_oob_bonding_complete(adapter, bdaddr, status);
 }
 
+static void bonding_attempt_complete(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr,
+					uint8_t addr_type, uint8_t status)
+{
+	int err = 0;
+	struct btd_device *device;
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	DBG("hci%u bdaddr %s type %u status 0x%x", adapter->dev_id, addr,
+							addr_type, status);
+
+	if (status == 0)
+		device = adapter_get_device(adapter, bdaddr, addr_type);
+	else
+		device = adapter_find_device(adapter, bdaddr);
+
+	if (status == MGMT_STATUS_AUTH_FAILED) {
+
+		/* On faliure, issue a bonding_retry if possible. */
+		if (device != NULL) {
+			err = device_bonding_attempt_retry(device);
+			if (err == 0)
+				return;
+		}
+	}
+
+	/* Ignore disconnects during retry. */
+	if (status == MGMT_STATUS_DISCONNECTED && device_is_retrying(device))
+		return;
+
+	/* In any other case, finish the bonding. */
+	bonding_complete(adapter, bdaddr, addr_type, status);
+}
+
 struct pair_device_data {
 	struct btd_adapter *adapter;
 	bdaddr_t bdaddr;
@@ -4985,7 +5020,7 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 		error("Pair device failed: %s (0x%02x)",
 						mgmt_errstr(status), status);
 
-		bonding_complete(adapter, &data->bdaddr,
+		bonding_attempt_complete(adapter, &data->bdaddr,
 						data->addr_type, status);
 		return;
 	}
@@ -4995,17 +5030,13 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 		return;
 	}
 
-	bonding_complete(adapter, &rp->addr.bdaddr, rp->addr.type, status);
+	bonding_attempt_complete(adapter, &rp->addr.bdaddr, rp->addr.type,
+									status);
 }
 
 int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 					uint8_t addr_type, uint8_t io_cap)
 {
-	struct mgmt_cp_pair_device cp;
-	char addr[18];
-	struct pair_device_data *data;
-	unsigned int id;
-
 	if (adapter->pair_device_id > 0) {
 		error("Unable pair since another pairing is in progress");
 		return -EBUSY;
@@ -5013,6 +5044,17 @@ int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 
 	suspend_discovery(adapter);
 
+	return adapter_bonding_attempt(adapter, bdaddr, addr_type, io_cap);
+}
+
+int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
+					uint8_t addr_type, uint8_t io_cap)
+{
+	struct mgmt_cp_pair_device cp;
+	char addr[18];
+	struct pair_device_data *data;
+	unsigned int id;
+
 	ba2str(bdaddr, addr);
 	DBG("hci%u bdaddr %s type %d io_cap 0x%02x",
 				adapter->dev_id, addr, addr_type, io_cap);
@@ -5065,7 +5107,7 @@ static void dev_disconnected(struct btd_adapter *adapter,
 	if (device)
 		adapter_remove_connection(adapter, device);
 
-	bonding_complete(adapter, &addr->bdaddr, addr->type,
+	bonding_attempt_complete(adapter, &addr->bdaddr, addr->type,
 						MGMT_STATUS_DISCONNECTED);
 }
 
@@ -5119,7 +5161,8 @@ static void auth_failed_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	bonding_complete(adapter, &ev->addr.bdaddr, ev->addr.type, ev->status);
+	bonding_attempt_complete(adapter, &ev->addr.bdaddr, ev->addr.type,
+								ev->status);
 }
 
 static void store_link_key(struct btd_adapter *adapter,
@@ -5720,13 +5763,20 @@ static void connect_failed_callback(uint16_t index, uint16_t length,
 	device = adapter_find_device(adapter, &ev->addr.bdaddr);
 	if (device) {
 		if (device_is_bonding(device, NULL))
-			device_bonding_failed(device, ev->status);
+			device_cancel_authentication(device, FALSE);
 		if (device_is_temporary(device))
 			adapter_remove_device(adapter, device, TRUE);
 	}
 
 	/* In the case of security mode 3 devices */
-	bonding_complete(adapter, &ev->addr.bdaddr, ev->addr.type, ev->status);
+	bonding_attempt_complete(adapter, &ev->addr.bdaddr, ev->addr.type,
+								ev->status);
+
+	if (device && device_is_bonding(device, NULL)
+					&& !device_is_retrying(device)) {
+		device_cancel_authentication(device, TRUE);
+		device_bonding_failed(device, ev->status);
+	}
 }
 
 static void unpaired_callback(uint16_t index, uint16_t length,
diff --git a/src/adapter.h b/src/adapter.h
index ba57b15..1489995 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -178,6 +178,9 @@ int btd_adapter_passkey_reply(struct btd_adapter *adapter,
 int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 					uint8_t addr_type, uint8_t io_cap);
 
+int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
+					uint8_t addr_type, uint8_t io_cap);
+
 int adapter_cancel_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 							uint8_t addr_type);
 
diff --git a/src/device.c b/src/device.c
index 62e4d3a..224f858 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3740,6 +3740,46 @@ gboolean device_is_bonding(struct btd_device *device, const char *sender)
 	return g_str_equal(sender, dbus_message_get_sender(bonding->msg));
 }
 
+static gboolean device_bonding_retry(gpointer data)
+{
+	struct btd_device *device = data;
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct bonding_req *bonding = device->bonding;
+	int err;
+
+	if (!bonding)
+		return FALSE;
+
+	DBG("retrying bonding");
+	bonding->retry_timer = 0;
+
+	err = adapter_bonding_attempt(adapter, &device->bdaddr,
+				device->bdaddr_type, bonding->capability);
+	if (err < 0)
+		device_bonding_complete(device, bonding->status);
+
+	return FALSE;
+}
+
+int device_bonding_attempt_retry(struct btd_device *device) {
+	struct bonding_req *bonding = device->bonding;
+
+	/* Ignore other failure events while retrying */
+	if (device_is_retrying(device))
+		return 0;
+
+	if (!bonding)
+		return -EINVAL;
+
+	if (pincb_iter_end(bonding->cb_iter))
+		return -EINVAL;
+
+	DBG("scheduling retry with io_cap %u", bonding->capability);
+	bonding->retry_timer = g_timeout_add(3000,
+						device_bonding_retry, device);
+	return 0;
+}
+
 void device_bonding_failed(struct btd_device *device, uint8_t status)
 {
 	struct bonding_req *bonding = device->bonding;
@@ -3750,17 +3790,15 @@ void device_bonding_failed(struct btd_device *device, uint8_t status)
 	if (!bonding)
 		return;
 
-	if (device->authr)
-		device_cancel_authentication(device, FALSE);
-
 	reply = new_authentication_return(bonding->msg, status);
 	g_dbus_send_message(dbus_conn, reply);
 
 	bonding_request_free(bonding);
 }
 
-struct pincb_iter *device_bonding_iter(struct btd_device *device) {
-	if (device->bonding == NULL)
+struct pincb_iter *device_bonding_iter(struct btd_device *device)
+{
+	if (!device->bonding)
 		return NULL;
 
 	return device->bonding->cb_iter;
diff --git a/src/device.h b/src/device.h
index 61a294b..f81721a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -76,8 +76,10 @@ gboolean device_is_connected(struct btd_device *device);
 gboolean device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t status);
 gboolean device_is_bonding(struct btd_device *device, const char *sender);
+void device_bonding_attempt_failed(struct btd_device *device, uint8_t status);
 void device_bonding_failed(struct btd_device *device, uint8_t status);
 struct pincb_iter *device_bonding_iter(struct btd_device *device);
+int device_bonding_attempt_retry(struct btd_device *device);
 int device_request_pincode(struct btd_device *device, gboolean secure);
 int device_request_passkey(struct btd_device *device);
 int device_confirm_passkey(struct btd_device *device, uint32_t passkey,
-- 
1.8.1.3
