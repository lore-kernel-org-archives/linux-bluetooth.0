Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Use continuous scanning when creating LE connections
Date: Thu,  3 Dec 2015 12:45:19 +0200
Message-Id: <1449139520-950-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All LE connections are now triggered through a preceding passive scan
and waiting for a connectable advertising report. This means we've got
the best possible guarantee that the device is within range and should
be able to request the controller to perform continuous scanning. This
way we minimize the risk that we miss out on any advertising packets.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable@vger.kernel.org # 4.3+
---
 net/bluetooth/hci_conn.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e2600213cd50..48a7eac6ef71 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -726,8 +726,12 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	if (hci_update_random_address(req, false, &own_addr_type))
 		return;
 
+	/* Set window to be the same value as the interval to enable
+	 * continuous scanning.
+	 */
 	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
-	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
+	cp.scan_window = cp.scan_interval;
+
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
 	cp.own_address_type = own_addr_type;
-- 
2.5.0

