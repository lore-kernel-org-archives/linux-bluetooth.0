Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 14/17] Bluetooth: A2MP: Process A2MP Disc Physlink Request
Date: Tue, 29 May 2012 13:59:14 +0300
Message-Id: <1338289158-25655-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Placeholder for A2MP Disconnect Physlink Request.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 870ef009..0d3e0d9 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -280,6 +280,39 @@ send_rsp:
 	return 0;
 }
 
+static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
+				 struct a2mp_cmd *hdr)
+{
+	struct a2mp_physlink_req *req = (void *) skb->data;
+	struct a2mp_physlink_rsp rsp;
+	struct hci_dev *hdev;
+
+	if (le16_to_cpu(hdr->len) < sizeof(*req))
+		return -EINVAL;
+
+	BT_DBG("local_id %d remote_id %d", req->local_id, req->remote_id);
+
+	rsp.local_id = req->remote_id;
+	rsp.remote_id = req->local_id;
+	rsp.status = A2MP_STATUS_SUCCESS;
+
+	hdev = hci_dev_get(req->local_id);
+	if (!hdev) {
+		rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
+		goto send_rsp;
+	}
+
+	/* TODO Disconnect Phys Link here */
+
+	hci_dev_put(hdev);
+
+send_rsp:
+	a2mp_send(mgr, A2MP_DISCONNPHYSLINK_RSP, hdr->ident, sizeof(rsp), &rsp);
+
+	skb_pull(skb, sizeof(*req));
+	return 0;
+}
+
 /* Handle A2MP signalling */
 static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
@@ -330,6 +363,9 @@ static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 			break;
 
 		case A2MP_DISCONNPHYSLINK_REQ:
+			err = a2mp_discphyslink_req(mgr, skb, hdr);
+			break;
+
 		case A2MP_CHANGE_RSP:
 		case A2MP_DISCOVER_RSP:
 		case A2MP_GETINFO_RSP:
-- 
1.7.9.5

