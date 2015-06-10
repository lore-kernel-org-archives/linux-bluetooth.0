Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Jun 2015 15:01:56 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "An, Tedd" <tedd.an@intel.com>
Subject: [PATCH v4] Bluetooth: btusb: Add routine for applying Intel DDC
 parameters
Message-ID: <20150610150156.7522ed3f@tedd-fedora-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
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
DDC file consists of one or more number of HCI_Intel_Write_DDC
command that contains the DDC structure in parameter.

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

In case of command failure, it returns the command complete with
parameter that contains the ID that failed to apply.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.h |  5 ++++
 drivers/bluetooth/btusb.c   | 63 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 4bda6ab..affb216 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -69,6 +69,11 @@ struct intel_secure_send_result {
 	__u8     status;
 } __packed;
 
+struct intel_write_ddc {
+	__u8	status;
+	__le16	failed_id;
+} __packed;
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e97d036..66002d7d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1936,6 +1936,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	char fwname[64];
 	ktime_t calltime, delta, rettime;
 	unsigned long long duration;
+	u8 dev_revid;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2083,6 +2084,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	BT_INFO("%s: Found device firmware: %s", hdev->name, fwname);
 
+	/* Keep Device Revision to use later for DDC */
+	dev_revid = le16_to_cpu(params->dev_revid);
+
 	kfree_skb(skb);
 
 	if (fw->size < 644) {
@@ -2244,7 +2248,66 @@ done:
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
+	/* Once the device is running in operational mode, it needs to apply
+	 * the device configuration(DDC) parameters to the device.
+	 */
+	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.ddc", dev_revid);
+
+	/* Device can work without DDC parameters so even if it fails to load
+	 * the file, no need to fail the setup.
+	 */
+	err = request_firmware_direct(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		BT_ERR("failed to open the ddc file: %s", fwname);
+		return 0;
+	}
+
+	BT_INFO("%s: Intel DDC file opened: %s", hdev->name, fwname);
+
+	fw_ptr = fw->data;
+
+	/* DDC file contains DDC parameters in HCI Command format. */
+	while (fw->size > fw_ptr - fw->data) {
+		struct hci_command_hdr *cmd;
+		struct intel_write_ddc *wr_ddc;
+
+		cmd = (struct hci_command_hdr *)fw_ptr;
+		fw_ptr += sizeof(*cmd);
+
+		skb = __hci_cmd_sync(hdev, le16_to_cpu(cmd->opcode), cmd->plen,
+				     fw_ptr, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			BT_ERR("%s: Failed to send Intel_Write_DDC (%ld)",
+			       hdev->name, PTR_ERR(skb));
+			err = PTR_ERR(skb);
+			goto exit_error_ddc;
+		}
+
+		/* If the command fails, it needs to display the event param
+		 * that contains the last failed DDC ID
+		 */
+		wr_ddc = (struct intel_write_ddc *)skb->data;
+		if (wr_ddc->status) {
+			BT_ERR("%s: Last failed DDC ID: 0x%04x",
+			       hdev->name, wr_ddc->failed_id);
+			err = -bt_to_errno(wr_ddc->status);
+			kfree_skb(skb);
+			goto exit_error_ddc;
+		}
+
+		fw_ptr += cmd->plen;
+		kfree_skb(skb);
+	}
+	release_firmware(fw);
+
+	BT_INFO("%s: Completed to apply Intel DDC parameters", hdev->name);
+
 	return 0;
+
+exit_error_ddc:
+	release_firmware(fw);
+
+	return err;
 }
 
 static void btusb_hw_error_intel(struct hci_dev *hdev, u8 code)
-- 
2.1.0

