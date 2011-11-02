Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 14/20] Bluetooth: A2MP: process A2MP Get Info Request
Date: Wed,  2 Nov 2011 16:02:42 +0200
Message-Id: <1320242568-372-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 3dd3cdb..af3f2db 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -178,6 +178,40 @@ static inline int a2mp_change_notify(struct amp_mgr *mgr, struct sk_buff *skb,
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
+	rsp.status = 1;
+
+	BT_DBG("id %d", req->id);
+	hdev = hci_dev_get(AMP_HCI_ID(req->id));
+
+	if (hdev && hdev->amp_type != HCI_BREDR) {
+		rsp.status = 0;
+		rsp.total_bw = cpu_to_le32(hdev->amp_total_bw);
+		rsp.max_bw = cpu_to_le32(hdev->amp_max_bw);
+		rsp.min_latency = cpu_to_le32(hdev->amp_min_latency);
+		rsp.pal_cap = cpu_to_le16(hdev->amp_pal_cap);
+		rsp.assoc_size = cpu_to_le16(hdev->amp_assoc_size);
+	}
+
+	/* TODO send A2MP_GETINFO_RSP */
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
@@ -216,6 +250,9 @@ void a2mp_receive(struct sock *sk, struct sk_buff *skb)
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

