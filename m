Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 2/4] tools/hciattach : Fix syntax error
Date: Wed, 15 Oct 2014 19:38:20 +0530
Message-id: <1413382102-4049-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1413382102-4049-1-git-send-email-gowtham.ab@samsung.com>
References: <1413382102-4049-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This error may not be shown during normal compilation,
because of ifdef.
---
 tools/hciattach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index d8ef7e7..2ace6f5 100644
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

