Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Move memory location outside of hci_dev lock
Date: Sat, 28 Mar 2015 15:14:20 -0700
Message-Id: <1427580861-8052-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Taking the hci_dev lock for just a memory allocation seems a bit too
much and not really needed. So instead try to allocate the memory first
and then take the lock.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 29cbd98f4649..a9a0036ff0a7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6446,14 +6446,12 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 					 &cp->type, sizeof(cp->type));
 	}
 
-	hci_dev_lock(hdev);
-
 	rp_len = sizeof(*rp) + eir_len;
 	rp = kmalloc(rp_len, GFP_ATOMIC);
-	if (!rp) {
-		hci_dev_unlock(hdev);
+	if (!rp)
 		return -ENOMEM;
-	}
+
+	hci_dev_lock(hdev);
 
 	eir_len = 0;
 	switch (cp->type) {
@@ -6517,13 +6515,13 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 		break;
 	}
 
-	rp->type = cp->type;
-	rp->eir_len = cpu_to_le16(eir_len);
-
 	hci_dev_unlock(hdev);
 
 	hci_sock_set_flag(sk, HCI_MGMT_OOB_DATA_EVENTS);
 
+	rp->type = cp->type;
+	rp->eir_len = cpu_to_le16(eir_len);
+
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
 				MGMT_STATUS_SUCCESS, rp, sizeof(*rp) + eir_len);
 	if (err < 0)
-- 
2.1.0

