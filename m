Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v3 2/2] Bluetooth: mgmt: Fix enabling LE while powered off
Date: Wed, 29 Aug 2012 10:02:09 +0200
Message-ID: <1346227329-1686-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346227329-1686-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346227329-1686-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When new BT USB adapter is plugged in it's configured while still being powered
off (HCI_AUTO_OFF flag is set), thus Set LE will only set dev_flags but won't
write changes to controller. As a result it's not possible to start device
discovery session on LE controller as it uses interleaved discovery which
requires LE Supported Host flag in extended features.

This patch ensures HCI Write LE Host Supported is sent when Set Powered is
called to power on controller and clear HCI_AUTO_OFF flag.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: stable@vger.kernel.org
---
 net/bluetooth/mgmt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccc6716..57ce7cd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2897,6 +2897,16 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
 		}
 
+		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+			struct hci_cp_write_le_host_supported cp;
+
+			cp.le = 1;
+			cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
+
+			hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
+				     sizeof(cp), &cp);
+		}
+
 		update_class(hdev);
 		update_name(hdev, hdev->dev_name);
 		update_eir(hdev);
-- 
1.7.11.3

