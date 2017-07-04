Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/10] gatt: Add implementation of AcquireWrite
Date: Tue,  4 Jul 2017 18:09:30 +0300
Message-Id: <20170704150937.11701-4-luiz.dentz@gmail.com>
In-Reply-To: <20170704150937.11701-1-luiz.dentz@gmail.com>
References: <20170704150937.11701-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements AcquireWrite creating a pipe and passing the write fd
to the application requesting it:

bluetoothd[29915]: src/gatt-client.c:characteristic_create_pipe() AcquireWrite: sender :1.378 io 0x89cdfe0

The fd is monitored and in case the client decides close it, or exit/crash,
the daemon detects the HUP and cleanup properly:

bluetoothd[29915]: src/gatt-client.c:characteristic_pipe_hup() /org/bluez/hci1/dev_00_1B_DC_07_31_88/service001f/char0020: io 0x89cdfe0
---
 src/device.c      |   8 ++-
 src/gatt-client.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 8cb79df..6a9936a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -551,7 +551,13 @@ static void gatt_client_cleanup(struct btd_device *device)
 
 	gatt_cache_cleanup(device);
 	bt_gatt_client_set_service_changed(device->client, NULL, NULL, NULL);
-	bt_gatt_client_ready_unregister(device->client, device->gatt_ready_id);
+
+	if (device->gatt_ready_id > 0) {
+		bt_gatt_client_ready_unregister(device->client,
+						device->gatt_ready_id);
+		device->gatt_ready_id = 0;
+	}
+
 	bt_gatt_client_unref(device->client);
 	device->client = NULL;
 }
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 6c67841..9a660df 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -24,6 +24,8 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
 
 #include <dbus/dbus.h>
 
@@ -37,6 +39,7 @@
 #include "error.h"
 #include "adapter.h"
 #include "device.h"
+#include "src/shared/io.h"
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
@@ -97,6 +100,10 @@ struct characteristic {
 	bt_uuid_t uuid;
 	char *path;
 
+	unsigned int ready_id;
+	DBusMessage *acquire_write;
+	struct io *write_io;
+
 	struct async_dbus_op *read_op;
 	struct async_dbus_op *write_op;
 
@@ -990,6 +997,151 @@ fail:
 	return btd_error_not_supported(msg);
 }
 
+static bool chrc_pipe_read(struct io *io, void *user_data)
+{
+	struct characteristic *chrc = user_data;
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+	uint8_t buf[512];
+	int fd = io_get_fd(io);
+	ssize_t bytes_read;
+
+	bytes_read = read(fd, buf, sizeof(buf));
+	if (bytes_read < 0)
+		return false;
+
+	if (!gatt)
+		return false;
+
+	bt_gatt_client_write_without_response(gatt, chrc->value_handle,
+					chrc->props & BT_GATT_CHRC_PROP_AUTH,
+					buf, bytes_read);
+
+	return true;
+}
+
+static void characteristic_destroy_pipe(struct characteristic *chrc,
+							struct io *io)
+{
+	if (io == chrc->write_io) {
+		io_destroy(chrc->write_io);
+		chrc->write_io = NULL;
+	}
+}
+
+static bool characteristic_pipe_hup(struct io *io, void *user_data)
+{
+	struct characteristic *chrc = user_data;
+
+	DBG("%s: io %p", chrc->path, io);
+
+	characteristic_destroy_pipe(chrc, io);
+
+	return false;
+}
+
+static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
+						DBusMessage *msg)
+{
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+	int pipefd[2];
+	struct io *io;
+	bool dir;
+	uint16_t mtu;
+	DBusMessage *reply;
+
+	if (!gatt || !bt_gatt_client_is_ready(gatt))
+		return btd_error_failed(msg, "Not connected");
+
+	if (pipe2(pipefd, O_DIRECT | O_NONBLOCK | O_CLOEXEC) < 0)
+		return btd_error_failed(msg, strerror(errno));
+
+	dir = dbus_message_has_member(msg, "AcquireWrite");
+
+	io = io_new(pipefd[!dir]);
+	if (!io) {
+		close(pipefd[0]);
+		close(pipefd[1]);
+		return btd_error_failed(msg, strerror(EIO));
+	}
+
+	io_set_close_on_destroy(io, true);
+
+	if (!io_set_read_handler(io, chrc_pipe_read, chrc, NULL))
+		goto fail;
+
+	if (!io_set_disconnect_handler(io, characteristic_pipe_hup, chrc, NULL))
+		goto fail;
+
+	mtu = bt_gatt_client_get_mtu(gatt);
+
+	reply = g_dbus_create_reply(msg, DBUS_TYPE_UNIX_FD, &pipefd[dir],
+					DBUS_TYPE_UINT16, &mtu,
+					DBUS_TYPE_INVALID);
+
+	close(pipefd[dir]);
+
+	if (dir)
+		chrc->write_io = io;
+
+	DBG("%s: sender %s io %p", dbus_message_get_member(msg),
+					dbus_message_get_sender(msg), io);
+
+	return reply;
+
+fail:
+	io_destroy(io);
+	close(pipefd[dir]);
+	return btd_error_failed(msg, strerror(EIO));
+}
+
+static void characteristic_ready(bool success, uint8_t ecode, void *user_data)
+{
+	struct characteristic *chrc = user_data;
+	DBusMessage *reply;
+
+	chrc->ready_id = 0;
+
+	if (chrc->acquire_write) {
+		reply = characteristic_create_pipe(chrc, chrc->acquire_write);
+
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+		dbus_message_unref(chrc->acquire_write);
+		chrc->acquire_write = NULL;
+	}
+}
+
+static DBusMessage *characteristic_acquire_write(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct characteristic *chrc = user_data;
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+
+	if (!gatt)
+		return btd_error_failed(msg, "Not connected");
+
+	if (chrc->write_io || chrc->acquire_write)
+		return btd_error_failed(msg, strerror(EBUSY));
+
+	if (chrc->write_op)
+		return btd_error_in_progress(msg);
+
+	if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
+		return btd_error_not_supported(msg);
+
+	if (!bt_gatt_client_is_ready(gatt)) {
+		DBG("GATT not ready, wait until it becomes read");
+		if (!chrc->ready_id)
+			chrc->ready_id = bt_gatt_client_ready_register(gatt,
+							characteristic_ready,
+							chrc, NULL);
+		chrc->acquire_write = dbus_message_ref(msg);
+		return NULL;
+	}
+
+	return characteristic_create_pipe(chrc, msg);
+}
+
 struct notify_client {
 	struct characteristic *chrc;
 	int ref_count;
@@ -1265,6 +1417,10 @@ static const GDBusMethodTable characteristic_methods[] = {
 						{ "options", "a{sv}" }),
 					NULL,
 					characteristic_write_value) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("AcquireWrite", NULL,
+					GDBUS_ARGS({ "fd", "h" },
+						{ "mtu", "q" }),
+					characteristic_acquire_write) },
 	{ GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL,
 					characteristic_start_notify) },
 	{ GDBUS_METHOD("StopNotify", NULL, NULL,
@@ -1280,6 +1436,11 @@ static void characteristic_free(void *data)
 	queue_destroy(chrc->descs, NULL);
 	queue_destroy(chrc->notify_clients, NULL);
 
+	io_destroy(chrc->write_io);
+
+	if (chrc->acquire_write)
+		dbus_message_unref(chrc->acquire_write);
+
 	g_free(chrc->path);
 	free(chrc);
 }
-- 
2.9.4

