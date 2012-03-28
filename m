Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv6 16/26] Bluetooth: A2MP: Process A2MP Create Physlink Request
Date: Wed, 28 Mar 2012 16:31:39 +0300
Message-Id: <1332941509-21345-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 95f5bcd..a5f831b 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -245,6 +245,42 @@ clean:
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
@@ -291,6 +327,9 @@ static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 			break;
 
 		case A2MP_CREATEPHYSLINK_REQ:
+			err = a2mp_createphyslink_req(mgr, skb, hdr);
+			break;
+
 		case A2MP_DISCONNPHYSLINK_REQ:
 		case A2MP_CHANGE_RSP:
 		case A2MP_DISCOVER_RSP:
-- 
1.7.9.1

