Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 14/19] Bluetooth: AMP: Create Physical Link
Date: Thu,  6 Sep 2012 15:19:52 +0300
Message-Id: <1346933997-14369-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving A2MP Get AMP Assoc Response execute HCI Create Physical
Link to AMP controller. Define function which will run when receiving
HCI Command Status.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h |    4 ++++
 include/net/bluetooth/pal.h |    1 -
 net/bluetooth/a2mp.c        |    2 ++
 net/bluetooth/amp.c         |   19 +++++++++++++++++++
 net/bluetooth/hci_event.c   |    9 +++++++++
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index e861675..b6c08ce 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -14,8 +14,12 @@
 #ifndef __AMP_H
 #define __AMP_H
 
+#include <net/bluetooth/pal.h>
+
 void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
 void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
 void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
+void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
+			struct hci_conn *hcon);
 
 #endif /* __AMP_H */
diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
index 3b6213c..35f1765 100644
--- a/include/net/bluetooth/pal.h
+++ b/include/net/bluetooth/pal.h
@@ -18,7 +18,6 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
-#include <net/bluetooth/amp.h>
 
 struct amp_ctrl {
 	struct list_head	list;
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index c550589..39e0f95 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -383,6 +383,8 @@ static int a2mp_getampassoc_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	BT_DBG("Created hcon %p: loc:%d -> rem:%d", hcon, hdev->id, rsp->id);
 
+	amp_create_phylink(hdev, mgr, hcon);
+
 done:
 	hci_dev_put(hdev);
 	skb_pull(skb, len);
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 2d4e79e..9676393 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -43,3 +43,22 @@ void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
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
index 85dad7f..f151ed2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1686,6 +1686,11 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
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
@@ -2495,6 +2500,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
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

