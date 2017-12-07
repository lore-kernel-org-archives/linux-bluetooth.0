Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] client: Fix arguments of set-filter-clear
Date: Thu,  7 Dec 2017 10:21:52 -0200
Message-Id: <20171207122152.29743-7-luiz.dentz@gmail.com>
In-Reply-To: <20171207122152.29743-1-luiz.dentz@gmail.com>
References: <20171207122152.29743-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commands with no arguments shall use NULL not empty string.
---
 client/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 3534bd329..f0f62fe2a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2239,7 +2239,7 @@ static const struct bt_shell_menu scan_menu = {
 				cmd_set_scan_filter_duplicate_data,
 				"Set scan filter duplicate data",
 				mode_generator },
-	{ "set-filter-clear", "", cmd_set_scan_filter_clear,
+	{ "set-filter-clear", NULL, cmd_set_scan_filter_clear,
 				"Clears discovery filter." },
 	{ } },
 };
-- 
2.13.6

