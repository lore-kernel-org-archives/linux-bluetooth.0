Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] obexd/mns: Check event value is valid
Date: Mon, 15 Sep 2014 13:51:06 +0300
Message-Id: <1410778266-2891-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1410778266-2891-1-git-send-email-luiz.dentz@gmail.com>
References: <1410778266-2891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a common check before passing the event value to the callback.
---
 obexd/client/mns.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index 124dbcf..76b7d1c 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -191,9 +191,6 @@ static void parse_event_report_handle(struct map_event *event,
 static void parse_event_report_folder(struct map_event *event,
 							const char *value)
 {
-	if (!value)
-		return;
-
 	g_free(event->folder);
 
 	if (g_str_has_prefix(value, "/"))
@@ -205,9 +202,6 @@ static void parse_event_report_folder(struct map_event *event,
 static void parse_event_report_old_folder(struct map_event *event,
 							const char *value)
 {
-	if (!value)
-		return;
-
 	g_free(event->old_folder);
 
 	if (g_str_has_prefix(value, "/"))
@@ -219,9 +213,6 @@ static void parse_event_report_old_folder(struct map_event *event,
 static void parse_event_report_msg_type(struct map_event *event,
 							const char *value)
 {
-	if (!value)
-		return;
-
 	g_free(event->msg_type);
 	event->msg_type = g_strdup(value);
 }
@@ -256,7 +247,8 @@ static void event_report_element(GMarkupParseContext *ctxt,
 		for (parser = event_report_parsers; parser && parser->name;
 								parser++) {
 			if (strcasecmp(key, parser->name) == 0) {
-				parser->func(event, values[i]);
+				if (values[i])
+					parser->func(event, values[i]);
 				break;
 			}
 		}
-- 
1.9.3

