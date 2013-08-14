Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 1/2] Bluetooth: Fix SCO connection without socket
Date: Wed, 14 Aug 2013 19:29:01 +0200
Message-Id: <1376501342-30347-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If SCO socket is closed after ACL connection is established and before
SCO is established, it is not possible to cancel the ongoing
synchronous connection setup. When Synchronous Connection Complete
event is triggered, there will be no socket ready. Drop connection if
this is the case.

There is a side effect on this patch since it does not distinguish
between outgoing and incoming sco connections. An incoming SCO
connection with no acceptor will be dropped.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 include/net/bluetooth/hci_core.h |   10 +++++++---
 net/bluetooth/hci_event.c        |    5 +++--
 net/bluetooth/sco.c              |   14 +++++++++-----
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1f95e9b..1000553 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -376,7 +376,7 @@ extern int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb,
 			      u16 flags);
 
 extern int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-extern void sco_connect_cfm(struct hci_conn *hcon, __u8 status);
+extern int sco_connect_cfm(struct hci_conn *hcon, __u8 status);
 extern void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason);
 extern int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
 
@@ -843,8 +843,10 @@ static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	}
 }
 
-static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
+static inline int hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
 {
+	int canceled = 0;
+
 	switch (conn->type) {
 	case ACL_LINK:
 	case LE_LINK:
@@ -853,7 +855,7 @@ static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
 
 	case SCO_LINK:
 	case ESCO_LINK:
-		sco_connect_cfm(conn, status);
+		canceled = sco_connect_cfm(conn, status);
 		break;
 
 	default:
@@ -863,6 +865,8 @@ static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
 
 	if (conn->connect_cfm_cb)
 		conn->connect_cfm_cb(conn, status);
+
+	return canceled;
 }
 
 static inline int hci_proto_disconn_ind(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 491c5fb..e29ef13 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2879,6 +2879,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 {
 	struct hci_ev_sync_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
+	int canceled;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -2922,8 +2923,8 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		break;
 	}
 
-	hci_proto_connect_cfm(conn, ev->status);
-	if (ev->status)
+	canceled = hci_proto_connect_cfm(conn, ev->status);
+	if (canceled || ev->status)
 		hci_conn_del(conn);
 
 unlock:
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 1170b6e..e94e654 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -979,7 +979,7 @@ static void sco_chan_del(struct sock *sk, int err)
 	sock_set_flag(sk, SOCK_ZAPPED);
 }
 
-static void sco_conn_ready(struct sco_conn *conn)
+static int sco_conn_ready(struct sco_conn *conn)
 {
 	struct sock *parent;
 	struct sock *sk = conn->sk;
@@ -998,7 +998,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 		parent = sco_get_sock_listen(conn->src);
 		if (!parent) {
 			sco_conn_unlock(conn);
-			return;
+			return 1;
 		}
 
 		bh_lock_sock(parent);
@@ -1008,7 +1008,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 		if (!sk) {
 			bh_unlock_sock(parent);
 			sco_conn_unlock(conn);
-			return;
+			return 0;
 		}
 
 		sco_sock_init(sk, parent);
@@ -1031,6 +1031,8 @@ static void sco_conn_ready(struct sco_conn *conn)
 
 		sco_conn_unlock(conn);
 	}
+
+	return 0;
 }
 
 /* ----- SCO interface with lower layer (HCI) ----- */
@@ -1061,7 +1063,7 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	return lm;
 }
 
-void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
+int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 	if (!status) {
@@ -1069,9 +1071,11 @@ void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 		conn = sco_conn_add(hcon);
 		if (conn)
-			sco_conn_ready(conn);
+			return sco_conn_ready(conn);
 	} else
 		sco_conn_del(hcon, bt_to_errno(status));
+
+	return 0;
 }
 
 void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
-- 
1.7.9.5

