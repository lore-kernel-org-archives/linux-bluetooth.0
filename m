Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/10] Bluetooth: Use hci_get_own_address_type() when connecting LE
Date: Sun, 23 Feb 2014 16:23:53 +0200
Message-Id: <1393165438-13610-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
References: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we initiate LE connections we need to update the local random
address if necessary. This patch updates the LE connection creation
mechanism to use the new hci_get_own_address_type() function to set the
own_address_type parameter and to update the local random address if
necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd66c52eff95..5be2a05f2795 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -564,7 +564,7 @@ static int hci_create_le_conn(struct hci_conn *conn)
 	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
 	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
 	bacpy(&cp.peer_addr, &conn->dst);
-	cp.peer_addr_type = conn->dst_type;
+	cp.peer_addr_type = hci_get_own_address_type(&req);
 	cp.own_address_type = conn->src_type;
 	cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
 	cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
-- 
1.8.5.3

