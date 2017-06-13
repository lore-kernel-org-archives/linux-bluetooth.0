Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v2 5/7] monitor: Add LE Periodic Advertising commands decoding
Date: Tue, 13 Jun 2017 15:18:15 +0200
Message-Id: <20170613131817.18516-6-michal.narajowski@codecoup.pl>
In-Reply-To: <20170613131817.18516-1-michal.narajowski@codecoup.pl>
References: <20170613131817.18516-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

monitor: Add LE Periodic Advertising Create Sync decoding

< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
        Filter policy: Use Periodic Advertiser List (0x01)
        SID: 0x02
        Adv address type: Reserved (0xff)
        Adv address: 00-00-00-00-00-00
        Skip: 0x0201
        Sync timeout: 25630 msec (0x0a03)
        Unused: 0x0a

monitor: Add LE Periodic Advertising Create Sync Cancel decoding

monitor: Add LE Periodic Advertising Terminate Sync decoding

< HCI Command: LE Periodic Advertising Terminate Sync (0x08|0x0046) plen 2
        Sync handle: 0x0201

monitor: Add LE Add Device To Periodic Advertiser List decoding

< HCI Command: LE Add Device To Periodic Advertiser List (0x08|0x0047) plen 8
        Adv address type: Random (0x01)
        Adv address: 07:06:05:04:03:02 (Non-Resolvable)
        SID: 0x08

monitor: Add LE Remove Device From Periodic Advertiser List decoding

< HCI Command: LE Add Device To Periodic Advertiser List (0x08|0x0047) plen 8
        Adv address type: Random (0x01)
        Adv address: 07:06:05:04:03:02 (Non-Resolvable)
        SID: 0x08

monitor: Add LE Clear Periodic Advertiser List decoding

monitor: Add LE Read Periodic Advertiser List Size decoding
---
 monitor/bt.h     | 40 +++++++++++++++++++++++++
 monitor/packet.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 122 insertions(+), 7 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 0aaa58b..7fe5673 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2313,6 +2313,46 @@ struct bt_hci_le_ext_create_conn {
 	uint16_t max_length;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC		0x2044
+struct bt_hci_cmd_le_periodic_adv_create_sync {
+	uint8_t  filter_policy;
+	uint8_t  sid;
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint16_t skip;
+	uint16_t sync_timeout;
+	uint8_t  unused;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL		0x2045
+
+#define BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC		0x2046
+struct bt_hci_cmd_le_periodic_adv_term_sync {
+	uint16_t sync_handle;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_ADD_DEV_PERIODIC_ADV_LIST		0x2047
+struct bt_hci_cmd_le_add_dev_periodic_adv_list {
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  sid;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_REMOVE_DEV_PERIODIC_ADV_LIST		0x2048
+struct bt_hci_cmd_le_remove_dev_periodic_adv_list {
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  sid;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_CLEAR_PERIODIC_ADV_LIST		0x2049
+
+#define BT_HCI_CMD_LE_READ_PERIODIC_ADV_LIST_SIZE		0x204a
+struct bt_hci_rsp_le_read_dev_periodic_adv_list_size {
+	uint8_t  status;
+	uint8_t  list_size;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 2a970e6..9a75e43 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7562,6 +7562,67 @@ static void le_ext_create_conn_cmd(const void *data, uint8_t size)
 	}
 }
 
+static void le_periodic_adv_create_sync_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_periodic_adv_create_sync *cmd = data;
+	const char *str;
+
+	switch (cmd->filter_policy) {
+	case 0x00:
+		str = "Use specified advertising parameters";
+		break;
+	case 0x01:
+		str = "Use Periodic Advertiser List";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Filter policy: %s (0x%2.2x)", str, cmd->filter_policy);
+	print_field("SID: 0x%2.2x", cmd->sid);
+	print_addr_type("Adv address type", cmd->addr_type);
+	print_addr("Adv address", cmd->addr, cmd->addr_type);
+	print_field("Skip: 0x%4.4x", cmd->skip);
+	print_field("Sync timeout: %d msec (0x%4.4x)",
+					le16_to_cpu(cmd->sync_timeout) * 10,
+					le16_to_cpu(cmd->sync_timeout));
+	print_field("Unused: 0x%2.2x", cmd->unused);
+}
+
+static void le_periodic_adv_term_sync_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_periodic_adv_term_sync *cmd = data;
+
+	print_field("Sync handle: 0x%4.4x", cmd->sync_handle);
+}
+
+static void le_add_dev_periodic_adv_list_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_add_dev_periodic_adv_list *cmd = data;
+
+	print_addr_type("Adv address type", cmd->addr_type);
+	print_addr("Adv address", cmd->addr, cmd->addr_type);
+	print_field("SID: 0x%2.2x", cmd->sid);
+}
+
+static void le_remove_dev_periodic_adv_list_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_remove_dev_periodic_adv_list *cmd = data;
+
+	print_addr_type("Adv address type", cmd->addr_type);
+	print_addr("Adv address", cmd->addr, cmd->addr_type);
+	print_field("SID: 0x%2.2x", cmd->sid);
+}
+
+static void le_read_periodic_adv_list_size_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_dev_periodic_adv_list_size *rsp = data;
+
+	print_status(rsp->status);
+	print_field("List size: 0x%2.2x", rsp->list_size);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8316,13 +8377,27 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2043, 303, "LE Extended Create Connection",
 				le_ext_create_conn_cmd, 10, false,
 				status_rsp, 1, true },
-	{ 0x2044, 304, "LE Periodic Advertising Create Sync" },
-	{ 0x2045, 305, "LE Periodic Advertising Create Sync Cancel" },
-	{ 0x2046, 306, "LE Periodic Advertising Terminate Sync" },
-	{ 0x2047, 307, "LE Add Device To Periodic Advertiser List" },
-	{ 0x2048, 308, "LE Remove Device From Periodic Advertiser List" },
-	{ 0x2049, 309, "LE Clear Periodic Advertiser List" },
-	{ 0x204a, 310, "LE Read Periodic Advertiser List Size" },
+	{ 0x2044, 304, "LE Periodic Advertising Create Sync",
+				le_periodic_adv_create_sync_cmd, 14, true,
+				status_rsp, 1, true },
+	{ 0x2045, 305, "LE Periodic Advertising Create Sync Cancel",
+				null_cmd, 0, true,
+				status_rsp, 1, true },
+	{ 0x2046, 306, "LE Periodic Advertising Terminate Sync",
+				le_periodic_adv_term_sync_cmd, 2, true,
+				status_rsp, 1, true },
+	{ 0x2047, 307, "LE Add Device To Periodic Advertiser List",
+				le_add_dev_periodic_adv_list_cmd, 8, true,
+				status_rsp, 1, true },
+	{ 0x2048, 308, "LE Remove Device From Periodic Advertiser List",
+				le_remove_dev_periodic_adv_list_cmd, 8, true,
+				status_rsp, 1, true },
+	{ 0x2049, 309, "LE Clear Periodic Advertiser List",
+				null_cmd, 0, true,
+				status_rsp, 1, true },
+	{ 0x204a, 310, "LE Read Periodic Advertiser List Size",
+				null_cmd, 0, true,
+				le_read_periodic_adv_list_size_rsp, 2, true },
 	{ 0x204b, 311, "LE Read Transmit Power" },
 	{ 0x204c, 312, "LE Read RF Path Compensation" },
 	{ 0x204d, 313, "LE Write RF Path Compensation" },
-- 
2.9.3

