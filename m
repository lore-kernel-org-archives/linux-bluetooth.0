Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org, mathewm@codeaurora.org
Subject: [PATCHv7 18/19] Bluetooth: AMP: Accept Physical Link
Date: Thu, 27 Sep 2012 17:26:23 +0300
Message-Id: <1348755984-6403-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1348755984-6403-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1348755984-6403-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving A2MP Create Physical Link message execute HCI
Accept Physical Link command to AMP controller.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h |    2 ++
 net/bluetooth/a2mp.c        |    5 +----
 net/bluetooth/amp.c         |   19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index 70496c0..1b06d7b 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -41,6 +41,8 @@ void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
 				   struct hci_conn *hcon);
 void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct hci_conn *hcon);
+void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
+			struct hci_conn *hcon);
 void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
 void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 375a67f..dbfdbbb 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -453,12 +453,9 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 		goto send_rsp;
 	}
 
-	/* TODO process physlink create */
-
 	hcon = phylink_add(hdev, mgr, req->local_id);
 	if (hcon) {
-		BT_DBG("hcon %p", hcon);
-
+		amp_accept_phylink(hdev, mgr, hcon);
 		rsp.status = A2MP_STATUS_SUCCESS;
 	} else {
 		rsp.status = A2MP_STATUS_UNABLE_START_LINK_CREATION;
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 4f7b264..845e430 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -346,3 +346,22 @@ void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 
 	hci_send_cmd(hdev, HCI_OP_CREATE_PHY_LINK, sizeof(cp), &cp);
 }
+
+void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
+			struct hci_conn *hcon)
+{
+	struct hci_cp_accept_phy_link cp;
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
+	hci_send_cmd(hdev, HCI_OP_ACCEPT_PHY_LINK, sizeof(cp), &cp);
+}
-- 
1.7.9.5

