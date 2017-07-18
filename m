Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] monitor: Filter duplicated advertisements
Date: Tue, 18 Jul 2017 19:46:23 +0300
Message-Id: <20170718164627.20114-3-luiz.dentz@gmail.com>
In-Reply-To: <20170718164627.20114-1-luiz.dentz@gmail.com>
References: <20170718164627.20114-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reduces the verbosity and give a precise picture of how unique
each report is.
---
 monitor/intel.c  |  28 +++---
 monitor/packet.c | 277 ++++++++++++++++++++++++++++++++++++-------------------
 monitor/vendor.h |   2 +-
 3 files changed, 198 insertions(+), 109 deletions(-)

diff --git a/monitor/intel.c b/monitor/intel.c
index 1ca9a95..9da188a 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -499,11 +499,11 @@ const struct vendor_ocf *intel_vendor_ocf(uint16_t ocf)
 	return NULL;
 }
 
-static void startup_evt(const void *data, uint8_t size)
+static void startup_evt(uint8_t index, const void *data, uint8_t size)
 {
 }
 
-static void fatal_exception_evt(const void *data, uint8_t size)
+static void fatal_exception_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint16_t line = get_le16(data);
 	uint8_t module = get_u8(data + 2);
@@ -514,7 +514,7 @@ static void fatal_exception_evt(const void *data, uint8_t size)
 	print_field("Reason: 0x%2.2x", reason);
 }
 
-static void bootup_evt(const void *data, uint8_t size)
+static void bootup_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint8_t zero = get_u8(data);
 	uint8_t num_packets = get_u8(data + 1);
@@ -617,7 +617,7 @@ static void bootup_evt(const void *data, uint8_t size)
 	print_field("DDC status: %s (0x%2.2x)", str, ddc_status);
 }
 
-static void default_bd_data_evt(const void *data, uint8_t size)
+static void default_bd_data_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint8_t mem_status = get_u8(data);
 	const char *str;
@@ -634,7 +634,7 @@ static void default_bd_data_evt(const void *data, uint8_t size)
 	print_field("Memory status: %s (0x%2.2x)", str, mem_status);
 }
 
-static void secure_send_commands_result_evt(const void *data, uint8_t size)
+static void secure_send_commands_result_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint8_t result = get_u8(data);
 	uint16_t opcode = get_le16(data + 1);
@@ -678,7 +678,7 @@ static void secure_send_commands_result_evt(const void *data, uint8_t size)
 	print_status(status);
 }
 
-static void debug_exception_evt(const void *data, uint8_t size)
+static void debug_exception_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint16_t line = get_le16(data);
 	uint8_t module = get_u8(data + 2);
@@ -689,7 +689,7 @@ static void debug_exception_evt(const void *data, uint8_t size)
 	print_field("Reason: 0x%2.2x", reason);
 }
 
-static void le_link_established_evt(const void *data, uint8_t size)
+static void le_link_established_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint16_t handle = get_le16(data);
 	uint32_t access_addr = get_le32(data + 10);
@@ -703,7 +703,7 @@ static void le_link_established_evt(const void *data, uint8_t size)
 	packet_hexdump(data + 14, size - 14);
 }
 
-static void scan_status_evt(const void *data, uint8_t size)
+static void scan_status_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint8_t enable = get_u8(data);
 
@@ -718,14 +718,14 @@ static void scan_status_evt(const void *data, uint8_t size)
 
 }
 
-static void act_deact_traces_complete_evt(const void *data, uint8_t size)
+static void act_deact_traces_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 
 	print_status(status);
 }
 
-static void lmp_pdu_trace_evt(const void *data, uint8_t size)
+static void lmp_pdu_trace_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint8_t type, len, id;
 	uint16_t handle, count;
@@ -819,14 +819,14 @@ static void lmp_pdu_trace_evt(const void *data, uint8_t size)
 	}
 }
 
-static void write_bd_data_complete_evt(const void *data, uint8_t size)
+static void write_bd_data_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
 
 	print_status(status);
 }
 
-static void sco_rejected_via_lmp_evt(const void *data, uint8_t size)
+static void sco_rejected_via_lmp_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint8_t reason = get_u8(data + 6);
 
@@ -834,7 +834,7 @@ static void sco_rejected_via_lmp_evt(const void *data, uint8_t size)
 	packet_print_error("Reason", reason);
 }
 
-static void ptt_switch_notification_evt(const void *data, uint8_t size)
+static void ptt_switch_notification_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint16_t handle = get_le16(data);
 	uint8_t table = get_u8(data + 2);
