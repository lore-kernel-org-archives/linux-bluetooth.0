Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Fix IRK lookup when tfm_aes is not available
Date: Fri,  8 Aug 2014 09:32:49 +0300
Message-Id: <1407479572-4868-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If the AES crypto has not been initialized properly we should cleanly
return from the hci_find_irk_by_rpa() function. Right now this will not
happen in practice, but once (in subsequent patches) SMP init is moved
to after the HCI init procedure it is possible that the pointer is NULL.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 860477090d78..4a1ec259099e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3232,6 +3232,9 @@ struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
 			return irk;
 	}
 
+	if (!hdev->tfm_aes)
+		return NULL;
+
 	list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
 		if (smp_irk_matches(hdev->tfm_aes, irk->val, rpa)) {
 			bacpy(&irk->rpa, rpa);
-- 
1.9.3

