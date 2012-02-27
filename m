Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Don't send unnecessary write_le_enable command
Date: Tue, 28 Feb 2012 01:41:33 +0200
Message-Id: <1330386094-19501-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If the local host features indicate that LE is already in the state that
is desired there's no point in sending the HCI command to try to change
the setting.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 27830f4..5373bc1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1260,7 +1260,7 @@ static int set_le(struct sock *sk, u16 index, void *data, u16 len)
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
-	u8 val;
+	u8 val, enabled;
 
 	BT_DBG("request for hci%u", index);
 
@@ -1280,8 +1280,9 @@ static int set_le(struct sock *sk, u16 index, void *data, u16 len)
 	}
 
 	val = !!cp->val;
+	enabled = !!(hdev->host_features[0] & 0x02);
 
-	if (!hdev_is_powered(hdev)) {
+	if (!hdev_is_powered(hdev) || val == enabled) {
 		bool changed = false;
 
 		if (val != test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
-- 
1.7.9.1

