Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH] Add support for sending L2CAP S-frames.
Date: Wed, 29 Apr 2009 21:45:29 -0400
Message-Id: <1241055933-12343-2-git-send-email-ngh@isomerica.net>
In-Reply-To: <1241055933-12343-1-git-send-email-ngh@isomerica.net>
References: <1241055933-12343-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

This patch creates the function l2cap_send_sframe() which builds a sk_buff
contains the specified control field and then sends the frame over the ACL
connection.
---
 net/bluetooth/l2cap.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index bc7280f..a68a0cf 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -69,6 +69,7 @@ static void l2cap_sock_kill(struct sock *sk);
 
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				u8 code, u8 ident, u16 dlen, void *data);
+static struct sk_buff *l2cap_build_sframe(struct l2cap_pinfo *pi, u16 control);
 
 /* ---- L2CAP timers ---- */
 static void l2cap_sock_timeout(unsigned long arg)
@@ -333,6 +334,18 @@ static inline int l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16
 	return hci_send_acl(conn->hcon, skb, 0);
 }
 
+static inline int l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
+{
+	struct sk_buff *skb = l2cap_build_sframe(pi, control);
+
+	BT_DBG("control 0x%2.2x", control);
+
+	if (!skb)
+		return -ENOMEM;
+
+	return hci_send_acl(pi->conn->hcon, skb, 0);
+}
+
 static void l2cap_do_start(struct sock *sk)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
@@ -1752,6 +1765,38 @@ fail:
 	return NULL;
 }
 
+static struct sk_buff *l2cap_build_sframe(struct l2cap_pinfo *pi, u16 control)
+{
+	struct sk_buff *skb;
+	struct l2cap_hdr *lh;
+	int len;
+
+	BT_DBG("pi %p, control 0x%2.2x", pi, control);
+
+	len = L2CAP_HDR_SIZE + 2;
+	control |= L2CAP_CONTROL_TYPE_MASK;
+
+	if (pi->fcs);
+		len += 2;
+
+	skb = bt_skb_alloc(len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
+	lh->len = cpu_to_le16(pi->fcs ? 4 : 2);
+	lh->cid = cpu_to_le16(pi->dcid);
+
+	put_unaligned(control, (__le16 *)skb_put(skb, 2));
+	if (pi->fcs)
+	{
+		u16 fcs = crc16(0, (u8 *)lh, len);
+		put_unaligned(fcs, (__le16 *)skb_put(skb, 2));
+	}
+
+	return skb;
+}
+
 static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen, unsigned long *val)
 {
 	struct l2cap_conf_opt *opt = *ptr;
-- 
1.6.0.6