@@ -857,7 +857,7 @@ static void ptt_switch_notification_evt(const void *data, uint8_t size)
 	print_field("Packet type table: %s (0x%2.2x)", str, table);
 }
 
-static void system_exception_evt(const void *data, uint8_t size)
+static void system_exception_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint8_t type = get_u8(data);
 	const char *str;
diff --git a/monitor/packet.c b/monitor/packet.c
index cc24165..1ec816c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -42,7 +42,9 @@
 #include "lib/hci.h"
 #include "lib/hci_lib.h"
 
+#include "src/shared/mainloop.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 #include "src/shared/btsnoop.h"
 #include "display.h"
 #include "bt.h"
@@ -100,6 +102,9 @@
 
 #define COLOR_PHY_PACKET		COLOR_BLUE
 
+#define ADV_TIMEOUT			3000
+#define ADV_MAX_CACHE			100
+
 static time_t time_offset = ((time_t) -1);
 static int priority_level = BTSNOOP_PRIORITY_INFO;
 static unsigned long filter_mask = 0;
@@ -267,11 +272,20 @@ void packet_select_index(uint16_t index)
 
 #define MAX_INDEX 16
 
+struct adv_data {
+	struct bt_hci_evt_le_adv_report evt;
+	void *data;
+	size_t frame;
+	int timeout;
+	struct queue *cache;
+};
+
 struct index_data {
 	uint8_t  type;
 	uint8_t  bdaddr[6];
 	uint16_t manufacturer;
 	size_t	frame;
+	struct queue *adv_cache;
 };
 
 static struct index_data index_list[MAX_INDEX];
@@ -7704,14 +7718,14 @@ static const struct vendor_evt *current_vendor_evt(uint8_t evt)
 	return NULL;
 }
 
-static void inquiry_complete_evt(const void *data, uint8_t size)
+static void inquiry_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_complete *evt = data;
 
 	print_status(evt->status);
 }
 
-static void inquiry_result_evt(const void *data, uint8_t size)
+static void inquiry_result_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_result *evt = data;
 
@@ -7727,7 +7741,7 @@ static void inquiry_result_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void conn_complete_evt(const void *data, uint8_t size)
+static void conn_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_conn_complete *evt = data;
 
@@ -7741,7 +7755,7 @@ static void conn_complete_evt(const void *data, uint8_t size)
 		assign_handle(le16_to_cpu(evt->handle), 0x00);
 }
 
-static void conn_request_evt(const void *data, uint8_t size)
+static void conn_request_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_conn_request *evt = data;
 
@@ -7750,7 +7764,7 @@ static void conn_request_evt(const void *data, uint8_t size)
 	print_link_type(evt->link_type);
 }
 
-static void disconnect_complete_evt(const void *data, uint8_t size)
+static void disconnect_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_disconnect_complete *evt = data;
 
@@ -7762,7 +7776,7 @@ static void disconnect_complete_evt(const void *data, uint8_t size)
 		release_handle(le16_to_cpu(evt->handle));
 }
 
-static void auth_complete_evt(const void *data, uint8_t size)
+static void auth_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_auth_complete *evt = data;
 
@@ -7770,7 +7784,7 @@ static void auth_complete_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 }
 
-static void remote_name_request_complete_evt(const void *data, uint8_t size)
+static void remote_name_request_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_name_request_complete *evt = data;
 
@@ -7779,7 +7793,7 @@ static void remote_name_request_complete_evt(const void *data, uint8_t size)
 	print_name(evt->name);
 }
 
-static void encrypt_change_evt(const void *data, uint8_t size)
+static void encrypt_change_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_encrypt_change *evt = data;
 
@@ -7788,7 +7802,7 @@ static void encrypt_change_evt(const void *data, uint8_t size)
 	print_encr_mode_change(evt->encr_mode, evt->handle);
 }
 
-static void change_conn_link_key_complete_evt(const void *data, uint8_t size)
+static void change_conn_link_key_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_change_conn_link_key_complete *evt = data;
 
@@ -7796,7 +7810,7 @@ static void change_conn_link_key_complete_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 }
 
-static void master_link_key_complete_evt(const void *data, uint8_t size)
+static void master_link_key_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_master_link_key_complete *evt = data;
 
@@ -7805,7 +7819,7 @@ static void master_link_key_complete_evt(const void *data, uint8_t size)
 	print_key_flag(evt->key_flag);
 }
 
-static void remote_features_complete_evt(const void *data, uint8_t size)
+static void remote_features_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_features_complete *evt = data;
 
