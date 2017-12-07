Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 8/9] tools/btpclient: Add support for tracking mutable adapter settings
Date: Thu,  7 Dec 2017 15:21:42 +0100
Message-Id: <20171207142143.27324-9-szymon.janc@codecoup.pl>
In-Reply-To: <20171207142143.27324-1-szymon.janc@codecoup.pl>
References: <20171207142143.27324-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btpclient.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 5f7fb85f1..2c7c40241 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -53,6 +53,21 @@ static struct btp *btp;
 
 static bool gap_service_registered;
 
+static struct btp_adapter *find_adapter_by_proxy(struct l_dbus_proxy *proxy)
+{
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(adapters); entry;
+							entry = entry->next) {
+		struct btp_adapter *adapter = entry->data;
+
+		if (adapter->proxy == proxy)
+			return adapter;
+	}
+
+	return NULL;
+}
+
 static struct btp_adapter *find_adapter_by_index(uint8_t index)
 {
 	const struct l_queue_entry *entry;
@@ -437,11 +452,75 @@ static void proxy_removed(struct l_dbus_proxy *proxy, void *user_data)
 	}
 }
 
+static void update_current_settings(struct btp_adapter *adapter,
+							uint32_t new_settings)
+{
+	struct btp_new_settings_ev ev;
+
+	adapter->current_settings = new_settings;
+
+	ev.current_settings = L_CPU_TO_LE32(adapter->current_settings);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_NEW_SETTINGS, adapter->index,
+							sizeof(ev), &ev);
+}
+
 static void property_changed(struct l_dbus_proxy *proxy, const char *name,
 				struct l_dbus_message *msg, void *user_data)
 {
-	l_info("property_changed %s %s %s", name, l_dbus_proxy_get_path(proxy),
-			l_dbus_proxy_get_interface(proxy));
+	const char *interface = l_dbus_proxy_get_interface(proxy);
+	const char *path = l_dbus_proxy_get_path(proxy);
+
+	l_info("property_changed %s %s %s", name, path, interface);
+
+	if (!strcmp(interface, "org.bluez.Adapter1")) {
+		struct btp_adapter *adapter = find_adapter_by_proxy(proxy);
+		uint32_t new_settings;
+
+		if (!adapter)
+			return;
+
+		new_settings = adapter->current_settings;
+
+		if (!strcmp(name, "Powered")) {
+			bool prop;
+
+			if (!l_dbus_message_get_arguments(msg, "b", &prop))
+				return;
+
+			if (prop)
+				new_settings |= BTP_GAP_SETTING_POWERED;
+			else
+				new_settings &= ~BTP_GAP_SETTING_POWERED;
+		} else if (!strcmp(name, "Discoverable")) {
+			bool prop;
+
+			if (!l_dbus_message_get_arguments(msg, "b", &prop))
+				return;
+
+			if (prop)
+				new_settings |= BTP_GAP_SETTING_DISCOVERABLE;
+			else
+				new_settings &= ~BTP_GAP_SETTING_DISCOVERABLE;
+		}
+
+		if (!strcmp(name, "Pairable")) {
+			bool prop;
+
+			if (!l_dbus_message_get_arguments(msg, "b", &prop))
+				return;
+
+			if (prop)
+				new_settings |= BTP_GAP_SETTING_BONDABLE;
+			else
+				new_settings &= ~BTP_GAP_SETTING_BONDABLE;
+		}
+
+		if (new_settings != adapter->current_settings)
+			update_current_settings(adapter, new_settings);
+
+		return;
+	}
 }
 
 static void client_connected(struct l_dbus *dbus, void *user_data)
-- 
2.14.3

