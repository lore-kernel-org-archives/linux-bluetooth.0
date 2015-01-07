Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, Cathy Luo <cluo@marvell.com>,
        Amitkumar Karwar
	<akarwar@marvell.com>
Subject: [PATCH v2 2/2] Bluetooth: btmrvl: fix card reset and suspend race issue
Date: Tue, 6 Jan 2015 21:36:56 -0800
Message-ID: <1420609016-24947-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1420609016-24947-1-git-send-email-akarwar@marvell.com>
References: <1420609016-24947-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Sometimes suspend thread queues a command and wait for it's
response, meanwhile WLAN driver power cycles the card which
leads to crash. This patch makes sure that suspend thread is
woken up in remove path.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 2578b29..4135977 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -207,10 +207,14 @@ static int btmrvl_send_sync_cmd(struct btmrvl_private *priv, u16 opcode,
 	wake_up_interruptible(&priv->main_thread.wait_q);
 
 	if (!wait_event_interruptible_timeout(priv->adapter->cmd_wait_q,
-					      priv->adapter->cmd_complete,
+					      priv->adapter->cmd_complete ||
+					      priv->surprise_removed,
 					      WAIT_UNTIL_CMD_RESP))
 		return -ETIMEDOUT;
 
+	if (priv->surprise_removed)
+		return -EFAULT;
+
 	return 0;
 }
 
@@ -292,9 +296,10 @@ int btmrvl_enable_hs(struct btmrvl_private *priv)
 	}
 
 	ret = wait_event_interruptible_timeout(adapter->event_hs_wait_q,
-					       adapter->hs_state,
+					       adapter->hs_state ||
+					       priv->surprise_removed,
 					       WAIT_UNTIL_HS_STATE_CHANGED);
-	if (ret < 0) {
+	if (ret < 0 || priv->surprise_removed) {
 		BT_ERR("event_hs_wait_q terminated (%d): %d,%d,%d",
 		       ret, adapter->hs_state, adapter->ps_state,
 		       adapter->wakeup_tries);
-- 
1.8.1.4