@@ -7814,7 +7828,7 @@ static void remote_features_complete_evt(const void *data, uint8_t size)
 	print_features(0, evt->features, 0x00);
 }
 
-static void remote_version_complete_evt(const void *data, uint8_t size)
+static void remote_version_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_version_complete *evt = data;
 
@@ -7830,7 +7844,7 @@ static void remote_version_complete_evt(const void *data, uint8_t size)
 	}
 }
 
-static void qos_setup_complete_evt(const void *data, uint8_t size)
+static void qos_setup_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_qos_setup_complete *evt = data;
 
@@ -7846,7 +7860,7 @@ static void qos_setup_complete_evt(const void *data, uint8_t size)
 	print_field("Delay variation: %d", le32_to_cpu(evt->delay_variation));
 }
 
-static void cmd_complete_evt(const void *data, uint8_t size)
+static void cmd_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_cmd_complete *evt = data;
 	uint16_t opcode = le16_to_cpu(evt->opcode);
@@ -7942,7 +7956,7 @@ static void cmd_complete_evt(const void *data, uint8_t size)
 	opcode_data->rsp_func(data + 3, size - 3);
 }
 
-static void cmd_status_evt(const void *data, uint8_t size)
+static void cmd_status_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_cmd_status *evt = data;
 	uint16_t opcode = le16_to_cpu(evt->opcode);
@@ -7994,21 +8008,21 @@ static void cmd_status_evt(const void *data, uint8_t size)
 	print_status(evt->status);
 }
 
-static void hardware_error_evt(const void *data, uint8_t size)
+static void hardware_error_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_hardware_error *evt = data;
 
 	print_field("Code: 0x%2.2x", evt->code);
 }
 
-static void flush_occurred_evt(const void *data, uint8_t size)
+static void flush_occurred_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_flush_occurred *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void role_change_evt(const void *data, uint8_t size)
+static void role_change_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_role_change *evt = data;
 
@@ -8017,7 +8031,7 @@ static void role_change_evt(const void *data, uint8_t size)
 	print_role(evt->role);
 }
 
-static void num_completed_packets_evt(const void *data, uint8_t size)
+static void num_completed_packets_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_num_completed_packets *evt = data;
 
@@ -8029,7 +8043,7 @@ static void num_completed_packets_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void mode_change_evt(const void *data, uint8_t size)
+static void mode_change_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_mode_change *evt = data;
 
@@ -8039,7 +8053,7 @@ static void mode_change_evt(const void *data, uint8_t size)
 	print_interval(evt->interval);
 }
 
-static void return_link_keys_evt(const void *data, uint8_t size)
+static void return_link_keys_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_return_link_keys *evt = data;
 	uint8_t i;
@@ -8052,21 +8066,21 @@ static void return_link_keys_evt(const void *data, uint8_t size)
 	}
 }
 
-static void pin_code_request_evt(const void *data, uint8_t size)
+static void pin_code_request_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_pin_code_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void link_key_request_evt(const void *data, uint8_t size)
+static void link_key_request_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_link_key_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void link_key_notify_evt(const void *data, uint8_t size)
+static void link_key_notify_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_link_key_notify *evt = data;
 
@@ -8075,19 +8089,19 @@ static void link_key_notify_evt(const void *data, uint8_t size)
 	print_key_type(evt->key_type);
 }
 
-static void loopback_command_evt(const void *data, uint8_t size)
+static void loopback_command_evt(uint8_t index, const void *data, uint8_t size)
 {
 	packet_hexdump(data, size);
 }
 
-static void data_buffer_overflow_evt(const void *data, uint8_t size)
+static void data_buffer_overflow_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_data_buffer_overflow *evt = data;
 
 	print_link_type(evt->link_type);
 }
 
-static void max_slots_change_evt(const void *data, uint8_t size)
+static void max_slots_change_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_max_slots_change *evt = data;
 
@@ -8095,7 +8109,7 @@ static void max_slots_change_evt(const void *data, uint8_t size)
 	print_field("Max slots: %d", evt->max_slots);
 }
 
-static void clock_offset_complete_evt(const void *data, uint8_t size)
+static void clock_offset_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_clock_offset_complete *evt = data;
 
@@ -8104,7 +8118,7 @@ static void clock_offset_complete_evt(const void *data, uint8_t size)
 	print_clock_offset(evt->clock_offset);
 }
 
-static void conn_pkt_type_changed_evt(const void *data, uint8_t size)
+static void conn_pkt_type_changed_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_conn_pkt_type_changed *evt = data;
 
