Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Fix local name setting for LE-only controllers
Date: Thu, 28 Feb 2013 14:23:14 +0200
Message-Id: <1362054195-18919-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362054195-18919-1-git-send-email-johan.hedberg@gmail.com>
References: <1362054195-18919-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes the mgmt_set_local_name command to send the appropriate
HCI commands based on BR/EDR support and LE support. Local name and EIR
data should only be sent for BR/EDR capable controllers whereas an
update to the AD should only happen for LE capable controllers.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c45625e..b704148 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2407,8 +2407,12 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	memcpy(hdev->dev_name, cp->name, sizeof(hdev->dev_name));
 
 	hci_transaction_init(&transaction, hdev, set_name_complete);
-	update_name(&transaction);
-	update_eir(&transaction);
+	if (lmp_bredr_capable(hdev)) {
+		update_name(&transaction);
+		update_eir(&transaction);
+	}
+	if (lmp_le_capable(hdev))
+		hci_update_ad(&transaction);
 	err = hci_transaction_run(&transaction);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
1.7.10.4

