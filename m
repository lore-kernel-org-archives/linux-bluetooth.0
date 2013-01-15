Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] obexd: Add parameter SubjectLength to map_list_messages
Date: Tue, 15 Jan 2013 14:56:40 +0100
Message-Id: <1358258204-4090-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This parameter allows the client to request a maximum length of the
parameter "subject" in the messages listing.
---
 doc/obex-api.txt   |  9 +++++++--
 obexd/client/map.c | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index b2998de..bb14fba 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -539,8 +539,8 @@ Methods		void SetFolder(string name)
 			Returns an array containing the messages found in the
 			given folder.
 
-			Possible Filters: Offset, MaxCount, Fields, Type,
-			PeriodStart, PeriodEnd, Status, Recipient, Sender,
+			Possible Filters: Offset, MaxCount, SubjectLength, Fields,
+			Type, PeriodStart, PeriodEnd, Status, Recipient, Sender,
 			Priority
 
 			Each message is represented by an object path followed
@@ -627,6 +627,11 @@ Filter:		uint16 Offset:
 
 			Maximum number of items, default is 1024
 
+		uint8 SubjectLength:
+
+			Maximum length of the Subject property in the
+			message, default is 256
+
 		array{string} Fields:
 
 			Message fields, default is all values.
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 29efd51..54a6a7f 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1052,6 +1052,19 @@ fail:
 	return reply;
 }
 
+static GObexApparam *parse_subject_length(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	guint8 num;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BYTE)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &num);
+
+	return g_obex_apparam_set_uint8(apparam, MAP_AP_SUBJECTLENGTH, num);
+}
+
 static uint64_t get_filter_mask(const char *filterstr)
 {
 	int i;
@@ -1263,6 +1276,9 @@ static GObexApparam *parse_message_filters(GObexApparam *apparam,
 		} else if (strcasecmp(key, "MaxCount") == 0) {
 			if (parse_max_count(apparam, &value) == NULL)
 				return NULL;
+		} else if (strcasecmp(key, "SubjectLength") == 0) {
+			if (parse_subject_length(apparam, &value) == NULL)
+				return NULL;
 		} else if (strcasecmp(key, "Fields") == 0) {
 			if (parse_fields(apparam, &value) == NULL)
 				return NULL;
-- 
1.8.1

