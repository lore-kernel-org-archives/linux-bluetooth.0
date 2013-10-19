Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix UUID values in blacklist debugfs file
Date: Sat, 19 Oct 2013 09:31:59 -0700
Message-Id: <1382200319-26951-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The uuid entry struct is used for the UUID byte stream. That is
actually the wrong value. The correct value is uuid->uuid.

Besides fixing this up, use the %pUb modifier to print the UUID
string. However since the UUID is stored in big endian with
reversed byte order, change the byte order before printing.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b5c8cb3..c5fb3a3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -193,18 +193,16 @@ static int uuids_show(struct seq_file *f, void *p)
 
 	hci_dev_lock(hdev);
 	list_for_each_entry(uuid, &hdev->uuids, list) {
-		u32 data0, data5;
-		u16 data1, data2, data3, data4;
-
-		data5 = get_unaligned_le32(uuid);
-		data4 = get_unaligned_le16(uuid + 4);
-		data3 = get_unaligned_le16(uuid + 6);
-		data2 = get_unaligned_le16(uuid + 8);
-		data1 = get_unaligned_le16(uuid + 10);
-		data0 = get_unaligned_le32(uuid + 12);
-
-		seq_printf(f, "%.8x-%.4x-%.4x-%.4x-%.4x%.8x\n",
-			   data0, data1, data2, data3, data4, data5);
+		u8 i, val[16];
+
+		/* The Bluetooth UUID values are stored in big endian,
+		 * but with reversed byte order. So convert them into
+		 * the right order for the %pUb modifier.
+		 */
+		for (i = 0; i < 16; i++)
+			val[i] = uuid->uuid[15 - i];
+
+		seq_printf(f, "%pUb\n", val);
 	}
 	hci_dev_unlock(hdev);
 
-- 
1.8.3.1

