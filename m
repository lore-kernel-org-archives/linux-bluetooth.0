Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: mgmt: Restrict BR/EDR settings to BR/EDR-only adapters
Date: Tue, 23 Oct 2012 19:53:56 +0300
Message-Id: <1351011241-32515-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch makes sure that settings which are specific for BR/EDR
capable adapters are not allowed for non-BR/EDR (e.g. LE-only) adapters.
Instead, a "not supported" error is returned of such a setting is
attempted to be set for a non-BR/EDR adapter.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1d79979..eaa6fdc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -377,15 +377,15 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	u32 settings = 0;
 
 	settings |= MGMT_SETTING_POWERED;
-	settings |= MGMT_SETTING_CONNECTABLE;
-	settings |= MGMT_SETTING_FAST_CONNECTABLE;
-	settings |= MGMT_SETTING_DISCOVERABLE;
 	settings |= MGMT_SETTING_PAIRABLE;
 
 	if (lmp_ssp_capable(hdev))
 		settings |= MGMT_SETTING_SSP;
 
 	if (lmp_bredr_capable(hdev)) {
+		settings |= MGMT_SETTING_CONNECTABLE;
+		settings |= MGMT_SETTING_FAST_CONNECTABLE;
+		settings |= MGMT_SETTING_DISCOVERABLE;
 		settings |= MGMT_SETTING_BREDR;
 		settings |= MGMT_SETTING_LINK_SECURITY;
 	}
@@ -874,6 +874,10 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
+	if (!lmp_bredr_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
+				 MGMT_STATUS_NOT_SUPPORTED);
+
 	timeout = __le16_to_cpu(cp->timeout);
 	if (!cp->val && timeout > 0)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
@@ -969,6 +973,10 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
+	if (!lmp_bredr_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -1067,6 +1075,10 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
+	if (!lmp_bredr_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -2647,6 +2659,10 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
+	if (!lmp_bredr_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
 	if (!hdev_is_powered(hdev))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				  MGMT_STATUS_NOT_POWERED);
-- 
1.7.10.4

