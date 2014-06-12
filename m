Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] mcap: Fix possible overflow
Date: Thu, 12 Jun 2014 16:49:19 +0300
Message-Id: <1402580959-7383-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/health/mcap_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/health/mcap_sync.c b/profiles/health/mcap_sync.c
index cc89d47..a0cc02a 100644
--- a/profiles/health/mcap_sync.c
+++ b/profiles/health/mcap_sync.c
@@ -187,7 +187,7 @@ void mcap_sync_stop(struct mcap_mcl *mcl)
 
 static uint64_t time_us(struct timespec *tv)
 {
-	return tv->tv_sec * 1000000 + tv->tv_nsec / 1000;
+	return tv->tv_sec * 1000000ll + tv->tv_nsec / 1000ll;
 }
 
 static int64_t bt2us(int bt)
-- 
1.8.3.2

