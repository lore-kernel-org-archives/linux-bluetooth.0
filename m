Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix enabling BR/EDR SC when powering on
Date: Fri, 12 Dec 2014 13:30:11 +0200
Message-Id: <1418383811-15178-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we're in the AUTO_OFF stage the powered_update_hci() function is
responsible for doing the updates to the HCI state that were not done
during the actual mgmt command handlers. One of the updates needing done
is for BR/EDR SC support. This patch adds the missing HCI command for SC
support to the powered_update_hci() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b0782668cd22..23a0ca5a4737 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6097,6 +6097,11 @@ static int powered_update_hci(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
 	}
 
+	if (bredr_sc_enabled(hdev) && !lmp_host_sc_capable(hdev)) {
+		u8 sc = 0x01;
+		hci_req_add(&req, HCI_OP_WRITE_SC_SUPPORT, sizeof(sc), &sc);
+	}
+
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
 	    lmp_bredr_capable(hdev)) {
 		struct hci_cp_write_le_host_supported cp;
-- 
2.1.0

