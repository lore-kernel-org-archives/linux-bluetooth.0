Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/7] android/tester: If print dbg log if emulator starts
Date: Wed, 17 Dec 2014 15:01:33 +0100
Message-Id: <1418824897-25342-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1418824897-25342-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1418824897-25342-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If emulator starts tester should print debug log instead of warn. In
quiet mode it's unnecessarily to print that emulator starts.
---
 android/tester-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index aa08126..152459d 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -2499,7 +2499,7 @@ static void emu_connectable_complete(uint16_t opcode, uint8_t status,
 		tester_warn("Emulated remote setup failed.");
 		step->action_status = BT_STATUS_FAIL;
 	} else {
-		tester_warn("Emulated remote setup done.");
+		tester_debug("Emulated remote setup done.");
 		step->action_status = BT_STATUS_SUCCESS;
 	}
 
-- 
1.9.3

