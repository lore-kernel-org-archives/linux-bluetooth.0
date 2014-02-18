Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] Bluetooth: Fix hci_remove_ltk failure when no match is found
Date: Tue, 18 Feb 2014 17:14:33 +0200
Message-Id: <1392736479-8808-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
References: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There is code (in mgmt.c) that depends on the hci_remove_ltk function to
fail if no match is found. This patch adds tracking of removed LTKs
(there can be up to two: one for master and another for slave) in the
hci_remove_ltk function and returns -ENOENT of no matches were found.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fd5bb4086613..69b7145bfce2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2807,6 +2807,7 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 {
 	struct smp_ltk *k, *tmp;
+	int removed = 0;
 
 	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->bdaddr_type != bdaddr_type)
@@ -2816,9 +2817,10 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 
 		list_del(&k->list);
 		kfree(k);
+		removed++;
 	}
 
-	return 0;
+	return removed ? 0 : -ENOENT;
 }
 
 /* HCI command timer function */
-- 
1.8.5.3

