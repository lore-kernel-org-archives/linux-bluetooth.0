Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/13] Bluetooth: Disable auto-connection parameters when unpairing
Date: Wed, 21 Oct 2015 18:03:04 +0300
Message-Id: <1445439791-2151-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
References: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For connection parameters that are left around until a disconnection
we should at least clear any auto-connection properties. This way a
new Add Device call is required to re-set them after calling Unpair
Device.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d56845a28af1..3fa4cafc2c03 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3052,6 +3052,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_unpair_device *cp = data;
 	struct mgmt_rp_unpair_device rp;
+	struct hci_conn_params *params;
 	struct hci_cp_disconnect dc;
 	struct mgmt_pending_cmd *cmd;
 	struct hci_conn *conn;
@@ -3131,6 +3132,15 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	 */
 	set_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
 
+	/* Disable auto-connection parameters if present */
+	params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr, addr_type);
+	if (params) {
+		if (params->explicit_connect)
+			params->auto_connect = HCI_AUTO_CONN_EXPLICIT;
+		else
+			params->auto_connect = HCI_AUTO_CONN_DISABLED;
+	}
+
 	/* If disconnection is not requested, then clear the connection
 	 * variable so that the link is not terminated.
 	 */
-- 
2.5.0

