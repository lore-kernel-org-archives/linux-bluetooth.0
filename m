Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/9] tools/btpclient: Add support for including tx-power to ad
Date: Wed, 28 Feb 2018 13:41:22 +0100
Message-Id: <20180228124129.25851-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows to set tx-power in advertising data.
---
 tools/btpclient.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index d37232f07..9703915dd 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -44,6 +44,7 @@
 #define AD_TYPE_FLAGS				0x01
 #define AD_TYPE_INCOMPLETE_UUID16_SERVICE_LIST	0x02
 #define AD_TYPE_SHORT_NAME			0x08
+#define AD_TYPE_TX_POWER			0x0a
 #define AD_TYPE_SERVICE_DATA_UUID16		0x16
 #define AD_TYPE_APPEARANCE			0x19
 #define AD_TYPE_MANUFACTURER_DATA		0xff
@@ -1048,6 +1049,12 @@ static void create_advertising_data(uint8_t adv_data_len, const uint8_t *data)
 			ad.local_name[ad_len] = '\0';
 
 			break;
+		case AD_TYPE_TX_POWER:
+			ad.tx_power = true;
+
+			/* XXX Value is ommited cause, stack fills it */
+
+			break;
 		case AD_TYPE_SERVICE_DATA_UUID16:
 		{
 			struct service_data *sd;
-- 
2.13.6

