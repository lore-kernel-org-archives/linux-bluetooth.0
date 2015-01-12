Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  3/3] monitor/packet: Fix possbile checkpatch errors
Date: Mon, 12 Jan 2015 17:38:31 +0530
Message-id: <1421064511-25894-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1421064511-25894-1-git-send-email-gowtham.ab@samsung.com>
References: <1421064511-25894-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/packet.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 87b97ad..ebff682 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1052,7 +1052,7 @@ static void print_voice_setting(uint16_t setting)
 		str = "Linear";
 		break;
 	case 0x01:
-		str ="u-law";
+		str = "u-law";
 		break;
 	case 0x02:
 		str = "A-law";
@@ -1096,7 +1096,7 @@ static void print_voice_setting(uint16_t setting)
 		str = "CVSD";
 		break;
 	case 0x01:
-		str ="u-law";
+		str = "u-law";
 		break;
 	case 0x02:
 		str = "A-law";
@@ -2184,7 +2184,7 @@ static void print_channel_map(const uint8_t *map)
 
 			if (count > 1) {
 				print_field("  Channel %u-%u",
-						start, start + count - 1 );
+						start, start + count - 1);
 				count = 0;
 			} else if (count > 0) {
 				print_field("  Channel %u", start);
@@ -2575,7 +2575,7 @@ static const struct {
 					LE_STATE_MASTER_SLAVE	},
 	{ 39, LE_STATE_CONN_SLAVE | LE_STATE_HIGH_DIRECT_ADV |
 					LE_STATE_SLAVE_SLAVE	},
-	{ 40, LE_STATE_CONN_SLAVE| LE_STATE_LOW_DIRECT_ADV |
+	{ 40, LE_STATE_CONN_SLAVE | LE_STATE_LOW_DIRECT_ADV |
 					LE_STATE_SLAVE_SLAVE	},
 	{ 41, LE_STATE_INITIATING | LE_STATE_CONN_SLAVE |
 					LE_STATE_MASTER_SLAVE	},
@@ -2643,7 +2643,7 @@ static void print_le_channel_map(const uint8_t *map)
 
 			if (count > 1) {
 				print_field("  Channel %u-%u",
-						start, start + count - 1 );
+						start, start + count - 1);
 				count = 0;
 			} else if (count > 0) {
 				print_field("  Channel %u", start);
@@ -3900,7 +3900,7 @@ static void create_logic_link_cmd(const void *data, uint8_t size)
 
 static void accept_logic_link_cmd(const void *data, uint8_t size)
 {
-        const struct bt_hci_cmd_accept_logic_link *cmd = data;
+	const struct bt_hci_cmd_accept_logic_link *cmd = data;
 
 	print_phy_handle(cmd->phy_handle);
 	print_flow_spec("TX", cmd->tx_flow_spec);
@@ -3924,7 +3924,7 @@ static void logic_link_cancel_cmd(const void *data, uint8_t size)
 
 static void logic_link_cancel_rsp(const void *data, uint8_t size)
 {
-        const struct bt_hci_rsp_logic_link_cancel *rsp = data;
+	const struct bt_hci_rsp_logic_link_cancel *rsp = data;
 
 	print_status(rsp->status);
 	print_phy_handle(rsp->phy_handle);
@@ -8039,7 +8039,7 @@ void packet_hci_event(struct timeval *tv, uint16_t index,
 	sprintf(extra_str, "(0x%2.2x) plen %d", hdr->evt, hdr->plen);
 
 	print_packet(tv, index, '>', event_color, "HCI Event",
-                                                        event_str, extra_str);
+						event_str, extra_str);
 
 	if (!event_data || !event_data->func) {
 		packet_hexdump(data, size);
-- 
1.9.1

