Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] monitor/l2cap: Fix buffer overflow issue
Date: Mon, 15 Dec 2014 19:29:14 +0530
Message-id: <1418651954-15378-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

String copy function overflows destination buffer.
	strcat(str, "LinkKey ");
	^~~~~~~~~~~~~~~~~~~~~~~
---
 monitor/l2cap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 6d9b1ce..27341fd 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2379,7 +2379,7 @@ static void print_smp_auth_req(uint8_t auth_req)
 
 static void print_smp_key_dist(const char *label, uint8_t dist)
 {
-	char str[19];
+	char str[27];
 
 	if (!(dist & 0x07)) {
 		strcpy(str, "<none> ");
-- 
1.9.1

