Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH 2/3] Bluetooth: Move amp assoc read/write completed callback to amp.c
Date: Fri, 24 Jul 2015 17:10:50 +0800
Message-Id: <1437729050-16750-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To avoid amp module hooks from hci_event.c

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 net/bluetooth/amp.c       |   81 ++++++++++++++++++++++++++++++++++++++++++---
 net/bluetooth/hci_event.c |   59 ---------------------------------
 2 files changed, 77 insertions(+), 63 deletions(-)

diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index ee016f0..45888fa 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -16,6 +16,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <crypto/hash.h>
 
+#include "hci_request.h"
 #include "a2mp.h"
 #include "amp.h"
 
@@ -220,10 +221,49 @@ int phylink_gen_key(struct hci_conn *conn, u8 *data, u8 *len, u8 *type)
 	return hmac_sha256(gamp_key, HCI_AMP_LINK_KEY_SIZE, "802b", 4, data);
 }
 
+static void read_local_amp_assoc_complete(struct hci_dev *hdev, u8 status,
+					  u16 opcode, struct sk_buff *skb)
+{
+	struct hci_rp_read_local_amp_assoc *rp = (void *)skb->data;
+	struct amp_assoc *assoc = &hdev->loc_assoc;
+	size_t rem_len, frag_len;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		goto send_rsp;
+
+	frag_len = skb->len - sizeof(*rp);
+	rem_len = __le16_to_cpu(rp->rem_len);
+
+	if (rem_len > frag_len) {
+		BT_DBG("frag_len %zu rem_len %zu", frag_len, rem_len);
+
+		memcpy(assoc->data + assoc->offset, rp->frag, frag_len);
+		assoc->offset += frag_len;
+
+		/* Read other fragments */
+		amp_read_loc_assoc_frag(hdev, rp->phy_handle);
+
+		return;
+	}
+
+	memcpy(assoc->data + assoc->offset, rp->frag, rem_len);
+	assoc->len = assoc->offset + rem_len;
+	assoc->offset = 0;
+
+send_rsp:
+	/* Send A2MP Rsp when all fragments are received */
+	a2mp_send_getampassoc_rsp(hdev, rp->status);
+	a2mp_send_create_phy_link_req(hdev, rp->status);
+}
+
 void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle)
 {
 	struct hci_cp_read_local_amp_assoc cp;
 	struct amp_assoc *loc_assoc = &hdev->loc_assoc;
+	struct hci_request req;
+	int err = 0;
 
 	BT_DBG("%s handle %d", hdev->name, phy_handle);
 
@@ -231,12 +271,18 @@ void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle)
 	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
 	cp.len_so_far = cpu_to_le16(loc_assoc->offset);
 
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
+	hci_req_init(&req, hdev);
+	hci_req_add(&req, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
+	err = hci_req_run_skb(&req, read_local_amp_assoc_complete);
+	if (err < 0)
+		a2mp_send_getampassoc_rsp(hdev, A2MP_STATUS_INVALID_CTRL_ID);
 }
 
 void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
 {
 	struct hci_cp_read_local_amp_assoc cp;
+	struct hci_request req;
+	int err = 0;
 
 	memset(&hdev->loc_assoc, 0, sizeof(struct amp_assoc));
 	memset(&cp, 0, sizeof(cp));
@@ -244,7 +290,11 @@ void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
 	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
 
 	set_bit(READ_LOC_AMP_ASSOC, &mgr->state);
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
+	hci_req_init(&req, hdev);
+	hci_req_add(&req, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
+	hci_req_run_skb(&req, read_local_amp_assoc_complete);
+	if (err < 0)
+		a2mp_send_getampassoc_rsp(hdev, A2MP_STATUS_INVALID_CTRL_ID);
 }
 
 void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
@@ -252,6 +302,8 @@ void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
 {
 	struct hci_cp_read_local_amp_assoc cp;
 	struct amp_mgr *mgr = hcon->amp_mgr;
+	struct hci_request req;
+	int err = 0;
 
 	cp.phy_handle = hcon->handle;
 	cp.len_so_far = cpu_to_le16(0);
@@ -260,7 +312,25 @@ void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
 	set_bit(READ_LOC_AMP_ASSOC_FINAL, &mgr->state);
 
 	/* Read Local AMP Assoc final link information data */
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
+	hci_req_init(&req, hdev);
+	hci_req_add(&req, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
+	hci_req_run_skb(&req, read_local_amp_assoc_complete);
+	if (err < 0)
+		a2mp_send_getampassoc_rsp(hdev, A2MP_STATUS_INVALID_CTRL_ID);
+}
+
+static void write_remote_amp_assoc_complete(struct hci_dev *hdev, u8 status,
+					    u16 opcode, struct sk_buff *skb)
+{
+	struct hci_rp_write_remote_amp_assoc *rp = (void *)skb->data;
+
+	BT_DBG("%s status 0x%2.2x phy_handle 0x%2.2x",
+	       hdev->name, rp->status, rp->phy_handle);
+
+	if (rp->status)
+		return;
+
+	amp_write_rem_assoc_continue(hdev, rp->phy_handle);
 }
 
 /* Write AMP Assoc data fragments, returns true with last fragment written*/
@@ -270,6 +340,7 @@ static bool amp_write_rem_assoc_frag(struct hci_dev *hdev,
 	struct hci_cp_write_remote_amp_assoc *cp;
 	struct amp_mgr *mgr = hcon->amp_mgr;
 	struct amp_ctrl *ctrl;
+	struct hci_request req;
 	u16 frag_len, len;
 
 	ctrl = amp_ctrl_lookup(mgr, hcon->remote_id);
@@ -307,7 +378,9 @@ static bool amp_write_rem_assoc_frag(struct hci_dev *hdev,
 
 	amp_ctrl_put(ctrl);
 
-	hci_send_cmd(hdev, HCI_OP_WRITE_REMOTE_AMP_ASSOC, len, cp);
+	hci_req_init(&req, hdev);
+	hci_req_add(&req, HCI_OP_WRITE_REMOTE_AMP_ASSOC, sizeof(cp), &cp);
+	hci_req_run_skb(&req, write_remote_amp_assoc_complete);
 
 	kfree(cp);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3f81cb4..1c43819 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -837,43 +837,6 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
 }
 
-static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
-					struct sk_buff *skb)
-{
-	struct hci_rp_read_local_amp_assoc *rp = (void *) skb->data;
-	struct amp_assoc *assoc = &hdev->loc_assoc;
-	size_t rem_len, frag_len;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		goto a2mp_rsp;
-
-	frag_len = skb->len - sizeof(*rp);
-	rem_len = __le16_to_cpu(rp->rem_len);
-
-	if (rem_len > frag_len) {
-		BT_DBG("frag_len %zu rem_len %zu", frag_len, rem_len);
-
-		memcpy(assoc->data + assoc->offset, rp->frag, frag_len);
-		assoc->offset += frag_len;
-
-		/* Read other fragments */
-		amp_read_loc_assoc_frag(hdev, rp->phy_handle);
-
-		return;
-	}
-
-	memcpy(assoc->data + assoc->offset, rp->frag, rem_len);
-	assoc->len = assoc->offset + rem_len;
-	assoc->offset = 0;
-
-a2mp_rsp:
-	/* Send A2MP Rsp when all fragments are received */
-	a2mp_send_getampassoc_rsp(hdev, rp->status);
-	a2mp_send_create_phy_link_req(hdev, rp->status);
-}
-
 static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
@@ -1406,20 +1369,6 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev,
-					  struct sk_buff *skb)
-{
-	struct hci_rp_write_remote_amp_assoc *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x phy_handle 0x%2.2x",
-	       hdev->name, rp->status, rp->phy_handle);
-
-	if (rp->status)
-		return;
-
-	amp_write_rem_assoc_continue(hdev, rp->phy_handle);
-}
-
 static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_rssi *rp = (void *) skb->data;
@@ -2995,10 +2944,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_read_clock(hdev, skb);
 		break;
 
-	case HCI_OP_READ_LOCAL_AMP_ASSOC:
-		hci_cc_read_local_amp_assoc(hdev, skb);
-		break;
-
 	case HCI_OP_READ_INQ_RSP_TX_POWER:
 		hci_cc_read_inq_rsp_tx_power(hdev, skb);
 		break;
@@ -3103,10 +3048,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_set_adv_param(hdev, skb);
 		break;
 
-	case HCI_OP_WRITE_REMOTE_AMP_ASSOC:
-		hci_cc_write_remote_amp_assoc(hdev, skb);
-		break;
-
 	case HCI_OP_READ_RSSI:
 		hci_cc_read_rssi(hdev, skb);
 		break;
-- 
1.7.9.5

