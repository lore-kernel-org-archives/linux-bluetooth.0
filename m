Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] uHIDP: HIDP in userspace
Message-Id: <20140313030007.557A6100A6E@puck.mtv.corp.google.com>
Date: Wed, 12 Mar 2014 20:00:07 -0700 (PDT)
List-ID: <linux-bluetooth.vger.kernel.org>

Enable HID protocol handling in userspace when uHIDP=true in input.conf.
---
 Makefile.plugins           |   3 +-
 profiles/input/device.c    | 804 +++++++++++++++++++++++++++++++++++++++++----
 profiles/input/device.h    |   1 +
 profiles/input/hidp_defs.h |  77 +++++
 profiles/input/input.conf  |   4 +
 profiles/input/manager.c   |  22 +-
 6 files changed, 837 insertions(+), 74 deletions(-)
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
index 5235dfd..8b9ce0a 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -53,9 +53,13 @@
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
@@ -81,16 +85,30 @@ struct input_device {
 	enum reconnect_mode_t	reconnect_mode;
 	guint			reconnect_timer;
 	uint32_t		reconnect_attempt;
+	gboolean		uhidp_enabled;
+	int			uhid_fd;
+	guint			uhid_watch;
+	gboolean		uhid_created;
+	unsigned char		report_req_pending;
+	guint			report_req_timer;
+	uint32_t		report_rsp_id;
 };
 
 static int idle_timeout = 0;
+static gboolean uhidp_enabled = FALSE;
 
 void input_set_idle_timeout(int timeout)
 {
 	idle_timeout = timeout;
 }
 
+void input_enable_uhidp(gboolean state)
+{
+	uhidp_enabled = state;
+}
+
 static void input_device_enter_reconnect_mode(struct input_device *idev);
+static int connection_disconnect(struct input_device *idev, uint32_t flags);
 
 static void input_device_free(struct input_device *idev)
 {
@@ -124,14 +142,201 @@ static void input_device_free(struct input_device *idev)
 	if (idev->reconnect_timer > 0)
 		g_source_remove(idev->reconnect_timer);
 
+	if (idev->report_req_timer > 0)
+		g_source_remove(idev->report_req_timer);
+
 	g_free(idev);
 }
 
