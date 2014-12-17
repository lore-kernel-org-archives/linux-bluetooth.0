Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/5] android/tester: Set action status to fail if no l2cap data is given
Date: Wed, 17 Dec 2014 11:58:19 +0100
Message-Id: <1418813900-29056-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1418813900-29056-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1418813900-29056-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No status set in zeroized step mean that this status is SUCCESS (value
0). If no data is present while setting l2cap server, status should be
set to FAIL.
---
 android/tester-main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 33bdc69..19b2cb9 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -2645,7 +2645,8 @@ void emu_add_l2cap_server_action(void)
 
 	if (!l2cap_data) {
 		tester_warn("Invalid l2cap_data params");
-		return;
+		step->action_status = BT_STATUS_FAIL;
+		goto done;
 	}
 
 	bthost = hciemu_client_get_host(data->hciemu);
@@ -2655,6 +2656,7 @@ void emu_add_l2cap_server_action(void)
 
 	step->action_status = BT_STATUS_SUCCESS;
 
+done:
 	schedule_action_verification(step);
 }
 
-- 
1.9.3

