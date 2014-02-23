Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 08/13] Bluetooth: Use hci_update_random_address() for initiating LE scan
Date: Sun, 23 Feb 2014 19:42:24 +0200
Message-Id: <1393177349-361-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we start LE scanning we need to update the local random address if
necessary. This patch updates the code to use hci_update_random_address()
for setting the own_address_type scan parameter and updating the local
random address if necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 14de8505c054..92f776318a6b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3290,7 +3290,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	struct hci_request req;
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	u8 status;
+	u8 status, own_addr_type;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -3383,10 +3383,19 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		}
 
 		memset(&param_cp, 0, sizeof(param_cp));
+
+		err = hci_update_random_address(&req, &own_addr_type);
+		if (err < 0) {
+			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+					 MGMT_STATUS_FAILED);
+			mgmt_pending_remove(cmd);
+			goto failed;
+		}
+
 		param_cp.type = LE_SCAN_ACTIVE;
 		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
 		param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
-		param_cp.own_address_type = hdev->own_addr_type;
+		param_cp.own_address_type = own_addr_type;
 		hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
 			    &param_cp);
 
-- 
1.8.5.3

