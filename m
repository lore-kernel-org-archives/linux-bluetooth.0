Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 06/15] Bluetooth: Use connection parameters if any
Date: Tue, 29 Oct 2013 10:25:51 -0300
Message-Id: <1383053160-10175-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes hci_connect_le() so it uses the connection
parameters specified for the certain device. If no parameters
were configured, we use the default values.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 195b78f..075d070 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -608,6 +608,7 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *conn;
 	int err;
+	struct hci_conn_params *params;
 
 	if (test_bit(HCI_ADVERTISING, &hdev->flags))
 		return ERR_PTR(-ENOTSUPP);
@@ -652,8 +653,16 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
 	conn->auth_type = auth_type;
-	conn->conn_interval_min = hdev->le_conn_min_interval;
-	conn->conn_interval_max = hdev->le_conn_max_interval;
+
+	params = hci_find_conn_params(hdev, &conn->dst, conn->dst_type);
+	if (params) {
+		conn->conn_interval_min = params->conn_interval_min;
+		conn->conn_interval_max = params->conn_interval_max;
+		hci_conn_params_put(params);
+	} else {
+		conn->conn_interval_min = hdev->le_conn_min_interval;
+		conn->conn_interval_max = hdev->le_conn_max_interval;
+	}
 
 	err = hci_create_le_conn(conn);
 	if (err)
-- 
1.8.4

