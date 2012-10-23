Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Fix updating host feature bits for LE
Date: Tue, 23 Oct 2012 19:53:59 +0300
Message-Id: <1351011241-32515-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When LE has been enabled with the simultaneous BR/EDR & LE parameter set
to true we should also update the host features stored in struct hci_dev
accordingly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index abad39c..b63a5f3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1332,6 +1332,11 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 		else
 			hdev->host_features[0] &= ~LMP_HOST_LE;
 
+		if (sent->simul)
+			hdev->host_features[0] |= LMP_HOST_LE_BREDR;
+		else
+			hdev->host_features[0] &= ~LMP_HOST_LE_BREDR;
+
 		if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags) &&
 		    test_bit(HCI_INIT, &hdev->flags))
 			hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
-- 
1.7.10.4

