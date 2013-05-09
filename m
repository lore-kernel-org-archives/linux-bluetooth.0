Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v5 4/8] core: retry bonding attempt until the iterator reaches the end.
Date: Wed,  8 May 2013 17:37:58 -0700
Message-Id: <1368059882-9986-5-git-send-email-deymo@chromium.org>
In-Reply-To: <1368059882-9986-1-git-send-email-deymo@chromium.org>
References: <1368059882-9986-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch splits the bonding process in an interative process consisting
of one or more "bonding attempts". The user/agent starts a new "bonding"
that may involve several rounds of "bonding attempts" with the device
before it gets back to the user/agent.

Some functions were split in two parts to reflect this change. When a
bonding attempt fails with an authentication error and a pin code was
provided, a new bonding attempt is initiated (after a short delay)
to retry with the next function (or next call to the same function)
in the pincode callback list. If no pin code was provided to the device,
no retry is attempted and the authentication error is returned to the
client. This effectively allows a plugin try different pincodes for the
same device during the same bonding.
---
 src/adapter.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 src/adapter.h |  3 ++
 src/device.c  | 47 +++++++++++++++++++++++++++++
 src/device.h  |  2 ++
 4 files changed, 135 insertions(+), 13 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index bcf54d5..bca1515 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -165,6 +165,7 @@ struct btd_adapter {
 	guint pairable_timeout_id;	/* pairable timeout id */
 	guint auth_idle_id;		/* Pending authorization dequeue */
 	GQueue *auths;			/* Ongoing and pending auths */
+	bool pincode_requested;		/* PIN requested during last bonding */
 	GSList *connections;		/* Connected devices */
 	GSList *devices;		/* Devices structure pointers */
 	GSList *connect_list;		/* Devices to connect when found */
@@ -3894,6 +3895,7 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 
 	adapter->dev_id = index;
 	adapter->mgmt = mgmt_ref(mgmt_master);
+	adapter->pincode_requested = FALSE;
 
 	/*
 	 * Setup default configuration values. These are either adapter
@@ -4835,6 +4837,9 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
+	/* Flag the request of a pincode to allow a bonding retry. */
+	adapter->pincode_requested = TRUE;
+
 	memset(pin, 0, sizeof(pin));
 
 	iter = device_bonding_iter(device);
@@ -4923,6 +4928,42 @@ static void bonding_complete(struct btd_adapter *adapter,
 	check_oob_bonding_complete(adapter, bdaddr, status);
 }
 
+/* bonding_attempt_complete() handles the end of a "bonding attempt" checking if
+ * it should begin a new attempt or complete the bonding.
+ */
+static void bonding_attempt_complete(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr,
+					uint8_t addr_type, uint8_t status)
+{
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
+	if (status == MGMT_STATUS_AUTH_FAILED && adapter->pincode_requested) {
+		/* On faliure, issue a bonding_retry if possible. */
+		if (device != NULL) {
+			if (device_bonding_attempt_retry(device) == 0)
+				return;
+		}
+	}
+
+	/* Ignore disconnects during retry. */
+	if (status == MGMT_STATUS_DISCONNECTED &&
+					device && device_is_retrying(device))
+		return;
+
+	/* In any other case, finish the bonding. */
+	bonding_complete(adapter, bdaddr, addr_type, status);
+}
+
 struct pair_device_data {
 	struct btd_adapter *adapter;
 	bdaddr_t bdaddr;
@@ -4976,7 +5017,7 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 		error("Pair device failed: %s (0x%02x)",
 						mgmt_errstr(status), status);
 
-		bonding_complete(adapter, &data->bdaddr,
+		bonding_attempt_complete(adapter, &data->bdaddr,
 						data->addr_type, status);
 		return;
 	}
@@ -4986,17 +5027,13 @@ static void pair_device_complete(uint8_t status, uint16_t length,
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
@@ -5004,10 +5041,25 @@ int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 
 	suspend_discovery(adapter);
 
+	return adapter_bonding_attempt(adapter, bdaddr, addr_type, io_cap);
+}
+
+/* Starts a new bonding attempt in a fresh new bonding_req or a retried one. */
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
 
+	/* Reset the pincode_requested flag for a new bonding attempt. */
+	adapter->pincode_requested = FALSE;
+
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.addr.bdaddr, bdaddr);
 	cp.addr.type = addr_type;
@@ -5056,7 +5108,7 @@ static void dev_disconnected(struct btd_adapter *adapter,
 	if (device)
 		adapter_remove_connection(adapter, device);
 
-	bonding_complete(adapter, &addr->bdaddr, addr->type,
+	bonding_attempt_complete(adapter, &addr->bdaddr, addr->type,
 						MGMT_STATUS_DISCONNECTED);
 }
 
@@ -5110,7 +5162,8 @@ static void auth_failed_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	bonding_complete(adapter, &ev->addr.bdaddr, ev->addr.type, ev->status);
+	bonding_attempt_complete(adapter, &ev->addr.bdaddr, ev->addr.type,
+								ev->status);
 }
 
 static void store_link_key(struct btd_adapter *adapter,
@@ -5708,14 +5761,31 @@ static void connect_failed_callback(uint16_t index, uint16_t length,
 
 	device = adapter_find_device(adapter, &ev->addr.bdaddr);
 	if (device) {
+		/* If the device is in a bonding process cancel any auth request
+		 * sent to the agent before proceeding, but keep the bonding
+		 * request structure. */
 		if (device_is_bonding(device, NULL))
-			device_bonding_failed(device, ev->status);
-		if (device_is_temporary(device))
-			adapter_remove_device(adapter, device, TRUE);
+			device_cancel_authentication(device, FALSE);
 	}
 
 	/* In the case of security mode 3 devices */
-	bonding_complete(adapter, &ev->addr.bdaddr, ev->addr.type, ev->status);
+	bonding_attempt_complete(adapter, &ev->addr.bdaddr, ev->addr.type,
+								ev->status);
+
+	/* If the device is scheduled to retry the bonding wait until the retry
+	 * happens. In other case, proceed with cancel the bondig.
+	 */
+	if (device && device_is_bonding(device, NULL)
+					&& !device_is_retrying(device)) {
+		device_cancel_authentication(device, TRUE);
+		device_bonding_failed(device, ev->status);
+	}
+
+	/* In the case the bonding was canceled or did exists, remove the device
+	 * when it is temporary. */
+	if (device && !device_is_bonding(device, NULL)
+						&& device_is_temporary(device))
+		adapter_remove_device(adapter, device, TRUE);
 }
 
 static void unpaired_callback(uint16_t index, uint16_t length,
diff --git a/src/adapter.h b/src/adapter.h
index 09d80c2..2de8730 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -179,6 +179,9 @@ int btd_adapter_passkey_reply(struct btd_adapter *adapter,
 int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 					uint8_t addr_type, uint8_t io_cap);
 
+int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
+					uint8_t addr_type, uint8_t io_cap);
+
 int adapter_cancel_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 							uint8_t addr_type);
 
diff --git a/src/device.c b/src/device.c
index 012e150..03325f7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3818,6 +3818,53 @@ gboolean device_is_bonding(struct btd_device *device, const char *sender)
 	return g_str_equal(sender, dbus_message_get_sender(bonding->msg));
 }
 
