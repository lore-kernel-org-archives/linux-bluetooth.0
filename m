Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/handsfree: Fix not sending callheld=2 when single call was held
Date: Wed, 19 Mar 2014 08:25:26 +0100
Message-Id: <1395213926-16351-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1395213926-16351-1-git-send-email-szymon.janc@tieto.com>
References: <1395213926-16351-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index ebeb751..d56a812 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2091,7 +2091,6 @@ static void phone_state_idle(int num_active, int num_held)
 				device.num_held == num_active) {
 			/* TODO better way for forcing indicator */
 			device.inds[IND_CALLHELD].val = 0;
-			update_indicator(IND_CALLHELD, 1);
 		} else if ((num_active > 0 || num_held > 0) &&
 						device.num_active == 0 &&
 						device.num_held == 0) {
@@ -2102,11 +2101,10 @@ static void phone_state_idle(int num_active, int num_held)
 			connect_audio();
 		} else if (num_active == 0 && num_held == 0) {
 			disconnect_sco();
-		} else {
-			update_indicator(IND_CALLHELD,
-					num_held ? (num_active ? 1 : 2) : 0);
 		}
 
+		update_indicator(IND_CALLHELD,
+					num_held ? (num_active ? 1 : 2) : 0);
 		update_indicator(IND_CALL, !!(num_active + num_held));
 		update_indicator(IND_CALLSETUP, 0);
 		break;
-- 
1.8.5.3

