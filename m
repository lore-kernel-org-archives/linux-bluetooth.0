Return-Path: <cyrus@holtmann.org>
From: gowtham babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, p.sinha@samsung.com,
	gowtham babu <gowtham.ab@samsung.com>
Subject: [PATCH 2/2] tools/hciattach : Fix syntax error
Date: Fri, 05 Sep 2014 19:24:49 +0530
Message-id: <1409925289-6065-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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

