Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [[RFC] 1/2] android/avrcp: Split AVRCP into TG and CT
Date: Tue, 23 Dec 2014 15:48:05 +0100
Message-Id: <1419346086-26687-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1419346086-26687-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1419346086-26687-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Proposal RFC for splitting AVRCP into target, control role and common
functionality. Init, registering are done seperately for roles. Both
roles should have access for shared list of connected devices, sessions.
Common part contain list of devices and its session. CT/TG can add,
remove, get devices.
---
 android/Android.mk     |   2 +
 android/Makefile.am    |   2 +
 android/avrcp-common.c | 360 ++++++++++++++++++++++++++++++++++++++
 android/avrcp-common.h |  48 +++++
 android/avrcp-ctrl.c   | 165 ++++++++++++++++++
 android/avrcp-ctrl.h   |  26 +++
 android/avrcp.c        | 464 ++++---------------------------------------------
 android/main.c         |  11 ++
 8 files changed, 643 insertions(+), 435 deletions(-)
 create mode 100644 android/avrcp-common.c
 create mode 100644 android/avrcp-common.h
 create mode 100644 android/avrcp-ctrl.c
 create mode 100644 android/avrcp-ctrl.h

diff --git a/android/Android.mk b/android/Android.mk
index c1a9eff..44abe4e 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -48,7 +48,9 @@ LOCAL_SRC_FILES := \
 	bluez/android/a2dp.c \
 	bluez/android/a2dp-sink.c \
 	bluez/android/avctp.c \
+	bluez/android/avrcp-common.c \
 	bluez/android/avrcp.c \
+	bluez/android/avrcp-ctrl.c \
 	bluez/android/avrcp-lib.c \
 	bluez/android/pan.c \
 	bluez/android/handsfree.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index dbc3780..e1c44ce 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -38,7 +38,9 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/a2dp.h android/a2dp.c \
 				android/a2dp-sink.h android/a2dp-sink.c \
 				android/avctp.h android/avctp.c \
+				android/avrcp-common.h android/avrcp-common.c \
 				android/avrcp.h android/avrcp.c \
+				android/avrcp-ctrl.h android/avrcp-ctrl.c \
 				android/avrcp-lib.h android/avrcp-lib.c \
 				android/socket.h android/socket.c \
 				android/sco.h android/sco.c \
