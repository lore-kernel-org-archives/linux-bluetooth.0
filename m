Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v6 11/11] monitor: Refactor print_enable function
Date: Tue,  8 Aug 2017 10:45:33 +0200
Message-Id: <20170808084533.2323-12-michal.narajowski@codecoup.pl>
In-Reply-To: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
References: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/packet.c | 411 ++++++++-----------------------------------------------
 1 file changed, 57 insertions(+), 354 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 0154e4f9f..f214790ac 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -557,6 +557,25 @@ void packet_print_error(const char *label, uint8_t error)
 	print_error(label, error);
 }
 
+static void print_enable(const char *label, uint8_t enable)
+{
+	const char *str;
+
+	switch (enable) {
+	case 0x00:
+		str = "Disabled";
+		break;
+	case 0x01:
+		str = "Enabled";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("%s: %s (0x%2.2x)", label, str, enable);
+}
+
 static void print_addr_type(const char *label, uint8_t addr_type)
 {
 	const char *str;
@@ -1196,25 +1215,6 @@ static void print_power_level(int8_t level, const char *type)
 								level, level);
 }
 
-static void print_sync_flow_control(uint8_t enable)
-{
-	const char *str;
-
-	switch (enable) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Flow control: %s (0x%2.2x)", str, enable);
-}
-
 static void print_host_flow_control(uint8_t enable)
 {
 	const char *str;
@@ -1504,44 +1504,6 @@ static void print_pscan_type(uint8_t type)
 	print_field("Type: %s (0x%2.2x)", str, type);
 }
 
-static void print_afh_mode(uint8_t mode)
-{
-	const char *str;
-
-	switch (mode) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Mode: %s (0x%2.2x)", str, mode);
-}
-
-static void print_erroneous_reporting(uint8_t mode)
-{
-	const char *str;
-
-	switch (mode) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Mode: %s (0x%2.2x)", str, mode);
-}
-
 static void print_loopback_mode(uint8_t mode)
 {
 	const char *str;
@@ -1564,63 +1526,6 @@ static void print_loopback_mode(uint8_t mode)
 	print_field("Mode: %s (0x%2.2x)", str, mode);
 }
 
-static void print_simple_pairing_mode(uint8_t mode)
-{
-	const char *str;
-
-	switch (mode) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Mode: %s (0x%2.2x)", str, mode);
-}
-
-static void print_ssp_debug_mode(uint8_t mode)
-{
-	const char *str;
-
-	switch (mode) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Debug mode: %s (0x%2.2x)", str, mode);
-}
-
-static void print_secure_conn_support(uint8_t support)
-{
-	const char *str;
-
-	switch (support) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Support: %s (0x%2.2x)", str, support);
-}
-
 static void print_auth_payload_timeout(uint16_t timeout)
 {
 	print_field("Timeout: %d msec (0x%4.4x)",
@@ -1789,25 +1694,6 @@ static void print_link_type(uint8_t link_type)
 	print_field("Link type: %s (0x%2.2x)", str, link_type);
 }
 
-static void print_encr_mode(uint8_t encr_mode)
-{
-	const char *str;
-
-	switch (encr_mode) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Encryption: %s (0x%2.2x)", str, encr_mode);
-}
-
 static void print_encr_mode_change(uint8_t encr_mode, uint16_t handle)
 {
 	const char *str;
@@ -2246,25 +2132,6 @@ static void print_flow_spec(const char *label, const uint8_t *data)
 	print_field("  Flush timeout: 0x%8.8x", get_le32(data + 12));
 }
 
-static void print_short_range_mode(uint8_t mode)
-{
-	const char *str;
-
-	switch (mode) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Short range mode: %s (0x%2.2x)", str, mode);
-}
-
 static void print_amp_status(uint8_t amp_status)
 {
 	const char *str;
@@ -4427,7 +4294,7 @@ static void set_conn_encrypt_cmd(const void *data, uint8_t size)
 	const struct bt_hci_cmd_set_conn_encrypt *cmd = data;
 
 	print_handle(cmd->handle);
-	print_encr_mode(cmd->encr_mode);
+	print_enable("Encryption", cmd->encr_mode);
 }
 
 static void change_conn_link_key_cmd(const void *data, uint8_t size)
@@ -5374,14 +5241,14 @@ static void read_sync_flow_control_rsp(const void *data, uint8_t size)
 	const struct bt_hci_rsp_read_sync_flow_control *rsp = data;
 
 	print_status(rsp->status);
-	print_sync_flow_control(rsp->enable);
+	print_enable("Flow control", rsp->enable);
 }
 
 static void write_sync_flow_control_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_write_sync_flow_control *cmd = data;
 
