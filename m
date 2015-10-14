Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Cathy Luo <cluo@marvell.com>, Zhaoyang Liu <liuzy@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 4/4] Bluetooth: btmrvl: change debug prints to btmrvl_dbg
Date: Wed, 14 Oct 2015 08:34:43 -0700
Message-ID: <1444836883-14701-4-git-send-email-akarwar@marvell.com>
In-Reply-To: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
References: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Zhaoyang Liu <liuzy@marvell.com>

This patch changes all debug print from BT_INFO/BT_DBG/BT_ERR
to marvell bluetooth driver specific debug functions.

Signed-off-by: Zhaoyang Liu <liuzy@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_debugfs.c |   3 +-
 drivers/bluetooth/btmrvl_main.c    | 145 ++++++++++-------
 drivers/bluetooth/btmrvl_sdio.c    | 311 ++++++++++++++++++++++---------------
 3 files changed, 275 insertions(+), 184 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index af52b03..7bbe3dc 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -257,7 +257,8 @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
 	priv->debugfs_data = dbg;
 
 	if (!dbg) {
-		BT_ERR("Can not allocate memory for btmrvl_debugfs_data.");
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "Can not allocate memory for btmrvl_debugfs_data.");
 		return;
 	}
 
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 8e53609..948055d 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -60,7 +60,8 @@ void btmrvl_interrupt(struct btmrvl_private *priv)
 	priv->adapter->int_count++;
 
 	if (priv->adapter->hs_state == HS_ACTIVATED) {
-		BT_DBG("BT: HS DEACTIVATED in ISR!");
+		btmrvl_dbg(priv->adapter, INTR,
+			   "BT: HS DEACTIVATED in ISR!");
 		priv->adapter->hs_state = HS_DEACTIVATED;
 	}
 
@@ -85,8 +86,9 @@ bool btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb)
 			wake_up_interruptible(&priv->adapter->cmd_wait_q);
 
 			if (hci_opcode_ogf(opcode) == 0x3F) {
-				BT_DBG("vendor event skipped: opcode=%#4.4x",
-				       opcode);
+				btmrvl_dbg(priv->adapter, EVENT,
+					   "vendor event skipped: opcode=%#4.4x",
+					   opcode);
 				kfree_skb(skb);
 				return false;
 			}
@@ -105,7 +107,8 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 
 	event = (struct btmrvl_event *) skb->data;
 	if (event->ec != 0xff) {
-		BT_DBG("Not Marvell Event=%x", event->ec);
+		btmrvl_dbg(adapter, ERROR,
+			   "Not Marvell Event=%x", event->ec);
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -117,19 +120,19 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 				adapter->psmode = 1;
 			else
 				adapter->psmode = 0;
-			BT_DBG("PS Mode:%s",
-				(adapter->psmode) ? "Enable" : "Disable");
+			btmrvl_dbg(adapter, EVENT, "PS Mode:%s",
+				   (adapter->psmode) ? "Enable" : "Disable");
 		} else {
-			BT_DBG("PS Mode command failed");
+			btmrvl_dbg(adapter, EVENT, "PS Mode command failed");
 		}
 		break;
 
 	case BT_EVENT_HOST_SLEEP_CONFIG:
 		if (!event->data[3])
-			BT_DBG("gpio=%x, gap=%x", event->data[1],
-							event->data[2]);
+			btmrvl_dbg(adapter, EVENT, "gpio=%x, gap=%x",
+				   event->data[1], event->data[2]);
 		else
-			BT_DBG("HSCFG command failed");
+			btmrvl_dbg(adapter, ERROR, "HSCFG command failed");
 		break;
 
 	case BT_EVENT_HOST_SLEEP_ENABLE:
@@ -138,32 +141,35 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 			if (adapter->psmode)
 				adapter->ps_state = PS_SLEEP;
 			wake_up_interruptible(&adapter->event_hs_wait_q);
-			BT_DBG("HS ACTIVATED!");
+			btmrvl_dbg(adapter, EVENT, "HS ACTIVATED!");
 		} else {
-			BT_DBG("HS Enable failed");
+			btmrvl_dbg(adapter, ERROR, "HS Enable failed");
 		}
 		break;
 
 	case BT_EVENT_MODULE_CFG_REQ:
 		if (priv->btmrvl_dev.sendcmdflag &&
 				event->data[1] == MODULE_BRINGUP_REQ) {
-			BT_DBG("EVENT:%s",
-				((event->data[2] == MODULE_BROUGHT_UP) ||
-				(event->data[2] == MODULE_ALREADY_UP)) ?
-				"Bring-up succeed" : "Bring-up failed");
+			btmrvl_dbg(adapter, EVENT, "EVENT:%s",
+				   ((event->data[2] == MODULE_BROUGHT_UP) ||
+				   (event->data[2] == MODULE_ALREADY_UP)) ?
+				   "Bring-up succeed" : "Bring-up failed");
 
 			if (event->length > 3 && event->data[3])
 				priv->btmrvl_dev.dev_type = HCI_AMP;
 			else
 				priv->btmrvl_dev.dev_type = HCI_BREDR;
 
-			BT_DBG("dev_type: %d", priv->btmrvl_dev.dev_type);
+			btmrvl_dbg(adapter, EVENT, "dev_type: %d",
+				   priv->btmrvl_dev.dev_type);
 		} else if (priv->btmrvl_dev.sendcmdflag &&
 				event->data[1] == MODULE_SHUTDOWN_REQ) {
-			BT_DBG("EVENT:%s", (event->data[2]) ?
-				"Shutdown failed" : "Shutdown succeed");
+			btmrvl_dbg(adapter, EVENT, "EVENT:%s",
+				   (event->data[2]) ?
+				   "Shutdown failed" : "Shutdown succeed");
 		} else {
-			BT_DBG("BT_CMD_MODULE_CFG_REQ resp for APP");
+			btmrvl_dbg(adapter, ERROR,
+				   "BT_CMD_MODULE_CFG_REQ resp for APP");
 			ret = -EINVAL;
 		}
 		break;
@@ -171,12 +177,12 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 	case BT_EVENT_POWER_STATE:
 		if (event->data[1] == BT_PS_SLEEP)
 			adapter->ps_state = PS_SLEEP;
-		BT_DBG("EVENT:%s",
-			(adapter->ps_state) ? "PS_SLEEP" : "PS_AWAKE");
+		btmrvl_dbg(adapter, EVENT, "EVENT:%s",
+			   (adapter->ps_state) ? "PS_SLEEP" : "PS_AWAKE");
 		break;
 
 	default:
-		BT_DBG("Unknown Event=%d", event->data[0]);
+		btmrvl_dbg(adapter, ERROR, "Unknown Event=%d", event->data[0]);
 		ret = -EINVAL;
 		break;
 	}
