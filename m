Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Bind the SMP channel registration to management power state
Date: Wed, 14 Jan 2015 15:43:11 -0800
Message-Id: <1421278991-4169-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller gets powered on via the management interface, then
register the supported SMP channels. There is no point in registering
these channels earlier since it is not know what identity address the
controller is going to operate with.

When powering down a controller unregister all SMP channels. This is
required since a powered down controller is allowed to change its
identity address.

In addition the SMP channels are only available when the controller
is powered via the management interface. When using legacy ioctl, then
Bluetooth Low Energy is not supported and registering kernel side SMP
integration may actually cause confusion.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 6 +++---
 net/bluetooth/mgmt.c     | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c04197347c90..34c17a0645ce 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -933,10 +933,8 @@ static int __hci_init(struct hci_dev *hdev)
 	if (lmp_bredr_capable(hdev))
 		hci_debugfs_create_bredr(hdev);
 
-	if (lmp_le_capable(hdev)) {
+	if (lmp_le_capable(hdev))
 		hci_debugfs_create_le(hdev);
-		smp_register(hdev);
-	}
 
 	return 0;
 }
@@ -2133,6 +2131,8 @@ static void hci_power_off(struct work_struct *work)
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_do_close(hdev);
+
+	smp_unregister(hdev);
 }
 
 static void hci_discov_off(struct work_struct *work)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cae612658ba9..f5c4d2eed9a1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6232,6 +6232,15 @@ static void powered_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	BT_DBG("status 0x%02x", status);
 
+	if (!status) {
+		/* Register the available SMP channels (BR/EDR and LE) only
+		 * when successfully powering on the controller. This late
+		 * registration is required so that LE SMP can clearly
+		 * decide if the public address or static address is used.
+		 */
+		smp_register(hdev);
+	}
+
 	hci_dev_lock(hdev);
 
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
-- 
2.1.0