+static gboolean device_bonding_retry(gpointer data)
+{
+	struct btd_device *device = data;
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct bonding_req *bonding = device->bonding;
+	uint8_t io_cap;
+	int err;
+
+	if (!bonding)
+		return FALSE;
+
+	DBG("retrying bonding");
+	bonding->retry_timer = 0;
+
+	if (bonding->agent)
+		io_cap = agent_get_io_capability(bonding->agent);
+	else
+		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
+
+	err = adapter_bonding_attempt(adapter, &device->bdaddr,
+				device->bdaddr_type, io_cap);
+	if (err < 0)
+		device_bonding_complete(device, bonding->status);
+
+	return FALSE;
+}
+
+int device_bonding_attempt_retry(struct btd_device *device)
+{
+	struct bonding_req *bonding = device->bonding;
+
+	/* Ignore other failure events while retrying */
+	if (device_is_retrying(device))
+		return 0;
+
+	if (!bonding)
+		return -EINVAL;
+
+	if (btd_adapter_pin_cb_iter_end(bonding->cb_iter))
+		return -EINVAL;
+
+	DBG("scheduling retry");
+	bonding->retry_timer = g_timeout_add(3000,
+						device_bonding_retry, device);
+	return 0;
+}
+
 void device_bonding_failed(struct btd_device *device, uint8_t status)
 {
 	struct bonding_req *bonding = device->bonding;
diff --git a/src/device.h b/src/device.h
index b7d5c45..5aa0f81 100644
--- a/src/device.h
+++ b/src/device.h
@@ -77,8 +77,10 @@ gboolean device_is_connected(struct btd_device *device);
 bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t status);
 gboolean device_is_bonding(struct btd_device *device, const char *sender);
+void device_bonding_attempt_failed(struct btd_device *device, uint8_t status);
 void device_bonding_failed(struct btd_device *device, uint8_t status);
 struct btd_adapter_pin_cb_iter *device_bonding_iter(struct btd_device *device);
+int device_bonding_attempt_retry(struct btd_device *device);
 int device_request_pincode(struct btd_device *device, gboolean secure);
 int device_request_passkey(struct btd_device *device);
 int device_confirm_passkey(struct btd_device *device, uint32_t passkey,
-- 
1.8.2.1
