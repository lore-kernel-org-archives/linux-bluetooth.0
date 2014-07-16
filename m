Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Fix trying to initiate connections when acting as LE slave
Date: Wed, 16 Jul 2014 11:56:09 +0300
Message-Id: <1405500969-17578-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1405500969-17578-1-git-send-email-johan.hedberg@gmail.com>
References: <1405500969-17578-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we have at least one LE slave connection most (probably all)
controllers will refuse to initiate any new connections. To avoid
unnecessary failures simply check for this situation up-front and skip
the connection attempt.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c68b93e11686..e54db7f0590b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4246,6 +4246,12 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 	if (hci_bdaddr_list_lookup(&hdev->blacklist, addr, addr_type))
 		return;
 
+	/* Most controller will fail if we try to create new connections
+	 * while we have an existing one in slave role.
+	 */
+	if (hdev->conn_hash.le_num_slave > 0)
+		return;
+
 	/* If we're connectable, always connect any ADV_DIRECT_IND event */
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
 	    adv_type == LE_ADV_DIRECT_IND)
-- 
1.9.3

