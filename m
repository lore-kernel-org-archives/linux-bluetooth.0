Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix Class of Device indication when powering off
Date: Wed, 16 Jan 2013 16:15:34 +0200
Message-Id: <1358345734-17892-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When a HCI device is powered off the Management interface specification
dictates that the class of device value is indicated as zero. This patch
fixes sending of the appropriate class of device changed event when a
HCI device is powered off.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fc171f2..54f3ddba 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2987,7 +2987,13 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 		}
 	} else {
 		u8 status = MGMT_STATUS_NOT_POWERED;
+		u8 zero_cod[] = { 0, 0, 0 };
+
 		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
+
+		if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0)
+			mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
+				   zero_cod, sizeof(zero_cod), NULL);
 	}
 
 	err = new_settings(hdev, match.sk);
-- 
1.7.10.4

