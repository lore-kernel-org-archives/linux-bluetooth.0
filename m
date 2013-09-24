Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: Add new mgmt setting for LE advertising
Date: Tue, 24 Sep 2013 17:02:42 +0300
Message-Id: <1380031363-1266-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a new mgmt setting for LE advertising and hooks up the
necessary places in the mgmt code to operate on the HCI_LE_PERIPHERAL
flag (which corresponds to this setting). This patch does not yet add
any new command for enabling the setting - that is left for a subsequent
patch.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |  1 +
 net/bluetooth/mgmt.c         | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9944c3e..6cc72b6 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -93,6 +93,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_BREDR		0x00000080
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
+#define MGMT_SETTING_ADVERTISING	0x00000400
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e595b59..d11899d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -384,8 +384,10 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (enable_hs)
 		settings |= MGMT_SETTING_HS;
 
-	if (lmp_le_capable(hdev))
+	if (lmp_le_capable(hdev)) {
 		settings |= MGMT_SETTING_LE;
+		settings |= MGMT_SETTING_ADVERTISING;
+	}
 
 	return settings;
 }
@@ -424,6 +426,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_HS_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_HS;
 
+	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
+		settings |= MGMT_SETTING_ADVERTISING;
+
 	return settings;
 }
 
@@ -1368,6 +1373,9 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
 
 	change_bit(HCI_LE_ENABLED, &hdev->dev_flags);
 
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+
 	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, settings_rsp, &match);
 
 	new_settings(hdev, match.sk);
@@ -1413,6 +1421,11 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 			changed = true;
 		}
 
+		if (!val && test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags)) {
+			clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+			changed = true;
+		}
+
 		err = send_settings_rsp(sk, MGMT_OP_SET_LE, hdev);
 		if (err < 0)
 			goto unlock;
@@ -1444,6 +1457,9 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_req_init(&req, hdev);
 
+	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags) && !val)
+		hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(val), &val);
+
 	hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
 		    &hci_cp);
 
@@ -3519,6 +3535,12 @@ static int powered_update_hci(struct hci_dev *hdev)
 				    sizeof(cp), &cp);
 	}
 
+	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags)) {
+		u8 adv = 0x01;
+
+		hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(adv), &adv);
+	}
+
 	link_sec = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
 	if (link_sec != test_bit(HCI_AUTH, &hdev->flags))
 		hci_req_add(&req, HCI_OP_WRITE_AUTH_ENABLE,
-- 
1.8.4.rc3

