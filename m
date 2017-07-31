Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v5 08/11] monitor: Fix connection latency decoding
Date: Mon, 31 Jul 2017 15:39:07 +0200
Message-Id: <20170731133910.26745-9-michal.narajowski@codecoup.pl>
In-Reply-To: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
References: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Connection Latency is a number, not time
---
 monitor/packet.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index fec952a12..fb299084d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2431,6 +2431,12 @@ static void print_window(uint16_t window)
 	print_slot_625("Window", window);
 }
 
+static void print_conn_latency(const char *label, uint16_t value)
+{
+	print_field("%s: %u (0x%4.4x)", label, le16_to_cpu(value),
+							le16_to_cpu(value));
+}
+
 static void print_role(uint8_t role)
 {
 	const char *str;
@@ -6623,7 +6629,7 @@ static void le_create_conn_cmd(const void *data, uint8_t size)
 
 	print_slot_125("Min connection interval", cmd->min_interval);
 	print_slot_125("Max connection interval", cmd->max_interval);
-	print_field("Connection latency: 0x%4.4x", le16_to_cpu(cmd->latency));
+	print_conn_latency("Connection latency", cmd->latency);
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(cmd->supv_timeout) * 10,
 					le16_to_cpu(cmd->supv_timeout));
@@ -6662,7 +6668,7 @@ static void le_conn_update_cmd(const void *data, uint8_t size)
 	print_handle(cmd->handle);
 	print_slot_125("Min connection interval", cmd->min_interval);
 	print_slot_125("Max connection interval", cmd->max_interval);
-	print_field("Connection latency: 0x%4.4x", le16_to_cpu(cmd->latency));
+	print_conn_latency("Connection latency", cmd->latency);
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(cmd->supv_timeout) * 10,
 					le16_to_cpu(cmd->supv_timeout));
@@ -6806,7 +6812,7 @@ static void le_conn_param_req_reply_cmd(const void *data, uint8_t size)
 	print_handle(cmd->handle);
 	print_slot_125("Min connection interval", cmd->min_interval);
 	print_slot_125("Max connection interval", cmd->max_interval);
-	print_field("Connection latency: 0x%4.4x", le16_to_cpu(cmd->latency));
+	print_conn_latency("Connection latency", cmd->latency);
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(cmd->supv_timeout) * 10,
 					le16_to_cpu(cmd->supv_timeout));
@@ -7695,9 +7701,8 @@ static void print_ext_conn_phys(const void *data, uint8_t flags)
 							entry->min_interval);
 			print_slot_125("  Max connection interval",
 							entry->max_interval);
-			print_field("  Connection latency: %u (0x%4.4x)",
-						le16_to_cpu(entry->latency),
-						le16_to_cpu(entry->latency));
+			print_conn_latency("  Connection latency",
+								entry->latency);
 			print_field("  Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(entry->supv_timeout) * 10,
 					le16_to_cpu(entry->supv_timeout));
@@ -9587,7 +9592,7 @@ static void le_conn_complete_evt(const void *data, uint8_t size)
 	print_peer_addr_type("Peer address type", evt->peer_addr_type);
 	print_addr("Peer address", evt->peer_addr, evt->peer_addr_type);
 	print_slot_125("Connection interval", evt->interval);
-	print_slot_125("Connection latency", evt->latency);
+	print_conn_latency("Connection latency", evt->latency);
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));
@@ -9632,7 +9637,7 @@ static void le_conn_update_complete_evt(const void *data, uint8_t size)
 	print_status(evt->status);
 	print_handle(evt->handle);
 	print_slot_125("Connection interval", evt->interval);
-	print_slot_125("Connection latency", evt->latency);
+	print_conn_latency("Connection latency", evt->latency);
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));
@@ -9663,7 +9668,7 @@ static void le_conn_param_request_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 	print_slot_125("Min connection interval", evt->min_interval);
 	print_slot_125("Max connection interval", evt->max_interval);
-	print_field("Connection latency: 0x%4.4x", le16_to_cpu(evt->latency));
+	print_conn_latency("Connection latency", evt->latency);
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));
@@ -9708,7 +9713,7 @@ static void le_enhanced_conn_complete_evt(const void *data, uint8_t size)
 	print_addr("Local resolvable private address", evt->local_rpa, 0x01);
 	print_addr("Peer resolvable private address", evt->peer_rpa, 0x01);
 	print_slot_125("Connection interval", evt->interval);
-	print_slot_125("Connection latency", evt->latency);
+	print_conn_latency("Connection latency", evt->latency);
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));
@@ -11159,7 +11164,7 @@ static void mgmt_print_connection_parameter(const void *data)
 	mgmt_print_address(data, address_type);
 	print_field("Min connection interval: %u", min_conn_interval);
 	print_field("Max connection interval: %u", max_conn_interval);
-	print_field("Connection latency: %u", conn_latency);
+	print_conn_latency("Connection latency", conn_latency);
 	print_field("Supervision timeout: %u", supv_timeout);
 }
 
-- 
2.11.0

