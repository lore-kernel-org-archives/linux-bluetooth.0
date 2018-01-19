Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] tools/btpclient: Initial check of ad_proxy presence in stop adv cmd
Date: Fri, 19 Jan 2018 17:41:27 +0100
Message-Id: <20180119164133.16767-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch covers with fail response if no advertising proxy was
registered at command beginning.
---
 tools/btpclient.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 33116ce1b..f2c79b3a3 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -1156,19 +1156,15 @@ static void btp_gap_stop_advertising(uint8_t index, const void *param,
 	}
 
 	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
-							!prop || !ad.registered)
+				!prop || !adapter->ad_proxy || !ad.registered)
 		goto failed;
 
-	if (adapter->ad_proxy) {
-		if (!l_dbus_proxy_method_call(adapter->ad_proxy,
+	if (!l_dbus_proxy_method_call(adapter->ad_proxy,
 						"UnregisterAdvertisement",
 						unreg_advertising_setup,
 						stop_advertising_reply,
-						NULL, NULL)) {
-			status = BTP_ERROR_FAIL;
-			goto failed;
-		}
-	}
+						NULL, NULL))
+		goto failed;
 
 	return;
 
-- 
2.13.6

