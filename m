Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 13/26] Bluetooth: A2MP: Process A2MP Get AMP Assoc Rsp
Date: Fri, 17 Aug 2012 17:33:08 +0300
Message-Id: <1345214001-7053-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving A2MP Get AMP Assoc Response save assoc data to remote
AMP controller list and prepare for creating physical link.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 5a238df..6f719d3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -331,6 +331,60 @@ done:
 	return 0;
 }
 
+static int a2mp_getampassoc_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
+				struct a2mp_cmd *hdr)
+{
+	struct a2mp_amp_assoc_rsp *rsp = (void *) skb->data;
+	u16 len = le16_to_cpu(hdr->len);
+	struct hci_dev *hdev;
+	struct amp_ctrl *ctrl;
+	struct phy_link *plink;
+
+	if (len < sizeof(*rsp))
+		return -EINVAL;
+
+	BT_DBG("id %d status 0x%2.2x assoc len %u", rsp->id, rsp->status,
+	       len - sizeof(*rsp));
+
+	if (rsp->status)
+		return -EINVAL;
+
+	/* Save remote ASSOC data */
+	ctrl = amp_ctrl_lookup(mgr, rsp->id);
+	if (ctrl) {
+		u8 *assoc, assoc_len = len - sizeof(*rsp);
+
+		assoc = kzalloc(assoc_len, GFP_KERNEL);
+		if (!assoc) {
+			amp_ctrl_put(ctrl);
+			return -ENOMEM;
+		}
+
+		memcpy(assoc, rsp->amp_assoc, assoc_len);
+		ctrl->assoc = assoc;
+		ctrl->assoc_len = assoc_len;
+		ctrl->assoc_rem_len = assoc_len;
+		ctrl->assoc_len_so_far = 0;
+
+		amp_ctrl_put(ctrl);
+	}
+
+	/* Create Phys Link */
+	hdev = hci_dev_get(rsp->id);
+	if (!hdev)
+		return -EINVAL;
+
+	plink = phylink_add(mgr, hdev->id, rsp->id, ctrl->assoc,
+			    ctrl->assoc_len);
+
+	BT_DBG("Created plink %p: loc:%d -> rem:%d", plink, hdev->id, rsp->id);
+
+done:
+	hci_dev_put(hdev);
+	skb_pull(skb, len);
+	return 0;
+}
+
 static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 				   struct a2mp_cmd *hdr)
 {
@@ -492,8 +546,11 @@ static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 			err = a2mp_getinfo_rsp(mgr, skb, hdr);
 			break;
 
-		case A2MP_CHANGE_RSP:
 		case A2MP_GETAMPASSOC_RSP:
+			err = a2mp_getampassoc_rsp(mgr, skb, hdr);
+			break;
+
+		case A2MP_CHANGE_RSP:
 		case A2MP_CREATEPHYSLINK_RSP:
 		case A2MP_DISCONNPHYSLINK_RSP:
 			err = a2mp_cmd_rsp(mgr, skb, hdr);
-- 
1.7.9.5

