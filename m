Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] tools/btpclient: Cleanup advertising data on reset
Date: Fri, 19 Jan 2018 17:41:30 +0100
Message-Id: <20180119164133.16767-5-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds advertising data cleanup routine to reset command if
registered.
---
 tools/btpclient.c | 71 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index c5f88e673..53c0d4c05 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -413,6 +413,37 @@ static void remove_device_reply(struct l_dbus_proxy *proxy,
 	l_queue_remove(adapter->devices, device);
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
+static void ad_cleanup_service(void *service)
+{
+	struct service_data *s = service;
+
+	l_free(s->uuid);
+	l_free(s);
+}
+
+static void ad_cleanup(void)
+{
+	l_free(ad.local_name);
+	l_queue_destroy(ad.uuids, l_free);
+	l_queue_destroy(ad.services, ad_cleanup_service);
+	l_queue_destroy(ad.manufacturers, l_free);
+
+	memset(&ad, 0, sizeof(ad));
+}
+
 static void unreg_advertising_setup(struct l_dbus_message *message,
 								void *user_data)
 {
@@ -430,6 +461,7 @@ static void unreg_advertising_reply(struct l_dbus_proxy *proxy,
 {
 	const char *path = l_dbus_proxy_get_path(proxy);
 	struct btp_adapter *adapter = find_adapter_by_path(path);
+	uint32_t new_settings;
 
 	if (!adapter)
 		return;
@@ -451,6 +483,12 @@ static void unreg_advertising_reply(struct l_dbus_proxy *proxy,
 		l_info("Unable to remove propety instance");
 	if (!l_dbus_unregister_interface(dbus, AD_IFACE))
 		l_info("Unable to unregister ad interface");
+
+	new_settings = adapter->current_settings;
+	new_settings &= ~BTP_GAP_SETTING_ADVERTISING;
+	update_current_settings(adapter, new_settings);
+
+	ad_cleanup();
 }
 
 static void unreg_agent_setup(struct l_dbus_message *message, void *user_data)
@@ -520,7 +558,7 @@ static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
 						NULL);
 	}
 
-	if (adapter->ad_proxy)
+	if (adapter->ad_proxy && ad.registered)
 		if (!l_dbus_proxy_method_call(adapter->ad_proxy,
 						"UnregisterAdvertisement",
 						unreg_advertising_setup,
@@ -613,19 +651,6 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
-static void update_current_settings(struct btp_adapter *adapter,
-							uint32_t new_settings)
-{
-	struct btp_new_settings_ev ev;
-
-	adapter->current_settings = new_settings;
-
-	ev.current_settings = L_CPU_TO_LE32(adapter->current_settings);
-
-	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_NEW_SETTINGS, adapter->index,
-							sizeof(ev), &ev);
-}
-
 static void btp_gap_set_connectable(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -726,24 +751,6 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
-static void ad_cleanup_service(void *service)
-{
-	struct service_data *s = service;
-
-	l_free(s->uuid);
-	l_free(s);
-}
-
-static void ad_cleanup(void)
-{
-	l_free(ad.local_name);
-	l_queue_destroy(ad.uuids, l_free);
-	l_queue_destroy(ad.services, ad_cleanup_service);
-	l_queue_destroy(ad.manufacturers, l_free);
-
-	memset(&ad, 0, sizeof(ad));
-}
-
 static void ad_init(void)
 {
 	ad.uuids = l_queue_new();
-- 
2.13.6