@@ -196,13 +202,13 @@ static int btmrvl_send_sync_cmd(struct btmrvl_private *priv, u16 opcode,
 	struct hci_command_hdr *hdr;
 
 	if (priv->surprise_removed) {
-		BT_ERR("Card is removed");
+		btmrvl_dbg(priv->adapter, ERROR, "Card is removed");
 		return -EFAULT;
 	}
 
 	skb = bt_skb_alloc(HCI_COMMAND_HDR_SIZE + len, GFP_ATOMIC);
 	if (!skb) {
-		BT_ERR("No free skb");
+		btmrvl_dbg(priv->adapter, ERROR, "No free skb");
 		return -ENOMEM;
 	}
 
@@ -241,7 +247,8 @@ int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, u8 subcmd)
 
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_MODULE_CFG_REQ, &subcmd, 1);
 	if (ret)
-		BT_ERR("module_cfg_cmd(%x) failed", subcmd);
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "module_cfg_cmd(%x) failed", subcmd);
 
 	return ret;
 }
@@ -254,7 +261,8 @@ static int btmrvl_enable_sco_routing_to_host(struct btmrvl_private *priv)
 
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_ROUTE_SCO_TO_HOST, &subcmd, 1);
 	if (ret)
-		BT_ERR("BT_CMD_ROUTE_SCO_TO_HOST command failed: %#x", ret);
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "BT_CMD_ROUTE_SCO_TO_HOST command failed: %#x", ret);
 
 	return ret;
 }
@@ -270,7 +278,8 @@ int btmrvl_pscan_window_reporting(struct btmrvl_private *priv, u8 subcmd)
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_PSCAN_WIN_REPORT_ENABLE,
 				   &subcmd, 1);
 	if (ret)
-		BT_ERR("PSCAN_WIN_REPORT_ENABLE command failed: %#x", ret);
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "PSCAN_WIN_REPORT_ENABLE command failed: %#x", ret);
 
 	return ret;
 }
@@ -284,12 +293,13 @@ int btmrvl_send_hscfg_cmd(struct btmrvl_private *priv)
 	param[0] = (priv->btmrvl_dev.gpio_gap & 0xff00) >> 8;
 	param[1] = (u8) (priv->btmrvl_dev.gpio_gap & 0x00ff);
 
-	BT_DBG("Sending HSCFG Command, gpio=0x%x, gap=0x%x",
-	       param[0], param[1]);
+	btmrvl_dbg(priv->adapter, CMD,
+		   "Sending HSCFG Command, gpio=0x%x, gap=0x%x",
+		   param[0], param[1]);
 
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_HOST_SLEEP_CONFIG, param, 2);
 	if (ret)
-		BT_ERR("HSCFG command failed");
+		btmrvl_dbg(priv->adapter, ERROR, "HSCFG command failed");
 
 	return ret;
 }
@@ -307,7 +317,7 @@ int btmrvl_enable_ps(struct btmrvl_private *priv)
 
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_AUTO_SLEEP_MODE, &param, 1);
 	if (ret)
-		BT_ERR("PSMODE command failed");
+		btmrvl_dbg(priv->adapter, ERROR, "PSMODE command failed");
 
 	return 0;
 }
@@ -320,7 +330,8 @@ int btmrvl_enable_hs(struct btmrvl_private *priv)
 
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_HOST_SLEEP_ENABLE, NULL, 0);
 	if (ret) {
-		BT_ERR("Host sleep enable command failed");
+		btmrvl_dbg(adapter, ERROR,
+			   "Host sleep enable command failed");
 		return ret;
 	}
 
@@ -329,16 +340,19 @@ int btmrvl_enable_hs(struct btmrvl_private *priv)
 					       priv->surprise_removed,
 					       WAIT_UNTIL_HS_STATE_CHANGED);
 	if (ret < 0 || priv->surprise_removed) {
-		BT_ERR("event_hs_wait_q terminated (%d): %d,%d,%d",
-		       ret, adapter->hs_state, adapter->ps_state,
-		       adapter->wakeup_tries);
+		btmrvl_dbg(adapter, ERROR,
+			   "event_hs_wait_q terminated (%d): %d,%d,%d",
+			   ret, adapter->hs_state, adapter->ps_state,
+			   adapter->wakeup_tries);
 	} else if (!ret) {
-		BT_ERR("hs_enable timeout: %d,%d,%d", adapter->hs_state,
-		       adapter->ps_state, adapter->wakeup_tries);
+		btmrvl_dbg(adapter, ERROR, "hs_enable timeout: %d,%d,%d",
+			   adapter->hs_state, adapter->ps_state,
+			   adapter->wakeup_tries);
 		ret = -ETIMEDOUT;
 	} else {
-		BT_DBG("host sleep enabled: %d,%d,%d", adapter->hs_state,
-		       adapter->ps_state, adapter->wakeup_tries);
+		btmrvl_dbg(adapter, CMD, "host sleep enabled: %d,%d,%d",
+			   adapter->hs_state, adapter->ps_state,
+			   adapter->wakeup_tries);
 		ret = 0;
 	}
 
@@ -368,7 +382,8 @@ int btmrvl_prepare_command(struct btmrvl_private *priv)
 		} else {
 			ret = priv->hw_wakeup_firmware(priv);
 			priv->adapter->hs_state = HS_DEACTIVATED;
-			BT_DBG("BT: HS DEACTIVATED due to host activity!");
+			btmrvl_dbg(priv->adapter, CMD,
+				   "BT: HS DEACTIVATED due to host activity!");
 		}
 	}
 
@@ -389,8 +404,9 @@ static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
 		return -EINVAL;
 
 	if (!skb->len || ((skb->len + BTM_HEADER_LEN) > BTM_UPLD_SIZE)) {
-		BT_ERR("Tx Error: Bad skb length %d : %d",
-						skb->len, BTM_UPLD_SIZE);
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "Tx Error: Bad skb length %d : %d",
+			   skb->len, BTM_UPLD_SIZE);
 		return -EINVAL;
 	}
 
@@ -425,13 +441,14 @@ static void btmrvl_init_adapter(struct btmrvl_private *priv)
 	priv->adapter->hw_regs_buf = kzalloc(buf_size, GFP_KERNEL);
 	if (!priv->adapter->hw_regs_buf) {
 		priv->adapter->hw_regs = NULL;
-		BT_ERR("Unable to allocate buffer for hw_regs.");
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "Unable to allocate buffer for hw_regs.");
 	} else {
 		priv->adapter->hw_regs =
 			(u8 *)ALIGN_ADDR(priv->adapter->hw_regs_buf,
 					 BTSDIO_DMA_ALIGN);
-		BT_DBG("hw_regs_buf=%p hw_regs=%p",
-		       priv->adapter->hw_regs_buf, priv->adapter->hw_regs);
+		btmrvl_dbg(priv->adapter, MSG, "hw_regs_buf=%p hw_regs=%p",
+			   priv->adapter->hw_regs_buf, priv->adapter->hw_regs);
 	}
 
 	init_waitqueue_head(&priv->adapter->cmd_wait_q);
