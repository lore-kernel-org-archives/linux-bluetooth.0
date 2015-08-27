Return-Path: <cyrus@holtmann.org>
From: Minjune Kim <infinite.minjune.kim@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Minjune Kim <infinite.minjune.kim@gmail.com>
Subject: [PATCH] Correct typo based on checkpatch.pl
Date: Thu, 27 Aug 2015 13:21:52 +0900
Message-Id: <1440649312-4716-1-git-send-email-infinite.minjune.kim@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Minjune Kim <infinite.minjune.kim@gmail.com>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f759dea..b6aceaf 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1581,7 +1581,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 
 	/* fw_patch_num indicates the version of patch the device currently
 	 * have. If there is no patch data in the device, it is always 0x00.
-	 * So, if it is other than 0x00, no need to patch the deivce again.
+	 * So, if it is other than 0x00, no need to patch the device again.
 	 */
 	if (ver->fw_patch_num) {
 		BT_INFO("%s: Intel device is already patched. patch num: %02x",
@@ -2100,7 +2100,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 		frag_len += sizeof(*cmd) + cmd->plen;
 
-		/* The paramter length of the secure send command requires
+		/* The parameter length of the secure send command requires
 		 * a 4 byte alignment. It happens so that the firmware file
 		 * contains proper Intel_NOP commands to align the fragments
 		 * as needed.
-- 
2.5.0

