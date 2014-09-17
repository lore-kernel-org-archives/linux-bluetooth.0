Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] emulator/bthost: Add iovec support
Date: Wed, 17 Sep 2014 15:49:45 +0300
Message-Id: <1410958185-3878-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1410958185-3878-1-git-send-email-luiz.dentz@gmail.com>
References: <1410958185-3878-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This convert bthost_set_send_handler to take struct iovec for doing
scatter io.
---
 emulator/bthost.c   | 96 ++++++++++++++++++++++++++++-------------------------
 emulator/bthost.h   |  3 +-
 src/shared/hciemu.c | 15 +--------
 3 files changed, 54 insertions(+), 60 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 1fae580..766f14c 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -448,11 +448,12 @@ void bthost_set_send_handler(struct bthost *bthost, bthost_send_func handler,
 	bthost->send_data = user_data;
 }
 
-static void queue_command(struct bthost *bthost, const void *data,
-								uint16_t len)
+static void queue_command(struct bthost *bthost, const struct iovec *iov,
+								int iovlen)
 {
 	struct cmd_queue *cmd_q = &bthost->cmd_q;
 	struct cmd *cmd;
+	int i;
 
 	cmd = malloc(sizeof(*cmd));
 	if (!cmd)
@@ -460,8 +461,10 @@ static void queue_command(struct bthost *bthost, const void *data,
 
 	memset(cmd, 0, sizeof(*cmd));
 
-	memcpy(cmd->data, data, len);
-	cmd->len = len;
+	for (i = 0; i < iovlen; i++) {
+		memcpy(cmd->data + cmd->len, iov[i].iov_base, iov[i].iov_len);
+		cmd->len += iov[i].iov_len;
+	}
 
 	if (cmd_q->tail)
 		cmd_q->tail->next = cmd;
@@ -472,45 +475,47 @@ static void queue_command(struct bthost *bthost, const void *data,
 	cmd_q->tail = cmd;
 }
 
-static void send_packet(struct bthost *bthost, const void *data, uint16_t len)
+static void send_packet(struct bthost *bthost, const struct iovec *iov,
+								int iovlen)
 {
 	if (!bthost->send_handler)
 		return;
 
-	bthost->send_handler(data, len, bthost->send_data);
+	bthost->send_handler(iov, iovlen, bthost->send_data);
 }
 
 static void send_acl(struct bthost *bthost, uint16_t handle, uint16_t cid,
 						const void *data, uint16_t len)
 {
-	struct bt_hci_acl_hdr *acl_hdr;
-	struct bt_l2cap_hdr *l2_hdr;
-	uint16_t pkt_len;
-	void *pkt_data;
+	struct bt_hci_acl_hdr acl_hdr;
+	struct bt_l2cap_hdr l2_hdr;
+	uint8_t pkt = BT_H4_ACL_PKT;
+	struct iovec iov[4];
 
-	pkt_len = 1 + sizeof(*acl_hdr) + sizeof(*l2_hdr) + len;
+	iov[0].iov_base = &pkt;
+	iov[0].iov_len = sizeof(pkt);
 
-	pkt_data = malloc(pkt_len);
-	if (!pkt_data)
-		return;
+	acl_hdr.handle = acl_handle_pack(handle, 0);
+	acl_hdr.dlen = cpu_to_le16(len + sizeof(l2_hdr));
 
-	((uint8_t *) pkt_data)[0] = BT_H4_ACL_PKT;
+	iov[1].iov_base = &acl_hdr;
+	iov[1].iov_len = sizeof(acl_hdr);
 
-	acl_hdr = pkt_data + 1;
-	acl_hdr->handle = acl_handle_pack(handle, 0);
-	acl_hdr->dlen = cpu_to_le16(len + sizeof(*l2_hdr));
+	l2_hdr.cid = cpu_to_le16(cid);
+	l2_hdr.len = cpu_to_le16(len);
 
-	l2_hdr = pkt_data + 1 + sizeof(*acl_hdr);
-	l2_hdr->cid = cpu_to_le16(cid);
-	l2_hdr->len = cpu_to_le16(len);
+	iov[2].iov_base = &l2_hdr;
+	iov[2].iov_len = sizeof(l2_hdr);
 
-	if (len > 0)
-		memcpy(pkt_data + 1 + sizeof(*acl_hdr) + sizeof(*l2_hdr),
-								data, len);
+	if (len == 0) {
+		send_packet(bthost, iov, 3);
+		return;
+	}
 
-	send_packet(bthost, pkt_data, pkt_len);
+	iov[3].iov_base = (void *) data;
+	iov[3].iov_len = len;
 
-	free(pkt_data);
+	send_packet(bthost, iov, 4);
 }
 
 static uint8_t l2cap_sig_send(struct bthost *bthost, struct btconn *conn,
@@ -636,33 +641,30 @@ bool bthost_l2cap_req(struct bthost *bthost, uint16_t handle, uint8_t code,
 static void send_command(struct bthost *bthost, uint16_t opcode,
 						const void *data, uint8_t len)
 {
-	struct bt_hci_cmd_hdr *hdr;
-	uint16_t pkt_len;
-	void *pkt_data;
+	struct bt_hci_cmd_hdr hdr;
+	uint8_t pkt = BT_H4_CMD_PKT;
+	struct iovec iov[3];
 
-	pkt_len = 1 + sizeof(*hdr) + len;
+	iov[0].iov_base = &pkt;
+	iov[0].iov_len = sizeof(pkt);
 
-	pkt_data = malloc(pkt_len);
-	if (!pkt_data)
-		return;
+	hdr.opcode = cpu_to_le16(opcode);
+	hdr.plen = len;
 
-	((uint8_t *) pkt_data)[0] = BT_H4_CMD_PKT;
+	iov[1].iov_base = &hdr;
+	iov[1].iov_len = sizeof(hdr);
 
-	hdr = pkt_data + 1;
-	hdr->opcode = cpu_to_le16(opcode);
-	hdr->plen = len;
-
-	if (len > 0)
-		memcpy(pkt_data + 1 + sizeof(*hdr), data, len);
+	if (len > 0) {
+		iov[2].iov_base = (void *) data;
+		iov[2].iov_len = len;
+	}
 
 	if (bthost->ncmd) {
-		send_packet(bthost, pkt_data, pkt_len);
+		send_packet(bthost, iov, len > 0 ? 3 : 2);
 		bthost->ncmd--;
 	} else {
-		queue_command(bthost, pkt_data, pkt_len);
+		queue_command(bthost, iov, len > 0 ? 3 : 2);
 	}
-
-	free(pkt_data);
 }
 
 static void next_cmd(struct bthost *bthost)
@@ -670,6 +672,7 @@ static void next_cmd(struct bthost *bthost)
 	struct cmd_queue *cmd_q = &bthost->cmd_q;
 	struct cmd *cmd = cmd_q->head;
 	struct cmd *next;
+	struct iovec iov;
 
 	if (!cmd)
 		return;
@@ -679,7 +682,10 @@ static void next_cmd(struct bthost *bthost)
 	if (!bthost->ncmd)
 		return;
 
-	send_packet(bthost, cmd->data, cmd->len);
+	iov.iov_base = cmd->data;
+	iov.iov_len = cmd->len;
+
+	send_packet(bthost, &iov, 1);
 	bthost->ncmd--;
 
 	if (next)
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 042f1cd..042d35f 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -23,8 +23,9 @@
  */
 
 #include <stdint.h>
+#include <sys/uio.h>
 
-typedef void (*bthost_send_func) (const void *data, uint16_t len,
+typedef void (*bthost_send_func) (const struct iovec *iov, int iovlen,
 							void *user_data);
 
 struct bthost;
diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 4e354a0..3892fea 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -107,19 +107,6 @@ static void client_command_callback(uint16_t opcode,
 	btdev_command_default(callback);
 }
 
-static void write_callback(const void *data, uint16_t len, void *user_data)
-{
-	GIOChannel *channel = user_data;
-	ssize_t written;
-	int fd;
-
-	fd = g_io_channel_unix_get_fd(channel);
-
-	written = write(fd, data, len);
-	if (written < 0)
-		return;
-}
-
 static void writev_callback(const struct iovec *iov, int iovlen,
 								void *user_data)
 {
@@ -167,7 +154,7 @@ static guint create_source_bthost(int fd, struct bthost *bthost)
 	g_io_channel_set_encoding(channel, NULL, NULL);
 	g_io_channel_set_buffered(channel, FALSE);
 
-	bthost_set_send_handler(bthost, write_callback, channel);
+	bthost_set_send_handler(bthost, writev_callback, channel);
 
 	source = g_io_add_watch_full(channel, G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-- 
1.9.3

