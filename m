Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: Move non-critical sections outside of the dev lock
Date: Wed,  9 Jan 2013 15:29:38 +0200
Message-Id: <1357738180-4128-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes sections of code that do not need hci_lock_dev to be
outside of the lock. Such sections include code that do not touch the
hdev at all as well as sections which just read a single byte from the
supported_features value (i.e. all lmp_*_capable() macros).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4f60540..69221ce 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1133,13 +1133,11 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	BT_DBG("request for %s", hdev->name);
 
-	hci_dev_lock(hdev);
+	if (!lmp_ssp_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
+				  MGMT_STATUS_NOT_SUPPORTED);
 
-	if (!lmp_ssp_capable(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
-				 MGMT_STATUS_NOT_SUPPORTED);
-		goto failed;
-	}
+	hci_dev_lock(hdev);
 
 	val = !!cp->val;
 
@@ -1217,13 +1215,11 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	BT_DBG("request for %s", hdev->name);
 
-	hci_dev_lock(hdev);
+	if (!lmp_le_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
+				  MGMT_STATUS_NOT_SUPPORTED);
 
-	if (!lmp_le_capable(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
-				 MGMT_STATUS_NOT_SUPPORTED);
-		goto unlock;
-	}
+	hci_dev_lock(hdev);
 
 	val = !!cp->val;
 	enabled = lmp_host_le_capable(hdev);
@@ -1422,25 +1418,19 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	hci_dev_lock(hdev);
+	if (!lmp_bredr_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
+				  MGMT_STATUS_NOT_SUPPORTED);
 
-	if (!lmp_bredr_capable(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
-				 MGMT_STATUS_NOT_SUPPORTED);
-		goto unlock;
-	}
+	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
+				  MGMT_STATUS_BUSY);
 
-	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
-				 MGMT_STATUS_BUSY);
-		goto unlock;
-	}
+	if ((cp->minor & 0x03) != 0 || (cp->major & 0xe0) != 0)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
+				  MGMT_STATUS_INVALID_PARAMS);
 
-	if ((cp->minor & 0x03) != 0 || (cp->major & 0xe0) != 0) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
-				 MGMT_STATUS_INVALID_PARAMS);
-		goto unlock;
-	}
+	hci_dev_lock(hdev);
 
 	hdev->major_class = cp->major;
 	hdev->minor_class = cp->minor;
-- 
1.7.10.4

