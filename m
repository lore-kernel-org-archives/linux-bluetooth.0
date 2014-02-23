Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 07/13] Bluetooth: Use hci_update_random_address() for enabling advertising
Date: Sun, 23 Feb 2014 19:42:23 +0200
Message-Id: <1393177349-361-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we enable advertising we need to update the local random address if
necessary. This patch takes advantage of the hci_update_random_address()
function to set the own_address_type variable and to update the local
random address if necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 09316dd2cce1..14de8505c054 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -839,13 +839,17 @@ static void enable_advertising(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_adv_param cp;
-	u8 enable = 0x01;
+	u8 own_addr_type, enable = 0x01;
 
 	memset(&cp, 0, sizeof(cp));
+
+	if (hci_update_random_address(req, &own_addr_type) < 0)
+		return;
+
 	cp.min_interval = __constant_cpu_to_le16(0x0800);
 	cp.max_interval = __constant_cpu_to_le16(0x0800);
 	cp.type = get_adv_type(hdev);
-	cp.own_address_type = hdev->own_addr_type;
+	cp.own_address_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 
 	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
-- 
1.8.5.3

