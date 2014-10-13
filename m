Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] core: Add btd_adapter_recreate_bonding()
Date: Mon, 13 Oct 2014 11:43:40 +0000
Message-Id: <1413200623-31278-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds btd_adapter_recreate_bonding() which rebonds a device,
i.e. it performs an unbonding operation inmediately followed by a
bonding operation.

Although there is no internal use for btd_adapter_recreate_bonding()
yet, it is useful for plugins dealing with devices which require
renegotiaing their keys. For instance, when dealing with devices
without persistent storage which lose their keys on reset.

Certain caveats have been taken into account when rebonding with a LE
device:

 * If the device to rebond is already connected, the rebonding is done
   without disconnecting to avoid the extra latency of reestablishing
   the connection.

 * If no connection exists, we connect before unbonding anyways to
   avoid losing the device's autoconnection and connection parameters,
   which are removed by the kernel when unpairing if no connection
   exists.

 * Not closing the connection requires defering attribute discovery
   until the rebonding is done. Otherwise, the security level could be
   elavated with the old LTK, which may be invalid since we are
   rebonding. When rebonding, attribute discovery is suspended and the
   ATT socket is saved to allow resuming it once bonding is finished.
---
 src/adapter.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/adapter.h |  7 ++++++-
 src/device.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/device.h  |  4 ++++
 4 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 92ee1a0..81e8f22 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5195,14 +5195,15 @@ int btd_adapter_read_clock(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 }
 
 int btd_adapter_remove_bonding(struct btd_adapter *adapter,
-				const bdaddr_t *bdaddr, uint8_t bdaddr_type)
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type,
+				uint8_t disconnect)
 {
 	struct mgmt_cp_unpair_device cp;
 
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.addr.bdaddr, bdaddr);
 	cp.addr.type = bdaddr_type;
-	cp.disconnect = 1;
+	cp.disconnect = disconnect;
 
 	if (mgmt_send(adapter->mgmt, MGMT_OP_UNPAIR_DEVICE,
 				adapter->dev_id, sizeof(cp), &cp,
@@ -5212,6 +5213,53 @@ int btd_adapter_remove_bonding(struct btd_adapter *adapter,
 	return -EIO;
 }
 
+int btd_adapter_recreate_bonding(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr,
+					uint8_t bdaddr_type,
+					uint8_t io_cap)
+{
+	struct btd_device *device;
+	int err;
+
+	device = btd_adapter_get_device(adapter, bdaddr, bdaddr_type);
+
+	if (!device || !device_is_bonded(device, bdaddr_type))
+		return -EINVAL;
+
+	device_set_rebonding(device, bdaddr_type, true);
+
+	/* Make sure the device is connected before unbonding to avoid
+	 * losing the device's autoconnection and connection
+	 * parameters, which are removed by the kernel when unpairing
+	 * if no connection exists. We would had anyways implicitly
+	 * connected when bonding later on, so we might as well just
+	 * do it explicitly now.
+	 */
+	if (bdaddr_type != BDADDR_BREDR && !btd_device_is_connected(device)) {
+		err = device_connect_le(device);
+		if (err < 0)
+			goto failed;
+	}
+
+	/* Unbond without disconnecting to avoid the connection
+	 * re-establishment latency
+	 */
+	err = btd_adapter_remove_bonding(adapter, bdaddr, bdaddr_type, 0);
+	if (err < 0)
+		goto failed;
+
+	err = adapter_create_bonding(adapter, bdaddr, bdaddr_type, io_cap);
+	if (err < 0)
+		goto failed;
+
+	return 0;
+
+failed:
+	error("failed: %s", strerror(-err));
+	device_set_rebonding(device, bdaddr_type, false);
+	return err;
+}
+
 static void pincode_reply_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -5594,8 +5642,11 @@ static void bonding_complete(struct btd_adapter *adapter,
 	else
 		device = btd_adapter_find_device(adapter, bdaddr, addr_type);
 
-	if (device != NULL)
+	if (device != NULL) {
 		device_bonding_complete(device, addr_type, status);
+		if (device_is_rebonding(device, addr_type))
+			device_rebonding_complete(device, addr_type);
+	}
 
 	resume_discovery(adapter);
 
diff --git a/src/adapter.h b/src/adapter.h
index 6801fee..bd00d3e 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -158,7 +158,12 @@ int btd_adapter_disconnect_device(struct btd_adapter *adapter,
 							uint8_t bdaddr_type);
 
 int btd_adapter_remove_bonding(struct btd_adapter *adapter,
-				const bdaddr_t *bdaddr, uint8_t bdaddr_type);
+				const bdaddr_t *bdaddr, uint8_t bdaddr_type,
+				uint8_t disconnect);
+int btd_adapter_recreate_bonding(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr,
+					uint8_t bdaddr_type,
+					uint8_t io_cap);
 
 int btd_adapter_pincode_reply(struct btd_adapter *adapter,
 					const  bdaddr_t *bdaddr,
diff --git a/src/device.c b/src/device.c
index 875a5c5..4aab349 100644
--- a/src/device.c
+++ b/src/device.c
@@ -158,6 +158,7 @@ struct att_callbacks {
 struct bearer_state {
 	bool paired;
 	bool bonded;
+	bool rebonding;
 	bool connected;
 	bool svc_resolved;
 };
@@ -221,6 +222,8 @@ struct btd_device {
 	int8_t		rssi;
 
 	GIOChannel	*att_io;
+	GIOChannel	*att_rebond_io;
+
 	guint		cleanup_id;
 	guint		store_id;
 };
@@ -522,6 +525,9 @@ static void device_free(gpointer user_data)
 
 	attio_cleanup(device);
 
+	if (device->att_rebond_io)
+		g_io_channel_unref(device->att_rebond_io);
+
 	if (device->tmp_records)
 		sdp_list_free(device->tmp_records,
 					(sdp_free_func_t) sdp_record_free);
@@ -1739,6 +1745,23 @@ long device_bonding_last_duration(struct btd_device *device)
 	return bonding->last_attempt_duration_ms;
 }
 
+bool device_is_rebonding(struct btd_device *device, uint8_t bdaddr_type)
+{
+	struct bearer_state *state = get_state(device, bdaddr_type);
+
+	return state->rebonding;
+}
+
+void device_set_rebonding(struct btd_device *device, uint8_t bdaddr_type,
+				bool rebonding)
+{
+	struct bearer_state *state = get_state(device, bdaddr_type);
+
+	state->rebonding = rebonding;
+
+	DBG("rebonding = %d", rebonding);
+}
+
 static void create_bond_req_exit(DBusConnection *conn, void *user_data)
 {
 	struct btd_device *device = user_data;
@@ -2029,7 +2052,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 
 	if (state->paired && !state->bonded)
 		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
-								bdaddr_type);
+								bdaddr_type, 1);
 
 	if (device->bredr_state.connected || device->le_state.connected)
 		return;
@@ -2639,13 +2662,13 @@ static void device_remove_stored(struct btd_device *device)
 	if (device->bredr_state.bonded) {
 		device->bredr_state.bonded = false;
 		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
-								BDADDR_BREDR);
+							BDADDR_BREDR, 1);
 	}
 
 	if (device->le_state.bonded) {
 		device->le_state.bonded = false;
 		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
-							device->bdaddr_type);
+							device->bdaddr_type, 1);
 	}
 
 	device->bredr_state.paired = false;
