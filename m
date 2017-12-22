Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] tools/btpclient: Add advertising proxy to adapter
Date: Fri, 22 Dec 2017 15:17:06 +0100
Message-Id: <20171222141709.29008-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20171222141709.29008-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20171222141709.29008-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Advertising manager proxy is required to handle advertise related
operations in adapter context.
---
 tools/btpclient.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index a38a87a25..23e1080f5 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -36,6 +36,7 @@
 
 struct btp_adapter {
 	struct l_dbus_proxy *proxy;
+	struct l_dbus_proxy *ad_proxy;
 	uint8_t index;
 	uint32_t supported_settings;
 	uint32_t current_settings;
@@ -659,6 +660,19 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 		device->proxy = proxy;
 
 		l_queue_push_tail(adapter->devices, device);
+
+		return;
+	}
+
+	if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
+		struct btp_adapter *adapter;
+
+		adapter = find_adapter_by_path(path);
+		if (!adapter)
+			return;
+
+		adapter->ad_proxy = proxy;
+
 		return;
 	}
 }
-- 
2.13.6

