Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: Move memset closer to where it's needed
Date: Wed,  9 Mar 2016 17:30:32 +0200
Message-Id: <1457537434-32250-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Minor fix to not do the memset until the variable it clears is
actually used.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 32575b49f4a0..7264025dc781 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -726,14 +726,14 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	struct hci_dev *hdev = conn->hdev;
 	u8 own_addr_type;
 
-	memset(&cp, 0, sizeof(cp));
-
 	/* Update random address, but set require_privacy to false so
 	 * that we never connect with an non-resolvable address.
 	 */
 	if (hci_update_random_address(req, false, &own_addr_type))
 		return;
 
+	memset(&cp, 0, sizeof(cp));
+
 	/* Set window to be the same value as the interval to enable
 	 * continuous scanning.
 	 */
-- 
2.5.0

