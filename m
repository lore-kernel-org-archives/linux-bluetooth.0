Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Jun 2015 16:20:05 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>
Cc: "An, Tedd" <tedd.an@intel.com>
Subject: [PATCH v5] Bluetooth: btusb: Add routine for applying Intel DDC
 parameters
Message-ID: <20150612162005.75849a3b@tedd-fedora-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds the routine to apply the DDC parameter from device
specific ddc file.

Once the device is rest to operational mode, optionally, it can
download the device specific configration (DDC) parameters before
the BlueZ starts the stack initialization.

It opens the DDC file based on HW_VARIANT and DEV_REVISION and
send ID/Value with HCI_Intel_Write_DDC command.

Format of DDC file
DDC file contains one or more number of DDC structure.

DDC Structure
It has 'Length' field of one octet, DDC 'ID' field of
two octets followed by the array of DDC 'Value' that gives
the value of parameters itself.
'Length' contains the length of DDC 'ID' and DDC 'Value'.

+------------+----------+
| Size(byte) |    Name  |
+------------+----------+
|      1     | Length   |
+------------+----------+
|      2     | ID       |
+------------+----------+
| Length - 2 | Value    |
+------------+----------+

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e97d036..3a526f1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2083,6 +2083,12 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	BT_INFO("%s: Found device firmware: %s", hdev->name, fwname);
 
+	/* Save the DDC file name for later use to apply once the firmware
+	 * downloadindg is done
+	 */
+	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.ddc",
+		 le16_to_cpu(params->dev_revid));
+
 	kfree_skb(skb);
 
 	if (fw->size < 644) {
@@ -2244,6 +2250,42 @@ done:
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
+	/* Once the device is running in operational mode, it needs to apply
+	 * the device configuration(DDC) parameters to the device.
+	 * Device can work without DDC parameters so even if it fails to load
+	 * the file, no need to fail the setup.
+	 */
+	err = request_firmware_direct(&fw, fwname, &hdev->dev);
+	if (err < 0)
+		return 0;
+
+	BT_INFO("%s: Intel DDC file opened: %s", hdev->name, fwname);
+
+	fw_ptr = fw->data;
+
+	/* DDC file contains one or more DDC structure which has
+	 * Length (1 byte), DDC ID (2 bytes), and DDC value (Length - 2)
+	 */
+	while (fw->size > fw_ptr - fw->data) {
+		u8 cmd_plen = fw_ptr[0] + sizeof(u8);
+
+		skb = __hci_cmd_sync(hdev, 0xfc8b, cmd_plen, fw_ptr,
+				     HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			BT_ERR("%s: Failed to send Intel_Write_DDC (%ld)",
+			       hdev->name, PTR_ERR(skb));
+			release_firmware(fw);
+			return PTR_ERR(skb);
+		}
+
+		fw_ptr += cmd_plen;
+		kfree_skb(skb);
+	}
+
+	release_firmware(fw);
+
+	BT_INFO("%s: Completed to apply Intel DDC parameters", hdev->name);
+
 	return 0;
 }
 
-- 
2.1.0
