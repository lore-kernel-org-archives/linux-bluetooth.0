Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] tools: Add missing check of write() return value
Date: Sun, 12 Jan 2014 21:23:59 -0400
Message-Id: <1389576239-22061-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix clang error:

tools/seq2bseq.c: In function ‘convert_line’:
tools/seq2bseq.c:52:8: error: ignoring return value of ‘write’, declared
with attribute warn_unused_result [-Werror=unused-result]
---
 tools/seq2bseq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/seq2bseq.c b/tools/seq2bseq.c
index 6d70777..191e623 100644
--- a/tools/seq2bseq.c
+++ b/tools/seq2bseq.c
@@ -31,16 +31,17 @@
 #include <string.h>
 #include <stdlib.h>
 #include <getopt.h>
+#include <errno.h>
 #include <sys/stat.h>
 
-static void convert_line(int fd, const char *line)
+static int convert_line(int fd, const char *line)
 {
 	const char *ptr = line;
 	char str[3];
 	unsigned char val;
 
 	if (line[0] == '*' || line[0] == '\r' || line[0] == '\r')
-		return;
+		return 0;
 
 	while (1) {
 		str[0] = *ptr++;
@@ -49,7 +50,11 @@ static void convert_line(int fd, const char *line)
 
 		val = strtol(str, NULL, 16);
 
-		write(fd, &val, 1);
+		if (write(fd, &val, 1) < 0) {
+			int err = -errno;
+			perror("Failed to write to output file");
+			return err;
+		}
 
 		if (*ptr == '\r' || *ptr == '\n')
 			break;
@@ -57,6 +62,8 @@ static void convert_line(int fd, const char *line)
 		while (*ptr == ' ')
 			ptr++;
 	}
+
+	return 0;
 }
 
 static void convert_file(const char *input_path, const char *output_path)
@@ -133,7 +140,8 @@ static void convert_file(const char *input_path, const char *output_path)
 
 		cur += strlen(str);
 
-		convert_line(fd, str);
+		if (convert_line(fd, str) < 0)
+			break;
 	}
 
 	fclose(fp);
-- 
1.8.3.2

