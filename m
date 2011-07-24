Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 24 Jul 2011 00:10:35 -0400
Subject: [PATCH 1/7] Bluetooth: rfcomm: Remove unnecessary krfcommd event
Message-ID: <1311480635.4106.26.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removed superfluous event handling which was used to signal
that the rfcomm kthread had been woken. This appears to have been
used to prevent lost wakeups. Correctly ordering when the task
state is set to TASK_INTERRUPTIBLE is sufficient to prevent lost wakeups.

To prevent wakeups which occurred prior to initially setting
TASK_INTERRUPTIBLE from being lost, the main work of the thread loop -
rfcomm_process_sessions() - is performed prior to sleeping.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/rfcomm/core.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 5759bb7..5ba3f6d 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -62,7 +62,6 @@ static DEFINE_MUTEX(rfcomm_mutex);
 #define rfcomm_lock()	mutex_lock(&rfcomm_mutex)
 #define rfcomm_unlock()	mutex_unlock(&rfcomm_mutex)
 
-static unsigned long rfcomm_event;
 
 static LIST_HEAD(session_list);
 
@@ -120,7 +119,6 @@ static inline void rfcomm_schedule(void)
 {
 	if (!rfcomm_thread)
 		return;
-	set_bit(RFCOMM_SCHED_WAKEUP, &rfcomm_event);
 	wake_up_process(rfcomm_thread);
 }
 
@@ -2038,19 +2036,18 @@ static int rfcomm_run(void *unused)
 
 	rfcomm_add_listener(BDADDR_ANY);
 
-	while (!kthread_should_stop()) {
+	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (!test_bit(RFCOMM_SCHED_WAKEUP, &rfcomm_event)) {
-			/* No pending events. Let's sleep.
-			 * Incoming connections and data will wake us up. */
-			schedule();
-		}
-		set_current_state(TASK_RUNNING);
+
+		if (kthread_should_stop())
+			break;
 
 		/* Process stuff */
-		clear_bit(RFCOMM_SCHED_WAKEUP, &rfcomm_event);
 		rfcomm_process_sessions();
+
+		schedule();
 	}
+	__set_current_state(TASK_RUNNING);
 
 	rfcomm_kill_listener();
 
-- 
1.7.4.1

