Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/4] Add support for Out of Band (OOB) association model.
Date: Thu, 4 Nov 2010 11:10:58 +0100
Message-ID: <1288865461-3760-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
References: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am      |    3 +-
 lib/hci.h        |    3 ++
 plugins/hciops.c |   70 +++++++++++++++++++++++++++++++++++++++--------
 src/adapter.c    |    5 +++
 src/adapter.h    |    3 ++
 src/device.c     |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/device.h     |   12 ++++++++
 src/event.c      |   73 +++++++++++++++++++++++++++++++++++++------------
 src/event.h      |    3 +-
 src/oob.c        |   61 +++++++++++++++++++++++++++++++++++++++++
 src/oob.h        |   47 +++++++++++++++++++++++++++++++
 11 files changed, 326 insertions(+), 34 deletions(-)
 create mode 100644 src/oob.c
 create mode 100644 src/oob.h

diff --git a/Makefile.am b/Makefile.am
index 873f2df..1b71cc4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -238,7 +238,8 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/adapter.h src/adapter.c \
 			src/device.h src/device.c \
 			src/dbus-common.c src/dbus-common.h \
-			src/event.h src/event.c
+			src/event.h src/event.c \
+			src/oob.c
 src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
 							@CAPNG_LIBS@ -ldl -lrt
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
diff --git a/lib/hci.h b/lib/hci.h
index 0cb120f..409abd9 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -524,6 +524,9 @@ typedef struct {
 
 #define OCF_REMOTE_OOB_DATA_NEG_REPLY	0x0033
 
+#define OOB_DATA_NOT_PRESENT	0x00
+#define OOB_DATA_PRESENT	0x01
+
 #define OCF_IO_CAPABILITY_NEG_REPLY	0x0034
 typedef struct {
 	bdaddr_t	bdaddr;
diff --git a/plugins/hciops.c b/plugins/hciops.c
index 8a79010..d8a1d2c 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3,6 +3,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2010  ST-Ericsson SA
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -47,6 +48,7 @@
 #include "event.h"
 #include "device.h"
 #include "manager.h"
+#include "oob.h"
 
 #define HCI_REQ_TIMEOUT         5000
 
@@ -504,33 +506,45 @@ static void user_passkey_notify(int dev, bdaddr_t *sba, void *ptr)
 
 static void remote_oob_data_request(int dev, bdaddr_t *sba, void *ptr)
 {
-	hci_send_cmd(dev, OGF_LINK_CTL, OCF_REMOTE_OOB_DATA_NEG_REPLY, 6, ptr);
+	bdaddr_t *dba = ptr;
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+	char da[18];
+
+	ba2str(dba, da);
+	adapter = manager_find_adapter(sba);
+	device = adapter_find_device(adapter, da);
+
+	if (device_has_oob_data(device)) {
+		remote_oob_data_reply_cp cp;
+
+		bacpy(&cp.bdaddr, dba);
+		device_get_oob_data(device,cp.hash,cp.randomizer);
+
+		hci_send_cmd(dev, OGF_LINK_CTL, OCF_REMOTE_OOB_DATA_REPLY,
+				REMOTE_OOB_DATA_REPLY_CP_SIZE, &cp);
+	} else
+		hci_send_cmd(dev, OGF_LINK_CTL, OCF_REMOTE_OOB_DATA_NEG_REPLY,
+				6, ptr);
 }
 
 static void io_capa_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
 {
 	char sa[18], da[18];
-	uint8_t cap, auth;
 
 	ba2str(sba, sa); ba2str(dba, da);
 	info("io_capa_request (sba=%s, dba=%s)", sa, da);
 
-	if (btd_event_get_io_cap(sba, dba, &cap, &auth) < 0) {
+	/* If failed to establish IO capabilities then send negative reply
+	 * immediately. Positive reply will be sent when IO capabilities are
+	 * established. */
+	if (btd_event_request_io_cap(sba, dba)) {
 		io_capability_neg_reply_cp cp;
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.bdaddr, dba);
 		cp.reason = HCI_PAIRING_NOT_ALLOWED;
 		hci_send_cmd(dev, OGF_LINK_CTL, OCF_IO_CAPABILITY_NEG_REPLY,
 					IO_CAPABILITY_NEG_REPLY_CP_SIZE, &cp);
-	} else {
-		io_capability_reply_cp cp;
-		memset(&cp, 0, sizeof(cp));
-		bacpy(&cp.bdaddr, dba);
-		cp.capability = cap;
-		cp.oob_data = 0x00;
-		cp.authentication = auth;
-		hci_send_cmd(dev, OGF_LINK_CTL, OCF_IO_CAPABILITY_REPLY,
-					IO_CAPABILITY_REPLY_CP_SIZE, &cp);
 	}
 }
 
@@ -731,6 +745,15 @@ static void read_scan_complete(bdaddr_t *sba, uint8_t status, void *ptr)
 	adapter_mode_changed(adapter, rp->enable);
 }
 
+static void read_local_oob_data_complete(bdaddr_t *local, uint8_t status,
+		read_local_oob_data_rp *rp)
+{
+	if (status)
+		oob_local_data_updated(local, NULL, NULL);
+	else
+		oob_local_data_updated(local, rp->hash, rp->randomizer);
+}
+
 static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 {
 	evt_cmd_complete *evt = ptr;
@@ -785,6 +808,10 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 		ptr += sizeof(evt_cmd_complete);
 		adapter_update_tx_power(sba, status, ptr);
 		break;
+	case cmd_opcode_pack(OGF_HOST_CTL, OCF_READ_LOCAL_OOB_DATA):
+		ptr += sizeof(evt_cmd_complete);
+		read_local_oob_data_complete(sba, status, ptr);
+		break;
 	};
 }
 
