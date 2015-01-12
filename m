Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add firmware loading for Intel Snowfield Peak devices
Date: Mon, 12 Jan 2015 14:15:31 -0800
Message-Id: <1421100931-29280-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel Snowfield Peak devices do not come with Bluetooth firmware
loaded and thus require a full download of the operational Bluetooth
firmware when the device is connected via USB.

Snowfield Peak devices start with a bootloader mode that only accepts
a very limited set of HCI commands. The supported commands are enough
to identify the hardware and select the right firmware to load.

Previous patches to the btusb driver allow overwriting the handling
for bulk receive endpoint packets and HCI events processing. The
firmware loading makes heavy use of these new internal callbacks.

This patch also introduces additional internal states to track if the
device is in bootloader or operational mode. This allows for correct
feedback about the firmware loading procedure.

Output from /sys/kernel/debug/usb/devices for this device:

T:  Bus=02 Lev=02 Prnt=02 Port=05 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=0a2b Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Based-on-patch-by: Tedd Ho-Jeong An <tedd.an@intel.com>.
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 502 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 499 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4a6495ab9726..b2913867d418 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -28,7 +28,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#define VERSION "0.6"
+#define VERSION "0.7"
 
 static bool disable_scofix;
 static bool force_scofix;
@@ -50,6 +50,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BCM_PATCHRAM	0x400
 #define BTUSB_MARVELL		0x800
 #define BTUSB_SWAVE		0x1000
+#define BTUSB_INTEL_NEW		0x2000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -256,6 +257,7 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Intel Bluetooth device */
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
+	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW },
 
 	/* Marvell device */
 	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
@@ -271,6 +273,9 @@ static const struct usb_device_id blacklist_table[] = {
 #define BTUSB_ISOC_RUNNING	2
 #define BTUSB_SUSPENDING	3
 #define BTUSB_DID_ISO_RESUME	4
+#define BTUSB_BOOTLOADER	5
+#define BTUSB_DOWNLOADING	6
+#define BTUSB_FIRMWARE_FAILED	7
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1295,6 +1300,26 @@ struct intel_version {
 	u8 fw_patch_num;
 } __packed;
 
+struct intel_boot_params {
+	__u8     status;
+	__u8     otp_format;
+	__u8     otp_content;
+	__u8     otp_patch;
+	__le16   dev_revid;
+	__u8     secure_boot;
+	__u8     key_from_hdr;
+	__u8     key_type;
+	__u8     otp_lock;
+	__u8     api_lock;
+	__u8     debug_lock;
+	bdaddr_t otp_bdaddr;
+	__u8     min_fw_build_nn;
+	__u8     min_fw_build_cw;
+	__u8     min_fw_build_yy;
+	__u8     limited_cce;
+	__u8     unlocked_state;
+} __packed;
+
 static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
 						       struct intel_version *ver)
 {
@@ -1703,6 +1728,465 @@ exit_mfg_deactivate:
 	return 0;
 }
 
