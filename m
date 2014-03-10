Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 4/7] shared/hfp: Fix not NULL terminating parsed strings
Date: Tue, 11 Mar 2014 00:10:31 +0100
Message-Id: <1394493034-2417-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
References: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there were not enough space in output buffer
hfp_gw_result_get_string() and hfp_gw_result_get_unquoted_string()
wcould return true, but resulting string would not be NULL terminated.
---
 src/shared/hfp.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 1be53fb..e481360 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -308,13 +308,17 @@ bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
 	result->offset++;
 
 	while (data[result->offset] != '\0' && data[result->offset] != '"') {
-		if (i < len)
-			buf[i++] = data[result->offset];
+		if (i == len)
+			return false;
+
+		buf[i++] = data[result->offset];
 		result->offset++;
 	}
 
-	if (i < len)
-		buf[i++] = '\0';
+	if (i == len)
+		return false;
+
+	buf[i] = '\0';
 
 	if (data[result->offset] == '"')
 		result->offset++;
@@ -342,13 +346,17 @@ bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
 
 	while (data[result->offset] != '\0' && data[result->offset] != ','
 					&& data[result->offset] != ')') {
-		if (i < len)
-			buf[i++] = data[result->offset];
+		if (i == len)
+			return false;
+
+		buf[i++] = data[result->offset];
 		result->offset++;
 	}
 
-	if (i < len)
-		buf[i++] = '\0';
+	if (i == len)
+		return false;
+
+	buf[i] = '\0';
 
 	next_field(result);
 
-- 
1.9.0

