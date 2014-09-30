Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] emulator/bthost: Avoid coping in l2cap_sig_send
Date: Tue, 30 Sep 2014 17:19:53 +0300
Message-Id: <1412086795-25000-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses scatter io to avoid extra copies inside l2cap_sig_send
---
 emulator/bthost.c | 75 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 22bdca5..8d06de9 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -484,38 +484,48 @@ static void send_packet(struct bthost *bthost, const struct iovec *iov,
 	bthost->send_handler(iov, iovlen, bthost->send_data);
 }
 
-static void send_acl(struct bthost *bthost, uint16_t handle, uint16_t cid,
-						const void *data, uint16_t len)
+static void send_iov(struct bthost *bthost, uint16_t handle, uint16_t cid,
+					const struct iovec *iov, int iovcnt)
 {
 	struct bt_hci_acl_hdr acl_hdr;
 	struct bt_l2cap_hdr l2_hdr;
 	uint8_t pkt = BT_H4_ACL_PKT;
-	struct iovec iov[4];
+	struct iovec pdu[3 + iovcnt];
+	int i, len = 0;
 
-	iov[0].iov_base = &pkt;
-	iov[0].iov_len = sizeof(pkt);
+	for (i = 0; i < iovcnt; i++) {
+		pdu[3 + i].iov_base = iov[i].iov_base;
+		pdu[3 + i].iov_len = iov[i].iov_len;
+		len += iov[i].iov_len;
+	}
+
+	pdu[0].iov_base = &pkt;
+	pdu[0].iov_len = sizeof(pkt);
 
 	acl_hdr.handle = acl_handle_pack(handle, 0);
 	acl_hdr.dlen = cpu_to_le16(len + sizeof(l2_hdr));
 
-	iov[1].iov_base = &acl_hdr;
-	iov[1].iov_len = sizeof(acl_hdr);
+	pdu[1].iov_base = &acl_hdr;
+	pdu[1].iov_len = sizeof(acl_hdr);
 
 	l2_hdr.cid = cpu_to_le16(cid);
 	l2_hdr.len = cpu_to_le16(len);
 
-	iov[2].iov_base = &l2_hdr;
-	iov[2].iov_len = sizeof(l2_hdr);
+	pdu[2].iov_base = &l2_hdr;
+	pdu[2].iov_len = sizeof(l2_hdr);
 
-	if (len == 0) {
-		send_packet(bthost, iov, 3);
-		return;
-	}
+	send_packet(bthost, pdu, 3 + iovcnt);
+}
 
-	iov[3].iov_base = (void *) data;
-	iov[3].iov_len = len;
+static void send_acl(struct bthost *bthost, uint16_t handle, uint16_t cid,
+						const void *data, uint16_t len)
+{
+	struct iovec iov;
 
-	send_packet(bthost, iov, 4);
+	iov.iov_base = (void *) data;
+	iov.iov_len = len;
+
+	send_iov(bthost, handle, cid, &iov, 1);
 }
 
 static uint8_t l2cap_sig_send(struct bthost *bthost, struct btconn *conn,
@@ -523,15 +533,9 @@ static uint8_t l2cap_sig_send(struct bthost *bthost, struct btconn *conn,
 					const void *data, uint16_t len)
 {
 	static uint8_t next_ident = 1;
-	struct bt_l2cap_hdr_sig *hdr;
-	uint16_t pkt_len, cid;
-	void *pkt_data;
-
-	pkt_len = sizeof(*hdr) + len;
-
-	pkt_data = malloc(pkt_len);
-	if (!pkt_data)
-		return 0;
+	struct bt_l2cap_hdr_sig hdr;
+	uint16_t cid;
+	struct iovec iov[2];
 
 	if (!ident) {
 		ident = next_ident++;
@@ -539,22 +543,27 @@ static uint8_t l2cap_sig_send(struct bthost *bthost, struct btconn *conn,
 			ident = next_ident++;
 	}
 
-	hdr = pkt_data;
-	hdr->code  = code;
-	hdr->ident = ident;
-	hdr->len   = cpu_to_le16(len);
+	hdr.code  = code;
+	hdr.ident = ident;
+	hdr.len   = cpu_to_le16(len);
 
-	if (len > 0)
-		memcpy(pkt_data + sizeof(*hdr), data, len);
+	iov[0].iov_base = &hdr;
+	iov[0].iov_len = sizeof(hdr);
 
 	if (conn->addr_type == BDADDR_BREDR)
 		cid = 0x0001;
 	else
 		cid = 0x0005;
 
-	send_acl(bthost, conn->handle, cid, pkt_data, pkt_len);
+	if (len == 0) {
+		send_iov(bthost, conn->handle, cid, iov, 1);
+		return ident;
+	}
+
+	iov[1].iov_base = (void *) data;
+	iov[1].iov_len = len;
 
-	free(pkt_data);
+	send_iov(bthost, conn->handle, cid, iov, 2);
 
 	return ident;
 }
-- 
1.9.3