@@ -452,7 +469,8 @@ static int btmrvl_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btmrvl_private *priv = hci_get_drvdata(hdev);
 
-	BT_DBG("type=%d, len=%d", skb->pkt_type, skb->len);
+	btmrvl_dbg(priv->adapter, DATA, "type=%d, len=%d",
+		   skb->pkt_type, skb->len);
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
@@ -514,7 +532,8 @@ static int btmrvl_download_cal_data(struct btmrvl_private *priv,
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_LOAD_CONFIG_DATA, data,
 				   BT_CAL_HDR_LEN + len);
 	if (ret)
-		BT_ERR("Failed to download caibration data");
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "Failed to download caibration data");
 
 	return 0;
 }
@@ -537,11 +556,12 @@ static int btmrvl_check_device_tree(struct btmrvl_private *priv)
 		if (ret)
 			return ret;
 
-		BT_DBG("Use cal data from device tree");
+		btmrvl_dbg(priv->adapter, MSG, "Use cal data from device tree");
 		ret = btmrvl_download_cal_data(priv, cal_data,
 					       BT_CAL_DATA_SIZE);
 		if (ret) {
-			BT_ERR("Fail to download calibrate data");
+			btmrvl_dbg(priv->adapter, ERROR,
+				   "Fail to download calibrate data");
 			return ret;
 		}
 	}
@@ -576,6 +596,7 @@ static int btmrvl_setup(struct hci_dev *hdev)
 
 static int btmrvl_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
+	struct btmrvl_private *priv = hci_get_drvdata(hdev);
 	struct sk_buff *skb;
 	long ret;
 	u8 buf[8];
@@ -588,8 +609,9 @@ static int btmrvl_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
-		BT_ERR("%s: changing btmrvl device address failed (%ld)",
-		       hdev->name, ret);
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "%s: changing btmrvl device address failed (%ld)",
+			   hdev->name, ret);
 		return ret;
 	}
 	kfree_skb(skb);
@@ -617,7 +639,8 @@ static int btmrvl_service_main_thread(void *data)
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (kthread_should_stop() || priv->surprise_removed) {
-			BT_DBG("main_thread: break from main thread");
+			btmrvl_dbg(adapter, WARN,
+				   "main_thread: break from main thread");
 			break;
 		}
 
@@ -625,7 +648,8 @@ static int btmrvl_service_main_thread(void *data)
 				((!adapter->int_count) &&
 				(!priv->btmrvl_dev.tx_dnld_rdy ||
 				skb_queue_empty(&adapter->tx_queue)))) {
-			BT_DBG("main_thread is sleeping...");
+			btmrvl_dbg(adapter, WARN,
+				   "main_thread is sleeping...");
 			schedule();
 		}
 
@@ -633,10 +657,11 @@ static int btmrvl_service_main_thread(void *data)
 
 		remove_wait_queue(&thread->wait_q, &wait);
 
-		BT_DBG("main_thread woke up");
+		btmrvl_dbg(adapter, WARN, "main_thread woke up");
 
 		if (kthread_should_stop() || priv->surprise_removed) {
-			BT_DBG("main_thread: break from main thread");
+			btmrvl_dbg(adapter, WARN,
+				   "main_thread: break from main thread");
 			break;
 		}
 
@@ -682,7 +707,8 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
-		BT_ERR("Can not allocate HCI device");
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "Can not allocate HCI device");
 		goto err_hdev;
 	}
 
@@ -701,7 +727,8 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 
 	ret = hci_register_dev(hdev);
 	if (ret < 0) {
-		BT_ERR("Can not register HCI device");
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "Can not register HCI device");
 		goto err_hci_register_dev;
 	}
 
@@ -739,7 +766,7 @@ struct btmrvl_private *btmrvl_add_card(void *card)
 
 	btmrvl_init_adapter(priv);
 
-	BT_DBG("Starting kthread...");
+	btmrvl_dbg(priv->adapter, MSG, "Starting kthread...");
 	priv->main_thread.priv = priv;
 	spin_lock_init(&priv->driver_lock);
 
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index e039fc9..c2e10d6 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -302,7 +302,8 @@ static int btmrvl_sdio_enable_host_int_mask(struct btmrvl_sdio_card *card,
 
 	sdio_writeb(card->func, mask, card->reg->host_int_mask, &ret);
 	if (ret) {
-		BT_ERR("Unable to enable the host interrupt!");
+		btmrvl_dbg(NULL, ERROR,
+			   "Unable to enable the host interrupt!");
 		ret = -EIO;
 	}
 
@@ -323,7 +324,8 @@ static int btmrvl_sdio_disable_host_int_mask(struct btmrvl_sdio_card *card,
 
 	sdio_writeb(card->func, host_int_mask, card->reg->host_int_mask, &ret);
 	if (ret < 0) {
-		BT_ERR("Unable to disable the host interrupt!");
+		btmrvl_dbg(NULL, ERROR,
+			   "Unable to disable the host interrupt!");
 		return -EIO;
 	}
 
@@ -349,7 +351,7 @@ static int btmrvl_sdio_poll_card_status(struct btmrvl_sdio_card *card, u8 bits)
 	ret = -ETIMEDOUT;
 
 failed:
-	BT_ERR("FAILED! ret=%d", ret);
+	btmrvl_dbg(NULL, ERROR, "FAILED! ret=%d", ret);
 
 	return ret;
 }
@@ -390,8 +392,9 @@ static int btmrvl_sdio_download_helper(struct btmrvl_sdio_card *card)
 	ret = request_firmware(&fw_helper, card->helper,
 						&card->func->dev);
 	if ((ret < 0) || !fw_helper) {
-		BT_ERR("request_firmware(helper) failed, error code = %d",
-									ret);
+		btmrvl_dbg(NULL, ERROR,
+			   "request_firmware(helper) failed, error code = %d",
+			   ret);
 		ret = -ENOENT;
 		goto done;
 	}
@@ -399,15 +402,17 @@ static int btmrvl_sdio_download_helper(struct btmrvl_sdio_card *card)
 	helper = fw_helper->data;
 	helperlen = fw_helper->size;
 
-	BT_DBG("Downloading helper image (%d bytes), block size %d bytes",
-						helperlen, SDIO_BLOCK_SIZE);
+	btmrvl_dbg(NULL, MSG,
+		   "Downloading helper image (%d bytes), block size %d bytes",
+		   helperlen, SDIO_BLOCK_SIZE);
 
 	tmphlprbufsz = ALIGN_SZ(BTM_UPLD_SIZE, BTSDIO_DMA_ALIGN);
 
 	tmphlprbuf = kzalloc(tmphlprbufsz, GFP_KERNEL);
 	if (!tmphlprbuf) {
-		BT_ERR("Unable to allocate buffer for helper."
-			" Terminating download");
+		btmrvl_dbg(NULL, ERROR,
+			   "Unable to allocate buffer for helper.\t"
+			   "Terminating download");
 		ret = -ENOMEM;
 		goto done;
 	}
@@ -423,8 +428,9 @@ static int btmrvl_sdio_download_helper(struct btmrvl_sdio_card *card)
 		ret = btmrvl_sdio_poll_card_status(card,
 					    CARD_IO_READY | DN_LD_CARD_RDY);
 		if (ret < 0) {
-			BT_ERR("Helper download poll status timeout @ %d",
-				hlprblknow);
+			btmrvl_dbg(NULL, ERROR,
+				   "Helper download poll status timeout @ %d",
+				   hlprblknow);
 			goto done;
 		}
 
@@ -448,22 +454,24 @@ static int btmrvl_sdio_download_helper(struct btmrvl_sdio_card *card)
 		ret = sdio_writesb(card->func, card->ioport, helperbuf,
 				FIRMWARE_TRANSFER_NBLOCK * SDIO_BLOCK_SIZE);
 		if (ret < 0) {
-			BT_ERR("IO error during helper download @ %d",
-				hlprblknow);
+			btmrvl_dbg(NULL, ERROR,
+				   "IO error during helper download @ %d",
+				   hlprblknow);
 			goto done;
 		}
 
 		hlprblknow += tx_len;
 	} while (true);
 
