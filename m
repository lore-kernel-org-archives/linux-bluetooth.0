Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] obexd/client: Fix leaking memory on MNS
Date: Mon, 15 Sep 2014 13:51:05 +0300
Message-Id: <1410778266-2891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case an event is received twice, due to remote side misbehaving or
not, it would leak the previous data.
---
 obexd/client/mns.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index d638886..124dbcf 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -194,6 +194,8 @@ static void parse_event_report_folder(struct map_event *event,
 	if (!value)
 		return;
 
+	g_free(event->folder);
+
 	if (g_str_has_prefix(value, "/"))
 		event->folder = g_strdup(value);
 	else
@@ -206,6 +208,8 @@ static void parse_event_report_old_folder(struct map_event *event,
 	if (!value)
 		return;
 
+	g_free(event->old_folder);
+
 	if (g_str_has_prefix(value, "/"))
 		event->old_folder = g_strdup(value);
 	else
@@ -215,6 +219,10 @@ static void parse_event_report_old_folder(struct map_event *event,
 static void parse_event_report_msg_type(struct map_event *event,
 							const char *value)
 {
+	if (!value)
+		return;
+
+	g_free(event->msg_type);
 	event->msg_type = g_strdup(value);
 }
 
-- 
1.9.3

