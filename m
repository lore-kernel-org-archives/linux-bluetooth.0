Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't try to reject failed LE connections
Date: Tue, 15 Jul 2014 11:51:28 +0300
Message-Id: <1405414288-6903-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The check for the blacklist in hci_le_conn_complete_evt() should be when
we know that we have an actual successful connection (ev->status being
non-zero). This patch fixes this ordering.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bf2926b2e4a9..68d335e193bf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4187,14 +4187,14 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	else
 		addr_type = BDADDR_LE_RANDOM;
 
-	/* Drop the connection if he device is blocked */
-	if (hci_bdaddr_list_lookup(&hdev->blacklist, &conn->dst, addr_type)) {
-		hci_conn_drop(conn);
+	if (ev->status) {
+		hci_le_conn_failed(conn, ev->status);
 		goto unlock;
 	}
 
-	if (ev->status) {
-		hci_le_conn_failed(conn, ev->status);
+	/* Drop the connection if the device is blocked */
+	if (hci_bdaddr_list_lookup(&hdev->blacklist, &conn->dst, addr_type)) {
+		hci_conn_drop(conn);
 		goto unlock;
 	}
 
-- 
1.9.3

