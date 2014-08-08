Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: Fix hci_update_random_address() error return for no crypto
Date: Fri,  8 Aug 2014 09:32:48 +0300
Message-Id: <1407479572-4868-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If the AES crypto context is not available we cannot generate new RPAs.
We should therefore cleanly return an error from the function
responsible for updating the random address.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 217ef83fb541..860477090d78 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3882,6 +3882,12 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 		    !bacmp(&hdev->random_addr, &hdev->rpa))
 			return 0;
 
+		if (!hdev->tfm_aes) {
+			BT_ERR("%s crypto not available to generate RPA",
+			       hdev->name);
+			return -EOPNOTSUPP;
+		}
+
 		err = smp_generate_rpa(hdev->tfm_aes, hdev->irk, &hdev->rpa);
 		if (err < 0) {
 			BT_ERR("%s failed to generate new RPA", hdev->name);
-- 
1.9.3

