Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Use privacy mode for non-connectable advertising
Date: Sun, 23 Feb 2014 20:25:55 -0800
Message-Id: <1393215955-3907-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When enabling non-connectable advertising, there is no need to advertise
with a public address or static address. In case LE privacy has not been
enabled a unresolvable private address will be used.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5d309d4ab527..50d86e2e6bc5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -841,12 +841,14 @@ static void enable_advertising(struct hci_request *req)
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_adv_param cp;
 	u8 own_addr_type, enable = 0x01;
+	bool allow_privacy;
 
-	memset(&cp, 0, sizeof(cp));
+	allow_privacy = !test_bit(HCI_CONNECTABLE, &hdev->dev_flags);
 
-	if (hci_update_random_address(req, false, &own_addr_type) < 0)
+	if (hci_update_random_address(req, allow_privacy, &own_addr_type) < 0)
 		return;
 
+	memset(&cp, 0, sizeof(cp));
 	cp.min_interval = __constant_cpu_to_le16(0x0800);
 	cp.max_interval = __constant_cpu_to_le16(0x0800);
 	cp.type = get_adv_type(hdev);
-- 
1.8.5.3

