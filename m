Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 17/20] Bluetooth: A2MP: process A2MP Disc Physlink Request
Date: Wed,  2 Nov 2011 16:02:45 +0200
Message-Id: <1320242568-372-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index b584465..662ada7 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -245,6 +245,45 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	return 0;
 }
 
+static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
+							struct a2mp_cmd *hdr)
+{
+	struct a2mp_physlink_req *req = (struct a2mp_physlink_req *)skb->data;
+	struct a2mp_physlink_rsp rsp;
+	struct hci_dev *hdev;
+	struct hci_conn *conn;
+
+	if (le16_to_cpu(hdr->len) < sizeof(*req))
+		return -EINVAL;
+
+	rsp.local_id = req->remote_id;
+	rsp.remote_id = req->local_id;
+	rsp.status = 0;
+
+	BT_DBG("local_id %d remote_id %d", rsp.local_id, rsp.remote_id);
+	hdev = hci_dev_get(AMP_HCI_ID(req->local_id));
+	if (!hdev) {
+		rsp.status = 1; /* Invalid Controller ID */
+		goto send_rsp;
+	}
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					&mgr->l2cap_conn->hcon->dst);
+	if (conn) {
+		BT_DBG("conn %p", conn);
+		hci_acl_disconn(conn, 0x13);
+	}
+
+send_rsp:
+	/* TODO send A2MP_DISCONNPHYSLINK_RSP */
+
+	if (hdev)
+		hci_dev_put(hdev);
+
+	skb_pull(skb, sizeof(*req));
+	return 0;
+}
+
 /* Handle A2MP signalling */
 void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 {
@@ -295,6 +334,9 @@ void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 			break;
 
 		case A2MP_DISCONNPHYSLINK_REQ:
+			err = a2mp_discphyslink_req(mgr, skb, hdr);
+			break;
+
 		case A2MP_CHANGE_RSP:
 		case A2MP_DISCOVER_RSP:
 		case A2MP_GETINFO_RSP:
-- 
1.7.4.1