diff --git a/android/avrcp-common.c b/android/avrcp-common.c
new file mode 100644
index 0000000..30b6b3a
--- /dev/null
+++ b/android/avrcp-common.c
@@ -0,0 +1,360 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <stdlib.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <glib.h>
+
+#include "btio/btio.h"
+#include "lib/bluetooth.h"
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "src/sdp-client.h"
+#include "src/log.h"
+
+#include "avrcp-lib.h"
+#include "avrcp-common.h"
+#include "hal-msg.h"
+
+static bdaddr_t adapter_addr;
+static GIOChannel *server = NULL;
+static GSList *devices = NULL;
+
+static int device_cmp(gconstpointer s, gconstpointer user_data)
+{
+	const struct avrcp_device *dev = s;
+	const bdaddr_t *dst = user_data;
+
+	return bacmp(&dev->dst, dst);
+}
+
+struct avrcp_device *get_avrcp_device(const bdaddr_t *dst)
+{
+	GSList *l;
+
+	/*
+	 * Peek the first device since the HAL cannot really address a specific
+	 * device it might mean there could only be one connected.
+	 */
+	if (!dst && devices)
+		return devices->data;
+
+	l = g_slist_find_custom(devices, dst, device_cmp);
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
+static void free_avrcp_device(void *data)
+{
+	struct avrcp_device *dev = data;
+
+	if (dev->queue) {
+		g_queue_foreach(dev->queue, (GFunc) g_free, NULL);
+		g_queue_free(dev->queue);
+	}
+
+	if (dev->session)
+		avrcp_shutdown(dev->session);
+
+	if (dev->io) {
+		g_io_channel_shutdown(dev->io, FALSE, NULL);
+		g_io_channel_unref(dev->io);
+	}
+
+	g_free(dev);
+}
+
+void remove_avrcp_device(struct avrcp_device *dev)
+{
+	devices = g_slist_remove(devices, dev);
+	free_avrcp_device(dev);
+}
+
+struct avrcp_request *pop_request(uint8_t pdu_id, uint8_t event_id, bool peek)
+{
+	GSList *l;
+
+	for (l = devices; l; l = g_slist_next(l)) {
+		struct avrcp_device *dev = l->data;
+		GList *reqs = g_queue_peek_head_link(dev->queue);
+		int i;
+
+		for (i = 0; reqs; reqs = g_list_next(reqs), i++) {
+			struct avrcp_request *req = reqs->data;
+
+			if (req->pdu_id != pdu_id || req->event_id != event_id)
+				continue;
+
+			if (!peek)
+				g_queue_pop_nth(dev->queue, i);
+
+			return req;
+		}
+	}
+
+	return NULL;
+}
+
+static bool avrcp_device_connect(struct avrcp_device *dev, BtIOConnect cb)
+{
+	GError *err = NULL;
+
+	dev->io = bt_io_connect(cb, dev, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+					BT_IO_OPT_DEST_BDADDR, &dev->dst,
+					BT_IO_OPT_PSM, L2CAP_PSM_AVCTP,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		return false;
+	}
+
+	return true;
+}
+
+static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
+						uint16_t imtu, uint16_t omtu)
+{
+	char address[18];
+
+	dev->session = avrcp_new(fd, imtu, omtu, dev->version);
+	if (!dev->session)
+		return -EINVAL;
+
+	dev->queue = g_queue_new();
+
+	ba2str(&dev->dst, address);
+
+	/* FIXME: get the real name of the device */
+	avrcp_init_uinput(dev->session, "bluetooth", address);
+
+	dev->session_added_cb(dev);
+
+	return 0;
+}
+
+static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct avrcp_device *dev = user_data;
+	uint16_t imtu, omtu;
+	char address[18];
+	GError *gerr = NULL;
+	int fd;
+
+	if (err) {
+		error("%s", err->message);
+		return;
+	}
+
+	bt_io_get(chan, &gerr,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_OMTU, &omtu,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
+	fd = g_io_channel_unix_get_fd(chan);
+	if (avrcp_device_add_session(dev, fd, imtu, omtu) < 0) {
+		free_avrcp_device(dev);
+		return;
+	}
+
+	g_io_channel_set_close_on_unref(chan, FALSE);
+
+	if (dev->io) {
+		g_io_channel_unref(dev->io);
+		dev->io = NULL;
+	}
+
+	DBG("%s connected", address);
+}
+
+static void search_cb(sdp_list_t *recs, int err, gpointer data)
+{
+	struct avrcp_device *dev = data;
+	sdp_list_t *list;
+
+	DBG("");
+
+	if (!g_slist_find(devices, dev))
+		return;
+
+	if (err < 0) {
+		error("Unable to get AV_REMOTE_SVCLASS_ID SDP record: %s",
+							strerror(-err));
+		goto fail;
+	}
+
+	if (!recs || !recs->data) {
+		error("No AVRCP records found");
+		goto fail;
+	}
+
+	for (list = recs; list; list = list->next) {
+		sdp_record_t *rec = list->data;
+		sdp_list_t *l;
+		sdp_profile_desc_t *desc;
+		int features;
+
+		if (sdp_get_profile_descs(rec, &l) < 0)
+			continue;
+
+		desc = l->data;
+		dev->version = desc->version;
+
+		if (sdp_get_int_attr(rec, SDP_ATTR_SUPPORTED_FEATURES,
+							&features) == 0)
+			dev->features = features;
+
+		sdp_list_free(l, free);
+		break;
+	}
+
+	if (dev->io) {
+		GError *gerr = NULL;
+		if (!bt_io_accept(dev->io, connect_cb, dev, NULL, &gerr)) {
+			error("bt_io_accept: %s", gerr->message);
+			g_error_free(gerr);
+			goto fail;
+		}
+		return;
+	}
+
+	if (!avrcp_device_connect(dev, connect_cb)) {
+		error("Unable to connect to AVRCP");
+		goto fail;
+	}
+
+	return;
+
+fail:
+	remove_avrcp_device(dev);
+}
+
+static int search_avrcp_device(struct avrcp_device *dev)
+{
+	uuid_t uuid;
+
+	sdp_uuid16_create(&uuid, AV_REMOTE_SVCLASS_ID);
+
+	return bt_search_service(&adapter_addr, &dev->dst, &uuid, search_cb,
+								dev, NULL, 0);
+}
+
+struct avrcp_device *add_new_avrcp_device(const bdaddr_t *dst,
+							void *session_added_cb)
+{
+	struct avrcp_device *dev;
+
+	dev = g_new0(struct avrcp_device, 1);
+	bacpy(&dev->dst, dst);
+	dev->session_added_cb = session_added_cb;
+	devices = g_slist_prepend(devices, dev);
+
+	if (search_avrcp_device(dev) < 0) {
+		error("AVRCP: Failed to search SDP details");
+		free_avrcp_device(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+
+static void confirm_cb(GIOChannel *chan, gpointer data)
+{
+	struct avrcp_device *dev;
+	char address[18];
+	bdaddr_t dst;
+	void *session_added_cb = data;
+	GError *err = NULL;
+
+	bt_io_get(chan, &err,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
+	DBG("incoming connect from %s", address);
+
+	dev = get_avrcp_device(&dst);
+	if (dev && dev->session) {
+		error("AVRCP: Refusing unexpected connect");
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
+	dev = add_new_avrcp_device(&dst, session_added_cb);
+
+	if (!dev) {
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
+	dev->io = g_io_channel_ref(chan);
+}
+
+bool bt_avrcp_io_listen(const bdaddr_t *addr, void *session_added_cb)
+{
+	GError *err = NULL;
+
+	if (server) {
+		/* already listening */
+		return true;
+	}
+
+	bacpy(&adapter_addr, addr);
+
+	server = bt_io_listen(NULL, confirm_cb, session_added_cb, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_PSM, L2CAP_PSM_AVCTP,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_INVALID);
+	if (!server) {
+		error("Failed to listen on AVDTP channel: %s", err->message);
+		g_error_free(err);
+		return false;
+	}
+
+	return true;
+}
+
+void bt_avrcp_io_shutdown(void)
+{
+	if (server) {
+		g_slist_free_full(devices, free_avrcp_device);
+		devices = NULL;
+
+		g_io_channel_shutdown(server, TRUE, NULL);
+		g_io_channel_unref(server);
+		server = NULL;
+	}
+}
diff --git a/android/avrcp-common.h b/android/avrcp-common.h
new file mode 100644
index 0000000..6571908
--- /dev/null
+++ b/android/avrcp-common.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#define AVRCP_FEATURE_CATEGORY_1	0x0001
+#define AVRCP_FEATURE_CATEGORY_2	0x0002
+#define AVRCP_FEATURE_CATEGORY_3	0x0004
+#define AVRCP_FEATURE_CATEGORY_4	0x0008
+
+#define L2CAP_PSM_AVCTP 0x17
+
+struct avrcp_device {
+	bdaddr_t	dst;
+	uint16_t	version;
+	uint16_t	features;
+	struct avrcp	*session;
+	GIOChannel	*io;
+	GQueue		*queue;
+	void (*session_added_cb)(void *data);
+};
+
+struct avrcp_request {
+	struct avrcp_device *dev;
+	uint8_t pdu_id;
+	uint8_t event_id;
+	uint8_t transaction;
+};
+
+struct avrcp_device *add_new_avrcp_device(const bdaddr_t *dst,
+							void *session_added_cb);
+void remove_avrcp_device(struct avrcp_device *dev);
+struct avrcp_device *get_avrcp_device(const bdaddr_t *dst);
+struct avrcp_request *pop_request(uint8_t pdu_id, uint8_t event_id, bool peek);
+bool bt_avrcp_io_listen(const bdaddr_t *addr, void *connected_cb);
+void bt_avrcp_io_shutdown(void);
diff --git a/android/avrcp-ctrl.c b/android/avrcp-ctrl.c
new file mode 100644
index 0000000..31a9d7f
--- /dev/null
+++ b/android/avrcp-ctrl.c
@@ -0,0 +1,165 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <stdbool.h>
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "src/log.h"
+
+#include "hal-msg.h"
+#include "ipc-common.h"
+#include "ipc.h"
+
+#include "avctp.h"
+#include "avrcp-common.h"
+#include "avrcp-ctrl.h"
+#include "bluetooth.h"
+
+static uint32_t record_ct_id = 0;
+static struct ipc *hal_ipc = NULL;
+
+static void handle_send_passthrough(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP_CTRL,
+			HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH, HAL_STATUS_FAILED);
+}
+
+static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH */
+	{ handle_send_passthrough, false,
+			sizeof(struct hal_ev_avrcp_ctrl_passthrough_rsp) },
+};
+
+static sdp_record_t *avrcp_ct_record(void)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, l2cap, avctp, avrct, avrctr;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t *record;
+	sdp_data_t *psm, *version, *features;
+	uint16_t lp = AVCTP_CONTROL_PSM;
+	uint16_t avrcp_ver = 0x0105, avctp_ver = 0x0104;
+	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
+						AVRCP_FEATURE_CATEGORY_2 |
+						AVRCP_FEATURE_CATEGORY_3 |
+						AVRCP_FEATURE_CATEGORY_4);
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	/* Service Class ID List */
+	sdp_uuid16_create(&avrct, AV_REMOTE_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &avrct);
+	sdp_uuid16_create(&avrctr, AV_REMOTE_CONTROLLER_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &avrctr);
+	sdp_set_service_classes(record, svclass_id);
+
+	/* Protocol Descriptor List */
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap);
+	psm = sdp_data_alloc(SDP_UINT16, &lp);
+	proto[0] = sdp_list_append(proto[0], psm);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&avctp, AVCTP_UUID);
+	proto[1] = sdp_list_append(NULL, &avctp);
+	version = sdp_data_alloc(SDP_UINT16, &avctp_ver);
+	proto[1] = sdp_list_append(proto[1], version);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	/* Bluetooth Profile Descriptor List */
+	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
+	profile[0].version = avrcp_ver;
+	pfseq = sdp_list_append(NULL, &profile[0]);
+	sdp_set_profile_descs(record, pfseq);
+
+	features = sdp_data_alloc(SDP_UINT16, &feat);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	sdp_set_info_attr(record, "AVRCP CT", NULL, NULL);
+
+	free(psm);
+	free(version);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(pfseq, NULL);
+	sdp_list_free(aproto, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass_id, NULL);
+
+	return record;
+}
+
+bool bt_avrcp_ctrl_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
+{
+	sdp_record_t *rec;
+
+	DBG("");
+
+	rec = avrcp_ct_record();
+	if (!rec) {
+		error("Failed to allocate AVRCP CT record");
+		goto fail;
+	}
+
+	if (bt_adapter_add_record(rec, 0) < 0) {
+		error("Failed to register AVRCP CT record");
+		sdp_record_free(rec);
+		goto fail;
+	}
+	record_ct_id = rec->handle;
+
+	hal_ipc = ipc;
+
+	ipc_register(hal_ipc, HAL_SERVICE_ID_AVRCP_CTRL, cmd_handlers,
+						G_N_ELEMENTS(cmd_handlers));
+
+	return true;
+fail:
+	return false;
+}
+
+void bt_avrcp_ctrl_unregister(void)
+{
+	DBG("");
+
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_AVRCP_CTRL);
+	hal_ipc = NULL;
+
+	bt_adapter_remove_record(record_ct_id);
+	record_ct_id = 0;
+}
diff --git a/android/avrcp-ctrl.h b/android/avrcp-ctrl.h
new file mode 100644
index 0000000..e59fd68
--- /dev/null
+++ b/android/avrcp-ctrl.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+bool bt_avrcp_ctrl_register(struct ipc *ipc, const bdaddr_t *addr,
+								uint8_t mode);
+void bt_avrcp_ctrl_unregister(void);
diff --git a/android/avrcp.c b/android/avrcp.c
index a0d412d..0bb0791 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -45,64 +45,12 @@
 #include "ipc.h"
 #include "bluetooth.h"
 #include "avrcp.h"
