Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 13/17] Bluetooth: A2MP: Process A2MP Create Physlink Request
Date: Fri, 18 May 2012 17:25:46 +0300
Message-Id: <1337351150-20526-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Placeholder for A2MP Create Physlink Request.
Handles requests with invalid controler id as shown below:

...
> ACL data: handle 11 flags 0x02 dlen 50
    A2MP: Create Physical Link req: local id 1 remote id 85
      Assoc data:
        <skipped>
< ACL data: handle 11 flags 0x00 dlen 15
    A2MP: Create Physical Link rsp: local id 85 remote id 1 status 1
      Invalid Controller ID
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 5498d67..ca37116 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -244,6 +244,42 @@ clean:
 	return 0;
 }
 
+static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
+				   struct a2mp_cmd *hdr)
+{
+	struct a2mp_physlink_req *req = (struct a2mp_physlink_req *) skb->data;
+	struct a2mp_physlink_rsp rsp;
+	struct hci_dev *hdev;
+
+	if (le16_to_cpu(hdr->len) < sizeof(*req))
+		return -EINVAL;
+
+	BT_DBG("local_id %d, remote_id %d", req->local_id, req->remote_id);
+
+	rsp.local_id = req->remote_id;
+	rsp.remote_id = req->local_id;
+
+	hdev = hci_dev_get(req->remote_id);
+	if (!hdev || hdev->amp_type != HCI_AMP) {
+		rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
+		goto send_rsp;
+	}
+
+	/* TODO process physlink create */
+
+	rsp.status = A2MP_STATUS_SUCCESS;
+
+send_rsp:
+	if (hdev)
+		hci_dev_put(hdev);
+
+	a2mp_send(mgr, A2MP_CREATEPHYSLINK_RSP, hdr->ident, sizeof(rsp),
+		  &rsp);
+
+	skb_pull(skb, le16_to_cpu(hdr->len));
+	return 0;
+}
+
 /* Handle A2MP signalling */
 static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 {
@@ -290,6 +326,9 @@ static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 			break;
 
 		case A2MP_CREATEPHYSLINK_REQ:
+			err = a2mp_createphyslink_req(mgr, skb, hdr);
+			break;
+
 		case A2MP_DISCONNPHYSLINK_REQ:
 		case A2MP_CHANGE_RSP:
 		case A2MP_DISCOVER_RSP:
-- 
1.7.9.5

