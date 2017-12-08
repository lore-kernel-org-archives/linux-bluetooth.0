Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH V2 08/10] tools/btpclient: Add support for configuring adapter settings
Date: Fri,  8 Dec 2017 15:03:47 +0100
Message-Id: <20171208140348.30342-9-szymon.janc@codecoup.pl>
In-Reply-To: <20171208140348.30342-1-szymon.janc@codecoup.pl>
References: <20171208140348.30342-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to configure Powered, Discoverable and Pairable options.
---
 tools/btpclient.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 482d1e380..50112c3a3 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -174,6 +174,136 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+struct set_setting_data {
+	struct btp_adapter *adapter;
+	uint8_t opcode;
+	uint32_t setting;
+	bool value;
+};
+
+static void set_setting_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *result, void *user_data)
+{
+	struct set_setting_data *data = user_data;
+	struct btp_adapter *adapter = data->adapter;
+	uint32_t settings;
+
+	if (l_dbus_message_is_error(result)) {
+		btp_send_error(btp, BTP_GAP_SERVICE, data->adapter->index,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	if (data->value)
+		adapter->current_settings |= data->setting;
+	else
+		adapter->current_settings &= ~data->setting;
+
+	settings = L_CPU_TO_LE32(adapter->current_settings);
+
+	btp_send(btp, BTP_GAP_SERVICE, data->opcode, adapter->index,
+						sizeof(settings), &settings);
+}
+
+static void btp_gap_set_powered(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_set_powered_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	struct set_setting_data *data;
+
+	if (length < sizeof(*cp))
+		goto failed;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	data = l_new(struct set_setting_data, 1);
+	data->adapter = adapter;
+	data->opcode = BTP_OP_GAP_SET_POWERED;
+	data->setting = BTP_GAP_SETTING_POWERED;
+	data->value = cp->powered;
+
+	if (l_dbus_proxy_set_property(adapter->proxy, set_setting_reply,
+					data, l_free, "Powered", "b",
+					&data->value))
+		return;
+
+	l_free(data);
+
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
+static void btp_gap_set_discoverable(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_set_discoverable_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	struct set_setting_data *data;
+
+	if (length < sizeof(*cp))
+		goto failed;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	data = l_new(struct set_setting_data, 1);
+	data->adapter = adapter;
+	data->opcode = BTP_OP_GAP_SET_DISCOVERABLE;
+	data->setting = BTP_GAP_SETTING_DISCOVERABLE;
+	data->value = cp->discoverable;
+
+	if (l_dbus_proxy_set_property(adapter->proxy, set_setting_reply,
+					data, l_free, "Discoverable", "b",
+					&data->value))
+		return;
+
+	l_free(data);
+
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
+static void btp_gap_set_bondable(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_set_bondable_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	struct set_setting_data *data;
+
+	if (length < sizeof(*cp))
+		goto failed;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	data = l_new(struct set_setting_data, 1);
+	data->adapter = adapter;
+	data->opcode = BTP_OP_GAP_SET_BONDABLE;
+	data->setting = BTP_GAP_SETTING_BONDABLE;
+	data->value = cp->bondable;
+
+	if (l_dbus_proxy_set_property(adapter->proxy, set_setting_reply,
+					data, l_free, "Pairable", "b",
+					&data->value))
+		return;
+
+	l_free(data);
+
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
 static void register_gap_service(void)
 {
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_SUPPORTED_COMMANDS,
@@ -185,6 +315,15 @@ static void register_gap_service(void)
 
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_COTROLLER_INFO,
 						btp_gap_read_info, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_POWERED,
+					btp_gap_set_powered, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_DISCOVERABLE,
+					btp_gap_set_discoverable, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_BONDABLE,
+					btp_gap_set_bondable, NULL, NULL);
 }
 
 static void btp_core_read_commands(uint8_t index, const void *param,
-- 
2.14.3

