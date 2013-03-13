Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 12/26] Bluetooth: Fix local name setting for LE-only controllers
Date: Wed, 13 Mar 2013 11:12:03 -0700
Message-Id: <1363198337-3896-13-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes the mgmt_set_local_name command to send the appropriate
HCI commands based on BR/EDR support and LE support. Local name and EIR
data should only be sent for BR/EDR capable controllers whereas an
update to the AD should only happen for LE capable controllers.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1d50841..28e5975 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2433,8 +2433,15 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	memcpy(hdev->dev_name, cp->name, sizeof(hdev->dev_name));
 
 	hci_req_init(&req, hdev);
-	update_name(&req);
-	update_eir(&req);
+
+	if (lmp_bredr_capable(hdev)) {
+		update_name(&req);
+		update_eir(&req);
+	}
+
+	if (lmp_le_capable(hdev))
+		hci_update_ad(&req);
+
 	err = hci_req_run(&req, set_name_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
1.7.10.4