-	BT_DBG("Transferring helper image EOF block");
+	btmrvl_dbg(NULL, MSG, "Transferring helper image EOF block");
 
 	memset(helperbuf, 0x0, SDIO_BLOCK_SIZE);
 
 	ret = sdio_writesb(card->func, card->ioport, helperbuf,
 							SDIO_BLOCK_SIZE);
 	if (ret < 0) {
-		BT_ERR("IO error in writing helper image EOF block");
+		btmrvl_dbg(NULL, ERROR,
+			   "IO error in writing helper image EOF block");
 		goto done;
 	}
 
@@ -490,8 +498,9 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 	ret = request_firmware(&fw_firmware, card->firmware,
 							&card->func->dev);
 	if ((ret < 0) || !fw_firmware) {
-		BT_ERR("request_firmware(firmware) failed, error code = %d",
-									ret);
+		btmrvl_dbg(NULL, ERROR,
+			   "request_firmware(firmware) failed, error code = %d",
+			   ret);
 		ret = -ENOENT;
 		goto done;
 	}
@@ -499,13 +508,14 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 	firmware = fw_firmware->data;
 	firmwarelen = fw_firmware->size;
 
-	BT_DBG("Downloading FW image (%d bytes)", firmwarelen);
+	btmrvl_dbg(NULL, MSG, "Downloading FW image (%d bytes)", firmwarelen);
 
 	tmpfwbufsz = ALIGN_SZ(BTM_UPLD_SIZE, BTSDIO_DMA_ALIGN);
 	tmpfwbuf = kzalloc(tmpfwbufsz, GFP_KERNEL);
 	if (!tmpfwbuf) {
-		BT_ERR("Unable to allocate buffer for firmware."
-		       " Terminating download");
+		btmrvl_dbg(NULL, ERROR,
+			   "Unable to allocate buffer for firmware.\t"
+			   "Terminating download");
 		ret = -ENOMEM;
 		goto done;
 	}
@@ -519,8 +529,9 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 		ret = btmrvl_sdio_poll_card_status(card,
 					CARD_IO_READY | DN_LD_CARD_RDY);
 		if (ret < 0) {
-			BT_ERR("FW download with helper poll status"
-						" timeout @ %d", offset);
+			btmrvl_dbg(NULL, ERROR,
+				   "FW download with helper poll status\t"
+				   "timeout @ %d", offset);
 			goto done;
 		}
 
@@ -532,20 +543,22 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 			base0 = sdio_readb(card->func,
 					card->reg->sq_read_base_addr_a0, &ret);
 			if (ret) {
-				BT_ERR("BASE0 register read failed:"
-					" base0 = 0x%04X(%d)."
-					" Terminating download",
-					base0, base0);
+				btmrvl_dbg(NULL, ERROR,
+					   "BASE0 register read failed:\t"
+					   "base0 = 0x%04X(%d).\t"
+					   "Terminating download",
+					   base0, base0);
 				ret = -EIO;
 				goto done;
 			}
 			base1 = sdio_readb(card->func,
 					card->reg->sq_read_base_addr_a1, &ret);
 			if (ret) {
-				BT_ERR("BASE1 register read failed:"
-					" base1 = 0x%04X(%d)."
-					" Terminating download",
-					base1, base1);
+				btmrvl_dbg(NULL, ERROR,
+					   "BASE1 register read failed:\t"
+					   "base1 = 0x%04X(%d).\t"
+					   "Terminating download",
+					   base1, base1);
 				ret = -EIO;
 				goto done;
 			}
@@ -560,8 +573,8 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 		if (!len)
 			break;
 		else if (len > BTM_UPLD_SIZE) {
-			BT_ERR("FW download failure @%d, invalid length %d",
-								offset, len);
+			btmrvl_dbg(NULL, ERROR, "FW download failure @%d,\t"
+				   "invalid length %d", offset, len);
 			ret = -EINVAL;
 			goto done;
 		}
@@ -571,13 +584,15 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 		if (len & BIT(0)) {
 			count++;
 			if (count > MAX_WRITE_IOMEM_RETRY) {
-				BT_ERR("FW download failure @%d, "
-					"over max retry count", offset);
+				btmrvl_dbg(NULL, ERROR,
+					   "FW download failure @%d,\t"
+					   "over max retry count", offset);
 				ret = -EIO;
 				goto done;
 			}
-			BT_ERR("FW CRC error indicated by the helper: "
-				"len = 0x%04X, txlen = %d", len, txlen);
+			btmrvl_dbg(NULL, ERROR,
+				   "FW CRC error indicated by the helper:\t"
+				   "len = 0x%04X, txlen = %d", len, txlen);
 			len &= ~BIT(0);
 			/* Set txlen to 0 so as to resend from same offset */
 			txlen = 0;
@@ -597,18 +612,19 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 						tx_blocks * blksz_dl);
 
 		if (ret < 0) {
-			BT_ERR("FW download, writesb(%d) failed @%d",
-							count, offset);
+			btmrvl_dbg(NULL, ERROR,
+				   "FW download, writesb(%d) failed @%d",
+				   count, offset);
 			sdio_writeb(card->func, HOST_CMD53_FIN,
 						card->reg->cfg, &ret);
 			if (ret)
-				BT_ERR("writeb failed (CFG)");
+				btmrvl_dbg(NULL, ERROR, "writeb failed (CFG)");
 		}
 
 		offset += txlen;
 	} while (true);
 