@@ -3628,6 +3651,18 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
 	GAttrib *attrib;
 	BtIOSecLevel sec_level;
 
+	DBG("");
+
+	if (dev->le_state.rebonding) {
+		DBG("postponing due to rebonding");
+		/* Keep the att socket, and defer attaching the attributes
+		 * until rebonding is done.
+		 */
+		if (!dev->att_rebond_io)
+			dev->att_rebond_io = g_io_channel_ref(io);
+		return false;
+	}
+
 	bt_io_get(io, &gerr, BT_IO_OPT_SEC_LEVEL, &sec_level,
 						BT_IO_OPT_INVALID);
 	if (gerr) {
@@ -4269,6 +4304,23 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 	}
 }
 
+bool device_rebonding_complete(struct btd_device *device, uint8_t bdaddr_type)
+{
+	bool ret = true;
+
+	DBG("");
+
+	device_set_rebonding(device, bdaddr_type, false);
+
+	if (bdaddr_type != BDADDR_BREDR && device->att_rebond_io) {
+		ret = device_attach_attrib(device, device->att_rebond_io);
+		g_io_channel_unref(device->att_rebond_io);
+		device->att_rebond_io = NULL;
+	}
+
+	return ret;
+}
+
 static gboolean svc_idle_cb(gpointer user_data)
 {
 	struct svc_callback *cb = user_data;
diff --git a/src/device.h b/src/device.h
index 2e0473e..65b1018 100644
--- a/src/device.h
+++ b/src/device.h
@@ -94,6 +94,10 @@ bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 							uint8_t status);
 gboolean device_is_bonding(struct btd_device *device, const char *sender);
+bool device_is_rebonding(struct btd_device *device, uint8_t bdaddr_type);
+void device_set_rebonding(struct btd_device *device, uint8_t bdaddr_type,
+				bool rebonding);
+bool device_complete_rebonding(struct btd_device *device, uint8_t bdaddr_type);
 void device_bonding_attempt_failed(struct btd_device *device, uint8_t status);
 void device_bonding_failed(struct btd_device *device, uint8_t status);
 struct btd_adapter_pin_cb_iter *device_bonding_iter(struct btd_device *device);
-- 
1.9.1

