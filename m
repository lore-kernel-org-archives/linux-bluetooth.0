Return-Path: <cyrus@holtmann.org>
Message-ID: <f0e5c4fab81cf4bf2ed4865a3a60c5c7.squirrel@mustache.e-dot.nl>
Date: Sat, 27 Dec 2014 00:42:34 +0100
Subject: [PATCH] Fix sdptool search with UUID128
From: "Jeroen Sack" <maillist@jeroensack.nl>
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When running sdptool search with an UUID128 it will give
a segmentation fault, this patch will make it work.

I think it would be better to do via uuid-helper.c, but
the names in uuid-helper are different from the ones
in sdptool.

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 17561b1..108beba 100644
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
@@ -4085,6 +4096,31 @@ static int cmd_search(int argc, char **argv)
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
+			&data0, &data1, &data2, &data3, &data4, &data5) == 6) {
+
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