-	print_sync_flow_control(cmd->enable);
+	print_enable("Flow control", cmd->enable);
 }
 
 static void set_host_flow_control_cmd(const void *data, uint8_t size)
@@ -5565,14 +5432,14 @@ static void read_afh_assessment_mode_rsp(const void *data, uint8_t size)
 	const struct bt_hci_rsp_read_afh_assessment_mode *rsp = data;
 
 	print_status(rsp->status);
-	print_afh_mode(rsp->mode);
+	print_enable("Mode", rsp->mode);
 }
 
 static void write_afh_assessment_mode_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_write_afh_assessment_mode *cmd = data;
 
-	print_afh_mode(cmd->mode);
+	print_enable("Mode", cmd->mode);
 }
 
 static void read_ext_inquiry_response_rsp(const void *data, uint8_t size)
@@ -5604,14 +5471,14 @@ static void read_simple_pairing_mode_rsp(const void *data, uint8_t size)
 	const struct bt_hci_rsp_read_simple_pairing_mode *rsp = data;
 
 	print_status(rsp->status);
-	print_simple_pairing_mode(rsp->mode);
+	print_enable("Mode", rsp->mode);
 }
 
 static void write_simple_pairing_mode_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_write_simple_pairing_mode *cmd = data;
 
-	print_simple_pairing_mode(cmd->mode);
+	print_enable("Mode", cmd->mode);
 }
 
 static void read_local_oob_data_rsp(const void *data, uint8_t size)
@@ -5643,14 +5510,14 @@ static void read_erroneous_reporting_rsp(const void *data, uint8_t size)
 	const struct bt_hci_rsp_read_erroneous_reporting *rsp = data;
 
 	print_status(rsp->status);
-	print_erroneous_reporting(rsp->mode);
+	print_enable("Mode", rsp->mode);
 }
 
 static void write_erroneous_reporting_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_write_erroneous_reporting *cmd = data;
 
-	print_erroneous_reporting(cmd->mode);
+	print_enable("Mode", cmd->mode);
 }
 
 static void enhanced_flush_cmd(const void *data, uint8_t size)
@@ -5778,7 +5645,7 @@ static void short_range_mode_cmd(const void *data, uint8_t size)
 	const struct bt_hci_cmd_short_range_mode *cmd = data;
 
 	print_phy_handle(cmd->phy_handle);
-	print_short_range_mode(cmd->mode);
+	print_enable("Short range mode", cmd->mode);
 }
 
 static void read_le_host_supported_rsp(const void *data, uint8_t size)
@@ -5888,14 +5755,14 @@ static void read_secure_conn_support_rsp(const void *data, uint8_t size)
 	const struct bt_hci_rsp_read_secure_conn_support *rsp = data;
 
 	print_status(rsp->status);
-	print_secure_conn_support(rsp->support);
+	print_enable("Support", rsp->support);
 }
 
 static void write_secure_conn_support_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_write_secure_conn_support *cmd = data;
 
-	print_secure_conn_support(cmd->support);
+	print_enable("Support", cmd->support);
 }
 
 static void read_auth_payload_timeout_cmd(const void *data, uint8_t size)
@@ -6186,7 +6053,7 @@ static void read_afh_channel_map_rsp(const void *data, uint8_t size)
 
 	print_status(rsp->status);
 	print_handle(rsp->handle);
-	print_afh_mode(rsp->mode);
+	print_enable("Mode", rsp->mode);
 	print_channel_map(rsp->map);
 }
 
@@ -6358,24 +6225,9 @@ static void get_mws_transport_config_rsp(const void *data, uint8_t size)
 static void set_triggered_clock_capture_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_set_triggered_clock_capture *cmd = data;
-	const char *str;
 
 	print_handle(cmd->handle);
-
-	switch (cmd->enable) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Capture: %s (0x%2.2x)", str, cmd->enable);
-
+	print_enable("Capture", cmd->enable);
 	print_clock_type(cmd->type);
 	print_lpo_allowed(cmd->lpo_allowed);
 	print_field("Clock captures to filter: %u", cmd->num_filter);
@@ -6400,7 +6252,7 @@ static void write_ssp_debug_mode_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_write_ssp_debug_mode *cmd = data;
 
-	print_ssp_debug_mode(cmd->mode);
+	print_enable("Debug Mode", cmd->mode);
 }
 
 static void le_set_event_mask_cmd(const void *data, uint8_t size)
@@ -6499,21 +6351,8 @@ static void le_set_scan_rsp_data_cmd(const void *data, uint8_t size)
 static void le_set_adv_enable_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_adv_enable *cmd = data;
-	const char *str;
 
-	switch (cmd->enable) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Advertising: %s (0x%2.2x)", str, cmd->enable);
+	print_enable("Advertising", cmd->enable);
 }
 
 static void print_scan_type(const char *label, uint8_t type)