@@ -8113,14 +8127,14 @@ static void conn_pkt_type_changed_evt(const void *data, uint8_t size)
 	print_pkt_type(evt->pkt_type);
 }
 
-static void qos_violation_evt(const void *data, uint8_t size)
+static void qos_violation_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_qos_violation *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void pscan_mode_change_evt(const void *data, uint8_t size)
+static void pscan_mode_change_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_pscan_mode_change *evt = data;
 
@@ -8128,7 +8142,7 @@ static void pscan_mode_change_evt(const void *data, uint8_t size)
 	print_pscan_mode(evt->pscan_mode);
 }
 
-static void pscan_rep_mode_change_evt(const void *data, uint8_t size)
+static void pscan_rep_mode_change_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_pscan_rep_mode_change *evt = data;
 
@@ -8136,7 +8150,7 @@ static void pscan_rep_mode_change_evt(const void *data, uint8_t size)
 	print_pscan_rep_mode(evt->pscan_rep_mode);
 }
 
-static void flow_spec_complete_evt(const void *data, uint8_t size)
+static void flow_spec_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_flow_spec_complete *evt = data;
 
@@ -8154,7 +8168,7 @@ static void flow_spec_complete_evt(const void *data, uint8_t size)
 	print_field("Access latency: %d", le32_to_cpu(evt->access_latency));
 }
 
-static void inquiry_result_with_rssi_evt(const void *data, uint8_t size)
+static void inquiry_result_with_rssi_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_result_with_rssi *evt = data;
 
@@ -8170,7 +8184,7 @@ static void inquiry_result_with_rssi_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void remote_ext_features_complete_evt(const void *data, uint8_t size)
+static void remote_ext_features_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_ext_features_complete *evt = data;
 
@@ -8180,7 +8194,7 @@ static void remote_ext_features_complete_evt(const void *data, uint8_t size)
 	print_features(evt->page, evt->features, 0x00);
 }
 
-static void sync_conn_complete_evt(const void *data, uint8_t size)
+static void sync_conn_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_sync_conn_complete *evt = data;
 
@@ -8195,7 +8209,7 @@ static void sync_conn_complete_evt(const void *data, uint8_t size)
 	print_air_mode(evt->air_mode);
 }
 
-static void sync_conn_changed_evt(const void *data, uint8_t size)
+static void sync_conn_changed_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_sync_conn_changed *evt = data;
 
@@ -8207,7 +8221,7 @@ static void sync_conn_changed_evt(const void *data, uint8_t size)
 	print_field("TX packet length: %d", le16_to_cpu(evt->tx_pkt_len));
 }
 
-static void sniff_subrating_evt(const void *data, uint8_t size)
+static void sniff_subrating_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_sniff_subrating *evt = data;
 
@@ -8219,7 +8233,7 @@ static void sniff_subrating_evt(const void *data, uint8_t size)
 	print_slot_625("Min local timeout", evt->min_local_timeout);
 }
 
-static void ext_inquiry_result_evt(const void *data, uint8_t size)
+static void ext_inquiry_result_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_ext_inquiry_result *evt = data;
 
@@ -8233,7 +8247,7 @@ static void ext_inquiry_result_evt(const void *data, uint8_t size)
 	print_eir(evt->data, sizeof(evt->data), false);
 }
 
-static void encrypt_key_refresh_complete_evt(const void *data, uint8_t size)
+static void encrypt_key_refresh_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_encrypt_key_refresh_complete *evt = data;
 
@@ -8241,14 +8255,14 @@ static void encrypt_key_refresh_complete_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 }
 
-static void io_capability_request_evt(const void *data, uint8_t size)
+static void io_capability_request_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_io_capability_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void io_capability_response_evt(const void *data, uint8_t size)
+static void io_capability_response_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_io_capability_response *evt = data;
 
@@ -8258,7 +8272,7 @@ static void io_capability_response_evt(const void *data, uint8_t size)
 	print_authentication(evt->authentication);
 }
 
-static void user_confirm_request_evt(const void *data, uint8_t size)
+static void user_confirm_request_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_user_confirm_request *evt = data;
 
@@ -8266,21 +8280,21 @@ static void user_confirm_request_evt(const void *data, uint8_t size)
 	print_passkey(evt->passkey);
 }
 
-static void user_passkey_request_evt(const void *data, uint8_t size)
+static void user_passkey_request_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_user_passkey_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void remote_oob_data_request_evt(const void *data, uint8_t size)
+static void remote_oob_data_request_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_oob_data_request *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 }
 
