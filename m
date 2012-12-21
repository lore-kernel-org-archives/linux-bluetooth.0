Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH] Bluetooth: Fix uuid output in debugfs
Date: Fri, 21 Dec 2012 20:58:15 -0200
Message-Id: <1356130695-29342-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

The uuid should be printed in the CPU endianness and not in little-endian.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/hci_sysfs.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 55cceee..05b78c7 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -461,19 +461,18 @@ static const struct file_operations blacklist_fops = {
 
 static void print_bt_uuid(struct seq_file *f, u8 *uuid)
 {
-	__be32 data0, data4;
-	__be16 data1, data2, data3, data5;
-
-	memcpy(&data0, &uuid[0], 4);
-	memcpy(&data1, &uuid[4], 2);
-	memcpy(&data2, &uuid[6], 2);
-	memcpy(&data3, &uuid[8], 2);
-	memcpy(&data4, &uuid[10], 4);
-	memcpy(&data5, &uuid[14], 2);
-
-	seq_printf(f, "%.8x-%.4x-%.4x-%.4x-%.8x%.4x\n",
-		   ntohl(data0), ntohs(data1), ntohs(data2), ntohs(data3),
-		   ntohl(data4), ntohs(data5));
+	u32 data0, data5;
+	u16 data1, data2, data3, data4;
+
+	data5 = le32_to_cpu(*(__le32 *)uuid);
+	data4 = le16_to_cpu(*(__le16 *)(uuid + 4));
+	data3 = le16_to_cpu(*(__le16 *)(uuid + 6));
+	data2 = le16_to_cpu(*(__le16 *)(uuid + 8));
+	data1 = le16_to_cpu(*(__le16 *)(uuid + 10));
+	data0 = le32_to_cpu(*(__le32 *)(uuid + 12));
+
+	seq_printf(f, "%.8x-%.4x-%.4x-%.4x-%.4x%.8x\n",
+		   data0, data1, data2, data3, data4, data5);
 }
 
 static int uuids_show(struct seq_file *f, void *p)
-- 
1.8.0.2

