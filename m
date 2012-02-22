Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: mgmt: Fix Set SSP supported check
Date: Wed, 22 Feb 2012 16:53:11 +0200
Message-Id: <1329922392-25089-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The test for SSP support needs to be earlier in the set_ssp function so
that we return an error when SSP is not supported even when the device
is powered off.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8b4df04..ac8ba83 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1141,6 +1141,12 @@ static int set_ssp(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
+	if (!(hdev->features[6] & LMP_SIMPLE_PAIR)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_SSP,
+						MGMT_STATUS_NOT_SUPPORTED);
+		goto failed;
+	}
+
 	val = !!cp->val;
 
 	if (!hdev_is_powered(hdev)) {
@@ -1161,12 +1167,6 @@ static int set_ssp(struct sock *sk, u16 index, void *data, u16 len)
 		goto failed;
 	}
 
-	if (!(hdev->features[6] & LMP_SIMPLE_PAIR)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_SSP,
-						MGMT_STATUS_NOT_SUPPORTED);
-		goto failed;
-	}
-
 	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_SSP, MGMT_STATUS_BUSY);
 		goto failed;
-- 
1.7.9

