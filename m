Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 2 Feb 2010 15:50:03 -0600
Message-ID: <8a7a8d7b1002021350o3c80c7d9p948365ea983a0d89@mail.gmail.com>
Subject: [PATCH 1/1] Bluetooth:L2CAP check FEAT success
From: Liejun Tao <liejuntao001@gmail.com>
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Resolve the connection issue with Blackbery 8900, if encryption is ON.
If encryption turned on indication comes when L2CAP is in "Information
Request" process, there will be 2 l2cap_conn_req, and one is denied
from remote, cause the connection dropped.
This patch applies to kernel version 2.6.29. 2.6.32 should have same issue.
Please review.

>From ad6bc3dac4d60c3a52034ed420a656b64cdfd809 Mon Sep 17 00:00:00 2001
From: Liejun Tao <L.J.Tao@motorola.com>
Date: Mon, 1 Feb 2010 16:23:11 -0600
Subject: [PATCH] Bluetooth:L2CAP check FEAT success

L2CAP Information Response carries optional data only if result is Success
avoid Info_REQ L2CAP_IT_FIXED_CHAN if FEAT is Not Supported
If L2CAP is in Info_REQ process, security_cfm should not issue another
L2CAP_CONN_REQ

Signed-off-by: Liejun Tao <L.J.Tao@motorola.com>
---
 net/bluetooth/l2cap.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index ca4d3b4..5acf8b8 100755
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2227,7 +2227,8 @@ static inline int l2cap_information_rsp(struct
l2cap_conn *conn, struct l2cap_cm

 	del_timer(&conn->info_timer);

-	if (type == L2CAP_IT_FEAT_MASK) {
+	/* only continue info req if FEAT success */
+	if (type == L2CAP_IT_FEAT_MASK && !result) {
 		conn->feat_mask = get_unaligned_le32(rsp->data);

 		if (conn->feat_mask & 0x0080) {
@@ -2244,6 +2245,12 @@ static inline int l2cap_information_rsp(struct
l2cap_conn *conn, struct l2cap_cm

 			l2cap_conn_start(conn);
 		}
+	} else if (type == L2CAP_IT_FEAT_MASK && result) {
+		/* FEAT is not supported */
+		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
+		conn->info_ident = 0;
+
+		l2cap_conn_start(conn);
 	} else if (type == L2CAP_IT_FIXED_CHAN) {
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
@@ -2562,7 +2569,15 @@ static int l2cap_security_cfm(struct hci_conn
*hcon, u8 status, u8 encrypt)
 		}

 		if (sk->sk_state == BT_CONNECT) {
-			if (!status) {
+			if (!status && (conn->info_state &
+					L2CAP_INFO_FEAT_MASK_REQ_SENT)) {
+				if (!(conn->info_state &
+					L2CAP_INFO_FEAT_MASK_REQ_DONE)) {
+					BT_DBG("INFO pending");
+					bh_unlock_sock(sk);
+					continue;
+				}
+			} else if (!status) {
 				struct l2cap_conn_req req;
 				req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
 				req.psm  = l2cap_pi(sk)->psm;
-- 
1.6.0.4
