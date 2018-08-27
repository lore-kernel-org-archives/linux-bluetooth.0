Return-Path: <dingxiang@cmss.chinamobile.com>
From: Ding Xiang <dingxiang@cmss.chinamobile.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3] Bluetooth: bt3c_cs: Fix obsolete function
Date: Sun, 26 Aug 2018 22:55:00 -0400
Message-Id: <1535338500-7682-1-git-send-email-dingxiang@cmss.chinamobile.com>
List-ID: <linux-bluetooth.vger.kernel.org>

simple_strtol and simple_strtoul are obsolete, both place
use kstrtouint instead.

V2: fix error tmp += tn
V3: fix compile error

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/bluetooth/bt3c_cs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 25b0cf9..5471383 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -448,7 +448,7 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 {
 	char *ptr = (char *) firmware;
 	char b[9];
-	unsigned int iobase, tmp;
+	unsigned int iobase, tmp, tn;
 	unsigned long size, addr, fcs;
 	int i, err = 0;
 
@@ -490,7 +490,9 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 		memset(b, 0, sizeof(b));
 		for (tmp = 0, i = 0; i < size; i++) {
 			memcpy(b, ptr + (i * 2) + 2, 2);
-			tmp += simple_strtol(b, NULL, 16);
+			if (kstrtouint(b, 16, &tn))
+				return -EINVAL;
+			tmp += tn;
 		}
 
 		if (((tmp + fcs) & 0xff) != 0xff) {
@@ -505,7 +507,8 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 			memset(b, 0, sizeof(b));
 			for (i = 0; i < (size - 4) / 2; i++) {
 				memcpy(b, ptr + (i * 4) + 12, 4);
-				tmp = simple_strtoul(b, NULL, 16);
+				if (kstrtouint(b, 16, &tmp))
+					return -EINVAL;
 				bt3c_put(iobase, tmp);
 			}
 		}
-- 
1.8.3.1
