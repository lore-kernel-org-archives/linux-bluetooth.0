Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH obexd] Fix writing out of bounds in add_slash func
Date: Thu, 21 Jul 2011 09:22:19 +0200
Message-Id: <1311232939-32431-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/plugins/vcard.c b/plugins/vcard.c
index b997fc4..a6eb5f5 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -101,27 +101,41 @@ static void add_slash(char *dest, const char *src, int len_max, int len)
 {
 	int i, j;
 
-	for (i = 0, j = 0; i < len && j < len_max; i++, j++) {
+	for (i = 0, j = 0; i < len && j < len_max - 1; i++, j++) {
+		/* filling dest buffer - last field need to be reserved
+		 * for '\0'*/
 		switch (src[i]) {
 		case '\n':
+			if (j == len_max - 2)
+				/* not enough space in the buffer to put char
+				 * preceded with escaping sequence */
+				goto done;
+
 			dest[j++] = '\\';
 			dest[j] = 'n';
 			break;
 		case '\r':
+			if (j == len_max - 2)
+				goto done;
+
 			dest[j++] = '\\';
 			dest[j] = 'r';
 			break;
 		case '\\':
 		case ';':
 		case ',':
+			if (j == len_max - 2)
+				goto done;
+
 			dest[j++] = '\\';
 		default:
 			dest[j] = src[i];
 			break;
 		}
 	}
+
+done:
 	dest[j] = 0;
-	return;
 }
 
 static void get_escaped_fields(char **fields, ...)
-- 
1.7.0.4

