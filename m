Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/handsfree: Fix cut and paste typo
Date: Thu,  6 Nov 2014 14:55:07 +0200
Message-Id: <1415278508-3929-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415278508-3929-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415278508-3929-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-handsfree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 2834c80..8b644f3 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -466,8 +466,6 @@ static bt_status_t stop_voice_recognition_real(bt_bdaddr_t *bd_addr)
 	if (bd_addr)
 		memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
-
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_STOP_VR,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
-- 
1.9.1

