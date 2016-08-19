Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Leigh Fiddes <leigh.fiddes@atomos.com>
Subject: [Proposed Patch Bluez v5] btmon: Print connection latency correctly
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Message-ID: <155e0135-7d14-259d-322b-a582afb979c9@atomos.com>
Date: Fri, 19 Aug 2016 17:00:17 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I submit the following small patch for consideration.
Leigh
---

In at least two places the Connection Latency field was being displayed by btmon in units of 1.25mS,
which is incorrect. Print in decimal instead of hex as it is a number.

--
 monitor/packet.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 259c20b..9b9b037 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -6226,7 +6226,7 @@ static void le_create_conn_cmd(const void *data, uint8_t size)
 
 	print_slot_125("Min connection interval", cmd->min_interval);
 	print_slot_125("Max connection interval", cmd->max_interval);
-	print_field("Connection latency: 0x%4.4x", le16_to_cpu(cmd->latency));
+	print_field("Connection latency: %u", le16_to_cpu(cmd->latency));
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(cmd->supv_timeout) * 10,
 					le16_to_cpu(cmd->supv_timeout));
@@ -6265,7 +6265,7 @@ static void le_conn_update_cmd(const void *data, uint8_t size)
 	print_handle(cmd->handle);
 	print_slot_125("Min connection interval", cmd->min_interval);
 	print_slot_125("Max connection interval", cmd->max_interval);
-	print_field("Connection latency: 0x%4.4x", le16_to_cpu(cmd->latency));
+	print_field("Connection latency: %u", le16_to_cpu(cmd->latency));
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(cmd->supv_timeout) * 10,
 					le16_to_cpu(cmd->supv_timeout));
@@ -6409,7 +6409,7 @@ static void le_conn_param_req_reply_cmd(const void *data, uint8_t size)
 	print_handle(cmd->handle);
 	print_slot_125("Min connection interval", cmd->min_interval);
 	print_slot_125("Max connection interval", cmd->max_interval);
-	print_field("Connection latency: 0x%4.4x", le16_to_cpu(cmd->latency));
+	print_field("Connection latency: %u", le16_to_cpu(cmd->latency));
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(cmd->supv_timeout) * 10,
 					le16_to_cpu(cmd->supv_timeout));
@@ -8218,7 +8218,7 @@ static void le_conn_complete_evt(const void *data, uint8_t size)
 	print_peer_addr_type("Peer address type", evt->peer_addr_type);
 	print_addr("Peer address", evt->peer_addr, evt->peer_addr_type);
 	print_slot_125("Connection interval", evt->interval);
-	print_slot_125("Connection latency", evt->latency);
+	print_field("Connection latency: %d", le16_to_cpu(evt->latency));
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));
@@ -8263,7 +8263,7 @@ static void le_conn_update_complete_evt(const void *data, uint8_t size)
 	print_status(evt->status);
 	print_handle(evt->handle);
 	print_slot_125("Connection interval", evt->interval);
-	print_slot_125("Connection latency", evt->latency);
+	print_field("Connection latency: %d", le16_to_cpu(evt->latency));
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));
@@ -8294,7 +8294,7 @@ static void le_conn_param_request_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 	print_slot_125("Min connection interval", evt->min_interval);
 	print_slot_125("Max connection interval", evt->max_interval);
-	print_field("Connection latency: 0x%4.4x", le16_to_cpu(evt->latency));
+	print_field("Connection latency: %d", le16_to_cpu(evt->latency));
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));
@@ -8339,7 +8339,7 @@ static void le_enhanced_conn_complete_evt(const void *data, uint8_t size)
 	print_addr("Local resolvable private address", evt->local_rpa, 0x01);
 	print_addr("Peer resolvable private address", evt->peer_rpa, 0x01);
 	print_slot_125("Connection interval", evt->interval);
-	print_slot_125("Connection latency", evt->latency);
+	print_field("Connection latency: %d", le16_to_cpu(evt->latency));
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));

