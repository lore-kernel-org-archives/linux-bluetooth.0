Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix dependency for BR/EDR Secure Connections mode on SSP
Date: Thu, 22 Jan 2015 11:15:20 -0800
Message-Id: <1421954122-15727-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The BR/EDR Secure Connections feature should only be enabled when the
Secure Simple Pairing mode has been enabled first. However since secure
connections is feature that is valid for BR/EDR and LE, this needs
special handling.

When enabling secure connections on a LE only configured controller,
thent the BR/EDR side should not be enabled in the controller. This
patches makes the BR/EDR Secure Connections feature depending on
enabling Secure Simple Pairing mode first.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c |  5 ++++-
 net/bluetooth/mgmt.c     | 14 ++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 34c17a0645ce..bb831d678868 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -609,6 +609,7 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 
 		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
 			u8 mode = 0x01;
+
 			hci_req_add(req, HCI_OP_WRITE_SSP_MODE,
 				    sizeof(mode), &mode);
 		} else {
@@ -870,8 +871,10 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_READ_SYNC_TRAIN_PARAMS, 0, NULL);
 
 	/* Enable Secure Connections if supported and configured */
-	if (bredr_sc_enabled(hdev)) {
+	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
+	    bredr_sc_enabled(hdev)) {
 		u8 support = 0x01;
+
 		hci_req_add(req, HCI_OP_WRITE_SC_SUPPORT,
 			    sizeof(support), &support);
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a619d983c078..3049a4815665 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6262,14 +6262,16 @@ static int powered_update_hci(struct hci_dev *hdev)
 
 	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
 	    !lmp_host_ssp_capable(hdev)) {
-		u8 ssp = 1;
+		u8 mode = 0x01;
 
-		hci_req_add(&req, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
-	}
+		hci_req_add(&req, HCI_OP_WRITE_SSP_MODE, sizeof(mode), &mode);
+
+		if (bredr_sc_enabled(hdev) && !lmp_host_sc_capable(hdev)) {
+			u8 support = 0x01;
 
-	if (bredr_sc_enabled(hdev) && !lmp_host_sc_capable(hdev)) {
-		u8 sc = 0x01;
-		hci_req_add(&req, HCI_OP_WRITE_SC_SUPPORT, sizeof(sc), &sc);
+			hci_req_add(&req, HCI_OP_WRITE_SC_SUPPORT,
+				    sizeof(support), &support);
+		}
 	}
 
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
-- 
2.1.0