+#include "avrcp-common.h"
 #include "utils.h"
 
-#define L2CAP_PSM_AVCTP 0x17
-
-#define AVRCP_FEATURE_CATEGORY_1	0x0001
-#define AVRCP_FEATURE_CATEGORY_2	0x0002
-#define AVRCP_FEATURE_CATEGORY_3	0x0004
-#define AVRCP_FEATURE_CATEGORY_4	0x0008
-
-static bdaddr_t adapter_addr;
 static uint32_t record_tg_id = 0;
-static uint32_t record_ct_id = 0;
-static GSList *devices = NULL;
-static GIOChannel *server = NULL;
 static struct ipc *hal_ipc = NULL;
 
-struct avrcp_request {
-	struct avrcp_device *dev;
-	uint8_t pdu_id;
-	uint8_t event_id;
-	uint8_t transaction;
-};
-
-struct avrcp_device {
-	bdaddr_t	dst;
-	uint16_t	version;
-	uint16_t	features;
-	struct avrcp	*session;
-	GIOChannel	*io;
-	GQueue		*queue;
-};
-
-static struct avrcp_request *pop_request(uint8_t pdu_id, uint8_t event_id,
-								bool peek)
-{
-	GSList *l;
-
-	for (l = devices; l; l = g_slist_next(l)) {
-		struct avrcp_device *dev = l->data;
-		GList *reqs = g_queue_peek_head_link(dev->queue);
-		int i;
-
-		for (i = 0; reqs; reqs = g_list_next(reqs), i++) {
-			struct avrcp_request *req = reqs->data;
-
-			if (req->pdu_id != pdu_id || req->event_id != event_id)
-				continue;
-
-			if (!peek)
-				g_queue_pop_nth(dev->queue, i);
-
-			return req;
-		}
-	}
-
-	return NULL;
-}
-
 static void handle_get_play_status(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_avrcp_get_play_status *cmd = buf;
@@ -325,18 +273,14 @@ static void handle_set_volume(const void *buf, uint16_t len)
 
 	DBG("");
 
-	if (!devices) {
+	dev = get_avrcp_device(NULL);
+
+	if (!dev) {
 		error("AVRCP: No device found to set volume");
 		status = HAL_STATUS_FAILED;
 		goto done;
 	}
 
-	/*
-	 * Peek the first device since the HAL cannot really address a specific
-	 * device it might mean there could only be one connected.
-	 */
-	dev = devices->data;
-
 	ret = avrcp_set_volume(dev->session, cmd->value & 0x7f);
 	if (ret < 0) {
 		status = HAL_STATUS_FAILED;
@@ -450,143 +394,6 @@ static sdp_record_t *avrcp_tg_record(void)
 	return record;
 }
 
-static sdp_record_t *avrcp_ct_record(void)
-{
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
-	uuid_t root_uuid, l2cap, avctp, avrct, avrctr;
-	sdp_profile_desc_t profile[1];
-	sdp_list_t *aproto, *proto[2];
-	sdp_record_t *record;
-	sdp_data_t *psm, *version, *features;
-	uint16_t lp = AVCTP_CONTROL_PSM;
-	uint16_t avrcp_ver = 0x0105, avctp_ver = 0x0104;
-	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
-						AVRCP_FEATURE_CATEGORY_2 |
-						AVRCP_FEATURE_CATEGORY_3 |
-						AVRCP_FEATURE_CATEGORY_4);
-
-	record = sdp_record_alloc();
-	if (!record)
-		return NULL;
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	/* Service Class ID List */
-	sdp_uuid16_create(&avrct, AV_REMOTE_SVCLASS_ID);
-	svclass_id = sdp_list_append(NULL, &avrct);
-	sdp_uuid16_create(&avrctr, AV_REMOTE_CONTROLLER_SVCLASS_ID);
-	svclass_id = sdp_list_append(svclass_id, &avrctr);
-	sdp_set_service_classes(record, svclass_id);
-
-	/* Protocol Descriptor List */
-	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto[0] = sdp_list_append(NULL, &l2cap);
-	psm = sdp_data_alloc(SDP_UINT16, &lp);
-	proto[0] = sdp_list_append(proto[0], psm);
-	apseq = sdp_list_append(NULL, proto[0]);
-
-	sdp_uuid16_create(&avctp, AVCTP_UUID);
-	proto[1] = sdp_list_append(NULL, &avctp);
-	version = sdp_data_alloc(SDP_UINT16, &avctp_ver);
-	proto[1] = sdp_list_append(proto[1], version);
-	apseq = sdp_list_append(apseq, proto[1]);
-
-	aproto = sdp_list_append(NULL, apseq);
-	sdp_set_access_protos(record, aproto);
-
-	/* Bluetooth Profile Descriptor List */
-	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
-	profile[0].version = avrcp_ver;
-	pfseq = sdp_list_append(NULL, &profile[0]);
-	sdp_set_profile_descs(record, pfseq);
-
-	features = sdp_data_alloc(SDP_UINT16, &feat);
-	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
-
-	sdp_set_info_attr(record, "AVRCP CT", NULL, NULL);
-
-	free(psm);
-	free(version);
-	sdp_list_free(proto[0], NULL);
-	sdp_list_free(proto[1], NULL);
-	sdp_list_free(apseq, NULL);
-	sdp_list_free(pfseq, NULL);
-	sdp_list_free(aproto, NULL);
-	sdp_list_free(root, NULL);
-	sdp_list_free(svclass_id, NULL);
-
-	return record;
-}
-
-static void avrcp_device_free(void *data)
-{
-	struct avrcp_device *dev = data;
-
-	if (dev->queue) {
-		g_queue_foreach(dev->queue, (GFunc) g_free, NULL);
-		g_queue_free(dev->queue);
-	}
-
-	if (dev->session)
-		avrcp_shutdown(dev->session);
-
-	if (dev->io) {
-		g_io_channel_shutdown(dev->io, FALSE, NULL);
-		g_io_channel_unref(dev->io);
-	}
-
-	g_free(dev);
-}
-
-static void avrcp_device_remove(struct avrcp_device *dev)
-{
-	devices = g_slist_remove(devices, dev);
-	avrcp_device_free(dev);
-}
-
-static struct avrcp_device *avrcp_device_new(const bdaddr_t *dst)
-{
-	struct avrcp_device *dev;
-
-	dev = g_new0(struct avrcp_device, 1);
-	bacpy(&dev->dst, dst);
-	devices = g_slist_prepend(devices, dev);
-
-	return dev;
-}
-
-static int device_cmp(gconstpointer s, gconstpointer user_data)
-{
-	const struct avrcp_device *dev = s;
-	const bdaddr_t *dst = user_data;
-
-	return bacmp(&dev->dst, dst);
-}
-
-static struct avrcp_device *avrcp_device_find(const bdaddr_t *dst)
-{
-	GSList *l;
-
-	l = g_slist_find_custom(devices, dst, device_cmp);
-	if (!l)
-		return NULL;
-
-	return l->data;
-}
-
-static void disconnect_cb(void *data)
-{
-	struct avrcp_device *dev = data;
-
-	DBG("");
-
-	dev->session = NULL;
-
-	avrcp_device_remove(dev);
-}
-
 static bool handle_fast_forward(struct avrcp *session, bool pressed,
 							void *user_data)
 {
@@ -833,27 +640,27 @@ static const struct avrcp_control_cfm control_cfm = {
 	.set_volume = handle_set_volume_rsp,
 };
 
-static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
-						uint16_t imtu, uint16_t omtu)
+static void disconnect_cb(void *data)
 {
-	struct hal_ev_avrcp_remote_features ev;
-	char address[18];
+	struct avrcp_device *dev = data;
 
-	dev->session = avrcp_new(fd, imtu, omtu, dev->version);
-	if (!dev->session)
-		return -EINVAL;
+	DBG("");
 
-	avrcp_set_destroy_cb(dev->session, disconnect_cb, dev);
-	avrcp_set_passthrough_handlers(dev->session, passthrough_handlers,
-									dev);
-	avrcp_register_player(dev->session, &control_ind, &control_cfm, dev);
+	dev->session = NULL;
+
+	remove_avrcp_device(dev);
+}
 
-	dev->queue = g_queue_new();
+static void session_added_cb(void *data)
+{
+	struct avrcp_device *dev = data;
+	struct hal_ev_avrcp_remote_features ev;
 
-	ba2str(&dev->dst, address);
+	DBG("");
 
-	/* FIXME: get the real name of the device */
-	avrcp_init_uinput(dev->session, "bluetooth", address);
+	avrcp_set_destroy_cb(dev->session, disconnect_cb, dev);
+	avrcp_set_passthrough_handlers(dev->session, passthrough_handlers, dev);
+	avrcp_register_player(dev->session, &control_ind, &control_cfm, dev);
 
 	bdaddr2android(&dev->dst, ev.bdaddr);
 	ev.features = HAL_AVRCP_FEATURE_NONE;
@@ -874,200 +681,18 @@ static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
 
 done:
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
-					HAL_EV_AVRCP_REMOTE_FEATURES,
-					sizeof(ev), &ev);
-
-	return 0;
-}
-
-static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
-{
-	struct avrcp_device *dev = user_data;
-	uint16_t imtu, omtu;
-	char address[18];
-	GError *gerr = NULL;
-	int fd;
-
-	if (err) {
-		error("%s", err->message);
-		return;
-	}
-
-	bt_io_get(chan, &gerr,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_IMTU, &imtu,
-			BT_IO_OPT_OMTU, &omtu,
-			BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("%s", gerr->message);
-		g_error_free(gerr);
-		g_io_channel_shutdown(chan, TRUE, NULL);
-		return;
-	}
-
-	fd = g_io_channel_unix_get_fd(chan);
-	if (avrcp_device_add_session(dev, fd, imtu, omtu) < 0) {
-		avrcp_device_free(dev);
-		return;
-	}
-
-	g_io_channel_set_close_on_unref(chan, FALSE);
-
-	if (dev->io) {
-		g_io_channel_unref(dev->io);
-		dev->io = NULL;
-	}
-
-	DBG("%s connected", address);
-}
-
-static bool avrcp_device_connect(struct avrcp_device *dev, BtIOConnect cb)
-{
-	GError *err = NULL;
-
-	dev->io = bt_io_connect(cb, dev, NULL, &err,
-					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-					BT_IO_OPT_DEST_BDADDR, &dev->dst,
-					BT_IO_OPT_PSM, L2CAP_PSM_AVCTP,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-					BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		return false;
-	}
-
-	return true;
-}
-
-static void search_cb(sdp_list_t *recs, int err, gpointer data)
-{
-	struct avrcp_device *dev = data;
-	sdp_list_t *list;
-
-	DBG("");
-
-	if (!g_slist_find(devices, dev))
-		return;
-
-	if (err < 0) {
-		error("Unable to get AV_REMOTE_SVCLASS_ID SDP record: %s",
-							strerror(-err));
-		goto fail;
-	}
-
-	if (!recs || !recs->data) {
-		error("No AVRCP records found");
-		goto fail;
-	}
-
-	for (list = recs; list; list = list->next) {
-		sdp_record_t *rec = list->data;
-		sdp_list_t *l;
-		sdp_profile_desc_t *desc;
-		int features;
-
-		if (sdp_get_profile_descs(rec, &l) < 0)
-			continue;
-
-		desc = l->data;
-		dev->version = desc->version;
-
-		if (sdp_get_int_attr(rec, SDP_ATTR_SUPPORTED_FEATURES,
-							&features) == 0)
-			dev->features = features;
-
-		sdp_list_free(l, free);
-		break;
-	}
-
-	if (dev->io) {
-		GError *gerr = NULL;
-		if (!bt_io_accept(dev->io, connect_cb, dev, NULL, &gerr)) {
-			error("bt_io_accept: %s", gerr->message);
-			g_error_free(gerr);
-			goto fail;
-		}
-		return;
-	}
-
-	if (!avrcp_device_connect(dev, connect_cb)) {
-		error("Unable to connect to AVRCP");
-		goto fail;
-	}
-
-	return;
-
-fail:
-	avrcp_device_remove(dev);
-}
-
-static int avrcp_device_search(struct avrcp_device *dev)
-{
-	uuid_t uuid;
-
-	sdp_uuid16_create(&uuid, AV_REMOTE_SVCLASS_ID);
-
-	return bt_search_service(&adapter_addr, &dev->dst, &uuid, search_cb,
-								dev, NULL, 0);
-}
-
-static void confirm_cb(GIOChannel *chan, gpointer data)
-{
-	struct avrcp_device *dev;
-	char address[18];
-	bdaddr_t dst;
-	GError *err = NULL;
-
-	bt_io_get(chan, &err,
-			BT_IO_OPT_DEST_BDADDR, &dst,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		g_io_channel_shutdown(chan, TRUE, NULL);
-		return;
-	}
-
-	DBG("incoming connect from %s", address);
-
-	dev = avrcp_device_find(&dst);
-	if (dev && dev->session) {
-		error("AVRCP: Refusing unexpected connect");
-		g_io_channel_shutdown(chan, TRUE, NULL);
-		return;
-	}
-
-	dev = avrcp_device_new(&dst);
-	if (avrcp_device_search(dev) < 0) {
-		error("AVRCP: Failed to search SDP details");
-		avrcp_device_free(dev);
-		g_io_channel_shutdown(chan, TRUE, NULL);
-	}
-
-	dev->io = g_io_channel_ref(chan);
+						HAL_EV_AVRCP_REMOTE_FEATURES,
+						sizeof(ev), &ev);
 }
 
 bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
