Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] shared/hfp: Improve prefix comparing
Date: Tue,  2 Dec 2014 12:01:09 +0100
Message-Id: <1417518069-18289-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 5a91d12..ead082e 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -936,7 +936,7 @@ static bool match_handler_event_prefix(const void *a, const void *b)
 	const struct event_handler *handler = a;
 	const char *prefix = b;
 
-	if (memcmp(handler->prefix, prefix, strlen(prefix)))
+	if (strcmp(handler->prefix, prefix) != 0)
 		return false;
 
 	return true;
-- 
1.8.4

