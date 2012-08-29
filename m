Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v3 1/2] Bluetooth: mgmt: Fix enabling SSP while powered off
Date: Wed, 29 Aug 2012 10:02:08 +0200
Message-ID: <1346227329-1686-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When new BT USB adapter is plugged in it's configured while still being powered
off (HCI_AUTO_OFF flag is set), thus Set SSP will only set dev_flags but won't
write changes to controller. As a result remote devices won't use Secure Simple
Pairing with our device due to SSP Host Support flag disabled in extended
features and may also reject SSP attempt from our side (with possible fallback
to legacy pairing).

This patch ensures HCI Write Simple Pairing Mode is sent when Set Powered is
called to power on controller and clear HCI_AUTO_OFF flag.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: stable@vger.kernel.org
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 05d4b83..ccc6716 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2891,6 +2891,12 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 		if (scan)
 			hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 
+		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+			u8 ssp = 1;
+
+			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
+		}
+
 		update_class(hdev);
 		update_name(hdev, hdev->dev_name);
 		update_eir(hdev);
-- 
1.7.11.3

