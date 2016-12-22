Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Maxime Chevallier <maxime.chevallier@smile.fr>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
        Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH 2/2] tools/btgatt-client: Update set-security usage
Date: Thu, 22 Dec 2016 11:36:05 +0100
Message-Id: <1482402965-9462-2-git-send-email-maxime.chevallier@smile.fr>
In-Reply-To: <1482402965-9462-1-git-send-email-maxime.chevallier@smile.fr>
References: <1482402965-9462-1-git-send-email-maxime.chevallier@smile.fr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btgatt-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index afe00aa..615c805 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1190,10 +1190,10 @@ static void cmd_unregister_notify(struct client *cli, char *cmd_str)
 
 static void set_security_usage(void)
 {
-	printf("Usage: set_security <level>\n"
+	printf("Usage: set-security <level>\n"
 		"level: 1-3\n"
 		"e.g.:\n"
-		"\tset-sec-level 2\n");
+		"\tset-security 2\n");
 }
 
 static void cmd_set_security(struct client *cli, char *cmd_str)
-- 
2.1.4

