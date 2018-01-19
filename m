Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] tools/btpclient: Restore default settings on reset
Date: Fri, 19 Jan 2018 17:41:29 +0100
Message-Id: <20180119164133.16767-4-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reset command will restore default settings of adapter.
---
 tools/btpclient.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 708092937..c5f88e673 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -56,6 +56,7 @@ struct btp_adapter {
 	uint8_t index;
 	uint32_t supported_settings;
 	uint32_t current_settings;
+	uint32_t default_settings;
 	struct l_queue *devices;
 };
 
@@ -538,6 +539,8 @@ static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
 			goto failed;
 		}
 
+	adapter->current_settings = adapter->default_settings;
+
 	/* TODO for we assume all went well */
 	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_RESET, index, 0, NULL);
 	return;
@@ -2207,6 +2210,8 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 		extract_settings(proxy, &adapter->current_settings,
 						&adapter->supported_settings);
 
+		adapter->default_settings = adapter->current_settings;
+
 		l_queue_push_tail(adapters, adapter);
 		return;
 	}
-- 
2.13.6

