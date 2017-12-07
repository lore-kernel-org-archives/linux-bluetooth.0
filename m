Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 4/9] tools/btpclient: Store index along with adapter proxy
Date: Thu,  7 Dec 2017 15:21:38 +0100
Message-Id: <20171207142143.27324-5-szymon.janc@codecoup.pl>
In-Reply-To: <20171207142143.27324-1-szymon.janc@codecoup.pl>
References: <20171207142143.27324-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btpclient.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index c7ff239b0..3a4971eeb 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -37,6 +37,7 @@
 
 struct btp_adapter {
 	struct l_dbus_proxy *proxy;
+	unsigned int index;
 };
 
 struct btp_device {
@@ -157,9 +158,18 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 
 	if (!strcmp(interface, "org.bluez.Adapter1")) {
 		struct btp_adapter *adapter;
+		unsigned int index;
+
+		/* TODO should we rely on path for index or use other mapping
+		 * like queue size?
+		 */
+		if (sscanf(l_dbus_proxy_get_path(proxy), "/org/bluez/hci%u",
+								&index) != 1)
+			return;
 
 		adapter = l_new(struct btp_adapter, 1);
 		adapter->proxy = proxy;
+		adapter->index = index;
 
 		l_queue_push_tail(adapters, adapter);
 		return;
-- 
2.14.3

