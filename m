Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/9] tools/btpclient: Add passkey confirm ev and passkey confirm rsp cmd
Date: Wed, 28 Feb 2018 13:41:25 +0100
Message-Id: <20180228124129.25851-5-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds passkey confirm command handler and passkey confirm
event.
---
 tools/btpclient.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 4097c05d0..92fa742ce 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -1707,12 +1707,42 @@ static struct l_dbus_message *ag_request_confirmation_call(struct l_dbus *dbus,
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
 
 static struct l_dbus_message *ag_request_authorization_call(struct l_dbus *dbus,
-- 
2.13.6

