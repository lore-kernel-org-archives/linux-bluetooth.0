Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 6/7] shared/hfp: Don't update offset if string parsing failed
Date: Tue, 11 Mar 2014 00:10:33 +0100
Message-Id: <1394493034-2417-6-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
References: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 3256931..36c8c3e 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -299,20 +299,22 @@ bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
 {
 	int i = 0;
 	const char *data = result->data;
+	unsigned int offset;
 
 	skip_whitespace(result);
 
 	if (data[result->offset] != '"')
 		return false;
 
-	result->offset++;
+	offset = result->offset;
+	offset++;
 
-	while (data[result->offset] != '\0' && data[result->offset] != '"') {
+	while (data[offset] != '\0' && data[offset] != '"') {
 		if (i == len)
 			return false;
 
-		buf[i++] = data[result->offset];
-		result->offset++;
+		buf[i++] = data[offset];
+		offset++;
 	}
 
 	if (i == len)
@@ -320,11 +322,13 @@ bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
 
 	buf[i] = '\0';
 
-	if (data[result->offset] == '"')
-		result->offset++;
+	if (data[offset] == '"')
+		offset++;
 	else
 		return false;
 
+	result->offset = offset;
+
 	skip_whitespace(result);
 	next_field(result);
 
@@ -335,6 +339,7 @@ bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
 								uint8_t len)
 {
 	const char *data = result->data;
+	unsigned int offset;
 	int i = 0;
 	char c;
 
@@ -344,13 +349,15 @@ bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
 	if (c == '"' || c == ')' || c == '(')
 		return false;
 
-	while (data[result->offset] != '\0' && data[result->offset] != ','
-					&& data[result->offset] != ')') {
+	offset = result->offset;
+
+	while (data[offset] != '\0' && data[offset] != ',' &&
+							data[offset] != ')') {
 		if (i == len)
 			return false;
 
-		buf[i++] = data[result->offset];
-		result->offset++;
+		buf[i++] = data[offset];
+		offset++;
 	}
 
 	if (i == len)
@@ -358,6 +365,8 @@ bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
 
 	buf[i] = '\0';
 
+	result->offset = offset;
+
 	next_field(result);
 
 	return true;
-- 
1.9.0

