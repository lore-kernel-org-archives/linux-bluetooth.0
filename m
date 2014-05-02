Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 02/11] attrib: Discover descriptors using gatt_discover_desc
Date: Fri,  2 May 2014 12:57:33 +0200
Message-Id: <1399028262-17187-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c    | 49 ++++++++++++-------------------------------------
 attrib/interactive.c | 49 ++++++++++---------------------------------------
 2 files changed, 22 insertions(+), 76 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 5e0f820..bca7f69 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -400,49 +400,23 @@ error:
 	return FALSE;
 }
 
-static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_desc_cb(uint8_t status, GSList *descriptors, void *user_data)
 {
-	struct att_data_list *list;
-	guint8 format;
-	int i;
+	GSList *l;
 
-	if (status != 0) {
-		g_printerr("Discover all characteristic descriptors failed: "
-						"%s\n", att_ecode2str(status));
-		goto done;
+	if (status) {
+		g_printerr("Discover descriptors failed: %s\n",
+							att_ecode2str(status));
+		return;
 	}
 
-	list = dec_find_info_resp(pdu, plen, &format);
-	if (list == NULL)
-		goto done;
+	for (l = descriptors; l; l = l->next) {
+		struct gatt_desc *desc = l->data;
 
-	for (i = 0; i < list->num; i++) {
-		char uuidstr[MAX_LEN_UUID_STR];
-		uint16_t handle;
-		uint8_t *value;
-		bt_uuid_t uuid;
-
-		value = list->data[i];
-		handle = get_le16(value);
-
-		if (format == ATT_FIND_INFO_RESP_FMT_16BIT)
-			bt_uuid16_create(&uuid, get_le16(&value[2]));
-		else {
-			uint128_t u128;
-
-			/* Converts from LE to BE byte order */
-			bswap_128(&value[2], &u128);
-			bt_uuid128_create(&uuid, u128);
-		}
-
-		bt_uuid_to_string(&uuid, uuidstr, MAX_LEN_UUID_STR);
-		g_print("handle = 0x%04x, uuid = %s\n", handle, uuidstr);
+		g_print("handle = 0x%04x, uuid = %s\n", desc->handle,
+								desc->uuid);
 	}
 
-	att_data_list_free(list);
-
-done:
 	if (!opt_listen)
 		g_main_loop_quit(event_loop);
 }
@@ -451,7 +425,8 @@ static gboolean characteristics_desc(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
-	gatt_discover_char_desc(attrib, opt_start, opt_end, char_desc_cb, NULL);
+	gatt_discover_desc(attrib, opt_start, opt_end, NULL, char_desc_cb,
+									NULL);
 
 	return FALSE;
 }
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 4865944..08f39f7 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -269,51 +269,22 @@ static void char_cb(uint8_t status, GSList *characteristics, void *user_data)
 	}
 }
 
-static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_desc_cb(uint8_t status, GSList *descriptors, void *user_data)
 {
-	struct att_data_list *list;
-	guint8 format;
-	uint16_t handle = 0xffff;
-	int i;
+	GSList *l;
 
-	if (status != 0) {
-		rl_printf("Discover descriptors finished: %s\n",
-						att_ecode2str(status));
+	if (status) {
+		error("Discover descriptors failed: %s\n",
+							att_ecode2str(status));
 		return;
 	}
 
-	list = dec_find_info_resp(pdu, plen, &format);
-	if (list == NULL)
-		return;
+	for (l = descriptors; l; l = l->next) {
+		struct gatt_desc *desc = l->data;
 
-	for (i = 0; i < list->num; i++) {
-		char uuidstr[MAX_LEN_UUID_STR];
-		uint8_t *value;
-		bt_uuid_t uuid;
-
-		value = list->data[i];
-		handle = get_le16(value);
-
-		if (format == 0x01)
-			bt_uuid16_create(&uuid, get_le16(&value[2]));
-		else {
-			uint128_t u128;
-
-			/* Converts from LE to BE byte order */
-			bswap_128(&value[2], &u128);
-			bt_uuid128_create(&uuid, u128);
-		}
-
-		bt_uuid_to_string(&uuid, uuidstr, MAX_LEN_UUID_STR);
-		rl_printf("handle: 0x%04x, uuid: %s\n", handle, uuidstr);
+		rl_printf("handle: 0x%04x, uuid: %s\n", desc->handle,
+								desc->uuid);
 	}
-
-	att_data_list_free(list);
-
-	if (handle != 0xffff && handle < end)
-		gatt_discover_char_desc(attrib, handle + 1, end, char_desc_cb,
-									NULL);
 }
 
 static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
@@ -564,7 +535,7 @@ static void cmd_char_desc(int argcp, char **argvp)
 	} else
 		end = 0xffff;
 
-	gatt_discover_char_desc(attrib, start, end, char_desc_cb, NULL);
+	gatt_discover_desc(attrib, start, end, NULL, char_desc_cb, NULL);
 }
 
 static void cmd_read_hnd(int argcp, char **argvp)
-- 
1.9.2

