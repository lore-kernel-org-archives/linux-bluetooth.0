Return-Path: <cyrus@holtmann.org>
From: Daniel Drake <dsd@laptop.org>
To: marcel@holtmann.org, bzhao@marvell.com, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btmrvl: fix thread stopping race
Message-Id: <20130611194020.9EFBEFAACD@dev.laptop.org>
Date: Tue, 11 Jun 2013 15:40:20 -0400 (EDT)
List-ID: <linux-bluetooth.vger.kernel.org>

There is currently a race condition in the btmrvl_remove_card() which
is causing hangs on suspend for OLPC. When the race occurs,
kthread_stop() never returns.

The problem is that btmrvl_service_main_thread() calls kthread_should_stop()
and then does a fair number of things before restarting the loop and
sleeping.

If the thread gets stopped after kthread_should_stop() is checked, but
before the sleep happens, the thread will go to sleep and won't necessarily
be woken up.

Move the kthread_should_stop() check into a race-free place.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/bluetooth/btmrvl_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 3a4343b..9a9f518 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -498,6 +498,10 @@ static int btmrvl_service_main_thread(void *data)
 		add_wait_queue(&thread->wait_q, &wait);
 
 		set_current_state(TASK_INTERRUPTIBLE);
+		if (kthread_should_stop()) {
+			BT_DBG("main_thread: break from main thread");
+			break;
+		}
 
 		if (adapter->wakeup_tries ||
 				((!adapter->int_count) &&
@@ -513,11 +517,6 @@ static int btmrvl_service_main_thread(void *data)
 
 		BT_DBG("main_thread woke up");
 
-		if (kthread_should_stop()) {
-			BT_DBG("main_thread: break from main thread");
-			break;
-		}
-
 		spin_lock_irqsave(&priv->driver_lock, flags);
 		if (adapter->int_count) {
 			adapter->int_count = 0;
-- 
1.8.1.4
