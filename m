Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/10] Bluetooth: Use hci_get_own_address_type() for enabling advertising
Date: Sun, 23 Feb 2014 16:23:54 +0200
Message-Id: <1393165438-13610-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
References: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we enable advertising we need to update the local random address if
necessary. This patch takes advantage of the hci_get_own_address_type()
function to set the own_address_type variable and to update the local
random address if necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 09316dd2cce1..e57dc93af331 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -845,7 +845,7 @@ static void enable_advertising(struct hci_request *req)
 	cp.min_interval = __constant_cpu_to_le16(0x0800);
 	cp.max_interval = __constant_cpu_to_le16(0x0800);
 	cp.type = get_adv_type(hdev);
-	cp.own_address_type = hdev->own_addr_type;
+	cp.own_address_type = hci_get_own_address_type(req);
 	cp.channel_map = hdev->le_adv_channel_map;
 
 	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
-- 
1.8.5.3

