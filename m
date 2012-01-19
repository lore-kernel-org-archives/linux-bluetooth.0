Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 24/34] Bluetooth: A2MP: Process A2MP Disc Physlink Request
Date: Thu, 19 Jan 2012 11:20:13 +0200
Message-Id: <1326964823-26747-25-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index ea881a9..2d821fc 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -258,6 +258,40 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	return 0;
 }
 
+static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
+							struct a2mp_cmd *hdr)
+{
+	struct a2mp_physlink_req *req = (struct a2mp_physlink_req *)skb->data;
+	struct a2mp_physlink_rsp rsp;
+	struct hci_dev *hdev;
+
+	if (le16_to_cpu(hdr->len) < sizeof(*req))
+		return -EINVAL;
+
+	rsp.local_id = req->remote_id;
+	rsp.remote_id = req->local_id;
+	rsp.status = A2MP_STATUS_SUCCESS;
+
+	BT_DBG("local_id %d remote_id %d", rsp.local_id, rsp.remote_id);
+
+	hdev = hci_dev_get(req->local_id);
+	if (!hdev) {
+		rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
+		goto send_rsp;
+	}
+
+	/* TODO Disconnect Phys Link here */
+
+send_rsp:
+	a2mp_send(mgr, A2MP_DISCONNPHYSLINK_RSP, hdr->ident, sizeof(rsp), &rsp);
+
+	if (hdev)
+		hci_dev_put(hdev);
+
+	skb_pull(skb, sizeof(*req));
+	return 0;
+}
+
 /* Handle A2MP signalling */
 int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 {
@@ -306,6 +340,9 @@ int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
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