-	BT_INFO("FW download over, size %d bytes", offset);
+	btmrvl_dbg(NULL, MSG, "FW download over, size %d bytes", offset);
 
 	ret = 0;
 
@@ -629,7 +645,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
 
 	if (!card || !card->func) {
-		BT_ERR("card or function is NULL!");
+		btmrvl_dbg(NULL, ERROR, "card or function is NULL!");
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -637,7 +653,8 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	/* Read the length of data to be transferred */
 	ret = btmrvl_sdio_read_rx_len(card, &buf_len);
 	if (ret < 0) {
-		BT_ERR("read rx_len failed");
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "read rx_len failed");
 		ret = -EIO;
 		goto exit;
 	}
@@ -647,7 +664,8 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 
 	if (buf_len <= SDIO_HEADER_LEN
 	    || (num_blocks * blksz) > ALLOC_BUF_SIZE) {
-		BT_ERR("invalid packet length: %d", buf_len);
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "invalid packet length: %d", buf_len);
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -655,7 +673,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	/* Allocate buffer */
 	skb = bt_skb_alloc(num_blocks * blksz + BTSDIO_DMA_ALIGN, GFP_ATOMIC);
 	if (!skb) {
-		BT_ERR("No free skb");
+		btmrvl_dbg(priv->adapter, ERROR, "No free skb");
 		ret = -ENOMEM;
 		goto exit;
 	}
@@ -672,7 +690,8 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	ret = sdio_readsb(card->func, payload, card->ioport,
 			  num_blocks * blksz);
 	if (ret < 0) {
-		BT_ERR("readsb failed: %d", ret);
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "readsb failed: %d", ret);
 		ret = -EIO;
 		goto exit;
 	}
@@ -686,8 +705,9 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	buf_len |= payload[2] << 16;
 
 	if (buf_len > blksz * num_blocks) {
-		BT_ERR("Skip incorrect packet: hdrlen %d buffer %d",
-		       buf_len, blksz * num_blocks);
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "Skip incorrect packet: hdrlen %d buffer %d",
+			   buf_len, blksz * num_blocks);
 		ret = -EIO;
 		goto exit;
 	}
@@ -724,8 +744,10 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 		break;
 
 	default:
-		BT_ERR("Unknown packet type:%d", type);
-		BT_ERR("hex: %*ph", blksz * num_blocks, payload);
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "Unknown packet type:%d", type);
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "hex: %*ph", blksz * num_blocks, payload);
 
 		kfree_skb(skb);
 		skb = NULL;
@@ -755,8 +777,9 @@ static int btmrvl_sdio_process_int_status(struct btmrvl_private *priv)
 	sdio_claim_host(card->func);
 	if (ireg & DN_LD_HOST_INT_STATUS) {
 		if (priv->btmrvl_dev.tx_dnld_rdy)
-			BT_DBG("tx_done already received: "
-				" int_status=0x%x", ireg);
+			btmrvl_dbg(priv->adapter, INTR,
+				   "tx_done already received:\t"
+				   "int_status=0x%x", ireg);
 		else
 			priv->btmrvl_dev.tx_dnld_rdy = true;
 	}
@@ -776,23 +799,26 @@ static int btmrvl_sdio_read_to_clear(struct btmrvl_sdio_card *card, u8 *ireg)
 
 	ret = sdio_readsb(card->func, adapter->hw_regs, 0, SDIO_BLOCK_SIZE);
 	if (ret) {
-		BT_ERR("sdio_readsb: read int hw_regs failed: %d", ret);
+		btmrvl_dbg(adapter, ERROR,
+			   "sdio_readsb: read int hw_regs failed: %d", ret);
 		return ret;
 	}
 
 	*ireg = adapter->hw_regs[card->reg->host_intstatus];
-	BT_DBG("hw_regs[%#x]=%#x", card->reg->host_intstatus, *ireg);
+	btmrvl_dbg(adapter, INTR, "recv int status %#x", *ireg);
 
 	return 0;
 }
 
 static int btmrvl_sdio_write_to_clear(struct btmrvl_sdio_card *card, u8 *ireg)
 {
+	struct btmrvl_adapter *adapter = card->priv->adapter;
 	int ret;
 
 	*ireg = sdio_readb(card->func, card->reg->host_intstatus, &ret);
 	if (ret) {
-		BT_ERR("sdio_readb: read int status failed: %d", ret);
+		btmrvl_dbg(adapter, ERROR,
+			   "sdio_readb: read int status failed: %d", ret);
 		return ret;
 	}
 
@@ -802,13 +828,15 @@ static int btmrvl_sdio_write_to_clear(struct btmrvl_sdio_card *card, u8 *ireg)
 		 * Clear the interrupt status register and re-enable the
 		 * interrupt.
 		 */
-		BT_DBG("int_status = 0x%x", *ireg);
+		btmrvl_dbg(adapter, INTR, "recv int status 0x%x", *ireg);
 
 		sdio_writeb(card->func, ~(*ireg) & (DN_LD_HOST_INT_STATUS |
 						    UP_LD_HOST_INT_STATUS),
 			    card->reg->host_intstatus, &ret);
 		if (ret) {
-			BT_ERR("sdio_writeb: clear int status failed: %d", ret);
+			btmrvl_dbg(adapter, ERROR,
+				   "sdio_writeb: clear int status failed: %d",
+				   ret);
 			return ret;
 		}
 	}
@@ -826,8 +854,9 @@ static void btmrvl_sdio_interrupt(struct sdio_func *func)
 
 	card = sdio_get_drvdata(func);
 	if (!card || !card->priv) {
-		BT_ERR("sbi_interrupt(%p) card or priv is NULL, card=%p",
-		       func, card);
+		btmrvl_dbg(NULL, ERROR,
+			   "sbi_interrupt(%p) card or priv is NULL, card=%p",
+			   func, card);
 		return;
 	}
 
@@ -858,7 +887,8 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 	int ret = 0;
 
 	if (!card || !card->func) {
-		BT_ERR("Error: card or function is NULL!");
+		btmrvl_dbg(NULL, ERROR,
+			   "Error: card or function is NULL!");
 		ret = -EINVAL;
 		goto failed;
 	}
