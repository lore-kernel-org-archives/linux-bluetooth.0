Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add support for mode 0x02 for mgmt_set_debug_keys
Date: Tue, 24 Jun 2014 14:00:28 +0300
Message-Id: <1403607628-30926-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403607628-30926-1-git-send-email-johan.hedberg@gmail.com>
References: <1403607628-30926-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a new valid mode 0x02 for the mgmt_set_debug_keys
command. The 0x02 mode sets the HCI_USE_DEBUG_KEYS flag which makes us
always use debug keys for pairing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 69afbb2df133..f75a090cd7e4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4349,12 +4349,12 @@ static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
 			  void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
-	bool changed;
+	bool changed, use_changed;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (cp->val != 0x00 && cp->val != 0x01)
+	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEBUG_KEYS,
 				  MGMT_STATUS_INVALID_PARAMS);
 
@@ -4367,6 +4367,20 @@ static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
 		changed = test_and_clear_bit(HCI_KEEP_DEBUG_KEYS,
 					     &hdev->dev_flags);
 
+	if (cp->val == 0x02)
+		use_changed = !test_and_set_bit(HCI_USE_DEBUG_KEYS,
+						&hdev->dev_flags);
+	else
+		use_changed = test_and_clear_bit(HCI_USE_DEBUG_KEYS,
+						 &hdev->dev_flags);
+
+	if (hdev_is_powered(hdev) && use_changed &&
+	    test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+		u8 mode = (cp->val == 0x02) ? 0x01 : 0x00;
+		hci_send_cmd(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE,
+			     sizeof(mode), &mode);
+	}
+
 	err = send_settings_rsp(sk, MGMT_OP_SET_DEBUG_KEYS, hdev);
 	if (err < 0)
 		goto unlock;
-- 
1.9.3

