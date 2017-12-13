Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 9/9] client: Fix command scan:clear
Date: Wed, 13 Dec 2017 10:36:55 -0200
Message-Id: <20171213123655.24277-9-luiz.dentz@gmail.com>
In-Reply-To: <20171213123655.24277-1-luiz.dentz@gmail.com>
References: <20171213123655.24277-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Command clear shall clear all filters including DuplicateData.
---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 1617b7cb3..bbfdea80d 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1414,6 +1414,7 @@ static void cmd_scan_filter_clear(int argc, char *argv[])
 	filtered_scan_uuids_len = 0;
 	g_free(filtered_scan_transport);
 	filtered_scan_transport = NULL;
+	filtered_scan_duplicate_data = false;
 
 	if (check_default_ctrl() == FALSE)
 		return;
-- 
2.13.6

