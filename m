Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Dec 2014 17:09:33 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "An, Tedd" <tedd.an@intel.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC 3/3] Bluetooth: Add support Intel Bluetooth bootloader device
Message-ID: <20141203170933.2fcdf269@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch add support for Intel Bluetooth device with bootloader.

The flow of firmware downloading is similar to previous Intel setup routine.
But it uses bulk ep to send the command and receive the event for faster
download during setup stage. So, for Intel_Sec_Send command, it is sent to
bulk ep even if the format of the command is HCI command pcaket.
Also, the correspond event is recevied from bulk ep in the format of HCI event
packet and it is rerouted to interrupt receive handler.

This is allowed only during the setup stage and once downloading is completed,
bulk handlers will set back to the original routines.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c | 384 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 384 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0fa1c13..40dc1fc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -49,6 +49,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_BOOT	0x200
 #define BTUSB_BCM_PATCHRAM	0x400
 #define BTUSB_MARVELL		0x800
+#define BTUSB_INTEL_BOOT2	0x1000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -251,6 +252,7 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Intel Bluetooth device */
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
+	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_BOOT2 },
 
 	/* Marvell device */
 	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
@@ -1516,6 +1518,68 @@ static int btusb_setup_intel_read_fw_ver(struct hci_dev *hdev,
 	return 0;
 }
 
+int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer, int count)
+{
+	/*
+	 * During the setup, the CC event for Intel_Sec_Send command will come
+	 * via bulk ep in the format of HCI event. So, it needs to be routed to
+	 * interrupt receiver to process it as HCI event.
+	 *
+	 * This is only done during the setup, firmware downloading.
+	 */
+	return btusb_recv_intr(data, buffer, count);
+}
+
+/*
+ * This is basically a duplicate of btusb_send_frame function except handling
+ * Intel_Sec_Send command. If Intel_Sec_Send command is sent by host to device
+ * as HCI command, it will be sent to bulk ep instead of control ep.
+ */
+static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct urb *urb;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -EBUSY;
+
+	switch (bt_cb(skb)->pkt_type) {
+	case HCI_COMMAND_PKT:
+		/* Only 0xFC09 Intel_Sec_Send command will send via bulk ep */
+		if (bt_cb(skb)->opcode == 0xfc09)
+			urb = alloc_bulk_urb(hdev, skb);
+		else
+			urb = alloc_ctrl_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(urb);
+
+		hdev->stat.cmd_tx++;
+		return submit_or_queue_tx_urb(hdev, urb);
+
+	case HCI_ACLDATA_PKT:
+		urb = alloc_bulk_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(urb);
+
+		hdev->stat.acl_tx++;
+		return submit_or_queue_tx_urb(hdev, urb);
+
+	case HCI_SCODATA_PKT:
+		if (hci_conn_num(hdev, SCO_LINK) < 1)
+			return -ENODEV;
+
+		urb = alloc_isoc_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(urb);
+
+		hdev->stat.sco_tx++;
+		return submit_tx_urb(hdev, urb);
+	}
+
+	return -EILSEQ;
+}
+
 static int btusb_setup_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -1707,6 +1771,323 @@ exit_mfg_deactivate:
 	return 0;
 }
 
