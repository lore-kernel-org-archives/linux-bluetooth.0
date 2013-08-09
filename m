Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 4/6] Bluetooth: Keep the LE connection parameters in its own structure
Date: Fri,  9 Aug 2013 20:12:32 -0300
Message-Id: <1376089954-13639-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
References: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

This will allow for easier parameterization of these fields. This is
the first step for allowing to change the parameters during runtime.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 10 ++++++++++
 net/bluetooth/hci_conn.c         | 11 ++++++-----
 net/bluetooth/hci_core.c         |  8 ++++++++
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0a02fdb..24b91ae 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -117,6 +117,14 @@ struct oob_data {
 	u8 randomizer[16];
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
@@ -287,6 +295,8 @@ struct hci_dev {
 
 	struct delayed_work	le_scan_disable;
 
+	struct le_conn_params	le_conn_params;
+
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
 	__u8			adv_data_len;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6c7f363..f944757 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -34,6 +34,7 @@
 static void hci_le_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
+	struct le_conn_params *params = &hdev->le_conn_params;
 	struct hci_cp_le_create_conn cp;
 
 	conn->state = BT_CONNECT;
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
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8750663..806d0c3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2079,6 +2079,7 @@ struct hci_dev *hci_alloc_dev(void)
 {
 	struct hci_dev *hdev;
 	struct discovery_param *discov;
+	struct le_conn_params *conn_params;
 
 	hdev = kzalloc(sizeof(struct hci_dev), GFP_KERNEL);
 	if (!hdev)
@@ -2134,6 +2135,13 @@ struct hci_dev *hci_alloc_dev(void)
 	discov->interleaved_inquiry_length = DISCOV_INTERLEAVED_INQUIRY_LEN;
 	discov->bredr_inquiry_length = DISCOV_BREDR_INQUIRY_LEN;
 
+	conn_params = &hdev->le_conn_params;
+	conn_params->scan_interval = 0x0060;
+	conn_params->scan_window = 0x0030;
+	conn_params->conn_interval_min = 0x0028;
+	conn_params->conn_interval_max = 0x0038;
+	conn_params->supervision_timeout = 0x002a;
+
 	return hdev;
 }
 EXPORT_SYMBOL(hci_alloc_dev);
-- 
1.8.3.4

