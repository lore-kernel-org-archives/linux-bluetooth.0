Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 6/6] Add support to change uuid on interactive mode in gatttool
Date: Thu, 27 Jan 2011 16:09:02 -0300
Message-Id: <1296155342-31956-6-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
References: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c |   53 +++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index e66b554..d39ee9c 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -686,6 +686,42 @@ static gboolean cmd_connect(gpointer cmd)
 	return FALSE;
 }
 
+static gboolean parse_uuid(const char *key, const char *value,
+				gpointer user_data, GError **error)
+{
+	if (!value)
+		return FALSE;
+
+	opt_uuid = g_try_malloc(sizeof(uuid_t));
+	if (opt_uuid == NULL)
+		return FALSE;
+
+	if (bt_string2uuid(opt_uuid, value) < 0)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean cmd_uuid(gpointer cmd)
+{
+	const char **c = (const char **) cmd;
+	GError *gerr = NULL;
+
+	if (c[1] == NULL) {
+		char *uuid = bt_uuid2string(opt_uuid);
+		show_message("uuid: %s\n", uuid);
+		free(uuid);
+		return FALSE;
+	}
+
+	if (parse_uuid(NULL, c[1], NULL, &gerr) == FALSE) {
+		show_message("uuid: invalid argument\n");
+		return FALSE;
+	}
+
+	return FALSE;
+}
+
 static struct {
 	char *cmd;
 	gboolean (*func)(gpointer cmd);
@@ -701,6 +737,7 @@ static struct {
 	{ "char-read",	characteristics_read,	NULL,	"Characteristcs read"},
 	{ "char-desc",	characteristics_desc,	NULL,
 					"Characteristics descriptor discovery"},
+	{ "uuid",	cmd_uuid,	"uuid",		"Set uuid"},
 	{ NULL, NULL, NULL, NULL}
 };
 
@@ -814,22 +851,6 @@ static void do_noninteractive(void)
 	g_main_loop_unref(event_loop);
 }
 
-static gboolean parse_uuid(const char *key, const char *value,
-				gpointer user_data, GError **error)
-{
-	if (!value)
-		return FALSE;
-
-	opt_uuid = g_try_malloc(sizeof(uuid_t));
-	if (opt_uuid == NULL)
-		return FALSE;
-
-	if (bt_string2uuid(opt_uuid, value) < 0)
-		return FALSE;
-
-	return TRUE;
-}
-
 static GOptionEntry primary_char_options[] = {
 	{ "start", 's' , 0, G_OPTION_ARG_INT, &opt_start,
 		"Starting handle(optional)", "0x0001" },
-- 
1.7.1

