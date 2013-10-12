Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Limit security mode 4 level 0 to connection oriented channels
Date: Sat, 12 Oct 2013 07:19:31 -0700
Message-Id: <1381587572-63593-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The exception for certain PSM channels when it comes to security
mode 4 level 0 should only be checked when actually a connection
oriented channel is established.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 24 +++++++++++++++---------
 net/bluetooth/l2cap_sock.c | 10 +++++++---
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ab976a1..cc51cb8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -677,7 +677,8 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 {
-	if (chan->chan_type == L2CAP_CHAN_RAW) {
+	switch (chan->chan_type) {
+	case L2CAP_CHAN_RAW:
 		switch (chan->sec_level) {
 		case BT_SECURITY_HIGH:
 			return HCI_AT_DEDICATED_BONDING_MITM;
@@ -686,15 +687,19 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 		default:
 			return HCI_AT_NO_BONDING;
 		}
-	} else if (chan->psm == __constant_cpu_to_le16(L2CAP_PSM_SDP)) {
-		if (chan->sec_level == BT_SECURITY_LOW)
-			chan->sec_level = BT_SECURITY_SDP;
+		break;
+	case L2CAP_CHAN_CONN_ORIENTED:
+		if (chan->psm == __constant_cpu_to_le16(L2CAP_PSM_SDP)) {
+			if (chan->sec_level == BT_SECURITY_LOW)
+				chan->sec_level = BT_SECURITY_SDP;
 
-		if (chan->sec_level == BT_SECURITY_HIGH)
-			return HCI_AT_NO_BONDING_MITM;
-		else
-			return HCI_AT_NO_BONDING;
-	} else {
+			if (chan->sec_level == BT_SECURITY_HIGH)
+				return HCI_AT_NO_BONDING_MITM;
+			else
+				return HCI_AT_NO_BONDING;
+		}
+		/* fall through */
+	default:
 		switch (chan->sec_level) {
 		case BT_SECURITY_HIGH:
 			return HCI_AT_GENERAL_BONDING_MITM;
@@ -703,6 +708,7 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 		default:
 			return HCI_AT_NO_BONDING;
 		}
+		break;
 	}
 }
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 69e42db..bee98eb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -100,9 +100,13 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	if (err < 0)
 		goto done;
 
-	if (__le16_to_cpu(la.l2_psm) == L2CAP_PSM_SDP ||
-	    __le16_to_cpu(la.l2_psm) == L2CAP_PSM_RFCOMM)
-		chan->sec_level = BT_SECURITY_SDP;
+	switch (chan->chan_type) {
+	case L2CAP_CHAN_CONN_ORIENTED:
+		if (__le16_to_cpu(la.l2_psm) == L2CAP_PSM_SDP ||
+		    __le16_to_cpu(la.l2_psm) == L2CAP_PSM_RFCOMM)
+			chan->sec_level = BT_SECURITY_SDP;
+		break;
+	}
 
 	bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
 
-- 
1.8.3.1

