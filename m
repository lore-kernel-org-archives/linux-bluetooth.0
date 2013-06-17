Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/6] obexd: Notify registered notification handlers in MNS
Date: Mon, 17 Jun 2013 10:35:30 +0200
Message-Id: <1371458131-2741-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1371458131-2741-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1371458131-2741-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 obexd/client/mns.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index 8095b9e..3d64a9c 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -279,6 +279,8 @@ static int event_report_close(void *obj)
 	GMarkupParseContext *ctxt;
 	struct map_event *event;
 
+	DBG("");
+
 	event = g_new0(struct map_event, 1);
 	ctxt = g_markup_parse_context_new(&event_report_parser, 0, event,
 									NULL);
@@ -286,13 +288,8 @@ static int event_report_close(void *obj)
 									NULL);
 	g_markup_parse_context_free(ctxt);
 
-	DBG("Event report for %s:%d", mns->remote_address,
-							mns->mas_instance_id);
-
-	DBG("type=%x, handle=%s, folder=%s, old_folder=%s, msg_type=%s",
-				event->type, event->handle, event->folder,
-					event->old_folder, event->msg_type);
-
+	mns_dispatch_notification(mns->mas_instance_id, mns->remote_address,
+									event);
 	map_event_free(event);
 
 	reset_request(mns);
-- 
1.8.2.3

