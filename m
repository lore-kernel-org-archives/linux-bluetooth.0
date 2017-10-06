Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/2] tools/btmgmt: Remove 'btmgmt' from stop-find usage
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <5f2959f9-9888-1ac5-6991-106f12d651fe@jp.fujitsu.com>
Message-ID: <be95d89a-caf1-3153-e93e-1cee5f248fa4@jp.fujitsu.com>
Date: Fri, 6 Oct 2017 13:14:59 +0900
MIME-Version: 1.0
In-Reply-To: <5f2959f9-9888-1ac5-6991-106f12d651fe@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Apply the similar change as 5c35029fad ("tools/btmgmt: Remove 'btmgmt'
from help output") to stop-find usage.
---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 0f21f48..c29c1cb 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2370,7 +2370,7 @@ static void stop_find_rsp(uint8_t status, uint16_t len, const void *param,
 
 static void stop_find_usage(void)
 {
-	print("Usage: btmgmt stop-find [-l|-b]");
+	print("Usage: stop-find [-l|-b]");
 }
 
 static struct option stop_find_options[] = {
-- 
2.7.4


