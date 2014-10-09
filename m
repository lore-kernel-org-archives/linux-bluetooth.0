Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix possible NULL pointer passing to function
Date: Thu,  9 Oct 2014 13:16:52 +0300
Message-Id: <1412849812-6498-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Silence code analyzers and follow strict C standard where passing NULL
pointer results in undefined behaviour.
---
 android/tester-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 30e1c59..ee3444f 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -801,12 +801,12 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
-	if (exp->store_srvc_handle)
+	if (exp->store_srvc_handle && step->callback_result.srvc_handle)
 		memcpy(exp->store_srvc_handle,
 					step->callback_result.srvc_handle,
 					sizeof(*exp->store_srvc_handle));
 
-	if (exp->store_char_handle)
+	if (exp->store_char_handle && step->callback_result.char_handle)
 		memcpy(exp->store_char_handle,
 					step->callback_result.char_handle,
 					sizeof(*exp->store_char_handle));
-- 
1.9.1

