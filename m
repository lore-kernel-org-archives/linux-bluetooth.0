Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v2 3/3] tools/seq2bseq : Fix the same expression issue in if
 condition
Date: Mon, 15 Sep 2014 11:40:05 +0530
Message-id: <1410761405-4525-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1410761405-4525-1-git-send-email-gowtham.ab@samsung.com>
References: <1410761405-4525-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix the usage of same expression on both sides of '||' in if
---
 tools/seq2bseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/seq2bseq.c b/tools/seq2bseq.c
index 7657a57..23f6c9e 100644
--- a/tools/seq2bseq.c
+++ b/tools/seq2bseq.c
@@ -40,7 +40,7 @@ static int convert_line(int fd, const char *line)
 	char str[3];
 	unsigned char val;
 
-	if (line[0] == '*' || line[0] == '\r' || line[0] == '\r')
+	if (line[0] == '*' || line[0] == '\r' || line[0] == '\n')
 		return 0;
 
 	while (1) {
-- 
1.9.1

