Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] input: Add userspace HID support
Message-Id: <20140508200001.D3AB3100D85@puck.mtv.corp.google.com>
Date: Thu,  8 May 2014 13:00:01 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enable HID protocol handling in userspace when UserspaceHID=true in input.conf.

Benefits of userspace HID:
1. Persistent HID/input pipeline
   For a Bluetooth HID device, the corresponding kernel HID/input devices are
   created only once when the Bluetooth HID device is used the first time.
   The HID/input pipeline is not destroyed and recreated every time when
   the Bluetooth HID device disconnects and reconnects.

2. HID vs HoG parity
   Enables HID and HoG devices to operate the same way in BlueZ stack, using
   uHID kernel module (/dev/uhid) to pass HID report data between bluetoothd
   and kernel HID subsystem.

3. Debugging
   It is easier to debug HID protocol in userspace than in HIDP kernel module.
---
 Makefile.plugins           |   3 +-
 profiles/input/device.c    | 674 +++++++++++++++++++++++++++++++++++++++++++--
 profiles/input/device.h    |   1 +
 profiles/input/hidp_defs.h |  79 ++++++
 profiles/input/input.conf  |   4 +
 profiles/input/manager.c   |  10 +
 6 files changed, 754 insertions(+), 17 deletions(-)
 create mode 100644 profiles/input/hidp_defs.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 6a1ddbf..f0eada9 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -55,7 +55,8 @@ builtin_sources += profiles/network/manager.c \
 builtin_modules += input
 builtin_sources += profiles/input/manager.c \
 			profiles/input/server.h profiles/input/server.c \
-			profiles/input/device.h profiles/input/device.c
+			profiles/input/device.h profiles/input/device.c \
+			profiles/input/uhid_copy.h profiles/input/hidp_defs.h
 
 builtin_modules += hog
 builtin_sources += profiles/input/hog.c profiles/input/uhid_copy.h \
diff --git a/profiles/input/device.c b/profiles/input/device.c
index f1fa716..59fcf9e 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -3,6 +3,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2014       Google Inc.
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -53,9 +54,13 @@
 #include "src/sdp-client.h"
 
 #include "device.h"
+#include "hidp_defs.h"
+#include "uhid_copy.h"
 
 #define INPUT_INTERFACE "org.bluez.Input1"
 
