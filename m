Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 2/7] Add Characteristics Discovery option to interactive gatttool
Date: Mon, 21 Feb 2011 19:50:01 -0300
Message-Id: <1298328606-7993-2-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
References: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index b491314..7cc03bc 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -22,6 +22,7 @@
  */
 #include <string.h>
 #include <stdlib.h>
+#include <errno.h>
 #include <stdio.h>
 #include <glib.h>
 
@@ -145,6 +146,29 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	rl_forced_update_display();
 }
 
+static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
+{
+	GSList *l;
+
+	if (status) {
+		printf("Discover all characteristics failed: %s\n",
+							att_ecode2str(status));
+		return;
+	}
+
+	printf("\n");
+	for (l = characteristics; l; l = l->next) {
+		struct att_char *chars = l->data;
+
+		printf("handle: 0x%04x, char properties: 0x%02x, char value "
+				"handle: 0x%04x, uuid: %s\n", chars->handle,
+				chars->properties, chars->value_handle,
+				chars->uuid);
+	}
+
+	rl_forced_update_display();
+}
+
 static void cmd_exit(int argcp, char **argvp)
 {
 	rl_callback_handler_remove();
@@ -214,6 +238,41 @@ static void cmd_primary(int argcp, char **argvp)
 	gatt_discover_primary(attrib, &uuid, primary_by_uuid_cb, NULL);
 }
 
+static void cmd_char(int argcp, char **argvp)
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
+		char *e;
+
+		start = strtoll(argvp[1], &e, 16);
+		if (errno != 0 || *e != '\0') {
+			printf("Invalid start handle: %s\n", argvp[1]);
+			return;
+		}
+	}
+
+	if (argcp > 2) {
+		char *e;
+
+		end = strtoll(argvp[2], &e, 16);
+		if (errno != 0 || *e != '\0') {
+			printf("Invalid end handle: %s\n", argvp[2]);
+			return;
+		}
+	}
+
+	gatt_discover_char(attrib, start, end, char_cb, NULL);
+
+	return;
+}
+
 static struct {
 	const char *cmd;
 	void (*func)(int argcp, char **argvp);
@@ -230,6 +289,8 @@ static struct {
 		"Disconnect from a remote device" },
 	{ "primary",		cmd_primary,	"[UUID]",
 		"Primary Service Discovery" },
+	{ "characteristics",	cmd_char,	"[start hnd] [end hnd]",
+		"Characteristics Discovery" },
 	{ NULL, NULL, NULL}
 };
 
-- 
1.7.1

