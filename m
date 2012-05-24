Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Define and use PSM identifiers
Date: Thu, 24 May 2012 15:42:50 +0300
Message-Id: <1337863371-2584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define assigned Protocol and Service Multiplexor (PSM) identifiers
and use them instead of magic numbers.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    4 ++++
 net/bluetooth/l2cap_core.c    |    4 ++--
 net/bluetooth/l2cap_sock.c    |    4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0142257..f44344b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -229,6 +229,10 @@ struct l2cap_conn_rsp {
 	__le16     status;
 } __packed;
 
+/* protocol/service multiplexer (PSM) */
+#define L2CAP_PSM_SDP		0x0001
+#define L2CAP_PSM_RFCOMM	0x0003
+
 /* channel indentifier */
 #define L2CAP_CID_SIGNALING	0x0001
 #define L2CAP_CID_CONN_LESS	0x0002
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c9e6ae4..65c3f4e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -648,7 +648,7 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 		default:
 			return HCI_AT_NO_BONDING;
 		}
-	} else if (chan->psm == cpu_to_le16(0x0001)) {
+	} else if (chan->psm == __constant_cpu_to_le16(L2CAP_PSM_SDP)) {
 		if (chan->sec_level == BT_SECURITY_LOW)
 			chan->sec_level = BT_SECURITY_SDP;
 
@@ -3393,7 +3393,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	lock_sock(parent);
 
 	/* Check if the ACL is secure enough (if not SDP) */
-	if (psm != cpu_to_le16(0x0001) &&
+	if (psm != __constant_cpu_to_le16(L2CAP_PSM_SDP) &&
 				!hci_conn_check_link_mode(conn->hcon)) {
 		conn->disc_reason = HCI_ERROR_AUTH_FAILURE;
 		result = L2CAP_CR_SEC_BLOCK;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4d36605..d244361 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -88,8 +88,8 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	if (err < 0)
 		goto done;
 
-	if (__le16_to_cpu(la.l2_psm) == 0x0001 ||
-				__le16_to_cpu(la.l2_psm) == 0x0003)
+	if (__le16_to_cpu(la.l2_psm) == L2CAP_PSM_SDP ||
+	    __le16_to_cpu(la.l2_psm) == L2CAP_PSM_RFCOMM)
 		chan->sec_level = BT_SECURITY_SDP;
 
 	bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
-- 
1.7.9.5

