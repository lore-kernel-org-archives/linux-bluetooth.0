Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 1/6] tools/gatt: Fix incorrect error check
Date: Tue, 24 Feb 2015 14:26:44 +0200
Message-Id: <1424780809-23449-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424780809-23449-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424780809-23449-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/btgatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index e59d5db..25ace4a 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1021,7 +1021,7 @@ static void cmd_set_sec_level(struct client *cli, char *cmd_str)
 		return;
 	}
 
-	if (bt_gatt_client_set_sec_level(cli->gatt, level) < 0)
+	if (!bt_gatt_client_set_sec_level(cli->gatt, level))
 		printf("Could not set sec level\n");
 	else
 		printf("Setting security level %d success\n", level);
-- 
2.1.0

