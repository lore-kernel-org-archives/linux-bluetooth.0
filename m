Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Fix sending unnecessary HCI_Write_SSP_Mode command
Date: Thu, 25 Oct 2012 00:09:52 +0300
Message-Id: <1351112996-9597-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes sending an unnecessary HCI_Write_SSP_Mode command if
the command has already been sent as part of the default HCI init
sequence.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/mgmt.c             |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6642b3c..b3490c6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -770,6 +770,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_ext_feat_capable(dev)  ((dev)->features[7] & LMP_EXTFEATURES)
 
 /* ----- Extended LMP capabilities ----- */
+#define lmp_host_ssp_capable(dev)  ((dev)->host_features[0] & LMP_HOST_SSP)
 #define lmp_host_le_capable(dev)   ((dev)->host_features[0] & LMP_HOST_LE)
 #define lmp_host_le_br_capable(dev) ((dev)->host_features[0] & LMP_HOST_LE_BREDR)
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0ee150e..02dc5f8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2914,7 +2914,8 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
 	if (powered) {
-		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
+		    !lmp_host_ssp_capable(hdev)) {
 			u8 ssp = 1;
 
 			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
-- 
1.7.10.4

