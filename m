Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <patila@marvell.com>, Cathy Luo <cluo@marvell.com>,
        Marc Yang <yangyang@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH v2 1/4] Bluetooth: btmrvl: fix race issue while stopping main thread
Date: Thu, 1 Jan 2015 00:13:39 -0800
Message-ID: <1420100022-4134-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

btmrvl_remove_card() calls kthread_stop() to stop the main thread,
but kthread_should_stop() is checked when all the activities are done
in the main thread before sleeping.
We will have kthread_should_stop() check as soon as main thread is
woken up. This fixes a crash issue caused due to an invalid memory
access while unnecessarily processing interrupts after card removal.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 30939c9..e3f5711 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -616,6 +616,11 @@ static int btmrvl_service_main_thread(void *data)
 
 		BT_DBG("main_thread woke up");
 
+		if (kthread_should_stop()) {
+			BT_DBG("main_thread: break from main thread");
+			break;
+		}
+
 		spin_lock_irqsave(&priv->driver_lock, flags);
 		if (adapter->int_count) {
 			adapter->int_count = 0;
-- 
1.8.1.4