+#define UHID_DEVICE_FILE "/dev/uhid"
+
 enum reconnect_mode_t {
 	RECONNECT_NONE = 0,
 	RECONNECT_DEVICE,
@@ -81,16 +86,30 @@ struct input_device {
 	enum reconnect_mode_t	reconnect_mode;
 	guint			reconnect_timer;
 	uint32_t		reconnect_attempt;
+	bool			uhid_enabled;
+	int			uhid_fd;
+	guint			uhid_watch;
+	bool			uhid_created;
+	uint8_t			report_req_pending;
+	guint			report_req_timer;
+	uint32_t		report_rsp_id;
 };
 
 static int idle_timeout = 0;
+static bool uhid_enabled = false;
 
 void input_set_idle_timeout(int timeout)
 {
 	idle_timeout = timeout;
 }
 
+void input_enable_userspace_hid(bool state)
+{
+	uhid_enabled = state;
+}
+
 static void input_device_enter_reconnect_mode(struct input_device *idev);
+static int connection_disconnect(struct input_device *idev, uint32_t flags);
 
 static void input_device_free(struct input_device *idev)
 {
@@ -124,14 +143,189 @@ static void input_device_free(struct input_device *idev)
 	if (idev->reconnect_timer > 0)
 		g_source_remove(idev->reconnect_timer);
 
+	if (idev->report_req_timer > 0)
+		g_source_remove(idev->report_req_timer);
+
 	g_free(idev);
 }
 
+static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
+					const uint8_t *data, size_t size)
+{
+	int fd;
+	ssize_t len;
+	uint8_t msg[size + 1];
+
+	if (data == NULL)
+		size = 0;
+
+	msg[0] = hdr;
+	if (size > 0)
+		memcpy(&msg[1], data, size);
+	++size;
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	len = write(fd, msg, size);
+	if (len < 0) {
+		error("BT socket write error: %s (%d)", strerror(errno), errno);
+		return false;
+	}
+
+	if ((size_t)len < size) {
+		error("BT socket write error: partial write (%zd of %zu bytes)",
+								len, size);
+		return false;
+	}
+
+	return true;
+}
+
+static bool hidp_send_ctrl_message(struct input_device *idev, uint8_t hdr,
+					const uint8_t *data, size_t size)
+{
+	return hidp_send_message(idev->ctrl_io, hdr, data, size);
+}
+
+static bool hidp_send_intr_message(struct input_device *idev, uint8_t hdr,
+					const uint8_t *data, size_t size)
+{
+	return hidp_send_message(idev->intr_io, hdr, data, size);
+}
+
+static bool uhid_send_feature_answer(struct input_device *idev,
+					const uint8_t *data, size_t size,
+					uint32_t id, uint16_t err)
+{
+	struct uhid_event ev;
+	ssize_t len;
+
+	if (data == NULL)
+		size = 0;
+
+	if (size > sizeof(ev.u.feature_answer.data))
+		size = sizeof(ev.u.feature_answer.data);
+
+	if (!idev->uhid_created) {
+		DBG("HID report (%zu bytes) dropped", size);
+		return false;
+	}
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_FEATURE_ANSWER;
+	ev.u.feature_answer.id = id;
+	ev.u.feature_answer.err = err;
+	ev.u.feature_answer.size = size;
+
+	if (size > 0)
+		memcpy(ev.u.feature_answer.data, data, size);
+
+	len = write(idev->uhid_fd, &ev, sizeof(ev));
+	if (len < 0) {
+		error("uHID dev write error: %s (%d)", strerror(errno), errno);
+		return false;
+	}
+
+	/* uHID kernel driver does not handle partial writes */
+	if ((size_t)len < sizeof(ev)) {
+		error("uHID dev write error: partial write (%zd of %lu bytes)",
+							len, sizeof(ev));
+		return false;
+	}
+
+	DBG("HID report (%zu bytes) -> uHID fd %d", size, idev->uhid_fd);
+
+	return true;
+}
+
+static bool uhid_send_input_report(struct input_device *idev,
+					const uint8_t *data, size_t size)
+{
+	struct uhid_event ev;
+	ssize_t len;
+
+	if (data == NULL)
+		size = 0;
+
+	if (size > sizeof(ev.u.input.data))
+		size = sizeof(ev.u.input.data);
+
+	if (!idev->uhid_created) {
+		DBG("HID report (%zu bytes) dropped", size);
+		return false;
+	}
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_INPUT;
+	ev.u.input.size = size;
+
+	if (size > 0)
+		memcpy(ev.u.input.data, data, size);
+
+	len = write(idev->uhid_fd, &ev, sizeof(ev));
+	if (len < 0) {
+		error("uHID dev write error: %s (%d)", strerror(errno), errno);
+		return false;
+	}
+
+	/* uHID kernel driver does not handle partial writes */
+	if ((size_t)len < sizeof(ev)) {
+		error("uHID dev write error: partial write (%zd of %lu bytes)",
+							len, sizeof(ev));
+		return false;
+	}
+
+	DBG("HID report (%zu bytes) -> uHID fd %d", size, idev->uhid_fd);
+
+	return true;
+}
+
+static bool hidp_recv_intr_data(GIOChannel *chan, struct input_device *idev)
+{
+	int fd;
+	ssize_t len;
+	uint8_t hdr;
+	uint8_t data[UHID_DATA_MAX + 1];
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	len = read(fd, data, sizeof(data));
+	if (len < 0) {
+		error("BT socket read error: %s (%d)", strerror(errno), errno);
+		return false;
+	}
+
+	if (len == 0) {
+		DBG("BT socket read returned 0 bytes");
+		return true;
+	}
+
+	hdr = data[0];
+	if (hdr != (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
+		DBG("unsupported HIDP protocol header 0x%02x", hdr);
+		return true;
+	}
+
+	if (len < 2) {
+		DBG("received empty HID report");
+		return true;
+	}
+
+	uhid_send_input_report(idev, data + 1, len - 1);
+
+	return true;
+}
+
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct input_device *idev = data;
 	char address[18];
 
+	if (cond & G_IO_IN) {
+		if (hidp_recv_intr_data(chan, idev) && (cond == G_IO_IN))
+			return TRUE;
+	}
+
 	ba2str(&idev->dst, address);
 
 	DBG("Device %s disconnected", address);
@@ -164,11 +358,170 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	return FALSE;
 }
 
