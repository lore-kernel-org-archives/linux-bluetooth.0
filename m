Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Reuse hci_stop_discovery function when cleaning up HCI state
Date: Tue, 10 Jun 2014 14:05:59 +0300
Message-Id: <1402398359-1602-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1402398359-1602-1-git-send-email-johan.hedberg@gmail.com>
References: <1402398359-1602-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When cleaning up the HCI state as part of the power-off procedure we can
reuse the hci_stop_discovery() function instead of explicitly sending
HCI command related to discovery. The added benefit of this is that it
takes care of canceling name resolving and inquiry which were not
previously covered by the code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index be6f03219121..6107e037cd8e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1100,9 +1100,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		disable_advertising(&req);
 
-	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
-		hci_req_add_le_scan_disable(&req);
-	}
+	hci_stop_discovery(&req);
 
 	list_for_each_entry(conn, &hdev->conn_hash.list, list) {
 		struct hci_cp_disconnect dc;
-- 
1.9.3

