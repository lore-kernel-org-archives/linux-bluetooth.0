Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] AVRCP: split AVCTP specific code from control.c
Date: Mon, 12 Sep 2011 14:29:56 +0300
Message-Id: <1315826997-13818-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
References: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code is moved to avctp.c to simplify control.c
---
 Makefile.am     |    1 +
 audio/avctp.c   | 1028 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/avctp.h   |   95 +++++
 audio/control.c |  875 +++++++----------------------------------------
 audio/control.h |   14 -
 audio/device.c  |    1 +
 6 files changed, 1242 insertions(+), 772 deletions(-)
 create mode 100644 audio/avctp.c
 create mode 100644 audio/avctp.h

diff --git a/Makefile.am b/Makefile.am
index f4113b1..ef546d4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -143,6 +143,7 @@ builtin_sources += audio/main.c \
 			audio/gateway.h audio/gateway.c \
 			audio/headset.h audio/headset.c \
 			audio/control.h audio/control.c \
+			audio/avctp.h audio/avctp.c \
 			audio/device.h audio/device.c \
 			audio/source.h audio/source.c \
 			audio/sink.h audio/sink.c \
diff --git a/audio/avctp.c b/audio/avctp.c
new file mode 100644
index 0000000..9608d6f
--- /dev/null
+++ b/audio/avctp.c
@@ -0,0 +1,1028 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2011  Texas Instruments, Inc.
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
+#include <stdint.h>
+#include <errno.h>
+#include <unistd.h>
+#include <assert.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <netinet/in.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+
+#include <glib.h>
+
+#include "adapter.h"
+#include "../src/device.h"
+
+#include "log.h"
+#include "error.h"
+#include "uinput.h"
+#include "btio.h"
+#include "manager.h"
+#include "device.h"
+#include "avctp.h"
+
+#define QUIRK_NO_RELEASE 1 << 0
+
+/* Message types */
+#define AVCTP_COMMAND		0
+#define AVCTP_RESPONSE		1
+
+/* Packet types */
+#define AVCTP_PACKET_SINGLE	0
+#define AVCTP_PACKET_START	1
+#define AVCTP_PACKET_CONTINUE	2
+#define AVCTP_PACKET_END	3
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+
+struct avctp_header {
+	uint8_t ipid:1;
+	uint8_t cr:1;
+	uint8_t packet_type:2;
+	uint8_t transaction:4;
+	uint16_t pid;
+} __attribute__ ((packed));
+#define AVCTP_HEADER_LENGTH 3
+
+struct avc_header {
+	uint8_t code:4;
+	uint8_t _hdr0:4;
+	uint8_t subunit_id:3;
+	uint8_t subunit_type:5;
+	uint8_t opcode;
+} __attribute__ ((packed));
+#define AVC_HEADER_LENGTH 3
+
+#elif __BYTE_ORDER == __BIG_ENDIAN
+
+struct avctp_header {
+	uint8_t transaction:4;
+	uint8_t packet_type:2;
+	uint8_t cr:1;
+	uint8_t ipid:1;
+	uint16_t pid;
+} __attribute__ ((packed));
+#define AVCTP_HEADER_LENGTH 3
+
+struct avc_header {
+	uint8_t _hdr0:4;
+	uint8_t code:4;
+	uint8_t subunit_type:5;
+	uint8_t subunit_id:3;
+	uint8_t opcode;
+} __attribute__ ((packed));
+#define AVC_HEADER_LENGTH 3
+
+#else
+#error "Unknown byte order"
+#endif
+
+struct avctp_state_callback {
+	avctp_state_cb cb;
+	void *user_data;
+	unsigned int id;
+};
+
+struct avctp_server {
+	bdaddr_t src;
+	GIOChannel *io;
+	GSList *sessions;
+};
+
+struct avctp {
+	struct avctp_server *server;
+	bdaddr_t dst;
+
+	avctp_state_t state;
+
+	int uinput;
+
+	GIOChannel *io;
+	guint io_id;
+
+	uint16_t mtu;
+
+	uint8_t key_quirks[256];
+};
+
+struct avctp_pdu_handler {
+	uint8_t opcode;
+	avctp_pdu_cb cb;
+	void *user_data;
+	unsigned int id;
+};
+
+static struct {
+	const char *name;
+	uint8_t avc;
+	uint16_t uinput;
+} key_map[] = {
+	{ "PLAY",		PLAY_OP,		KEY_PLAYCD },
+	{ "STOP",		STAVC_OP_OP,		KEY_STOPCD },
+	{ "PAUSE",		PAUSE_OP,		KEY_PAUSECD },
+	{ "FORWARD",		FORWARD_OP,		KEY_NEXTSONG },
+	{ "BACKWARD",		BACKWARD_OP,		KEY_PREVIOUSSONG },
+	{ "REWIND",		REWIND_OP,		KEY_REWIND },
+	{ "FAST FORWARD",	FAST_FORWARD_OP,	KEY_FASTFORWARD },
+	{ NULL }
+};
+
+static GSList *callbacks = NULL;
+static GSList *servers = NULL;
+static GSList *handlers = NULL;
+
+static void auth_cb(DBusError *derr, void *user_data);
+
+static int send_event(int fd, uint16_t type, uint16_t code, int32_t value)
+{
+	struct uinput_event event;
+
+	memset(&event, 0, sizeof(event));
+	event.type	= type;
+	event.code	= code;
+	event.value	= value;
+
+	return write(fd, &event, sizeof(event));
+}
+
+static void send_key(int fd, uint16_t key, int pressed)
+{
+	if (fd < 0)
+		return;
+
+	send_event(fd, EV_KEY, key, pressed);
+	send_event(fd, EV_SYN, SYN_REPORT, 0);
+}
+
+static size_t handle_panel_passthrough(struct avctp *session,
+					uint8_t transaction, uint8_t *code,
+					uint8_t *subunit, uint8_t *operands,
+					size_t operand_count, void *user_data)
+{
+	const char *status;
+	int pressed, i;
+
+	if (*code != AVC_CTYPE_CONTROL || *subunit != AVC_SUBUNIT_PANEL) {
+		*code = AVC_CTYPE_REJECTED;
+		return 0;
+	}
+
+	if (operand_count == 0)
+		goto done;
+
+	if (operands[0] & 0x80) {
+		status = "released";
+		pressed = 0;
+	} else {
+		status = "pressed";
+		pressed = 1;
+	}
+
+	for (i = 0; key_map[i].name != NULL; i++) {
+		uint8_t key_quirks;
+
+		if ((operands[0] & 0x7F) != key_map[i].avc)
+			continue;
+
+		DBG("AVRCP: %s %s", key_map[i].name, status);
+
+		key_quirks = session->key_quirks[key_map[i].avc];
+
+		if (key_quirks & QUIRK_NO_RELEASE) {
+			if (!pressed) {
+				DBG("AVRCP: Ignoring release");
+				break;
+			}
+
+			DBG("AVRCP: treating key press as press + release");
+			send_key(session->uinput, key_map[i].uinput, 1);
+			send_key(session->uinput, key_map[i].uinput, 0);
+			break;
+		}
+
+		send_key(session->uinput, key_map[i].uinput, pressed);
+		break;
+	}
+
+	if (key_map[i].name == NULL)
+		DBG("AVRCP: unknown button 0x%02X %s",
+						operands[0] & 0x7F, status);
+
+done:
+	*code = AVC_CTYPE_ACCEPTED;
+	return operand_count;
+}
+
+static size_t handle_unit_info(struct avctp *session,
+					uint8_t transaction, uint8_t *code,
+					uint8_t *subunit, uint8_t *operands,
+					size_t operand_count, void *user_data)
+{
+	if (*code != AVC_CTYPE_STATUS) {
+		*code = AVC_CTYPE_REJECTED;
+		return 0;
+	}
+
+	*code = AVC_CTYPE_STABLE;
+
+	/* The first operand should be 0x07 for the UNITINFO response.
+	 * Neither AVRCP (section 22.1, page 117) nor AVC Digital
+	 * Interface Command Set (section 9.2.1, page 45) specs
+	 * explain this value but both use it */
+	if (operand_count >= 1)
+		operands[0] = 0x07;
+	if (operand_count >= 2)
+		operands[1] = AVC_SUBUNIT_PANEL << 3;
+
+	DBG("reply to AVC_OP_UNITINFO");
+
+	return 0;
+}
+
+static size_t handle_subunit_info(struct avctp *session,
+					uint8_t transaction, uint8_t *code,
+					uint8_t *subunit, uint8_t *operands,
+					size_t operand_count, void *user_data)
+{
+	if (*code != AVC_CTYPE_STATUS) {
+		*code = AVC_CTYPE_REJECTED;
+		return 0;
+	}
+
+	*code = AVC_CTYPE_STABLE;
+
+	/* The first operand should be 0x07 for the UNITINFO response.
+	 * Neither AVRCP (section 22.1, page 117) nor AVC Digital
+	 * Interface Command Set (section 9.2.1, page 45) specs
+	 * explain this value but both use it */
+	if (operand_count >= 2)
+		operands[1] = AVC_SUBUNIT_PANEL << 3;
+
+	DBG("reply to AVC_OP_SUBUNITINFO");
+
+	return 0;
+}
+
+static struct avctp_pdu_handler *find_handler(GSList *list, uint8_t opcode)
+{
+	for (; list; list = list->next) {
+		struct avctp_pdu_handler *handler = list->data;
+
+		if (handler->opcode == opcode)
+			return handler;
+	}
+
+	return NULL;
+}
+
+static void avctp_disconnected(struct avctp *session)
+{
+	struct avctp_server *server = session->server;
+
+	if (!session)
+		return;
+
+	if (session->io) {
+		g_io_channel_shutdown(session->io, TRUE, NULL);
+		g_io_channel_unref(session->io);
+		session->io = NULL;
+	}
+
+	if (session->io_id) {
+		g_source_remove(session->io_id);
+		session->io_id = 0;
+
+		if (session->state == AVCTP_STATE_CONNECTING) {
+			struct audio_device *dev;
+
+			dev = manager_get_device(&session->server->src,
+							&session->dst, FALSE);
+			audio_device_cancel_authorization(dev, auth_cb,
+								session);
+		}
+	}
+
+	if (session->uinput >= 0) {
+		char address[18];
+
+		ba2str(&session->dst, address);
+		DBG("AVCTP: closing uinput for %s", address);
+
+		ioctl(session->uinput, UI_DEV_DESTROY);
+		close(session->uinput);
+		session->uinput = -1;
+	}
+
+	server->sessions = g_slist_remove(server->sessions, session);
+	g_free(session);
+}
+
+static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
+{
+	GSList *l;
+	struct audio_device *dev;
+	avctp_state_t old_state = session->state;
+
+	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
+	if (dev == NULL) {
+		error("avdtp_set_state(): no matching audio device");
+		return;
+	}
+
+	session->state = new_state;
+
+	for (l = callbacks; l != NULL; l = l->next) {
+		struct avctp_state_callback *cb = l->data;
+		cb->cb(dev, old_state, new_state, cb->user_data);
+	}
+
+	switch (new_state) {
+	case AVCTP_STATE_DISCONNECTED:
+		DBG("AVCTP Disconnected");
+
+		avctp_disconnected(session);
+
+		if (old_state != AVCTP_STATE_CONNECTED)
+			break;
+
+		if (!audio_device_is_active(dev, NULL))
+			audio_device_set_authorized(dev, FALSE);
+
+		break;
+	case AVCTP_STATE_CONNECTING:
+		DBG("AVCTP Connecting");
+		break;
+	case AVCTP_STATE_CONNECTED:
+		DBG("AVCTP Connected");
+		break;
+	default:
+		error("Invalid AVCTP state %d", new_state);
+		return;
+	}
+}
+
+static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
+				gpointer data)
+{
+	struct avctp *session = data;
+	uint8_t buf[1024], *operands, code, subunit;
+	struct avctp_header *avctp;
+	struct avc_header *avc;
+	int ret, packet_size, operand_count, sock;
+	struct avctp_pdu_handler *handler;
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
+		goto failed;
+
+	sock = g_io_channel_unix_get_fd(session->io);
+
+	ret = read(sock, buf, sizeof(buf));
+	if (ret <= 0)
+		goto failed;
+
+	DBG("Got %d bytes of data for AVCTP session %p", ret, session);
+
+	if ((unsigned int) ret < sizeof(struct avctp_header)) {
+		error("Too small AVCTP packet");
+		goto failed;
+	}
+
+	avctp = (struct avctp_header *) buf;
+
+	DBG("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
+			"PID 0x%04X",
+			avctp->transaction, avctp->packet_type,
+			avctp->cr, avctp->ipid, ntohs(avctp->pid));
+
+	ret -= sizeof(struct avctp_header);
+	if ((unsigned int) ret < sizeof(struct avc_header)) {
+		error("Too small AVRCP packet");
+		goto failed;
+	}
+
+	avc = (struct avc_header *) (buf + sizeof(struct avctp_header));
+
+	ret -= sizeof(struct avc_header);
+
+	operands = buf + sizeof(struct avctp_header) + sizeof(struct avc_header);
+	operand_count = ret;
+
+	DBG("AV/C %s 0x%01X, subunit_type 0x%02X, subunit_id 0x%01X, "
+			"opcode 0x%02X, %d operands",
+			avctp->cr ? "response" : "command",
+			avc->code, avc->subunit_type, avc->subunit_id,
+			avc->opcode, operand_count);
+
+	if (avctp->cr == AVCTP_RESPONSE)
+		return TRUE;
+
+	packet_size = AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH;
+	avctp->cr = AVCTP_RESPONSE;
+
+	if (avctp->packet_type != AVCTP_PACKET_SINGLE) {
+		avc->code = AVC_CTYPE_NOT_IMPLEMENTED;
+		goto done;
+	}
+
+	if (avctp->pid != htons(AV_REMOTE_SVCLASS_ID)) {
+		avctp->ipid = 1;
+		avc->code = AVC_CTYPE_REJECTED;
+		goto done;
+	}
+
+	handler = find_handler(handlers, avc->opcode);
+	if (!handler) {
+		avc->code = AVC_CTYPE_REJECTED;
+		goto done;
+	}
+
+	code = avc->code;
+	subunit = avc->subunit_type;
+
+	packet_size += handler->cb(session, avctp->transaction, &code,
+					&subunit, operands, operand_count,
+					handler->user_data);
+
+	avc->code = code;
+	avc->subunit_type = subunit;
+
+done:
+	ret = write(sock, buf, packet_size);
+	if (ret != packet_size)
+		goto failed;
+
+	return TRUE;
+
+failed:
+	DBG("AVCTP session %p got disconnected", session);
+	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+	return FALSE;
+}
+
+static int uinput_create(char *name)
+{
+	struct uinput_dev dev;
+	int fd, err, i;
+
+	fd = open("/dev/uinput", O_RDWR);
+	if (fd < 0) {
+		fd = open("/dev/input/uinput", O_RDWR);
+		if (fd < 0) {
+			fd = open("/dev/misc/uinput", O_RDWR);
+			if (fd < 0) {
+				err = errno;
+				error("Can't open input device: %s (%d)",
+							strerror(err), err);
+				return -err;
+			}
+		}
+	}
+
+	memset(&dev, 0, sizeof(dev));
+	if (name)
+		strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
+
+	dev.id.bustype = BUS_BLUETOOTH;
+	dev.id.vendor  = 0x0000;
+	dev.id.product = 0x0000;
+	dev.id.version = 0x0000;
+
+	if (write(fd, &dev, sizeof(dev)) < 0) {
+		err = errno;
+		error("Can't write device information: %s (%d)",
+						strerror(err), err);
+		close(fd);
+		errno = err;
+		return -err;
+	}
+
+	ioctl(fd, UI_SET_EVBIT, EV_KEY);
+	ioctl(fd, UI_SET_EVBIT, EV_REL);
+	ioctl(fd, UI_SET_EVBIT, EV_REP);
+	ioctl(fd, UI_SET_EVBIT, EV_SYN);
+
+	for (i = 0; key_map[i].name != NULL; i++)
+		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
+
+	if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
+		err = errno;
+		error("Can't create uinput device: %s (%d)",
+						strerror(err), err);
+		close(fd);
+		errno = err;
+		return -err;
+	}
+
+	return fd;
+}
+
+static void init_uinput(struct avctp *session)
+{
+	struct audio_device *dev;
+	char address[18], name[248 + 1];
+
+	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
+
+	device_get_name(dev->btd_dev, name, sizeof(name));
+	if (g_str_equal(name, "Nokia CK-20W")) {
+		session->key_quirks[FORWARD_OP] |= QUIRK_NO_RELEASE;
+		session->key_quirks[BACKWARD_OP] |= QUIRK_NO_RELEASE;
+		session->key_quirks[PLAY_OP] |= QUIRK_NO_RELEASE;
+		session->key_quirks[PAUSE_OP] |= QUIRK_NO_RELEASE;
+	}
+
+	ba2str(&session->dst, address);
+
+	session->uinput = uinput_create(address);
+	if (session->uinput < 0)
+		error("AVRCP: failed to init uinput for %s", address);
+	else
+		DBG("AVRCP: uinput initialized for %s", address);
+}
+
+static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
+{
+	struct avctp *session = data;
+	char address[18];
+	uint16_t imtu;
+	GError *gerr = NULL;
+
+	if (err) {
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+		error("%s", err->message);
+		return;
+	}
+
+	bt_io_get(chan, BT_IO_L2CAP, &gerr,
+			BT_IO_OPT_DEST, &address,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		return;
+	}
+
+	DBG("AVCTP: connected to %s", address);
+
+	if (!session->io)
+		session->io = g_io_channel_ref(chan);
+
+	init_uinput(session);
+
+	avctp_set_state(session, AVCTP_STATE_CONNECTED);
+	session->mtu = imtu;
+	session->io_id = g_io_add_watch(chan,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) session_cb, session);
+}
+
+static void auth_cb(DBusError *derr, void *user_data)
+{
+	struct avctp *session = user_data;
+	GError *err = NULL;
+
+	if (session->io_id) {
+		g_source_remove(session->io_id);
+		session->io_id = 0;
+	}
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+		return;
+	}
+
+	if (!bt_io_accept(session->io, avctp_connect_cb, session,
+								NULL, &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+	}
+}
+
+static struct avctp_server *find_server(GSList *list, const bdaddr_t *src)
+{
+	for (; list; list = list->next) {
+		struct avctp_server *server = list->data;
+
+		if (bacmp(&server->src, src) == 0)
+			return server;
+	}
+
+	return NULL;
+}
+
+static struct avctp *find_session(GSList *list, const bdaddr_t *dst)
+{
+	for (; list != NULL; list = g_slist_next(list)) {
+		struct avctp *s = list->data;
+
+		if (bacmp(dst, &s->dst))
+			continue;
+
+		return s;
+	}
+
+	return NULL;
+}
+
+static struct avctp *avctp_get_internal(const bdaddr_t *src,
+							const bdaddr_t *dst)
+{
+	struct avctp_server *server;
+	struct avctp *session;
+
+	assert(src != NULL);
+	assert(dst != NULL);
+
+	server = find_server(servers, src);
+	if (server == NULL)
+		return NULL;
+
+	session = find_session(server->sessions, dst);
+	if (session)
+		return session;
+
+	session = g_new0(struct avctp, 1);
+
+	session->server = server;
+	bacpy(&session->dst, dst);
+	session->state = AVCTP_STATE_DISCONNECTED;
+
+	server->sessions = g_slist_append(server->sessions, session);
+
+	return session;
+}
+
+static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
+{
+	struct avctp *session;
+	struct audio_device *dev;
+	char address[18];
+	bdaddr_t src, dst;
+	GError *err = NULL;
+
+	bt_io_get(chan, BT_IO_L2CAP, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
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
+	DBG("AVCTP: incoming connect from %s", address);
+
+	session = avctp_get_internal(&src, &dst);
+	if (!session)
+		goto drop;
+
+	dev = manager_get_device(&src, &dst, FALSE);
+	if (!dev) {
+		dev = manager_get_device(&src, &dst, TRUE);
+		if (!dev) {
+			error("Unable to get audio device object for %s",
+					address);
+			goto drop;
+		}
+		btd_device_add_uuid(dev->btd_dev, AVRCP_REMOTE_UUID);
+	}
+
+	if (session->io) {
+		error("Refusing unexpected connect from %s", address);
+		goto drop;
+	}
+
+	avctp_set_state(session, AVCTP_STATE_CONNECTING);
+	session->io = g_io_channel_ref(chan);
+
+	if (audio_device_request_authorization(dev, AVRCP_TARGET_UUID,
+						auth_cb, session) < 0)
+		goto drop;
+
+	session->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							session_cb, session);
+	return;
+
+drop:
+	if (!session || !session->io)
+		g_io_channel_shutdown(chan, TRUE, NULL);
+	if (session)
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+}
+
+static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master)
+{
+	GError *err = NULL;
+	GIOChannel *io;
+
+	io = bt_io_listen(BT_IO_L2CAP, NULL, avctp_confirm_cb, NULL,
+				NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_PSM, AVCTP_PSM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_MASTER, master,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
+	return io;
+}
+
+static unsigned int passthrough_id = 0;
+static unsigned int unit_id = 0;
+static unsigned int subunit_id = 0;
+
+int avctp_register(const bdaddr_t *src, gboolean master)
+{
+	struct avctp_server *server;
+
+	server = g_new0(struct avctp_server, 1);
+	if (!server)
+		return -ENOMEM;
+
+	server->io = avctp_server_socket(src, master);
+	if (!server->io) {
+		g_free(server);
+		return -1;
+	}
+
+	bacpy(&server->src, src);
+
+	servers = g_slist_append(servers, server);
+
+	if (!passthrough_id)
+		passthrough_id = avctp_register_pdu_handler(AVC_OP_PASSTHROUGH,
+					handle_panel_passthrough, NULL);
+
+	if (!unit_id)
+		unit_id = avctp_register_pdu_handler(AVC_OP_UNITINFO, handle_unit_info,
+									NULL);
+
+	if (!subunit_id)
+		subunit_id = avctp_register_pdu_handler(AVC_OP_SUBUNITINFO,
+						handle_subunit_info, NULL);
+
+	return 0;
+}
+
+void avctp_unregister(const bdaddr_t *src)
+{
+	struct avctp_server *server;
+
+	server = find_server(servers, src);
+	if (!server)
+		return;
+
+	while (server->sessions)
+		avctp_disconnected(server->sessions->data);
+
+	servers = g_slist_remove(servers, server);
+
+	g_io_channel_shutdown(server->io, TRUE, NULL);
+	g_io_channel_unref(server->io);
+	g_free(server);
+
+	if (servers)
+		return;
+
+	if (passthrough_id)
+		avctp_unregister_pdu_handler(passthrough_id);
+
+	if (unit_id)
+		avctp_unregister_pdu_handler(unit_id);
+
+	if (subunit_id)
+		avctp_unregister_pdu_handler(unit_id);
+}
+
+int avctp_send_passthrough(struct avctp *session, uint8_t op)
+{
+	unsigned char buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH + 2];
+	struct avctp_header *avctp = (void *) buf;
+	struct avc_header *avc = (void *) &buf[AVCTP_HEADER_LENGTH];
+	uint8_t *operands = &buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH];
+	int sk = g_io_channel_unix_get_fd(session->io);
+	static uint8_t transaction = 0;
+
+	if (session->state != AVCTP_STATE_CONNECTED)
+		return -ENOTCONN;
+
+	memset(buf, 0, sizeof(buf));
+
+	avctp->transaction = transaction++;
+	avctp->packet_type = AVCTP_PACKET_SINGLE;
+	avctp->cr = AVCTP_COMMAND;
+	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
+
+	avc->code = AVC_CTYPE_CONTROL;
+	avc->subunit_type = AVC_SUBUNIT_PANEL;
+	avc->opcode = AVC_OP_PASSTHROUGH;
+
+	operands[0] = op & 0x7f;
+	operands[1] = 0;
+
+	if (write(sk, buf, sizeof(buf)) < 0)
+		return -errno;
+
+	/* Button release */
+	avctp->transaction = transaction++;
+	operands[0] |= 0x80;
+
+	if (write(sk, buf, sizeof(buf)) < 0)
+		return -errno;
+
+	return 0;
+}
+
+int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
+				uint8_t code, uint8_t subunit,
+				uint8_t *operands, size_t operand_count)
+{
+	uint8_t *buf;
+	struct avctp_header *avctp;
+	struct avc_header *avc;
+	uint8_t *pdu;
+	int sk, err;
+	uint16_t size;
+
+	if (session->state != AVCTP_STATE_CONNECTED)
+		return -ENOTCONN;
+
+	sk = g_io_channel_unix_get_fd(session->io);
+	size = AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH + operand_count;
+	buf = g_malloc0(size);
+
+	avctp = (void *) buf;
+	avc = (void *) &buf[AVCTP_HEADER_LENGTH];
+	pdu = (void *) &buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH];
+
+	avctp->transaction = transaction;
+	avctp->packet_type = AVCTP_PACKET_SINGLE;
+	avctp->cr = AVCTP_RESPONSE;
+	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
+
+	avc->code = code;
+	avc->subunit_type = subunit;
+	avc->opcode = AVC_OP_VENDORDEP;
+
+	memcpy(pdu, operands, operand_count);
+
+	err = write(sk, buf, size);
+	if (err < 0) {
+		g_free(buf);
+		return -errno;
+	}
+
+	g_free(buf);
+	return 0;
+}
+
+unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data)
+{
+	struct avctp_state_callback *state_cb;
+	static unsigned int id = 0;
+
+	state_cb = g_new(struct avctp_state_callback, 1);
+	state_cb->cb = cb;
+	state_cb->user_data = user_data;
+	state_cb->id = ++id;
+
+	callbacks = g_slist_append(callbacks, state_cb);
+
+	return state_cb->id;
+}
+
+gboolean avctp_remove_state_cb(unsigned int id)
+{
+	GSList *l;
+
+	for (l = callbacks; l != NULL; l = l->next) {
+		struct avctp_state_callback *cb = l->data;
+		if (cb && cb->id == id) {
+			callbacks = g_slist_remove(callbacks, cb);
+			g_free(cb);
+			return TRUE;
+		}
+	}
+
+	return FALSE;
+}
+
+unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_pdu_cb cb,
+							void *user_data)
+{
+	struct avctp_pdu_handler *handler;
+	static unsigned int id = 0;
+
+	handler = find_handler(handlers, opcode);
+	if (handler)
+		return 0;
+
+	handler = g_new(struct avctp_pdu_handler, 1);
+	handler->opcode = opcode;
+	handler->cb = cb;
+	handler->user_data = user_data;
+	handler->id = ++id;
+
+	handlers = g_slist_append(handlers, handler);
+
+	return handler->id;
+}
+
+gboolean avctp_unregister_pdu_handler(unsigned int id)
+{
+	GSList *l;
+
+	for (l = handlers; l != NULL; l = l->next) {
+		struct avctp_pdu_handler *handler = l->data;
+
+		if (handler->id == id) {
+			handlers = g_slist_remove(handlers, handler);
+			g_free(handler);
+			return TRUE;
+		}
+	}
+
+	return FALSE;
+}
+
+struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
+{
+	struct avctp *session;
+	GError *err = NULL;
+	GIOChannel *io;
+
+	session = avctp_get_internal(src, dst);
+	if (!session)
+		return NULL;
+
+	if (session->state > AVCTP_STATE_DISCONNECTED)
+		return session;
+
+	avctp_set_state(session, AVCTP_STATE_CONNECTING);
+
+	io = bt_io_connect(BT_IO_L2CAP, avctp_connect_cb, session, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &session->server->src,
+				BT_IO_OPT_DEST_BDADDR, &session->dst,
+				BT_IO_OPT_PSM, AVCTP_PSM,
+				BT_IO_OPT_INVALID);
+	if (err) {
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+		error("%s", err->message);
+		g_error_free(err);
+		return NULL;
+	}
+
+	session->io = io;
+
+	return session;
+}
+
+void avctp_disconnect(struct avctp *session)
+{
+	if (session->io)
+		return;
+
+	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+}
diff --git a/audio/avctp.h b/audio/avctp.h
new file mode 100644
index 0000000..157ecc6
--- /dev/null
+++ b/audio/avctp.h
@@ -0,0 +1,95 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#define AVCTP_PSM 23
+
+/* ctype entries */
+#define AVC_CTYPE_CONTROL		0x0
+#define AVC_CTYPE_STATUS		0x1
+#define AVC_CTYPE_NOTIFY		0x3
+#define AVC_CTYPE_NOT_IMPLEMENTED	0x8
+#define AVC_CTYPE_ACCEPTED		0x9
+#define AVC_CTYPE_REJECTED		0xA
+#define AVC_CTYPE_STABLE		0xC
+#define AVC_CTYPE_CHANGED		0xD
+#define AVC_CTYPE_INTERIM		0xF
+
+/* opcodes */
+#define AVC_OP_VENDORDEP		0x00
+#define AVC_OP_UNITINFO			0x30
+#define AVC_OP_SUBUNITINFO		0x31
+#define AVC_OP_PASSTHROUGH		0x7c
+
+/* subunits of interest */
+#define AVC_SUBUNIT_PANEL		0x09
+
+/* operands in passthrough commands */
+#define VOL_UP_OP			0x41
+#define VOL_DOWN_OP			0x42
+#define MUTE_OP				0x43
+#define PLAY_OP				0x44
+#define STAVC_OP_OP			0x45
+#define PAUSE_OP			0x46
+#define RECORD_OP			0x47
+#define REWIND_OP			0x48
+#define FAST_FORWARD_OP			0x49
+#define EJECT_OP			0x4a
+#define FORWARD_OP			0x4b
+#define BACKWARD_OP			0x4c
+
+struct avctp;
+
+typedef enum {
+	AVCTP_STATE_DISCONNECTED = 0,
+	AVCTP_STATE_CONNECTING,
+	AVCTP_STATE_CONNECTED
+} avctp_state_t;
+
+typedef void (*avctp_state_cb) (struct audio_device *dev,
+				avctp_state_t old_state,
+				avctp_state_t new_state,
+				void *user_data);
+
+typedef size_t (*avctp_pdu_cb) (struct avctp *session, uint8_t transaction,
+					uint8_t *code, uint8_t *subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data);
+
+unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data);
+gboolean avctp_remove_state_cb(unsigned int id);
+
+int avctp_register(const bdaddr_t *src, gboolean master);
+void avctp_unregister(const bdaddr_t *src);
+
+struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst);
+void avctp_disconnect(struct avctp *session);
+
+unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_pdu_cb cb,
+							void *user_data);
+gboolean avctp_unregister_pdu_handler(unsigned int id);
+
+int avctp_send_passthrough(struct avctp *session, uint8_t op);
+int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
+				uint8_t code, uint8_t subunit,
+				uint8_t *operands, size_t operand_count);
diff --git a/audio/control.c b/audio/control.c
index 73130e4..dceb004 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -36,7 +36,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <netinet/in.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
@@ -48,64 +47,14 @@
 
 #include "log.h"
 #include "error.h"
