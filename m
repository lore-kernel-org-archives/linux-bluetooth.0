Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org,
	gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCHv6 14/17] Bluetooth: AMP: Create Physical Link
Date: Tue, 18 Sep 2012 17:28:26 +0300
Message-Id: <1347978509-12133-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1347978509-12133-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347978509-12133-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving A2MP Get AMP Assoc Response execute HCI Create Physical
Link to AMP controller. Define function which will run when receiving
HCI Command Status.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h |    2 ++
 net/bluetooth/a2mp.c        |    2 ++
 net/bluetooth/amp.c         |   19 +++++++++++++++++++
 net/bluetooth/hci_event.c   |    9 +++++++++
 4 files changed, 32 insertions(+)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index 763b463..cadb3d0 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -37,5 +37,7 @@ int phylink_gen_key(struct hci_conn *hcon, u8 *data, u8 *len, u8 *type);
 void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
 void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
 void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
+void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
+			struct hci_conn *hcon);
 
 #endif /* __AMP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 93adaad..773e8fc 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -392,6 +392,8 @@ static int a2mp_getampassoc_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	BT_DBG("Created hcon %p: loc:%d -> rem:%d", hcon, hdev->id, rsp->id);
 
+	amp_create_phylink(hdev, mgr, hcon);
+
 done:
 	hci_dev_put(hdev);
 	skb_pull(skb, len);
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index de45696..c95e455 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -232,3 +232,22 @@ void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
 	mgr->state = READ_LOC_AMP_ASSOC;
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
 }
+
+void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
+			struct hci_conn *hcon)
+{
+	struct hci_cp_create_phy_link cp;
+
+	cp.phy_handle = hcon->handle;
+
+	BT_DBG("%s hcon %p phy handle 0x%2.2x", hdev->name, hcon,
+	       hcon->handle);
+
+	if (phylink_gen_key(mgr->l2cap_conn->hcon, cp.key, &cp.key_len,
+			    &cp.key_type)) {
+		BT_DBG("Cannot create link key");
+		return;
+	}
+
+	hci_send_cmd(hdev, HCI_OP_CREATE_PHY_LINK, sizeof(cp), &cp);
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6cc44cf..4b093f8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1687,6 +1687,11 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 }
 
+static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+}
+
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2496,6 +2501,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_le_start_enc(hdev, ev->status);
 		break;
 
+	case HCI_OP_CREATE_PHY_LINK:
+		hci_cs_create_phylink(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
-- 
1.7.9.5
