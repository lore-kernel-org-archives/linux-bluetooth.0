Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 2/7] Bluetooth: AMP: Handle complete frames in l2cap
Date: Fri, 12 Oct 2012 17:10:00 +0300
Message-Id: <1350051005-6015-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check flags type in switch statement and handle new frame
type ACL_COMPLETE used for High Speed data over AMP.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/l2cap_core.c  |   15 ++++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 77b6a19..88cbbda 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -198,6 +198,7 @@ enum {
 #define ACL_START_NO_FLUSH	0x00
 #define ACL_CONT		0x01
 #define ACL_START		0x02
+#define ACL_COMPLETE		0x03
 #define ACL_ACTIVE_BCAST	0x04
 #define ACL_PICO_BCAST		0x08
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 207b4a8..38f311e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5579,6 +5579,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_hdr *hdr;
+	int len;
 
 	if (!conn)
 		conn = l2cap_conn_add(hcon, 0);
@@ -5588,10 +5590,10 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 	BT_DBG("conn %p len %d flags 0x%x", conn, skb->len, flags);
 
-	if (!(flags & ACL_CONT)) {
-		struct l2cap_hdr *hdr;
-		int len;
-
+	switch (flags) {
+	case ACL_START:
+	case ACL_START_NO_FLUSH:
+	case ACL_COMPLETE:
 		if (conn->rx_len) {
 			BT_ERR("Unexpected start frame (len %d)", skb->len);
 			kfree_skb(conn->rx_skb);
@@ -5633,7 +5635,9 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len = len - skb->len;
-	} else {
+		break;
+
+	case ACL_CONT:
 		BT_DBG("Cont: frag len %d (expecting %d)", skb->len, conn->rx_len);
 
 		if (!conn->rx_len) {
@@ -5661,6 +5665,7 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			l2cap_recv_frame(conn, conn->rx_skb);
 			conn->rx_skb = NULL;
 		}
+		break;
 	}
 
 drop:
-- 
1.7.9.5

