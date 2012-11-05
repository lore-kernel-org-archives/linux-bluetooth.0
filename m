Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 1/3] Bluetooth: Keep the LE connection parameters in its own structure
Date: Mon,  5 Nov 2012 14:25:41 +0100
Message-Id: <1352121943-18001-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1352121943-18001-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1352121943-18001-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow for easier parameterization of these fields. This is
the first step for allowing to change the parameters during runtime.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 10 ++++++++++
 net/bluetooth/hci_conn.c         | 11 ++++++-----
 net/bluetooth/hci_event.c        | 10 ++++++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ce6dbeb..f477d43 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -123,6 +123,14 @@ struct le_scan_params {
 	int timeout;
 };
 
+struct le_conn_params {
+	u16 scan_interval;
+	u16 scan_window;
+	u16 conn_interval_min;
+	u16 conn_interval_max;
+	u16 supervision_timeout;
+};
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 struct amp_assoc {
@@ -278,6 +286,8 @@ struct hci_dev {
 	struct work_struct	le_scan;
 	struct le_scan_params	le_scan_params;
 
+	struct le_conn_params	le_conn_params;
+
 	__s8			adv_tx_power;
 
 	int (*open)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 25bfce0..d8ff5c0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -35,6 +35,7 @@ static void hci_le_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_conn cp;
+	struct le_conn_params *params = &hdev->le_conn_params;
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
@@ -42,13 +43,13 @@ static void hci_le_create_connection(struct hci_conn *conn)
 	conn->sec_level = BT_SECURITY_LOW;
 
 	memset(&cp, 0, sizeof(cp));
-	cp.scan_interval = __constant_cpu_to_le16(0x0060);
-	cp.scan_window = __constant_cpu_to_le16(0x0030);
+	cp.scan_interval = __cpu_to_le16(params->scan_interval);
+	cp.scan_window = __cpu_to_le16(params->scan_window);
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
-	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
-	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
-	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
+	cp.conn_interval_min = __cpu_to_le16(params->conn_interval_min);
+	cp.conn_interval_max = __cpu_to_le16(params->conn_interval_max);
+	cp.supervision_timeout = __cpu_to_le16(params->supervision_timeout);
 	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
 	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c08ac7c..3675dbd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1298,6 +1298,16 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 			hdev->host_features[0] |= LMP_HOST_LE_BREDR;
 		else
 			hdev->host_features[0] &= ~LMP_HOST_LE_BREDR;
+
+		if (sent->le || sent->simul) {
+			struct le_conn_params *params = &hdev->le_conn_params;
+
+			params->scan_interval = 0x0060;
+			params->scan_window = 0x0030;
+			params->conn_interval_min = 0x0028;
+			params->conn_interval_max = 0x0038;
+			params->supervision_timeout = 0x002a;
+		}
 	}
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
-- 
1.7.12.4

