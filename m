Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Cathy Luo <cluo@marvell.com>, Zhaoyang Liu <liuzy@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 2/4] Bluetooth: btmrvl: add prints debug control support
Date: Wed, 14 Oct 2015 08:34:41 -0700
Message-ID: <1444836883-14701-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
References: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Zhaoyang Liu <liuzy@marvell.com>

This patch adds support for debugging print control in marvell
bluetooth driver. The debug level can be controlled by setting
module loading parameter debug_mask.

Example:
insmod btmrvl.ko debug_mask=0x37

Signed-off-by: Zhaoyang Liu <liuzy@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  | 35 ++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmrvl_main.c | 18 ++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 27a9aac..1119d09 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -79,6 +79,7 @@ struct btmrvl_device {
 struct btmrvl_adapter {
 	void *hw_regs_buf;
 	u8 *hw_regs;
+	unsigned int debug_mask;
 	u32 int_count;
 	struct sk_buff_head tx_queue;
 	u8 psmode;
@@ -155,8 +156,40 @@ struct btmrvl_event {
 	u8 data[4];
 } __packed;
 
-/* Prototype of global function */
+/* marvell bluetooth driver debug level */
+enum BTMRVL_DEBUG_LEVEL {
+	BTMRVL_DBG_MSG		= 0x00000001,
+	BTMRVL_DBG_FATAL	= 0x00000002,
+	BTMRVL_DBG_ERROR	= 0x00000004,
+	BTMRVL_DBG_DATA		= 0x00000008,
+	BTMRVL_DBG_CMD		= 0x00000010,
+	BTMRVL_DBG_EVENT	= 0x00000020,
+	BTMRVL_DBG_INTR		= 0x00000040,
+
+	BTMRVL_DBG_DAT_D	= 0x00010000,
+	BTMRVL_DBG_CMD_D	= 0x00020000,
+
+	BTMRVL_DBG_ENTRY	= 0x10000000,
+	BTMRVL_DBG_WARN		= 0x20000000,
+	BTMRVL_DBG_INFO		= 0x40000000,
+
+	BTMRVL_DBG_ANY		= 0xffffffff
+};
 
+#define BTMRVL_DBG_DEFAULT_MASK		(BTMRVL_DBG_MSG | \
+					 BTMRVL_DBG_FATAL | \
+					 BTMRVL_DBG_ERROR)
+
+int btmrvl_log_allowed(struct btmrvl_adapter *adapter,
+		       enum BTMRVL_DEBUG_LEVEL level);
+
+#define btmrvl_dbg(adapter, dbg_mask, fmt, args...)		\
+do {								\
+	if (btmrvl_log_allowed(adapter, BTMRVL_DBG_##dbg_mask))	\
+		pr_info("btmrvl: " fmt "\n", ##args);		\
+} while (0)
+
+/* Prototype of global function */
 int btmrvl_register_hdev(struct btmrvl_private *priv);
 struct btmrvl_private *btmrvl_add_card(void *card);
 int btmrvl_remove_card(struct btmrvl_private *priv);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 61d2f39..8e53609 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -29,6 +29,23 @@
 
 #define VERSION "1.0"
 
+static unsigned int debug_mask = BTMRVL_DBG_DEFAULT_MASK;
+module_param(debug_mask, uint, 0);
+MODULE_PARM_DESC(debug_mask, "bitmap for debug flags");
+
+int btmrvl_log_allowed(struct btmrvl_adapter *adapter,
+		       enum BTMRVL_DEBUG_LEVEL level)
+{
+	if (!adapter && (BTMRVL_DBG_DEFAULT_MASK & level))
+		return true;
+
+	if (adapter->debug_mask & level)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(btmrvl_log_allowed);
+
 /*
  * This function is called by interface specific interrupt handler.
  * It updates Power Save & Host Sleep states, and wakes up the main
@@ -402,6 +419,7 @@ static void btmrvl_init_adapter(struct btmrvl_private *priv)
 	skb_queue_head_init(&priv->adapter->tx_queue);
 
 	priv->adapter->ps_state = PS_AWAKE;
+	priv->adapter->debug_mask = debug_mask;
 
 	buf_size = ALIGN_SZ(SDIO_BLOCK_SIZE, BTSDIO_DMA_ALIGN);
 	priv->adapter->hw_regs_buf = kzalloc(buf_size, GFP_KERNEL);
-- 
1.8.1.4