+static void hidp_recv_ctrl_handshake(struct input_device *idev, uint8_t param)
+{
+	bool pending_req_complete = false;
+	uint8_t pending_req_type;
+
+	DBG("");
+
+	pending_req_type = idev->report_req_pending & HIDP_HEADER_TRANS_MASK;
+
+	switch (param) {
+	case HIDP_HSHK_SUCCESSFUL:
+		if (pending_req_type == HIDP_TRANS_SET_REPORT) {
+			DBG("SET_REPORT successful");
+			pending_req_complete = true;
+		} else
+			DBG("Spurious HIDP_HSHK_SUCCESSFUL");
+		break;
+
+	case HIDP_HSHK_NOT_READY:
+	case HIDP_HSHK_ERR_INVALID_REPORT_ID:
+	case HIDP_HSHK_ERR_UNSUPPORTED_REQUEST:
+	case HIDP_HSHK_ERR_INVALID_PARAMETER:
+	case HIDP_HSHK_ERR_UNKNOWN:
+	case HIDP_HSHK_ERR_FATAL:
+		if (pending_req_type == HIDP_TRANS_GET_REPORT) {
+			DBG("GET_REPORT failed (%u)", param);
+			uhid_send_feature_answer(idev, NULL, 0,
+						idev->report_rsp_id, EIO);
+			pending_req_complete = true;
+		} else if (pending_req_type == HIDP_TRANS_SET_REPORT) {
+			DBG("SET_REPORT failed (%u)", param);
+			pending_req_complete = true;
+		} else
+			DBG("Spurious HIDP_HSHK_ERR");
+
+		if (param == HIDP_HSHK_ERR_FATAL)
+			hidp_send_ctrl_message(idev, HIDP_TRANS_HID_CONTROL |
+						HIDP_CTRL_SOFT_RESET, NULL, 0);
+		break;
+
+	default:
+		hidp_send_ctrl_message(idev, HIDP_TRANS_HANDSHAKE |
+				HIDP_HSHK_ERR_INVALID_PARAMETER, NULL, 0);
+		break;
+	}
+
+	if (pending_req_complete) {
+		idev->report_req_pending = 0;
+		if (idev->report_req_timer > 0) {
+			g_source_remove(idev->report_req_timer);
+			idev->report_req_timer = 0;
+		}
+		idev->report_rsp_id = 0;
+	}
+}
+
+static void hidp_recv_ctrl_hid_control(struct input_device *idev, uint8_t param)
+{
+	DBG("");
+
+	if (param == HIDP_CTRL_VIRTUAL_CABLE_UNPLUG)
+		connection_disconnect(idev, 0);
+}
+
+static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
+					const uint8_t *data, size_t size)
+{
+	uint8_t pending_req_type;
+	uint8_t pending_req_param;
+
+	DBG("");
+
+	pending_req_type = idev->report_req_pending & HIDP_HEADER_TRANS_MASK;
+	if (pending_req_type != HIDP_TRANS_GET_REPORT) {
+		DBG("Spurious DATA on control channel");
+		return;
+	}
+
+	pending_req_param = idev->report_req_pending & HIDP_HEADER_PARAM_MASK;
+	if (pending_req_param != param) {
+		DBG("Received DATA RTYPE doesn't match pending request RTYPE");
+		return;
+	}
+
+	switch (param) {
+	case HIDP_DATA_RTYPE_FEATURE:
+	case HIDP_DATA_RTYPE_INPUT:
+	case HIDP_DATA_RTYPE_OUPUT:
+		uhid_send_feature_answer(idev, data + 1, size - 1,
+							idev->report_rsp_id, 0);
+		break;
+
+	case HIDP_DATA_RTYPE_OTHER:
+		DBG("Received DATA_RTYPE_OTHER");
+		break;
+
+	default:
+		hidp_send_ctrl_message(idev, HIDP_TRANS_HANDSHAKE |
+				HIDP_HSHK_ERR_INVALID_PARAMETER, NULL, 0);
+		break;
+	}
+
+	idev->report_req_pending = 0;
+	if (idev->report_req_timer > 0) {
+		g_source_remove(idev->report_req_timer);
+		idev->report_req_timer = 0;
+	}
+	idev->report_rsp_id = 0;
+}
+
+static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
+{
+	int fd;
+	ssize_t len;
+	uint8_t hdr, type, param;
+	uint8_t data[UHID_DATA_MAX + 1];
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	len = read(fd, data, sizeof(data));
+	if (len < 0) {
+		error("BT socket read error: %s (%d)", strerror(errno), errno);
+		return false;
+	}
+
+	if (len == 0) {
+		DBG("BT socket read returned 0 bytes");
+		return true;
+	}
+
+	hdr = data[0];
+	type = hdr & HIDP_HEADER_TRANS_MASK;
+	param = hdr & HIDP_HEADER_PARAM_MASK;
+
+	switch (type) {
+	case HIDP_TRANS_HANDSHAKE:
+		hidp_recv_ctrl_handshake(idev, param);
+		break;
+	case HIDP_TRANS_HID_CONTROL:
+		hidp_recv_ctrl_hid_control(idev, param);
+		break;
+	case HIDP_TRANS_DATA:
+		hidp_recv_ctrl_data(idev, param, data, len);
+		break;
+	default:
+		error("unsupported HIDP control message");
+		hidp_send_ctrl_message(idev, HIDP_TRANS_HANDSHAKE |
+				HIDP_HSHK_ERR_UNSUPPORTED_REQUEST, NULL, 0);
+		break;
+	}
+
+	return true;
+}
+
 static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct input_device *idev = data;
 	char address[18];
 
