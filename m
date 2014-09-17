Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] emulator/btdev: Add iovec support
Date: Wed, 17 Sep 2014 15:49:44 +0300
Message-Id: <1410958185-3878-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This convert btdev_set_send_handler to take struct iovec for doing
scatter io.
---
 emulator/btdev.c    | 135 ++++++++++++++++++++++++++--------------------------
 emulator/btdev.h    |   2 +-
 emulator/serial.c   |   5 +-
 emulator/server.c   |  10 +++-
 emulator/vhci.c     |   5 +-
 src/shared/hciemu.c |  16 ++++++-
 6 files changed, 98 insertions(+), 75 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a60bac6..0a6df44 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -31,6 +31,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <alloca.h>
+#include <sys/uio.h>
 
 #include "src/shared/util.h"
 #include "src/shared/timeout.h"
@@ -622,103 +623,99 @@ void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
 	btdev->send_data = user_data;
 }
 
-static void send_packet(struct btdev *btdev, const void *data, uint16_t len)
+static void send_packet(struct btdev *btdev, const struct iovec *iov,
+								int iovlen)
 {
 	if (!btdev->send_handler)
 		return;
 
-	btdev->send_handler(data, len, btdev->send_data);
+	btdev->send_handler(iov, iovlen, btdev->send_data);
 }
 
 static void send_event(struct btdev *btdev, uint8_t event,
 						const void *data, uint8_t len)
 {
-	struct bt_hci_evt_hdr *hdr;
-	uint16_t pkt_len;
-	void *pkt_data;
+	struct bt_hci_evt_hdr hdr;
+	struct iovec iov[3];
+	uint8_t pkt = BT_H4_EVT_PKT;
 
-	pkt_len = 1 + sizeof(*hdr) + len;
+	iov[0].iov_base = &pkt;
+	iov[0].iov_len = sizeof(pkt);
 
-	pkt_data = malloc(pkt_len);
-	if (!pkt_data)
-		return;
-
-	((uint8_t *) pkt_data)[0] = BT_H4_EVT_PKT;
-
-	hdr = pkt_data + 1;
-	hdr->evt = event;
-	hdr->plen = len;
+	hdr.evt = event;
+	hdr.plen = len;
 
-	if (len > 0)
-		memcpy(pkt_data + 1 + sizeof(*hdr), data, len);
+	iov[1].iov_base = &hdr;
+	iov[1].iov_len = sizeof(hdr);
 
-	if (run_hooks(btdev, BTDEV_HOOK_POST_EVT, event, pkt_data, pkt_len))
-		send_packet(btdev, pkt_data, pkt_len);
+	if (len > 0) {
+		iov[2].iov_base = (void *) data;
+		iov[2].iov_len = len;
+	}
 
-	free(pkt_data);
+	if (run_hooks(btdev, BTDEV_HOOK_POST_EVT, event, data, len))
+		send_packet(btdev, iov, len > 0 ? 3 : 2);
 }
 