@@ -6574,35 +6413,9 @@ static void le_set_scan_parameters_cmd(const void *data, uint8_t size)
 static void le_set_scan_enable_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_scan_enable *cmd = data;
-	const char *str;
 
-	switch (cmd->enable) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Scanning: %s (0x%2.2x)", str, cmd->enable);
-
-	switch (cmd->filter_dup) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Filter duplicates: %s (0x%2.2x)", str, cmd->filter_dup);
+	print_enable("Scanning", cmd->enable);
+	print_enable("Filter duplicates", cmd->filter_dup);
 }
 
 static void le_create_conn_cmd(const void *data, uint8_t size)
@@ -6950,21 +6763,8 @@ static void le_read_local_resolv_addr_rsp(const void *data, uint8_t size)
 static void le_set_resolv_enable_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_resolv_enable *cmd = data;
-	const char *str;
-
-	switch (cmd->enable) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
 
-	print_field("Address resolution: %s (0x%2.2x)", str, cmd->enable);
+	print_enable("Address resolution", cmd->enable);
 }
 
 static void le_set_resolv_timeout_cmd(const void *data, uint8_t size)
@@ -7298,21 +7098,7 @@ static void le_set_ext_adv_params_cmd(const void *data, uint8_t size)
 	print_field("Secondary max skip: 0x%2.2x", cmd->secondary_max_skip);
 	print_le_phy("Secondary PHY", cmd->secondary_phy);
 	print_field("SID: 0x%2.2x", cmd->sid);
-
-	switch (cmd->notif_enable) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Scan request notifications: %s (0x%2.2x)",
-							str, cmd->notif_enable);
+	print_enable("Scan request notifications", cmd->notif_enable);
 }
 
 static void le_set_ext_adv_params_rsp(const void *data, uint8_t size)
@@ -7423,22 +7209,9 @@ static void le_set_ext_adv_enable_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_ext_adv_enable *cmd = data;
 	const struct bt_hci_cmd_ext_adv_set *adv_set;
-	const char *str;
 	int i;
 
-	switch (cmd->enable) {
-	case 0x00:
-		str = "Disable";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Extended advertising: %s (0x%2.2x)", str, cmd->enable);
+	print_enable("Extended advertising", cmd->enable);
 
 	if (cmd->num_of_sets == 0)
 		print_field("Number of sets: Disable all sets (0x%2.2x)",
@@ -7555,21 +7328,8 @@ static void le_set_periodic_adv_data_cmd(const void *data, uint8_t size)
 static void le_set_periodic_adv_enable_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_periodic_adv_enable *cmd = data;
-	const char *str;
 
-	switch (cmd->enable) {
-	case 0x00:
-		str = "Disable";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Periodic advertising: %s (0x%2.2x)", str, cmd->enable);
+	print_enable("Periodic advertising", cmd->enable);
 	print_handle(cmd->handle);
 }
 
@@ -7620,50 +7380,12 @@ static void le_set_ext_scan_params_cmd(const void *data, uint8_t size)
 	print_ext_scan_phys(cmd->data, cmd->num_phys);
 }
 
-static void print_enable(const char *label, uint8_t enable)
-{
-	const char *str;
-
-	switch (enable) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("%s: %s (0x%2.2x)", label, str, enable);
-}
-
-static void print_filter_dup(uint8_t filter_dup)
-{
-	const char *str;
-
-	switch (filter_dup) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Filter duplicates: %s (0x%2.2x)", str, filter_dup);
-}
-
 static void le_set_ext_scan_enable_cmd(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_ext_scan_enable *cmd = data;
 
 	print_enable("Extended scan", cmd->enable);
-	print_filter_dup(cmd->filter_dup);
+	print_enable("Filter duplicates", cmd->filter_dup);
 
 	print_field("Duration: %d msec (0x%4.4x)",
 						le16_to_cpu(cmd->duration) * 10,
@@ -8754,7 +8476,7 @@ static void conn_complete_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 	print_bdaddr(evt->bdaddr);
 	print_link_type(evt->link_type);
-	print_encr_mode(evt->encr_mode);
+	print_enable("Encryption", evt->encr_mode);
 
 	if (evt->status == 0x00)
 		assign_handle(le16_to_cpu(evt->handle), 0x00);
@@ -9479,7 +9201,7 @@ static void short_range_mode_change_evt(const void *data, uint8_t size)
 
 	print_status(evt->status);
 	print_phy_handle(evt->phy_handle);
-	print_short_range_mode(evt->mode);
+	print_enable("Short range mode", evt->mode);
 }
 
 static void amp_status_change_evt(const void *data, uint8_t size)
@@ -11007,25 +10729,6 @@ static void mgmt_print_uuid(const void *data)
 				get_le32(&uuid[2]), get_le16(&uuid[0]));
 }
 
