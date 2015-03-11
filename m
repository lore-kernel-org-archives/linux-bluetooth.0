Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix missing rcu_read_unlock() in hci_bdaddr_is_paired()
Date: Wed, 11 Mar 2015 08:55:51 +0200
Message-Id: <1426056951-3412-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When finding a matching LTK the rcu_read_unlock() function was failing
to release the RCU read lock. This patch adds the missing call to
rcu_reaD_unlock().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a35d8441187a..4eba9d6fc9a5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2535,8 +2535,10 @@ bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
-		if (k->bdaddr_type == addr_type && !bacmp(bdaddr, &k->bdaddr))
+		if (k->bdaddr_type == addr_type && !bacmp(bdaddr, &k->bdaddr)) {
+			rcu_read_unlock();
 			return true;
+		}
 	}
 	rcu_read_unlock();
 
-- 
2.1.0

