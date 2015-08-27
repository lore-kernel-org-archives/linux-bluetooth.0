Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Add MODULE_FIRMWARE entries for iBT 3.0 controllers
Date: Thu, 27 Aug 2015 08:57:39 +0200
Message-Id: <1440658659-101531-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The iBT 3.0 controllers need intel/ibt-11-5.sfi and intel/ibt-11-5.ddc
firmware files from linux-firmware repository.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 1ce4ac16c7fa..048423fd83bf 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -173,3 +173,5 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE("intel/ibt-11-5.sfi");
+MODULE_FIRMWARE("intel/ibt-11-5.ddc");
-- 
2.4.3

