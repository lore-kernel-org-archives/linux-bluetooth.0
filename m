Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] tools: Fix build error in seq2bseq
Date: Mon, 13 Jan 2014 09:09:13 +0100
Message-Id: <1389600554-20669-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't ignore return value of write. This fix following build error on
Ubuntu:

tools/seq2bseq.c: In function ‘convert_line’:
tools/seq2bseq.c:52:8: error: ignoring return value of ‘write’,
     declared with attribute warn_unused_result [-Werror=unused-result]
   write(fd, &val, 1);
---
 tools/seq2bseq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/seq2bseq.c b/tools/seq2bseq.c
index 6d70777..9797f5f 100644
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
@@ -49,7 +50,8 @@ static void convert_line(int fd, const char *line)
 
 		val = strtol(str, NULL, 16);
 
-		write(fd, &val, 1);
+		if (write(fd, &val, 1) < 0)
+			return -errno;
 
 		if (*ptr == '\r' || *ptr == '\n')
 			break;
@@ -57,6 +59,8 @@ static void convert_line(int fd, const char *line)
 		while (*ptr == ' ')
 			ptr++;
 	}
+
+	return 0;
 }
 
 static void convert_file(const char *input_path, const char *output_path)
-- 
1.8.3.2

