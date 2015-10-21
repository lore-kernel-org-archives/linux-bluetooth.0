Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/13] Bluetooth: 6lowpan: Use hci_conn_hash_lookup_le() when possible
Date: Wed, 21 Oct 2015 18:03:02 +0300
Message-Id: <1445439791-2151-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
References: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Use the new hci_conn_hash_lookup_le() API to look up LE connections.
This way we're guaranteed exact matches that also take into account
the address type.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 4057d6e6d8d5..d85af2385486 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1113,7 +1113,7 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
 		return -ENOENT;
 
 	hci_dev_lock(hdev);
-	hcon = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
+	hcon = hci_conn_hash_lookup_le(hdev, addr, *addr_type);
 	hci_dev_unlock(hdev);
 
 	if (!hcon)
-- 
2.5.0

