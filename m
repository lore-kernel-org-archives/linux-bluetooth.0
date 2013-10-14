Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for entering limited discoverable mode
Date: Mon, 14 Oct 2013 16:08:19 -0700
Message-Id: <1381792099-8732-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The limited discoverable mode should be used when a device is only
discoverable for a certain amount of time and after that it returns
back into being non-discoverable.

The management interface allows to specify a timeout parameter when
makeing a device discoverable. If such a timeout is specified or
changed, enter limited discoverable mode. Otherwise enter general
discoverable mode.

Devices in limited discoverable mode can still be found by the
general discovery procedure. It is mandatory that a device sets
both GIAC and LIAC when entering limited discoverable mode.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  6 ++++++
 net/bluetooth/mgmt.c        | 41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b096f5f..ab96f3b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -823,6 +823,12 @@ struct hci_rp_read_num_supported_iac {
 
 #define HCI_OP_READ_CURRENT_IAC_LAP	0x0c39
 
+#define HCI_OP_WRITE_CURRENT_IAC_LAP	0x0c3a
+struct hci_cp_write_current_iac_lap {
+	__u8	num_iac;
+	__u8	iac_lap[6];
+} __packed;
+
 #define HCI_OP_WRITE_INQUIRY_MODE	0x0c45
 
 #define HCI_MAX_EIR_LENGTH		240
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 861e389..cba15da 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1041,6 +1041,8 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (!!cp->val == test_bit(HCI_DISCOVERABLE, &hdev->dev_flags)) {
+		u16 current_timeout = hdev->discov_timeout;
+
 		if (hdev->discov_timeout > 0) {
 			cancel_delayed_work(&hdev->discov_off);
 			hdev->discov_timeout = 0;
@@ -1052,8 +1054,16 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 				msecs_to_jiffies(hdev->discov_timeout * 1000));
 		}
 
-		err = send_settings_rsp(sk, MGMT_OP_SET_DISCOVERABLE, hdev);
-		goto failed;
+		/* A change in timeout means that the device is switching
+		 * from one discoverable mode to another. In that case
+		 * the IAC LAP needs to be changed.
+		 */
+		if ((current_timeout > 0 && timeout > 0) ||
+		    (current_timeout == 0 && timeout == 0)) {
+			err = send_settings_rsp(sk, MGMT_OP_SET_DISCOVERABLE,
+						hdev);
+			goto failed;
+		}
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, hdev, data, len);
@@ -1066,10 +1076,33 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	scan = SCAN_PAGE;
 
-	if (cp->val)
+	if (cp->val) {
+		struct hci_cp_write_current_iac_lap cp;
+
+		if (timeout > 0) {
+			/* Limited discoverable mode */
+			cp.num_iac = 2;
+			cp.iac_lap[0] = 0x00;	/* LIAC */
+			cp.iac_lap[1] = 0x8b;
+			cp.iac_lap[2] = 0x9e;
+			cp.iac_lap[3] = 0x33;	/* GIAC */
+			cp.iac_lap[4] = 0x8b;
+			cp.iac_lap[5] = 0x9e;
+		} else {
+			/* General discoverable mode */
+			cp.num_iac = 1;
+			cp.iac_lap[0] = 0x33;	/* GIAC */
+			cp.iac_lap[1] = 0x8b;
+			cp.iac_lap[2] = 0x9e;
+		}
+
+		hci_req_add(&req, HCI_OP_WRITE_CURRENT_IAC_LAP,
+			    (cp.num_iac * 3) + 1, &cp);
+
 		scan |= SCAN_INQUIRY;
-	else
+	} else {
 		cancel_delayed_work(&hdev->discov_off);
+	}
 
 	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 
-- 
1.8.3.1

