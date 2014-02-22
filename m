Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/15] Bluetooth: Don't write static address when privacy is enabled
Date: Sat, 22 Feb 2014 19:06:38 +0200
Message-Id: <1393088805-28658-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If privacy is enabled we'll be using RPAs instead of the static address.
Therefore, only write the static address to HCI when the HCI_PRIVACY
flag is not set.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 145254f84975..21d059968c32 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4609,7 +4609,8 @@ static int powered_update_hci(struct hci_dev *hdev)
 
 	if (lmp_le_capable(hdev)) {
 		/* Set random address to static address if configured */
-		if (bacmp(&hdev->static_addr, BDADDR_ANY))
+		if (!test_bit(HCI_PRIVACY, &hdev->dev_flags) &&
+		    bacmp(&hdev->static_addr, BDADDR_ANY))
 			hci_req_add(&req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
 				    &hdev->static_addr);
 
-- 
1.8.5.3

