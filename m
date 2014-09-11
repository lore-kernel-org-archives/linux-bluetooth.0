Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 5/7] tools/seq2bseq : Fix the same expression issue in if
 condition
Date: Thu, 11 Sep 2014 18:50:05 +0530
Message-id: <1410441607-9687-5-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
References: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix the usage of same expression on both sides of '||' in if
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