-static void simple_pairing_complete_evt(const void *data, uint8_t size)
+static void simple_pairing_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_simple_pairing_complete *evt = data;
 
@@ -8288,7 +8302,7 @@ static void simple_pairing_complete_evt(const void *data, uint8_t size)
 	print_bdaddr(evt->bdaddr);
 }
 
-static void link_supv_timeout_changed_evt(const void *data, uint8_t size)
+static void link_supv_timeout_changed_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_link_supv_timeout_changed *evt = data;
 
@@ -8296,14 +8310,14 @@ static void link_supv_timeout_changed_evt(const void *data, uint8_t size)
 	print_timeout(evt->timeout);
 }
 
-static void enhanced_flush_complete_evt(const void *data, uint8_t size)
+static void enhanced_flush_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_enhanced_flush_complete *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void user_passkey_notify_evt(const void *data, uint8_t size)
+static void user_passkey_notify_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_user_passkey_notify *evt = data;
 
@@ -8311,7 +8325,7 @@ static void user_passkey_notify_evt(const void *data, uint8_t size)
 	print_passkey(evt->passkey);
 }
 
-static void keypress_notify_evt(const void *data, uint8_t size)
+static void keypress_notify_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_keypress_notify *evt = data;
 	const char *str;
@@ -8342,7 +8356,7 @@ static void keypress_notify_evt(const void *data, uint8_t size)
 	print_field("Notification type: %s (0x%2.2x)", str, evt->type);
 }
 
-static void remote_host_features_notify_evt(const void *data, uint8_t size)
+static void remote_host_features_notify_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_remote_host_features_notify *evt = data;
 
@@ -8350,7 +8364,7 @@ static void remote_host_features_notify_evt(const void *data, uint8_t size)
 	print_features(1, evt->features, 0x00);
 }
 
-static void phy_link_complete_evt(const void *data, uint8_t size)
+static void phy_link_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_phy_link_complete *evt = data;
 
@@ -8358,14 +8372,14 @@ static void phy_link_complete_evt(const void *data, uint8_t size)
 	print_phy_handle(evt->phy_handle);
 }
 
-static void channel_selected_evt(const void *data, uint8_t size)
+static void channel_selected_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_channel_selected *evt = data;
 
 	print_phy_handle(evt->phy_handle);
 }
 
-static void disconn_phy_link_complete_evt(const void *data, uint8_t size)
+static void disconn_phy_link_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_disconn_phy_link_complete *evt = data;
 
@@ -8374,7 +8388,7 @@ static void disconn_phy_link_complete_evt(const void *data, uint8_t size)
 	print_reason(evt->reason);
 }
 
-static void phy_link_loss_early_warning_evt(const void *data, uint8_t size)
+static void phy_link_loss_early_warning_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_phy_link_loss_early_warning *evt = data;
 	const char *str;
@@ -8405,14 +8419,14 @@ static void phy_link_loss_early_warning_evt(const void *data, uint8_t size)
 	print_field("Reason: %s (0x%2.2x)", str, evt->reason);
 }
 
-static void phy_link_recovery_evt(const void *data, uint8_t size)
+static void phy_link_recovery_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_phy_link_recovery *evt = data;
 
 	print_phy_handle(evt->phy_handle);
 }
 
-static void logic_link_complete_evt(const void *data, uint8_t size)
+static void logic_link_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_logic_link_complete *evt = data;
 
@@ -8422,7 +8436,7 @@ static void logic_link_complete_evt(const void *data, uint8_t size)
 	print_field("TX flow spec: 0x%2.2x", evt->flow_spec);
 }
 
-static void disconn_logic_link_complete_evt(const void *data, uint8_t size)
+static void disconn_logic_link_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_disconn_logic_link_complete *evt = data;
 
@@ -8431,7 +8445,7 @@ static void disconn_logic_link_complete_evt(const void *data, uint8_t size)
 	print_reason(evt->reason);
 }
 
-static void flow_spec_modify_complete_evt(const void *data, uint8_t size)
+static void flow_spec_modify_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_flow_spec_modify_complete *evt = data;
 
@@ -8439,7 +8453,7 @@ static void flow_spec_modify_complete_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 }
 
-static void num_completed_data_blocks_evt(const void *data, uint8_t size)
+static void num_completed_data_blocks_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_num_completed_data_blocks *evt = data;
 
