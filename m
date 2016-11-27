Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Loic Poulain <loic.poulain@gmail.com>
To: luiz.von.dentz@intel.com
Cc: linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@gmail.com>
Subject: [PATCH] shared/mainloop: Fix msec to nsec conversion in timerfd config
Date: Sun, 27 Nov 2016 19:51:36 +0100
Message-Id: <1480272696-3760-1-git-send-email-loic.poulain@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/mainloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index 9fff615..eacb6a4 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -311,7 +311,7 @@ static inline int timeout_set(int fd, unsigned int msec)
 	itimer.it_interval.tv_sec = 0;
 	itimer.it_interval.tv_nsec = 0;
 	itimer.it_value.tv_sec = sec;
-	itimer.it_value.tv_nsec = (msec - (sec * 1000)) * 1000;
+	itimer.it_value.tv_nsec = (msec - (sec * 1000)) * 1000 * 1000;
 
 	return timerfd_settime(fd, 0, &itimer, NULL);
 }
-- 
1.9.1

