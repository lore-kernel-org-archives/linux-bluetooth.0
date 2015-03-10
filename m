Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix clearing Fast Connectable when powering off
Date: Tue, 10 Mar 2015 12:57:56 +0200
Message-Id: <1425985077-6239-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Fast Connectable setting can only be enabled when powered on, so it
should implicitly be cleared when powering off. So far the code was
relying on HCI_Reset clearing the flag in dev_flags, however usually
this happens only upon power on, meaning the flag is left dangling while
powered off.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d769b428b630..840c245a5cf4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6509,6 +6509,11 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 		goto new_settings;
 	}
 
+	/* Fast Connectable is only valid while the controller is
+	 * powered on.
+	 */
+	clear_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags);
+
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
 	/* If the power off is because of hdev unregistration let
-- 
2.1.0

