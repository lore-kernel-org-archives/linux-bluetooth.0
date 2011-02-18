Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v2 06/14] Convert from host to network order before to print UUID128 values
Date: Fri, 18 Feb 2011 20:29:25 -0200
Message-Id: <1298068173-16518-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

UUID128 values are now stored on host order and need to be converted
to network order to be displayed properly.
---
 lib/sdp.c         |   30 +++++++++++++++++-------------
 src/glib-helper.c |   14 ++++++++------
 tools/sdptool.c   |   16 +++++++++-------
 3 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 3c4cd50..75154e9 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -285,13 +285,15 @@ int sdp_uuid2strn(const uuid_t *uuid, char *str, size_t n)
 		unsigned short data3;
 		unsigned int   data4;
 		unsigned short data5;
+		uint128_t n128;
 
-		memcpy(&data0, &uuid->value.uuid128.data[0], 4);
-		memcpy(&data1, &uuid->value.uuid128.data[4], 2);
-		memcpy(&data2, &uuid->value.uuid128.data[6], 2);
-		memcpy(&data3, &uuid->value.uuid128.data[8], 2);
-		memcpy(&data4, &uuid->value.uuid128.data[10], 4);
-		memcpy(&data5, &uuid->value.uuid128.data[14], 2);
+		hton128(&uuid->value.uuid128, &n128);
+		memcpy(&data0, &n128.data[0], 4);
+		memcpy(&data1, &n128.data[4], 2);
+		memcpy(&data2, &n128.data[6], 2);
+		memcpy(&data3, &n128.data[8], 2);
+		memcpy(&data4, &n128.data[10], 4);
+		memcpy(&data5, &n128.data[14], 2);
 
 		snprintf(str, n, "%.8x-%.4x-%.4x-%.4x-%.8x%.4x",
 				ntohl(data0), ntohs(data1),
@@ -333,13 +335,15 @@ void sdp_uuid_print(const uuid_t *uuid)
 		unsigned short data3;
 		unsigned int data4;
 		unsigned short data5;
-
-		memcpy(&data0, &uuid->value.uuid128.data[0], 4);
-		memcpy(&data1, &uuid->value.uuid128.data[4], 2);
-		memcpy(&data2, &uuid->value.uuid128.data[6], 2);
-		memcpy(&data3, &uuid->value.uuid128.data[8], 2);
-		memcpy(&data4, &uuid->value.uuid128.data[10], 4);
-		memcpy(&data5, &uuid->value.uuid128.data[14], 2);
+		uint128_t n128;
+
+		hton128(&uuid->value.uuid128, &n128);
+		memcpy(&data0, &n128.data[0], 4);
+		memcpy(&data1, &n128.data[4], 2);
+		memcpy(&data2, &n128.data[6], 2);
+		memcpy(&data3, &n128.data[8], 2);
+		memcpy(&data4, &n128.data[10], 4);
+		memcpy(&data5, &n128.data[14], 2);
 
 		SDPDBG("  uint128_t : 0x%.8x-", ntohl(data0));
 		SDPDBG("%.4x-", ntohs(data1));
diff --git a/src/glib-helper.c b/src/glib-helper.c
index 22c14e7..2b7e1b3 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -372,6 +372,7 @@ char *bt_uuid2string(uuid_t *uuid)
 {
 	gchar *str;
 	uuid_t uuid128;
+	uint128_t n128;
 	unsigned int data0;
 	unsigned short data1;
 	unsigned short data2;
@@ -397,12 +398,13 @@ char *bt_uuid2string(uuid_t *uuid)
 		return NULL;
 	}
 
-	memcpy(&data0, &uuid128.value.uuid128.data[0], 4);
-	memcpy(&data1, &uuid128.value.uuid128.data[4], 2);
-	memcpy(&data2, &uuid128.value.uuid128.data[6], 2);
-	memcpy(&data3, &uuid128.value.uuid128.data[8], 2);
-	memcpy(&data4, &uuid128.value.uuid128.data[10], 4);
-	memcpy(&data5, &uuid128.value.uuid128.data[14], 2);
+	hton128(&uuid128.value.uuid128, &n128);
+	memcpy(&data0, &n128.data[0], 4);
+	memcpy(&data1, &n128.data[4], 2);
+	memcpy(&data2, &n128.data[6], 2);
+	memcpy(&data3, &n128.data[8], 2);
+	memcpy(&data4, &n128.data[10], 4);
+	memcpy(&data5, &n128.data[14], 2);
 
 	str = g_try_malloc0(MAX_LEN_UUID_STR);
 	if (!str)
diff --git a/tools/sdptool.c b/tools/sdptool.c
index 140a46a..341e258 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -389,13 +389,15 @@ static void sdp_uuid_printf(uuid_t *uuid, struct attrib_context *context, int in
 			unsigned short data3;
 			unsigned int data4;
 			unsigned short data5;
-
-			memcpy(&data0, &uuid->value.uuid128.data[0], 4);
-			memcpy(&data1, &uuid->value.uuid128.data[4], 2);
-			memcpy(&data2, &uuid->value.uuid128.data[6], 2);
-			memcpy(&data3, &uuid->value.uuid128.data[8], 2);
-			memcpy(&data4, &uuid->value.uuid128.data[10], 4);
-			memcpy(&data5, &uuid->value.uuid128.data[14], 2);
+			uint128_t n128;
+
+			hton128(&uuid->value.uuid128, &n128);
+			memcpy(&data0, &n128.data[0], 4);
+			memcpy(&data1, &n128.data[4], 2);
+			memcpy(&data2, &n128.data[6], 2);
+			memcpy(&data3, &n128.data[8], 2);
+			memcpy(&data4, &n128.data[10], 4);
+			memcpy(&data5, &n128.data[14], 2);
 
 			printf("%.*sUUID128 : 0x%.8x-%.4x-%.4x-%.4x-%.8x-%.4x\n",
 				indent, indent_spaces,
-- 
1.7.4.1

