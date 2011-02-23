Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v3 3/7] Create helper functions to deal with handles on interactive gatttool
Date: Wed, 23 Feb 2011 11:20:19 -0300
Message-Id: <1298470819-5452-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <20110223030903.GB16014@jh-x301>
References: <20110223030903.GB16014@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |   48 +++++++++++++++++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 7cc03bc..ed45894 100644
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
-	}
+	errno = 0;
+	*dst = strtoll(src, &e, 16);
+	if (errno != 0 || *e != '\0')
+		return -1;
 
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