@@ -8454,7 +8468,7 @@ static void num_completed_data_blocks_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void short_range_mode_change_evt(const void *data, uint8_t size)
+static void short_range_mode_change_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_short_range_mode_change *evt = data;
 
@@ -8463,7 +8477,7 @@ static void short_range_mode_change_evt(const void *data, uint8_t size)
 	print_short_range_mode(evt->mode);
 }
 
-static void amp_status_change_evt(const void *data, uint8_t size)
+static void amp_status_change_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_amp_status_change *evt = data;
 
@@ -8471,7 +8485,7 @@ static void amp_status_change_evt(const void *data, uint8_t size)
 	print_amp_status(evt->amp_status);
 }
 
-static void triggered_clock_capture_evt(const void *data, uint8_t size)
+static void triggered_clock_capture_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_triggered_clock_capture *evt = data;
 
@@ -8481,14 +8495,14 @@ static void triggered_clock_capture_evt(const void *data, uint8_t size)
 	print_clock_offset(evt->clock_offset);
 }
 
-static void sync_train_complete_evt(const void *data, uint8_t size)
+static void sync_train_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_sync_train_complete *evt = data;
 
 	print_status(evt->status);
 }
 
-static void sync_train_received_evt(const void *data, uint8_t size)
+static void sync_train_received_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_sync_train_received *evt = data;
 
@@ -8503,7 +8517,7 @@ static void sync_train_received_evt(const void *data, uint8_t size)
 	print_field("Service Data: 0x%2.2x", evt->service_data);
 }
 
-static void slave_broadcast_receive_evt(const void *data, uint8_t size)
+static void slave_broadcast_receive_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_slave_broadcast_receive *evt = data;
 
@@ -8525,7 +8539,7 @@ static void slave_broadcast_receive_evt(const void *data, uint8_t size)
 		packet_hexdump(data + 18, size - 18);
 }
 
-static void slave_broadcast_timeout_evt(const void *data, uint8_t size)
+static void slave_broadcast_timeout_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_slave_broadcast_timeout *evt = data;
 
@@ -8533,7 +8547,7 @@ static void slave_broadcast_timeout_evt(const void *data, uint8_t size)
 	print_lt_addr(evt->lt_addr);
 }
 
-static void truncated_page_complete_evt(const void *data, uint8_t size)
+static void truncated_page_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_truncated_page_complete *evt = data;
 
@@ -8541,18 +8555,18 @@ static void truncated_page_complete_evt(const void *data, uint8_t size)
 	print_bdaddr(evt->bdaddr);
 }
 
-static void slave_page_response_timeout_evt(const void *data, uint8_t size)
+static void slave_page_response_timeout_evt(uint8_t index, const void *data, uint8_t size)
 {
 }
 
-static void slave_broadcast_channel_map_change_evt(const void *data, uint8_t size)
+static void slave_broadcast_channel_map_change_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_slave_broadcast_channel_map_change *evt = data;
 
 	print_channel_map(evt->map);
 }
 
-static void inquiry_response_notify_evt(const void *data, uint8_t size)
+static void inquiry_response_notify_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_inquiry_response_notify *evt = data;
 
@@ -8560,14 +8574,14 @@ static void inquiry_response_notify_evt(const void *data, uint8_t size)
 	print_rssi(evt->rssi);
 }
 
-static void auth_payload_timeout_expired_evt(const void *data, uint8_t size)
+static void auth_payload_timeout_expired_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_auth_payload_timeout_expired *evt = data;
 
 	print_handle(evt->handle);
 }
 
-static void le_conn_complete_evt(const void *data, uint8_t size)
+static void le_conn_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_conn_complete *evt = data;
 
@@ -8587,12 +8601,86 @@ static void le_conn_complete_evt(const void *data, uint8_t size)
 		assign_handle(le16_to_cpu(evt->handle), 0x01);
 }
 
-static void le_adv_report_evt(const void *data, uint8_t size)
+static void adv_free(void *data)
+{
+	struct adv_data *adv = data;
+
+	free(adv->data);
+	free(adv);
+}
+
+static bool match_adv(const void *data, const void *user_data)
+{
+	const struct adv_data *adv = data;
+	const struct bt_hci_evt_le_adv_report *evt = user_data;
+
+	if (memcmp(&adv->evt, evt, sizeof(*evt)))
+		return false;
+
+	return memcmp(adv->data, evt->data, evt->data_len) == 0;
+}
+
+static void adv_timeout(int id, void *data)
+{
+	struct adv_data *adv = data;
+
+	/* Remove from check (adv is freed after returning) */
+	queue_remove(adv->cache, adv);
+
+	mainloop_remove_timeout(adv->timeout);
+}
+
+static void le_adv_report_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_adv_report *evt = data;
+	struct adv_data *match;
+	struct adv_data *adv;
 	uint8_t evt_len;
 	int8_t *rssi;
 
