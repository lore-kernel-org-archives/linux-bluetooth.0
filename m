Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan
	<gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Scott James
 Remnant <keybuk@chromium.org>,
        Chin-Ran Lo <crlo@marvell.com>, Jeff CF Chen
	<jeffc@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Avinash Patil
	<patila@marvell.com>, Xinming Hu <huxm@marvell.com>,
        Bing Zhao
	<bzhao@marvell.com>
Subject: [PATCH] Bluetooth: btmrvl: wait for HOST_SLEEP_ENABLE event in suspend
Date: Tue, 1 Jul 2014 14:00:14 -0700
Message-ID: <1404248414-23650-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chin-Ran Lo <crlo@marvell.com>

After BT_CMD_HOST_SLEEP_ENABLE command finishes, driver should
wait until getting BT_EVENT_HOST_SLEEP_ENABLE event to complete
suspend procedure.
Without this patch the suspend handler would return success
earlier. By the time when the BT_EVENT_HOST_SLEEP_ENABLE event
comes in the controller driver could have already turned off the
bus clock. This causes kernel crash or system reboot eventually.

Cc: <stable@vger.kernel.org> # 3.13+
Signed-off-by: Chin-Ran Lo <crlo@marvell.com>
Signed-off-by: Jeff CF Chen <jeffc@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  |  1 +
 drivers/bluetooth/btmrvl_main.c | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index dc79f88..54d9f2e 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -68,6 +68,7 @@ struct btmrvl_adapter {
 	u8 hs_state;
 	u8 wakeup_tries;
 	wait_queue_head_t cmd_wait_q;
+	wait_queue_head_t event_hs_wait_q;
 	u8 cmd_complete;
 	bool is_suspended;
 };
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index e9dbddb..3ecba5c 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -114,6 +114,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 			adapter->hs_state = HS_ACTIVATED;
 			if (adapter->psmode)
 				adapter->ps_state = PS_SLEEP;
+			wake_up_interruptible(&adapter->event_hs_wait_q);
 			BT_DBG("HS ACTIVATED!");
 		} else {
 			BT_DBG("HS Enable failed");
@@ -253,11 +254,31 @@ EXPORT_SYMBOL_GPL(btmrvl_enable_ps);
 
 int btmrvl_enable_hs(struct btmrvl_private *priv)
 {
+	struct btmrvl_adapter *adapter = priv->adapter;
 	int ret;
 
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_HOST_SLEEP_ENABLE, NULL, 0);
-	if (ret)
+	if (ret) {
 		BT_ERR("Host sleep enable command failed\n");
+		return ret;
+	}
+
+	ret = wait_event_interruptible_timeout(adapter->event_hs_wait_q,
+					       adapter->hs_state,
+			msecs_to_jiffies(WAIT_UNTIL_HS_STATE_CHANGED));
+	if (ret < 0) {
+		BT_ERR("event_hs_wait_q terminated (%d): %d,%d,%d",
+		       ret, adapter->hs_state, adapter->ps_state,
+		       adapter->wakeup_tries);
+	} else if (!ret) {
+		BT_ERR("hs_enable timeout: %d,%d,%d", adapter->hs_state,
+		       adapter->ps_state, adapter->wakeup_tries);
+		ret = -ETIMEDOUT;
+	} else {
+		BT_DBG("host sleep enabled: %d,%d,%d", adapter->hs_state,
+		       adapter->ps_state, adapter->wakeup_tries);
+		ret = 0;
+	}
 
 	return ret;
 }
@@ -358,6 +379,7 @@ static void btmrvl_init_adapter(struct btmrvl_private *priv)
 	}
 
 	init_waitqueue_head(&priv->adapter->cmd_wait_q);
+	init_waitqueue_head(&priv->adapter->event_hs_wait_q);
 }
 
 static void btmrvl_free_adapter(struct btmrvl_private *priv)
@@ -666,6 +688,7 @@ int btmrvl_remove_card(struct btmrvl_private *priv)
 	hdev = priv->btmrvl_dev.hcidev;
 
 	wake_up_interruptible(&priv->adapter->cmd_wait_q);
+	wake_up_interruptible(&priv->adapter->event_hs_wait_q);
 
 	kthread_stop(priv->main_thread.task);
 
-- 
1.8.2.3
