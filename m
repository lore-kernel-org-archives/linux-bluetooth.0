Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 15/21] Bluetooth: A2MP: Process A2MP Get Info Request
Date: Thu, 10 Nov 2011 16:54:22 +0200
Message-Id: <1320936868-7978-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Example of trace log for invalid controller id is shown below:
...
> ACL data: handle 11 flags 0x02 dlen 13
    A2MP: Get Info req: id 238
< ACL data: handle 11 flags 0x00 dlen 30
    A2MP: Get Info rsp: id 238 status (1) Invalid Controller ID
      total bandwidth -381650496
      max guaranteed bandwidth -274362188
      min latency -158843144
      pal capabilities 0x9750
      assoc size 49478
...
Note that If the Status field is set to Invalid Controller ID all subsequent
fields in the AMP Get Info Response shall be ignored by the receiver.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index c69e949..3cef720 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -184,6 +184,38 @@ static inline int a2mp_change_notify(struct amp_mgr *mgr, struct sk_buff *skb,
 	return 0;
 }
 
+static inline int a2mp_getinfo_req(struct amp_mgr *mgr, struct sk_buff *skb,
+							struct a2mp_cmd *hdr)
+{
+	struct a2mp_info_req *req  = (struct a2mp_info_req *)skb->data;
+	struct hci_dev *hdev;
+	struct a2mp_info_rsp rsp;
+
+	if (le16_to_cpu(hdr->len) < sizeof(*req))
+		return -EINVAL;
+
+	rsp.id = req->id;
+	rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
+
+	hdev = hci_dev_get(req->id);
+	if (hdev && hdev->amp_type != HCI_BREDR) {
+		rsp.status = 0;
+		rsp.total_bw = cpu_to_le32(hdev->amp_total_bw);
+		rsp.max_bw = cpu_to_le32(hdev->amp_max_bw);
+		rsp.min_latency = cpu_to_le32(hdev->amp_min_latency);
+		rsp.pal_cap = cpu_to_le16(hdev->amp_pal_cap);
+		rsp.assoc_size = cpu_to_le16(hdev->amp_assoc_size);
+	}
+
+	if (hdev)
+		hci_dev_put(hdev);
+
+	a2mp_send(mgr, A2MP_GETINFO_RSP, hdr->ident, sizeof(rsp), &rsp);
+
+	skb_pull(skb, sizeof(*req));
+	return 0;
+}
+
 /* Handle A2MP signalling */
 void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 {
@@ -222,6 +254,9 @@ void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 			break;
 
 		case A2MP_GETINFO_REQ:
+			err = a2mp_getinfo_req(mgr, skb, hdr);
+			break;
+
 		case A2MP_GETAMPASSOC_REQ:
 		case A2MP_CREATEPHYSLINK_REQ:
 		case A2MP_DISCONNPHYSLINK_REQ:
-- 
1.7.4.1

