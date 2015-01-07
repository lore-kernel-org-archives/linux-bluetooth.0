Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, Cathy Luo <cluo@marvell.com>,
        Amitkumar Karwar
	<akarwar@marvell.com>
Subject: [PATCH v2 1/2] Bluetooth: btmrvl: use msecs_to_jiffies within macro definition
Date: Tue, 6 Jan 2015 21:36:55 -0800
Message-ID: <1420609016-24947-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This change improves readability and fixes allignment problem.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  | 4 ++--
 drivers/bluetooth/btmrvl_main.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 5513204..e75f8ee 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -28,9 +28,9 @@
 #define BTM_UPLD_SIZE			2312
 
 /* Time to wait until Host Sleep state change in millisecond */
-#define WAIT_UNTIL_HS_STATE_CHANGED	5000
+#define WAIT_UNTIL_HS_STATE_CHANGED	msecs_to_jiffies(5000)
 /* Time to wait for command response in millisecond */
-#define WAIT_UNTIL_CMD_RESP		5000
+#define WAIT_UNTIL_CMD_RESP		msecs_to_jiffies(5000)
 
 enum rdwr_status {
 	RDWR_STATUS_SUCCESS = 0,
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index c4a542c..2578b29 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -207,8 +207,8 @@ static int btmrvl_send_sync_cmd(struct btmrvl_private *priv, u16 opcode,
 	wake_up_interruptible(&priv->main_thread.wait_q);
 
 	if (!wait_event_interruptible_timeout(priv->adapter->cmd_wait_q,
-				priv->adapter->cmd_complete,
-				msecs_to_jiffies(WAIT_UNTIL_CMD_RESP)))
+					      priv->adapter->cmd_complete,
+					      WAIT_UNTIL_CMD_RESP))
 		return -ETIMEDOUT;
 
 	return 0;
@@ -293,7 +293,7 @@ int btmrvl_enable_hs(struct btmrvl_private *priv)
 
 	ret = wait_event_interruptible_timeout(adapter->event_hs_wait_q,
 					       adapter->hs_state,
-			msecs_to_jiffies(WAIT_UNTIL_HS_STATE_CHANGED));
+					       WAIT_UNTIL_HS_STATE_CHANGED);
 	if (ret < 0) {
 		BT_ERR("event_hs_wait_q terminated (%d): %d,%d,%d",
 		       ret, adapter->hs_state, adapter->ps_state,
-- 
1.8.1.4
