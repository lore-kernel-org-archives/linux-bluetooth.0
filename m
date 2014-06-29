Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Use LE connection parameters if known
Date: Sun, 29 Jun 2014 16:43:27 +0200
Message-Id: <1404053007-35603-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the LE connection parameters for connection latency and
supervision timeout are known, then use then. If they are not
know fallback to defaults.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index adb413d77637..e7ee7267f846 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -645,7 +645,8 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	cp.own_address_type = own_addr_type;
 	cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
 	cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
-	cp.supervision_timeout = cpu_to_le16(0x002a);
+	cp.conn_latency = cpu_to_le16(conn->le_conn_latency);
+	cp.supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
 	cp.min_ce_len = cpu_to_le16(0x0000);
 	cp.max_ce_len = cpu_to_le16(0x0000);
 
@@ -767,9 +768,13 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (params) {
 		conn->le_conn_min_interval = params->conn_min_interval;
 		conn->le_conn_max_interval = params->conn_max_interval;
+		conn->le_conn_latency = params->conn_latency;
+		conn->le_supv_timeout = params->supervision_timeout;
 	} else {
 		conn->le_conn_min_interval = hdev->le_conn_min_interval;
 		conn->le_conn_max_interval = hdev->le_conn_max_interval;
+		conn->le_conn_latency = 0x0000;
+		conn->le_supv_timeout = 0x002a;
 	}
 
 	/* If controller is scanning, we stop it since some controllers are
-- 
1.9.3

