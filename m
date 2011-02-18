Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v2 07/14] Convert from network to host order on bt_string2uuid function
Date: Fri, 18 Feb 2011 20:29:26 -0200
Message-Id: <1298068173-16518-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

UUID128 string values are given in network order and needs to be
converted to host order to keep the consistency.
---
 src/glib-helper.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/glib-helper.c b/src/glib-helper.c
index 2b7e1b3..84f3380 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -515,7 +515,7 @@ int bt_string2uuid(uuid_t *uuid, const char *string)
 	if (is_uuid128(string) &&
 			sscanf(string, "%08x-%04hx-%04hx-%04hx-%08x%04hx",
 				&data0, &data1, &data2, &data3, &data4, &data5) == 6) {
-		uint8_t val[16];
+		uint128_t n128, h128;
 
 		data0 = g_htonl(data0);
 		data1 = g_htons(data1);
@@ -524,14 +524,15 @@ int bt_string2uuid(uuid_t *uuid, const char *string)
 		data4 = g_htonl(data4);
 		data5 = g_htons(data5);
 
-		memcpy(&val[0], &data0, 4);
-		memcpy(&val[4], &data1, 2);
-		memcpy(&val[6], &data2, 2);
-		memcpy(&val[8], &data3, 2);
-		memcpy(&val[10], &data4, 4);
-		memcpy(&val[14], &data5, 2);
+		memcpy(&n128.data[0], &data0, 4);
+		memcpy(&n128.data[4], &data1, 2);
+		memcpy(&n128.data[6], &data2, 2);
+		memcpy(&n128.data[8], &data3, 2);
+		memcpy(&n128.data[10], &data4, 4);
+		memcpy(&n128.data[14], &data5, 2);
 
-		sdp_uuid128_create(uuid, val);
+		ntoh128(&n128, &h128);
+		sdp_uuid128_create(uuid, &h128);
 
 		return 0;
 	} else {
-- 
1.7.4.1

