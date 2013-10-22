Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: HID host
Date: Tue, 22 Oct 2013 13:43:41 +0300
Message-Id: <1382438621-24272-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frederic Danis <frederic.danis@linux.intel.com>

Basic implementation of HID host for Android.
---
 android/hidhost-device.c | 975 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 975 insertions(+)
 create mode 100644 android/hidhost-device.c

diff --git a/android/hidhost-device.c b/android/hidhost-device.c
new file mode 100644
index 0000000..eb3849d
--- /dev/null
+++ b/android/hidhost-device.c
@@ -0,0 +1,975 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+#include <stdlib.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <fcntl.h>
+
+#include <glib.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+#include <btio/btio.h>
+
+#include <linux/uhid.h>
+
+#include "log.h"
+#include "src/shared/mgmt.h"
+#include "adapter.h"
+#include "device.h"
+
+#define L2CAP_PSM_HIDP_CTRL	0x11
+#define L2CAP_PSM_HIDP_INTR	0x13
+
+#define UHID_DEVICE_FILE	"/dev/uhid"
+
+#define REPORT_MAP_MAX_SIZE	512
+
+enum reconnect_mode_t {
+	RECONNECT_NONE = 0,
+	RECONNECT_DEVICE,
+	RECONNECT_HOST,
+	RECONNECT_ANY
+};
+
+struct input_device {
+/*	struct btd_service	*service;
+*/
+	struct bt_device	*device;
+/*	char			*path;
+*/
+	bdaddr_t		src;
+	bdaddr_t		dst;
+/*	uint32_t		handle;
+*/
+	GIOChannel		*ctrl_io;
+	GIOChannel		*intr_io;
+	guint			ctrl_watch;
+	guint			intr_watch;
+/*	guint			sec_watch;
+*/
+	guint			uhid_watch_id;
+/*	struct hidp_connadd_req *req;
+*/
+	guint			dc_id;
+/*	bool			disable_sdp;
+	char			*name;
+*/
+	enum reconnect_mode_t	reconnect_mode;
+	guint			reconnect_timer;
+	uint32_t		reconnect_attempt;
+	int			uhid_fd;
+};
+
+static GSList *conns = NULL;
+
+static struct input_device *find_conn(GSList *list,
+						const bdaddr_t *bd_addr)
+{
+	for (; list; list = list->next) {
+		struct input_device *idev = list->data;
+
+		if (bacmp(bd_addr, bt_device_get_address(idev->device)))
+			return idev;
+	}
+
+	return NULL;
+}
+
+static void input_device_enter_reconnect_mode(struct input_device *idev);
+
+static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
+				gpointer data)
+{
+	struct input_device *idev = data;
+	char address[18];
+
+	ba2str(&idev->dst, address);
+
+	DBG("Device %s disconnected", address);
+
+	/* Checking for ctrl_watch avoids a double g_io_channel_shutdown since
+	 * it's likely that ctrl_watch_cb has been queued for dispatching in
+	 * this mainloop iteration */
+	if ((cond & (G_IO_HUP | G_IO_ERR)) && idev->ctrl_watch)
+		g_io_channel_shutdown(chan, TRUE, NULL);
+
+	bt_device_remove_disconnect_watch(idev->device, idev->dc_id);
+	idev->dc_id = 0;
+
+	idev->intr_watch = 0;
+
+	if (idev->intr_io) {
+		g_io_channel_unref(idev->intr_io);
+		idev->intr_io = NULL;
+	}
+
+	/* Close control channel */
+	if (idev->ctrl_io && !(cond & G_IO_NVAL))
+		g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
+
+	/* TODO:
+	btd_service_disconnecting_complete(idev->service, 0);
+	*/
+
+	/* Enter the auto-reconnect mode if needed */
+	input_device_enter_reconnect_mode(idev);
+
+	return FALSE;
+}
+
+static void ctrl_disconnected(struct input_device *idev, GIOChannel *chan,
+							GIOCondition cond)
+{
+	char address[18];
+
+	ba2str(&idev->dst, address);
+
+	DBG("Device %s disconnected", address);
+
+	/* Checking for intr_watch avoids a double g_io_channel_shutdown since
+	 * it's likely that intr_watch_cb has been queued for dispatching in
+	 * this mainloop iteration */
+	if ((cond & (G_IO_HUP | G_IO_ERR)) && idev->intr_watch)
+		g_io_channel_shutdown(chan, TRUE, NULL);
+
+	idev->ctrl_watch = 0;
+
+	if (idev->ctrl_io) {
+		g_io_channel_unref(idev->ctrl_io);
+		idev->ctrl_io = NULL;
+	}
+
+	/* Close interrupt channel */
+	if (idev->intr_io && !(cond & G_IO_NVAL))
+		g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
+}
+
+static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
+				gpointer data)
+{
+	struct input_device *idev = data;
+#if 0
+	char address[18];
+
+	ba2str(&idev->dst, address);
+
+	DBG("Device %s disconnected", address);
+
+	/* Checking for intr_watch avoids a double g_io_channel_shutdown since
+	 * it's likely that intr_watch_cb has been queued for dispatching in
+	 * this mainloop iteration */
+	if ((cond & (G_IO_HUP | G_IO_ERR)) && idev->intr_watch)
+		g_io_channel_shutdown(chan, TRUE, NULL);
+
+	idev->ctrl_watch = 0;
+
+	if (idev->ctrl_io) {
+		g_io_channel_unref(idev->ctrl_io);
+		idev->ctrl_io = NULL;
+	}
+
+	/* Close interrupt channel */
+	if (idev->intr_io && !(cond & G_IO_NVAL))
+		g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
+
+	return FALSE;
+#else
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		/* TODO: */
+		;
+	}
+
+	return TRUE;
+#endif
+}
+
+#ifndef STORAGEDIR
+#define STORAGEDIR "/var/lib/bluetooth"
+#endif
+
+sdp_record_t *record_from_string(const char *str)
+{
+	sdp_record_t *rec;
+	int size, i, len;
+	uint8_t *pdata;
+	char tmp[3];
+
+	size = strlen(str)/2;
+	pdata = g_malloc0(size);
+
+	tmp[2] = 0;
+	for (i = 0; i < size; i++) {
+		memcpy(tmp, str + (i * 2), 2);
+		pdata[i] = (uint8_t) strtol(tmp, NULL, 16);
+	}
+
+	rec = sdp_extract_pdu(pdata, size, &len);
+	g_free(pdata);
+
+	return rec;
+}
+
+#define HIDP_VIRTUAL_CABLE_UNPLUG	0
+#define HIDP_BOOT_PROTOCOL_MODE		1
+#define HIDP_BLUETOOTH_VENDOR_ID	9
+
+struct uhid_connadd_req {
+/*	int ctrl_sock;		/* Connected control socket */
+/*	int intr_sock;		/* Connected interrupt socket */
+	uint16_t parser;	/* Parser version */
+	uint16_t rd_size;	/* Report descriptor size */
+	uint8_t *rd_data;	/* Report descriptor data */
+	uint8_t  country;
+	uint8_t  subclass;
+	uint16_t vendor;
+	uint16_t product;
+/*	uint16_t version;
+*/
+	uint32_t flags;
+/*	uint32_t idle_to;
+*/
+	char name[128];		/* Device name */
+};
+
+static void epox_endian_quirk(unsigned char *data, int size)
+{
+	/* USAGE_PAGE (Keyboard)	05 07
+	 * USAGE_MINIMUM (0)		19 00
+	 * USAGE_MAXIMUM (65280)	2A 00 FF   <= must be FF 00
+	 * LOGICAL_MINIMUM (0)		15 00
+	 * LOGICAL_MAXIMUM (65280)	26 00 FF   <= must be FF 00
+	 */
+	unsigned char pattern[] = { 0x05, 0x07, 0x19, 0x00, 0x2a, 0x00, 0xff,
+						0x15, 0x00, 0x26, 0x00, 0xff };
+	unsigned int i;
+
+	if (!data)
+		return;
+
+	for (i = 0; i < size - sizeof(pattern); i++) {
+		if (!memcmp(data + i, pattern, sizeof(pattern))) {
+			data[i + 5] = 0xff;
+			data[i + 6] = 0x00;
+			data[i + 10] = 0xff;
+			data[i + 11] = 0x00;
+		}
+	}
+}
+
+static int create_hid_dev_name(sdp_record_t *rec, struct uhid_connadd_req *req)
+{
+	char sdesc[sizeof(req->name)];
+
+	if (sdp_get_service_desc(rec, sdesc, sizeof(sdesc)) == 0) {
+		char pname[sizeof(req->name)];
+
+		if (sdp_get_provider_name(rec, pname, sizeof(pname)) == 0 &&
+						strncmp(sdesc, pname, 5) != 0)
+			snprintf(req->name, sizeof(req->name), "%s %s", pname,
+									sdesc);
+		else
+			snprintf(req->name, sizeof(req->name), "%s", sdesc);
+	} else {
+		return sdp_get_service_name(rec, req->name, sizeof(req->name));
+	}
+
+	return 0;
+}
+
+/* See HID profile specification v1.0, "7.11.6 HIDDescriptorList" for details
+ * on the attribute format. */
+static int extract_hid_desc_data(sdp_record_t *rec,
+						struct uhid_connadd_req *req)
+{
+	sdp_data_t *d;
+
+	d = sdp_data_get(rec, SDP_ATTR_HID_DESCRIPTOR_LIST);
+	if (!d)
+		goto invalid_desc;
+
+	if (!SDP_IS_SEQ(d->dtd))
+		goto invalid_desc;
+
+	/* First HIDDescriptor */
+	d = d->val.dataseq;
+	if (!SDP_IS_SEQ(d->dtd))
+		goto invalid_desc;
+
+	/* ClassDescriptorType */
+	d = d->val.dataseq;
+	if (d->dtd != SDP_UINT8)
+		goto invalid_desc;
+
+	/* ClassDescriptorData */
+	d = d->next;
+	if (!d || !SDP_IS_TEXT_STR(d->dtd))
+		goto invalid_desc;
+
+	req->rd_data = g_try_malloc0(d->unitSize);
+	if (req->rd_data) {
+		memcpy(req->rd_data, d->val.str, d->unitSize);
+		req->rd_size = d->unitSize;
+		epox_endian_quirk(req->rd_data, req->rd_size);
+	}
+
+	return 0;
+
+invalid_desc:
+	error("Missing or invalid HIDDescriptorList SDP attribute");
+	return -EINVAL;
+}
+
+static int extract_hid_record(sdp_record_t *rec, struct uhid_connadd_req *req)
+{
+	sdp_data_t *pdlist;
+	uint8_t attr_val;
+	int err;
+
+	err = create_hid_dev_name(rec, req);
+	if (err < 0)
+		DBG("No valid Service Name or Service Description found");
+
+	pdlist = sdp_data_get(rec, SDP_ATTR_HID_PARSER_VERSION);
+	req->parser = pdlist ? pdlist->val.uint16 : 0x0100;
+
+	pdlist = sdp_data_get(rec, SDP_ATTR_HID_DEVICE_SUBCLASS);
+	req->subclass = pdlist ? pdlist->val.uint8 : 0;
+
+	pdlist = sdp_data_get(rec, SDP_ATTR_HID_COUNTRY_CODE);
+	req->country = pdlist ? pdlist->val.uint8 : 0;
+
+	pdlist = sdp_data_get(rec, SDP_ATTR_HID_VIRTUAL_CABLE);
+	attr_val = pdlist ? pdlist->val.uint8 : 0;
+	if (attr_val)
+		req->flags |= (1 << HIDP_VIRTUAL_CABLE_UNPLUG);
+
+	pdlist = sdp_data_get(rec, SDP_ATTR_HID_BOOT_DEVICE);
+	attr_val = pdlist ? pdlist->val.uint8 : 0;
+	if (attr_val)
+		req->flags |= (1 << HIDP_BOOT_PROTOCOL_MODE);
+
+	err = extract_hid_desc_data(rec, req);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int uhid_add_connection(struct input_device *idev)
+{
+	struct uhid_connadd_req *req;
+	sdp_record_t *rec;
+	char src_addr[18], dst_addr[18];
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char handle[11], *str;
+	uint8_t value[REPORT_MAP_MAX_SIZE];
+	struct uhid_event ev;
+	int i;
+	int err;
+
+	/* TODO: */
+#if 1
+	req = g_new0(struct uhid_connadd_req, 1);
+
+	ba2str(&idev->src, src_addr);
+	ba2str(&idev->dst, dst_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", src_addr,
+								dst_addr);
+	filename[PATH_MAX] = '\0';
+#if 0
+	sprintf(handle, "0x%8.8X", idev->handle);
+#else
+	sprintf(handle, "0x00010000");
+#endif
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	str = g_key_file_get_string(key_file, "ServiceRecords", handle, NULL);
+	g_key_file_free(key_file);
+
+	if (!str) {
+		error("Rejected connection from unknown device %s", dst_addr);
+#if 0
+		err = -EPERM;
+		goto cleanup;
+#else
+		return -1;
+#endif
+	}
+
+	rec = record_from_string(str);
+	g_free(str);
+
+	err = extract_hid_record(rec, req);
+	sdp_record_free(rec);
+	if (err < 0) {
+		error("Could not parse HID SDP record: %s (%d)", strerror(-err),
+									-err);
+#if 0
+		goto cleanup;
+#else
+		return -1;
+#endif
+	}
+#endif
+
+	DBG("Report MAP:");
+	for (i = 0; i < req->rd_size; i++) {
+#if 0
+		switch (value[i]) {
+		case 0x85:
+		case 0x86:
+		case 0x87:
+			hogdev->has_report_id = TRUE;
+		}
+#endif
+
+		if (i % 2 == 0) {
+			if (i + 1 == req->rd_size)
+				DBG("\t %02x", req->rd_data[i]);
+			else
+				DBG("\t %02x %02x", req->rd_data[i],
+							req->rd_data[i + 1]);
+		}
+	}
+
+#if 0
+	vendor_src = btd_device_get_vendor_src(idev->device);
+	vendor = btd_device_get_vendor(idev->device);
+	product = btd_device_get_product(idev->device);
+	version = btd_device_get_version(idev->device);
+/*	DBG("DIS information: vendor_src=0x%X, vendor=0x%X, product=0x%X, "
+			"version=0x%X",	vendor_src, vendor, product, version);
+*/
+#else
+	DBG("DIS information: vendor=0x%X, product=0x%X, version=0x%X",
+					req->vendor, req->product, req->parser);
+#endif
+
+	/* create uHID device */
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE;
+	strcpy((char *) ev.u.create.name, "bluez-hid-device");
+#if 0
+	ev.u.create.vendor = vendor;
+	ev.u.create.product = product;
+	ev.u.create.version = version;
+	ev.u.create.country = hogdev->bcountrycode;
+#else
+	ev.u.create.vendor = req->vendor;
+	ev.u.create.product = req->product;
+	ev.u.create.version = req->parser;
+	ev.u.create.country = req->country;
+#endif
+	ev.u.create.bus = BUS_BLUETOOTH;
+	ev.u.create.rd_data = req->rd_data;
+	ev.u.create.rd_size = req->rd_size;
+
+	if (write(idev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("Failed to create uHID device: %s", strerror(errno));
+
+	return 0;
+}
+
+static int is_connected(struct input_device *idev)
+{
+	/* TODO: */
+#if 0
+	struct hidp_conninfo ci;
+	int ctl;
+
+	/* Standard HID */
+	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
+	if (ctl < 0)
+		return 0;
+
+	memset(&ci, 0, sizeof(ci));
+	bacpy(&ci.bdaddr, &idev->dst);
+	if (ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) {
+		close(ctl);
+		return 0;
+	}
+
+	close(ctl);
+
+	if (ci.state != BT_CONNECTED)
+		return 0;
+	else
+		return 1;
+#else
+	return 0;
+#endif
+}
+
+static void disconnect_cb(struct bt_device *device, gboolean removal,
+				void *user_data)
+{
+	/* TODO: */
+#if 0
+	struct input_device *idev = user_data;
+	int flags;
+
+	info("Input: disconnect %s", idev->path);
+
+	flags = removal ? (1 << HIDP_VIRTUAL_CABLE_UNPLUG) : 0;
+
+	connection_disconnect(idev, flags);
+#endif
+}
+
+static int input_device_connected(struct input_device *idev)
+{
+	int err;
+
+	if (idev->intr_io == NULL || idev->ctrl_io == NULL)
+		return -ENOTCONN;
+
+	err = uhid_add_connection(idev);
+	if (err < 0)
+		return err;
+
+	idev->dc_id = bt_device_add_disconnect_watch(idev->device,
+							disconnect_cb,
+							idev, NULL);
+
+	/* TODO:
+	btd_service_connecting_complete(idev->service, 0);
+	*/
+
+	return 0;
+}
+
+static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
+							gpointer user_data)
+{
+	struct input_device *idev = user_data;
+	int err;
+
+	if (conn_err) {
+		err = -EIO;
+		goto failed;
+	}
+
+	err = input_device_connected(idev);
+	if (err < 0)
+		goto failed;
+
+	idev->intr_watch = g_io_add_watch(idev->intr_io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					intr_watch_cb, idev);
+
+	return;
+
+failed:
+	/* TODO:
+	btd_service_connecting_complete(idev->service, err);
+	*/
+
+	/* So we guarantee the interrupt channel is closed before the
+	 * control channel (if we only do unref GLib will close it only
+	 * after returning control to the mainloop */
+	if (!conn_err)
+		g_io_channel_shutdown(idev->intr_io, FALSE, NULL);
+
+	g_io_channel_unref(idev->intr_io);
+	idev->intr_io = NULL;
+
+	if (idev->ctrl_io) {
+		g_io_channel_unref(idev->ctrl_io);
+		idev->ctrl_io = NULL;
+	}
+}
+
+static void control_connect_cb(GIOChannel *chan, GError *conn_err,
+							gpointer user_data)
+{
+	struct input_device *idev = user_data;
+	GIOChannel *io;
+	GError *err = NULL;
+
+	if (conn_err) {
+		error("%s", conn_err->message);
+		goto failed;
+	}
+
+	/* Connect to the HID interrupt channel */
+	io = bt_io_connect(interrupt_connect_cb, idev,
+				NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &idev->src,
+				BT_IO_OPT_DEST_BDADDR, &idev->dst,
+				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto failed;
+	}
+
+	idev->intr_io = io;
+
+	idev->ctrl_watch = g_io_add_watch(idev->ctrl_io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					ctrl_watch_cb, idev);
+
+	return;
+
+failed:
+	/* TODO:
+	btd_service_connecting_complete(idev->service, -EIO);
+	*/
+	g_io_channel_unref(idev->ctrl_io);
+	idev->ctrl_io = NULL;
+}
+
+static int dev_connect(struct input_device *idev)
+{
+	GError *err = NULL;
+	GIOChannel *io;
+
+	/* TODO: */
+#if 0
+	if (idev->disable_sdp)
+		bt_clear_cached_session(&idev->src, &idev->dst);
+#endif
+
+	io = bt_io_connect(control_connect_cb, idev,
+			NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &idev->src,
+			BT_IO_OPT_DEST_BDADDR, &idev->dst,
+			BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
+			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+			BT_IO_OPT_INVALID);
+	idev->ctrl_io = io;
+
+	if (err == NULL)
+		return 0;
+
+	error("%s", err->message);
+	g_error_free(err);
+
+	return -EIO;
+}
+
+static gboolean input_device_auto_reconnect(gpointer user_data)
+{
+	struct input_device *idev = user_data;
+
+	/* TODO: */
+#if 0
+	DBG("path=%s, attempt=%d", idev->path, idev->reconnect_attempt);
+
+	/* Stop the recurrent reconnection attempts if the device is reconnected
+	 * or is marked for removal. */
+	if (device_is_temporary(idev->device) ||
+					device_is_connected(idev->device))
+		return FALSE;
+#else
+	DBG("attempt=%d", idev->reconnect_attempt);
+#endif
+
+	/* Only attempt an auto-reconnect for at most 3 minutes (6 * 30s). */
+	if (idev->reconnect_attempt >= 6)
+		return FALSE;
+
+	/* Check if the profile is already connected. */
+	if (idev->ctrl_io)
+		return FALSE;
+
+	if (is_connected(idev))
+		return FALSE;
+
+	idev->reconnect_attempt++;
+	dev_connect(idev);
+
+	return TRUE;
+}
+
+static const char * const _reconnect_mode_str[] = {
+	"none",
+	"device",
+	"host",
+	"any"
+};
+
+static const char *reconnect_mode_to_string(const enum reconnect_mode_t mode)
+{
+	return _reconnect_mode_str[mode];
+}
+
+static void input_device_enter_reconnect_mode(struct input_device *idev)
+{
+#if 0
+	DBG("path=%s reconnect_mode=%s", idev->path,
+				reconnect_mode_to_string(idev->reconnect_mode));
+#else
+	DBG("reconnect_mode=%s",
+		reconnect_mode_to_string(idev->reconnect_mode));
+#endif
+
+	/* Only attempt an auto-reconnect when the device is required to accept
+	 * reconnections from the host. */
+	if (idev->reconnect_mode != RECONNECT_ANY &&
+				idev->reconnect_mode != RECONNECT_HOST)
+		return;
+
+	/* TODO: */
+#if 0
+	/* If the device is temporary we are not required to reconnect with the
+	 * device. This is likely the case of a removing device. */
+	if (device_is_temporary(idev->device) ||
+					device_is_connected(idev->device))
+		return;
+#endif
+
+	if (idev->reconnect_timer > 0)
+		g_source_remove(idev->reconnect_timer);
+
+	DBG("registering auto-reconnect");
+	idev->reconnect_attempt = 0;
+	idev->reconnect_timer = g_timeout_add_seconds(30,
+					input_device_auto_reconnect, idev);
+
+}
+
+int input_device_connect(bdaddr_t *bd_addr)
+{
+	struct input_device *idev;
+
+	DBG("");
+
+	idev = find_conn(conns, bd_addr);
+
+	if (idev->ctrl_io)
+		return -EBUSY;
+
+	if (is_connected(idev))
+		return -EALREADY;
+
+	return dev_connect(idev);
+}
+
+static void forward_report(struct input_device *idev,
+						struct uhid_event *ev)
+{
+	/* TODO: */
+#if 0
+	struct report *report;
+	GSList *l;
+	void *data;
+	int size;
+	guint type;
+
+	if (idev->has_report_id) {
+		data = ev->u.output.data + 1;
+		size = ev->u.output.size - 1;
+	} else {
+		data = ev->u.output.data;
+		size = ev->u.output.size;
+	}
+
+	switch (ev->type) {
+	case UHID_OUTPUT:
+		type = HOG_REPORT_TYPE_OUTPUT;
+		break;
+	case UHID_FEATURE:
+		type = HOG_REPORT_TYPE_FEATURE;
+		break;
+	default:
+		return;
+	}
+
+	l = g_slist_find_custom(hogdev->reports, GUINT_TO_POINTER(type),
+							report_type_cmp);
+	if (!l)
+		return;
+
+	report = l->data;
+
+	DBG("Sending report type %d to device 0x%04X handle 0x%X", type,
+			idev->id, report->decl->value_handle);
+
+	if (idev->attrib == NULL)
+		return;
+
+	if (report->decl->properties & ATT_CHAR_PROPER_WRITE)
+		gatt_write_char(idev->attrib, report->decl->value_handle,
+				data, size, output_written_cb, idev);
+	else if (report->decl->properties & ATT_CHAR_PROPER_WRITE_WITHOUT_RESP)
+		gatt_write_cmd(idev->attrib, report->decl->value_handle,
+						data, size, NULL, NULL);
+#endif
+}
+
+static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct input_device *idev = user_data;
+	struct uhid_event ev;
+	ssize_t bread;
+	int fd;
+
+	if (cond & (G_IO_ERR | G_IO_NVAL))
+		goto failed;
+
+	fd = g_io_channel_unix_get_fd(io);
+	memset(&ev, 0, sizeof(ev));
+
+	bread = read(fd, &ev, sizeof(ev));
+	if (bread < 0) {
+		int err = -errno;
+		DBG("uhid-dev read: %s(%d)", strerror(-err), -err);
+		goto failed;
+	}
+
+	DBG("uHID event type %d received", ev.type);
+
+	switch (ev.type) {
+	case UHID_START:
+	case UHID_STOP:
+		/* These are called to start and stop the underlying hardware.
+		 * For HoG we open the channels before creating the device so
+		 * the hardware is always ready. No need to handle these.
+		 * Note that these are also called when the kernel switches
+		 * between device-drivers loaded on the HID device. But we can
+		 * simply keep the hardware alive during transitions and it
+		 * works just fine.
+		 * The kernel never destroys a device itself! Only an explicit
+		 * UHID_DESTROY request can remove a device. */
+		break;
+	case UHID_OPEN:
+	case UHID_CLOSE:
+		/* OPEN/CLOSE are sent whenever user-space opens any interface
+		 * provided by the kernel HID device. Whenever the open-count
+		 * is non-zero we must be ready for I/O. As long as it is zero,
+		 * we can decide to drop all I/O and put the device
+		 * asleep This is optional, though. Moreover, some
+		 * special device drivers are buggy in that regard, so
+		 * maybe we just keep I/O always awake like HIDP in the
+		 * kernel does. */
+		break;
+	case UHID_OUTPUT:
+	case UHID_FEATURE:
+		forward_report(idev, &ev);
+		break;
+	case UHID_OUTPUT_EV:
+		/* This is only sent by kernels prior to linux-3.11. It
+		 * requires us to parse HID-descriptors in user-space to
+		 * properly handle it. This is redundant as the kernel
+		 * does it already. That's why newer kernels assemble
+		 * the output-reports and send it to us via UHID_OUTPUT.
+		 * We never implemented this, so we rely on users to use
+		 * recent-enough kernels if they want this feature. No reason
+		 * to implement this for older kernels. */
+		DBG("Unsupported uHID output event: type %d code %d value %d",
+			ev.u.output_ev.type, ev.u.output_ev.code,
+			ev.u.output_ev.value);
+		break;
+	default:
+		warn("unexpected uHID event");
+		break;
+	}
+
+	return TRUE;
+
+failed:
+	idev->uhid_watch_id = 0;
+	return FALSE;
+}
+
+static struct input_device *input_new_device(struct bt_device *device)
+{
+	struct input_device *idev;
+
+	idev = g_try_new0(struct input_device, 1);
+	if (!idev)
+		return NULL;
+
+	idev->device = bt_device_ref(device);
+
+	return idev;
+}
+
+static void input_free_device(struct input_device *idev)
+{
+	bt_device_unref(idev->device);
+/*	g_slist_free_full(idev->reports, report_free);
+*/	g_free(idev);
+}
+
+struct input_device *input_register_device(struct bt_device *device)
+{
+	struct input_device *idev;
+	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_NVAL;
+	GIOChannel *io;
+
+	idev = input_new_device(device);
+	if (!idev)
+		return NULL;
+
+	idev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
+	if (idev->uhid_fd < 0) {
+		error("Failed to open uHID device: %s(%d)", strerror(errno),
+									errno);
+		input_free_device(idev);
+		return NULL;
+	}
+
+	io = g_io_channel_unix_new(idev->uhid_fd);
+	g_io_channel_set_encoding(io, NULL, NULL);
+	idev->uhid_watch_id = g_io_add_watch(io, cond, uhid_event_cb, idev);
+	g_io_channel_unref(io);
+
+	return idev;
+}
+
+int input_unregister_device(struct input_device *idev)
+{
+	struct uhid_event ev;
+
+	if (idev->uhid_watch_id) {
+		g_source_remove(idev->uhid_watch_id);
+		idev->uhid_watch_id = 0;
+	}
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+	if (write(idev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("Failed to destroy uHID device: %s", strerror(errno));
+
+	close(idev->uhid_fd);
+	idev->uhid_fd = -1;
+
+	input_free_device(idev);
+
+	return 0;
+}
-- 
1.8.1.2

