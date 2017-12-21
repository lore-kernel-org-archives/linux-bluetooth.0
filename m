Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] tools/btpclient: Add advertising proxy to adapter
Date: Thu, 21 Dec 2017 17:47:17 +0100
Message-Id: <20171221164720.20925-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20171221164720.20925-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20171221164720.20925-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Advertising manager proxy is required to handle advertise related
operations in adapter context.
---
 tools/btpclient.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 27e5a498e..095c5ea3e 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -36,6 +36,7 @@
 
 struct btp_adapter {
 	struct l_dbus_proxy *proxy;
+	struct l_dbus_proxy *ad_proxy;
 	uint8_t index;
 	uint32_t supported_settings;
 	uint32_t current_settings;
@@ -659,6 +660,17 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
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
+
+		adapter->ad_proxy = proxy;
+
 		return;
 	}
 }
-- 
2.13.6

