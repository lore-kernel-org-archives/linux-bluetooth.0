Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 17/18] gatttool: Remove unused code
Date: Tue,  2 Apr 2013 12:51:04 -0400
Message-Id: <1364921465-31182-18-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

Since commit 6a3a89774c6738df4d5b77636c4ce747b7497ae9 the code
removed here has no sense.
---
 attrib/gatttool.c    |   16 +---------------
 attrib/interactive.c |   32 ++++----------------------------
 2 files changed, 5 insertions(+), 43 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 9049886..2013a15 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -255,14 +255,9 @@ done:
 static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct characteristic_data *char_data = user_data;
 	struct att_data_list *list;
 	int i;
 
-	if (status == ATT_ECODE_ATTR_NOT_FOUND &&
-					char_data->start != opt_start)
-		goto done;
-
 	if (status != 0) {
 		g_printerr("Read characteristics by UUID failed: %s\n",
 							att_ecode2str(status));
@@ -277,8 +272,6 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 		uint8_t *value = list->data[i];
 		int j;
 
-		char_data->start = att_get_u16(value) + 1;
-
 		g_print("handle: 0x%04x \t value: ", att_get_u16(value));
 		value += 2;
 		for (j = 0; j < list->len - 2; j++, value++)
@@ -289,7 +282,6 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 	att_data_list_free(list);
 
 done:
-	g_free(char_data);
 	g_main_loop_quit(event_loop);
 }
 
@@ -298,15 +290,9 @@ static gboolean characteristics_read(gpointer user_data)
 	GAttrib *attrib = user_data;
 
 	if (opt_uuid != NULL) {
-		struct characteristic_data *char_data;
-
-		char_data = g_new(struct characteristic_data, 1);
-		char_data->attrib = attrib;
-		char_data->start = opt_start;
-		char_data->end = opt_end;
 
 		gatt_read_char_by_uuid(attrib, opt_start, opt_end, opt_uuid,
-						char_read_by_uuid_cb, char_data);
+						char_read_by_uuid_cb, NULL);
 
 		return FALSE;
 	}
diff --git a/attrib/interactive.c b/attrib/interactive.c
index f194e33..e297bd7 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -56,13 +56,6 @@ static int opt_mtu = 0;
 static int start;
 static int end;
 
-struct characteristic_data {
-	uint16_t orig_start;
-	uint16_t start;
-	uint16_t end;
-	bt_uuid_t uuid;
-};
-
 static void cmd_help(int argcp, char **argvp);
 
 static enum state {
@@ -324,30 +317,23 @@ static void char_read_cb(uint8_t status, const uint8_t *value, size_t vlen,
 static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct characteristic_data *char_data = user_data;
 	struct att_data_list *list;
 	int i;
 
-	if (status == ATT_ECODE_ATTR_NOT_FOUND &&
-				char_data->start != char_data->orig_start)
-		goto done;
-
 	if (status != 0) {
 		printf("Read characteristics by UUID failed: %s\n",
 							att_ecode2str(status));
-		goto done;
+		return;
 	}
 
 	list = dec_read_by_type_resp(pdu, plen);
 	if (list == NULL)
-		goto done;
+		return;
 
 	for (i = 0; i < list->num; i++) {
 		uint8_t *value = list->data[i];
 		int j;
 
-		char_data->start = att_get_u16(value) + 1;
-
 		printf("\nhandle: 0x%04x \t value: ", att_get_u16(value));
 		value += 2;
 		for (j = 0; j < list->len - 2; j++, value++)
@@ -358,9 +344,6 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 	att_data_list_free(list);
 
 	rl_forced_update_display();
-
-done:
-	g_free(char_data);
 }
 
 static void cmd_exit(int argcp, char **argvp)
@@ -571,7 +554,6 @@ static void cmd_read_hnd(int argcp, char **argvp)
 
 static void cmd_read_uuid(int argcp, char **argvp)
 {
-	struct characteristic_data *char_data;
 	int start = 0x0001;
 	int end = 0xffff;
 	bt_uuid_t uuid;
@@ -607,14 +589,8 @@ static void cmd_read_uuid(int argcp, char **argvp)
 		}
 	}
 
-	char_data = g_new(struct characteristic_data, 1);
-	char_data->orig_start = start;
-	char_data->start = start;
-	char_data->end = end;
-	char_data->uuid = uuid;
-
-	gatt_read_char_by_uuid(attrib, start, end, &char_data->uuid,
-					char_read_by_uuid_cb, char_data);
+	gatt_read_char_by_uuid(attrib, start, end, &uuid, char_read_by_uuid_cb,
+									NULL);
 }
 
 static void char_write_req_cb(uint8_t status, void *user_data)
-- 
1.7.9.5

