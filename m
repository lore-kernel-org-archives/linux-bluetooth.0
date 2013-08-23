Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 4/5] Bluetooth: Keep the LE connection parameters in its own structure
Date: Fri, 23 Aug 2013 17:01:10 -0300
Message-Id: <1377288071-3664-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1377288071-3664-1-git-send-email-andre.guedes@openbossa.org>
References: <1377288071-3664-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

This will allow for easier parameterization of these fields. This is
the first step for allowing to change the parameters during runtime.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 13 +++++++++++++
 net/bluetooth/hci_conn.c         | 16 +++++++++-------
 net/bluetooth/hci_core.c         | 11 +++++++++++
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 20dae6d..b354211 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -117,6 +117,17 @@ struct oob_data {
 	u8 randomizer[16];
 };
 
+struct le_conn_param {
+	u16 scan_interval;
+	u16 scan_window;
+	u16 conn_interval_min;
+	u16 conn_interval_max;
+	u16 supervision_timeout;
+	u16 min_ce_lentgh;
+	u16 max_ce_lentgh;
+	u16 conn_latency;
+};
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 struct amp_assoc {
@@ -287,6 +298,8 @@ struct hci_dev {
 
 	struct delayed_work	le_scan_disable;
 
+	struct le_conn_param	le_conn_param;
+
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
 	__u8			adv_data_len;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f081712..97fc61b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -52,6 +52,7 @@ static const struct sco_param sco_param_wideband[] = {
 static void hci_le_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
+	struct le_conn_param *param = &hdev->le_conn_param;
 	struct hci_cp_le_create_conn cp;
 
 	conn->state = BT_CONNECT;
@@ -60,15 +61,16 @@ static void hci_le_create_connection(struct hci_conn *conn)
 	conn->sec_level = BT_SECURITY_LOW;
 
 	memset(&cp, 0, sizeof(cp));
-	cp.scan_interval = __constant_cpu_to_le16(0x0060);
-	cp.scan_window = __constant_cpu_to_le16(0x0030);
+	cp.scan_interval = __cpu_to_le16(param->scan_interval);
+	cp.scan_window = __cpu_to_le16(param->scan_window);
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
-	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
-	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
-	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
-	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
-	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
+	cp.conn_interval_min = __cpu_to_le16(param->conn_interval_min);
+	cp.conn_interval_max = __cpu_to_le16(param->conn_interval_max);
+	cp.supervision_timeout = __cpu_to_le16(param->supervision_timeout);
+	cp.min_ce_len = __constant_cpu_to_le16(param->min_ce_lentgh);
+	cp.max_ce_len = __constant_cpu_to_le16(param->max_ce_lentgh);
+	cp.conn_latency = __constant_cpu_to_le16(param->conn_latency);
 
 	hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
 }
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e6d1350..eac6709 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2098,6 +2098,7 @@ struct hci_dev *hci_alloc_dev(void)
 {
 	struct hci_dev *hdev;
 	struct discovery_param *discov;
+	struct le_conn_param *conn_param;
 
 	hdev = kzalloc(sizeof(struct hci_dev), GFP_KERNEL);
 	if (!hdev)
@@ -2153,6 +2154,16 @@ struct hci_dev *hci_alloc_dev(void)
 	discov->interleaved_inquiry_length = DISCOV_INTERLEAVED_INQUIRY_LEN;
 	discov->bredr_inquiry_length = DISCOV_BREDR_INQUIRY_LEN;
 
+	conn_param = &hdev->le_conn_param;
+	conn_param->scan_interval = 0x0060;
+	conn_param->scan_window = 0x0030;
+	conn_param->conn_interval_min = 0x0028;
+	conn_param->conn_interval_max = 0x0038;
+	conn_param->supervision_timeout = 0x002a;
+	conn_param->min_ce_lentgh = 0x0000;
+	conn_param->max_ce_lentgh = 0x0000;
+	conn_param->conn_latency = 0x0000;
+
 	return hdev;
 }
 EXPORT_SYMBOL(hci_alloc_dev);
-- 
1.8.3.4

