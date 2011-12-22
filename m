Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 15/20] Bluetooth: A2MP: Process A2MP Get AMP Assoc Request
Date: Thu, 22 Dec 2011 13:06:21 +0200
Message-Id: <1324551986-29431-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Example trace when receiving AMP Assoc Request with wrong AMP id.
...
> ACL data: handle 11 flags 0x02 dlen 13
    A2MP: Get AMP Assoc req: id 238
< ACL data: handle 11 flags 0x00 dlen 14
    A2MP: Get AMP Assoc rsp: id 238 status (1) Invalid Controller ID
      assoc data:
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 666d8e5..a6891b0 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -213,6 +213,35 @@ static inline int a2mp_getinfo_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	return 0;
 }
 
+static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
+							struct a2mp_cmd *hdr)
+{
+	struct a2mp_amp_assoc_req *req =
+				(struct a2mp_amp_assoc_req *)skb->data;
+	struct hci_dev *hdev;
+
+	if (le16_to_cpu(hdr->len) < sizeof(*req))
+		return -EINVAL;
+
+	BT_DBG("id %d", req->id);
+
+	hdev = hci_dev_get(req->id);
+	if (!hdev || hdev->amp_type == HCI_BREDR) {
+		struct a2mp_amp_assoc_rsp rsp;
+		rsp.id = req->id;
+		rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
+
+		a2mp_send(mgr, A2MP_GETAMPASSOC_RSP, hdr->ident, sizeof(rsp),
+									&rsp);
+	}
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
@@ -255,6 +284,9 @@ void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 			break;
 
 		case A2MP_GETAMPASSOC_REQ:
+			err = a2mp_getampassoc_req(mgr, skb, hdr);
+			break;
+
 		case A2MP_CREATEPHYSLINK_REQ:
 		case A2MP_DISCONNPHYSLINK_REQ:
 		case A2MP_CHANGE_RSP:
-- 
1.7.4.1