-static void cmd_complete(struct btdev *btdev, uint16_t opcode,
-						const void *data, uint8_t len)
+static void send_cmd(struct btdev *btdev, uint8_t evt, uint16_t opcode,
+					const struct iovec *iov, int iovlen)
 {
-	struct bt_hci_evt_hdr *hdr;
-	struct bt_hci_evt_cmd_complete *cc;
-	uint16_t pkt_len;
-	void *pkt_data;
-
-	pkt_len = 1 + sizeof(*hdr) + sizeof(*cc) + len;
-
-	pkt_data = malloc(pkt_len);
-	if (!pkt_data)
-		return;
-
-	((uint8_t *) pkt_data)[0] = BT_H4_EVT_PKT;
+	struct bt_hci_evt_hdr hdr;
+	struct iovec iov2[2 + iovlen];
+	uint8_t pkt = BT_H4_EVT_PKT;
+	int i;
 
-	hdr = pkt_data + 1;
-	hdr->evt = BT_HCI_EVT_CMD_COMPLETE;
-	hdr->plen = sizeof(*cc) + len;
+	iov2[0].iov_base = &pkt;
+	iov2[0].iov_len = sizeof(pkt);
 
-	cc = pkt_data + 1 + sizeof(*hdr);
-	cc->ncmd = 0x01;
-	cc->opcode = cpu_to_le16(opcode);
+	hdr.evt = evt;
+	hdr.plen = 0;
 
-	if (len > 0)
-		memcpy(pkt_data + 1 + sizeof(*hdr) + sizeof(*cc), data, len);
+	iov2[1].iov_base = &hdr;
+	iov2[1].iov_len = sizeof(hdr);
 
-	if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, pkt_data, pkt_len))
-		send_packet(btdev, pkt_data, pkt_len);
+	for (i = 0; i < iovlen; i++) {
+		hdr.plen += iov[i].iov_len;
+		iov2[2 + i].iov_base = iov[i].iov_base;
+		iov2[2 + i].iov_len = iov[i].iov_len;
+	}
 
-	free(pkt_data);
+	if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, iov[i].iov_base,
+								iov[i].iov_len))
+		send_packet(btdev, iov2, 2 + iovlen);
 }
 
-static void cmd_status(struct btdev *btdev, uint8_t status, uint16_t opcode)
+static void cmd_complete(struct btdev *btdev, uint16_t opcode,
+						const void *data, uint8_t len)
 {
-	struct bt_hci_evt_hdr *hdr;
-	struct bt_hci_evt_cmd_status *cs;
-	uint16_t pkt_len;
-	void *pkt_data;
+	struct bt_hci_evt_cmd_complete cc;
+	struct iovec iov[2];
 
-	pkt_len = 1 + sizeof(*hdr) + sizeof(*cs);
+	cc.ncmd = 0x01;
+	cc.opcode = cpu_to_le16(opcode);
 
-	pkt_data = malloc(pkt_len);
-	if (!pkt_data)
-		return;
+	iov[0].iov_base = &cc;
+	iov[0].iov_len = sizeof(cc);
 
-	((uint8_t *) pkt_data)[0] = BT_H4_EVT_PKT;
+	iov[1].iov_base = (void *) data;
+	iov[1].iov_len = len;
 
-	hdr = pkt_data + 1;
-	hdr->evt = BT_HCI_EVT_CMD_STATUS;
-	hdr->plen = sizeof(*cs);
+	send_cmd(btdev, BT_HCI_EVT_CMD_COMPLETE, opcode, iov, 2);
+}
 
-	cs = pkt_data + 1 + sizeof(*hdr);
-	cs->status = status;
-	cs->ncmd = 0x01;
-	cs->opcode = cpu_to_le16(opcode);
+static void cmd_status(struct btdev *btdev, uint8_t status, uint16_t opcode)
+{
+	struct bt_hci_evt_cmd_status cs;
+	struct iovec iov;
+
+	cs.status = status;
+	cs.ncmd = 0x01;
+	cs.opcode = cpu_to_le16(opcode);
 
-	if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, pkt_data, pkt_len))
-		send_packet(btdev, pkt_data, pkt_len);
+	iov.iov_base = &cs;
+	iov.iov_len = sizeof(cs);
 
-	free(pkt_data);
+	send_cmd(btdev, BT_HCI_EVT_CMD_STATUS, opcode, &iov, 1);
 }
 
 static void num_completed_packets(struct btdev *btdev)
