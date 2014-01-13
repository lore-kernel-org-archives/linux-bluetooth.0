Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] tools: Stop converting file if write failed in seq2bseq
Date: Mon, 13 Jan 2014 09:09:14 +0100
Message-Id: <1389600554-20669-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1389600554-20669-1-git-send-email-szymon.janc@tieto.com>
References: <1389600554-20669-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If write failed converted file would be broken. This make sure that
user is being informed about it.
---
 tools/seq2bseq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/seq2bseq.c b/tools/seq2bseq.c
index 9797f5f..7657a57 100644
--- a/tools/seq2bseq.c
+++ b/tools/seq2bseq.c
@@ -130,6 +130,7 @@ static void convert_file(const char *input_path, const char *output_path)
 
 	while (1) {
 		char *str;
+		int err;
 
 		str = fgets(line_buffer, line_size - 1, fp);
 		if (!str)
@@ -137,7 +138,12 @@ static void convert_file(const char *input_path, const char *output_path)
 
 		cur += strlen(str);
 
-		convert_line(fd, str);
+		err = convert_line(fd, str);
+		if (err < 0) {
+			fprintf(stderr, "Failed to convert file (%s)\n",
+								strerror(-err));
+			break;
+		}
 	}
 
 	fclose(fp);
-- 
1.8.3.2

