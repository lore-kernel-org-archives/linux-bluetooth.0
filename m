Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC untested] Bluetooth: btusb: Fix secure send command length alignment on Intel 8260
Date: Sun,  7 Jun 2015 09:47:08 +0200
Message-Id: <1433663228-30253-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the command length alignment issue for Intel Bluetooth
8260.

The length of parameters in the firmware downloading command must be
multiplication of 4. If not, the command must append Intel_NOP command
with extra parameters, zeros, at the end, and the firmware file is
already included Intel_NOP command for alignment.

This patch checks the next command and if the next command is Intel_NOP
command, it reads the Intel_NOP command and send them together.

For example, if the data from the firmware file looks like this:
8E FC 03 11 22 33 02 FC 03 00 00 00

Previously, btusb sends two commands:
09 FC 06 8E FC 03 11 22 33
09 FC 06 02 FC 03 00 00 00

This won't work because the length of parameters are 6 which violates
the 4 byte alignment.

This patch will append them together and send as one command:
09 FC 0C 8E FC 03 11 22 33 02 FC 03 00 00 00

Based on previous work from Tedd Ho-Jeong An <tedd.an@intel.com>

Reported-by: Tedd Ho-Jeong An <tedd.an@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/btusb.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7f936db169f5..945f04b80275 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1950,6 +1950,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	struct intel_boot_params *params;
 	const struct firmware *fw;
 	const u8 *fw_ptr;
+	u32 frag_len;
 	char fwname[64];
 	ktime_t calltime, delta, rettime;
 	unsigned long long duration;
@@ -2142,24 +2143,33 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	}
 
 	fw_ptr = fw->data + 644;
+	frag_len = 0;
 
 	while (fw_ptr - fw->data < fw->size) {
-		struct hci_command_hdr *cmd = (void *)fw_ptr;
-		u8 cmd_len;
+		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
 
-		cmd_len = sizeof(*cmd) + cmd->plen;
+		frag_len += sizeof(*cmd) + cmd->plen;
 
-		/* Send each command from the firmware data buffer as
-		 * a single Data fragment.
+		/* The paramter length of the secure send command requires
+		 * a 4 byte alignment. It happens so that the firmware file
+		 * contains proper Intel_NOP commands to align the fragments
+		 * as needed.
+		 *
+		 * Send set of commands with 4 byte alignment from the
+		 * firmware data buffer as a single Data fragement.
 		 */
-		err = btusb_intel_secure_send(hdev, 0x01, cmd_len, fw_ptr);
-		if (err < 0) {
-			BT_ERR("%s: Failed to send firmware data (%d)",
-			       hdev->name, err);
-			goto done;
-		}
+		if (!(frag_len % 4)) {
+			err = btusb_intel_secure_send(hdev, 0x01, frag_len,
+						      fw_ptr);
+			if (err < 0) {
+				BT_ERR("%s: Failed to send firmware data (%d)",
+				       hdev->name, err);
+				goto done;
+			}
 
-		fw_ptr += cmd_len;
+			fw_ptr += frag_len;
+			frag_len = 0;
+		}
 	}
 
 	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-- 
2.4.2

