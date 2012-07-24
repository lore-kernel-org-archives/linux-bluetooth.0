Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 20/20] Bluetooth: AMP: Send Create Chan Req
Date: Tue, 24 Jul 2012 16:22:01 +0300
Message-Id: <1343136121-22476-21-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Send L2CAP Create Channel Request when receiving HCI Physical
Link Complete event.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    5 +++++
 net/bluetooth/hci_event.c        |    2 ++
 net/bluetooth/l2cap_core.c       |   28 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 02ec147..444838f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -380,6 +380,7 @@ extern void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason);
 extern int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt);
 extern int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb,
 			      u16 flags);
+extern void l2cap_chan_create_cfm(struct hci_conn *hcon, u8 status);
 
 extern int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 extern void sco_connect_cfm(struct hci_conn *hcon, __u8 status);
@@ -786,6 +787,10 @@ static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
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
index cfe3ef3..379db6d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3436,6 +3436,8 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 
 		hci_conn_hold_device(conn);
 		hci_conn_add_sysfs(conn);
+
+		hci_proto_connect_cfm(conn, ev->status);
 	} else {
 		BT_ERR("Cannot add connection");
 	}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 165b810..56fc0f2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -38,6 +38,7 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
 #include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/pal.h>
 
 bool disable_ertm;
 
@@ -1015,6 +1016,19 @@ void l2cap_send_conn_req(struct l2cap_chan *chan)
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
+	l2cap_send_cmd(conn, chan->ident, L2CAP_CREATE_CHAN_REQ,
+		       sizeof(req), &req);
+}
+
 static void l2cap_chan_ready(struct l2cap_chan *chan)
 {
 	/* This clears all conf flags, including CONF_NOT_COMPLETE */
@@ -5430,7 +5444,21 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 		l2cap_conn_put(conn);
 	}
+}
+
+void l2cap_chan_create_cfm(struct hci_conn *hcon, u8 status)
+{
+	struct amp_mgr *mgr = hcon->amp_mgr;
+	struct hci_dev *hdev = hcon->hdev;
+	struct phy_link *plink;
+
+	plink = phylink_lookup(mgr, hdev->id, 0);
+	if (!plink)
+		return;
+
+	l2cap_send_chan_create_req(mgr->bredr_chan, plink->remote_id);
 
+	phylink_put(plink);
 }
 
 int l2cap_disconn_ind(struct hci_conn *hcon)
-- 
1.7.9.5

