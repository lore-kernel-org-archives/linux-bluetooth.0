Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] obexd: Prefix folders in event reports with leading slash
Date: Tue, 24 Sep 2013 16:16:07 +0200
Message-Id: <1380032167-6440-8-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The internal representation of folder paths starts with a leading slash.
Therefore we have to prepend it to the folders received in event reports.
---
 obexd/client/mns.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index 76a5e24..ca44e5f 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -188,13 +188,25 @@ static void parse_event_report_handle(struct map_event *event,
 static void parse_event_report_folder(struct map_event *event,
 							const char *value)
 {
-	event->folder = g_strdup(value);
+	if (!value)
+		return;
+
+	if (g_str_has_prefix(value, "/"))
+		event->folder = g_strdup(value);
+	else
+		event->folder = g_strconcat("/", value, NULL);
 }
 
 static void parse_event_report_old_folder(struct map_event *event,
 							const char *value)
 {
-	event->old_folder = g_strdup(value);
+	if (!value)
+		return;
+
+	if (g_str_has_prefix(value, "/"))
+		event->old_folder = g_strdup(value);
+	else
+		event->old_folder = g_strconcat("/", value, NULL);
 }
 
 static void parse_event_report_msg_type(struct map_event *event,
-- 
1.8.3.4

