Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] tools/btpclient: Fix setting/reseting connectable flag
Date: Fri, 12 Jan 2018 15:10:09 +0100
Message-Id: <20180112141012.28113-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Defined setting flag is presented as mask.
---
 tools/btpclient.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 806403f6a..a8a65fd51 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -368,9 +368,9 @@ static void btp_gap_set_connectable(uint8_t index, const void *param,
 	new_settings = adapter->current_settings;
 
 	if (cp->connectable)
-		new_settings |= 1 << BTP_GAP_SETTING_CONNECTABLE;
+		new_settings |= BTP_GAP_SETTING_CONNECTABLE;
 	else
-		new_settings &= ~(1 << BTP_GAP_SETTING_CONNECTABLE);
+		new_settings &= ~BTP_GAP_SETTING_CONNECTABLE;
 
 	update_current_settings(adapter, new_settings);
 
-- 
2.13.6

