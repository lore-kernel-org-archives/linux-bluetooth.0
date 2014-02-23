Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/10] Bluetooth: Use hci_get_own_address_type() for initiating LE scan
Date: Sun, 23 Feb 2014 16:23:55 +0200
Message-Id: <1393165438-13610-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
References: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we start LE scanning we need to update the local random address if
necessary. This patch updates the code to use hci_get_own_address_type()
for setting the own_address_type scan parameter and updating the local
random address if necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e57dc93af331..467ca21e04d6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3382,7 +3382,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		param_cp.type = LE_SCAN_ACTIVE;
 		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
 		param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
-		param_cp.own_address_type = hdev->own_addr_type;
+		param_cp.own_address_type = hci_get_own_address_type(&req);
 		hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
 			    &param_cp);
 
-- 
1.8.5.3