+static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
+{
+	struct sk_buff *skb;
+	struct hci_event_hdr *hdr;
+	struct hci_ev_cmd_complete *evt;
+
+	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (struct hci_event_hdr *)skb_put(skb, sizeof(*hdr));
+	hdr->evt = HCI_EV_CMD_COMPLETE;
+	hdr->plen = sizeof(*evt) + 1;
+
+	evt = (struct hci_ev_cmd_complete *)skb_put(skb, sizeof(*evt));
+	evt->ncmd = 0x01;
+	evt->opcode = cpu_to_le16(opcode);
+
+	*skb_put(skb, 1) = 0x00;
+
+	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+
+	return hci_recv_frame(hdev, skb);
+}
+
+static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
+				 int count)
+{
+	/* When the device is in bootloader mode, then it can send
+	 * events via the bulk endpoint. These events are treated the
+	 * same way as the ones received from the interrupt endpoint.
+	 */
+	if (test_bit(BTUSB_BOOTLOADER, &data->flags))
+		return btusb_recv_intr(data, buffer, count);
+
+	return btusb_recv_bulk(data, buffer, count);
+}
+
+static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
+		struct hci_event_hdr *hdr = (void *)skb->data;
+
+		/* When the firmware loading completes the device sends
+		 * out a vendor specific event indicating the result of
+		 * the firmware loading.
+		 */
+		if (skb->len == 7 && hdr->evt == 0xff && hdr->plen == 0x05 &&
+		    skb->data[2] == 0x06) {
+			if (skb->data[3] != 0x00)
+				test_bit(BTUSB_FIRMWARE_FAILED, &data->flags);
+
+			if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags))
+				wake_up_interruptible(&hdev->req_wait_q);
+		}
+	}
+
+	return hci_recv_frame(hdev, skb);
+}
+
+static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct urb *urb;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -EBUSY;
+
+	switch (bt_cb(skb)->pkt_type) {
+	case HCI_COMMAND_PKT:
+		if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
+			struct hci_command_hdr *cmd = (void *)skb->data;
+			__u16 opcode = le16_to_cpu(cmd->opcode);
+
+			/* When in bootloader mode and the command 0xfc09
+			 * is received, it needs to be send down the
+			 * bulk endpoint. So allocate a bulk URB instead.
+			 */
+			if (opcode == 0xfc09)
+				urb = alloc_bulk_urb(hdev, skb);
+			else
+				urb = alloc_ctrl_urb(hdev, skb);
+
+			/* When the 0xfc01 command is issued to reboot into
+			 * the operational firmware, it will actually not
+			 * send a command complete event. To keep the flow
+			 * control working inject that event here.
+			 */
+			if (opcode == 0xfc01)
+				inject_cmd_complete(hdev, opcode);
+		} else {
+			urb = alloc_ctrl_urb(hdev, skb);
+		}
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
+static int btusb_intel_secure_send(struct hci_dev *hdev, u8 fragment_type,
+				   u32 plen, const void *param)
+{
+	while (plen > 0) {
+		struct sk_buff *skb;
+		u8 cmd_param[253], fragment_len = (plen > 252) ? 252 : plen;
+
+		cmd_param[0] = fragment_type;
+		memcpy(cmd_param + 1, param, fragment_len);
+
+		skb = __hci_cmd_sync(hdev, 0xfc09, fragment_len + 1,
+				     cmd_param, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
+
+		kfree_skb(skb);
+
+		plen -= fragment_len;
+		param += fragment_len;
+	}
+
+	return 0;
+}
+
+static int btusb_setup_intel_new(struct hci_dev *hdev)
+{
+	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
+					  0x00, 0x08, 0x04, 0x00 };
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct sk_buff *skb;
+	struct intel_version *ver;
+	struct intel_boot_params *params;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	char fwname[64];
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	calltime = ktime_get();
+
+	/* Read the Intel version information to determine if the device
+	 * is in bootloader mode or if it already has operational firmware
+	 * loaded.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Reading Intel version information failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		BT_ERR("%s: Intel version event size mismatch", hdev->name);
+		kfree_skb(skb);
+		return -EILSEQ;
+	}
+
+	ver = (struct intel_version *)skb->data;
+	if (ver->status) {
+		BT_ERR("%s: Intel version command failure (%02x)",
+		       hdev->name, ver->status);
+		err = -bt_to_errno(ver->status);
+		kfree_skb(skb);
+		return err;
+	}
+
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (ver->hw_platform != 0x37) {
+		BT_ERR("%s: Unsupported Intel hardware platform (%u)",
+		       hdev->name, ver->hw_platform);
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	/* The firmware variant determines if the device is in bootloader
+	 * mode or is running operational firmware. The value 0x06 identifies
+	 * the bootloader and the value 0x23 identifies the operational
+	 * firmware.
+	 *
+	 * When the operational firmware is already present, then only
+	 * the check for valid Bluetooth device address is needed. This
+	 * determines if the device will be added as configured or
+	 * unconfigured controller.
+	 *
+	 * It is not possible to use the Secure Boot Parameters in this
+	 * case since that command is only available in bootloader mode.
+	 */
+	if (ver->fw_variant == 0x23) {
+		BT_INFO("%s: Intel firmware already loaded", hdev->name);
+		kfree_skb(skb);
+		clear_bit(BTUSB_BOOTLOADER, &data->flags);
+		btusb_check_bdaddr_intel(hdev);
+		return 0;
+	}
+
+	/* If the device is not in bootloader mode, then the only possible
+	 * choice is to return an error and abort the device initialization.
+	 */
+	if (ver->fw_variant != 0x06) {
+		BT_ERR("%s: Unsupported Intel firmware variant (%u)",
+		       hdev->name, ver->fw_variant);
+		kfree_skb(skb);
+		return -ENODEV;
+	}
+
+	/* With the Intel bootloader only the hardware variant and hardware
+	 * revision are important to select the right firmware to load. The
+	 * first attempt is to load a specific firmware that matches the
+	 * hardware variant and hardware revision.
+	 */
+	snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.sfi",
+		 ver->hw_variant, ver->hw_revision);
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		if (err != -ENOENT) {
+			BT_ERR("%s: Failed to load Intel firmware file (%d)",
+			       hdev->name, err);
+			kfree_skb(skb);
+			return err;
+		}
+
+		/* If the specific firmware is not available, look for a
+		 * generic firmware for that hardware variant.
+		 */
+		snprintf(fwname, sizeof(fwname), "intel/ibt-%u.sfi",
+			 ver->hw_variant);
+
+		err = request_firmware(&fw, fwname, &hdev->dev);
+		if (err < 0) {
+			BT_ERR("%s: Failed to load Intel firmware file (%d)",
+			       hdev->name, err);
+			kfree_skb(skb);
+			return err;
+		}
+
+		BT_INFO("%s: Found generic firmware: %s", hdev->name, fwname);
+	} else {
+		BT_INFO("%s: Found firmware: %s", hdev->name, fwname);
+	}
+
+	kfree_skb(skb);
+
+	if (fw->size < 644) {
+		BT_ERR("%s: Invalid size of firmware file (%zu)",
+		       hdev->name, fw->size);
+		err = -EBADF;
+		goto done;
+	}
+
+	/* Read the secure boot parameters to identify the operating
+	 * details of the bootloader.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc0d, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Reading Intel boot parameters failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		err = PTR_ERR(skb);
+		goto done;
+	}
+
+	if (skb->len != sizeof(*params)) {
+		BT_ERR("%s: Intel boot parameters size mismatch", hdev->name);
+		kfree_skb(skb);
+		err = -EILSEQ;
+		goto done;
+	}
+
+	params = (struct intel_boot_params *)skb->data;
+	if (params->status) {
+		BT_ERR("%s: Intel boot parameters command failure (%02x)",
+		       hdev->name, params->status);
+		err = -bt_to_errno(params->status);
+		kfree_skb(skb);
+		goto done;
+	}
+
+	/* It is required that every single firmware fragment is acknowledged
+	 * with a command complete event. If the boot parameters indicate
+	 * that this bootloader does not send them, then abort the setup.
+	 */
+	if (params->limited_cce != 0x00) {
+		BT_ERR("%s: Unsupported Intel firmware loading method (%u)",
+		       hdev->name, params->limited_cce);
+		kfree_skb(skb);
+		err = -EINVAL;
+		goto done;
+	}
+
+	BT_INFO("%s: Secure boot is %s", hdev->name,
+		params->secure_boot ? "enabled" : "disabled");
+
+	/* If the OTP has no valid Bluetooth device address, then there will
+	 * also be no valid address for the operational firmware.
+	 */
+	if (!bacmp(&params->otp_bdaddr, BDADDR_ANY))
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+
+	kfree_skb(skb);
+
+	set_bit(BTUSB_DOWNLOADING, &data->flags);
+
+	/* Start the firmware download transaction with the Init fragment
+	 * represented by the 128 bytes of CSS header.
+	 */
+	err = btusb_intel_secure_send(hdev, 0x00, 128, fw->data);
+	if (err < 0) {
+		BT_ERR("%s: Failed to send firmware header (%d)",
+		       hdev->name, err);
+		goto done;
+	}
+
+	/* Send the 256 bytes of public key information from the firmware
+	 * as the PKey fragment.
+	 */
+	err = btusb_intel_secure_send(hdev, 0x03, 256, fw->data + 128);
+	if (err < 0) {
+		BT_ERR("%s: Failed to send firmware public key (%d)",
+		       hdev->name, err);
+		goto done;
+	}
+
+	/* Send the 256 bytes of signature information from the firmware
+	 * as the Sign fragment.
+	 */
+	err = btusb_intel_secure_send(hdev, 0x02, 256, fw->data + 388);
+	if (err < 0) {
+		BT_ERR("%s: Failed to send firmware signature (%d)",
+		       hdev->name, err);
+		goto done;
+	}
+
+	fw_ptr = fw->data + 644;
+
+	while (fw_ptr - fw->data < fw->size) {
+		struct hci_command_hdr *cmd = (void *)fw_ptr;
+		u8 cmd_len;
+
+		cmd_len = sizeof(*cmd) + cmd->plen;
+
+		/* Send each command from the firmware data buffer as
+		 * a single Data fragment.
+		 */
+		err = btusb_intel_secure_send(hdev, 0x01, cmd_len, fw_ptr);
+		if (err < 0) {
+			BT_ERR("%s: Failed to send firmware data (%d)",
+			       hdev->name, err);
+			goto done;
+		}
+
+		fw_ptr += cmd_len;
+	}
+
+	/* Before switching the device into operational mode and with that
+	 * booting the loaded firmware, wait for the bootloader notification
+	 * that all fragments have been successfully received.
+	 *
+	 * When the event processing receives the notification, then this
+	 * flag will be cleared. So just in case that happens really quickly,
+	 * check it first before adding the wait queue.
+	 */
+	if (test_bit(BTUSB_DOWNLOADING, &data->flags)) {
+		DECLARE_WAITQUEUE(wait, current);
+		signed long timeout;
+
+		BT_INFO("%s: Waiting for firmware download to complete",
+			hdev->name);
+
+		add_wait_queue(&hdev->req_wait_q, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		/* The firmware loading should not take longer than 5 seconds
+		 * and thus just timeout if that happens and fail the setup
+		 * of this device.
+		 */
+		timeout = schedule_timeout(msecs_to_jiffies(5000));
+
+		remove_wait_queue(&hdev->req_wait_q, &wait);
+
+		if (signal_pending(current)) {
+			BT_ERR("%s: Firmware loading interrupted", hdev->name);
+			err = -EINTR;
+			goto done;
+		}
+
+		if (!timeout) {
+			BT_ERR("%s: Firmware loading timeout", hdev->name);
+			err = -ETIMEDOUT;
+			goto done;
+		}
+	}
+
+	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
+		BT_ERR("%s: Firmware loading failed", hdev->name);
+		err = -ENOEXEC;
+		goto done;
+	}
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+
+	BT_INFO("%s: Firmware loaded in %llu usecs", hdev->name, duration);
+
+done:
+	release_firmware(fw);
+
+	if (err < 0)
+		return err;
+
+	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+
+	/* The bootloader and the operational firmware do not indicate when
+	 * the device is ready. So wait for 200 msecs before allowing the
+	 * initialization procedure to continue.
+	 */
+	msleep(200);
+
+	clear_bit(BTUSB_BOOTLOADER, &data->flags);
+
+	return 0;
+}
+
 static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
 	struct sk_buff *skb;
@@ -2049,8 +2533,14 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->isoc_anchor);
 	spin_lock_init(&data->rxlock);
 
-	data->recv_event = hci_recv_frame;
-	data->recv_bulk = btusb_recv_bulk;
+	if (id->driver_info & BTUSB_INTEL_NEW) {
+		data->recv_event = btusb_recv_event_intel;
+		data->recv_bulk = btusb_recv_bulk_intel;
+		set_bit(BTUSB_BOOTLOADER, &data->flags);
+	} else {
+		data->recv_event = hci_recv_frame;
+		data->recv_bulk = btusb_recv_bulk;
+	}
 
 	hdev = hci_alloc_dev();
 	if (!hdev)
@@ -2083,6 +2573,12 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
 	}
 
+	if (id->driver_info & BTUSB_INTEL_NEW) {
+		hdev->send = btusb_send_frame_intel;
+		hdev->setup = btusb_setup_intel_new;
+		hdev->set_bdaddr = btusb_set_bdaddr_intel;
+	}
+
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
-- 
2.1.0

