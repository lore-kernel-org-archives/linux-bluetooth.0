Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: HCI name update to hci_request.c
Date: Wed, 25 Nov 2015 16:15:41 +0200
Message-Id: <1448460944-17002-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1448460944-17002-1-git-send-email-johan.hedberg@gmail.com>
References: <1448460944-17002-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll soon need this both from hci_request.c and mgmt.c so move it as
a request helper function to hci_request.c.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 10 ++++++++++
 net/bluetooth/hci_request.h |  2 ++
 net/bluetooth/mgmt.c        | 14 ++------------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index fe14fd121d36..3150461c52a4 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -420,6 +420,16 @@ static void __hci_update_background_scan(struct hci_request *req)
 	}
 }
 
+void __hci_req_update_name(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_write_local_name cp;
+
+	memcpy(cp.name, hdev->dev_name, sizeof(cp.name));
+
+	hci_req_add(req, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
+}
+
 void hci_req_add_le_scan_disable(struct hci_request *req)
 {
 	struct hci_cp_le_set_scan_enable cp;
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 41920348d68b..4e65a9c7906a 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -55,6 +55,8 @@ void hci_req_sync_cancel(struct hci_dev *hdev, int err);
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
 
+void __hci_req_update_name(struct hci_request *req);
+
 void hci_req_add_le_scan_disable(struct hci_request *req);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 29b3bb70ae9f..001a29a320e6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3153,16 +3153,6 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 				 HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
-static void update_name(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_write_local_name cp;
-
-	memcpy(cp.name, hdev->dev_name, sizeof(cp.name));
-
-	hci_req_add(req, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
-}
-
 static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct mgmt_cp_set_local_name *cp;
@@ -3241,7 +3231,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_req_init(&req, hdev);
 
 	if (lmp_bredr_capable(hdev)) {
-		update_name(&req);
+		__hci_req_update_name(&req);
 		update_eir(&req);
 	}
 
@@ -6768,7 +6758,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 			write_fast_connectable(&req, false);
 		__hci_req_update_scan(&req);
 		__hci_req_update_class(&req);
-		update_name(&req);
+		__hci_req_update_name(&req);
 		update_eir(&req);
 	}
 
-- 
2.5.0