+#define INTEL_OP_SEC_SEND		0xfc09
+#define INTEL_SEC_SEND_INIT		0x00
+#define INTEL_SEC_SEND_FRAG_DATA	0x01
+#define INTEL_SEC_SEND_FRAG_SIGN	0x02
+#define INTEL_SEC_SEND_FRAG_PKEY	0x03
+#define HCI_MAX_CMD_SIZE		260
+
+static int btusb_setup_intel_sec_send_section(struct hci_dev *hdev, u8 type,
+					      int read_len, const u8 *fw_ptr)
+{
+	struct sk_buff *skb;
+	u8 cmd_param[HCI_MAX_CMD_SIZE];
+
+	cmd_param[0] = type;
+	memcpy(&cmd_param[1], fw_ptr, read_len);
+	skb = __hci_cmd_sync(hdev, INTEL_OP_SEC_SEND, read_len + 1, cmd_param,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: sending INTEL_SEC_SEND failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->data[0]) {
+		BT_ERR("%s: INTEL_SEC_SEND command failed (0x%2.2x)",
+		       hdev->name, skb->data[0]);
+		kfree_skb(skb);
+		return -bt_to_errno(skb->data[0]);
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
+/*
+ * There are 4 sections(INIT, PKEY, SIGN, DATA) in the sfi file.
+ * Each section has a fixed length except DATA section.
+ *    - INIT: 128 bytes
+ *    - PKEY: 256 bytes + 4 bytes
+ *    - SIGN: 256 bytes
+ *    - DATA: varies
+ *
+ * The data in each section must be encapsulated by Intel_Sec_Send command in
+ * order to download. The first parameter of Intel_Sec_Send command indicates
+ * the section as follow:
+ *    - 00: INIT
+ *    - 01: DATA
+ *    - 02: SIGN
+ *    - 03: PKEY
+ */
+static int btusb_setup_intel_sec_patching(struct hci_dev *hdev,
+					  const struct firmware *fw)
+{
+	int ret;
+	struct hci_command_hdr *hdr;
+	const u8 *fw_ptr;
+	int read_len;
+	size_t remain;
+
+
+	fw_ptr = fw->data;
+	remain = fw->size;
+
+	/*
+	 * INIT section
+	 */
+	read_len = 128;
+	ret = btusb_setup_intel_sec_send_section(hdev, INTEL_SEC_SEND_INIT,
+						 read_len, fw_ptr);
+	if (ret < 0) {
+		BT_ERR("%s: sending INIT section failed", hdev->name);
+		return ret;
+	}
+
+	fw_ptr += read_len;
+	remain -= read_len;
+
+	/*
+	 * PKEY Section
+	 * The length of PKEY is 256 bytes which doesn't fit in 1 HCI command.
+	 * It needs to be split into two HCI commands and each data must be
+	 * the multiplication of 4 for alignment in the device.
+	 * So, the PKEY will be split into 252 and 4 bytes for each command.
+	 */
+
+	/* PKEY 1 */
+	read_len = 252;
+	ret = btusb_setup_intel_sec_send_section(hdev, INTEL_SEC_SEND_FRAG_PKEY,
+						 read_len, fw_ptr);
+	if (ret < 0) {
+		BT_ERR("%s: sending PKEY1 section failed", hdev->name);
+		return ret;
+	}
+
+	fw_ptr += read_len;
+	remain -= read_len;
+
+	/* PKEY 2 */
+	read_len = 4;
+	ret = btusb_setup_intel_sec_send_section(hdev, INTEL_SEC_SEND_FRAG_PKEY,
+						 read_len, fw_ptr);
+	if (ret < 0) {
+		BT_ERR("%s: sending PKEY2 section failed", hdev->name);
+		return ret;
+	}
+
+	fw_ptr += read_len;
+	remain -= read_len;
+
+	/* There is 4 bytes of module value but no needs to download */
+	fw_ptr += 4;
+	remain -= 4;
+
+	/*
+	 * SIGN Section
+	 * The length of SIGN is 256 bytes which doesn't fit in 1 HCI command.
+	 * It needs to be split into two HCI commands and each data must be
+	 * the multiplication of 4 for alignment in the device.
+	 * So, the SIGN will be split into 252 and 4 bytes for each command.
+	 */
+	/* SIGN 1 */
+	read_len = 252;
+	ret = btusb_setup_intel_sec_send_section(hdev, INTEL_SEC_SEND_FRAG_SIGN,
+						 read_len, fw_ptr);
+	if (ret < 0) {
+		BT_ERR("%s: sending SIGN1 section failed", hdev->name);
+		return ret;
+	}
+
+	fw_ptr += read_len;
+	remain -= read_len;
+
+	/* SIGN 2 */
+	read_len = 4;
+	ret = btusb_setup_intel_sec_send_section(hdev, INTEL_SEC_SEND_FRAG_SIGN,
+						 read_len, fw_ptr);
+	if (ret < 0) {
+		BT_ERR("%s: sending SIGN2 section failed", hdev->name);
+		return ret;
+	}
+
+	fw_ptr += read_len;
+	remain -= read_len;
+
+	/*
+	 * DATA Section
+	 * This section consists of number of HCI commands which needs to be
+	 * encapsulated by INTEL_SEC_SEND command.
+	 */
+	/* DATA */
+	while (remain > 0) {
+		hdr = (struct hci_command_hdr *)fw_ptr;
+
+		if (remain < 255)
+			read_len = remain;
+		else
+			read_len = hdr->plen + sizeof(*hdr);
+
+		ret = btusb_setup_intel_sec_send_section(hdev,
+				INTEL_SEC_SEND_FRAG_DATA, read_len, fw_ptr);
+		if (ret < 0) {
+			BT_ERR("%s: sending DATA section failed", hdev->name);
+			return ret;
+		}
+
+		fw_ptr += read_len;
+		remain -= read_len;
+	}
+
+	return 0;
+}
+
+/*
+ * Send Intel Reset command to the device to enable the operational firmware.
+ * Because the device will not send CC event for Intel Reset command,
+ * the command is sent with btusb_send_frame() instead of __hci_cmd_sync() so
+ * the host won't wait for event.
+ */
+static int btusb_setup_intel_send_reset(struct hci_dev *hdev)
+{
+	int ret;
+	int len, plen;
+	struct hci_command_hdr *hdr;
+	struct sk_buff *skb;
+
+	u8 intel_reset[] = { 0x00, 0x00, 0x00, 0x01, 0x00, 0x08, 0x04, 0x00 };
+
+	plen = sizeof(intel_reset);
+
+	len = HCI_COMMAND_HDR_SIZE + plen;
+	skb = bt_skb_alloc(len, GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("%s: failed to allocate sk_buff", hdev->name);
+		return -ENOMEM;
+	}
+
+	hdr = (struct hci_command_hdr *) skb_put(skb, HCI_COMMAND_HDR_SIZE);
+	hdr->opcode = cpu_to_le16(0xfc01);
+	hdr->plen   = plen;
+
+	memcpy(skb_put(skb, plen), intel_reset, plen);
+
+	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+	bt_cb(skb)->opcode = 0xfc01;
+
+	ret = btusb_send_frame(hdev, skb);
+	if (ret < 0) {
+		BT_ERR("%s: sending Intel Reset failed (%d)", hdev->name, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int btusb_setup_intel_boot2(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct intel_version ver;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	/*
+	 * During the setup, the specific HCI command (INTE_SEC_SEND) and its
+	 * correspond event are sending/receiving via bulk endpoint instead of
+	 * control ep and interrupt in order to improve the FW downlaoding
+	 * speed. So, it sending and receiving routines needs to be set to
+	 * custom ones during this time and it will set back to generic ones
+	 * after.
+	 */
+	hdev->send = btusb_send_frame_intel;
+	data->recv_bulk = btusb_recv_bulk_intel;
+
+	/* Intel Read Version */
+	err = btusb_setup_intel_read_fw_ver(hdev, &ver);
+	if (err < 0) {
+		BT_ERR("%s: reading Inte FW version failed (%d)",
+		       hdev->name, err);
+		goto exit_error;
+	}
+
+	BT_INFO("%s: Intel FW version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
+		hdev->name, ver.hw_platform, ver.hw_variant, ver.hw_revision,
+		ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
+		ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);
+
+	/*
+	 * fw_variant indicates whether the device is running on bootloader
+	 * mode(0x06) or operational mode (0x23). If the device is running
+	 * with operational mode, no need to download the fw.
+	 */
+	if (ver.fw_variant == 0x23) {
+		BT_INFO("%s: Intel BT is Operational. skipping FW downloading",
+			hdev->name);
+		goto exit_error;
+	}
+
+	/* Opens the firmware patch file based on the firmware version. */
+	fw = btusb_setup_intel_get_fw(hdev, &ver, "sfi");
+	if (!fw) {
+		BT_ERR("%s: opening Intel FW failed", hdev->name);
+		goto exit_error;
+	}
+	fw_ptr = fw->data;
+
+	/* Start to download the firmware */
+	err = btusb_setup_intel_sec_patching(hdev, fw);
+	if (err < 0) {
+		BT_ERR("%s: downloading firmware failed (%d)", hdev->name, err);
+		goto exit_release;
+	}
+
+	/* Send Intel Reset to enable the downloaded operational firmware */
+	err = btusb_setup_intel_send_reset(hdev);
+	if (err < 0) {
+		BT_ERR("%s: sending Intel Reset failed (%d)", hdev->name, err);
+		goto exit_release;
+	}
+
+	BT_INFO("%s: Intel firmware downloading is completed", hdev->name);
+
+exit_release:
+	release_firmware(fw);
+
+	/* extra time after resetting the device */
+	msleep(200);
+
+	/*
+	 * Once the device is running with operational firmware, send device
+	 * specific configuration parameter with legacy way.
+	 */
+	err = btusb_setup_intel(hdev);
+	if (err < 0) {
+		BT_ERR("%s: configuring Intel BT device failed (%d)",
+		       hdev->name, err);
+		goto exit_error;
+	}
+
+	BT_INFO("%s: Intel Bluetooth device configuration is completed",
+		hdev->name);
+
+exit_error:
+	/*
+	 * After this point, All events will come from interrupt endpoint.
+	 * So, put back the bulk_recv routine to generic one
+	 */
+	BT_INFO("%s: Reset the send and receive routines", hdev->name);
+
+	data->recv_bulk = btusb_recv_bulk;
+	hdev->send = btusb_send_frame;
+
+	return err;
+}
+
+
 static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
 	struct sk_buff *skb;
@@ -2061,6 +2442,9 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
 	}
 
+	if (id->driver_info & BTUSB_INTEL_BOOT2)
+		hdev->setup = btusb_setup_intel_boot2;
+
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
-- 
1.9.1