-	GError *err = NULL;
 	sdp_record_t *rec;
 
 	DBG("");
 
-	bacpy(&adapter_addr, addr);
-
-	server = bt_io_listen(NULL, confirm_cb, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-				BT_IO_OPT_PSM, L2CAP_PSM_AVCTP,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_INVALID);
-	if (!server) {
-		error("Failed to listen on AVDTP channel: %s", err->message);
-		g_error_free(err);
-		return false;
-	}
+	if (!bt_avrcp_io_listen(addr, session_added_cb))
+		goto fail;
 
 	rec = avrcp_tg_record();
 	if (!rec) {
@@ -1082,21 +707,6 @@ bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 	}
 	record_tg_id = rec->handle;
 
-	rec = avrcp_ct_record();
-	if (!rec) {
-		error("Failed to allocate AVRCP CT record");
-		bt_adapter_remove_record(record_tg_id);
-		goto fail;
-	}
-
-	if (bt_adapter_add_record(rec, 0) < 0) {
-		error("Failed to register AVRCP CT record");
-		bt_adapter_remove_record(record_tg_id);
-		sdp_record_free(rec);
-		goto fail;
-	}
-	record_ct_id = rec->handle;
-
 	hal_ipc = ipc;
 
 	ipc_register(hal_ipc, HAL_SERVICE_ID_AVRCP, cmd_handlers,
@@ -1104,9 +714,7 @@ bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 
 	return true;
 fail:
-	g_io_channel_shutdown(server, TRUE, NULL);
-	g_io_channel_unref(server);
-	server = NULL;
+	bt_avrcp_io_shutdown();
 
 	return false;
 }