-static void mgmt_print_enable(const char *label, uint8_t enable)
-{
-	const char *str;
-
-	switch (enable) {
-	case 0x00:
-		str = "Disabled";
-		break;
-	case 0x01:
-		str = "Enabled";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("%s: %s (0x%2.2x)", label, str, enable);
-}
-
 static void mgmt_print_io_capability(uint8_t capability)
 {
 	const char *str;
@@ -11344,7 +11047,7 @@ static void mgmt_set_powered_cmd(const void *data, uint16_t size)
 {
 	uint8_t enable = get_u8(data);
 
-	mgmt_print_enable("Powered", enable);
+	print_enable("Powered", enable);
 }
 
 static void mgmt_set_discoverable_cmd(const void *data, uint16_t size)
@@ -11376,49 +11079,49 @@ static void mgmt_set_connectable_cmd(const void *data, uint16_t size)
 {
 	uint8_t enable = get_u8(data);
 
-	mgmt_print_enable("Connectable", enable);
+	print_enable("Connectable", enable);
 }
 
 static void mgmt_set_fast_connectable_cmd(const void *data, uint16_t size)
 {
 	uint8_t enable = get_u8(data);
 
-	mgmt_print_enable("Fast Connectable", enable);
+	print_enable("Fast Connectable", enable);
 }
 
 static void mgmt_set_bondable_cmd(const void *data, uint16_t size)
 {
 	uint8_t enable = get_u8(data);
 
-	mgmt_print_enable("Bondable", enable);
+	print_enable("Bondable", enable);
 }
 
 static void mgmt_set_link_security_cmd(const void *data, uint16_t size)
 {
 	uint8_t enable = get_u8(data);
 
-	mgmt_print_enable("Link Security", enable);
+	print_enable("Link Security", enable);
 }
 
 static void mgmt_set_secure_simple_pairing_cmd(const void *data, uint16_t size)
 {
 	uint8_t enable = get_u8(data);
 
-	mgmt_print_enable("Secure Simple Pairing", enable);
+	print_enable("Secure Simple Pairing", enable);
 }
 
 static void mgmt_set_high_speed_cmd(const void *data, uint16_t size)
 {
 	uint8_t enable = get_u8(data);
 
-	mgmt_print_enable("High Speed", enable);
+	print_enable("High Speed", enable);
 }
 
 static void mgmt_set_low_energy_cmd(const void *data, uint16_t size)
 {
 	uint8_t enable = get_u8(data);
 
-	mgmt_print_enable("Low Energy", enable);
+	print_enable("Low Energy", enable);
 }
 
 static void mgmt_new_settings_rsp(const void *data, uint16_t size)
@@ -11481,7 +11184,7 @@ static void mgmt_load_link_keys_cmd(const void *data, uint16_t size)
 	uint16_t num_keys = get_le16(data + 1);
 	int i;
 
-	mgmt_print_enable("Debug keys", debug_keys);
+	print_enable("Debug keys", debug_keys);
 	print_field("Keys: %u", num_keys);
 
 	if (size - 3 != num_keys * 25) {
@@ -11616,7 +11319,7 @@ static void mgmt_unpair_device_cmd(const void *data, uint16_t size)
 	uint8_t disconnect = get_u8(data + 7);
 
 	mgmt_print_address(data, address_type);
-	mgmt_print_enable("Disconnect", disconnect);
+	print_enable("Disconnect", disconnect);
 }
 
 static void mgmt_unpair_device_rsp(const void *data, uint16_t size)
@@ -11836,7 +11539,7 @@ static void mgmt_set_bredr_cmd(const void *data, uint16_t size)
 {
 	uint8_t enable = get_u8(data);
 
-	mgmt_print_enable("BR/EDR", enable);
+	print_enable("BR/EDR", enable);
 }
 
 static void mgmt_set_static_address_cmd(const void *data, uint16_t size)
@@ -12059,7 +11762,7 @@ static void mgmt_set_external_configuration_cmd(const void *data, uint16_t size)
 {
 	uint8_t enable = get_u8(data);
 
-	mgmt_print_enable("Configuration", enable);
+	print_enable("Configuration", enable);
 }
 
 static void mgmt_set_public_address_cmd(const void *data, uint16_t size)
@@ -12742,7 +12445,7 @@ static void mgmt_discovering_evt(const void *data, uint16_t size)
 	uint8_t enable = get_u8(data + 1);
 
 	mgmt_print_address_type(type);
-	mgmt_print_enable("Discovery", enable);
+	print_enable("Discovery", enable);
 }
 
 static void mgmt_device_blocked_evt(const void *data, uint16_t size)
-- 
2.11.0

