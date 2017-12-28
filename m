Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Subject: [PATCH BlueZ v3 2/5] tools/btpclient: Add advertising proxy to adapter
Date: Thu, 28 Dec 2017 14:11:15 +0100
Message-Id: <1514466678-32582-2-git-send-email-kolodziejczyk.grzegorz.wroc@gmail.com>
In-Reply-To: <1514466678-32582-1-git-send-email-kolodziejczyk.grzegorz.wroc@gmail.com>
References: <1514466678-32582-1-git-send-email-kolodziejczyk.grzegorz.wroc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>

Advertising manager proxy is required to handle advertise related
operations in adapter context.
---
 tools/btpclient.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 2cb5719..90ba8b6 100644
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
2.7.4

