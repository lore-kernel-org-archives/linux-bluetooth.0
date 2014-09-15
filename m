Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] obexd/client/map: Check msg value is valid
Date: Mon, 15 Sep 2014 18:29:16 +0530
Message-id: <1410785956-6887-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Checks for the NULL msg-value, before passing it to the callback.
---
 obexd/client/map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 520e492..fb8ebd8 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1132,7 +1132,8 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 
 		for (parser = msg_parsers; parser && parser->name; parser++) {
 			if (strcasecmp(key, parser->name) == 0) {
-				parser->func(msg, values[i]);
+				if(values[i])
+					parser->func(msg, values[i]);
 				break;
 			}
 		}
-- 
1.9.1