+	if (cond & G_IO_IN) {
+		if (hidp_recv_ctrl_message(chan, idev) && (cond == G_IO_IN))
+			return TRUE;
+	}
+
 	ba2str(&idev->dst, address);
 
 	DBG("Device %s disconnected", address);
@@ -193,6 +546,202 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	return FALSE;
 }
 
+#define REPORT_REQ_TIMEOUT  3
+
+static gboolean hidp_report_req_timeout(gpointer data)
+{
+	struct input_device *idev = data;
+	uint8_t pending_req_type;
+	const char *req_type_str;
+	char address[18];
+
+	ba2str(&idev->dst, address);
+	pending_req_type = idev->report_req_pending & HIDP_HEADER_TRANS_MASK;
+
+	switch (pending_req_type) {
+	case HIDP_TRANS_GET_REPORT:
+		req_type_str = "GET_REPORT";
+		break;
+	case HIDP_TRANS_SET_REPORT:
+		req_type_str = "SET_REPORT";
+		break;
+	default:
+		/* Should never happen */
+		req_type_str = "OTHER_TRANS";
+		break;
+	}
+
+	DBG("Device %s HIDP %s request timed out", address, req_type_str);
+
+	idev->report_req_pending = 0;
+	idev->report_req_timer = 0;
+	idev->report_rsp_id = 0;
+
+	return FALSE;
+}
+
+static void hidp_send_set_report(struct input_device *idev,
+							struct uhid_event *ev)
+{
+	uint8_t hdr;
+	bool sent;
+
+	DBG("");
+
+	switch (ev->u.output.rtype) {
+	case UHID_FEATURE_REPORT:
+		/* Send SET_REPORT on control channel */
+		if (idev->report_req_pending) {
+			DBG("Old GET_REPORT or SET_REPORT still pending");
+			return;
+		}
+
+		hdr = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;
+		sent = hidp_send_ctrl_message(idev, hdr, ev->u.output.data,
+							ev->u.output.size);
+		if (sent) {
+			idev->report_req_pending = hdr;
+			idev->report_req_timer =
+				g_timeout_add_seconds(REPORT_REQ_TIMEOUT,
+						hidp_report_req_timeout, idev);
+		}
+		break;
+	case UHID_OUTPUT_REPORT:
+		/* Send DATA on interrupt channel */
+		hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
+		hidp_send_intr_message(idev, hdr, ev->u.output.data,
+							ev->u.output.size);
+		break;
+	default:
+		DBG("Unsupported HID report type %u", ev->u.output.rtype);
+		return;
+	}
+}
+
+static void hidp_send_get_report(struct input_device *idev,
+							struct uhid_event *ev)
+{
+	uint8_t hdr;
+	bool sent;
+
+	DBG("");
+
+	if (idev->report_req_pending) {
+		DBG("Old GET_REPORT or SET_REPORT still pending");
+		uhid_send_feature_answer(idev, NULL, 0, ev->u.feature.id,
+									EBUSY);
+		return;
+	}
+
+	/* Send GET_REPORT on control channel */
+	switch (ev->u.feature.rtype) {
+	case UHID_FEATURE_REPORT:
+		hdr = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_FEATURE;
+		break;
+	case UHID_INPUT_REPORT:
+		hdr = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_INPUT;
+		break;
+	case UHID_OUTPUT_REPORT:
+		hdr = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_OUPUT;
+		break;
+	default:
+		DBG("Unsupported HID report type %u", ev->u.feature.rtype);
+		return;
+	}
+
+	sent = hidp_send_ctrl_message(idev, hdr, &ev->u.feature.rnum,
+						sizeof(ev->u.feature.rnum));
+	if (sent) {
+		idev->report_req_pending = hdr;
+		idev->report_req_timer =
+			g_timeout_add_seconds(REPORT_REQ_TIMEOUT,
+						hidp_report_req_timeout, idev);
+		idev->report_rsp_id = ev->u.feature.id;
+	}
+}
+
+static gboolean uhid_watch_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	struct input_device *idev = user_data;
+	int fd;
+	ssize_t len;
+	struct uhid_event ev;
+
+	if (cond & (G_IO_ERR | G_IO_NVAL))
+		goto failed;
+
+	fd = g_io_channel_unix_get_fd(chan);
+	memset(&ev, 0, sizeof(ev));
+
+	len = read(fd, &ev, sizeof(ev));
+	if (len < 0) {
+		error("uHID dev read error: %s (%d)", strerror(errno), errno);
+		goto failed;
+	}
+
+	if ((size_t)len < sizeof(ev.type)) {
+		error("uHID dev read returned too few bytes");
+		goto failed;
+	}
+
+	DBG("uHID event type %u received (%zd bytes)", ev.type, len);
+
+	switch (ev.type) {
+	case UHID_START:
+	case UHID_STOP:
+		/* These are called to start and stop the underlying hardware.
+		 * For HID we open the channels before creating the device so
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
+		hidp_send_set_report(idev, &ev);
+		break;
+	case UHID_FEATURE:
+		hidp_send_get_report(idev, &ev);
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
+		DBG("Unsupported uHID output event: type %u code %u value %d",
+				ev.u.output_ev.type, ev.u.output_ev.code,
+				ev.u.output_ev.value);
+		break;
+	default:
+		warn("unexpected uHID event");
+		break;
+	}
+
+	return TRUE;
+
+failed:
+	idev->uhid_watch = 0;
+	return FALSE;
+}
+
 static void epox_endian_quirk(unsigned char *data, int size)
 {
 	/* USAGE_PAGE (Keyboard)	05 07
@@ -395,6 +944,38 @@ static int ioctl_disconnect(struct input_device *idev, uint32_t flags)
 	return err;
 }
 
+static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
+{
+	int err = 0;
+	struct uhid_event ev;
+
+	if (!idev->uhid_created) {
+		/* create uHID device */
+		memset(&ev, 0, sizeof(ev));
+		ev.type = UHID_CREATE;
+		strncpy((char *) ev.u.create.name, req->name,
+						sizeof(ev.u.create.name) - 1);
+		ba2str(&idev->src, (char *) ev.u.create.phys);
+		ba2str(&idev->dst, (char *) ev.u.create.uniq);
+		ev.u.create.vendor = req->vendor;
+		ev.u.create.product = req->product;
+		ev.u.create.version = req->version;
+		ev.u.create.country = req->country;
+		ev.u.create.bus = BUS_BLUETOOTH;
+		ev.u.create.rd_data = req->rd_data;
+		ev.u.create.rd_size = req->rd_size;
+
+		if (write(idev->uhid_fd, &ev, sizeof(ev)) < 0) {
+			err = -errno;
+			error("Failed to create uHID device: %s (%d)",
+							strerror(-err), -err);
+		} else
+			idev->uhid_created = true;
+	}
+
+	return err;
+}
+
 static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 								gpointer data)
 {
@@ -403,7 +984,11 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 
 	DBG("");
 
-	err = ioctl_connadd(idev->req);
+	if (idev->uhid_enabled)
+		err = uhid_connadd(idev, idev->req);
+	else
+		err = ioctl_connadd(idev->req);
+
 	if (err < 0) {
 		error("ioctl_connadd(): %s (%d)", strerror(-err), -err);
 
@@ -501,7 +1086,10 @@ static int hidp_add_connection(struct input_device *idev)
 		return 0;
 	}
 
-	err = ioctl_connadd(req);
+	if (idev->uhid_enabled)
+		err = uhid_connadd(idev, req);
+	else
+		err = ioctl_connadd(req);
 
 cleanup:
 	g_free(req->rd_data);
@@ -512,7 +1100,10 @@ cleanup:
 
 static bool is_connected(struct input_device *idev)
 {
-	return ioctl_is_connected(idev);
+	if (idev->uhid_enabled)
+		return (idev->intr_io != NULL && idev->ctrl_io != NULL);
+	else
+		return ioctl_is_connected(idev);
 }
 
 static int connection_disconnect(struct input_device *idev, uint32_t flags)
@@ -526,7 +1117,10 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
 	if (idev->ctrl_io)
 		g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
 
-	return ioctl_disconnect(idev, flags);
+	if (idev->uhid_enabled)
+		return 0;
+	else
+		return ioctl_disconnect(idev, flags);
 }
 
 static void disconnect_cb(struct btd_device *device, gboolean removal,
@@ -565,6 +1159,7 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 							gpointer user_data)
 {
 	struct input_device *idev = user_data;
+	GIOCondition cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	int err;
 
 	if (conn_err) {
@@ -576,9 +1171,11 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 	if (err < 0)
 		goto failed;
 
-	idev->intr_watch = g_io_add_watch(idev->intr_io,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					intr_watch_cb, idev);
+	if (idev->uhid_enabled)
+		cond |= G_IO_IN;
+
+	idev->intr_watch = g_io_add_watch(idev->intr_io, cond, intr_watch_cb,
+									idev);
 
 	return;
 
@@ -604,6 +1201,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 							gpointer user_data)
 {
 	struct input_device *idev = user_data;
+	GIOCondition cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	GIOChannel *io;
 	GError *err = NULL;
 
@@ -628,9 +1226,11 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 
 	idev->intr_io = io;
 
-	idev->ctrl_watch = g_io_add_watch(idev->ctrl_io,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					ctrl_watch_cb, idev);
+	if (idev->uhid_enabled)
+		cond |= G_IO_IN;
+
+	idev->ctrl_watch = g_io_add_watch(idev->ctrl_io, cond, ctrl_watch_cb,
+									idev);
 
 	return;
 
@@ -829,6 +1429,7 @@ static struct input_device *input_device_new(struct btd_service *service)
 	idev->path = g_strdup(path);
 	idev->handle = rec->handle;
 	idev->disable_sdp = is_device_sdp_disable(rec);
+	idev->uhid_enabled = uhid_enabled;
 
 	/* Initialize device properties */
 	extract_hid_props(idev, rec);
@@ -858,6 +1459,8 @@ int input_device_register(struct btd_service *service)
 	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
 	struct input_device *idev;
+	int err;
+	GIOChannel *io;
 
 	DBG("%s", path);
 
@@ -865,6 +1468,24 @@ int input_device_register(struct btd_service *service)
 	if (!idev)
 		return -EINVAL;
 
+	if (idev->uhid_enabled) {
+		idev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
+		if (idev->uhid_fd < 0) {
+			err = errno;
+			error("Failed to open uHID device: %s (%d)",
+							strerror(err), err);
+			input_device_free(idev);
+			return -err;
+		}
+
+		io = g_io_channel_unix_new(idev->uhid_fd);
+		g_io_channel_set_encoding(io, NULL, NULL);
+		idev->uhid_watch = g_io_add_watch(io,
+						G_IO_IN | G_IO_ERR | G_IO_NVAL,
+						uhid_watch_cb, idev);
+		g_io_channel_unref(io);
+	}
+
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 					idev->path, INPUT_INTERFACE,
 					NULL, NULL,
@@ -902,12 +1523,31 @@ void input_device_unregister(struct btd_service *service)
 	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
 	struct input_device *idev = btd_service_get_user_data(service);
+	struct uhid_event ev;
 
 	DBG("%s", path);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 						idev->path, INPUT_INTERFACE);
 
+	if (idev->uhid_enabled) {
+		if (idev->uhid_watch) {
+			g_source_remove(idev->uhid_watch);
+			idev->uhid_watch = 0;
+		}
+
+		if (idev->uhid_created) {
+			memset(&ev, 0, sizeof(ev));
+			ev.type = UHID_DESTROY;
+			if (write(idev->uhid_fd, &ev, sizeof(ev)) < 0)
+				error("Failed to destroy uHID device: %s (%d)",
+							strerror(errno), errno);
+		}
+
+		close(idev->uhid_fd);
+		idev->uhid_fd = -1;
+	}
+
 	input_device_free(idev);
 }
 
