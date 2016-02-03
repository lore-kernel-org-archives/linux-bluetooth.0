Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: syamsidhardh@gmail.com, Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/1] adapter: Fix memory leak
Date: Wed, 03 Feb 2016 20:28:43 +0530
Message-id: <1454511523-2128-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

if strlen(str) < 32 then there is a memory leak.
---
 src/adapter.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b184eed..f4fbf82 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3091,12 +3091,12 @@ static GSList *get_ltk_info(GKeyFile *key_file, const char *peer,
 static struct irk_info *get_irk_info(GKeyFile *key_file, const char *peer,
 							uint8_t bdaddr_type)
 {
-	struct irk_info *irk;
+	struct irk_info *irk = NULL;
 	char *str;
 
 	str = g_key_file_get_string(key_file, "IdentityResolvingKey", "Key", NULL);
 	if (!str || strlen(str) < 32)
-		return NULL;
+		goto failed;
 
 	irk = g_new0(struct irk_info, 1);
 
@@ -3108,6 +3108,7 @@ static struct irk_info *get_irk_info(GKeyFile *key_file, const char *peer,
 	else
 		str2buf(&str[0], irk->val, sizeof(irk->val));
 
+failed:
 	g_free(str);
 
 	return irk;
-- 
1.7.9.5