@@ -1115,23 +723,13 @@ void bt_avrcp_unregister(void)
 {
 	DBG("");
 
-	g_slist_free_full(devices, avrcp_device_free);
-	devices = NULL;
-
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_AVRCP);
 	hal_ipc = NULL;
 
 	bt_adapter_remove_record(record_tg_id);
 	record_tg_id = 0;
 
-	bt_adapter_remove_record(record_ct_id);
-	record_ct_id = 0;
-
-	if (server) {
-		g_io_channel_shutdown(server, TRUE, NULL);
-		g_io_channel_unref(server);
-		server = NULL;
-	}
+	bt_avrcp_io_shutdown();
 }
 
 void bt_avrcp_connect(const bdaddr_t *dst)
@@ -1141,14 +739,10 @@ void bt_avrcp_connect(const bdaddr_t *dst)
 
 	DBG("");
 
-	if (avrcp_device_find(dst))
+	if (get_avrcp_device(dst))
 		return;
 
-	dev = avrcp_device_new(dst);
-	if (avrcp_device_search(dev) < 0) {
-		error("AVRCP: Failed to search SDP details");
-		avrcp_device_free(dev);
-	}
+	dev = add_new_avrcp_device(dst, session_added_cb);
 
 	ba2str(&dev->dst, addr);
 	DBG("connecting to %s", addr);
