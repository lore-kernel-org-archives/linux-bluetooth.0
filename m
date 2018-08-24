Return-Path: <dingxiang@cmss.chinamobile.com>
From: Ding Xiang <dingxiang@cmss.chinamobile.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: bt3c_cs: Fix obsolete function
Date: Fri, 24 Aug 2018 06:23:32 -0400
Message-Id: <1535106212-21514-1-git-send-email-dingxiang@cmss.chinamobile.com>
List-ID: <linux-bluetooth.vger.kernel.org>

simple_strtol and simple_strtoul are obsolete, both place
use kstrtoul instead.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/bluetooth/bt3c_cs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 25b0cf9..5e4800d 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -449,7 +449,7 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 	char *ptr = (char *) firmware;
 	char b[9];
 	unsigned int iobase, tmp;
-	unsigned long size, addr, fcs;
+	unsigned long size, addr, fcs, tn;
 	int i, err = 0;
 
 	iobase = info->p_dev->resource[0]->start;
@@ -490,7 +490,9 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 		memset(b, 0, sizeof(b));
 		for (tmp = 0, i = 0; i < size; i++) {
 			memcpy(b, ptr + (i * 2) + 2, 2);
-			tmp += simple_strtol(b, NULL, 16);
+			if (kstrtoul(b, 16, &tn))
+				return -EINVAL;
+			tmp += tn;
 		}
 
 		if (((tmp + fcs) & 0xff) != 0xff) {
@@ -505,7 +507,9 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 			memset(b, 0, sizeof(b));
 			for (i = 0; i < (size - 4) / 2; i++) {
 				memcpy(b, ptr + (i * 4) + 12, 4);
-				tmp = simple_strtoul(b, NULL, 16);
+				if (kstrtoul(b, 16, &tn))
+					return -EINVAL;
+				tmp += tn;
 				bt3c_put(iobase, tmp);
 			}
 		}
-- 
1.8.3.1
