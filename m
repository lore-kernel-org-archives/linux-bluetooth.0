Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 1/2] Bluetooth: mgmt: Fix enabling SSP while powered off
Date: Tue, 28 Aug 2012 13:52:22 +0200
Message-ID: <1346154743-18749-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set SSP called when hdev is up but still has HCI_AUTO_OFF flag set will
only change dev_flags and enable feature in host but won't enable feature
in controller. As a result some devices will reject IO Capa Request due to
missing SSP Host Support flag in extended features and thus won't allow
SSP or fallback to legacy pairing.

This patch ensures HCI Write Simple Pairing Mode is sent when Set Powered is
called to clear HCI_AUTO_OFF flag.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
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

