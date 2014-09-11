Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 6/7] tools/hciattach : Fix syntax error
Date: Thu, 11 Sep 2014 18:50:06 +0530
Message-id: <1410441607-9687-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
References: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix the syntax error.
---
 tools/hciattach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index 1904ac5..db68b51 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -128,7 +128,7 @@ int uart_speed(int s)
 		return B3500000;
 #endif
 #ifdef B3710000
-	case 3710000
+	case 3710000:
 		return B3710000;
 #endif
 #ifdef B4000000
-- 
1.9.1

