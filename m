Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 11/12] android/mcap: Fix using uninitialised value
Date: Fri, 27 Jun 2014 14:25:02 +0300
Message-Id: <1403868303-8129-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403855994-29262-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes clang warning:
...
android/mcap-lib.c:2366:20: warning: The left operand of '*' is a
garbage value
        return tv->tv_sec * 1000000ll + tv->tv_nsec / 1000ll;
               ~~~~~~~~~~ ^
1 warning generated.
...
---
 android/mcap-lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/mcap-lib.c b/android/mcap-lib.c
index 256abe1..79f6ce2 100644
--- a/android/mcap-lib.c
+++ b/android/mcap-lib.c
@@ -2454,7 +2454,8 @@ uint64_t mcap_get_timestamp(struct mcap_mcl *mcl,
 	if (given_time)
 		now = *given_time;
 	else
-		clock_gettime(CLK, &now);
+		if (clock_gettime(CLK, &now) < 0)
+			return MCAP_TMSTAMP_DONTSET;
 
 	tmstamp = time_us(&now) - time_us(&mcl->csp->base_time)
 		+ mcl->csp->base_tmstamp;
-- 
1.8.3.2

