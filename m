Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v7 02/11] Bluetooth: Use connection parameters if any
Date: Mon,  3 Feb 2014 13:56:19 -0300
Message-Id: <1391446588-18729-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391446588-18729-1-git-send-email-andre.guedes@openbossa.org>
References: <1391446588-18729-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes hci_connect_le() so it uses the connection
parameters specified for the certain device. If no parameters
were configured, we use the default values.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 801820f..6797292 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -586,6 +586,7 @@ static int hci_create_le_conn(struct hci_conn *conn)
 static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				    u8 dst_type, u8 sec_level, u8 auth_type)
 {
+	struct hci_conn_params *params;
 	struct hci_conn *conn;
 	int err;
 
@@ -632,8 +633,15 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
 	conn->auth_type = auth_type;
-	conn->le_conn_min_interval = hdev->le_conn_min_interval;
-	conn->le_conn_max_interval = hdev->le_conn_max_interval;
+
+	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+	if (params) {
+		conn->le_conn_min_interval = params->conn_min_interval;
+		conn->le_conn_max_interval = params->conn_max_interval;
+	} else {
+		conn->le_conn_min_interval = hdev->le_conn_min_interval;
+		conn->le_conn_max_interval = hdev->le_conn_max_interval;
+	}
 
 	err = hci_create_le_conn(conn);
 	if (err)
-- 
1.8.5.3

