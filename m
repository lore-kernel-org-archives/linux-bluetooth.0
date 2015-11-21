Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 1/2] monitor: Fix use of uninitialized variable
Date: Sat, 21 Nov 2015 21:09:03 +0100
Message-Id: <1448136544-18660-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

subevent code was never set in vendor_evt() resulting in printing
random stack data as subevent opcode in print_subevent().
---
 monitor/packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 4c18cb2..70bd153 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8471,6 +8471,7 @@ static void vendor_evt(const void *data, uint8_t size)
 			vendor_data.str = vendor_str;
 		} else
 			vendor_data.str = vnd->str;
+		vendor_data.subevent = subevent;
 		vendor_data.func = vnd->evt_func;
 		vendor_data.size = vnd->evt_size;
 		vendor_data.fixed = vnd->evt_fixed;
-- 
2.6.2

