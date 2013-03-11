Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 8/8] obexd: Notify registered notification handlers
Date: Mon, 11 Mar 2013 16:05:50 +0100
Message-Id: <1363014350-16114-9-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 obexd/client/mns.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index 81550ef..f16d235 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -41,7 +41,7 @@
 #include "service.h"
 #include "mimetype.h"
 #include "map_ap.h"
-#include "map-event.h"
+#include "map-dispatcher.h"
 
 struct mns_session {
 	GString *buffer;
@@ -266,6 +266,8 @@ static int event_report_close(void *obj)
 	GMarkupParseContext *ctxt;
 	struct map_event *event;
 
+	DBG("");
+
 	event = g_new0(struct map_event, 1);
 	ctxt = g_markup_parse_context_new(&event_report_parser, 0, event,
 									NULL);
@@ -273,11 +275,7 @@ static int event_report_close(void *obj)
 									NULL);
 	g_markup_parse_context_free(ctxt);
 
-	DBG("Received event report for instance %d", mns->mas_instance_id);
-	DBG("type=%x, handle=%s, folder=%s, old_folder=%s, msg_type=%s",
-				event->type, event->handle, event->folder,
-					event->old_folder, event->msg_type);
-
+	mns_dispatch_notification(mns->mas_instance_id, event);
 	map_event_free(event);
 
 	reset_request(mns);
-- 
1.8.1.5