+	if (!index_list[index].adv_cache)
+		index_list[index].adv_cache = queue_new();
+
+	adv = queue_remove_if(index_list[index].adv_cache, match_adv,
+							(void *) evt);
+	if (adv) {
+		/* Update cache and modify expire timeout */
+		if (mainloop_modify_timeout(adv->timeout, ADV_TIMEOUT) < 0) {
+			mainloop_remove_timeout(adv->timeout);
+			adv->timeout = mainloop_add_timeout(ADV_TIMEOUT,
+							adv_timeout, adv,
+							adv_free);
+		}
+		queue_push_head(index_list[index].adv_cache, adv);
+		print_field("Duplicate of #%zu", adv->frame);
+		size = 0;
+		goto rssi;
+	}
+
+	match = new0(struct adv_data, 1);
+	match->evt = *evt;
+
+	match->data = malloc(evt->data_len);
+	memcpy(match->data, evt->data, evt->data_len);
+
+	match->cache = index_list[index].adv_cache;
+	match->frame = index_list[index].frame;
+	match->timeout = mainloop_add_timeout(ADV_TIMEOUT, adv_timeout, match,
+						adv_free);
+	if (match->timeout <= 0) {
+		print_field("Cannot cache: %s (%d)", strerror(-match->timeout),
+							match->timeout);
+		adv_free(match);
+		goto print;
+	}
+
+	queue_push_head(index_list[index].adv_cache, match);
+
+	if (queue_length(index_list[index].adv_cache) > ADV_MAX_CACHE)
+		queue_remove(index_list[index].adv_cache,
+				queue_peek_tail(index_list[index].adv_cache));
+
+print:
 	print_num_reports(evt->num_reports);
 
 report:
@@ -8602,6 +8690,7 @@ report:
 	print_field("Data length: %d", evt->data_len);
 	print_eir(evt->data, evt->data_len, true);
 
+rssi:
 	rssi = (int8_t *) (evt->data + evt->data_len);
 	print_rssi(*rssi);
 
@@ -8615,7 +8704,7 @@ report:
 	}
 }
 
-static void le_conn_update_complete_evt(const void *data, uint8_t size)
+static void le_conn_update_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_conn_update_complete *evt = data;
 
@@ -8628,7 +8717,7 @@ static void le_conn_update_complete_evt(const void *data, uint8_t size)
 					le16_to_cpu(evt->supv_timeout));
 }
 
-static void le_remote_features_complete_evt(const void *data, uint8_t size)
+static void le_remote_features_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_remote_features_complete *evt = data;
 
@@ -8637,7 +8726,7 @@ static void le_remote_features_complete_evt(const void *data, uint8_t size)
 	print_features(0, evt->features, 0x01);
 }
 
-static void le_long_term_key_request_evt(const void *data, uint8_t size)
+static void le_long_term_key_request_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_long_term_key_request *evt = data;
 
@@ -8646,7 +8735,7 @@ static void le_long_term_key_request_evt(const void *data, uint8_t size)
 	print_encrypted_diversifier(evt->ediv);
 }
 
-static void le_conn_param_request_evt(const void *data, uint8_t size)
+static void le_conn_param_request_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_conn_param_request *evt = data;
 
@@ -8659,7 +8748,7 @@ static void le_conn_param_request_evt(const void *data, uint8_t size)
 					le16_to_cpu(evt->supv_timeout));
 }
 
-static void le_data_length_change_evt(const void *data, uint8_t size)
+static void le_data_length_change_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_data_length_change *evt = data;
 
@@ -8670,7 +8759,7 @@ static void le_data_length_change_evt(const void *data, uint8_t size)
 	print_field("Max RX time: %d", le16_to_cpu(evt->max_rx_time));
 }
 
-static void le_read_local_pk256_complete_evt(const void *data, uint8_t size)
+static void le_read_local_pk256_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_read_local_pk256_complete *evt = data;
 
@@ -8678,7 +8767,7 @@ static void le_read_local_pk256_complete_evt(const void *data, uint8_t size)
 	print_pk256("Local P-256 public key", evt->local_pk256);
 }
 
-static void le_generate_dhkey_complete_evt(const void *data, uint8_t size)
+static void le_generate_dhkey_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_generate_dhkey_complete *evt = data;
 
