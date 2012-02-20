Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Clear EIR data when disabling SSP
Date: Tue, 21 Feb 2012 00:59:12 +0200
Message-Id: <1329778752-23846-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

EIR shouldn't be enabled if SSP isn't enabled. This patch adds the
clearing of EIR data when disabling SSP and restores the data when SSP
is re-enabled.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index aa0d640..a5a2a68 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3250,6 +3250,18 @@ int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
+static int clear_eir(struct hci_dev *hdev)
+{
+	struct hci_cp_write_eir cp;
+
+	if (!(hdev->features[6] & LMP_EXT_INQ))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+
+	return hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
+}
+
 int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
@@ -3268,9 +3280,15 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 status)
 	ev = cpu_to_le32(get_current_settings(hdev));
 	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), match.sk);
 
-	if (match.sk)
+	if (match.sk) {
 		sock_put(match.sk);
 
+		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
+			update_eir(hdev);
+		else
+			clear_eir(hdev);
+	}
+
 	return err;
 }
 
-- 
1.7.9

