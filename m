Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 2/2] gatttool: Add "included" command
Date: Wed,  4 Apr 2012 16:45:53 -0400
Message-Id: <1333572353-10332-3-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1333572353-10332-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1333572353-10332-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

New command to find included services in interactive mode.
---
 attrib/interactive.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 0064ba2..a7757ad 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -206,6 +206,28 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	rl_forced_update_display();
 }
 
+static void included_cb(GSList *includes, guint8 status, gpointer user_data)
+{
+	GSList *l;
+
+	if (status) {
+		printf("Find included services failed: %s\n",
+						att_ecode2str(status));
+		return;
+	}
+
+	printf("\n");
+	for (l = includes; l; l = l->next) {
+		struct gatt_included *incl = l->data;
+		printf("handle: 0x%04x, start handle: 0x%04x, "
+				"end handle: 0x%04x uuid: %s\n",
+				incl->handle, incl->range.start,
+				incl->range.end, incl->uuid);
+	}
+
+	rl_forced_update_display();
+}
+
 static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 {
 	GSList *l;
@@ -415,6 +437,36 @@ static int strtohandle(const char *src)
 	return dst;
 }
 
+static void cmd_included(int argcp, char **argvp)
+{
+	int start = 0x0001;
+	int end = 0xffff;
+
+	if (conn_state != STATE_CONNECTED) {
+		printf("Command failed: disconnected\n");
+		return;
+	}
+
+	if (argcp > 1) {
+		start = strtohandle(argvp[1]);
+		if (start < 0) {
+			printf("Invalid start handle: %s\n", argvp[1]);
+			return;
+		}
+		end = start;
+	}
+
+	if (argcp > 2) {
+		end = strtohandle(argvp[2]);
+		if (end < 0) {
+			printf("Invalid end handle: %s\n", argvp[2]);
+			return;
+		}
+	}
+
+	gatt_find_included(attrib, start, end, included_cb, NULL);
+}
+
 static void cmd_char(int argcp, char **argvp)
 {
 	int start = 0x0001;
@@ -741,6 +793,8 @@ static struct {
 		"Disconnect from a remote device" },
 	{ "primary",		cmd_primary,	"[UUID]",
 		"Primary Service Discovery" },
+	{ "included",		cmd_included,	"[start hnd [end hnd]]",
+		"Find Included Services" },
 	{ "characteristics",	cmd_char,	"[start hnd [end hnd [UUID]]]",
 		"Characteristics Discovery" },
 	{ "char-desc",		cmd_char_desc,	"[start hnd] [end hnd]",
-- 
1.7.9.5

