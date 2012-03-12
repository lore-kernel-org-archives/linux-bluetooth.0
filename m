Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: trivial: Correct types
Date: Mon, 12 Mar 2012 15:59:31 +0200
Message-Id: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fix sparse warnigns below:
...
net/bluetooth/hci_sysfs.c:458:33: warning: cast to restricted __be32
net/bluetooth/hci_sysfs.c:458:47: warning: cast to restricted __be16
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_sysfs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index bc15429..0a4e7ab 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -444,8 +444,8 @@ static const struct file_operations blacklist_fops = {
 
 static void print_bt_uuid(struct seq_file *f, u8 *uuid)
 {
-	u32 data0, data4;
-	u16 data1, data2, data3, data5;
+	__be32 data0, data4;
+	__be16 data1, data2, data3, data5;
 
 	memcpy(&data0, &uuid[0], 4);
 	memcpy(&data1, &uuid[4], 2);
-- 
1.7.9.1

