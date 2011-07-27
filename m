Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCHv2 obexd 2/2] Fix writing out of bounds in add_slash func
Date: Wed, 27 Jul 2011 09:39:48 +0200
Message-Id: <1311752388-1391-2-git-send-email-radoslawjablonski@gmail.com>
In-Reply-To: <1311752388-1391-1-git-send-email-radoslawjablonski@gmail.com>
References: <1311752388-1391-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For long input string there was possibility to write out
of "dest" buffer. It usually ended with obexd crash little
later in some random place.
---
 plugins/vcard.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 2c13266..30841b7 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -101,25 +101,41 @@ static void add_slash(char *dest, const char *src, int len_max, int len)
 {
 	int i, j;
 
-	for (i = 0, j = 0; i < len && j < len_max; i++, j++) {
+	for (i = 0, j = 0; i < len && j + 1 < len_max; i++, j++) {
+		/* filling dest buffer - last field need to be reserved
+		 * for '\0'*/
 		switch (src[i]) {
 		case '\n':
+			if (j + 2 >= len_max)
+				/* not enough space in the buffer to put char
+				 * preceded with escaping sequence (and '\0' in
+				 * the end) */
+				goto done;
+
 			dest[j++] = '\\';
 			dest[j] = 'n';
 			break;
 		case '\r':
+			if (j + 2 >= len_max)
+				goto done;
+
 			dest[j++] = '\\';
 			dest[j] = 'r';
 			break;
 		case '\\':
 		case ';':
 		case ',':
+			if (j + 2 >= len_max)
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
 }
 
-- 
1.7.0.4

