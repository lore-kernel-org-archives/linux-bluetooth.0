Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Cathy Luo <cluo@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 1/4] Bluetooth: btmrvl: remove memory allocation failure message
Date: Wed, 14 Oct 2015 08:34:40 -0700
Message-ID: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These changes resolve below checkpatch warning

WARNING: Possible unnecessary 'out of memory' message

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_main.c | 8 ++------
 drivers/bluetooth/btmrvl_sdio.c | 5 ++---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 6ba2286..61d2f39 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -712,16 +712,12 @@ struct btmrvl_private *btmrvl_add_card(void *card)
 	struct btmrvl_private *priv;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		BT_ERR("Can not allocate priv");
+	if (!priv)
 		goto err_priv;
-	}
 
 	priv->adapter = kzalloc(sizeof(*priv->adapter), GFP_KERNEL);
-	if (!priv->adapter) {
-		BT_ERR("Allocate buffer for btmrvl_adapter failed!");
+	if (!priv->adapter)
 		goto err_adapter;
-	}
 
 	btmrvl_init_adapter(priv);
 
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 71ea2a3..e039fc9 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1382,10 +1382,9 @@ done:
 		return;
 
 	fw_dump_data = vzalloc(fw_dump_len+1);
-	if (!fw_dump_data) {
-		BT_ERR("Vzalloc fw_dump_data fail!");
+	if (!fw_dump_data)
 		return;
-	}
+
 	fw_dump_ptr = fw_dump_data;
 
 	/* Dump all the memory data into single file, a userspace script will
-- 
1.8.1.4

