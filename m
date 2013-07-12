Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 08/10] hsp: Add initial HSP plugin
Date: Fri, 12 Jul 2013 12:54:41 +0200
Message-Id: <1373626483-2031-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This simple HSP plugin implements the AG role, typically used in desktop
environments. The goal is to have a fallback alternative in case a
full-blown HSP/HFP implementation (e.g. oFono) is not available.
---
 Makefile.plugins |    3 +
 plugins/hsp.c    | 1013 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1016 insertions(+)
 create mode 100644 plugins/hsp.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 3efe849..e7532a4 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -107,4 +107,7 @@ builtin_sources += profiles/heartrate/heartrate.c
 
 builtin_modules += cyclingspeed
 builtin_sources += profiles/cyclingspeed/cyclingspeed.c
+
+builtin_modules += hsp
+builtin_sources += plugins/hsp.c
 endif
diff --git a/plugins/hsp.c b/plugins/hsp.c
new file mode 100644
index 0000000..f0b55c9
--- /dev/null
+++ b/plugins/hsp.c
@@ -0,0 +1,1013 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2012-2013  BMW Car IT GmbH. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <signal.h>
+#include <string.h>
+#include <getopt.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <assert.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+#include <gdbus.h>
+
+#include "lib/uuid.h"
+#include "plugin.h"
+#include "log.h"
+#include "adapter.h"
+#include "device.h"
+#include "profile.h"
+#include "service.h"
+#include "error.h"
+#include "sdp-client.h"
+#include "sdpd.h"
+#include "btio.h"
+#include "profiles/audio/manager.h"
+
+#define DEFAULT_HS_AG_CHANNEL 12
+#define BUF_SIZE 1024
+
+typedef enum {
+	HEADSET_STATE_DISCONNECTED,
+	HEADSET_STATE_CONNECTING,
+	HEADSET_STATE_CONNECTED,
+	HEADSET_STATE_PLAYING,
+} headset_state_t;
+
+struct headset_slc {
+	char buf[BUF_SIZE];
+	int data_start;
+	int data_length;
+
+	int sp_gain;
+	int mic_gain;
+};
+
+struct server {
+	struct btd_adapter *adapter;
+	GIOChannel *io;
+	GIOChannel *sco_io;
+	uint32_t record_id;
+	GSList *active_headsets;
+};
+
+struct headset {
+	struct server *server;
+	struct btd_service *service;
+	struct audio_device *audio_dev;
+
+	bool discovering;
+	int rfcomm_ch;
+	GIOChannel *rfcomm;
+	struct headset_slc *slc;
+
+	GIOChannel *sco;
+	guint sco_id;
+
+	headset_state_t state;
+};
+
+struct event {
+	const char *cmd;
+	int (*callback) (struct headset *hs, const char *buf);
+};
+
+static GSList *servers = NULL;
+
+static void headset_set_state(struct headset *hs, headset_state_t state);
+
+static const char *state2str(headset_state_t state)
+{
+	switch (state) {
+	case HEADSET_STATE_DISCONNECTED:
+		return "HEADSET_STATE_DISCONNECTED";
+	case HEADSET_STATE_CONNECTING:
+		return "HEADSET_STATE_CONNECTING";
+	case HEADSET_STATE_CONNECTED:
+		return "HEADSET_STATE_CONNECTED";
+	case HEADSET_STATE_PLAYING:
+		return "HEADSET_STATE_PLAYING";
+	}
+
+	return NULL;
+}
+
+static struct server *find_server(const struct btd_adapter *adapter)
+{
+	GSList *l;
+
+	for (l = servers; l != NULL; l = g_slist_next(l)) {
+		struct server *server = l->data;
+
+		if (server->adapter == adapter)
+			return server;
+	}
+
+	return NULL;
+}
+
+static int headset_send_valist(struct headset *hs, char *format, va_list ap)
+{
+	char rsp[BUF_SIZE];
+	ssize_t total_written, count;
+	int fd;
+
+	count = vsnprintf(rsp, sizeof(rsp), format, ap);
+
+	if (count < 0)
+		return -EINVAL;
+
+	if (hs->rfcomm == NULL) {
+		error("headset_send: the headset is not connected");
+		return -EIO;
+	}
+
+	total_written = 0;
+	fd = g_io_channel_unix_get_fd(hs->rfcomm);
+
+	while (total_written < count) {
+		ssize_t written;
+
+		written = write(fd, rsp + total_written,
+				count - total_written);
+		if (written < 0)
+			return -errno;
+
+		total_written += written;
+	}
+
+	return 0;
+}
+
+static int __attribute__((format(printf, 2, 3)))
+			headset_send(struct headset *hs, char *format, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, format);
+	ret = headset_send_valist(hs, format, ap);
+	va_end(ap);
+
+	return ret;
+}
+
+static gboolean sco_io_cb(GIOChannel *io, GIOCondition cond, gpointer user_data)
+{
+	struct headset *hs = user_data;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	DBG("SCO connection got disconnected");
+
+	if (hs->state > HEADSET_STATE_CONNECTED)
+		headset_set_state(hs, HEADSET_STATE_CONNECTED);
+
+	return FALSE;
+}
+
+static void headset_init_sco(struct headset *hs)
+{
+	int fd;
+
+	assert(hs->sco != NULL);
+
+	fd = g_io_channel_unix_get_fd(hs->sco);
+	fcntl(fd, F_SETFL, 0);
+
+	/* Do not watch HUP since we need to know when the link is
+	   really disconnected */
+	hs->sco_id = g_io_add_watch(hs->sco, G_IO_ERR | G_IO_NVAL,
+								sco_io_cb, hs);
+
+	headset_send(hs, "\r\n+VGS=%u\r\n", hs->slc->sp_gain);
+	headset_send(hs, "\r\n+VGM=%u\r\n", hs->slc->mic_gain);
+
+	headset_set_state(hs, HEADSET_STATE_PLAYING);
+}
+
+static void headset_close_sco(struct headset *hs)
+{
+	if (hs->sco != NULL) {
+		int sock = g_io_channel_unix_get_fd(hs->sco);
+		shutdown(sock, SHUT_RDWR);
+		g_io_channel_shutdown(hs->sco, TRUE, NULL);
+		g_io_channel_unref(hs->sco);
+		hs->sco = NULL;
+	}
+
+	if (hs->sco_id != 0) {
+		g_source_remove(hs->sco_id);
+		hs->sco_id = 0;
+	}
+}
+
+static int key_press(struct headset *hs, const char *buf)
+{
+	if (strlen(buf) < 9)
+		return -EINVAL;
+
+	return headset_send(hs, "\r\nOK\r\n");
+}
+
+static int signal_gain_setting(struct headset *hs, const char *buf)
+{
+	struct headset_slc *slc = hs->slc;
+	long int gain;
+
+	if (strlen(buf) < 8) {
+		error("Too short string for Gain setting");
+		return -EINVAL;
+	}
+
+	gain = strtol(&buf[7], NULL, 10);
+
+	if (gain < 0 || gain > 15) {
+		error("Invalid gain value: %ld", gain);
+		return -EINVAL;
+	}
+
+	switch (buf[5]) {
+	case 'S':
+		if (slc->sp_gain == gain)
+			return -EALREADY;
+
+		slc->sp_gain = gain;
+		break;
+	case 'M':
+		if (slc->mic_gain == gain)
+			return 0;
+
+		slc->mic_gain = gain;
+		break;
+	default:
+		error("Unknown gain setting");
+		return -EINVAL;
+	}
+
+	return headset_send(hs, "\r\nOK\r\n");
+}
+
+static struct event event_callbacks[] = {
+	{ "AT+CKPD", key_press },
+	{ "AT+VG", signal_gain_setting },
+	{ 0 }
+};
+
+static int handle_event(struct headset *hs, const char *buf)
+{
+	struct event *ev;
+
+	DBG("Received %s", buf);
+
+	for (ev = event_callbacks; ev->cmd; ev++)
+		if (!strncmp(buf, ev->cmd, strlen(ev->cmd)))
+			return ev->callback(hs, buf);
+
+	return -EINVAL;
+}
+
+static gboolean rfcomm_io_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct headset *hs = user_data;
+	struct headset_slc *slc;
+	unsigned char buf[BUF_SIZE];
+	ssize_t bytes_read;
+	size_t free_space;
+	int fd;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	slc = hs->slc;
+
+	if (cond & (G_IO_ERR | G_IO_HUP)) {
+		DBG("ERR or HUP on RFCOMM socket");
+		goto failed;
+	}
+
+	fd = g_io_channel_unix_get_fd(io);
+	bytes_read = read(fd, buf, sizeof(buf) - 1);
+	if (bytes_read < 0)
+		return TRUE;
+
+	free_space = sizeof(slc->buf) - slc->data_start - slc->data_length - 1;
+
+	if (free_space < (size_t) bytes_read) {
+		/* Very likely that the HS is sending us garbage so
+		 * just ignore the data and disconnect */
+		error("Too much data to fit incoming buffer");
+		goto failed;
+	}
+
+	memcpy(&slc->buf[slc->data_start], buf, bytes_read);
+	slc->data_length += bytes_read;
+
+	/* Make sure the data is null terminated so we can use string
+	 * functions */
+	slc->buf[slc->data_start + slc->data_length] = '\0';
+
+	while (slc->data_length > 0) {
+		char *cr;
+		int err;
+		off_t cmd_len;
+
+		cr = strchr(&slc->buf[slc->data_start], '\r');
+		if (cr == NULL)
+			break;
+
+		cmd_len = 1 + (off_t) cr - (off_t) &slc->buf[slc->data_start];
+		*cr = '\0';
+
+		if (cmd_len > 1)
+			err = handle_event(hs, &slc->buf[slc->data_start]);
+		else
+			/* Silently skip empty commands */
+			err = 0;
+
+		if (err == -EINVAL) {
+			error("Badly formated or unrecognized command: %s",
+					&slc->buf[slc->data_start]);
+			err = headset_send(hs, "\r\nERROR\r\n");
+			if (err < 0)
+				goto failed;
+		} else if (err < 0)
+			error("Error handling command %s: %s (%d)",
+						&slc->buf[slc->data_start],
+						strerror(-err), -err);
+
+		slc->data_start += cmd_len;
+		slc->data_length -= cmd_len;
+
+		if (slc->data_length == 0)
+			slc->data_start = 0;
+	}
+
+	return TRUE;
+
+failed:
+	headset_set_state(hs, HEADSET_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
+static void headset_connect_rfcomm_cb(GIOChannel *io, GError *err,
+							gpointer user_data)
+{
+	struct headset *hs = user_data;
+	struct btd_device *device = btd_service_get_device(hs->service);
+	char addr[18];
+
+	if (err) {
+		error("%s", err->message);
+		headset_set_state(hs, HEADSET_STATE_DISCONNECTED);
+		return;
+	}
+
+	g_io_add_watch(io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							rfcomm_io_cb, hs);
+
+	hs->slc = g_new0(struct headset_slc, 1);
+	hs->slc->sp_gain = 15;
+	hs->slc->mic_gain = 15;
+
+	ba2str(device_get_address(device), addr);
+	DBG("Connected to %s", addr);
+
+	headset_set_state(hs, HEADSET_STATE_CONNECTED);
+}
+
+static int headset_connect_rfcomm(struct headset *hs)
+{
+	struct btd_device *device = btd_service_get_device(hs->service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	const bdaddr_t *src, *dst;
+	char addr[18];
+	GError *err = NULL;
+
+	if (hs->rfcomm_ch < 0)
+		return -EINVAL;
+
+	src = adapter_get_address(adapter);
+	dst = device_get_address(device);
+
+	ba2str(dst, addr);
+	DBG("Connecting to %s channel %d", addr, hs->rfcomm_ch);
+
+	hs->rfcomm = bt_io_connect(headset_connect_rfcomm_cb, hs, NULL,
+					&err,
+					BT_IO_OPT_SOURCE_BDADDR, src,
+					BT_IO_OPT_DEST_BDADDR, dst,
+					BT_IO_OPT_CHANNEL, hs->rfcomm_ch,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID);
+
+	hs->rfcomm_ch = -1;
+
+	if (hs->rfcomm == NULL) {
+		error("%s", err->message);
+		g_error_free(err);
+		return -EIO;
+	}
+
+	headset_set_state(hs, HEADSET_STATE_CONNECTING);
+
+	return 0;
+}
+
+static int headset_close_rfcomm(struct headset *hs)
+{
+	if (hs->rfcomm != NULL) {
+		g_io_channel_shutdown(hs->rfcomm, TRUE, NULL);
+		g_io_channel_unref(hs->rfcomm);
+		hs->rfcomm = NULL;
+	}
+
+	g_free(hs->slc);
+	hs->slc = NULL;
+
+	return 0;
+}
+
+static int headset_set_channel(struct headset *headset,
+						const sdp_record_t *record)
+{
+	int ch;
+	sdp_list_t *protos;
+
+	if (sdp_get_access_protos(record, &protos) < 0) {
+		error("Unable to get access protos from headset record");
+		return -1;
+	}
+
+	ch = sdp_get_proto_port(protos, RFCOMM_UUID);
+
+	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
+	sdp_list_free(protos, NULL);
+
+	if (ch <= 0) {
+		error("Unable to get RFCOMM channel from Headset record");
+		return -1;
+	}
+
+	headset->rfcomm_ch = ch;
+
+	return 0;
+}
+
+static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
+{
+	struct headset *hs = user_data;
+	sdp_record_t *record = NULL;
+	sdp_list_t *r;
+	uuid_t uuid;
+
+	hs->discovering = false;
+
+	if (err < 0) {
+		error("Unable to get service record: %s (%d)",
+							strerror(-err), -err);
+		goto failed;
+	}
+
+	if (recs == NULL || recs->data == NULL) {
+		error("No records found");
+		goto failed;
+	}
+
+	sdp_uuid16_create(&uuid, HEADSET_SVCLASS_ID);
+
+	for (r = recs; r != NULL; r = r->next) {
+		sdp_list_t *classes;
+		uuid_t class;
+
+		record = r->data;
+
+		if (sdp_get_service_classes(record, &classes) < 0) {
+			error("Unable to get service classes from record");
+			continue;
+		}
+
+		memcpy(&class, classes->data, sizeof(uuid));
+		sdp_list_free(classes, free);
+
+		if (sdp_uuid_cmp(&class, &uuid) == 0)
+			break;
+	}
+
+	if (r == NULL) {
+		error("No record found with HSP UUID");
+		goto failed;
+	}
+
+	if (headset_set_channel(hs, record) < 0) {
+		error("Unable to extract RFCOMM channel from service record");
+		goto failed;
+	}
+
+	err = headset_connect_rfcomm(hs);
+	if (err < 0) {
+		error("Unable to connect: %s (%d)", strerror(-err), -err);
+		goto failed;
+	}
+
+	return;
+
+failed:
+	headset_set_state(hs, HEADSET_STATE_DISCONNECTED);
+}
+
+static int get_records(struct headset *hs)
+{
+	struct btd_device *device = btd_service_get_device(hs->service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	uuid_t uuid;
+	int err;
+
+	sdp_uuid16_create(&uuid, HEADSET_SVCLASS_ID);
+
+	err = bt_search_service(adapter_get_address(adapter),
+						device_get_address(device),
+						&uuid, get_record_cb, hs, NULL);
+	if (err < 0)
+		return err;
+
+	hs->discovering = true;
+	headset_set_state(hs, HEADSET_STATE_CONNECTING);
+
+	return 0;
+}
+
+static void headset_cancel_discovery(struct headset *hs)
+{
+	struct btd_device *device = btd_service_get_device(hs->service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+
+	if (!hs->discovering)
+		return;
+
+	bt_cancel_discovery(adapter_get_address(adapter),
+						device_get_address(device));
+	hs->discovering = false;
+	headset_set_state(hs, HEADSET_STATE_DISCONNECTED);
+}
+
+static void headset_set_state(struct headset *hs, headset_state_t state)
+{
+	struct btd_device *device = btd_service_get_device(hs->service);
+	struct server *server = hs->server;
+	headset_state_t old_state = hs->state;
+	btd_service_state_t service_state = btd_service_get_state(hs->service);
+	char addr[18];
+
+	if (old_state == state)
+		return;
+
+	switch (state) {
+	case HEADSET_STATE_DISCONNECTED:
+		headset_cancel_discovery(hs);
+		headset_close_sco(hs);
+		headset_close_rfcomm(hs);
+		server->active_headsets = g_slist_remove(
+						server->active_headsets, hs);
+
+		if (service_state == BTD_SERVICE_STATE_CONNECTING)
+			btd_service_connecting_complete(hs->service, -EIO);
+		else if (service_state == BTD_SERVICE_STATE_DISCONNECTING)
+			btd_service_disconnecting_complete(hs->service, 0);
+
+		break;
+	case HEADSET_STATE_CONNECTING:
+		break;
+	case HEADSET_STATE_CONNECTED:
+		headset_close_sco(hs);
+
+		if (service_state == BTD_SERVICE_STATE_CONNECTING)
+			btd_service_connecting_complete(hs->service, 0);
+
+		if (hs->state >= state)
+			break;
+
+		server->active_headsets = g_slist_append(
+						server->active_headsets, hs);
+		break;
+	case HEADSET_STATE_PLAYING:
+		break;
+	}
+
+	hs->state = state;
+	ba2str(device_get_address(device), addr);
+	DBG("%s state changed: %s -> %s", addr, state2str(old_state),
+							state2str(state));
+}
+
+static int hsp_hs_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct headset *hs;
+
+	DBG("path %s", device_get_path(device));
+
+	hs = g_new0(struct headset, 1);
+	hs->server = find_server(device_get_adapter(device));
+	hs->service = btd_service_ref(service);
+	hs->audio_dev = manager_get_audio_device(device, TRUE);
+	hs->rfcomm_ch = -1;
+
+	btd_service_set_user_data(service, hs);
+
+	return 0;
+}
+
+static void hsp_hs_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct headset *hs = btd_service_get_user_data(service);
+
+	DBG("path %s", device_get_path(device));
+
+	headset_cancel_discovery(hs);
+	headset_close_sco(hs);
+	headset_close_rfcomm(hs);
+	btd_service_unref(hs->service);
+
+	manager_remove_audio_device(hs->audio_dev);
+
+	g_free(hs);
+}
+
+static int hsp_hs_connect(struct btd_service *service)
+{
+	struct headset *hs = btd_service_get_user_data(service);
+	struct btd_device *device = btd_service_get_device(service);
+
+	DBG("path %s", device_get_path(device));
+
+	if (hs->rfcomm_ch < 0)
+		return get_records(hs);
+
+	return headset_connect_rfcomm(hs);
+}
+
+static int hsp_hs_disconnect(struct btd_service *service)
+{
+	struct headset *hs = btd_service_get_user_data(service);
+	struct btd_device *device = btd_service_get_device(service);
+
+	DBG("path %s", device_get_path(device));
+
+	headset_close_sco(hs);
+	headset_close_rfcomm(hs);
+	headset_set_state(hs, HEADSET_STATE_DISCONNECTED);
+
+	return 0;
+}
+
+static sdp_record_t *hsp_ag_record(uint8_t ch)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
+	uuid_t l2cap_uuid, rfcomm_uuid;
+	sdp_profile_desc_t profile;
+	sdp_record_t *record;
+	sdp_list_t *aproto, *proto[2];
+	sdp_data_t *channel;
+
+	record = sdp_record_alloc();
+	if (record == NULL)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&svclass_uuid, HEADSET_AGW_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &svclass_uuid);
+	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
+	profile.version = 0x0102;
+	pfseq = sdp_list_append(0, &profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[1] = sdp_list_append(0, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &ch);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "Headset Audio Gateway", 0, 0);
+
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(pfseq, 0);
+	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
+
+	return record;
+}
+
+static struct headset *find_headset(struct server *server, const bdaddr_t *addr)
+{
+	struct btd_device *device;
+	struct btd_service *service;
+
+	device = adapter_find_device(server->adapter, addr);
+	if (device == NULL)
+		return NULL;
+
+	service = btd_device_get_service(device, HSP_HS_UUID);
+	if (service == NULL)
+		return NULL;
+
+	return btd_service_get_user_data(service);
+}
+
+static void confirm_event_cb(GIOChannel *io, gpointer user_data)
+{
+	struct server *server = user_data;
+	struct headset *hs;
+	bdaddr_t dst;
+	uint8_t ch;
+	char addr[18];
+	GError *err = NULL;
+
+	bt_io_get(io, &err, BT_IO_OPT_DEST_BDADDR, &dst,
+						BT_IO_OPT_CHANNEL, &ch,
+						BT_IO_OPT_INVALID);
+
+	if (err != NULL) {
+		error("bt_io_get: %s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	ba2str(&dst, addr);
+	DBG("Incoming connection from %s on channel %u", addr, ch);
+
+	hs = find_headset(server, &dst);
+	if (hs == NULL) {
+		DBG("Refusing connection for unknown headset");
+		goto drop;
+	}
+
+	if (hs->rfcomm != NULL) {
+		DBG("Refusing new connection since one already exists");
+		goto drop;
+	}
+
+	DBG("Accepted headset RFCOMM connection from %s", addr);
+	hs->rfcomm = g_io_channel_ref(io);
+
+	headset_set_state(hs, HEADSET_STATE_CONNECTED);
+
+	return;
+
+drop:
+	g_io_channel_shutdown(io, TRUE, NULL);
+}
+
+static void sco_server_cb(GIOChannel *io, GError *err, gpointer user_data)
+{
+	struct server *server = user_data;
+	struct headset *hs;
+	char addr[18];
+	bdaddr_t dst;
+
+	if (err != NULL) {
+		error("sco_server_cb: %s", err->message);
+		return;
+	}
+
+	bt_io_get(io, &err, BT_IO_OPT_DEST_BDADDR, &dst, BT_IO_OPT_INVALID);
+
+	if (err != NULL) {
+		error("bt_io_get: %s", err->message);
+		goto drop;
+	}
+
+	ba2str(&dst, addr);
+	DBG("Incoming SCO from %s", addr);
+
+	hs = find_headset(server, &dst);
+	if (hs == NULL) {
+		DBG("Refusing SCO connection for unknown headset");
+		goto drop;
+	}
+
+	switch (hs->state) {
+	case HEADSET_STATE_DISCONNECTED:
+	case HEADSET_STATE_CONNECTING:
+		DBG("Refusing SCO from non-connected headset");
+		goto drop;
+	case HEADSET_STATE_CONNECTED:
+		break;
+	case HEADSET_STATE_PLAYING:
+		DBG("Refusing second SCO from same headset");
+		goto drop;
+	}
+
+	DBG("Accepted headset SCO connection from %s", addr);
+	hs->sco = g_io_channel_ref(io);
+	headset_init_sco(hs);
+
+	return;
+
+drop:
+	g_io_channel_shutdown(io, TRUE, NULL);
+}
+
+static int hsp_hs_server_probe(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	const bdaddr_t *src = adapter_get_address(adapter);
+	struct server *server;
+	static sdp_record_t *record;
+	gboolean master = TRUE;
+	uint8_t chan = DEFAULT_HS_AG_CHANNEL;
+	GError *err = NULL;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = g_new0(struct server, 1);
+	server->adapter = adapter;
+	server->io = bt_io_listen(NULL, confirm_event_cb, server, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_CHANNEL, chan,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_MASTER, master,
+					BT_IO_OPT_INVALID);
+	if (server->io == NULL) {
+		if (err == NULL)
+			error("Unable to listen on HS AG socket");
+		else {
+			error("Unable to listen on HS AG socket: %s",
+								err->message);
+			g_error_free(err);
+		}
+
+		goto failed;
+	}
+
+	server->sco_io = bt_io_listen(sco_server_cb, NULL, server, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_INVALID);
+	if (server->sco_io == NULL) {
+		if (err == NULL)
+			error("Unable to listen on SCO socket");
+		else {
+			error("Unable to listen on SCO socket: %s",
+								err->message);
+			g_error_free(err);
+		}
+
+		goto failed;
+	}
+
+	record = hsp_ag_record(chan);
+	if (record == NULL) {
+		error("Unable to allocate new service record");
+		goto failed;
+	}
+
+	if (add_record_to_server(src, record) < 0) {
+		error("Unable to register HSP AG service record");
+		sdp_record_free(record);
+		goto failed;
+	}
+
+	server->record_id = record->handle;
+	servers = g_slist_append(servers, server);
+
+	return 0;
+
+failed:
+	if (server->sco_io != NULL) {
+		g_io_channel_shutdown(server->sco_io, TRUE, NULL);
+		g_io_channel_unref(server->sco_io);
+		server->sco_io = NULL;
+	}
+
+	if (server->io != NULL) {
+		g_io_channel_shutdown(server->io, TRUE, NULL);
+		g_io_channel_unref(server->io);
+		server->io = NULL;
+	}
+
+	return -EIO;
+}
+
+static void hsp_hs_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct server *server;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = find_server(adapter);
+	if (server == NULL) {
+		DBG("Server not found");
+		return;
+	}
+
+	if (server->record_id != 0)
+		remove_record_from_server(server->record_id);
+
+	if (server->sco_io != NULL) {
+		g_io_channel_shutdown(server->sco_io, TRUE, NULL);
+		g_io_channel_unref(server->sco_io);
+	}
+
+	if (server->io != NULL) {
+		g_io_channel_shutdown(server->io, TRUE, NULL);
+		g_io_channel_unref(server->io);
+	}
+
+	servers = g_slist_remove(servers, server);
+	g_free(server);
+}
+
+static struct btd_profile hsp_profile = {
+	.name		= "audio-hsp-hs",
+
+	.remote_uuid	= HSP_HS_UUID,
+	.device_probe	= hsp_hs_probe,
+	.device_remove	= hsp_hs_remove,
+
+	.auto_connect	= true,
+	.connect	= hsp_hs_connect,
+	.disconnect	= hsp_hs_disconnect,
+
+	.adapter_probe	= hsp_hs_server_probe,
+	.adapter_remove = hsp_hs_server_remove,
+};
+
+static int hsp_init(void)
+{
+	int err;
+
+	err = btd_profile_register(&hsp_profile);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static void hsp_exit(void)
+{
+	btd_profile_unregister(&hsp_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(hsp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							hsp_init, hsp_exit)
-- 
1.8.1.4

