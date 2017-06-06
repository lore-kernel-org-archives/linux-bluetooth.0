Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 18/31] monitor: Add LE Periodic Advertising Create Sync decoding
Date: Tue,  6 Jun 2017 11:41:07 +0200
Message-Id: <20170606094120.14541-21-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
        Filter policy: Use Periodic Advertiser List (0x01)
        SID: 0x02
        Adv address type: Reserved (0xff)
        Adv address: 00-00-00-00-00-00
        Skip: 0x0201
        Sync timeout: 25630 msec (0x0a03)
        Unused: 0x0a
---
 monitor/bt.h     | 11 +++++++++++
 monitor/packet.c | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index d98d4b6..014cde6 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2313,6 +2313,17 @@ struct bt_hci_le_ext_create_conn {
 	uint16_t  max_length;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC		0x2044
+struct bt_hci_cmd_le_periodic_adv_create_sync {
+	uint8_t  filter_policy;
+	uint8_t  sid;
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint16_t  skip;
+	uint16_t  sync_timeout;
+	uint8_t  unused;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 3278abf..273f06f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7556,6 +7556,34 @@ static void le_ext_create_conn_cmd(const void *data, uint8_t size)
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
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8310,7 +8338,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2043, 303, "LE Extended Create Connection",
 				le_ext_create_conn_cmd, 10, false,
 				status_rsp, 1, true },
-	{ 0x2044, 304, "LE Periodic Advertising Create Sync" },
+	{ 0x2044, 304, "LE Periodic Advertising Create Sync",
+				le_periodic_adv_create_sync_cmd, 14, true,
+				status_rsp, 1, true },
 	{ 0x2045, 305, "LE Periodic Advertising Create Sync Cancel" },
 	{ 0x2046, 306, "LE Periodic Advertising Terminate Sync" },
 	{ 0x2047, 307, "LE Add Device To Periodic Advertiser List" },
-- 
2.9.3

