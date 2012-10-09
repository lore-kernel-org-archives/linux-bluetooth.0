Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH v4 BlueZ 2/4] gatttool: Add "included" command
Date: Mon,  8 Oct 2012 21:17:36 -0300
Message-Id: <1349741858-18325-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1349741858-18325-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1349741858-18325-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

New command to find included services in interactive mode.
---
This produces a warning when applying, but the warning can be ignored for that
particular string.

WARNING:SPLIT_STRING: quoted string split across lines
#36: FILE: attrib/interactive.c:233:
+		printf("handle: 0x%04x, start handle: 0x%04x, "
+					"end handle: 0x%04x uuid: %s\n",

 attrib/interactive.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 8d9531f..85f72ad 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -211,6 +211,34 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	rl_forced_update_display();
 }
 
+static void included_cb(GSList *includes, guint8 status, gpointer user_data)
+{
+	GSList *l;
+
+	if (status) {
+		printf("Find included services failed: %s\n",
+							att_ecode2str(status));
+		goto done;
+	}
+
+	if (includes == NULL) {
+		printf("No included services found for this range\n");
+		goto done;
+	}
+
+	printf("\n");
+	for (l = includes; l; l = l->next) {
+		struct gatt_included *incl = l->data;
+		printf("handle: 0x%04x, start handle: 0x%04x, "
+					"end handle: 0x%04x uuid: %s\n",
+					incl->handle, incl->range.start,
+					incl->range.end, incl->uuid);
+	}
+
+done:
+	rl_forced_update_display();
+}
+
 static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 {
 	GSList *l;
@@ -431,6 +459,36 @@ static int strtohandle(const char *src)
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
@@ -743,6 +801,8 @@ static struct {
 		"Disconnect from a remote device" },
 	{ "primary",		cmd_primary,	"[UUID]",
 		"Primary Service Discovery" },
+	{ "included",		cmd_included,	"[start hnd [end hnd]]",
+		"Find Included Services" },
 	{ "characteristics",	cmd_char,	"[start hnd [end hnd [UUID]]]",
 		"Characteristics Discovery" },
 	{ "char-desc",		cmd_char_desc,	"[start hnd] [end hnd]",
-- 
1.7.12.2

