Return-Path: <cyrus@holtmann.org>
From: Antti Julku <antti.julku@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antti Julku <antti.julku@nokia.com>
Subject: [PATCH BlueZ] Add support for blacklisting events
Date: Thu, 28 Jul 2011 15:00:22 +0300
Message-Id: <1311854423-1471-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for mgmt interface events for device blocking/unblocking.
Kernel sends a mgmt event when a device has been blocked by another
management socket or with ioctl command (e.g. by hciconfig).

Parameter update_only is added to device_block/unblock functions in
device.c to avoid code copying. When update_only is true, blocking
command is not sent to kernel, but only device status is updated and
dbus signal is sent.
---
 lib/mgmt.h        |   10 +++++++++
 plugins/mgmtops.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.c      |   27 +++++++++++++++----------
 src/device.h      |    5 ++++
 src/event.c       |   26 +++++++++++++++++++++++++
 src/event.h       |    2 +
 6 files changed, 113 insertions(+), 11 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index f22434e..260f8c0 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -305,3 +305,13 @@ struct mgmt_ev_remote_name {
 } __packed;
 
 #define MGMT_EV_DISCOVERING		0x0014
+
+#define MGMT_EV_DEVICE_BLOCKED		0x0015
+struct mgmt_ev_device_blocked {
+	bdaddr_t bdaddr;
+} __packed;
+
+#define MGMT_EV_DEVICE_UNBLOCKED	0x0016
+struct mgmt_ev_device_unblocked {
+	bdaddr_t bdaddr;
+} __packed;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 3cdb97e..9f6450c 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1385,6 +1385,54 @@ static void mgmt_discovering(int sk, uint16_t index, void *buf, size_t len)
 	adapter_set_state(adapter, state);
 }
 
