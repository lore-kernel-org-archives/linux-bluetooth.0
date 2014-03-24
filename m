Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] android/handsfree: Send NO CARRIER if call was end due to carrier loss
Date: Mon, 24 Mar 2014 19:48:32 +0100
Message-Id: <1395686912-10919-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This was affecting TC_AG_TCA_BV_06_I qualification test case.
---

I have an impression that this should be handled by telephony stack,
not BT stack hence sending this as RFC.


 android/handsfree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index e1bf563..9b98591 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2093,6 +2093,13 @@ static void phone_state_idle(int num_active, int num_held)
 					num_held ? (num_active ? 1 : 2) : 0);
 		update_indicator(IND_CALL, !!(num_active + num_held));
 		update_indicator(IND_CALLSETUP, 0);
+
+		/* If call was terminated due to carrier lost send NO CARRIER */
+		if (num_active == 0 && num_held == 0 &&
+				device.inds[IND_SERVICE].val == 0 &&
+				(device.num_active > 0 || device.num_held > 0))
+				hfp_gw_send_info(device.gw, "NO CARRIER");
+
 		break;
 	default:
 		DBG("unhandled state %u", device.setup_state);
-- 
1.8.5.3

