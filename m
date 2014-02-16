Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix sending wrong store hint for new long term keys
Date: Sun, 16 Feb 2014 12:59:06 -0800
Message-Id: <1392584346-64921-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The long term keys should only be stored when they belong to an
indentity address. The identity address can either be a public
address or a random static address.

For all other addresses (unresovable or resolvable) tell userspace
that the long term key is not persistent.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e7746690d620..58d2f9bf241f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2685,6 +2685,7 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 {
 	struct smp_ltk *key, *old_key;
 	bool master = ltk_type_master(type);
+	u8 persistent;
 
 	old_key = hci_find_ltk_by_addr(hdev, bdaddr, addr_type, master);
 	if (old_key)
@@ -2708,8 +2709,13 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 	if (!new_key)
 		return 0;
 
+	if (addr_type == ADDR_LE_DEV_RANDOM && (bdaddr->b[5] & 0xc0) != 0xc0)
+		persistent = 0;
+	else
+		persistent = 1;
+
 	if (type == HCI_SMP_LTK || type == HCI_SMP_LTK_SLAVE)
-		mgmt_new_ltk(hdev, key, 1);
+		mgmt_new_ltk(hdev, key, persistent);
 
 	return 0;
 }
-- 
1.8.5.3