+static gboolean hidp_send_message(GIOChannel *chan, const unsigned char hdr,
+				const unsigned char *data, unsigned int size)
+{
+	int fd;
+	ssize_t len;
+	unsigned char *msgptr;
+	unsigned char msg[size + 1];
+
+	if (data == NULL)
+		size = 0;
+
+	msg[0] = hdr;
+	if (size > 0)
+		memcpy(&msg[1], data, size);
+
+	msgptr = msg;
+	++size;
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	while (size > 0) {
+		len = write(fd, msgptr, size);
+
+		if (len < 0) {
+			error("BT socket write failed: %s (%d)",
+							strerror(errno), errno);
+			return FALSE;
+		}
+
+		if (len == 0) {
+			error("BT socket write failed: wrote 0 bytes");
+			return FALSE;
+		}
+
+		msgptr += len;
+		size -= len;
+	}
+
+	return TRUE;
+}
+
+static inline gboolean hidp_send_ctrl_message(struct input_device *idev,
+	const unsigned char hdr, const unsigned char *data, unsigned int size)
+{
+	return hidp_send_message(idev->ctrl_io, hdr, data, size);
+}
+
+static inline gboolean hidp_send_intr_message(struct input_device *idev,
+	const unsigned char hdr, const unsigned char *data, unsigned int size)
+{
+	return hidp_send_message(idev->intr_io, hdr, data, size);
+}
+
+static gboolean uhid_send_feature_answer(struct input_device *idev,
+				const unsigned char *data, unsigned int size,
+				const unsigned int id, const unsigned int err)
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
+		DBG("HID report (%u bytes) dropped", size);
+		return FALSE;
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
+
+	if (len < 0) {
+		error("uHID dev write failed: %s (%d)", strerror(errno), errno);
+		return FALSE;
+	}
+
+	/* uHID kernel driver does not handle partial writes */
+	if (len < sizeof(ev)) {
+		error("uHID dev write failed: partial write (%zd of %lu bytes)",
+							len, sizeof(ev));
+		return FALSE;
+	}
+
+	DBG("HID report (%u bytes) written to uHID fd %d", size, idev->uhid_fd);
+
+	return TRUE;
+}
+
+static gboolean uhid_send_input_report(struct input_device *idev,
+				const unsigned char *data, unsigned int size)
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
+		DBG("HID report (%u bytes) dropped", size);
+		return FALSE;
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
+
+	if (len < 0) {
+		error("uHID dev write failed: %s (%d)", strerror(errno), errno);
+		return FALSE;
+	}
+
+	/* uHID kernel driver does not handle partial writes */
+	if (len < sizeof(ev)) {
+		error("uHID dev write failed: partial write (%zd of %lu bytes)",
+							len, sizeof(ev));
+		return FALSE;
+	}
+
+	DBG("HID report (%u bytes) written to uHID fd %d", size, idev->uhid_fd);
+
+	return TRUE;
+}
+
+static gboolean hidp_recv_intr_data(GIOChannel *chan,
+						struct input_device *idev)
+{
+	int fd;
+	ssize_t len;
+	unsigned char hdr;
+	unsigned char data[UHID_DATA_MAX + 1];
+
+	fd = g_io_channel_unix_get_fd(chan);
+	len = read(fd, data, sizeof(data));
+
+	if (len < 0) {
+		DBG("BT socket read failed: %s (%d)", strerror(errno), errno);
+		return FALSE;
+	}
+
+	if (len == 0) {
+		DBG("BT socket read returned 0 bytes");
+		return TRUE;
+	}
+
+	hdr = data[0];
+	if (hdr != (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
+		DBG("unsupported HIDP protocol header 0x%02x", hdr);
+		return TRUE;
+	}
+
+	if (len < 2) {
+		DBG("received empty HID report");
+		return TRUE;
+	}
+
+	uhid_send_input_report(idev, data + 1, len - 1);
+
+	return TRUE;
+}
+
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct input_device *idev = data;
 	char address[18];
 
+	if ((cond & G_IO_IN) && hidp_recv_intr_data(chan, idev) &&
+							(cond == G_IO_IN)) {
+		return TRUE;
+	}
+
 	ba2str(&idev->dst, address);
 
 	DBG("Device %s disconnected", address);
@@ -164,11 +369,174 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	return FALSE;
 }
 