@@ -1160,7 +754,7 @@ void bt_avrcp_disconnect(const bdaddr_t *dst)
 
 	DBG("");
 
-	dev = avrcp_device_find(dst);
+	dev = get_avrcp_device(dst);
 	if (!dev)
 		return;
 
@@ -1169,5 +763,5 @@ void bt_avrcp_disconnect(const bdaddr_t *dst)
 		return;
 	}
 
-	avrcp_device_remove(dev);
+	remove_avrcp_device(dev);
 }
diff --git a/android/main.c b/android/main.c
index 58dd9ab..365439e 100644
--- a/android/main.c
+++ b/android/main.c
@@ -58,6 +58,7 @@
 #include "a2dp.h"
 #include "pan.h"
 #include "avrcp.h"
+#include "avrcp-ctrl.h"
 #include "handsfree.h"
 #include "gatt.h"
 #include "health.h"
@@ -245,6 +246,14 @@ static void service_register(const void *buf, uint16_t len)
 		}
 
 		break;
+	case HAL_SERVICE_ID_AVRCP_CTRL:
+		if (!bt_avrcp_ctrl_register(hal_ipc, &adapter_bdaddr,
+								m->mode)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+
+		break;
 	default:
 		DBG("service %u not supported", m->service_id);
 		status = HAL_STATUS_FAILED;
@@ -301,6 +310,8 @@ static bool unregister_service(uint8_t id)
 	case HAL_SERVICE_ID_MAP_CLIENT:
 		bt_map_client_unregister();
 		break;
+	case HAL_SERVICE_ID_AVRCP_CTRL:
+		bt_avrcp_ctrl_unregister();
 	default:
 		DBG("service %u not supported", id);
 		return false;
-- 
1.9.3

