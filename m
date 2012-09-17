Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ v2 2/4] gatttool: Add "included" command
Date: Mon, 17 Sep 2012 17:46:42 -0300
Message-Id: <1347914804-29624-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1347914804-29624-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1347914804-29624-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

New command to find included services in interactive mode.
---
 attrib/interactive.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index c96df3e..ec5f2a5 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -209,6 +209,34 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
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
+						"end handle: 0x%04x uuid: %s\n",
+						incl->handle, incl->range.start,
+						incl->range.end, incl->uuid);
+	}
+
+done:
+	rl_forced_update_display();
+}
+
 static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 {
 	GSList *l;
@@ -426,6 +454,36 @@ static int strtohandle(const char *src)
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
@@ -751,6 +809,8 @@ static struct {
 		"Disconnect from a remote device" },
 	{ "primary",		cmd_primary,	"[UUID]",
 		"Primary Service Discovery" },
+	{ "included",		cmd_included,	"[start hnd [end hnd]]",
+		"Find Included Services" },
 	{ "characteristics",	cmd_char,	"[start hnd [end hnd [UUID]]]",
 		"Characteristics Discovery" },
 	{ "char-desc",		cmd_char_desc,	"[start hnd] [end hnd]",
-- 
1.7.12

