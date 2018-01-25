Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] tools/btpclient: Add passkey confirm ev and passkey confirm rsp cmd
Date: Thu, 25 Jan 2018 16:53:33 +0100
Message-Id: <20180125155333.12734-5-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180125155333.12734-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180125155333.12734-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds passkey confirm command handler and passkey confirm
event.
---
 tools/btpclient.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 4 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 00c4e5fac..5320003f9 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -1700,12 +1700,42 @@ static struct l_dbus_message *ag_request_confirmation_call(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	struct l_dbus_message *reply;
+	struct btp_gap_passkey_confirm_ev ev;
+	struct btp_device *device;
+	struct btp_adapter *adapter;
+	const char *path, *str_addr, *str_addr_type;
+	uint32_t passkey;
 
-	reply = l_dbus_message_new_method_return(message);
-	l_dbus_message_set_arguments(reply, "");
+	l_dbus_message_get_arguments(message, "ou", &path, &passkey);
 
-	return reply;
+	device = find_device_by_path(path);
+
+	if (!l_dbus_proxy_get_property(device->proxy, "Address", "s", &str_addr)
+		|| !l_dbus_proxy_get_property(device->proxy, "AddressType", "s",
+		&str_addr_type)) {
+		l_info("Cannot get device properties");
+
+		return NULL;
+	}
+
+	ev.passkey = L_CPU_TO_LE32(passkey);
+	ev.address_type = strcmp(str_addr_type, "public") ?
+							BTP_GAP_ADDR_RANDOM :
+							BTP_GAP_ADDR_PUBLIC;
+	if (str2ba(str_addr, &ev.address) < 0) {
+		l_info("Incorrect device address");
+
+		return NULL;
+	}
+
+	adapter = find_adapter_by_device(device);
+
+	ag.pending_req = l_dbus_message_ref(message);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_PASSKEY_CONFIRM,
+					adapter->index, sizeof(ev), &ev);
+
+	return NULL;
 }
 
 static struct l_dbus_message *ag_authorize_service_call(struct l_dbus *dbus,
@@ -2286,6 +2316,65 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+static void passkey_confirm_rsp_reply(struct l_dbus_message *result,
+								void *user_data)
+{
+	struct btp_adapter *adapter = user_data;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to confirm passkey (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	l_dbus_message_unref(ag.pending_req);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_CONFIRM_RSP,
+						adapter->index, 0, NULL);
+}
+
+static void btp_gap_confirm_entry_rsp(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	const struct btp_gap_passkey_confirm_rsp_cp *cp = param;
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct l_dbus_message *reply;
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to confirm passkey */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+						!prop || !ag.pending_req)
+		goto failed;
+
+	if (cp->match) {
+		reply = l_dbus_message_new_method_return(ag.pending_req);
+		l_dbus_message_set_arguments(reply, "");
+	} else {
+		reply = l_dbus_message_new_error(ag.pending_req,
+						"org.bluez.Error.Rejected",
+						"Passkey missmatch");
+	}
+
+	l_dbus_send_with_reply(dbus, ag.pending_req, passkey_confirm_rsp_reply,
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
@@ -2419,6 +2508,9 @@ static void register_gap_service(void)
 
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_ENTRY_RSP,
 					btp_gap_passkey_entry_rsp, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_CONFIRM_RSP,
+					btp_gap_confirm_entry_rsp, NULL, NULL);
 }
 
 static void btp_core_read_commands(uint8_t index, const void *param,
-- 
2.13.6

