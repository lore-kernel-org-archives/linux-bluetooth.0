Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Don't try to look up private addresses as Identity Address
Date: Tue, 18 Feb 2014 21:41:35 +0200
Message-Id: <1392752497-8696-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
References: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Identity Addresses are either public or static random. When looking up
addresses based on the Identity Address it doesn't make sense to go
through the IRK list if we're given a private random address. This patch
fixes (or rather improves) the hci_find_irk_by_addr function to bail out
early if given a private random address.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cdba4709f012..e4c5b9d6083c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2662,6 +2662,10 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct smp_irk *irk;
 
+	/* Identity Address must be public or static random */
+	if (addr_type == ADDR_LE_DEV_RANDOM && (bdaddr->b[5] & 0xc0) != 0xc0)
+		return NULL;
+
 	list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
 		if (addr_type == irk->addr_type &&
 		    bacmp(bdaddr, &irk->bdaddr) == 0)
-- 
1.8.5.3

