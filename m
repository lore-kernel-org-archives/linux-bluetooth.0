Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH 3/3] Bluetooth: Move create/accept phy link completed callback to amp.c
Date: Fri, 24 Jul 2015 17:11:01 +0800
Message-Id: <1437729061-16787-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To avoid amp module hooks from hci_event.c

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 net/bluetooth/amp.c       |   53 +++++++++++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_event.c |   49 -----------------------------------------
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 45888fa..238ddd3 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -417,10 +417,37 @@ void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle)
 	amp_write_rem_assoc_frag(hdev, hcon);
 }
 
+static void create_phylink_complete(struct hci_dev *hdev, u8 status,
+				    u16 opcode)
+{
+	struct hci_cp_create_phy_link *cp;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_CREATE_PHY_LINK);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (status) {
+		struct hci_conn *hcon;
+
+		hcon = hci_conn_hash_lookup_handle(hdev, cp->phy_handle);
+		if (hcon)
+			hci_conn_del(hcon);
+	} else {
+		amp_write_remote_assoc(hdev, cp->phy_handle);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct hci_conn *hcon)
 {
 	struct hci_cp_create_phy_link cp;
+	struct hci_request req;
 
 	cp.phy_handle = hcon->handle;
 
@@ -433,13 +460,33 @@ void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 		return;
 	}
 
-	hci_send_cmd(hdev, HCI_OP_CREATE_PHY_LINK, sizeof(cp), &cp);
+	hci_req_init(&req, hdev);
+	hci_req_add(&req, HCI_OP_CREATE_PHY_LINK, sizeof(cp), &cp);
+	hci_req_run(&req, create_phylink_complete);
+}
+
+static void accept_phylink_complete(struct hci_dev *hdev, u8 status,
+				    u16 opcode)
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
 }
 
 void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct hci_conn *hcon)
 {
 	struct hci_cp_accept_phy_link cp;
+	struct hci_request req;
 
 	cp.phy_handle = hcon->handle;
 
@@ -452,7 +499,9 @@ void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 		return;
 	}
 
-	hci_send_cmd(hdev, HCI_OP_ACCEPT_PHY_LINK, sizeof(cp), &cp);
+	hci_req_init(&req, hdev);
+	hci_req_add(&req, HCI_OP_ACCEPT_PHY_LINK, sizeof(cp), &cp);
+	hci_req_run(&req, accept_phylink_complete);
 }
 
 void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c43819..5e24582 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1890,47 +1890,6 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
-{
-	struct hci_cp_create_phy_link *cp;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	cp = hci_sent_cmd_data(hdev, HCI_OP_CREATE_PHY_LINK);
-	if (!cp)
-		return;
-
-	hci_dev_lock(hdev);
-
-	if (status) {
-		struct hci_conn *hcon;
-
-		hcon = hci_conn_hash_lookup_handle(hdev, cp->phy_handle);
-		if (hcon)
-			hci_conn_del(hcon);
-	} else {
-		amp_write_remote_assoc(hdev, cp->phy_handle);
-	}
-
-	hci_dev_unlock(hdev);
-}
-
-static void hci_cs_accept_phylink(struct hci_dev *hdev, u8 status)
-{
-	struct hci_cp_accept_phy_link *cp;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	if (status)
-		return;
-
-	cp = hci_sent_cmd_data(hdev, HCI_OP_ACCEPT_PHY_LINK);
-	if (!cp)
-		return;
-
-	amp_write_remote_assoc(hdev, cp->phy_handle);
-}
-
 static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_le_create_conn *cp;
@@ -3131,14 +3090,6 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cs_setup_sync_conn(hdev, ev->status);
 		break;
 
-	case HCI_OP_CREATE_PHY_LINK:
-		hci_cs_create_phylink(hdev, ev->status);
-		break;
-
-	case HCI_OP_ACCEPT_PHY_LINK:
-		hci_cs_accept_phylink(hdev, ev->status);
-		break;
-
 	case HCI_OP_SNIFF_MODE:
 		hci_cs_sniff_mode(hdev, ev->status);
 		break;
-- 
1.7.9.5