+static void mgmt_device_blocked(int sk, uint16_t index, void *buf, size_t len)
+{
+	struct controller_info *info;
+	struct mgmt_ev_device_blocked *ev = buf;
+	char addr[18];
+
+	if (len < sizeof(*ev)) {
+		error("Too small mgmt_device_blocked event packet");
+		return;
+	}
+
+	ba2str(&ev->bdaddr, addr);
+	DBG("Device blocked, index %u, addr %s", index, addr);
+
+	if (index > max_index) {
+		error("Unexpected index %u in device_blocked event", index);
+		return;
+	}
+
+	info = &controllers[index];
+
+	btd_event_device_blocked(&info->bdaddr, &ev->bdaddr);
+}
+
+static void mgmt_device_unblocked(int sk, uint16_t index, void *buf, size_t len)
+{
+	struct controller_info *info;
+	struct mgmt_ev_device_unblocked *ev = buf;
+	char addr[18];
+
+	if (len < sizeof(*ev)) {
+		error("Too small mgmt_device_unblocked event packet");
+		return;
+	}
+
+	ba2str(&ev->bdaddr, addr);
+	DBG("Device unblocked, index %u, addr %s", index, addr);
+
+	if (index > max_index) {
+		error("Unexpected index %u in device_unblocked event", index);
+		return;
+	}
+
+	info = &controllers[index];
+
+	btd_event_device_unblocked(&info->bdaddr, &ev->bdaddr);
+}
+
 static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data)
 {
 	char buf[MGMT_BUF_SIZE];
@@ -1489,6 +1537,12 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 	case MGMT_EV_DISCOVERING:
 		mgmt_discovering(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
+	case MGMT_EV_DEVICE_BLOCKED:
+		mgmt_device_blocked(sk, index, buf + MGMT_HDR_SIZE, len);
+		break;
+	case MGMT_EV_DEVICE_UNBLOCKED:
+		mgmt_device_unblocked(sk, index, buf + MGMT_HDR_SIZE, len);
+		break;
 	default:
 		error("Unknown Management opcode %u (index %u)", opcode, index);
 		break;
diff --git a/src/device.c b/src/device.c
index 9dd657c..895c304 100644
--- a/src/device.c
+++ b/src/device.c
@@ -445,9 +445,10 @@ static gboolean do_disconnect(gpointer user_data)
 	return FALSE;
 }
 
-static int device_block(DBusConnection *conn, struct btd_device *device)
+int device_block(DBusConnection *conn, struct btd_device *device,
+						gboolean update_only)
 {
-	int err;
+	int err = 0;
 	bdaddr_t src;
 
 	if (device->blocked)
@@ -458,7 +459,9 @@ static int device_block(DBusConnection *conn, struct btd_device *device)
 
 	g_slist_foreach(device->drivers, (GFunc) driver_remove, device);
 
-	err = btd_adapter_block_address(device->adapter, &device->bdaddr);
+	if (!update_only)
+		err = btd_adapter_block_address(device->adapter, &device->bdaddr);
+
 	if (err < 0)
 		return err;
 
@@ -478,16 +481,18 @@ static int device_block(DBusConnection *conn, struct btd_device *device)
 	return 0;
 }
 
-static int device_unblock(DBusConnection *conn, struct btd_device *device,
-							gboolean silent)
+int device_unblock(DBusConnection *conn, struct btd_device *device,
+				gboolean silent, gboolean update_only)
 {
-	int err;
+	int err = 0;
 	bdaddr_t src;
 
 	if (!device->blocked)
 		return 0;
 
-	err = btd_adapter_unblock_address(device->adapter, &device->bdaddr);
+	if (!update_only)
+		err = btd_adapter_unblock_address(device->adapter, &device->bdaddr);
+
 	if (err < 0)
 		return err;
 
@@ -516,9 +521,9 @@ static DBusMessage *set_blocked(DBusConnection *conn, DBusMessage *msg,
 	int err;
 
 	if (value)
-		err = device_block(conn, device);
+		err = device_block(conn, device, FALSE);
 	else
-		err = device_unblock(conn, device, FALSE);
+		err = device_unblock(conn, device, FALSE, FALSE);
 
 	switch (-err) {
 	case 0:
@@ -938,7 +943,7 @@ struct btd_device *device_create(DBusConnection *conn,
 	device->trusted = read_trust(&src, address, GLOBAL_TRUST);
 
 	if (read_blocked(&src, &device->bdaddr))
-		device_block(conn, device);
+		device_block(conn, device, FALSE);
 
 	if (read_link_key(&src, &device->bdaddr, NULL, NULL) == 0) {
 		device_set_paired(device, TRUE);
@@ -1003,7 +1008,7 @@ static void device_remove_stored(struct btd_device *device)
 	delete_device_service(&src, &device->bdaddr);
 
 	if (device->blocked)
-		device_unblock(conn, device, TRUE);
+		device_unblock(conn, device, TRUE, FALSE);
 }
 
 void device_remove(struct btd_device *device, gboolean remove_stored)
diff --git a/src/device.h b/src/device.h
index 6efcf63..b6349bc 100644
--- a/src/device.h
+++ b/src/device.h
@@ -116,3 +116,8 @@ void btd_unregister_device_driver(struct btd_device_driver *driver);
 
 struct btd_device *btd_device_ref(struct btd_device *device);
 void btd_device_unref(struct btd_device *device);
+
+int device_block(DBusConnection *conn, struct btd_device *device,
+						gboolean update_only);
+int device_unblock(DBusConnection *conn, struct btd_device *device,
+					gboolean silent, gboolean update_only);
diff --git a/src/event.c b/src/event.c
index d86eb28..b17da62 100644
--- a/src/event.c
+++ b/src/event.c
@@ -469,6 +469,32 @@ void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer)
 	adapter_remove_connection(adapter, device);
 }
 
+void btd_event_device_blocked(bdaddr_t *local, bdaddr_t *peer)
+{
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+
+	DBusConnection *conn = get_dbus_connection();
+
+	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
+		return;
+
+	device_block(conn, device, TRUE);
+}
+
+void btd_event_device_unblocked(bdaddr_t *local, bdaddr_t *peer)
+{
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+
+	DBusConnection *conn = get_dbus_connection();
+
+	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
+		return;
+
+	device_unblock(conn, device, FALSE, TRUE);
+}
+
 /* Section reserved to device HCI callbacks */
 
 void btd_event_returned_link_key(bdaddr_t *local, bdaddr_t *peer)
diff --git a/src/event.h b/src/event.h
index 1268edf..d93a361 100644
--- a/src/event.h
+++ b/src/event.h
@@ -38,5 +38,7 @@ void btd_event_returned_link_key(bdaddr_t *local, bdaddr_t *peer);
 int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
 int btd_event_user_passkey(bdaddr_t *sba, bdaddr_t *dba);
 int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
+void btd_event_device_blocked(bdaddr_t *local, bdaddr_t *peer);
+void btd_event_device_unblocked(bdaddr_t *local, bdaddr_t *peer);
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 					uint8_t key_type, uint8_t pin_length);
-- 
1.7.2.5

