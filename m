Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: mgmt: Fix command status error code values
Date: Thu,  1 Mar 2012 17:14:59 -0800
Message-Id: <1330650900-11420-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1330650900-11420-1-git-send-email-johan.hedberg@gmail.com>
References: <1330650900-11420-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Error codes in the command status should always be from the set of
values defined for mgmt and never e.g. POSIX error codes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 40b3da3..bd01e4a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2745,7 +2745,7 @@ int mgmt_index_added(struct hci_dev *hdev)
 
 int mgmt_index_removed(struct hci_dev *hdev)
 {
-	u8 status = ENODEV;
+	u8 status = MGMT_STATUS_INVALID_PARAMS;
 
 	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
 
@@ -2798,7 +2798,7 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 		update_class(hdev);
 		update_eir(hdev);
 	} else {
-		u8 status = ENETDOWN;
+		u8 status = MGMT_STATUS_NOT_POWERED;
 		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
 	}
 
-- 
1.7.9.1