+static void hidp_recv_ctrl_handshake(struct input_device *idev,
+							unsigned char param)
+{
+	gboolean pending_req_complete = FALSE;
+	unsigned char pending_req_type;
+
+	DBG("");
+
+	pending_req_type = idev->report_req_pending & HIDP_HEADER_TRANS_MASK;
+
+	switch (param) {
+	case HIDP_HSHK_SUCCESSFUL:
+		if (pending_req_type == HIDP_TRANS_SET_REPORT) {
+			DBG("SET_REPORT successful");
+			pending_req_complete = TRUE;
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
+			pending_req_complete = TRUE;
+		} else if (pending_req_type == HIDP_TRANS_SET_REPORT) {
+			DBG("SET_REPORT failed (%u)", param);
+			pending_req_complete = TRUE;
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
+static void hidp_recv_ctrl_hid_control(struct input_device *idev,
+							unsigned char param)
+{
+	DBG("");
+
+	if (param == HIDP_CTRL_VIRTUAL_CABLE_UNPLUG)
+		connection_disconnect(idev, 0);
+}
+
+static void hidp_recv_ctrl_data(struct input_device *idev, unsigned char param,
+					unsigned char *data, unsigned int len)
+{
+	unsigned char pending_req_type;
+	unsigned char pending_req_param;
+
+	DBG("");
+
+	pending_req_type = idev->report_req_pending & HIDP_HEADER_TRANS_MASK;
+	pending_req_param = idev->report_req_pending & HIDP_HEADER_PARAM_MASK;
+
+	if (pending_req_type != HIDP_TRANS_GET_REPORT) {
+		DBG("Spurious DATA on control channel");
+		return;
+	}
+
+	if (pending_req_param != param) {
+		DBG("Received DATA RTYPE doesn't match pending request RTYPE");
+		return;
+	}
+
+	switch (param) {
+	case HIDP_DATA_RTYPE_FEATURE:
+	case HIDP_DATA_RTYPE_INPUT:
+	case HIDP_DATA_RTYPE_OUPUT:
+		uhid_send_feature_answer(idev, data + 1, len - 1,
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
+static gboolean hidp_recv_ctrl_message(GIOChannel *chan,
+						struct input_device *idev)
+{
+	int fd;
+	ssize_t len;
+	unsigned char hdr, type, param;
+	unsigned char data[UHID_DATA_MAX + 1];
+
+	fd = g_io_channel_unix_get_fd(chan);
+	len = read(fd, data, sizeof(data));
+
+	if (len < 0) {
+		DBG("BT socket read failed: %s (%d)", strerror(errno), errno);
+		return FALSE;
+	}
+
+	if (len == 0) {
+		DBG("BT socket read returned 0 bytes");
+		return TRUE;
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
+	return TRUE;
+}
+
 static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct input_device *idev = data;
 	char address[18];
 
+	if ((cond & G_IO_IN) && hidp_recv_ctrl_message(chan, idev) &&
+							(cond == G_IO_IN)) {
+		return TRUE;
+	}
+
 	ba2str(&idev->dst, address);
 
 	DBG("Device %s disconnected", address);
@@ -193,6 +561,202 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	return FALSE;
 }
 
+#define REPORT_REQ_TIMEOUT  3
+
+static gboolean hidp_report_req_timeout(gpointer data)
+{
+	struct input_device *idev = data;
+	unsigned char pending_req_type;
+	char *req_type_str;
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
+	unsigned char hdr;
+	gboolean sent;
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
+	unsigned char hdr;
+	gboolean sent;
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
+	len = read(fd, &ev, sizeof(ev));
+
+	if (len < 0) {
+		error("uHID dev read failed: %s (%d)", strerror(errno), errno);
+		goto failed;
+	}
+
+	if (len < sizeof(ev.type)) {
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
@@ -333,6 +897,101 @@ static int ioctl_connadd(struct hidp_connadd_req *req)
 	return err;
 }
 
+static int ioctl_is_connected(struct input_device *idev)
+{
+	struct hidp_conninfo ci;
+	int ctl;
+
+	/* Standard HID */
+	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
+	if (ctl < 0) {
+		error("Can't open HIDP control socket");
+		return 0;
+	}
+
+	memset(&ci, 0, sizeof(ci));
+	bacpy(&ci.bdaddr, &idev->dst);
+	if (ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) {
+		error("Can't get HIDP connection info");
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
+}
+
+static int ioctl_disconnect(struct input_device *idev, uint32_t flags)
+{
+	struct hidp_conndel_req req;
+	struct hidp_conninfo ci;
+	int ctl, err = 0;
+
+	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
+	if (ctl < 0) {
+		error("Can't open HIDP control socket");
+		return -errno;
+	}
+
+	memset(&ci, 0, sizeof(ci));
+	bacpy(&ci.bdaddr, &idev->dst);
+	if ((ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) ||
+						(ci.state != BT_CONNECTED)) {
+		close(ctl);
+		return -ENOTCONN;
+	}
+
+	memset(&req, 0, sizeof(req));
+	bacpy(&req.bdaddr, &idev->dst);
+	req.flags = flags;
+	if (ioctl(ctl, HIDPCONNDEL, &req) < 0) {
+		err = -errno;
+		error("Can't delete the HID device: %s (%d)",
+							strerror(-err), -err);
+	}
+
+	close(ctl);
+
+	return err;
+}
+
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
+		} else {
+			idev->uhid_created = TRUE;
+		}
+	}
+
+	return err;
+}
+
 static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 								gpointer data)
 {
@@ -341,7 +1000,12 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 
 	DBG("");
 
-	err = ioctl_connadd(idev->req);
+	if (idev->uhidp_enabled) {
+		err = uhid_connadd(idev, idev->req);
+	} else {
+		err = ioctl_connadd(idev->req);
+	}
+
 	if (err < 0) {
 		error("ioctl_connadd(): %s (%d)", strerror(-err), -err);
 
@@ -439,7 +1103,11 @@ static int hidp_add_connection(struct input_device *idev)
 		return 0;
 	}
 
-	err = ioctl_connadd(req);
+	if (idev->uhidp_enabled) {
+		err = uhid_connadd(idev, req);
+	} else {
+		err = ioctl_connadd(req);
+	}
 
 cleanup:
 	g_free(req->rd_data);
@@ -450,35 +1118,15 @@ cleanup:
 
 static int is_connected(struct input_device *idev)
 {
-	struct hidp_conninfo ci;
-	int ctl;
-
-	/* Standard HID */
-	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
-	if (ctl < 0)
-		return 0;
-
-	memset(&ci, 0, sizeof(ci));
-	bacpy(&ci.bdaddr, &idev->dst);
-	if (ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) {
-		close(ctl);
-		return 0;
+	if (idev->uhidp_enabled) {
+		return (idev->intr_io != NULL && idev->ctrl_io != NULL);
+	} else {
+		return ioctl_is_connected(idev);
 	}
-
-	close(ctl);
-
-	if (ci.state != BT_CONNECTED)
-		return 0;
-	else
-		return 1;
 }
 
 static int connection_disconnect(struct input_device *idev, uint32_t flags)
 {
-	struct hidp_conndel_req req;
-	struct hidp_conninfo ci;
-	int ctl, err = 0;
-
 	if (!is_connected(idev))
 		return -ENOTCONN;
 
@@ -488,34 +1136,10 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
 	if (idev->ctrl_io)
 		g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
 
-	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
-	if (ctl < 0) {
-		error("Can't open HIDP control socket");
-		return -errno;
-	}
-
-	memset(&ci, 0, sizeof(ci));
-	bacpy(&ci.bdaddr, &idev->dst);
-	if ((ioctl(ctl, HIDPGETCONNINFO, &ci) < 0) ||
-				(ci.state != BT_CONNECTED)) {
-		err = -ENOTCONN;
-		goto fail;
-	}
-
-	memset(&req, 0, sizeof(req));
-	bacpy(&req.bdaddr, &idev->dst);
-	req.flags = flags;
-	if (ioctl(ctl, HIDPCONNDEL, &req) < 0) {
-		err = -errno;
-		error("Can't delete the HID device: %s(%d)",
-				strerror(-err), -err);
-		goto fail;
-	}
-
-fail:
-	close(ctl);
-
-	return err;
+	if (idev->uhidp_enabled)
+		return 0;
+	else
+		return ioctl_disconnect(idev, flags);
 }
 
 static void disconnect_cb(struct btd_device *device, gboolean removal,
@@ -554,6 +1178,7 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 							gpointer user_data)
 {
 	struct input_device *idev = user_data;
+	GIOCondition cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	int err;
 
 	if (conn_err) {
@@ -565,9 +1190,11 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 	if (err < 0)
 		goto failed;
 
-	idev->intr_watch = g_io_add_watch(idev->intr_io,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					intr_watch_cb, idev);
+	if (idev->uhidp_enabled)
+		cond |= G_IO_IN;
+
+	idev->intr_watch = g_io_add_watch(idev->intr_io, cond, intr_watch_cb,
+									idev);
 
 	return;
 
@@ -593,6 +1220,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 							gpointer user_data)
 {
 	struct input_device *idev = user_data;
+	GIOCondition cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	GIOChannel *io;
 	GError *err = NULL;
 
@@ -617,9 +1245,11 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 
 	idev->intr_io = io;
 
-	idev->ctrl_watch = g_io_add_watch(idev->ctrl_io,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					ctrl_watch_cb, idev);
+	if (idev->uhidp_enabled)
+		cond |= G_IO_IN;
+
+	idev->ctrl_watch = g_io_add_watch(idev->ctrl_io, cond, ctrl_watch_cb,
+									idev);
 
 	return;
 
@@ -818,6 +1448,7 @@ static struct input_device *input_device_new(struct btd_service *service)
 	idev->path = g_strdup(path);
 	idev->handle = rec->handle;
 	idev->disable_sdp = is_device_sdp_disable(rec);
+	idev->uhidp_enabled = uhidp_enabled;
 
 	/* Initialize device properties */
 	extract_hid_props(idev, rec);
@@ -847,6 +1478,8 @@ int input_device_register(struct btd_service *service)
 	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
 	struct input_device *idev;
+	int err;
+	GIOChannel *io;
 
 	DBG("%s", path);
 
@@ -854,6 +1487,24 @@ int input_device_register(struct btd_service *service)
 	if (!idev)
 		return -EINVAL;
 
+	if (idev->uhidp_enabled) {
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
@@ -891,12 +1542,31 @@ void input_device_unregister(struct btd_service *service)
 	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
 	struct input_device *idev = btd_service_get_user_data(service);
+	struct uhid_event ev;
 
 	DBG("%s", path);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 						idev->path, INPUT_INTERFACE);
 
+	if (idev->uhidp_enabled) {
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
 
@@ -937,28 +1607,30 @@ int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 								GIOChannel *io)
 {
 	struct input_device *idev = find_device(src, dst);
+	GIOCondition cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 
 	DBG("idev %p psm %d", idev, psm);
 
 	if (!idev)
 		return -ENOENT;
 
+	if (idev->uhidp_enabled)
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
index da2149c..6eaa3d9 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -28,6 +28,7 @@ struct input_device;
 struct input_conn;
 
 void input_set_idle_timeout(int timeout);
+void input_enable_uhidp(gboolean state);
 
 int input_device_register(struct btd_service *service);
 void input_device_unregister(struct btd_service *service);
diff --git a/profiles/input/hidp_defs.h b/profiles/input/hidp_defs.h
new file mode 100644
index 0000000..74110b5
--- /dev/null
+++ b/profiles/input/hidp_defs.h
@@ -0,0 +1,77 @@
+/*
+ * HIDP implementation for Linux Bluetooth stack (BlueZ).
+ * Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation;
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+ * IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+ * CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ * ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+ * COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+ * SOFTWARE IS DISCLAIMED.
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
index abfb64f..dc33e8f 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -7,3 +7,7 @@
 # Set idle timeout (in minutes) before the connection will
 # be disconnect (defaults to 0 for no timeout)
 #IdleTimeout=30
+
+# Enable HID protocol handling in userspace input profile
+# Defaults to false (HIDP handled in HIDP kernel module)
+#uHIDP=true
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 6ef83f4..c334f4f 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -97,15 +97,23 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
+		gboolean uhidp;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
-						"IdleTimeout", &err);
-		if (err) {
-			DBG("input.conf: %s", err->message);
-			g_error_free(err);
-		}
-
-		input_set_idle_timeout(idle_timeout * 60);
+							"IdleTimeout", &err);
+		if (!err) {
+			DBG("input.conf: IdleTimeout=%d", idle_timeout);
+			input_set_idle_timeout(idle_timeout * 60);
+		} else
+			g_clear_error(&err);
+
+		uhidp = g_key_file_get_boolean(config, "General", "uHIDP",
+									&err);
+		if (!err) {
+			DBG("input.conf: uHIDP=%s", uhidp ? "true" : "false");
+			input_enable_uhidp(uhidp);
+		} else
+			g_clear_error(&err);
 	}
 
 	btd_profile_register(&input_profile);
-- 
1.9.0.279.gdc9e3eb
