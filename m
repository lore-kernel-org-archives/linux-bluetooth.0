Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Introduce controller setting information for static address
Date: Fri,  6 Mar 2015 10:11:21 -0800
Message-Id: <1425665481-5898-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently it is not possible to determine if the static address is used
by the controller. It is also not possible to determine if using a
static on a dual-mode controller with disabled BR/EDR is possible or
not.

To address this issue, introduce a new setting called static-address. If
support for this setting is signaled that means that the kernel supports
using static addresses. And if used on dual-mode controllers with BR/EDR
disabled it means that a configured static address can be used.

In addition utilize the same setting for the list of current active
settings that indicates if a static address is configured and if that
address will be actually used.

With this in mind the existing Set Static Address management command
has been extended to return the current settings. That way the caller
of that command can easily determine if the programmed address will
be used or if extra steps are required.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |  1 +
 net/bluetooth/mgmt.c         | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index fe8eef00e9ca..0c737e4b8f57 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -98,6 +98,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_DEBUG_KEYS		0x00001000
 #define MGMT_SETTING_PRIVACY		0x00002000
 #define MGMT_SETTING_CONFIGURATION	0x00004000
+#define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 967f07fdbbbe..d185a9800983 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -583,6 +583,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_ADVERTISING;
 		settings |= MGMT_SETTING_SECURE_CONN;
 		settings |= MGMT_SETTING_PRIVACY;
+		settings |= MGMT_SETTING_STATIC_ADDRESS;
 	}
 
 	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
@@ -638,6 +639,25 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_PRIVACY, &hdev->dev_flags))
 		settings |= MGMT_SETTING_PRIVACY;
 
+	/* The current setting for static address has two purposes. The
+	 * first is to indicate if the static address will be used and
+	 * the second is to indicate if it is actually set.
+	 *
+	 * This means if the static address is not configured, this flag
+	 * will never bet set. If the address is configured, then if the
+	 * address is actually used decides if the flag is set or not.
+	 *
+	 * For single mode LE only controllers and dual-mode controllers
+	 * with BR/EDR disabled, the existence of the static address will
+	 * be evaluated.
+	 */
+	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
+	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) ||
+	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
+		if (bacmp(&hdev->static_addr, BDADDR_ANY))
+			settings |= MGMT_SETTING_STATIC_ADDRESS;
+	}
+
 	return settings;
 }
 
@@ -4498,10 +4518,14 @@ static int set_static_address(struct sock *sk, struct hci_dev *hdev,
 
 	bacpy(&hdev->static_addr, &cp->bdaddr);
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS, 0, NULL, 0);
+	err = send_settings_rsp(sk, MGMT_OP_SET_STATIC_ADDRESS, hdev);
+	if (err < 0)
+		goto unlock;
 
-	hci_dev_unlock(hdev);
+	err = new_settings(hdev, sk);
 
+unlock:
+	hci_dev_unlock(hdev);
 	return err;
 }
 
-- 
2.1.0

