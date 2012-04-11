Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v0 5/6] Bluetooth: btusb: Dynamic alternate setting
Date: Wed, 11 Apr 2012 08:48:51 +0200
Message-Id: <1334126932-27327-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The alternate setting must be dynamically set according to the number of
active SCO links, and the bit depth of the audio. The possible values
for the alternate setting are described in the Bluetooth Core
Specification, Volume 4, Part B, section 2.1.1.

Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
---
 drivers/bluetooth/btusb.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3311b81..10d02fa 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -849,6 +849,7 @@ static void btusb_work(struct work_struct *work)
 {
 	struct btusb_data *data = container_of(work, struct btusb_data, work);
 	struct hci_dev *hdev = data->hdev;
+	int new_alts;
 	int err;
 
 	if (hdev->conn_hash.sco_num > 0) {
@@ -862,11 +863,19 @@ static void btusb_work(struct work_struct *work)
 
 			set_bit(BTUSB_DID_ISO_RESUME, &data->flags);
 		}
-		if (data->isoc_altsetting != 2) {
+
+		if (hdev->voice_setting & 0x0020) {
+			static const int alts[3] = { 2, 4, 5 };
+			new_alts = alts[hdev->conn_hash.sco_num - 1];
+		} else {
+			new_alts = hdev->conn_hash.sco_num;
+		}
+
+		if (data->isoc_altsetting != new_alts) {
 			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 			usb_kill_anchored_urbs(&data->isoc_anchor);
 
-			if (__set_isoc_interface(hdev, 2) < 0)
+			if (__set_isoc_interface(hdev, new_alts) < 0)
 				return;
 		}
 
-- 
1.7.7.6

