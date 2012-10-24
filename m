Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Fix updating host feature bits for LE
Date: Wed, 24 Oct 2012 21:11:59 +0300
Message-Id: <1351102323-4654-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
References: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When LE has been enabled with the simultaneous BR/EDR & LE parameter set
to true we should also update the host features stored in struct hci_dev
accordingly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0b9e646..aa325ee 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1287,6 +1287,11 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 			hdev->host_features[0] |= LMP_HOST_LE;
 		else
 			hdev->host_features[0] &= ~LMP_HOST_LE;
+
+		if (sent->simul)
+			hdev->host_features[0] |= LMP_HOST_LE_BREDR;
+		else
+			hdev->host_features[0] &= ~LMP_HOST_LE_BREDR;
 	}
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
-- 
1.7.10.4

