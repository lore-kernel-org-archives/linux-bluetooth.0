Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 9/9] tools/btpclient: Add connect device command
Date: Wed, 28 Feb 2018 13:41:29 +0100
Message-Id: <20180228124129.25851-9-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for connect device command.
---
 tools/btpclient.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index d1d64d068..5bf2d922f 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -1550,12 +1550,81 @@ static void connect_reply(struct l_dbus_proxy *proxy,
 									NULL);
 }
 
+struct connect_device_data {
+	bdaddr_t addr;
+	uint8_t addr_type;
+};
+
+static void connect_device_destroy(void *connect_device_data)
+{
+	l_free(connect_device_data);
+}
+
+static void connect_device_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_proxy(proxy);
+
+	if (!adapter) {
+		btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROLLER,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to connect device (%s), %s", name, desc);
+
+		return;
+	}
+}
+
+static void connect_device_setup(struct l_dbus_message *message,
+								void *user_data)
+{
+	struct connect_device_data *cdd = user_data;
+	struct l_dbus_message_builder *builder;
+	char str_addr[18];
+
+	ba2str(&cdd->addr, str_addr);
+
+	builder = l_dbus_message_builder_new(message);
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', "Address");
+	l_dbus_message_builder_enter_variant(builder, "s");
+	l_dbus_message_builder_append_basic(builder, 's', str_addr);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', "AddressType");
+	l_dbus_message_builder_enter_variant(builder, "s");
+	if (cdd->addr_type == BTP_GAP_ADDR_RANDOM)
+		l_dbus_message_builder_append_basic(builder, 's', "random");
+	else
+		l_dbus_message_builder_append_basic(builder, 's', "public");
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
 static void btp_gap_connect(uint8_t index, const void *param, uint16_t length,
 								void *user_data)
 {
 	struct btp_adapter *adapter = find_adapter_by_index(index);
 	const struct btp_gap_connect_cp *cp = param;
 	struct btp_device *device;
+	struct connect_device_data *cdd;
 	bool prop;
 	uint8_t status = BTP_ERROR_FAIL;
 
@@ -1572,6 +1641,22 @@ static void btp_gap_connect(uint8_t index, const void *param, uint16_t length,
 	device = find_device_by_address(adapter, &cp->address,
 							cp->address_type);
 
+	if (!device) {
+		cdd = l_new(struct connect_device_data, 1);
+		memcpy(&cdd->addr, &cp->address, sizeof(cdd->addr));
+		cdd->addr_type = cp->address_type;
+
+		l_dbus_proxy_method_call(adapter->proxy, "ConnectDevice",
+							connect_device_setup,
+							connect_device_reply,
+							cdd,
+							connect_device_destroy);
+
+		btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_CONNECT,
+						adapter->index, 0, NULL);
+		return;
+	}
+
 	if (!device)
 		goto failed;
 
-- 
2.13.6

