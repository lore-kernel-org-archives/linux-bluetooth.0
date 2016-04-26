Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] [client] Fix select-attribute behaviour
Date: Tue, 26 Apr 2016 10:30:29 +0200
Message-Id: <1461659429-19139-3-git-send-email-beaufort.francois@gmail.com>
In-Reply-To: <1461659429-19139-1-git-send-email-beaufort.francois@gmail.com>
References: <1461659429-19139-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 209cf0c..c75b558 100644
--- a/client/main.c
+++ b/client/main.c
@@ -350,7 +350,6 @@ done:
 	rl_set_prompt(desc ? desc : PROMPT_ON);
 	printf("\r");
 	rl_on_new_line();
-	rl_redisplay();
 	g_free(desc);
 }
 
-- 
2.7.0