@@ -2289,6 +2316,24 @@ static int hciops_get_remote_version(int index, uint16_t handle,
 	return 0;
 }
 
+static int hciops_read_local_oob_data(int index)
+{
+	int dd;
+	int err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	err = hci_send_cmd(dd, OGF_HOST_CTL, OCF_READ_LOCAL_OOB_DATA, 0, 0);
+	if (err < 0)
+		err = -errno;
+
+	hci_close_dev(dd);
+
+	return err;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -2335,6 +2380,7 @@ static struct btd_adapter_ops hci_ops = {
 	.write_le_host = hciops_write_le_host,
 	.get_remote_version = hciops_get_remote_version,
 	.encrypt_link = hciops_encrypt_link,
+	.read_local_oob_data = hciops_read_local_oob_data,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index b25a7fc..3ec562b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3752,3 +3752,8 @@ int btd_adapter_encrypt_link(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 {
 	return adapter_ops->encrypt_link(adapter->dev_id, bdaddr, cb, user_data);
 }
+
+int btd_adapter_read_local_oob_data(struct btd_adapter *adapter)
+{
+	return adapter_ops->read_local_oob_data(adapter->dev_id);
+}
diff --git a/src/adapter.h b/src/adapter.h
index aa4d686..4ca82b3 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -231,6 +231,7 @@ struct btd_adapter_ops {
 						gboolean delayed);
 	int (*encrypt_link) (int index, bdaddr_t *bdaddr, bt_hci_result_t cb,
 							gpointer user_data);
+	int (*read_local_oob_data) (int index);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *ops, gboolean priority);
@@ -291,3 +292,5 @@ int btd_adapter_get_remote_version(struct btd_adapter *adapter,
 
 int btd_adapter_encrypt_link(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				bt_hci_result_t cb, gpointer user_data);
+
+int btd_adapter_read_local_oob_data(struct btd_adapter *adapter);
diff --git a/src/device.c b/src/device.c
index b14865c..31cfd89 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2010  ST-Ericsson SA
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -59,6 +60,7 @@
 #include "sdp-xml.h"
 #include "storage.h"
 #include "btio.h"
+#include "oob.h"
 
 #define DEFAULT_XML_BUF_SIZE	1024
 #define DISCONNECT_TIMER	2
@@ -132,6 +134,9 @@ struct btd_device {
 	uint8_t		cap;
 	uint8_t		auth;
 
+	uint8_t		local_cap;
+	uint8_t		local_auth;
+
 	uint16_t	handle;			/* Connection handle */
 
 	/* Whether were creating a security mode 3 connection */
@@ -149,6 +154,13 @@ struct btd_device {
 
 	gboolean	has_debug_key;
 	uint8_t		debug_key[16];
+
+	/* For OOB association model */
+	void (*oob_request_cb)(struct btd_device *device);
+	gboolean	was_oob_ssp;
+	gboolean	has_oob_data;
+	uint8_t		hash[16];
+	uint8_t		randomizer[16];
 };
 
 static uint16_t uuid_list[] = {
@@ -830,6 +842,72 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+void device_set_oob_data(struct btd_device *device, uint8_t *hash,
+		uint8_t *randomizer)
+{
+	if (!device)
+		return;
+
+	if (hash && randomizer) {
+		memcpy(device->hash, hash, 16);
+		memcpy(device->randomizer, randomizer, 16);
+		device->has_oob_data = TRUE;
+		device->was_oob_ssp = TRUE;
+	}
+
+	if (device->oob_request_cb) {
+		device->oob_request_cb(device);
+		device->oob_request_cb = NULL;
+	}
+}
+
+gboolean device_get_oob_data(struct btd_device *device, uint8_t *hash,
+		uint8_t *randomizer)
+{
+	if (!device || !device->has_oob_data)
+		return FALSE;
+
+	memcpy(hash, device->hash, 16);
+	memcpy(randomizer, device->randomizer, 16);
+	device->has_oob_data = FALSE;
+
+	return TRUE;
+}
+
+gboolean device_has_oob_data(struct btd_device *device)
+{
+	return device && device->has_oob_data;
+}
+
+gboolean device_request_oob_data(struct btd_device *device, void *cb)
+{
+	if (!device)
+		return FALSE;
+
+	device->was_oob_ssp = FALSE;
+	device->oob_request_cb = cb;
+	return oob_request_remote_data(device);
+}
+
+void device_set_local_auth_cap(struct btd_device *device, uint8_t auth,
+		uint8_t cap)
+{
+	if (!device)
+		return;
+
+	device->local_auth = auth;
+	device->local_cap = cap;
+}
+void device_get_local_auth_cap(struct btd_device *device, uint8_t *auth,
+		uint8_t *cap)
+{
+	if (!device)
+		return;
+
+	*auth = device->local_auth;
+	*cap = device->local_cap;
+}
+
 static GDBusMethodTable device_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",	get_properties	},
 	{ "SetProperty",	"sv",	"",		set_property	},
@@ -2282,7 +2360,7 @@ void device_cancel_authentication(struct btd_device *device, gboolean aborted)
 
 gboolean device_is_authenticating(struct btd_device *device)
 {
-	return (device->authr != NULL);
+	return (device->authr != NULL || device->was_oob_ssp);
 }
 
 gboolean device_is_authorizing(struct btd_device *device)
diff --git a/src/device.h b/src/device.h
index b570bd1..b62cdc5 100644
--- a/src/device.h
+++ b/src/device.h
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2010  ST-Ericsson SA
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -89,6 +90,17 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn,
 gboolean device_has_connection(struct btd_device *device, uint16_t handle);
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
 
+void device_set_oob_data(struct btd_device *device, uint8_t *hash,
+		uint8_t *randomizer);
+gboolean device_get_oob_data(struct btd_device *device, uint8_t *hash,
+		uint8_t *randomizer);
+gboolean device_has_oob_data(struct btd_device *device);
+gboolean device_request_oob_data(struct btd_device *device, void *cb);
+void device_set_local_auth_cap(struct btd_device *device, uint8_t auth,
+		uint8_t cap);
+void device_get_local_auth_cap(struct btd_device *device, uint8_t *auth,
+		uint8_t *cap);
+
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
 					void *user_data);
 
diff --git a/src/event.c b/src/event.c
index 60249f0..b551020 100644
--- a/src/event.c
+++ b/src/event.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2010  ST-Ericsson SA
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -757,26 +758,56 @@ void btd_event_returned_link_key(bdaddr_t *local, bdaddr_t *peer)
 	device_set_paired(device, TRUE);
 }
 
-int btd_event_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
-						uint8_t *cap, uint8_t *auth)
+static void btd_event_io_cap_reply(struct btd_device *device)
+{
+	io_capability_reply_cp cp;
+	int dev;
+	struct btd_adapter *adapter = device_get_adapter(device);
+	uint16_t dev_id = adapter_get_dev_id(adapter);
+
+	dev = hci_open_dev(dev_id);
+	if (dev < 0) {
+		error("hci_open_dev(%d): %s (%d)", dev_id,
+		strerror(errno), errno);
+		return;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	device_get_address(device, &cp.bdaddr);
+	device_get_local_auth_cap(device, &cp.authentication, &cp.capability);
+	cp.oob_data = device_has_oob_data(device)
+			? OOB_DATA_PRESENT : OOB_DATA_NOT_PRESENT;
+
+	DBG("final capabilities reply is cap=0x%02x, auth=0x%02x, oob=0x%02x",
+	cp.capability, cp.authentication, cp.oob_data);
+
+	hci_send_cmd(dev, OGF_LINK_CTL, OCF_IO_CAPABILITY_REPLY,
+					IO_CAPABILITY_REPLY_CP_SIZE, &cp);
+
+	hci_close_dev(dev);
+}
+
+int btd_event_request_io_cap(bdaddr_t *local, bdaddr_t *remote)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
 	struct agent *agent = NULL;
 	uint8_t agent_cap;
 	int err;
+	uint8_t cap;
+	uint8_t auth;
 
 	if (!get_adapter_and_device(local, remote, &adapter, &device, TRUE))
 		return -ENODEV;
 
-	err = btd_adapter_get_auth_info(adapter, remote, auth);
+	err = btd_adapter_get_auth_info(adapter, remote, &auth);
 	if (err < 0)
 		return err;
 
-	DBG("initial authentication requirement is 0x%02x", *auth);
+	DBG("initial authentication requirement is 0x%02x", auth);
 
-	if (*auth == 0xff)
-		*auth = device_get_auth(device);
+	if (auth == 0xff)
+		auth = device_get_auth(device);
 
 	/* Check if the adapter is not pairable and if there isn't a bonding
 	 * in progress */
@@ -785,11 +816,11 @@ int btd_event_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
 		if (device_get_auth(device) < 0x02) {
 			DBG("Allowing no bonding in non-bondable mode");
 			/* No input, no output */
-			*cap = 0x03;
+			cap = 0x03;
 			/* Kernel defaults to general bonding and so
 			 * overwrite for this special case. Otherwise
 			 * non-pairable test cases will fail. */
-			*auth = 0x00;
+			auth = 0x00;
 			goto done;
 		}
 		return -EPERM;
@@ -805,13 +836,13 @@ int btd_event_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
 		}
 
 		/* No agent available, and no bonding case */
-		if (*auth == 0x00 || *auth == 0x04) {
+		if (auth == 0x00 || auth == 0x04) {
 			DBG("Allowing no bonding without agent");
 			/* No input, no output */
-			*cap = 0x03;
+			cap = 0x03;
 			/* If kernel defaults to general bonding, set it
 			 * back to no bonding */
-			*auth = 0x00;
+			auth = 0x00;
 			goto done;
 		}
 
@@ -821,7 +852,7 @@ int btd_event_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
 
 	agent_cap = agent_get_io_capability(agent);
 
-	if (*auth == 0x00 || *auth == 0x04) {
+	if (auth == 0x00 || auth == 0x04) {
 		/* If remote requests dedicated bonding follow that lead */
 		if (device_get_auth(device) == 0x02 ||
 				device_get_auth(device) == 0x03) {
@@ -830,9 +861,9 @@ int btd_event_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
 			 * then require it, otherwise don't */
 			if (device_get_cap(device) == 0x03 ||
 							agent_cap == 0x03)
-				*auth = 0x02;
+				auth = 0x02;
 			else
-				*auth = 0x03;
+				auth = 0x03;
 		}
 
 		/* If remote indicates no bonding then follow that. This
@@ -840,7 +871,7 @@ int btd_event_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
 		 * as default. */
 		if (device_get_auth(device) == 0x00 ||
 					device_get_auth(device) == 0x01)
-			*auth = 0x00;
+			auth = 0x00;
 
 		/* If remote requires MITM then also require it, unless
 		 * our IO capability is NoInputNoOutput (so some
@@ -848,13 +879,19 @@ int btd_event_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
 		if (device_get_auth(device) != 0xff &&
 					(device_get_auth(device) & 0x01) &&
 					agent_cap != 0x03)
-			*auth |= 0x01;
+			auth |= 0x01;
 	}
 
-	*cap = agent_get_io_capability(agent);
+	cap = agent_get_io_capability(agent);
 
 done:
-	DBG("final authentication requirement is 0x%02x", *auth);
+	DBG("final authentication requirement is 0x%02x", auth);
+
+	device_set_local_auth_cap(device, auth, cap);
+
+	/* If failed to request remote OOB data then reply immediately. */
+	if (!device_request_oob_data(device, btd_event_io_cap_reply))
+		btd_event_io_cap_reply(device);
 
 	return 0;
 }
diff --git a/src/event.h b/src/event.h
index e918c9e..33d2f76 100644
--- a/src/event.h
+++ b/src/event.h
@@ -36,8 +36,7 @@ void btd_event_le_set_scan_enable_complete(bdaddr_t *local, uint8_t status);
 void btd_event_write_simple_pairing_mode_complete(bdaddr_t *local);
 void btd_event_read_simple_pairing_mode_complete(bdaddr_t *local, void *ptr);
 void btd_event_returned_link_key(bdaddr_t *local, bdaddr_t *peer);
-int btd_event_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
-						uint8_t *cap, uint8_t *auth);
+int btd_event_request_io_cap(bdaddr_t *local, bdaddr_t *remote);
 int btd_event_set_io_cap(bdaddr_t *local, bdaddr_t *remote,
 						uint8_t cap, uint8_t auth);
 int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
diff --git a/src/oob.c b/src/oob.c
new file mode 100644
index 0000000..cc20c67
--- /dev/null
+++ b/src/oob.c
@@ -0,0 +1,61 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010  ST-Ericsson SA
+ *
+ *  Author: Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <glib.h>
+#include "manager.h"
+#include "adapter.h"
+#include "oob.h"
+
+static struct oob_plugin *active_plugin = NULL;
+
+void oob_activate_plugin(struct oob_plugin *plugin)
+{
+	if (!plugin || !plugin->local_data_updated|| !plugin->plugin_deactivated
+			|| !plugin->request_remote_data
+			|| active_plugin == plugin)
+		return;
+
+	if (active_plugin)
+		active_plugin->plugin_deactivated();
+
+	active_plugin = plugin;
+}
+
+void oob_deactivate_plugin(struct oob_plugin *plugin)
+{
+	if (active_plugin == plugin)
+		active_plugin = NULL;
+}
+
+gboolean oob_request_remote_data(struct btd_device *device)
+{
+	return active_plugin && active_plugin->request_remote_data(device);
+}
+
+void oob_local_data_updated(bdaddr_t *ba, uint8_t *hash, uint8_t *randomizer)
+{
+	if (active_plugin)
+		active_plugin->local_data_updated(ba, hash, randomizer);
+}
diff --git a/src/oob.h b/src/oob.h
new file mode 100644
index 0000000..ed9fe84
--- /dev/null
+++ b/src/oob.h
@@ -0,0 +1,47 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010  ST-Ericsson SA
+ *
+ *  Author: Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct oob_plugin
+{
+	/* If request was successfully send this functions should return TRUE.
+	 * Function should not block for too long. */
+	gboolean (*request_remote_data)(struct btd_device *device);
+
+	/* Local OOB data updated. If corresponding HCI command failed, hash
+	 * and randomizer are NULL */
+	void (*local_data_updated)(bdaddr_t *ba, uint8_t *hash,
+			uint8_t *randomizer);
+
+	/* Plug-in was deactivated (called only for active plug-in). */
+	void (*plugin_deactivated)(void);
+};
+
+/* These functions are called by OOB plug-in.*/
+void oob_activate_plugin(struct oob_plugin *plugin);
+void oob_deactivate_plugin(struct oob_plugin *plugin);
+
+/* These functions are called from stack to interact with OOB plug-in. */
+gboolean oob_request_remote_data(struct btd_device *device);
+void oob_local_data_updated(bdaddr_t *ba, uint8_t *hash, uint8_t *randomizer);
-- 
1.7.1

