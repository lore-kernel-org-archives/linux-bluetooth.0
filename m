Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 5/6] Add support to char descriptor discover on interactive mode in gatttool
Date: Thu, 27 Jan 2011 16:09:01 -0300
Message-Id: <1296155342-31956-5-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
References: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index f7d6056..e66b554 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -612,6 +612,9 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	if (list == NULL)
 		goto done;
 
+	if (opt_interactive)
+		rl_save_prompt();
+
 	for (i = 0; i < list->num; i++) {
 		char uuidstr[MAX_LEN_UUID_STR];
 		uint16_t handle;
@@ -627,19 +630,32 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			sdp_uuid128_create(&uuid, &value[2]);
 
 		sdp_uuid2strn(&uuid, uuidstr, MAX_LEN_UUID_STR);
-		g_print("handle = 0x%04x, uuid = %s\n", handle, uuidstr);
+		if (opt_interactive)
+			g_print("handle = 0x%04x, uuid = %s\n", handle, uuidstr);
+		else {
+			rl_message("handle = 0x%04x, uuid = %s\n", handle, uuidstr);
+			rl_on_new_line();
+		}
+	}
+
+	if (opt_interactive) {
+		rl_restore_prompt();
+		rl_forced_update_display();
 	}
 
 	att_data_list_free(list);
 
 done:
-	if (opt_listen == FALSE)
+	if ((opt_listen == FALSE) && (opt_interactive == FALSE))
 		g_main_loop_quit(event_loop);
 }
 
 static gboolean characteristics_desc(gpointer user_data)
 {
-	GAttrib *attrib = user_data;
+	if (opt_interactive && conn_state != STATE_CONNECTED) {
+		show_message("Fail: disconnected\n");
+		return FALSE;
+	}
 
 	gatt_find_info(attrib, opt_start, opt_end, char_desc_cb, NULL);
 
@@ -683,6 +699,8 @@ static struct {
 	{ "primary",	primary,	NULL,
 						"Primary Service Discovery"},
 	{ "char-read",	characteristics_read,	NULL,	"Characteristcs read"},
+	{ "char-desc",	characteristics_desc,	NULL,
+					"Characteristics descriptor discovery"},
 	{ NULL, NULL, NULL, NULL}
 };
 
-- 
1.7.1