@@ -869,21 +899,24 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 
 	ret = sdio_enable_func(func);
 	if (ret) {
-		BT_ERR("sdio_enable_func() failed: ret=%d", ret);
+		btmrvl_dbg(NULL, ERROR,
+			   "sdio_enable_func() failed: ret=%d", ret);
 		ret = -EIO;
 		goto release_host;
 	}
 
 	ret = sdio_claim_irq(func, btmrvl_sdio_interrupt);
 	if (ret) {
-		BT_ERR("sdio_claim_irq failed: ret=%d", ret);
+		btmrvl_dbg(NULL, ERROR,
+			   "sdio_claim_irq failed: ret=%d", ret);
 		ret = -EIO;
 		goto disable_func;
 	}
 
 	ret = sdio_set_block_size(card->func, SDIO_BLOCK_SIZE);
 	if (ret) {
-		BT_ERR("cannot set SDIO block size");
+		btmrvl_dbg(NULL, ERROR,
+			   "cannot set SDIO block size");
 		ret = -EIO;
 		goto release_irq;
 	}
@@ -912,7 +945,8 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 
 	card->ioport |= (reg << 16);
 
-	BT_DBG("SDIO FUNC%d IO port: 0x%x", func->num, card->ioport);
+	btmrvl_dbg(NULL, INFO,
+		   "SDIO FUNC%d IO port: 0x%x", func->num, card->ioport);
 
 	if (card->reg->int_read_to_clear) {
 		reg = sdio_readb(func, card->reg->host_int_rsr, &ret);
@@ -1017,7 +1051,7 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_private *priv,
 	int tmpbufsz;
 
 	if (!card || !card->func) {
-		BT_ERR("card or function is NULL!");
+		btmrvl_dbg(NULL, ERROR, "card or function is NULL!");
 		return -EINVAL;
 	}
 
@@ -1042,8 +1076,10 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_private *priv,
 				   buf_block_len * blksz);
 		if (ret < 0) {
 			i++;
-			BT_ERR("i=%d writesb failed: %d", i, ret);
-			BT_ERR("hex: %*ph", nb, payload);
+			btmrvl_dbg(priv->adapter, ERROR,
+				   "i=%d writesb failed: %d", i, ret);
+			btmrvl_dbg(priv->adapter, ERROR,
+				   "hex: %*ph", nb, payload);
 			ret = -EIO;
 			if (i > MAX_WRITE_IOMEM_RETRY)
 				goto exit;
@@ -1066,12 +1102,12 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
 	int pollnum = MAX_POLL_TRIES;
 
 	if (!card || !card->func) {
-		BT_ERR("card or function is NULL!");
+		btmrvl_dbg(NULL, ERROR, "card or function is NULL!");
 		return -EINVAL;
 	}
 
 	if (!btmrvl_sdio_verify_fw_download(card, 1)) {
-		BT_DBG("Firmware already downloaded!");
+		btmrvl_dbg(NULL, ERROR, "Firmware already downloaded!");
 		return 0;
 	}
 
@@ -1080,12 +1116,15 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
 	/* Check if other function driver is downloading the firmware */
 	fws0 = sdio_readb(card->func, card->reg->card_fw_status0, &ret);
 	if (ret) {
-		BT_ERR("Failed to read FW downloading status!");
+		btmrvl_dbg(NULL, ERROR,
+			   "Failed to read FW downloading status!");
 		ret = -EIO;
 		goto done;
 	}
 	if (fws0) {
-		BT_DBG("BT not the winner (%#x). Skip FW downloading", fws0);
+		btmrvl_dbg(NULL, ERROR,
+			   "BT not the winner (%#x). Skip FW downloading",
+			   fws0);
 
 		/* Give other function more time to download the firmware */
 		pollnum *= 10;
@@ -1093,14 +1132,16 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
 		if (card->helper) {
 			ret = btmrvl_sdio_download_helper(card);
 			if (ret) {
-				BT_ERR("Failed to download helper!");
+				btmrvl_dbg(NULL, ERROR,
+					   "Failed to download helper!");
 				ret = -EIO;
 				goto done;
 			}
 		}
 
 		if (btmrvl_sdio_download_fw_w_helper(card)) {
-			BT_ERR("Failed to download firmware!");
+			btmrvl_dbg(NULL, ERROR,
+				   "Failed to download firmware!");
 			ret = -EIO;
 			goto done;
 		}
@@ -1111,7 +1152,7 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
 	 * module can continue its initialization
 	 */
 	if (btmrvl_sdio_verify_fw_download(card, pollnum)) {
-		BT_ERR("FW failed to be active in time!");
+		btmrvl_dbg(NULL, ERROR, "FW failed to be active in time!");
 		return -ETIMEDOUT;
 	}
 
@@ -1130,7 +1171,7 @@ static int btmrvl_sdio_wakeup_fw(struct btmrvl_private *priv)
 	int ret = 0;
 
 	if (!card || !card->func) {
-		BT_ERR("card or function is NULL!");
+		btmrvl_dbg(NULL, ERROR, "card or function is NULL!");
 		return -EINVAL;
 	}
 
@@ -1140,7 +1181,7 @@ static int btmrvl_sdio_wakeup_fw(struct btmrvl_private *priv)
 
 	sdio_release_host(card->func);
 
-	BT_DBG("wake up firmware");
+	btmrvl_dbg(priv->adapter, INFO, "wake up firmware");
 
 	return ret;
 }
@@ -1188,7 +1229,7 @@ static void btmrvl_sdio_dump_regs(struct btmrvl_private *priv)
 			}
 		}
 
-		BT_INFO("%s", buf);
+		btmrvl_dbg(priv->adapter, INFO, "%s", buf);
 	}
 
 	sdio_release_host(card->func);
@@ -1207,7 +1248,7 @@ rdwr_status btmrvl_sdio_rdwr_firmware(struct btmrvl_private *priv,
 		    &ret);
 
 	if (ret) {
-		BT_ERR("SDIO write err");
+		btmrvl_dbg(priv->adapter, ERROR, "SDIO write err");
 		return RDWR_STATUS_FAILURE;
 	}
 
@@ -1216,7 +1257,7 @@ rdwr_status btmrvl_sdio_rdwr_firmware(struct btmrvl_private *priv,
 				       &ret);
 
 		if (ret) {
-			BT_ERR("SDIO read err");
+			btmrvl_dbg(priv->adapter, ERROR, "SDIO read err");
 			return RDWR_STATUS_FAILURE;
 		}
 
