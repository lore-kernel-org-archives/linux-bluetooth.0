Return-Path: <cyrus@holtmann.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Bluetooth: Pre-initialize variables in read_local_oob_ext_data_complete()
Date: Thu, 16 Apr 2015 21:24:25 +0200
Message-Id: <1429212265-26750-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

net/bluetooth/mgmt.c: In function ‘read_local_oob_ext_data_complete’:
net/bluetooth/mgmt.c:6474: warning: ‘r256’ may be used uninitialized in this function
net/bluetooth/mgmt.c:6474: warning: ‘h256’ may be used uninitialized in this function
net/bluetooth/mgmt.c:6474: warning: ‘r192’ may be used uninitialized in this function
net/bluetooth/mgmt.c:6474: warning: ‘h192’ may be used uninitialized in this function

While these are false positives, the code can be shortened by
pre-initializing the hash table pointers and eir_len. This has the side
effect of killing the compiler warnings.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/bluetooth/mgmt.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7fd87e7135b52753..f8e13b6d58279463 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6471,9 +6471,9 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 {
 	const struct mgmt_cp_read_local_oob_ext_data *mgmt_cp;
 	struct mgmt_rp_read_local_oob_ext_data *mgmt_rp;
-	u8 *h192, *r192, *h256, *r256;
+	u8 *h192 = NULL, *r192 = NULL, *h256 = NULL, *r256 = NULL;
 	struct mgmt_pending_cmd *cmd;
-	u16 eir_len;
+	u16 eir_len = 0;
 	int err;
 
 	BT_DBG("%s status %u", hdev->name, status);
@@ -6486,18 +6486,11 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 
 	if (status) {
 		status = mgmt_status(status);
-		eir_len = 0;
-
-		h192 = NULL;
-		r192 = NULL;
-		h256 = NULL;
-		r256 = NULL;
 	} else if (opcode == HCI_OP_READ_LOCAL_OOB_DATA) {
 		struct hci_rp_read_local_oob_data *rp;
 
 		if (skb->len != sizeof(*rp)) {
 			status = MGMT_STATUS_FAILED;
-			eir_len = 0;
 		} else {
 			status = MGMT_STATUS_SUCCESS;
 			rp = (void *)skb->data;
@@ -6505,23 +6498,18 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 			eir_len = 5 + 18 + 18;
 			h192 = rp->hash;
 			r192 = rp->rand;
-			h256 = NULL;
-			r256 = NULL;
 		}
 	} else {
 		struct hci_rp_read_local_oob_ext_data *rp;
 
 		if (skb->len != sizeof(*rp)) {
 			status = MGMT_STATUS_FAILED;
-			eir_len = 0;
 		} else {
 			status = MGMT_STATUS_SUCCESS;
 			rp = (void *)skb->data;
 
 			if (hci_dev_test_flag(hdev, HCI_SC_ONLY)) {
 				eir_len = 5 + 18 + 18;
-				h192 = NULL;
-				r192 = NULL;
 			} else {
 				eir_len = 5 + 18 + 18 + 18 + 18;
 				h192 = rp->hash192;
-- 
1.9.1
