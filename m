Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Fix advertising address type when toggling connectable
Date: Tue, 25 Feb 2014 19:56:31 +0200
Message-Id: <1393350991-8327-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the connectable setting is toggled using mgmt_set_connectable the
HCI_CONNECTABLE flag will only be set once the related HCI commands
succeed. When determining what kind of advertising to do we need to
therefore also check whether there is a pending Set Connectable command
in addition to the current flag value.

The enable_advertising function was already taking care of this for the
advertising type with the help of the get_adv_type function, but was
failing to do the same for the address type selection. This patch
converts the get_adv_type function to be more generic in that it returns
the expected connectable state and updates the enable_advertising
function to use the return value both for the advertising type as well
as the advertising address type.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25b8b278debd..d6e269287cfc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -817,10 +817,9 @@ static void update_class(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
 }
 
-static u8 get_adv_type(struct hci_dev *hdev)
+static bool get_connectable(struct hci_dev *hdev)
 {
 	struct pending_cmd *cmd;
-	bool connectable;
 
 	/* If there's a pending mgmt command the flag will not yet have
 	 * it's final value, so check for this first.
@@ -828,12 +827,10 @@ static u8 get_adv_type(struct hci_dev *hdev)
 	cmd = mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
 	if (cmd) {
 		struct mgmt_mode *cp = cmd->param;
-		connectable = !!cp->val;
-	} else {
-		connectable = test_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+		return cp->val;
 	}
 
-	return connectable ? LE_ADV_IND : LE_ADV_NONCONN_IND;
+	return test_bit(HCI_CONNECTABLE, &hdev->dev_flags);
 }
 
 static void enable_advertising(struct hci_request *req)
@@ -841,17 +838,21 @@ static void enable_advertising(struct hci_request *req)
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_adv_param cp;
 	u8 own_addr_type, enable = 0x01;
-	bool require_privacy;
+	bool connectable;
 
-	require_privacy = !test_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+	connectable = get_connectable(hdev);
 
-	if (hci_update_random_address(req, require_privacy, &own_addr_type) < 0)
+	/* Set require_privacy to true only when non-connectable
+	 * advertising is used. In that case it is fine to use a
+	 * non-resolvable private address.
+	 */
+	if (hci_update_random_address(req, !connectable, &own_addr_type) < 0)
 		return;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.min_interval = __constant_cpu_to_le16(0x0800);
 	cp.max_interval = __constant_cpu_to_le16(0x0800);
-	cp.type = get_adv_type(hdev);
+	cp.type = connectable ? LE_ADV_IND : LE_ADV_NONCONN_IND;
 	cp.own_address_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 
-- 
1.8.5.3

