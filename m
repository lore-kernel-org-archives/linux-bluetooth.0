Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 06/13] Bluetooth: Use hci_update_random_address() when connecting LE
Date: Sun, 23 Feb 2014 19:42:22 +0200
Message-Id: <1393177349-361-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we initiate LE connections we need to update the local random
address if necessary. This patch updates the LE connection creation
mechanism to use the new hci_update_random_address() function to set the
own_address_type parameter and to update the local random address if
necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd66c52eff95..4cb337d6401f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -556,16 +556,22 @@ static int hci_create_le_conn(struct hci_conn *conn)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_conn cp;
 	struct hci_request req;
+	u8 own_addr_type;
 	int err;
 
 	hci_req_init(&req, hdev);
 
 	memset(&cp, 0, sizeof(cp));
+
+	err = hci_update_random_address(&req, &own_addr_type);
+	if (err < 0)
+		return err;
+
 	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
 	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
-	cp.own_address_type = conn->src_type;
+	cp.own_address_type = own_addr_type;
 	cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
 	cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
 	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
-- 
1.8.5.3

