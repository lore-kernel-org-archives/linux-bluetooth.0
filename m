Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Print information of Intel SfP lock states
Date: Tue, 13 Oct 2015 13:54:55 +0200
Message-Id: <1444737295-109828-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The lock states from Intel SfP controllers can only be read once before
loading the firmware. So for debugging purposes, print them out.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e9142a4ebd94..27830da67063 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2104,6 +2104,15 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	BT_INFO("%s: Secure boot is %s", hdev->name,
 		params->secure_boot ? "enabled" : "disabled");
 
+	BT_INFO("%s: OTP lock is %s", hdev->name,
+		params->otp_lock ? "enabled" : "disabled");
+
+	BT_INFO("%s: API lock is %s", hdev->name,
+		params->api_lock ? "enabled" : "disabled");
+
+	BT_INFO("%s: Debug lock is %s", hdev->name,
+		params->debug_lock ? "enabled" : "disabled");
+
 	BT_INFO("%s: Minimum firmware build %u week %u %u", hdev->name,
 		params->min_fw_build_nn, params->min_fw_build_cw,
 		2000 + params->min_fw_build_yy);
-- 
2.4.3

