Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] tools/btpclient: Fix start adv commend comment
Date: Fri, 19 Jan 2018 17:41:26 +0100
Message-Id: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Comment should be aproperiate for advertising command. Device needs to
be powered to advertise.
---
 tools/btpclient.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index af0e75290..33116ce1b 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -1038,7 +1038,7 @@ static void btp_gap_start_advertising(uint8_t index, const void *param,
 		goto failed;
 	}
 
-	/* Adapter needs to be powered to be able to remove devices */
+	/* Adapter needs to be powered to be able to advertise */
 	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
 							!prop || ad.registered)
 		goto failed;
-- 
2.13.6