@@ -1225,11 +1266,13 @@ rdwr_status btmrvl_sdio_rdwr_firmware(struct btmrvl_private *priv,
 		if (doneflag && ctrl_data == doneflag)
 			return RDWR_STATUS_DONE;
 		if (ctrl_data != FW_DUMP_HOST_READY) {
-			BT_INFO("The ctrl reg was changed, re-try again!");
+			btmrvl_dbg(priv->adapter, INFO,
+				   "The ctrl reg was changed, re-try again!");
 			sdio_writeb(card->func, FW_DUMP_HOST_READY,
 				    card->reg->fw_dump_ctrl, &ret);
 			if (ret) {
-				BT_ERR("SDIO write err");
+				btmrvl_dbg(priv->adapter, ERROR,
+					   "SDIO write err");
 				return RDWR_STATUS_FAILURE;
 			}
 		}
@@ -1237,7 +1280,7 @@ rdwr_status btmrvl_sdio_rdwr_firmware(struct btmrvl_private *priv,
 	}
 
 	if (ctrl_data == FW_DUMP_HOST_READY) {
-		BT_ERR("Fail to pull ctrl_data");
+		btmrvl_dbg(priv->adapter, ERROR, "Fail to pull ctrl_data");
 		return RDWR_STATUS_FAILURE;
 	}
 
@@ -1259,7 +1302,8 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 	btmrvl_sdio_dump_regs(priv);
 
 	if (!card->supports_fw_dump) {
-		BT_ERR("Firmware dump not supported for this card!");
+		btmrvl_dbg(priv->adapter, ERROR,
+			   "Firmware dump not supported for this card!");
 		return;
 	}
 
@@ -1276,7 +1320,7 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 	btmrvl_sdio_wakeup_fw(priv);
 	sdio_claim_host(card->func);
 
-	BT_INFO("== btmrvl firmware dump start ==");
+	btmrvl_dbg(priv->adapter, MSG, "== btmrvl firmware dump start ==");
 
 	stat = btmrvl_sdio_rdwr_firmware(priv, doneflag);
 	if (stat == RDWR_STATUS_FAILURE)
@@ -1287,7 +1331,7 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 	dump_num = sdio_readb(card->func, reg, &ret);
 
 	if (ret) {
-		BT_ERR("SDIO read memory length err");
+		btmrvl_dbg(priv->adapter, ERROR, "SDIO read memory length err");
 		goto done;
 	}
 
@@ -1304,7 +1348,8 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 		for (i = 0; i < 4; i++) {
 			read_reg = sdio_readb(card->func, reg, &ret);
 			if (ret) {
-				BT_ERR("SDIO read err");
+				btmrvl_dbg(priv->adapter, ERROR,
+					   "SDIO read err");
 				goto done;
 			}
 			memory_size |= (read_reg << i*8);
@@ -1312,21 +1357,25 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 		}
 
 		if (memory_size == 0) {
-			BT_INFO("Firmware dump finished!");
+			btmrvl_dbg(priv->adapter, MSG,
+				   "Firmware dump finished!");
 			sdio_writeb(card->func, FW_DUMP_READ_DONE,
 				    card->reg->fw_dump_ctrl, &ret);
 			if (ret) {
-				BT_ERR("SDIO Write MEMDUMP_FINISH ERR");
+				btmrvl_dbg(priv->adapter, ERROR,
+					   "SDIO write dump finished err");
 				goto done;
 			}
 			break;
 		}
 
-		BT_INFO("%s_SIZE=0x%x", entry->mem_name, memory_size);
+		btmrvl_dbg(priv->adapter, MSG,
+			   "%s_SIZE=0x%x", entry->mem_name, memory_size);
 		entry->mem_ptr = vzalloc(memory_size + 1);
 		entry->mem_size = memory_size;
 		if (!entry->mem_ptr) {
-			BT_ERR("Vzalloc %s failed", entry->mem_name);
+			btmrvl_dbg(priv->adapter, ERROR,
+				   "Vzalloc %s failed", entry->mem_name);
 			goto done;
 		}
 
@@ -1340,8 +1389,9 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 		end_ptr = dbg_ptr + memory_size;
 
 		doneflag = entry->done_flag;
-		BT_INFO("Start %s output, please wait...",
-			entry->mem_name);
+		btmrvl_dbg(priv->adapter, MSG,
+			   "Start %s output, please wait...",
+			   entry->mem_name);
 
 		do {
 			stat = btmrvl_sdio_rdwr_firmware(priv, doneflag);
@@ -1353,27 +1403,30 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 			for (reg = reg_start; reg <= reg_end; reg++) {
 				*dbg_ptr = sdio_readb(card->func, reg, &ret);
 				if (ret) {
-					BT_ERR("SDIO read err");
+					btmrvl_dbg(priv->adapter, ERROR,
+						   "SDIO read err");
 					goto done;
 				}
 				if (dbg_ptr < end_ptr)
 					dbg_ptr++;
 				else
-					BT_ERR("Allocated buffer not enough");
+					btmrvl_dbg(priv->adapter, ERROR,
+						   "Allocated buffer not enough");
 			}
 
 			if (stat != RDWR_STATUS_DONE) {
 				continue;
 			} else {
-				BT_INFO("%s done: size=0x%tx",
-					entry->mem_name,
-					dbg_ptr - entry->mem_ptr);
+				btmrvl_dbg(priv->adapter, MSG,
+					   "%s done: size=0x%tx",
+					   entry->mem_name,
+					   dbg_ptr - entry->mem_ptr);
 				break;
 			}
 		} while (1);
 	}
 
-	BT_INFO("== btmrvl firmware dump end ==");
+	btmrvl_dbg(priv->adapter, MSG, "== btmrvl firmware dump end ==");
 
 done:
 	sdio_release_host(card->func);
@@ -1389,7 +1442,9 @@ done:
 
 	/* Dump all the memory data into single file, a userspace script will
 	   be used to split all the memory data to multiple files*/
-	BT_INFO("== btmrvl firmware dump to /sys/class/devcoredump start");
+	btmrvl_dbg(priv->adapter, MSG,
+		   "== btmrvl firmware dump to /sys/class/devcoredump start");
+
 	for (idx = 0; idx < dump_num; idx++) {
 		struct memory_type_mapping *entry = &mem_type_mapping_tbl[idx];
 
@@ -1417,7 +1472,8 @@ done:
 	/* fw_dump_data will be free in device coredump release function
 	   after 5 min*/
 	dev_coredumpv(&card->func->dev, fw_dump_data, fw_dump_len, GFP_KERNEL);
-	BT_INFO("== btmrvl firmware dump to /sys/class/devcoredump end");
+	btmrvl_dbg(priv->adapter, MSG,
+		   "== btmrvl firmware dump to /sys/class/devcoredump end");
 }
 
 static int btmrvl_sdio_probe(struct sdio_func *func,
@@ -1427,8 +1483,8 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	struct btmrvl_private *priv = NULL;
 	struct btmrvl_sdio_card *card = NULL;
 
-	BT_INFO("vendor=0x%x, device=0x%x, class=%d, fn=%d",
-			id->vendor, id->device, id->class, func->num);
+	btmrvl_dbg(NULL, MSG, "vendor=0x%x, device=0x%x, class=%d, fn=%d",
+		   id->vendor, id->device, id->class, func->num);
 
 	card = devm_kzalloc(&func->dev, sizeof(*card), GFP_KERNEL);
 	if (!card)
@@ -1447,7 +1503,7 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	}
 
 	if (btmrvl_sdio_register_dev(card) < 0) {
-		BT_ERR("Failed to register BT device!");
+		btmrvl_dbg(NULL, ERROR, "Failed to register BT device!");
 		return -ENODEV;
 	}
 
