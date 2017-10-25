Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v1] Bluetooth: Fix potential memory leak
Date: Wed, 25 Oct 2017 10:58:48 +0530
Message-Id: <1508909328-14529-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If command is added to req then it should be freed in case if
hdev is down or HCI_ADVERTISING flag is set.

This introduces a helper in hci_request to purge the cmd_q
to make cmd_q internal to hci_request which is used to fix
the leak.

This also replace accessing of cmd_q in hci_ccnn with the
new helper.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 net/bluetooth/hci_conn.c    | 2 +-
 net/bluetooth/hci_request.c | 5 +++++
 net/bluetooth/hci_request.h | 1 +
 net/bluetooth/mgmt.c        | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3538b69..9459311 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -944,7 +944,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		 */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 		    hdev->le_scan_type == LE_SCAN_ACTIVE) {
-			skb_queue_purge(&req.cmd_q);
+			hci_req_purge(&req);
 			hci_conn_del(conn);
 			return ERR_PTR(-EBUSY);
 		}
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 85ec657..62a7b94 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -39,6 +39,11 @@ void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
 	req->err = 0;
 }
 
+void hci_req_purge(struct hci_request *req)
+{
+	skb_queue_purge(&req->cmd_q);
+}
+
 static int req_run(struct hci_request *req, hci_req_complete_t complete,
 		   hci_req_complete_skb_t complete_skb)
 {
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index dde77bd..702beb1 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -36,6 +36,7 @@ struct hci_request {
 };
 
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
+void hci_req_purge(struct hci_request *req);
 int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
 int hci_req_run_skb(struct hci_request *req, hci_req_complete_skb_t complete);
 void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1fba2a0..07a3cc2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6383,6 +6383,7 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 	if (skb_queue_empty(&req.cmd_q) ||
 	    !hdev_is_powered(hdev) ||
 	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
+		hci_req_purge(&req);
 		rp.instance = cp->instance;
 		err = mgmt_cmd_complete(sk, hdev->id,
 					MGMT_OP_REMOVE_ADVERTISING,
-- 
2.7.4

