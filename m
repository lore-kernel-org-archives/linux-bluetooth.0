Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 3/7] Create helper functions to deal with handles on interactive gatttool
Date: Mon, 21 Feb 2011 19:50:02 -0300
Message-Id: <1298328606-7993-3-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
References: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |   46 ++++++++++++++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 7cc03bc..e9f6019 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -238,36 +238,50 @@ static void cmd_primary(int argcp, char **argvp)
 	gatt_discover_primary(attrib, &uuid, primary_by_uuid_cb, NULL);
 }
 
-static void cmd_char(int argcp, char **argvp)
+static int strtohandle(int *dst, const char *src)
 {
-	int start = 0x0001;
-	int end = 0xffff;
+	char *e;
 
-	if (conn_state != STATE_CONNECTED) {
-		printf("Command failed: disconnected\n");
-		return;
+	*dst = strtoll(src, &e, 16);
+	if (errno != 0 || *e != '\0') {
+		return -1;
 	}
 
-	if (argcp > 1) {
-		char *e;
+	return 0;
+}
 
-		start = strtoll(argvp[1], &e, 16);
-		if (errno != 0 || *e != '\0') {
+static int set_handles(int *start, int *end, int argcp, char **argvp)
+{
+	if (argcp > 1) {
+		if (strtohandle(start, argvp[1])) {
 			printf("Invalid start handle: %s\n", argvp[1]);
-			return;
+			return -1;
 		}
 	}
 
 	if (argcp > 2) {
-		char *e;
-
-		end = strtoll(argvp[2], &e, 16);
-		if (errno != 0 || *e != '\0') {
+		if (strtohandle(end, argvp[2])) {
 			printf("Invalid end handle: %s\n", argvp[2]);
-			return;
+			return -1;
 		}
 	}
 
+	return 0;
+}
+
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
+	if (set_handles(&start, &end, argcp, argvp))
+		return;
+
 	gatt_discover_char(attrib, start, end, char_cb, NULL);
 
 	return;
-- 
1.7.1

