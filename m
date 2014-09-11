Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 1/7] obexd/client : Handle the MAP Extended Event Report 1.1
Date: Thu, 11 Sep 2014 18:50:01 +0530
Message-id: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to handle the Extended Event Report 1.1

1) In SDP, the MAP supported featured bit is updated.
2) In map-event, corresponding new event type and the new attribute introduced in Event report 1.1 is added.
3) In mns corresponding handlers are added.

First two patches related to MAP 1.2 implementation.
Rest are all simple issues.
---
 lib/sdp.h                |  2 +-
 obexd/client/map-event.h |  7 ++++++-
 obexd/client/mns.c       | 30 ++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/lib/sdp.h b/lib/sdp.h
index cc10e9f..76f61e1 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -306,7 +306,7 @@ extern "C" {
 #define SDP_ATTR_MAS_INSTANCE_ID		0x0315
 #define SDP_ATTR_SUPPORTED_MESSAGE_TYPES	0x0316
 #define SDP_ATTR_PBAP_SUPPORTED_FEATURES	0x0317
-#define SDP_ATTR_MAP_SUPPORTED_FEATURES		0x0317
+#define SDP_ATTR_MAP_SUPPORTED_FEATURES		0x031f
 
 #define SDP_ATTR_SPECIFICATION_ID		0x0200
 #define SDP_ATTR_VENDOR_ID			0x0201
diff --git a/obexd/client/map-event.h b/obexd/client/map-event.h
index ba5d5d2..99cb0c2 100644
--- a/obexd/client/map-event.h
+++ b/obexd/client/map-event.h
@@ -32,7 +32,8 @@ enum map_event_type {
 	MAP_ET_MEMORY_FULL,
 	MAP_ET_MEMORY_AVAILABLE,
 	MAP_ET_MESSAGE_DELETED,
-	MAP_ET_MESSAGE_SHIFT
+	MAP_ET_MESSAGE_SHIFT,
+	MAP_ET_READ_STATUS_CHANGED
 };
 
 struct map_event {
@@ -41,6 +42,10 @@ struct map_event {
 	char *folder;
 	char *old_folder;
 	char *msg_type;
+	char *datetime;
+	char *subject;
+	char *sender_name;
+	char *priority;
 };
 
 /* Handle notification in map client.
diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index d638886..8087933 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -180,6 +180,8 @@ static void parse_event_report_type(struct map_event *event, const char *value)
 		event->type = MAP_ET_MESSAGE_DELETED;
 	else if (!g_ascii_strcasecmp(value, "MessageShift"))
 		event->type = MAP_ET_MESSAGE_SHIFT;
+	else if (!g_ascii_strcasecmp(value, "ReadStatusChanged"))
+		event->type = MAP_ET_READ_STATUS_CHANGED;
 }
 
 static void parse_event_report_handle(struct map_event *event,
@@ -218,6 +220,30 @@ static void parse_event_report_msg_type(struct map_event *event,
 	event->msg_type = g_strdup(value);
 }
 
+static void parse_event_report_date_time(struct map_event *event,
+                                                        const char *value)
+{
+	event->datetime = g_strdup(value);
+}
+
+static void parse_event_report_subject(struct map_event *event,
+                                                        const char *value)
+{
+	event->subject = g_strdup(value);
+}
+
+static void parse_event_report_sender_name(struct map_event *event,
+                                                        const char *value)
+{
+	event->sender_name = g_strdup(value);
+}
+
+static void parse_event_report_priority(struct map_event *event,
+                                                        const char *value)
+{
+	event->priority = g_strdup(value);
+}
+
 static struct map_event_report_parser {
 	const char *name;
 	void (*func) (struct map_event *event, const char *value);
@@ -227,6 +253,10 @@ static struct map_event_report_parser {
 		{ "folder", parse_event_report_folder },
 		{ "old_folder", parse_event_report_old_folder },
 		{ "msg_type", parse_event_report_msg_type },
+		{ "datetime", parse_event_report_date_time },
+		{ "subject", parse_event_report_subject },
+		{ "sender_name", parse_event_report_sender_name },
+		{ "priority", parse_event_report_priority },
 		{ }
 };
 
-- 
1.9.1

