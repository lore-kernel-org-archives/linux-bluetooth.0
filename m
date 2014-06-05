Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix incorrectly overriding conn->src_type
Date: Thu,  5 Jun 2014 12:19:54 +0300
Message-Id: <1401959994-9611-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1401958444-6623-1-git-send-email-johan.hedberg@gmail.com>
References: <1401958444-6623-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The src_type member of struct hci_conn should always reflect the address
type of the src_member. It should never be overridden. There is already
code in place in the command status handler of HCI_LE_Create_Connection
to copy the right initiator address into conn->init_addr_type.

Without this patch, if privacy is enabled, we will send the wrong
address type in the SMP identity address information PDU (it'll e.g.
contain our public address but a random address type).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Reworded misleading commit message

 net/bluetooth/hci_conn.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1bb8900086dd..7430001570d9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -610,11 +610,6 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	if (hci_update_random_address(req, false, &own_addr_type))
 		return;
 
-	/* Save the address type used for this connnection attempt so we able
-	 * to retrieve this information if we need it.
-	 */
-	conn->src_type = own_addr_type;
-
 	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
 	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
 	bacpy(&cp.peer_addr, &conn->dst);
-- 
1.9.3

