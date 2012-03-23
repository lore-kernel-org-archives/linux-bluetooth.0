Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv5 17/26] Bluetooth: A2MP: Process A2MP Disc Physlink Request
Date: Fri, 23 Mar 2012 18:13:57 +0200
Message-Id: <1332519246-16656-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Placeholder for A2MP Disconnect Physlink Request.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index d2d292a..b2d0153 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -254,6 +254,40 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	return 0;
 }
 
+static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
+				 struct a2mp_cmd *hdr)
+{
+	struct a2mp_physlink_req *req = (struct a2mp_physlink_req *) skb->data;
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
 static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 {
@@ -304,6 +338,9 @@ static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 			break;
 
 		case A2MP_DISCONNPHYSLINK_REQ:
+			err = a2mp_discphyslink_req(mgr, skb, hdr);
+			break;
+
 		case A2MP_CHANGE_RSP:
 		case A2MP_DISCOVER_RSP:
 		case A2MP_GETINFO_RSP:
-- 
1.7.9.1

