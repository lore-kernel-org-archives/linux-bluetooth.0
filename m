Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 03/14] android/tester-ng: Expose action step verification function
Date: Thu, 24 Jul 2014 10:37:56 +0200
Message-Id: <1406191087-5831-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed for profile specific testers to define step actions
(and verify their results) in their own file and not in tester-main.c
where only core actions, needed by all other testers should be defined.
---
 android/tester-main.c | 2 +-
 android/tester-main.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index e7b1e1b..bbb3375 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -560,7 +560,7 @@ static void schedule_callback_call(struct step *step)
 	g_idle_add(verify_callback, step);
 }
 
-static void schedule_action_verification(struct step *step)
+void schedule_action_verification(struct step *step)
 {
 	g_idle_add_full(G_PRIORITY_HIGH_IDLE, verify_action, step, NULL);
 }
diff --git a/android/tester-main.h b/android/tester-main.h
index a239ae1..0f3f165 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -266,6 +266,9 @@ void remove_hidhost_tests(void);
 struct queue *get_gatt_tests(void);
 void remove_gatt_tests(void);
 
+/* Generic tester API */
+void schedule_action_verification(struct step *step);
+
 /* Emulator actions */
 void emu_setup_powered_remote_action(void);
 void emu_set_pin_code_action(void);
-- 
1.9.1

