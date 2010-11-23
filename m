Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Extend discover characteristic by UUID in gatttool to fetch all values
Date: Tue, 23 Nov 2010 07:37:19 -0500
Message-Id: <1290515839-11867-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the number of characteristics returned exceeds the MTU size, it will
be needed to ask for more data until the handle range is entirely
searched.
---
 attrib/gatttool.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index d0ef6d3..6ad2cfb 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -401,9 +401,14 @@ done:
 static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
+	struct characteristic_data *char_data = user_data;
 	struct att_data_list *list;
 	int i;
 
+	if ((status == ATT_ECODE_ATTR_NOT_FOUND) &&
+			(char_data->start != opt_start))
+		goto done;
+
 	if (status != 0) {
 		g_printerr("Read characteristics by UUID failed: %s\n",
 							att_ecode2str(status));
@@ -418,6 +423,8 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 		uint8_t *value = list->data[i];
 		int j;
 
+		char_data->start = att_get_u16(value) + 1;
+
 		g_print("handle: 0x%04x \t value: ", att_get_u16(value));
 		value += 2;
 		for (j = 0; j < list->len - 2; j++, value++)
@@ -427,7 +434,14 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 
 	att_data_list_free(list);
 
+	gatt_read_char_by_uuid(char_data->attrib, char_data->start,
+					char_data->end, opt_uuid,
+					char_read_by_uuid_cb,
+					char_data);
+
+	return;
 done:
+	g_free(char_data);
 	g_main_loop_quit(event_loop);
 }
 
@@ -436,8 +450,16 @@ static gboolean characteristics_read(gpointer user_data)
 	GAttrib *attrib = user_data;
 
 	if (opt_uuid != NULL) {
+		struct characteristic_data *char_data;
+
+		char_data = g_new(struct characteristic_data, 1);
+		char_data->attrib = attrib;
+		char_data->start = opt_start;
+		char_data->end = opt_end;
+
 		gatt_read_char_by_uuid(attrib, opt_start, opt_end, opt_uuid,
-						char_read_by_uuid_cb, attrib);
+						char_read_by_uuid_cb, char_data);
+
 		return FALSE;
 	}
 
-- 
1.7.3.2