@@ -3136,6 +3133,7 @@ static void process_cmd(struct btdev *btdev, const void *data, uint16_t len)
 void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 {
 	uint8_t pkt_type;
+	struct iovec iov;
 
 	if (!btdev)
 		return;
@@ -3150,8 +3148,11 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 		process_cmd(btdev, data + 1, len - 1);
 		break;
 	case BT_H4_ACL_PKT:
-		if (btdev->conn)
-			send_packet(btdev->conn, data, len);
+		if (btdev->conn) {
+			iov.iov_base = (void *) data;
+			iov.iov_len = len;
+			send_packet(btdev->conn, &iov, 1);
+		}
 		num_completed_packets(btdev);
 		break;
 	default:
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 1e623f4..32c708f 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -51,7 +51,7 @@ typedef void (*btdev_command_func) (uint16_t opcode,
 				const void *data, uint8_t len,
 				btdev_callback callback, void *user_data);
 
-typedef void (*btdev_send_func) (const void *data, uint16_t len,
+typedef void (*btdev_send_func) (const struct iovec *iov, int iovlen,
 							void *user_data);
 
 typedef bool (*btdev_hook_func) (const void *data, uint16_t len,
diff --git a/emulator/serial.c b/emulator/serial.c
index 27a0cba..9583be4 100644
--- a/emulator/serial.c
+++ b/emulator/serial.c
@@ -34,6 +34,7 @@
 #include <string.h>
 #include <sys/param.h>
 #include <sys/epoll.h>
+#include <sys/uio.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -70,13 +71,13 @@ static void serial_destroy(void *user_data)
 	serial->fd = -1;
 }
 
-static void serial_write_callback(const void *data, uint16_t len,
+static void serial_write_callback(const struct iovec *iov, int iovlen,
 							void *user_data)
 {
 	struct serial *serial = user_data;
 	ssize_t written;
 
-	written = write(serial->fd, data, len);
+	written = writev(serial->fd, iov, iovlen);
 	if (written < 0)
 		return;
 }
diff --git a/emulator/server.c b/emulator/server.c
index f3c82d3..c185edf 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -84,13 +84,19 @@ static void client_destroy(void *user_data)
 	free(client);
 }
 
-static void client_write_callback(const void *data, uint16_t len,
+static void client_write_callback(const struct iovec *iov, int iovlen,
 							void *user_data)
 {
 	struct client *client = user_data;
+	struct msghdr msg;
 	ssize_t written;
 
-	written = send(client->fd, data, len, MSG_DONTWAIT);
+	memset(&msg, 0, sizeof(msg));
+
+	msg.msg_iov = (struct iovec *) iov;
+	msg.msg_iovlen = iovlen;
+
+	written = sendmsg(client->fd, &msg, MSG_DONTWAIT);
 	if (written < 0)
 		return;
 }
diff --git a/emulator/vhci.c b/emulator/vhci.c
index 00c6118..2e35000 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -60,12 +60,13 @@ static void vhci_destroy(void *user_data)
 	free(vhci);
 }
 
-static void vhci_write_callback(const void *data, uint16_t len, void *user_data)
+static void vhci_write_callback(const struct iovec *iov, int iovlen,
+							void *user_data)
 {
 	struct vhci *vhci = user_data;
 	ssize_t written;
 
-	written = write(vhci->fd, data, len);
+	written = writev(vhci->fd, iov, iovlen);
 	if (written < 0)
 		return;
 }
diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 6c93005..4e354a0 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -120,6 +120,20 @@ static void write_callback(const void *data, uint16_t len, void *user_data)
 		return;
 }
 
+static void writev_callback(const struct iovec *iov, int iovlen,
+								void *user_data)
+{
+	GIOChannel *channel = user_data;
+	ssize_t written;
+	int fd;
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	written = writev(fd, iov, iovlen);
+	if (written < 0)
+		return;
+}
+
 static gboolean receive_bthost(GIOChannel *channel, GIOCondition condition,
 							gpointer user_data)
 {
@@ -203,7 +217,7 @@ static guint create_source_btdev(int fd, struct btdev *btdev)
 	g_io_channel_set_encoding(channel, NULL, NULL);
 	g_io_channel_set_buffered(channel, FALSE);
 
-	btdev_set_send_handler(btdev, write_callback, channel);
+	btdev_set_send_handler(btdev, writev_callback, channel);
 
 	source = g_io_add_watch_full(channel, G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-- 
1.9.3

