Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 1/6] Create a helper function to deal with handles on interactive gatttool
Date: Thu, 24 Feb 2011 17:38:25 -0300
Message-Id: <1298579910-15198-2-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1298579910-15198-1-git-send-email-sheldon.demario@openbossa.org>
References: <1298579910-15198-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 7cc03bc..7b18e90 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -238,6 +238,19 @@ static void cmd_primary(int argcp, char **argvp)
 	gatt_discover_primary(attrib, &uuid, primary_by_uuid_cb, NULL);
 }
 
+static int strtohandle(const char *src)
+{
+	char *e;
+	int dst;
+
+	errno = 0;
+	dst = strtoll(src, &e, 16);
+	if (errno != 0 || *e != '\0')
+		return -EINVAL;
+
+	return dst;
+}
+
 static void cmd_char(int argcp, char **argvp)
 {
 	int start = 0x0001;
@@ -249,28 +262,22 @@ static void cmd_char(int argcp, char **argvp)
 	}
 
 	if (argcp > 1) {
-		char *e;
-
-		start = strtoll(argvp[1], &e, 16);
-		if (errno != 0 || *e != '\0') {
+		start = strtohandle(argvp[1]);
+		if (start < 0) {
 			printf("Invalid start handle: %s\n", argvp[1]);
 			return;
 		}
 	}
 
 	if (argcp > 2) {
-		char *e;
-
-		end = strtoll(argvp[2], &e, 16);
-		if (errno != 0 || *e != '\0') {
+		end = strtohandle(argvp[2]);
+		if (end < 0) {
 			printf("Invalid end handle: %s\n", argvp[2]);
 			return;
 		}
 	}
 
 	gatt_discover_char(attrib, start, end, char_cb, NULL);
-
-	return;
 }
 
 static struct {
-- 
1.7.1

