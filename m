Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH V2 06/10] tools/btpclient: Get initial values for adapter setttings
Date: Fri,  8 Dec 2017 15:03:45 +0100
Message-Id: <20171208140348.30342-7-szymon.janc@codecoup.pl>
In-Reply-To: <20171208140348.30342-1-szymon.janc@codecoup.pl>
References: <20171208140348.30342-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btpclient.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index d4b4601bd..b0bc0ab30 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -325,6 +325,49 @@ static void btp_device_free(struct btp_device *device)
 	l_free(device);
 }
 
+static void extract_settings(struct l_dbus_proxy *proxy, uint32_t *current,
+						uint32_t *supported)
+{
+	bool prop;
+
+	*supported = 0;
+	*current = 0;
+
+	/* TODO not all info is available via D-Bus API */
+	*supported |=  BTP_GAP_SETTING_POWERED;
+	*supported |=  BTP_GAP_SETTING_CONNECTABLE;
+	*supported |=  BTP_GAP_SETTING_DISCOVERABLE;
+	*supported |=  BTP_GAP_SETTING_BONDABLE;
+	*supported |=  BTP_GAP_SETTING_SSP;
+	*supported |=  BTP_GAP_SETTING_BREDR;
+	*supported |=  BTP_GAP_SETTING_LE;
+	*supported |=  BTP_GAP_SETTING_ADVERTISING;
+	*supported |=  BTP_GAP_SETTING_SC;
+	*supported |=  BTP_GAP_SETTING_PRIVACY;
+	/* *supported |=  BTP_GAP_SETTING_STATIC_ADDRESS; */
+
+	/* TODO not all info is availbe via D-Bus API so some are assumed to be
+	 * enabled by bluetoothd or simply hardcoded until API is extended
+	 */
+	*current |=  BTP_GAP_SETTING_CONNECTABLE;
+	*current |=  BTP_GAP_SETTING_SSP;
+	*current |=  BTP_GAP_SETTING_BREDR;
+	*current |=  BTP_GAP_SETTING_LE;
+	*current |=  BTP_GAP_SETTING_PRIVACY;
+	*current |=  BTP_GAP_SETTING_SC;
+	/* *supported |=  BTP_GAP_SETTING_STATIC_ADDRESS; */
+
+	if (l_dbus_proxy_get_property(proxy, "Powered", "b", &prop) && prop)
+		*current |=  BTP_GAP_SETTING_POWERED;
+
+	if (l_dbus_proxy_get_property(proxy, "Discoverable", "b", &prop) &&
+									prop)
+		*current |=  BTP_GAP_SETTING_DISCOVERABLE;
+
+	if (l_dbus_proxy_get_property(proxy, "Pairable", "b", &prop) && prop)
+		*current |=  BTP_GAP_SETTING_BONDABLE;
+}
+
 static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 {
 	const char *interface = l_dbus_proxy_get_interface(proxy);
@@ -339,6 +382,9 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 		adapter->proxy = proxy;
 		adapter->index = l_queue_length(adapters);
 
+		extract_settings(proxy, &adapter->current_settings,
+						&adapter->supported_settings);
+
 		l_queue_push_tail(adapters, adapter);
 		return;
 	}
-- 
2.14.3