@@ -1455,7 +1511,7 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	btmrvl_sdio_disable_host_int(card);
 
 	if (btmrvl_sdio_download_fw(card)) {
-		BT_ERR("Downloading firmware failed!");
+		btmrvl_dbg(NULL, ERROR, "Downloading firmware failed!");
 		ret = -ENODEV;
 		goto unreg_dev;
 	}
@@ -1464,7 +1520,7 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 
 	priv = btmrvl_add_card(card);
 	if (!priv) {
-		BT_ERR("Initializing card failed!");
+		btmrvl_dbg(NULL, ERROR, "Initializing card failed!");
 		ret = -ENODEV;
 		goto disable_host_int;
 	}
@@ -1478,7 +1534,7 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	priv->firmware_dump = btmrvl_sdio_dump_firmware;
 
 	if (btmrvl_register_hdev(priv)) {
-		BT_ERR("Register hdev failed!");
+		btmrvl_dbg(priv->adapter, ERROR, "Register hdev failed!");
 		ret = -ENODEV;
 		goto disable_host_int;
 	}
@@ -1507,7 +1563,7 @@ static void btmrvl_sdio_remove(struct sdio_func *func)
 							MODULE_SHUTDOWN_REQ);
 				btmrvl_sdio_disable_host_int(card);
 			}
-			BT_DBG("unregester dev");
+			btmrvl_dbg(card->priv->adapter, MSG, "unregester dev");
 			card->priv->surprise_removed = true;
 			btmrvl_sdio_unregister_dev(card);
 			btmrvl_remove_card(card->priv);
@@ -1525,32 +1581,35 @@ static int btmrvl_sdio_suspend(struct device *dev)
 
 	if (func) {
 		pm_flags = sdio_get_host_pm_caps(func);
-		BT_DBG("%s: suspend: PM flags = 0x%x", sdio_func_id(func),
-		       pm_flags);
+		btmrvl_dbg(NULL, MSG, "%s: suspend: PM flags = 0x%x",
+			   sdio_func_id(func), pm_flags);
 		if (!(pm_flags & MMC_PM_KEEP_POWER)) {
-			BT_ERR("%s: cannot remain alive while suspended",
-			       sdio_func_id(func));
+			btmrvl_dbg(NULL, ERROR,
+				   "%s: cannot remain alive while suspended",
+				   sdio_func_id(func));
 			return -ENOSYS;
 		}
 		card = sdio_get_drvdata(func);
 		if (!card || !card->priv) {
-			BT_ERR("card or priv structure is not valid");
+			btmrvl_dbg(NULL, ERROR,
+				   "card or priv structure is not valid");
 			return 0;
 		}
 	} else {
-		BT_ERR("sdio_func is not specified");
+		btmrvl_dbg(NULL, ERROR, "sdio_func is not specified");
 		return 0;
 	}
 
 	priv = card->priv;
 	hcidev = priv->btmrvl_dev.hcidev;
-	BT_DBG("%s: SDIO suspend", hcidev->name);
+	btmrvl_dbg(priv->adapter, MSG, "%s: SDIO suspend", hcidev->name);
 	hci_suspend_dev(hcidev);
 	skb_queue_purge(&priv->adapter->tx_queue);
 
 	if (priv->adapter->hs_state != HS_ACTIVATED) {
 		if (btmrvl_enable_hs(priv)) {
-			BT_ERR("HS not actived, suspend failed!");
+			btmrvl_dbg(priv->adapter, ERROR,
+				   "HS not actived, suspend failed!");
 			return -EBUSY;
 		}
 	}
@@ -1559,10 +1618,12 @@ static int btmrvl_sdio_suspend(struct device *dev)
 
 	/* We will keep the power when hs enabled successfully */
 	if (priv->adapter->hs_state == HS_ACTIVATED) {
-		BT_DBG("suspend with MMC_PM_KEEP_POWER");
+		btmrvl_dbg(priv->adapter, MSG,
+			   "suspend with MMC_PM_KEEP_POWER");
 		return sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
 	} else {
-		BT_DBG("suspend without MMC_PM_KEEP_POWER");
+		btmrvl_dbg(priv->adapter, MSG,
+			   "suspend without MMC_PM_KEEP_POWER");
 		return 0;
 	}
 }
@@ -1577,30 +1638,32 @@ static int btmrvl_sdio_resume(struct device *dev)
 
 	if (func) {
 		pm_flags = sdio_get_host_pm_caps(func);
-		BT_DBG("%s: resume: PM flags = 0x%x", sdio_func_id(func),
-		       pm_flags);
+		btmrvl_dbg(NULL, MSG, "%s: resume: PM flags = 0x%x",
+			   sdio_func_id(func), pm_flags);
 		card = sdio_get_drvdata(func);
 		if (!card || !card->priv) {
-			BT_ERR("card or priv structure is not valid");
+			btmrvl_dbg(NULL, ERROR,
+				   "card or priv structure is not valid");
 			return 0;
 		}
 	} else {
-		BT_ERR("sdio_func is not specified");
+		btmrvl_dbg(NULL, ERROR, "sdio_func is not specified");
 		return 0;
 	}
 	priv = card->priv;
 
 	if (!priv->adapter->is_suspended) {
-		BT_DBG("device already resumed");
+		btmrvl_dbg(priv->adapter, MSG, "device already resumed");
 		return 0;
 	}
 
 	priv->hw_wakeup_firmware(priv);
 	priv->adapter->hs_state = HS_DEACTIVATED;
 	hcidev = priv->btmrvl_dev.hcidev;
-	BT_DBG("%s: HS DEACTIVATED in resume!", hcidev->name);
+	btmrvl_dbg(priv->adapter, MSG,
+		   "%s: HS DEACTIVATED in resume!", hcidev->name);
 	priv->adapter->is_suspended = false;
-	BT_DBG("%s: SDIO resume", hcidev->name);
+	btmrvl_dbg(priv->adapter, MSG, "%s: SDIO resume", hcidev->name);
 	hci_resume_dev(hcidev);
 
 	return 0;
@@ -1625,7 +1688,7 @@ static struct sdio_driver bt_mrvl_sdio = {
 static int __init btmrvl_sdio_init_module(void)
 {
 	if (sdio_register_driver(&bt_mrvl_sdio) != 0) {
-		BT_ERR("SDIO Driver Registration Failed");
+		btmrvl_dbg(NULL, ERROR, "SDIO Driver Registration Failed");
 		return -ENODEV;
 	}
 
-- 
1.8.1.4

