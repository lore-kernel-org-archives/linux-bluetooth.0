Return-Path: <cyrus@holtmann.org>
From: Jeroen Sack <maillist@jeroensack.nl>
To: linux-bluetooth@vger.kernel.org
Cc: Jeroen Sack <maillist@jeroensack.nl>
Subject: [PATCH 1/3] tools/sdptool: Fix search for UUID128
Date: Tue,  6 Jan 2015 23:32:22 +0100
Message-Id: <1420583544-9796-1-git-send-email-maillist@jeroensack.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When running sdptool search with an UUID128 it will give
a segmentation fault, this patch will make it work.

I think it would be better to do via uuid-helper.c, but
the names in uuid-helper are different from the ones
in sdptool.
---
 tools/sdptool.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 17561b1..a65fc95 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -35,6 +35,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <getopt.h>
+#include <stdbool.h>
 #include <sys/socket.h>
 
 #include <bluetooth/bluetooth.h>
@@ -67,6 +68,15 @@ static int estr2ba(char *str, bdaddr_t *ba)
 	return str2ba(str, ba);
 }
 
+static inline bool is_uuid128(const char *string)
+{
+	return (strlen(string) == 36 &&
+			string[8] == '-' &&
+			string[13] == '-' &&
+			string[18] == '-' &&
+			string[23] == '-');
+}
+
 #define DEFAULT_VIEW	0	/* Display only known attribute */
 #define TREE_VIEW	1	/* Display full attribute tree */
 #define RAW_VIEW	2	/* Display raw tree */
@@ -4038,6 +4048,7 @@ static int cmd_search(int argc, char **argv)
 {
 	struct search_context context;
 	unsigned char *uuid = NULL;
+	unsigned char uuid128[16];
 	uint32_t class = 0;
 	bdaddr_t bdaddr;
 	int has_addr = 0;
@@ -4085,6 +4096,30 @@ static int cmd_search(int argc, char **argv)
 		sscanf(context.svc + 2, "%X", &num);
 		class = num;
 		printf("Class 0x%X\n", class);
+	} else if(is_uuid128(context.svc)) {
+		/* This is a UUID128, so convert it to raw data
+		 * and put it in uuid pointer */
+		uint32_t data0, data4;
+		uint16_t data1, data2, data3, data5;
+
+		uuid = uuid128;
+
+		if(sscanf(context.svc, "%08x-%04hx-%04hx-%04hx-%08x%04hx",
+		          &data0, &data1, &data2, &data3, &data4, &data5) == 6) {
+			data0 = htonl(data0);
+			data1 = htons(data1);
+			data2 = htons(data2);
+			data3 = htons(data3);
+			data4 = htonl(data4);
+			data5 = htons(data5);
+
+			memcpy(&uuid[0], &data0, 4);
+			memcpy(&uuid[4], &data1, 2);
+			memcpy(&uuid[6], &data2, 2);
+			memcpy(&uuid[8], &data3, 2);
+			memcpy(&uuid[10], &data4, 4);
+			memcpy(&uuid[14], &data5, 2);
+		}
 	} else {
 		/* Convert class name to an UUID */
 
-- 
2.1.4

