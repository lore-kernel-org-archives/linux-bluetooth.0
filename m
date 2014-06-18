Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 09/11] android/health: Fix possible overflow
Date: Wed, 18 Jun 2014 16:33:52 +0300
Message-Id: <1403098434-28193-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/mcap-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/mcap-lib.c b/android/mcap-lib.c
index be9ce79..346688e 100644
--- a/android/mcap-lib.c
+++ b/android/mcap-lib.c
@@ -2357,7 +2357,7 @@ void mcap_sync_stop(struct mcap_mcl *mcl)
 
 static uint64_t time_us(struct timespec *tv)
 {
-	return tv->tv_sec * 1000000 + tv->tv_nsec / 1000;
+	return tv->tv_sec * 1000000ll + tv->tv_nsec / 1000ll;
 }
 
 static int64_t bt2us(int bt)
-- 
1.8.3.2

