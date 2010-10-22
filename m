Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/6] Bluetooth: fix receiving L2CAP packets over LE
Date: Fri, 22 Oct 2010 19:56:56 -0400
Message-Id: <1287791820-22693-3-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <linux-bluetooth@vger.kernel.org>
References: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

As L2CAP packets coming over LE don't have any more encapsulation,
other than L2CAP, we are able to process them as soon as they arrive.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 2bf083e..1ac44f4 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4768,17 +4768,30 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_hdr *hdr;
+	int len;
 
 	if (!conn && !(conn = l2cap_conn_add(hcon, 0)))
 		goto drop;
 
 	BT_DBG("conn %p len %d flags 0x%x", conn, skb->len, flags);
 
+	if (hcon->type == LE_LINK) {
+		hdr = (struct l2cap_hdr *) skb->data;
+		len = __le16_to_cpu(hdr->len) + L2CAP_HDR_SIZE;
+
+		if (len == skb->len) {
+			/* Complete frame received */
+			l2cap_recv_frame(conn, skb);
+			return 0;
+		}
+
+		goto drop;
+	}
+
 	if (flags & ACL_START) {
-		struct l2cap_hdr *hdr;
 		struct sock *sk;
 		u16 cid;
-		int len;
 
 		if (conn->rx_len) {
 			BT_ERR("Unexpected start frame (len %d)", skb->len);
-- 
1.7.0.4

