Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set addr_type only when it's needed
Date: Fri, 15 Aug 2014 16:39:00 +0300
Message-Id: <1408109940-12309-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In the hci_le_conn_complete_evt() function there's no need to set the
addr_type value until it's actually needed, i.e. for the black list
lookup. This patch moves the code a bit further down in the function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b44b83d4a8e6..827117160ac5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4193,16 +4193,16 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		conn->dst_type = irk->addr_type;
 	}
 
-	if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
-		addr_type = BDADDR_LE_PUBLIC;
-	else
-		addr_type = BDADDR_LE_RANDOM;
-
 	if (ev->status) {
 		hci_le_conn_failed(conn, ev->status);
 		goto unlock;
 	}
 
+	if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
+		addr_type = BDADDR_LE_PUBLIC;
+	else
+		addr_type = BDADDR_LE_RANDOM;
+
 	/* Drop the connection if the device is blocked */
 	if (hci_bdaddr_list_lookup(&hdev->blacklist, &conn->dst, addr_type)) {
 		hci_conn_drop(conn);
-- 
1.9.3

