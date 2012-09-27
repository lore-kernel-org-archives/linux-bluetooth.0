Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org, mathewm@codeaurora.org
Subject: [PATCHv7 19/19] Bluetooth: AMP: Handle Accept phylink command status evt
Date: Thu, 27 Sep 2012 17:26:24 +0300
Message-Id: <1348755984-6403-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1348755984-6403-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1348755984-6403-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving HCI Command Status event for Accept Physical Link
execute HCI Write Remote AMP Assoc with data saved from A2MP Create
Physical Link Request.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h |    1 +
 net/bluetooth/a2mp.c        |   32 ++++++++++++++++++++++++++++++++
 net/bluetooth/amp.c         |    2 +-
 net/bluetooth/hci_event.c   |   20 ++++++++++++++++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index 1b06d7b..b1e5490 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -25,6 +25,7 @@ struct amp_ctrl {
 };
 
 int amp_ctrl_put(struct amp_ctrl *ctrl);
+void amp_ctrl_get(struct amp_ctrl *ctrl);
 struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr);
 struct amp_ctrl *amp_ctrl_lookup(struct amp_mgr *mgr, u8 id);
 void amp_ctrl_list_flush(struct amp_mgr *mgr);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index dbfdbbb..47565d2 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -438,6 +438,7 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
 	struct hci_conn *hcon;
+	struct amp_ctrl *ctrl;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -453,6 +454,37 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 		goto send_rsp;
 	}
 
+	ctrl = amp_ctrl_lookup(mgr, rsp.remote_id);
+	if (!ctrl) {
+		ctrl = amp_ctrl_add(mgr);
+		if (ctrl) {
+			amp_ctrl_get(ctrl);
+		} else {
+			rsp.status = A2MP_STATUS_UNABLE_START_LINK_CREATION;
+			goto send_rsp;
+		}
+	}
+
+	if (ctrl) {
+		u8 *assoc, assoc_len = le16_to_cpu(hdr->len) - sizeof(*req);
+
+		ctrl->id = rsp.remote_id;
+
+		assoc = kzalloc(assoc_len, GFP_KERNEL);
+		if (!assoc) {
+			amp_ctrl_put(ctrl);
+			return -ENOMEM;
+		}
+
+		memcpy(assoc, req->amp_assoc, assoc_len);
+		ctrl->assoc = assoc;
+		ctrl->assoc_len = assoc_len;
+		ctrl->assoc_rem_len = assoc_len;
+		ctrl->assoc_len_so_far = 0;
+
+		amp_ctrl_put(ctrl);
+	}
+
 	hcon = phylink_add(hdev, mgr, req->local_id);
 	if (hcon) {
 		amp_accept_phylink(hdev, mgr, hcon);
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 845e430..5dab2d1 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -19,7 +19,7 @@
 #include <crypto/hash.h>
 
 /* Remote AMP Controllers interface */
-static void amp_ctrl_get(struct amp_ctrl *ctrl)
+void amp_ctrl_get(struct amp_ctrl *ctrl)
 {
 	BT_DBG("ctrl %p orig refcnt %d", ctrl,
 	       atomic_read(&ctrl->kref.refcount));
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8f1eccf..65f66bf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1728,6 +1728,22 @@ static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
 	amp_write_remote_assoc(hdev, cp->phy_handle);
 }
 
+static void hci_cs_accept_phylink(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_accept_phy_link *cp;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_ACCEPT_PHY_LINK);
+	if (!cp)
+		return;
+
+	amp_write_remote_assoc(hdev, cp->phy_handle);
+}
+
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2550,6 +2566,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_create_phylink(hdev, ev->status);
 		break;
 
+	case HCI_OP_ACCEPT_PHY_LINK:
+		hci_cs_accept_phylink(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
-- 
1.7.9.5

