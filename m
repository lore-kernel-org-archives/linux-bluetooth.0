Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Gopal Tiwari <gtiwari@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: dzickus@redhat.com, gtiwari@redhat.com
Subject: [PATCH BlueZ 2/2] Possible bug fix nsk replaced with sk
Date: Fri, 20 Jul 2018 10:03:59 +0530
Message-Id: <1532061239-22481-2-git-send-email-gtiwari@redhat.com>
In-Reply-To: <1532061239-22481-1-git-send-email-gtiwari@redhat.com>
References: <1532061239-22481-1-git-send-email-gtiwari@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During the review of the code path found this scenario where
seems like nsk is replaced with sk. Where as sk is already free.
Fixing it.
---
 tools/rctest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index 6d84e07..909bc68 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -376,7 +376,7 @@ static void do_listen(void (*handler)(int sk))
 			//goto error;
 		}
 
-		if (priority > 0 && setsockopt(sk, SOL_SOCKET, SO_PRIORITY,
+		if (priority > 0 && setsockopt(nsk, SOL_SOCKET, SO_PRIORITY,
 					&priority, sizeof(priority)) < 0) {
 			syslog(LOG_ERR, "Can't set socket priority: %s (%d)",
 						strerror(errno), errno);
-- 
2.7.5

