Return-Path: <cyrus@holtmann.org>
From: gowtham babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	gowtham babu <gowtham.ab@samsung.com>
Subject: [PATCH] tools/seq2bseq : Fix the same expression issue in if condition
Date: Wed, 10 Sep 2014 12:12:43 +0530
Message-id: <1410331363-3548-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix the usage of same expression on both sides of '||' in if

Below are the list of similar patches under 'tools' which are not yet reviewed

1) tools/csr_usb : Fix Resource leak: file
2) tools/hciattach : Fix syntax error
3) tools/btsnoop : Fix variable reassigning issue
---
 tools/seq2bseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/seq2bseq.c b/tools/seq2bseq.c
index 7657a57..521d20e 100644
--- a/tools/seq2bseq.c
+++ b/tools/seq2bseq.c
@@ -40,7 +40,7 @@ static int convert_line(int fd, const char *line)
 	char str[3];
 	unsigned char val;
 
-	if (line[0] == '*' || line[0] == '\r' || line[0] == '\r')
+	if (line[0] == '*' || line[0] == '\r')
 		return 0;
 
 	while (1) {
-- 
1.9.1

