Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 24/26] Bluetooth: AMP: Send Create Chan Req
Date: Fri, 17 Aug 2012 17:33:19 +0300
Message-Id: <1345214001-7053-25-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Send L2CAP Create Channel Request when receiving HCI Physical
Link Complete event.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    5 +++++
 net/bluetooth/hci_event.c        |   11 +++++++++++
 net/bluetooth/l2cap_core.c       |   22 ++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ba9a05f..1be2c81 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -381,6 +381,7 @@ extern void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason);
 extern int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt);
 extern int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb,
 			      u16 flags);
+extern void l2cap_chan_create_cfm(struct hci_conn *hcon, u8 status);
 
 extern int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 extern void sco_connect_cfm(struct hci_conn *hcon, __u8 status);
@@ -791,6 +792,10 @@ static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
 		sco_connect_cfm(conn, status);
 		break;
 
+	case AMP_LINK:
+		l2cap_chan_create_cfm(conn, status);
+		break;
+
 	default:
 		BT_ERR("unknown link type %d", conn->type);
 		break;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 313bbad..cdb32da 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3454,6 +3454,17 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 
 	hci_dev_unlock(hdev);
 
+	if (conn) {
+		struct hci_conn *bredr_conn = plink->mgr->l2cap_conn->hcon;
+		struct hci_dev *bredr_hdev = bredr_conn->hdev;
+
+		if (bredr_hdev) {
+			hci_dev_hold(bredr_hdev);
+			l2cap_chan_create_cfm(bredr_conn, plink->remote_id);
+			hci_dev_put(bredr_hdev);
+		}
+	}
+
 	phylink_put(plink);
 }
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c34fcd0..12da90b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -38,6 +38,7 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
 #include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/pal.h>
 
 bool disable_ertm;
 
@@ -1032,6 +1033,21 @@ void l2cap_send_conn_req(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ, sizeof(req), &req);
 }
 
+static void l2cap_send_chan_create_req(struct l2cap_chan *chan, u8 remote_id)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct l2cap_create_chan_req req;
+
+	req.scid = cpu_to_le16(chan->scid);
+	req.psm = chan->psm;
+	req.amp_id = remote_id;
+
+	chan->ident = l2cap_get_ident(conn);
+
+	l2cap_send_cmd(conn, chan->ident, L2CAP_CREATE_CHAN_REQ,
+		       sizeof(req), &req);
+}
+
 static void l2cap_chan_ready(struct l2cap_chan *chan)
 {
 	/* This clears all conf flags, including CONF_NOT_COMPLETE */
@@ -5447,7 +5463,13 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 		l2cap_conn_put(conn);
 	}
+}
+
+void l2cap_chan_create_cfm(struct hci_conn *hcon, u8 remote_id)
+{
+	struct amp_mgr *mgr = hcon->amp_mgr;
 
+	l2cap_send_chan_create_req(mgr->bredr_chan, remote_id);
 }
 
 int l2cap_disconn_ind(struct hci_conn *hcon)
-- 
1.7.9.5