-#include "uinput.h"
-#include "adapter.h"
-#include "../src/device.h"
 #include "device.h"
 #include "manager.h"
-#include "avdtp.h"
+#include "avctp.h"
 #include "control.h"
 #include "sdpd.h"
 #include "glib-helper.h"
-#include "btio.h"
 #include "dbus-common.h"
 
-#define AVCTP_PSM 23
-
-/* Message types */
-#define AVCTP_COMMAND		0
-#define AVCTP_RESPONSE		1
-
-/* Packet types */
-#define AVCTP_PACKET_SINGLE	0
-#define AVCTP_PACKET_START	1
-#define AVCTP_PACKET_CONTINUE	2
-#define AVCTP_PACKET_END	3
-
-/* ctype entries */
-#define CTYPE_CONTROL		0x0
-#define CTYPE_STATUS		0x1
-#define CTYPE_NOTIFY		0x3
-#define CTYPE_NOT_IMPLEMENTED	0x8
-#define CTYPE_ACCEPTED		0x9
-#define CTYPE_REJECTED		0xA
-#define CTYPE_STABLE		0xC
-#define CTYPE_CHANGED		0xD
-#define CTYPE_INTERIM		0xF
-
-/* opcodes */
-#define OP_VENDORDEP		0x00
-#define OP_UNITINFO		0x30
-#define OP_SUBUNITINFO		0x31
-#define OP_PASSTHROUGH		0x7c
-
-/* subunits of interest */
-#define SUBUNIT_PANEL		0x09
-
-/* operands in passthrough commands */
-#define VOL_UP_OP		0x41
-#define VOL_DOWN_OP		0x42
-#define MUTE_OP			0x43
-#define PLAY_OP			0x44
-#define STOP_OP			0x45
-#define PAUSE_OP		0x46
-#define RECORD_OP		0x47
-#define REWIND_OP		0x48
-#define FAST_FORWARD_OP		0x49
-#define EJECT_OP		0x4a
-#define FORWARD_OP		0x4b
-#define BACKWARD_OP		0x4c
-
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
 
