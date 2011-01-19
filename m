Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: ville.tervo@nokia.com
Subject: [PATCH 3/5] Bluetooth: Create a unified auth_type evaluation function
Date: Wed, 19 Jan 2011 12:06:50 +0530
Message-Id: <1295419012-25717-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
References: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The logic for determining the needed auth_type for an L2CAP socket is
rather complicated and has so far been duplicated in
l2cap_check_security as well as l2cap_do_connect. Additionally the
l2cap_check_security code was completely missing the handling of
SOCK_RAW type sockets. This patch creates a unified function for the
evaluation and makes l2cap_do_connect and l2cap_check_security use that
function.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/l2cap.c |   77 ++++++++++++++++++-------------------------------
 1 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 4fd88eb..ae227bf 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -305,33 +305,44 @@ static void l2cap_chan_del(struct sock *sk, int err)
 	}
 }
 
-/* Service level security */
-static inline int l2cap_check_security(struct sock *sk)
+static inline u8 l2cap_get_auth_type(struct sock *sk)
 {
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-	__u8 auth_type;
+	if (sk->sk_type == SOCK_RAW) {
+		switch (l2cap_pi(sk)->sec_level) {
+		case BT_SECURITY_HIGH:
+			return HCI_AT_DEDICATED_BONDING_MITM;
+		case BT_SECURITY_MEDIUM:
+			return HCI_AT_DEDICATED_BONDING;
+		default:
+			return HCI_AT_NO_BONDING;
+		}
+	} else if (l2cap_pi(sk)->psm == cpu_to_le16(0x0001)) {
+		if (l2cap_pi(sk)->sec_level == BT_SECURITY_LOW)
+			l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
 
-	if (l2cap_pi(sk)->psm == cpu_to_le16(0x0001)) {
 		if (l2cap_pi(sk)->sec_level == BT_SECURITY_HIGH)
-			auth_type = HCI_AT_NO_BONDING_MITM;
+			return HCI_AT_NO_BONDING_MITM;
 		else
-			auth_type = HCI_AT_NO_BONDING;
-
-		if (l2cap_pi(sk)->sec_level == BT_SECURITY_LOW)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
+			return HCI_AT_NO_BONDING;
 	} else {
 		switch (l2cap_pi(sk)->sec_level) {
 		case BT_SECURITY_HIGH:
-			auth_type = HCI_AT_GENERAL_BONDING_MITM;
-			break;
+			return HCI_AT_GENERAL_BONDING_MITM;
 		case BT_SECURITY_MEDIUM:
-			auth_type = HCI_AT_GENERAL_BONDING;
-			break;
+			return HCI_AT_GENERAL_BONDING;
 		default:
-			auth_type = HCI_AT_NO_BONDING;
-			break;
+			return HCI_AT_NO_BONDING;
 		}
 	}
+}
+
+/* Service level security */
+static inline int l2cap_check_security(struct sock *sk)
+{
+	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	__u8 auth_type;
+
+	auth_type = l2cap_get_auth_type(sk);
 
 	return hci_conn_security(conn->hcon, l2cap_pi(sk)->sec_level,
 								auth_type);
@@ -1068,39 +1079,7 @@ static int l2cap_do_connect(struct sock *sk)
 
 	err = -ENOMEM;
 
-	if (sk->sk_type == SOCK_RAW) {
-		switch (l2cap_pi(sk)->sec_level) {
-		case BT_SECURITY_HIGH:
-			auth_type = HCI_AT_DEDICATED_BONDING_MITM;
-			break;
-		case BT_SECURITY_MEDIUM:
-			auth_type = HCI_AT_DEDICATED_BONDING;
-			break;
-		default:
-			auth_type = HCI_AT_NO_BONDING;
-			break;
-		}
-	} else if (l2cap_pi(sk)->psm == cpu_to_le16(0x0001)) {
-		if (l2cap_pi(sk)->sec_level == BT_SECURITY_HIGH)
-			auth_type = HCI_AT_NO_BONDING_MITM;
-		else
-			auth_type = HCI_AT_NO_BONDING;
-
-		if (l2cap_pi(sk)->sec_level == BT_SECURITY_LOW)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
-	} else {
-		switch (l2cap_pi(sk)->sec_level) {
-		case BT_SECURITY_HIGH:
-			auth_type = HCI_AT_GENERAL_BONDING_MITM;
-			break;
-		case BT_SECURITY_MEDIUM:
-			auth_type = HCI_AT_GENERAL_BONDING;
-			break;
-		default:
-			auth_type = HCI_AT_NO_BONDING;
-			break;
-		}
-	}
+	auth_type = l2cap_get_auth_type(sk);
 
 	hcon = hci_connect(hdev, ACL_LINK, dst,
 					l2cap_pi(sk)->sec_level, auth_type);
-- 
1.7.2.3