@@ -8686,7 +8775,7 @@ static void le_generate_dhkey_complete_evt(const void *data, uint8_t size)
 	print_dhkey(evt->dhkey);
 }
 
-static void le_enhanced_conn_complete_evt(const void *data, uint8_t size)
+static void le_enhanced_conn_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_enhanced_conn_complete *evt = data;
 
@@ -8708,7 +8797,7 @@ static void le_enhanced_conn_complete_evt(const void *data, uint8_t size)
 		assign_handle(le16_to_cpu(evt->handle), 0x01);
 }
 
-static void le_direct_adv_report_evt(const void *data, uint8_t size)
+static void le_direct_adv_report_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_direct_adv_report *evt = data;
 
@@ -8725,7 +8814,7 @@ static void le_direct_adv_report_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
-static void le_phy_update_complete_evt(const void *data, uint8_t size)
+static void le_phy_update_complete_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_phy_update_complete *evt = data;
 
@@ -8735,7 +8824,7 @@ static void le_phy_update_complete_evt(const void *data, uint8_t size)
 	print_le_phy("RX PHY", evt->rx_phy);
 }
 
-static void le_chan_select_alg_evt(const void *data, uint8_t size)
+static void le_chan_select_alg_evt(uint8_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_chan_select_alg *evt = data;
 	const char *str;
@@ -8760,13 +8849,13 @@ static void le_chan_select_alg_evt(const void *data, uint8_t size)
 struct subevent_data {
 	uint8_t subevent;
 	const char *str;
-	void (*func) (const void *data, uint8_t size);
+	void (*func) (uint8_t index, const void *data, uint8_t size);
 	uint8_t size;
 	bool fixed;
 };
 
 static void print_subevent(const struct subevent_data *subevent_data,
-					const void *data, uint8_t size)
+				uint8_t index, const void *data, uint8_t size)
 {
 	const char *subevent_color;
 
@@ -8797,7 +8886,7 @@ static void print_subevent(const struct subevent_data *subevent_data,
 		}
 	}
 
-	subevent_data->func(data, size);
+	subevent_data->func(index, data, size);
 }
 
 static const struct subevent_data le_meta_event_table[] = {
@@ -8837,7 +8926,7 @@ static const struct subevent_data le_meta_event_table[] = {
 	{ }
 };
 
-static void le_meta_event_evt(const void *data, uint8_t size)
+static void le_meta_event_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint8_t subevent = *((const uint8_t *) data);
 	struct subevent_data unknown;
@@ -8857,10 +8946,10 @@ static void le_meta_event_evt(const void *data, uint8_t size)
 		}
 	}
 
-	print_subevent(subevent_data, data + 1, size - 1);
+	print_subevent(subevent_data, index, data + 1, size - 1);
 }
 
-static void vendor_evt(const void *data, uint8_t size)
+static void vendor_evt(uint8_t index, const void *data, uint8_t size)
 {
 	uint8_t subevent = *((const uint8_t *) data);
 	struct subevent_data vendor_data;
@@ -8881,7 +8970,7 @@ static void vendor_evt(const void *data, uint8_t size)
 		vendor_data.size = vnd->evt_size;
 		vendor_data.fixed = vnd->evt_fixed;
 
-		print_subevent(&vendor_data, data + 1, size - 1);
+		print_subevent(&vendor_data, index, data + 1, size - 1);
 	} else {
 		uint16_t manufacturer;
 
@@ -8897,7 +8986,7 @@ static void vendor_evt(const void *data, uint8_t size)
 struct event_data {
 	uint8_t event;
 	const char *str;
-	void (*func) (const void *data, uint8_t size);
+	void (*func) (uint8_t index, const void *data, uint8_t size);
 	uint8_t size;
 	bool fixed;
 };
@@ -9365,7 +9454,7 @@ void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
 		}
 	}
 
-	event_data->func(data, hdr->plen);
+	event_data->func(index, data, hdr->plen);
 }
 
 void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
diff --git a/monitor/vendor.h b/monitor/vendor.h
index f5792b3..fee1353 100644
--- a/monitor/vendor.h
+++ b/monitor/vendor.h
@@ -38,7 +38,7 @@ struct vendor_ocf {
 struct vendor_evt {
 	uint8_t evt;
 	const char *str;
-	void (*evt_func) (const void *data, uint8_t size);
+	void (*evt_func) (uint8_t index, const void *data, uint8_t size);
 	uint8_t evt_size;
 	bool evt_fixed;
 };
-- 
2.9.4

