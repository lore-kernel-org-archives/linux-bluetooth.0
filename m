Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv7 14/23] Bluetooth: A2MP: Process A2MP Disc Physlink Request
Date: Fri, 20 Apr 2012 14:09:42 +0300
Message-Id: <1334920191-29308-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Placeholder for A2MP Disconnect Physlink Request.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 6cb7161..af22981 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -280,6 +280,39 @@ send_rsp:
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
 static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 {
@@ -330,6 +363,9 @@ static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
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

