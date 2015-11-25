Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Move fast connectable code to hci_request.c
Date: Wed, 25 Nov 2015 16:15:43 +0200
Message-Id: <1448460944-17002-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1448460944-17002-1-git-send-email-johan.hedberg@gmail.com>
References: <1448460944-17002-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll soon need this both in hci_request.c and mgmt.c so move it to
hci_request.c as a generic helper.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 35 +++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h |  1 +
 net/bluetooth/mgmt.c        | 43 ++++---------------------------------------
 3 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 030a1bb66ef5..0abd83ddd4fb 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -349,6 +349,41 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 	hci_req_add_ev(req, opcode, plen, param, 0);
 }
 
+void __hci_req_write_fast_connectable(struct hci_request *req, bool enable)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_write_page_scan_activity acp;
+	u8 type;
+
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		return;
+
+	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
+		return;
+
+	if (enable) {
+		type = PAGE_SCAN_TYPE_INTERLACED;
+
+		/* 160 msec page scan interval */
+		acp.interval = cpu_to_le16(0x0100);
+	} else {
+		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
+
+		/* default 1.28 sec page scan */
+		acp.interval = cpu_to_le16(0x0800);
+	}
+
+	acp.window = cpu_to_le16(0x0012);
+
+	if (__cpu_to_le16(hdev->page_scan_interval) != acp.interval ||
+	    __cpu_to_le16(hdev->page_scan_window) != acp.window)
+		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY,
+			    sizeof(acp), &acp);
+
+	if (hdev->page_scan_type != type)
+		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
+}
+
 /* This function controls the background scanning based on hdev->pend_le_conns
  * list. If there are pending LE connection we start the background scanning,
  * otherwise we stop it.
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 5af40395afa8..d3dd24deca74 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -55,6 +55,7 @@ void hci_req_sync_cancel(struct hci_dev *hdev, int err);
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
 
+void __hci_req_write_fast_connectable(struct hci_request *req, bool enable);
 void __hci_req_update_name(struct hci_request *req);
 void __hci_req_update_eir(struct hci_request *req);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fa5dc67a800a..0a7e6f4de383 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1254,41 +1254,6 @@ failed:
 	return err;
 }
 
-static void write_fast_connectable(struct hci_request *req, bool enable)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_write_page_scan_activity acp;
-	u8 type;
-
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		return;
-
-	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
-		return;
-
-	if (enable) {
-		type = PAGE_SCAN_TYPE_INTERLACED;
-
-		/* 160 msec page scan interval */
-		acp.interval = cpu_to_le16(0x0100);
-	} else {
-		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
-
-		/* default 1.28 sec page scan */
-		acp.interval = cpu_to_le16(0x0800);
-	}
-
-	acp.window = cpu_to_le16(0x0012);
-
-	if (__cpu_to_le16(hdev->page_scan_interval) != acp.interval ||
-	    __cpu_to_le16(hdev->page_scan_window) != acp.window)
-		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY,
-			    sizeof(acp), &acp);
-
-	if (hdev->page_scan_type != type)
-		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
-}
-
 void mgmt_set_connectable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct mgmt_pending_cmd *cmd;
@@ -4094,7 +4059,7 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	hci_req_init(&req, hdev);
 
-	write_fast_connectable(&req, cp->val);
+	__hci_req_write_fast_connectable(&req, cp->val);
 
 	err = hci_req_run(&req, fast_connectable_complete);
 	if (err < 0) {
@@ -4236,7 +4201,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_req_init(&req, hdev);
 
-	write_fast_connectable(&req, false);
+	__hci_req_write_fast_connectable(&req, false);
 	__hci_req_update_scan(&req);
 
 	/* Since only the advertising data flags will change, there
@@ -6566,9 +6531,9 @@ static int powered_update_hci(struct hci_dev *hdev)
 
 	if (lmp_bredr_capable(hdev)) {
 		if (hci_dev_test_flag(hdev, HCI_FAST_CONNECTABLE))
-			write_fast_connectable(&req, true);
+			__hci_req_write_fast_connectable(&req, true);
 		else
-			write_fast_connectable(&req, false);
+			__hci_req_write_fast_connectable(&req, false);
 		__hci_req_update_scan(&req);
 		__hci_req_update_class(&req);
 		__hci_req_update_name(&req);
-- 
2.5.0

