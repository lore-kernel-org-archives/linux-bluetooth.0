Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 May 2015 15:52:23 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: "An, Tedd" <tedd.an@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH v2] Bluetooth: btusb: Add routine for applying Intel DDC
 parameters
Message-ID: <20150518155223.04f5fbdd@tedd-fedora-vm>
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

It opens the DDC file based on HW_VARIANT and send ID/Value with
HCI_Intel_Write_DDC command.

Format of DDC file
DDC file consists of one or more number of DDC structure that has a
'Length' field of one octet, DDC 'ID' field of two octets followed by
the array of DDC 'Value' that gives the value of parameters itself.
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
 drivers/bluetooth/btusb.c   | 70 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

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
index 13b9969..a80b8f3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2318,6 +2318,66 @@ static void btusb_intel_version_info(struct hci_dev *hdev,
 		ver->fw_build_num, ver->fw_build_ww, 2000 + ver->fw_build_yy);
 }
 
+static int btusb_apply_ddc_intel(struct hci_dev *hdev, u8 hw_var)
+{
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	char fwname[64];
+	struct sk_buff *skb;
+	int err;
+
+	snprintf(fwname, sizeof(fwname), "intel/ibt-%d.ddc", hw_var);
+
+	/* Device can work without DDC parameters so even if it fails to load
+	 * the file, no need to fail the device setup.
+	 */
+	err = request_firmware_direct(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		BT_INFO("%s: WARNING: unable to load Intel DDC file (%d)",
+			hdev->name, err);
+		return 0;
+	}
+
+	BT_INFO("%s: Intel DDC file opened: %s", hdev->name, fwname);
+
+	fw_ptr = fw->data;
+	while (fw->size > fw_ptr - fw->data) {
+		struct intel_write_ddc *wr_ddc;
+		u8 cmd_len = fw_ptr[0] + sizeof(u8);
+
+		skb = __hci_cmd_sync(hdev, 0xfc8b, cmd_len, fw_ptr,
+				     HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			BT_ERR("%s: Failed to send Intel_Write_DDC (%ld)",
+			       hdev->name, PTR_ERR(skb));
+			release_firmware(fw);
+			return PTR_ERR(skb);
+		}
+
+		wr_ddc = (struct intel_write_ddc *)skb->data;
+		if (wr_ddc->status) {
+			BT_ERR("%s: Intel write ddc command failure (%02x)",
+			       hdev->name, wr_ddc->status);
+			BT_ERR("%s: Last failed DDC ID: %04x",
+			       hdev->name, wr_ddc->failed_id);
+			err = -bt_to_errno(wr_ddc->status);
+			release_firmware(fw);
+			kfree_skb(skb);
+			return err;
+		}
+
+		fw_ptr += cmd_len;
+
+		kfree_skb(skb);
+	}
+
+	release_firmware(fw);
+
+	BT_INFO("%s: Completed to apply Intel DDC parameters", hdev->name);
+
+	return 0;
+}
+
 static int btusb_setup_intel_new(struct hci_dev *hdev)
 {
 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
@@ -2660,6 +2720,16 @@ done:
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
+	/* Once the device is running in operational mode, it needs to apply
+	 * the device configuration(DDC) parameters to the device.
+	 */
+	err = btusb_apply_ddc_intel(hdev, ver->hw_variant);
+	if (err < 0) {
+		BT_ERR("%s: Failed to apply DDC parameters (%d)",
+		       hdev->name, err);
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.1.0

