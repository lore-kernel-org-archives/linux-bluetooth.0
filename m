Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] tools/btpclient: Add passkey entry cmd and passkey display event
Date: Fri, 19 Jan 2018 17:41:32 +0100
Message-Id: <20180119164133.16767-7-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds passkey entry command handler and passkey display event.
---
 tools/btpclient.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 9d44fba41..55e5170a7 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -1658,11 +1658,44 @@ static struct l_dbus_message *ag_display_passkey_call(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
+	struct btp_gap_passkey_display_ev ev;
+	struct btp_device *device;
+	struct btp_adapter *adapter;
 	struct l_dbus_message *reply;
+	const char *path, *str_addr, *str_addr_type;
+	uint32_t passkey;
+	uint16_t entered;
 
 	reply = l_dbus_message_new_method_return(message);
 	l_dbus_message_set_arguments(reply, "");
 
+	l_dbus_message_get_arguments(message, "ouq", &path, &passkey, &entered);
+
+	device = find_device_by_path(path);
+
+	if (!l_dbus_proxy_get_property(device->proxy, "Address", "s", &str_addr)
+		|| !l_dbus_proxy_get_property(device->proxy, "AddressType", "s",
+		&str_addr_type)) {
+		l_info("Cannot get device properties");
+
+		return reply;
+	}
+
+	ev.passkey = L_CPU_TO_LE32(passkey);
+	ev.address_type = strcmp(str_addr_type, "public") ?
+							BTP_GAP_ADDR_RANDOM :
+							BTP_GAP_ADDR_PUBLIC;
+	if (str2ba(str_addr, &ev.address) < 0) {
+		l_info("Incorrect device addres");
+
+		return reply;
+	}
+
+	adapter = find_adapter_by_device(device);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_PASSKEY_DISPLAY,
+					adapter->index, sizeof(ev), &ev);
+
 	return reply;
 }
 
@@ -1993,6 +2026,62 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+static void passkey_entry_rsp_reply(struct l_dbus_message *result,
+								void *user_data)
+{
+	struct btp_adapter *adapter = user_data;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to reply with passkey (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	l_dbus_message_unref(ag.pending_req);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_ENTRY_RSP,
+						adapter->index, 0, NULL);
+}
+
+static void btp_gap_passkey_entry_rsp(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	const struct btp_gap_passkey_entry_rsp_cp *cp = param;
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct l_dbus_message_builder *builder;
+	uint8_t status = BTP_ERROR_FAIL;
+	uint32_t passkey = L_CPU_TO_LE32(cp->passkey);
+	bool prop;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to response with passkey */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+						!prop || !ag.pending_req)
+		goto failed;
+
+	builder = l_dbus_message_builder_new(ag.pending_req);
+	l_dbus_message_builder_append_basic(builder, 'u', &passkey);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	l_dbus_send_with_reply(dbus, ag.pending_req, passkey_entry_rsp_reply,
+								adapter, NULL);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
 static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 {
 	struct btp_device_found_ev ev;
@@ -2123,6 +2212,9 @@ static void register_gap_service(void)
 
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_UNPAIR, btp_gap_unpair,
 								NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_ENTRY_RSP,
+					btp_gap_passkey_entry_rsp, NULL, NULL);
 }
 
 static void btp_core_read_commands(uint8_t index, const void *param,
-- 
2.13.6

