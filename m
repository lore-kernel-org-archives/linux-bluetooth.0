Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 2/3] core: Fix associating a GAttrib to a device on incoming connections
Date: Tue, 28 Jan 2014 11:51:37 -0400
Message-Id: <1390924298-13804-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1390924298-13804-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390924298-13804-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If BlueZ is running as slave, incoming connections using ATT CID will
have a GAttrib created for them. But this GAttrib will not be assigned
to the underlying device (whose struct btd_device instance was created
in response to the Device Connected mgmt event).

This patch fixes this by assigning the GAttrib to the btd_device as soon
as a connection is first requested, which is done using attio callbacks.

Note that a new GAttrib reference is taken because attio callbacks "own"
device->attrib and thus need their own reference.
---
 src/attrib-server.c | 22 ++++++++++++++++++++++
 src/attrib-server.h |  1 +
 src/device.c        |  5 +++++
 3 files changed, 28 insertions(+)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 13b86e1..7a50022 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1100,6 +1100,28 @@ done:
 	g_attrib_send(channel->attrib, 0, opdu, length, NULL, NULL, NULL);
 }
 
+GAttrib *attrib_from_device(struct btd_device *device)
+{
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct gatt_server *server;
+	GSList *l;
+
+	l = g_slist_find_custom(servers, adapter, adapter_cmp);
+	if (!l)
+		return NULL;
+
+	server = l->data;
+
+	for (l = server->clients; l; l = l->next) {
+		struct gatt_channel *channel = l->data;
+
+		if (channel->device == device)
+			return g_attrib_ref(channel->attrib);
+	}
+
+	return NULL;
+}
+
 guint attrib_channel_attach(GAttrib *attrib)
 {
 	struct gatt_server *server;
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 90ba17c..063cb66 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -37,5 +37,6 @@ int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
 uint32_t attrib_create_sdp(struct btd_adapter *adapter, uint16_t handle,
 							const char *name);
 void attrib_free_sdp(struct btd_adapter *adapter, uint32_t sdp_handle);
+GAttrib *attrib_from_device(struct btd_device *device);
 guint attrib_channel_attach(GAttrib *attrib);
 gboolean attrib_channel_detach(GAttrib *attrib, guint id);
diff --git a/src/device.c b/src/device.c
index 41a6fc8..f771b63 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4470,6 +4470,11 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 
 	device_set_auto_connect(device, TRUE);
 
+	/* Check if there is no GAttrib associated to the device created by a
+	 * incoming connection */
+	if (!device->attrib)
+		device->attrib = attrib_from_device(device);
+
 	if (device->attrib && cfunc) {
 		device->attios_offline = g_slist_append(device->attios_offline,
 									attio);
-- 
1.8.3.2

