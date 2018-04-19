Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] tools/hcitool: Change connection handle condition for lecup
Date: Thu, 19 Apr 2018 16:03:10 +0200
Message-Id: <20180419140312.22707-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180419140312.22707-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180419140312.22707-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to BLUETOOTH SPECIFICATION Version 5.0 | Vol 2, Part E
7.8.18 LE Connection Update Command, connection handle range is
0x0000-0x0EFF.
---
 tools/hcitool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 02c4ebe1b..945f675b0 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -3351,7 +3351,7 @@ static void cmd_lecup(int dev_id, int argc, char **argv)
 		timeout = strtoul(argv[4], NULL, 0);
 	}
 
-	if (handle == 0) {
+	if (handle > 0x0EFF) {
 		printf("%s", lecup_help);
 		return;
 	}
-- 
2.13.6

