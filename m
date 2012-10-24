Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: Fix sending unnecessary HCI_LE_Host_Enable
Date: Thu, 25 Oct 2012 00:09:53 +0300
Message-Id: <1351112996-9597-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes sending an unnecessary HCI_LE_Host_Enable command if
the command has already been sent as part of the default HCI init
sequence.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 02dc5f8..03dc176 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2927,8 +2927,14 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 			cp.le = 1;
 			cp.simul = !!lmp_le_br_capable(hdev);
 
-			hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
-				     sizeof(cp), &cp);
+			/* Check first if we already have the right
+			 * host state (host features set)
+			 */
+			if (cp.le != !!lmp_host_le_capable(hdev) ||
+			    cp.simul != !!lmp_host_le_br_capable(hdev))
+				hci_send_cmd(hdev,
+					     HCI_OP_WRITE_LE_HOST_SUPPORTED,
+					     sizeof(cp), &cp);
 		}
 
 		if (lmp_bredr_capable(hdev)) {
-- 
1.7.10.4

