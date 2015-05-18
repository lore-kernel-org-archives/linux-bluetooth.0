Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 May 2015 15:52:07 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, "An, Tedd" <tedd.an@intel.com>
Subject: [PATCH v2] Bluetooth: btusb: fixed command length alignment on
 Intel 8260
Message-ID: <20150518155207.31ce2835@tedd-fedora-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

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
09 FC 0B 8E FC 03 11 22 33 02 FC 03 00 00 00

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d21f3b4..13b9969 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2541,6 +2541,22 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 		cmd_len = sizeof(*cmd) + cmd->plen;
 
+		/* The parameter length of secure send command should be a
+		 * multiplication of 4. If it is not, it needs to append
+		 * Intel_NOP command with arbitrary number of parameters (zeros)
+		 * to meet the 4 byte alignment.
+		 * The FW file has already formatted with this. So if the next
+		 * command is Intel_NOP then send them together.
+		 */
+		cmd = (void *)(fw_ptr + cmd_len);
+		if (le16_to_cpu(cmd->opcode) == 0xfc02) {
+			BT_DBG("%s: Updated cmd to include Intel_NOP",
+			       hdev->name);
+			/* Update cmd_len to include the Intel_NOP command
+			 */
+			cmd_len += sizeof(*cmd) + cmd->plen;
+		}
+
 		/* Send each command from the firmware data buffer as
 		 * a single Data fragment.
 		 */
-- 
2.1.0
