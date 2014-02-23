Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/10] Bluetooth: Don't write static address during power on
Date: Sun, 23 Feb 2014 16:23:56 +0200
Message-Id: <1393165438-13610-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
References: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since we always update the random address before enabling advertising,
scanning and initiating LE connections there is no need to write the
random address add power on.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 467ca21e04d6..9934441f7cf8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4591,11 +4591,6 @@ static int powered_update_hci(struct hci_dev *hdev)
 	}
 
 	if (lmp_le_capable(hdev)) {
-		/* Set random address to static address if configured */
-		if (bacmp(&hdev->static_addr, BDADDR_ANY))
-			hci_req_add(&req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
-				    &hdev->static_addr);
-
 		/* Make sure the controller has a good default for
 		 * advertising data. This also applies to the case
 		 * where BR/EDR was toggled during the AUTO_OFF phase.
-- 
1.8.5.3

