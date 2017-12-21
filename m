Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] tools/btpclient: Move string to address conversion to helper
Date: Thu, 21 Dec 2017 17:47:16 +0100
Message-Id: <20171221164720.20925-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20171221164720.20925-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20171221164720.20925-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes local helper with string to address conversion.
---
 tools/btpclient.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 9ea624995..27e5a498e 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -52,6 +52,12 @@ static struct btp *btp;
 
 static bool gap_service_registered;
 
+static inline uint8_t str2addr(const char *str, uint8_t *addr)
+{
+	return sscanf(str,"%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &addr[5], &addr[4],
+					&addr[3], &addr[2], &addr[1], &addr[0]);
+}
+
 static struct btp_adapter *find_adapter_by_proxy(struct l_dbus_proxy *proxy)
 {
 	const struct l_queue_entry *entry;
@@ -171,9 +177,7 @@ static void btp_gap_read_info(uint8_t index, const void *param, uint16_t length,
 	if (!l_dbus_proxy_get_property(adapter->proxy, "Address", "s", &str))
 		goto failed;
 
-	if (sscanf(str,"%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
-			&rp.address[5], &rp.address[4], &rp.address[3],
-			&rp.address[2], &rp.address[1], &rp.address[0]) != 6)
+	if (str2addr(str, rp.address) != 6)
 		goto failed;
 
 	if (!l_dbus_proxy_get_property(adapter->proxy, "Name", "s", &str)) {
-- 
2.13.6

