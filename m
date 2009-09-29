Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>, Rahul Tank <rahult@marvell.com>
Subject: [PATCH] Bluetooth: Removal of unused variable in btmrvl driver
Date: Mon, 28 Sep 2009 19:43:35 -0700
Message-Id: <1254192215-2501-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rahul Tank <rahult@marvell.com>

This patch removes unused variable "drvdbg" from btmrvl_debugfs_data
structure.

Signed-off-by: Rahul Tank <rahult@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btmrvl_debugfs.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index 4617bd1..d43b5cb 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -29,7 +29,6 @@ struct btmrvl_debugfs_data {
 	struct dentry *root_dir, *config_dir, *status_dir;
 
 	/* config */
-	struct dentry *drvdbg;
 	struct dentry *psmode;
 	struct dentry *pscmd;
 	struct dentry *hsmode;
-- 
1.5.4.3