@@ -948,28 +1588,30 @@ int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 								GIOChannel *io)
 {
 	struct input_device *idev = find_device(src, dst);
+	GIOCondition cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 
 	DBG("idev %p psm %d", idev, psm);
 
 	if (!idev)
 		return -ENOENT;
 
+	if (idev->uhid_enabled)
+		cond |= G_IO_IN;
+
 	switch (psm) {
 	case L2CAP_PSM_HIDP_CTRL:
 		if (idev->ctrl_io)
 			return -EALREADY;
 		idev->ctrl_io = g_io_channel_ref(io);
-		idev->ctrl_watch = g_io_add_watch(idev->ctrl_io,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					ctrl_watch_cb, idev);
+		idev->ctrl_watch = g_io_add_watch(idev->ctrl_io, cond,
+							ctrl_watch_cb, idev);
 		break;
 	case L2CAP_PSM_HIDP_INTR:
 		if (idev->intr_io)
 			return -EALREADY;
 		idev->intr_io = g_io_channel_ref(io);
-		idev->intr_watch = g_io_add_watch(idev->intr_io,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					intr_watch_cb, idev);
+		idev->intr_watch = g_io_add_watch(idev->intr_io, cond,
+							intr_watch_cb, idev);
 		break;
 	}
 
diff --git a/profiles/input/device.h b/profiles/input/device.h
index da2149c..51a9aee 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -28,6 +28,7 @@ struct input_device;
 struct input_conn;
 
 void input_set_idle_timeout(int timeout);
+void input_enable_userspace_hid(bool state);
 
 int input_device_register(struct btd_service *service);
 void input_device_unregister(struct btd_service *service);
diff --git a/profiles/input/hidp_defs.h b/profiles/input/hidp_defs.h
new file mode 100644
index 0000000..5dc479a
--- /dev/null
+++ b/profiles/input/hidp_defs.h
@@ -0,0 +1,79 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2003-2014  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2014       Google Inc.
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
+#ifndef __HIDP_DEFS_H
+#define __HIDP_DEFS_H
+
+/* HIDP header masks */
+#define HIDP_HEADER_TRANS_MASK			0xf0
+#define HIDP_HEADER_PARAM_MASK			0x0f
+
+/* HIDP transaction types */
+#define HIDP_TRANS_HANDSHAKE			0x00
+#define HIDP_TRANS_HID_CONTROL			0x10
+#define HIDP_TRANS_GET_REPORT			0x40
+#define HIDP_TRANS_SET_REPORT			0x50
+#define HIDP_TRANS_GET_PROTOCOL			0x60
+#define HIDP_TRANS_SET_PROTOCOL			0x70
+#define HIDP_TRANS_GET_IDLE			0x80
+#define HIDP_TRANS_SET_IDLE			0x90
+#define HIDP_TRANS_DATA				0xa0
+#define HIDP_TRANS_DATC				0xb0
+
+/* HIDP handshake results */
+#define HIDP_HSHK_SUCCESSFUL			0x00
+#define HIDP_HSHK_NOT_READY			0x01
+#define HIDP_HSHK_ERR_INVALID_REPORT_ID		0x02
+#define HIDP_HSHK_ERR_UNSUPPORTED_REQUEST	0x03
+#define HIDP_HSHK_ERR_INVALID_PARAMETER		0x04
+#define HIDP_HSHK_ERR_UNKNOWN			0x0e
+#define HIDP_HSHK_ERR_FATAL			0x0f
+
+/* HIDP control operation parameters */
+#define HIDP_CTRL_NOP				0x00
+#define HIDP_CTRL_HARD_RESET			0x01
+#define HIDP_CTRL_SOFT_RESET			0x02
+#define HIDP_CTRL_SUSPEND			0x03
+#define HIDP_CTRL_EXIT_SUSPEND			0x04
+#define HIDP_CTRL_VIRTUAL_CABLE_UNPLUG		0x05
+
+/* HIDP data transaction headers */
+#define HIDP_DATA_RTYPE_MASK			0x03
+#define HIDP_DATA_RSRVD_MASK			0x0c
+#define HIDP_DATA_RTYPE_OTHER			0x00
+#define HIDP_DATA_RTYPE_INPUT			0x01
+#define HIDP_DATA_RTYPE_OUPUT			0x02
+#define HIDP_DATA_RTYPE_FEATURE			0x03
+
+/* HIDP protocol header parameters */
+#define HIDP_PROTO_BOOT				0x00
+#define HIDP_PROTO_REPORT			0x01
+
+#define HIDP_VIRTUAL_CABLE_UNPLUG		0
+#define HIDP_BOOT_PROTOCOL_MODE			1
+#define HIDP_BLUETOOTH_VENDOR_ID		9
+#define HIDP_WAITING_FOR_RETURN			10
+#define HIDP_WAITING_FOR_SEND_ACK		11
+
+#endif /* __HIDP_DEFS_H */
diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index abfb64f..3e1d65a 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -7,3 +7,7 @@
 # Set idle timeout (in minutes) before the connection will
 # be disconnect (defaults to 0 for no timeout)
 #IdleTimeout=30
+
+# Enable HID protocol handling in userspace input profile
+# Defaults to false (HIDP handled in HIDP kernel module)
+#UserspaceHID=true
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 23e739a..9712d2c 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -97,6 +97,7 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
+		gboolean uhid_enabled;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
 							"IdleTimeout", &err);
@@ -105,6 +106,15 @@ static int input_init(void)
 			input_set_idle_timeout(idle_timeout * 60);
 		} else
 			g_clear_error(&err);
+
+		uhid_enabled = g_key_file_get_boolean(config, "General",
+							"UserspaceHID", &err);
+		if (!err) {
+			DBG("input.conf: UserspaceHID=%s", uhid_enabled ?
+							"true" : "false");
+			input_enable_userspace_hid(uhid_enabled);
+		} else
+			g_clear_error(&err);
 	}
 
 	btd_profile_register(&input_profile);
-- 
1.9.1.423.g4596e3a

