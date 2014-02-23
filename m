Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 12/13] Bluetooth: Fix setting correct src_type when connecting LE
Date: Sun, 23 Feb 2014 19:42:28 +0200
Message-Id: <1393177349-361-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch ensures that conn->src_type contains the same address type as
is used for initiating the connection while the connection attempt is in
progress. Once connected this value will be overwritten with the
identity address type.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4cb337d6401f..a1efa1c62de8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -567,6 +567,8 @@ static int hci_create_le_conn(struct hci_conn *conn)
 	if (err < 0)
 		return err;
 
+	conn->src_type = own_addr_type;
+
 	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
 	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
 	bacpy(&cp.peer_addr, &conn->dst);
@@ -653,7 +655,6 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-ENOMEM);
 
 	conn->dst_type = dst_type;
-	conn->src_type = hdev->own_addr_type;
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
-- 
1.8.5.3