@@ -137,8 +86,6 @@
 #define CAP_COMPANY_ID		0x02
 #define CAP_EVENTS_SUPPORTED	0x03
 
-#define QUIRK_NO_RELEASE	1 << 0
-
 enum player_setting {
 	PLAYER_SETTING_EQUALIZER =	1,
 	PLAYER_SETTING_REPEAT =		2,
@@ -200,27 +147,10 @@ enum media_info_id {
 static DBusConnection *connection = NULL;
 
 static GSList *servers = NULL;
+static unsigned int avctp_id = 0;
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
-struct avctp_header {
-	uint8_t ipid:1;
-	uint8_t cr:1;
-	uint8_t packet_type:2;
-	uint8_t transaction:4;
-	uint16_t pid;
-} __attribute__ ((packed));
-#define AVCTP_HEADER_LENGTH 3
-
-struct avc_header {
-	uint8_t code:4;
-	uint8_t _hdr0:4;
-	uint8_t subunit_id:3;
-	uint8_t subunit_type:5;
-	uint8_t opcode;
-} __attribute__ ((packed));
-#define AVC_HEADER_LENGTH 3
-
 struct avrcp_header {
 	uint8_t company_id[3];
 	uint8_t pdu_id;
@@ -233,24 +163,6 @@ struct avrcp_header {
 
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
-struct avctp_header {
-	uint8_t transaction:4;
-	uint8_t packet_type:2;
-	uint8_t cr:1;
-	uint8_t ipid:1;
-	uint16_t pid;
-} __attribute__ ((packed));
-#define AVCTP_HEADER_LENGTH 3
-
-struct avc_header {
-	uint8_t _hdr0:4;
-	uint8_t code:4;
-	uint8_t subunit_type:5;
-	uint8_t subunit_id:3;
-	uint8_t opcode;
-} __attribute__ ((packed));
-#define AVC_HEADER_LENGTH 3
-
 struct avrcp_header {
 	uint8_t company_id[3];
 	uint8_t pdu_id;
@@ -265,15 +177,8 @@ struct avrcp_header {
 #error "Unknown byte order"
 #endif
 
-struct avctp_state_callback {
-	avctp_state_cb cb;
-	void *user_data;
-	unsigned int id;
-};
-
-struct avctp_server {
+struct avrcp_server {
 	bdaddr_t src;
-	GIOChannel *io;
 	uint32_t tg_record_id;
 	uint32_t ct_record_id;
 };
@@ -295,53 +200,25 @@ struct media_player {
 
 	struct media_info mi;
 	GTimer *timer;
+	unsigned int handler;
 };
 
 struct control {
 	struct audio_device *dev;
 	struct media_player *mp;
-
-	avctp_state_t state;
-
-	int uinput;
-
-	GIOChannel *io;
-	guint io_id;
-
-	uint16_t mtu;
+	struct avctp *session;
 
 	gboolean target;
 
-	uint8_t key_quirks[256];
-
 	uint16_t registered_events;
 	uint8_t transaction_events[AVRCP_EVENT_TRACK_CHANGED + 1];
 };
 
-static struct {
-	const char *name;
-	uint8_t avrcp;
-	uint16_t uinput;
-} key_map[] = {
-	{ "PLAY",		PLAY_OP,		KEY_PLAYCD },
-	{ "STOP",		STOP_OP,		KEY_STOPCD },
-	{ "PAUSE",		PAUSE_OP,		KEY_PAUSECD },
-	{ "FORWARD",		FORWARD_OP,		KEY_NEXTSONG },
-	{ "BACKWARD",		BACKWARD_OP,		KEY_PREVIOUSSONG },
-	{ "REWIND",		REWIND_OP,		KEY_REWIND },
-	{ "FAST FORWARD",	FAST_FORWARD_OP,	KEY_FASTFORWARD },
-	{ NULL }
-};
-
 /* Company IDs supported by this device */
 static uint32_t company_ids[] = {
 	IEEEID_BTSIG,
 };
 
-static GSList *avctp_callbacks = NULL;
-
-static void auth_cb(DBusError *derr, void *user_data);
-
 static sdp_record_t *avrcp_ct_record(void)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -470,76 +347,6 @@ static sdp_record_t *avrcp_tg_record(void)
 	return record;
 }
 
-static int send_event(int fd, uint16_t type, uint16_t code, int32_t value)
-{
-	struct uinput_event event;
-
-	memset(&event, 0, sizeof(event));
-	event.type	= type;
-	event.code	= code;
-	event.value	= value;
-
-	return write(fd, &event, sizeof(event));
-}
-
-static void send_key(int fd, uint16_t key, int pressed)
-{
-	if (fd < 0)
-		return;
-
-	send_event(fd, EV_KEY, key, pressed);
-	send_event(fd, EV_SYN, SYN_REPORT, 0);
-}
-
-static void handle_panel_passthrough(struct control *control,
-					const unsigned char *operands,
-					int operand_count)
-{
-	const char *status;
-	int pressed, i;
-
-	if (operand_count == 0)
-		return;
-
-	if (operands[0] & 0x80) {
-		status = "released";
-		pressed = 0;
-	} else {
-		status = "pressed";
-		pressed = 1;
-	}
-
-	for (i = 0; key_map[i].name != NULL; i++) {
-		uint8_t key_quirks;
-
-		if ((operands[0] & 0x7F) != key_map[i].avrcp)
-			continue;
-
-		DBG("AVRCP: %s %s", key_map[i].name, status);
-
-		key_quirks = control->key_quirks[key_map[i].avrcp];
-
-		if (key_quirks & QUIRK_NO_RELEASE) {
-			if (!pressed) {
-				DBG("AVRCP: Ignoring release");
-				break;
-			}
-
-			DBG("AVRCP: treating key press as press + release");
-			send_key(control->uinput, key_map[i].uinput, 1);
-			send_key(control->uinput, key_map[i].uinput, 0);
-			break;
-		}
-
-		send_key(control->uinput, key_map[i].uinput, pressed);
-		break;
-	}
-
-	if (key_map[i].name == NULL)
-		DBG("AVRCP: unknown button 0x%02X %s",
-						operands[0] & 0x7F, status);
-}
-
 static unsigned int attr_get_max_val(uint8_t attr)
 {
 	switch (attr) {
@@ -719,18 +526,14 @@ static const char *battery_status_to_str(enum battery_status status)
 	return NULL;
 }
 
-static int avctp_send_event(struct control *control, uint8_t id, void *data)
+static int avrcp_send_event(struct control *control, uint8_t id, void *data)
 {
-	uint8_t buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH +
-					AVRCP_HEADER_LENGTH + 9];
-	struct avctp_header *avctp = (void *) buf;
-	struct avc_header *avc = (void *) &buf[AVCTP_HEADER_LENGTH];
-	struct avrcp_header *pdu = (void *) &buf[AVCTP_HEADER_LENGTH +
-							AVC_HEADER_LENGTH];
-	int sk = g_io_channel_unix_get_fd(control->io);
+	uint8_t buf[AVRCP_HEADER_LENGTH + 9];
+	struct avrcp_header *pdu = (void *) buf;
 	uint16_t size;
+	int err;
 
-	if (control->state != AVCTP_STATE_CONNECTED)
+	if (control->session)
 		return -ENOTCONN;
 
 	if (!(control->registered_events & (1 << id)))
@@ -738,15 +541,6 @@ static int avctp_send_event(struct control *control, uint8_t id, void *data)
 
 	memset(buf, 0, sizeof(buf));
 
-	avctp->transaction = control->transaction_events[id];
-	avctp->packet_type = AVCTP_PACKET_SINGLE;
-	avctp->cr = AVCTP_RESPONSE;
-	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
-
-	avc->code = CTYPE_CHANGED;
-	avc->subunit_type = SUBUNIT_PANEL;
-	avc->opcode = OP_VENDORDEP;
-
 	pdu->company_id[0] = IEEEID_BTSIG >> 16;
 	pdu->company_id[1] = (IEEEID_BTSIG >> 8) & 0xFF;
 	pdu->company_id[2] = IEEEID_BTSIG & 0xFF;
@@ -780,13 +574,12 @@ static int avctp_send_event(struct control *control, uint8_t id, void *data)
 	}
 
 	pdu->params_len = htons(size);
-	size += AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH +
-					AVRCP_HEADER_LENGTH;
-
-	sk = g_io_channel_unix_get_fd(control->io);
 
-	if (write(sk, buf, size) < 0)
-		return -errno;
+	err = avctp_send_vendordep(control->session, control->transaction_events[id],
+					AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
+					buf, size);
+	if (err < 0)
+		return err;
 
 	/* Unregister event as per AVRCP 1.3 spec, section 5.4.2 */
 	control->registered_events ^= 1 << id;
@@ -833,7 +626,7 @@ static void mp_set_playback_status(struct control *control, uint8_t status,
 
 	mp->status = status;
 
-	avctp_send_event(control, AVRCP_EVENT_PLAYBACK_STATUS_CHANGED,
+	avrcp_send_event(control, AVRCP_EVENT_PLAYBACK_STATUS_CHANGED,
 								&status);
 }
 
@@ -983,7 +776,7 @@ static void mp_set_media_attributes(struct control *control,
 			mi->title, mi->artist, mi->album, mi->genre,
 			mi->ntracks, mi->track, mi->track_len);
 
-	avctp_send_event(control, AVRCP_EVENT_TRACK_CHANGED, NULL);
+	avrcp_send_event(control, AVRCP_EVENT_TRACK_CHANGED, NULL);
 }
 
 static uint8_t avrcp_handle_get_capabilities(struct control *control,
@@ -1009,21 +802,21 @@ static uint8_t avrcp_handle_get_capabilities(struct control *control,
 		pdu->params_len = htons(2 + (3 * G_N_ELEMENTS(company_ids)));
 		pdu->params[1] = G_N_ELEMENTS(company_ids);
 
-		return CTYPE_STABLE;
+		return AVC_CTYPE_STABLE;
 	case CAP_EVENTS_SUPPORTED:
 		pdu->params_len = htons(4);
 		pdu->params[1] = 2;
 		pdu->params[2] = AVRCP_EVENT_PLAYBACK_STATUS_CHANGED;
 		pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
 
-		return CTYPE_STABLE;
+		return AVC_CTYPE_STABLE;
 	}
 
 err:
 	pdu->params_len = htons(1);
 	pdu->params[0] = E_INVALID_PARAM;
 
-	return CTYPE_REJECTED;
+	return AVC_CTYPE_REJECTED;
 }
 
 static uint8_t avrcp_handle_list_player_attributes(struct control *control,
@@ -1037,7 +830,7 @@ static uint8_t avrcp_handle_list_player_attributes(struct control *control,
 	if (len != 0) {
 		pdu->params_len = htons(1);
 		pdu->params[0] = E_INVALID_PARAM;
-		return CTYPE_REJECTED;
+		return AVC_CTYPE_REJECTED;
 	}
 
 	if (!mp)
@@ -1057,7 +850,7 @@ done:
 	pdu->params[0] = len;
 	pdu->params_len = htons(len + 1);
 
-	return CTYPE_STABLE;
+	return AVC_CTYPE_STABLE;
 }
 
 static uint8_t avrcp_handle_list_player_values(struct control *control,
@@ -1083,12 +876,12 @@ static uint8_t avrcp_handle_list_player_values(struct control *control,
 	pdu->params[0] = len;
 	pdu->params_len = htons(len + 1);
 
-	return CTYPE_STABLE;
+	return AVC_CTYPE_STABLE;
 
 err:
 	pdu->params_len = htons(1);
 	pdu->params[0] = E_INVALID_PARAM;
-	return CTYPE_REJECTED;
+	return AVC_CTYPE_REJECTED;
 }
 
 static uint8_t avrcp_handle_get_element_attributes(struct control *control,
@@ -1153,11 +946,11 @@ done:
 	pdu->params[0] = len;
 	pdu->params_len = htons(pos);
 
-	return CTYPE_STABLE;
+	return AVC_CTYPE_STABLE;
 err:
 	pdu->params_len = htons(1);
 	pdu->params[0] = E_INVALID_PARAM;
-	return CTYPE_REJECTED;
+	return AVC_CTYPE_REJECTED;
 }
 
 static uint8_t avrcp_handle_get_current_player_value(struct control *control,
@@ -1212,7 +1005,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct control *control,
 		pdu->params[0] = len;
 		pdu->params_len = htons(2 * len + 1);
 
-		return CTYPE_STABLE;
+		return AVC_CTYPE_STABLE;
 	}
 
 	error("No valid attributes in request");
@@ -1221,7 +1014,7 @@ err:
 	pdu->params_len = htons(1);
 	pdu->params[0] = E_INVALID_PARAM;
 
-	return CTYPE_REJECTED;
+	return AVC_CTYPE_REJECTED;
 }
 
 static uint8_t avrcp_handle_set_player_value(struct control *control,
@@ -1268,13 +1061,13 @@ static uint8_t avrcp_handle_set_player_value(struct control *control,
 	if (len) {
 		pdu->params_len = 0;
 
-		return CTYPE_STABLE;
+		return AVC_CTYPE_STABLE;
 	}
 
 err:
 	pdu->params_len = htons(1);
 	pdu->params[0] = E_INVALID_PARAM;
-	return CTYPE_REJECTED;
+	return AVC_CTYPE_REJECTED;
 }
 
 static uint8_t avrcp_handle_displayable_charset(struct control *control,
@@ -1286,7 +1079,7 @@ static uint8_t avrcp_handle_displayable_charset(struct control *control,
 	if (len < 3) {
 		pdu->params_len = htons(1);
 		pdu->params[0] = E_INVALID_PARAM;
-		return CTYPE_REJECTED;
+		return AVC_CTYPE_REJECTED;
 	}
 
 	/*
@@ -1294,7 +1087,7 @@ static uint8_t avrcp_handle_displayable_charset(struct control *control,
 	 * encoding since CT is obliged to support it.
 	 */
 	pdu->params_len = 0;
-	return CTYPE_STABLE;
+	return AVC_CTYPE_STABLE;
 }
 
 static uint8_t avrcp_handle_ct_battery_status(struct control *control,
@@ -1316,12 +1109,12 @@ static uint8_t avrcp_handle_ct_battery_status(struct control *control,
 					DBUS_TYPE_STRING, &valstr);
 	pdu->params_len = 0;
 
-	return CTYPE_STABLE;
+	return AVC_CTYPE_STABLE;
 
 err:
 	pdu->params_len = htons(1);
 	pdu->params[0] = E_INVALID_PARAM;
-	return CTYPE_REJECTED;
+	return AVC_CTYPE_REJECTED;
 }
 
 static uint8_t avrcp_handle_get_play_status(struct control *control,
@@ -1336,7 +1129,7 @@ static uint8_t avrcp_handle_get_play_status(struct control *control,
 	if (len != 0) {
 		pdu->params_len = htons(1);
 		pdu->params[0] = E_INVALID_PARAM;
-		return CTYPE_REJECTED;
+		return AVC_CTYPE_REJECTED;
 	}
 
 	if (control->mp) {
@@ -1356,7 +1149,7 @@ static uint8_t avrcp_handle_get_play_status(struct control *control,
 
 	pdu->params_len = htons(9);
 
-	return CTYPE_STABLE;
+	return AVC_CTYPE_STABLE;
 }
 
 static uint8_t avrcp_handle_register_notification(struct control *control,
@@ -1406,12 +1199,12 @@ static uint8_t avrcp_handle_register_notification(struct control *control,
 
 	pdu->params_len = htons(len);
 
-	return CTYPE_INTERIM;
+	return AVC_CTYPE_INTERIM;
 
 err:
 	pdu->params_len = htons(1);
 	pdu->params[0] = E_INVALID_PARAM;
-	return CTYPE_REJECTED;
+	return AVC_CTYPE_REJECTED;
 }
 
 static struct pdu_handler {
@@ -1421,51 +1214,54 @@ static struct pdu_handler {
 					struct avrcp_header *pdu,
 					uint8_t transaction);
 } handlers[] = {
-		{ AVRCP_GET_CAPABILITIES, CTYPE_STATUS,
+		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
 					avrcp_handle_get_capabilities },
-		{ AVRCP_LIST_PLAYER_ATTRIBUTES, CTYPE_STATUS,
+		{ AVRCP_LIST_PLAYER_ATTRIBUTES, AVC_CTYPE_STATUS,
 					avrcp_handle_list_player_attributes },
-		{ AVRCP_LIST_PLAYER_VALUES, CTYPE_STATUS,
+		{ AVRCP_LIST_PLAYER_VALUES, AVC_CTYPE_STATUS,
 					avrcp_handle_list_player_values },
-		{ AVRCP_GET_ELEMENT_ATTRIBUTES, CTYPE_STATUS,
+		{ AVRCP_GET_ELEMENT_ATTRIBUTES, AVC_CTYPE_STATUS,
 					avrcp_handle_get_element_attributes },
-		{ AVRCP_GET_CURRENT_PLAYER_VALUE, CTYPE_STATUS,
+		{ AVRCP_GET_CURRENT_PLAYER_VALUE, AVC_CTYPE_STATUS,
 					avrcp_handle_get_current_player_value },
-		{ AVRCP_SET_PLAYER_VALUE, CTYPE_CONTROL,
+		{ AVRCP_SET_PLAYER_VALUE, AVC_CTYPE_CONTROL,
 					avrcp_handle_set_player_value },
-		{ AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, CTYPE_STATUS,
+		{ AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, AVC_CTYPE_STATUS,
 					NULL },
-		{ AVRCP_GET_PLAYER_VALUE_TEXT, CTYPE_STATUS,
+		{ AVRCP_GET_PLAYER_VALUE_TEXT, AVC_CTYPE_STATUS,
 					NULL },
-		{ AVRCP_DISPLAYABLE_CHARSET, CTYPE_STATUS,
+		{ AVRCP_DISPLAYABLE_CHARSET, AVC_CTYPE_STATUS,
 					avrcp_handle_displayable_charset },
-		{ AVRCP_CT_BATTERY_STATUS, CTYPE_STATUS,
+		{ AVRCP_CT_BATTERY_STATUS, AVC_CTYPE_STATUS,
 					avrcp_handle_ct_battery_status },
-		{ AVRCP_GET_PLAY_STATUS, CTYPE_STATUS,
+		{ AVRCP_GET_PLAY_STATUS, AVC_CTYPE_STATUS,
 					avrcp_handle_get_play_status },
-		{ AVRCP_REGISTER_NOTIFICATION, CTYPE_NOTIFY,
+		{ AVRCP_REGISTER_NOTIFICATION, AVC_CTYPE_NOTIFY,
 					avrcp_handle_register_notification },
 		{ },
 };
 
 /* handle vendordep pdu inside an avctp packet */
-static int handle_vendordep_pdu(struct control *control,
-					struct avctp_header *avctp,
-					struct avc_header *avc,
-					int operand_count)
+static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
+					uint8_t *code, uint8_t *subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
 {
+	struct control *control = user_data;
 	struct pdu_handler *handler;
-	struct avrcp_header *pdu = (void *) avc + AVC_HEADER_LENGTH;
+	struct avrcp_header *pdu = (void *) operands;
 	uint32_t company_id = (pdu->company_id[0] << 16) |
 				(pdu->company_id[1] << 8) |
 				(pdu->company_id[2]);
 
-	if (company_id != IEEEID_BTSIG ||
-				pdu->packet_type != AVCTP_PACKET_SINGLE) {
-		avc->code = CTYPE_NOT_IMPLEMENTED;
-		return AVC_HEADER_LENGTH;
+	if (company_id != IEEEID_BTSIG) {
+		*code = AVC_CTYPE_NOT_IMPLEMENTED;
+		return 0;
 	}
 
+	DBG("AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
+			pdu->pdu_id, company_id, pdu->params_len);
+
 	pdu->packet_type = 0;
 	pdu->rsvd = 0;
 
@@ -1477,7 +1273,7 @@ static int handle_vendordep_pdu(struct control *control,
 			break;
 	}
 
-	if (!handler || handler->code != avc->code) {
+	if (!handler || handler->code != *code) {
 		pdu->params[0] = E_INVALID_COMMAND;
 		goto err_metadata;
 	}
@@ -1487,64 +1283,31 @@ static int handle_vendordep_pdu(struct control *control,
 		goto err_metadata;
 	}
 
-	avc->code = handler->func(control, pdu, avctp->transaction);
+	*code = handler->func(control, pdu, transaction);
 
-	return AVC_HEADER_LENGTH + AVRCP_HEADER_LENGTH +
-						ntohs(pdu->params_len);
+	return AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
 
 err_metadata:
 	pdu->params_len = htons(1);
-	avc->code = CTYPE_REJECTED;
+	*code = AVC_CTYPE_REJECTED;
 
-	return AVC_HEADER_LENGTH + AVRCP_HEADER_LENGTH + 1;
+	return AVRCP_HEADER_LENGTH + 1;
 }
 
-static void avctp_disconnected(struct audio_device *dev)
+static void state_changed(struct audio_device *dev, avctp_state_t old_state,
+				avctp_state_t new_state, void *user_data)
 {
 	struct control *control = dev->control;
-
-	if (!control)
-		return;
-
-	if (control->io) {
-		g_io_channel_shutdown(control->io, TRUE, NULL);
-		g_io_channel_unref(control->io);
-		control->io = NULL;
-	}
-
-	if (control->io_id) {
-		g_source_remove(control->io_id);
-		control->io_id = 0;
-
-		if (control->state == AVCTP_STATE_CONNECTING)
-			audio_device_cancel_authorization(dev, auth_cb,
-								control);
-	}
-
-	if (control->uinput >= 0) {
-		char address[18];
-
-		ba2str(&dev->dst, address);
-		DBG("AVRCP: closing uinput for %s", address);
-
-		ioctl(control->uinput, UI_DEV_DESTROY);
-		close(control->uinput);
-		control->uinput = -1;
-	}
-}
-
-static void avctp_set_state(struct control *control, avctp_state_t new_state)
-{
-	GSList *l;
-	struct audio_device *dev = control->dev;
-	avctp_state_t old_state = control->state;
 	gboolean value;
 
 	switch (new_state) {
 	case AVCTP_STATE_DISCONNECTED:
-		DBG("AVCTP Disconnected");
+		control->session = NULL;
 
-		avctp_disconnected(control->dev);
+		if (control->mp && control->mp->handler) {
+			avctp_unregister_pdu_handler(control->mp->handler);
+			control->mp->handler = 0;
+		}
 
 		if (old_state != AVCTP_STATE_CONNECTED)
 			break;
@@ -1557,221 +1320,32 @@ static void avctp_set_state(struct control *control, avctp_state_t new_state)
 					AUDIO_CONTROL_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &value);
 
-		if (!audio_device_is_active(dev, NULL))
-			audio_device_set_authorized(dev, FALSE);
-
 		break;
 	case AVCTP_STATE_CONNECTING:
-		DBG("AVCTP Connecting");
+		if (control->session)
+			break;
+
+		control->session = avctp_connect(&dev->src, &dev->dst);
+		if (!control->mp)
+			break;
+
+		control->mp->handler = avctp_register_pdu_handler(
+							AVC_OP_VENDORDEP,
+							handle_vendordep_pdu,
+							control);
 		break;
 	case AVCTP_STATE_CONNECTED:
-		DBG("AVCTP Connected");
 		value = TRUE;
-		g_dbus_emit_signal(control->dev->conn, control->dev->path,
+		g_dbus_emit_signal(dev->conn, dev->path,
 				AUDIO_CONTROL_INTERFACE, "Connected",
 				DBUS_TYPE_INVALID);
-		emit_property_changed(control->dev->conn, control->dev->path,
+		emit_property_changed(dev->conn, dev->path,
 				AUDIO_CONTROL_INTERFACE, "Connected",
 				DBUS_TYPE_BOOLEAN, &value);
 		break;
 	default:
-		error("Invalid AVCTP state %d", new_state);
 		return;
 	}
-
-	control->state = new_state;
-
-	for (l = avctp_callbacks; l != NULL; l = l->next) {
-		struct avctp_state_callback *cb = l->data;
-		cb->cb(control->dev, old_state, new_state, cb->user_data);
-	}
-}
-
-static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
-				gpointer data)
-{
-	struct control *control = data;
-	unsigned char buf[1024], *operands;
-	struct avctp_header *avctp;
-	struct avc_header *avc;
-	int ret, packet_size, operand_count, sock;
-
-	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
-		goto failed;
-
-	sock = g_io_channel_unix_get_fd(control->io);
-
-	ret = read(sock, buf, sizeof(buf));
-	if (ret <= 0)
-		goto failed;
-
-	DBG("Got %d bytes of data for AVCTP session %p", ret, control);
-
-	if ((unsigned int) ret < sizeof(struct avctp_header)) {
-		error("Too small AVCTP packet");
-		goto failed;
-	}
-
-	packet_size = ret;
-
-	avctp = (struct avctp_header *) buf;
-
-	DBG("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
-			"PID 0x%04X",
-			avctp->transaction, avctp->packet_type,
-			avctp->cr, avctp->ipid, ntohs(avctp->pid));
-
-	ret -= sizeof(struct avctp_header);
-	if ((unsigned int) ret < sizeof(struct avc_header)) {
-		error("Too small AVRCP packet");
-		goto failed;
-	}
-
-	avc = (struct avc_header *) (buf + sizeof(struct avctp_header));
-
-	ret -= sizeof(struct avc_header);
-
-	operands = buf + sizeof(struct avctp_header) + sizeof(struct avc_header);
-	operand_count = ret;
-
-	DBG("AV/C %s 0x%01X, subunit_type 0x%02X, subunit_id 0x%01X, "
-			"opcode 0x%02X, %d operands",
-			avctp->cr ? "response" : "command",
-			avc->code, avc->subunit_type, avc->subunit_id,
-			avc->opcode, operand_count);
-
-	if (avctp->packet_type != AVCTP_PACKET_SINGLE) {
-		avctp->cr = AVCTP_RESPONSE;
-		avc->code = CTYPE_NOT_IMPLEMENTED;
-	} else if (avctp->pid != htons(AV_REMOTE_SVCLASS_ID)) {
-		avctp->ipid = 1;
-		avctp->cr = AVCTP_RESPONSE;
-		packet_size = sizeof(*avctp);
-	} else if (avctp->cr == AVCTP_COMMAND &&
-			avc->code == CTYPE_CONTROL &&
-			avc->subunit_type == SUBUNIT_PANEL &&
-			avc->opcode == OP_PASSTHROUGH) {
-		handle_panel_passthrough(control, operands, operand_count);
-		avctp->cr = AVCTP_RESPONSE;
-		avc->code = CTYPE_ACCEPTED;
-	} else if (avctp->cr == AVCTP_COMMAND &&
-			avc->code == CTYPE_STATUS &&
-			(avc->opcode == OP_UNITINFO
-			|| avc->opcode == OP_SUBUNITINFO)) {
-		avctp->cr = AVCTP_RESPONSE;
-		avc->code = CTYPE_STABLE;
-		/* The first operand should be 0x07 for the UNITINFO response.
-		 * Neither AVRCP (section 22.1, page 117) nor AVC Digital
-		 * Interface Command Set (section 9.2.1, page 45) specs
-		 * explain this value but both use it */
-		if (operand_count >= 1 && avc->opcode == OP_UNITINFO)
-			operands[0] = 0x07;
-		if (operand_count >= 2)
-			operands[1] = SUBUNIT_PANEL << 3;
-		DBG("reply to %s", avc->opcode == OP_UNITINFO ?
-				"OP_UNITINFO" : "OP_SUBUNITINFO");
-	} else if (avctp->cr == AVCTP_COMMAND &&
-			avc->opcode == OP_VENDORDEP) {
-		int r_size;
-		operand_count -= 3;
-		avctp->cr = AVCTP_RESPONSE;
-		r_size = handle_vendordep_pdu(control, avctp, avc,
-								operand_count);
-		packet_size = AVCTP_HEADER_LENGTH + r_size;
-	} else {
-		avctp->cr = AVCTP_RESPONSE;
-		avc->code = CTYPE_REJECTED;
-	}
-
-	ret = write(sock, buf, packet_size);
-	if (ret != packet_size)
-		goto failed;
-
-	return TRUE;
-
-failed:
-	DBG("AVCTP session %p got disconnected", control);
-	avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
-	return FALSE;
-}
-
-static int uinput_create(char *name)
-{
-	struct uinput_dev dev;
-	int fd, err, i;
-
-	fd = open("/dev/uinput", O_RDWR);
-	if (fd < 0) {
-		fd = open("/dev/input/uinput", O_RDWR);
-		if (fd < 0) {
-			fd = open("/dev/misc/uinput", O_RDWR);
-			if (fd < 0) {
-				err = errno;
-				error("Can't open input device: %s (%d)",
-							strerror(err), err);
-				return -err;
-			}
-		}
-	}
-
-	memset(&dev, 0, sizeof(dev));
-	if (name)
-		strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
-
-	dev.id.bustype = BUS_BLUETOOTH;
-	dev.id.vendor  = 0x0000;
-	dev.id.product = 0x0000;
-	dev.id.version = 0x0000;
-
-	if (write(fd, &dev, sizeof(dev)) < 0) {
-		err = errno;
-		error("Can't write device information: %s (%d)",
-						strerror(err), err);
-		close(fd);
-		errno = err;
-		return -err;
-	}
-
-	ioctl(fd, UI_SET_EVBIT, EV_KEY);
-	ioctl(fd, UI_SET_EVBIT, EV_REL);
-	ioctl(fd, UI_SET_EVBIT, EV_REP);
-	ioctl(fd, UI_SET_EVBIT, EV_SYN);
-
-	for (i = 0; key_map[i].name != NULL; i++)
-		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
-
-	if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
-		err = errno;
-		error("Can't create uinput device: %s (%d)",
-						strerror(err), err);
-		close(fd);
-		errno = err;
-		return -err;
-	}
-
-	return fd;
-}
-
-static void init_uinput(struct control *control)
-{
-	struct audio_device *dev = control->dev;
-	char address[18], name[248 + 1];
-
-	device_get_name(dev->btd_dev, name, sizeof(name));
-	if (g_str_equal(name, "Nokia CK-20W")) {
-		control->key_quirks[FORWARD_OP] |= QUIRK_NO_RELEASE;
-		control->key_quirks[BACKWARD_OP] |= QUIRK_NO_RELEASE;
-		control->key_quirks[PLAY_OP] |= QUIRK_NO_RELEASE;
-		control->key_quirks[PAUSE_OP] |= QUIRK_NO_RELEASE;
-	}
-
-	ba2str(&dev->dst, address);
-
-	control->uinput = uinput_create(address);
-	if (control->uinput < 0)
-		error("AVRCP: failed to init uinput for %s", address);
-	else
-		DBG("AVRCP: uinput initialized for %s", address);
 }
 
 static void media_info_init(struct media_info *mi)
@@ -1787,169 +1361,16 @@ static void media_info_init(struct media_info *mi)
 	mi->elapsed = 0xFFFFFFFF;
 }
 
-static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
-{
-	struct control *control = data;
-	char address[18];
-	uint16_t imtu;
-	GError *gerr = NULL;
-
-	if (err) {
-		avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
-		error("%s", err->message);
-		return;
-	}
-
-	bt_io_get(chan, BT_IO_L2CAP, &gerr,
-			BT_IO_OPT_DEST, &address,
-			BT_IO_OPT_IMTU, &imtu,
-			BT_IO_OPT_INVALID);
-	if (gerr) {
-		avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
-		error("%s", gerr->message);
-		g_error_free(gerr);
-		return;
-	}
-
-	DBG("AVCTP: connected to %s", address);
-
-	if (!control->io)
-		control->io = g_io_channel_ref(chan);
-
-	init_uinput(control);
-
-	avctp_set_state(control, AVCTP_STATE_CONNECTED);
-	control->mtu = imtu;
-	control->io_id = g_io_add_watch(chan,
-				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				(GIOFunc) control_cb, control);
-}
-
-static void auth_cb(DBusError *derr, void *user_data)
-{
-	struct control *control = user_data;
-	GError *err = NULL;
-
-	if (control->io_id) {
-		g_source_remove(control->io_id);
-		control->io_id = 0;
-	}
-
-	if (derr && dbus_error_is_set(derr)) {
-		error("Access denied: %s", derr->message);
-		avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
-		return;
-	}
-
-	if (!bt_io_accept(control->io, avctp_connect_cb, control,
-								NULL, &err)) {
-		error("bt_io_accept: %s", err->message);
-		g_error_free(err);
-		avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
-	}
-}
-
-static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
-{
-	struct control *control = NULL;
-	struct audio_device *dev;
-	char address[18];
-	bdaddr_t src, dst;
-	GError *err = NULL;
-
-	bt_io_get(chan, BT_IO_L2CAP, &err,
-			BT_IO_OPT_SOURCE_BDADDR, &src,
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
-	dev = manager_get_device(&src, &dst, TRUE);
-	if (!dev) {
-		error("Unable to get audio device object for %s", address);
-		goto drop;
-	}
-
-	if (!dev->control) {
-		btd_device_add_uuid(dev->btd_dev, AVRCP_REMOTE_UUID);
-		if (!dev->control)
-			goto drop;
-	}
-
-	control = dev->control;
-
-	if (control->io) {
-		error("Refusing unexpected connect from %s", address);
-		goto drop;
-	}
-
-	avctp_set_state(control, AVCTP_STATE_CONNECTING);
-	control->io = g_io_channel_ref(chan);
-
-	if (audio_device_request_authorization(dev, AVRCP_TARGET_UUID,
-						auth_cb, dev->control) < 0)
-		goto drop;
-
-	control->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							control_cb, control);
-	return;
-
-drop:
-	if (!control || !control->io)
-		g_io_channel_shutdown(chan, TRUE, NULL);
-	if (control)
-		avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
-}
-
-static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master)
-{
-	GError *err = NULL;
-	GIOChannel *io;
-
-	io = bt_io_listen(BT_IO_L2CAP, NULL, avctp_confirm_cb, NULL,
-				NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_PSM, AVCTP_PSM,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, master,
-				BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
-		g_error_free(err);
-	}
-
-	return io;
-}
-
 gboolean avrcp_connect(struct audio_device *dev)
 {
 	struct control *control = dev->control;
-	GError *err = NULL;
-	GIOChannel *io;
 
-	if (control->state > AVCTP_STATE_DISCONNECTED)
+	if (control->session)
 		return TRUE;
 
-	avctp_set_state(control, AVCTP_STATE_CONNECTING);
-
-	io = bt_io_connect(BT_IO_L2CAP, avctp_connect_cb, control, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &dev->src,
-				BT_IO_OPT_DEST_BDADDR, &dev->dst,
-				BT_IO_OPT_PSM, AVCTP_PSM,
-				BT_IO_OPT_INVALID);
-	if (err) {
-		avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
-		error("%s", err->message);
-		g_error_free(err);
+	control->session = avctp_connect(&dev->src, &dev->dst);
+	if (!control->session)
 		return FALSE;
-	}
-
-	control->io = io;
 
 	return TRUE;
 }
@@ -1958,10 +1379,10 @@ void avrcp_disconnect(struct audio_device *dev)
 {
 	struct control *control = dev->control;
 
-	if (!(control && control->io))
+	if (!(control && control->session))
 		return;
 
-	avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
+	avctp_disconnect(control->session);
 }
 
 int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
@@ -1969,7 +1390,7 @@ int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 	sdp_record_t *record;
 	gboolean tmp, master = TRUE;
 	GError *err = NULL;
-	struct avctp_server *server;
+	struct avrcp_server *server;
 
 	if (config) {
 		tmp = g_key_file_get_boolean(config, "General",
@@ -1981,7 +1402,7 @@ int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 			master = tmp;
 	}
 
-	server = g_new0(struct avctp_server, 1);
+	server = g_new0(struct avrcp_server, 1);
 	if (!server)
 		return -ENOMEM;
 
@@ -2018,8 +1439,7 @@ int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 	}
 	server->ct_record_id = record->handle;
 
-	server->io = avctp_server_socket(src, master);
-	if (!server->io) {
+	if (avctp_register(src, master) < 0) {
 		remove_record_from_server(server->ct_record_id);
 		remove_record_from_server(server->tg_record_id);
 		g_free(server);
@@ -2033,10 +1453,10 @@ int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 	return 0;
 }
 
-static struct avctp_server *find_server(GSList *list, const bdaddr_t *src)
+static struct avrcp_server *find_server(GSList *list, const bdaddr_t *src)
 {
 	for (; list; list = list->next) {
-		struct avctp_server *server = list->data;
+		struct avrcp_server *server = list->data;
 
 		if (bacmp(&server->src, src) == 0)
 			return server;
@@ -2047,7 +1467,7 @@ static struct avctp_server *find_server(GSList *list, const bdaddr_t *src)
 
 void avrcp_unregister(const bdaddr_t *src)
 {
-	struct avctp_server *server;
+	struct avrcp_server *server;
 
 	server = find_server(servers, src);
 	if (!server)
@@ -2058,13 +1478,15 @@ void avrcp_unregister(const bdaddr_t *src)
 	remove_record_from_server(server->ct_record_id);
 	remove_record_from_server(server->tg_record_id);
 
-	g_io_channel_shutdown(server->io, TRUE, NULL);
-	g_io_channel_unref(server->io);
+	avctp_unregister(&server->src);
 	g_free(server);
 
 	if (servers)
 		return;
 
+	if (avctp_id)
+		avctp_remove_state_cb(avctp_id);
+
 	dbus_connection_unref(connection);
 	connection = NULL;
 }
@@ -2082,7 +1504,7 @@ static DBusMessage *control_is_connected(DBusConnection *conn,
 	if (!reply)
 		return NULL;
 
-	connected = (control->state == AVCTP_STATE_CONNECTED);
+	connected = (control->session != NULL);
 
 	dbus_message_append_args(reply, DBUS_TYPE_BOOLEAN, &connected,
 					DBUS_TYPE_INVALID);
@@ -2090,42 +1512,6 @@ static DBusMessage *control_is_connected(DBusConnection *conn,
 	return reply;
 }
 
-static int avctp_send_passthrough(struct control *control, uint8_t op)
-{
-	unsigned char buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH + 2];
-	struct avctp_header *avctp = (void *) buf;
-	struct avc_header *avc = (void *) &buf[AVCTP_HEADER_LENGTH];
-	uint8_t *operands = &buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH];
-	int sk = g_io_channel_unix_get_fd(control->io);
-	static uint8_t transaction = 0;
-
-	memset(buf, 0, sizeof(buf));
-
-	avctp->transaction = transaction++;
-	avctp->packet_type = AVCTP_PACKET_SINGLE;
-	avctp->cr = AVCTP_COMMAND;
-	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
-
-	avc->code = CTYPE_CONTROL;
-	avc->subunit_type = SUBUNIT_PANEL;
-	avc->opcode = OP_PASSTHROUGH;
-
-	operands[0] = op & 0x7f;
-	operands[1] = 0;
-
-	if (write(sk, buf, sizeof(buf)) < 0)
-		return -errno;
-
-	/* Button release */
-	avctp->transaction = transaction++;
-	operands[0] |= 0x80;
-
-	if (write(sk, buf, sizeof(buf)) < 0)
-		return -errno;
-
-	return 0;
-}
-
 static DBusMessage *volume_up(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -2133,13 +1519,13 @@ static DBusMessage *volume_up(DBusConnection *conn, DBusMessage *msg,
 	struct control *control = device->control;
 	int err;
 
-	if (control->state != AVCTP_STATE_CONNECTED)
+	if (!control->session)
 		return btd_error_not_connected(msg);
 
 	if (!control->target)
 		return btd_error_not_supported(msg);
 
-	err = avctp_send_passthrough(control, VOL_UP_OP);
+	err = avctp_send_passthrough(control->session, VOL_UP_OP);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -2153,13 +1539,13 @@ static DBusMessage *volume_down(DBusConnection *conn, DBusMessage *msg,
 	struct control *control = device->control;
 	int err;
 
-	if (control->state != AVCTP_STATE_CONNECTED)
+	if (!control->session)
 		return btd_error_not_connected(msg);
 
 	if (!control->target)
 		return btd_error_not_supported(msg);
 
-	err = avctp_send_passthrough(control, VOL_DOWN_OP);
+	err = avctp_send_passthrough(control->session, VOL_DOWN_OP);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -2187,7 +1573,7 @@ static DBusMessage *control_get_properties(DBusConnection *conn,
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
 	/* Connected */
-	value = (device->control->state == AVCTP_STATE_CONNECTED);
+	value = (device->control->session != NULL);
 	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &value);
 
 	dbus_message_iter_close_container(&iter, &dict);
@@ -2404,8 +1790,8 @@ static void path_unregister(void *data)
 	DBG("Unregistered interface %s on path %s",
 		AUDIO_CONTROL_INTERFACE, dev->path);
 
-	if (control->state != AVCTP_STATE_DISCONNECTED)
-		avctp_disconnected(dev);
+	if (control->session)
+		avctp_disconnect(control->session);
 
 	g_free(control);
 	dev->control = NULL;
@@ -2420,6 +1806,9 @@ static void mp_path_unregister(void *data)
 	DBG("Unregistered interface %s on path %s",
 		MEDIA_PLAYER_INTERFACE, dev->path);
 
+	if (mp->handler)
+		avctp_unregister_pdu_handler(mp->handler);
+
 	g_timer_destroy(mp->timer);
 	g_free(mp);
 	control->mp = NULL;
@@ -2494,11 +1883,12 @@ struct control *control_init(struct audio_device *dev, uint16_t uuid16,
 
 	control = g_new0(struct control, 1);
 	control->dev = dev;
-	control->state = AVCTP_STATE_DISCONNECTED;
-	control->uinput = -1;
 
 	control_update(control, uuid16, media_player);
 
+	if (!avctp_id)
+		avctp_id = avctp_add_state_cb(state_changed, NULL);
+
 	return control;
 }
 
@@ -2506,39 +1896,8 @@ gboolean control_is_active(struct audio_device *dev)
 {
 	struct control *control = dev->control;
 
-	if (control && control->state != AVCTP_STATE_DISCONNECTED)
+	if (control && control->session)
 		return TRUE;
 
 	return FALSE;
 }
-
-unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data)
-{
-	struct avctp_state_callback *state_cb;
-	static unsigned int id = 0;
-
-	state_cb = g_new(struct avctp_state_callback, 1);
-	state_cb->cb = cb;
-	state_cb->user_data = user_data;
-	state_cb->id = ++id;
-
-	avctp_callbacks = g_slist_append(avctp_callbacks, state_cb);
-
-	return state_cb->id;
-}
-
-gboolean avctp_remove_state_cb(unsigned int id)
-{
-	GSList *l;
-
-	for (l = avctp_callbacks; l != NULL; l = l->next) {
-		struct avctp_state_callback *cb = l->data;
-		if (cb && cb->id == id) {
-			avctp_callbacks = g_slist_remove(avctp_callbacks, cb);
-			g_free(cb);
-			return TRUE;
-		}
-	}
-
-	return FALSE;
-}
diff --git a/audio/control.h b/audio/control.h
index 77e7595..f5cfef2 100644
--- a/audio/control.h
+++ b/audio/control.h
@@ -25,20 +25,6 @@
 #define AUDIO_CONTROL_INTERFACE "org.bluez.Control"
 #define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
 
-typedef enum {
-	AVCTP_STATE_DISCONNECTED = 0,
-	AVCTP_STATE_CONNECTING,
-	AVCTP_STATE_CONNECTED
-} avctp_state_t;
-
-typedef void (*avctp_state_cb) (struct audio_device *dev,
-				avctp_state_t old_state,
-				avctp_state_t new_state,
-				void *user_data);
-
-unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data);
-gboolean avctp_remove_state_cb(unsigned int id);
-
 int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config);
 void avrcp_unregister(const bdaddr_t *src);
 
diff --git a/audio/device.c b/audio/device.c
index ea268bc..16f0701 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -52,6 +52,7 @@
 #include "unix.h"
 #include "avdtp.h"
 #include "control.h"
+#include "avctp.h"
 #include "headset.h"
 #include "gateway.h"
 #include "sink.h"
-- 
1.7.6.1

