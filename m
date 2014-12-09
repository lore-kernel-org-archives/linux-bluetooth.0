Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RFC v2 4/4] Bluetooth: Add support Intel Bluetooth bootloader device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20141208152500.6fef57ae@tedd-test>
Date: Tue, 9 Dec 2014 07:11:25 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <91440EF0-0729-4962-AFC6-56E322B48183@holtmann.org>
References: <20141208152500.6fef57ae@tedd-test>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch add support for Intel Bluetooth device with bootloader.
> 
> The flow of firmware downloading is similar to previous Intel setup routine.
> But it uses bulk ep to send the command and receive the event for faster
> download during setup stage. So, for Intel_Sec_Send command, it is sent to
> bulk ep even if the format of the command is HCI command pcaket.
> Also, the correspond event is recevied from bulk ep in the format of HCI event
> packet and it is rerouted to interrupt receive handler.
> 
> This is allowed only during the setup stage and once downloading is completed,
> bulk handlers will set back to the original routines.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c | 356 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 356 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 0c6eb333..95c140c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -49,6 +49,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_INTEL_BOOT	0x200
> #define BTUSB_BCM_PATCHRAM	0x400
> #define BTUSB_MARVELL		0x800
> +#define BTUSB_INTEL_BOOT2	0x1000
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -251,6 +252,7 @@ static const struct usb_device_id blacklist_table[] = {
> 	/* Intel Bluetooth device */
> 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
> 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
> +	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_BOOT2 },
> 
> 	/* Marvell device */
> 	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
> @@ -1565,6 +1567,68 @@ static int btusb_setup_intel_patching(struct hci_dev *hdev,
> 	return 0;
> }
> 
> +int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer, int count)
> +{
> +	/*
> +	 * During the setup, the CC event for Intel_Sec_Send command will come
> +	 * via bulk ep in the format of HCI event. So, it needs to be routed to
> +	 * interrupt receiver to process it as HCI event.
> +	 *
> +	 * This is only done during the setup, firmware downloading.
> +	 */
> +	return btusb_recv_intr(data, buffer, count);
> +}
> +
> +/*
> + * This is basically a duplicate of btusb_send_frame function except handling
> + * Intel_Sec_Send command. If Intel_Sec_Send command is sent by host to device
> + * as HCI command, it will be sent to bulk ep instead of control ep.
> + */

please use proper comment style for the network subsystem. This needs fixing all the way through the patch btw.

> +static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct urb *urb;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	if (!test_bit(HCI_RUNNING, &hdev->flags))
> +		return -EBUSY;
> +
> +	switch (bt_cb(skb)->pkt_type) {
> +	case HCI_COMMAND_PKT:
> +		/* Only 0xFC09 Intel_Sec_Send command will send via bulk ep */
> +		if (bt_cb(skb)->opcode == 0xfc09)
> +			urb = alloc_bulk_urb(hdev, skb);
> +		else
> +			urb = alloc_ctrl_urb(hdev, skb);
> +		if (IS_ERR(urb))
> +			return PTR_ERR(urb);
> +
> +		hdev->stat.cmd_tx++;
> +		return submit_or_queue_tx_urb(hdev, urb);
> +
> +	case HCI_ACLDATA_PKT:
> +		urb = alloc_bulk_urb(hdev, skb);
> +		if (IS_ERR(urb))
> +			return PTR_ERR(urb);
> +
> +		hdev->stat.acl_tx++;
> +		return submit_or_queue_tx_urb(hdev, urb);
> +
> +	case HCI_SCODATA_PKT:
> +		if (hci_conn_num(hdev, SCO_LINK) < 1)
> +			return -ENODEV;
> +
> +		urb = alloc_isoc_urb(hdev, skb);
> +		if (IS_ERR(urb))
> +			return PTR_ERR(urb);
> +
> +		hdev->stat.sco_tx++;
> +		return submit_tx_urb(hdev, urb);
> +	}
> +
> +	return -EILSEQ;
> +}
> +
> static int btusb_setup_intel(struct hci_dev *hdev)
> {
> 	struct sk_buff *skb;
> @@ -1725,6 +1789,295 @@ exit_mfg_deactivate:
> 	return 0;
> }
> 
> +#define INTEL_OP_SEC_SEND		0xfc09
> +#define INTEL_SEC_SEND_INIT		0x00
> +#define INTEL_SEC_SEND_FRAG_DATA	0x01
> +#define INTEL_SEC_SEND_FRAG_SIGN	0x02
> +#define INTEL_SEC_SEND_FRAG_PKEY	0x03
> +#define HCI_MAX_CMD_SIZE		260
> +
> +static int btusb_setup_intel_sec_send_section(struct hci_dev *hdev, u8 type,
> +					      int read_len, const u8 *fw_ptr)
> +{

Shortening this to btusb_setup_intel_sec_send might be a good idea.

> +	struct sk_buff *skb;
> +	u8 cmd_param[HCI_MAX_CMD_SIZE];
> +
> +	cmd_param[0] = type;
> +	memcpy(&cmd_param[1], fw_ptr, read_len);

So I prefer cmd_param + 1 here.

And you might want to have a length check here to make sure this is not overflowing. Since I assume the data comes from userspace, it needs to be validated.

> +	skb = __hci_cmd_sync(hdev, INTEL_OP_SEC_SEND, read_len + 1, cmd_param,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: sending INTEL_SEC_SEND failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->data[0]) {
> +		BT_ERR("%s: INTEL_SEC_SEND command failed (0x%2.2x)",
> +		       hdev->name, skb->data[0]);
> +		kfree_skb(skb);
> +		return -bt_to_errno(skb->data[0]);
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> +/*
> + * There are 4 sections(INIT, PKEY, SIGN, DATA) in the sfi file.
> + * Each section has a fixed length except DATA section.
> + *    - INIT: 128 bytes
> + *    - PKEY: 256 bytes + 4 bytes
> + *    - SIGN: 256 bytes
> + *    - DATA: varies
> + *
> + * The data in each section must be encapsulated by Intel_Sec_Send command in
> + * order to download. The first parameter of Intel_Sec_Send command indicates
> + * the section as follow:
> + *    - 00: INIT
> + *    - 01: DATA
> + *    - 02: SIGN
> + *    - 03: PKEY
> + */
> +static int btusb_setup_intel_sec_patching(struct hci_dev *hdev,
> +					  const struct firmware *fw)
> +{
> +	int ret;
> +	struct hci_command_hdr *hdr;
> +	const u8 *fw_ptr;
> +	int read_len;
> +	size_t remain;
> +
> +
> +	fw_ptr = fw->data;
> +	remain = fw->size;
> +
> +	/*
> +	 * INIT section
> +	 */
> +	read_len = 128;
> +	ret = btusb_setup_intel_sec_send_section(hdev, INTEL_SEC_SEND_INIT,
> +						 read_len, fw_ptr);
> +	if (ret < 0) {
> +		BT_ERR("%s: sending INIT section failed", hdev->name);
> +		return ret;
> +	}
> +
> +	fw_ptr += read_len;
> +	remain -= read_len;
> +
> +	/*
> +	 * PKEY Section
> +	 * The length of PKEY is 256 bytes which doesn't fit in 1 HCI command.
> +	 * It needs to be split into two HCI commands and each data must be
> +	 * the multiplication of 4 for alignment in the device.
> +	 * So, the PKEY will be split into 252 and 4 bytes for each command.
> +	 */
> +
> +	/* PKEY 1 */
> +	read_len = 252;
> +	ret = btusb_setup_intel_sec_send_section(hdev, INTEL_SEC_SEND_FRAG_PKEY,
> +						 read_len, fw_ptr);
> +	if (ret < 0) {
> +		BT_ERR("%s: sending PKEY1 section failed", hdev->name);
> +		return ret;
> +	}
> +
> +	fw_ptr += read_len;
> +	remain -= read_len;
> +
> +	/* PKEY 2 */
> +	read_len = 4;
> +	ret = btusb_setup_intel_sec_send_section(hdev, INTEL_SEC_SEND_FRAG_PKEY,
> +						 read_len, fw_ptr);
> +	if (ret < 0) {
> +		BT_ERR("%s: sending PKEY2 section failed", hdev->name);
> +		return ret;
> +	}
> +
> +	fw_ptr += read_len;
> +	remain -= read_len;
> +
> +	/* There is 4 bytes of module value but no needs to download */
> +	fw_ptr += 4;
> +	remain -= 4;
> +
> +	/*
> +	 * SIGN Section
> +	 * The length of SIGN is 256 bytes which doesn't fit in 1 HCI command.
> +	 * It needs to be split into two HCI commands and each data must be
> +	 * the multiplication of 4 for alignment in the device.
> +	 * So, the SIGN will be split into 252 and 4 bytes for each command.
> +	 */
> +	/* SIGN 1 */
> +	read_len = 252;
> +	ret = btusb_setup_intel_sec_send_section(hdev, INTEL_SEC_SEND_FRAG_SIGN,
> +						 read_len, fw_ptr);
> +	if (ret < 0) {
> +		BT_ERR("%s: sending SIGN1 section failed", hdev->name);
> +		return ret;
> +	}
> +
> +	fw_ptr += read_len;
> +	remain -= read_len;
> +
> +	/* SIGN 2 */
> +	read_len = 4;
> +	ret = btusb_setup_intel_sec_send_section(hdev, INTEL_SEC_SEND_FRAG_SIGN,
> +						 read_len, fw_ptr);
> +	if (ret < 0) {
> +		BT_ERR("%s: sending SIGN2 section failed", hdev->name);
> +		return ret;
> +	}
> +
> +	fw_ptr += read_len;
> +	remain -= read_len;

I think what we really want is that btusb_setup_sec_send handles the fragmentation of each section for us. You are repeating yourself here and it is not even consistent. In one case you use the constant 4 and in the other read_le that you previously had set to 4.

So lets make btusb_send_sec_send handle section size of whatever length. Then you can also remove the extra comments of what part currently gets programmed.

> +
> +	/*
> +	 * DATA Section
> +	 * This section consists of number of HCI commands which needs to be
> +	 * encapsulated by INTEL_SEC_SEND command.
> +	 */
> +	/* DATA */
> +	while (remain > 0) {
> +		hdr = (struct hci_command_hdr *)fw_ptr;
> +
> +		if (remain < 255)
> +			read_len = remain;
> +		else
> +			read_len = hdr->plen + sizeof(*hdr);
> +
> +		ret = btusb_setup_intel_sec_send_section(hdev,
> +				INTEL_SEC_SEND_FRAG_DATA, read_len, fw_ptr);

You need to keep the coding style.

> +		if (ret < 0) {
> +			BT_ERR("%s: sending DATA section failed", hdev->name);
> +			return ret;
> +		}
> +
> +		fw_ptr += read_len;
> +		remain -= read_len;
> +	}

And here you already have the fragmentation as a more generic approach. As I said, lets put that all into btusb_setup_intel_send_sec. Then this becomes nice and simple code.

I even get the feeling that btusb_setup_intel_sec_patching can then be removed and the handling of the 4 sections folded into btusb_setup_intel_boot2 directly.

> +
> +	return 0;
> +}
> +
> +/*
> + * Send Intel Reset command to the device to enable the operational firmware.
> + * Because the device will not send CC event for Intel Reset command,
> + * the command is sent with btusb_send_frame() instead of __hci_cmd_sync() so
> + * the host won't wait for event.
> + */

Why :(

These are the things that does frustrate me sometimes. Is it too much to ask from the bootloader to acknowledge that it received the command and only then go and reset everything in the device.

I mean you start using a well defined transport protocol and then you start violating it whenever you please because it is some tiny shortcut. It means that the host stack now has to do extra work and we can never tell when the device actually does a reset or if something fails. I mean how would we know if some of the firmware verification fails?

> +static int btusb_setup_intel_send_reset(struct hci_dev *hdev)
> +{
> +	int ret;

Use int err and normally we have these last in the variable list.

> +	int len, plen;
> +	struct hci_command_hdr *hdr;
> +	struct sk_buff *skb;
> +
> +	u8 intel_reset[] = { 0x00, 0x00, 0x00, 0x01, 0x00, 0x08, 0x04, 0x00 };

Make these const at least.

> +
> +	plen = sizeof(intel_reset);
> +
> +	len = HCI_COMMAND_HDR_SIZE + plen;
> +	skb = bt_skb_alloc(len, GFP_ATOMIC);
> +	if (!skb) {
> +		BT_ERR("%s: failed to allocate sk_buff", hdev->name);
> +		return -ENOMEM;
> +	}
> +
> +	hdr = (struct hci_command_hdr *) skb_put(skb, HCI_COMMAND_HDR_SIZE);
> +	hdr->opcode = cpu_to_le16(0xfc01);
> +	hdr->plen   = plen;
> +
> +	memcpy(skb_put(skb, plen), intel_reset, plen);
> +
> +	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
> +	bt_cb(skb)->opcode = 0xfc01;
> +
> +	ret = btusb_send_frame(hdev, skb);
> +	if (ret < 0) {
> +		BT_ERR("%s: sending Intel Reset failed (%d)", hdev->name, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int btusb_setup_intel_boot2(struct hci_dev *hdev)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	const struct firmware *fw;
> +	int err;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	/*
> +	 * During the setup, the specific HCI command (INTE_SEC_SEND) and its
> +	 * correspond event are sending/receiving via bulk endpoint instead of
> +	 * control ep and interrupt in order to improve the FW downlaoding
> +	 * speed. So, it sending and receiving routines needs to be set to
> +	 * custom ones during this time and it will set back to generic ones
> +	 * after.
> +	 */
> +	hdev->send = btusb_send_frame_intel;
> +	data->recv_bulk = btusb_recv_bulk_intel;

I actually prefer that we do not mess with these pointers in a registered device. These should be set in the probe function and then stay there.

> +
> +	fw = btusb_setup_intel_get_fw(hdev, INTEL_FW_MODE_BL);
> +	if (!fw) {
> +		err = 0;
> +		goto exit_error;
> +	}
> +
> +	/* Start to download the firmware */
> +	err = btusb_setup_intel_sec_patching(hdev, fw);
> +	if (err < 0) {
> +		BT_ERR("%s: downloading firmware failed (%d)", hdev->name, err);
> +		goto exit_release;
> +	}
> +
> +	/* Send Intel Reset to enable the downloaded operational firmware */
> +	err = btusb_setup_intel_send_reset(hdev);
> +	if (err < 0) {
> +		BT_ERR("%s: sending Intel Reset failed (%d)", hdev->name, err);
> +		goto exit_release;
> +	}
> +
> +	BT_INFO("%s: Intel firmware downloading is completed", hdev->name);
> +
> +exit_release:
> +	release_firmware(fw);
> +
> +	/* extra time after resetting the device */
> +	msleep(200);

So this now gets execute as generic error path. I think this timeout should be actually in the btusb_setup_intel_send_reset function. Since that is the only time it needs to wait for some magic time to turn the device back.

> +
> +	/*
> +	 * Once the device is running with operational firmware, send device
> +	 * specific configuration parameter with legacy way.
> +	 */
> +	err = btusb_setup_intel(hdev);
> +	if (err < 0) {
> +		BT_ERR("%s: configuring Intel BT device failed (%d)",
> +		       hdev->name, err);
> +		goto exit_error;
> +	}
> +
> +	BT_INFO("%s: Intel Bluetooth device configuration is completed",
> +		hdev->name);
> +
> +exit_error:
> +	/*
> +	 * After this point, All events will come from interrupt endpoint.
> +	 * So, put back the bulk_recv routine to generic one
> +	 */
> +	BT_INFO("%s: Reset the send and receive routines", hdev->name);
> +
> +	data->recv_bulk = btusb_recv_bulk;
> +	hdev->send = btusb_send_frame;
> +
> +	return err;
> +}
> +
> +
> static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> {
> 	struct sk_buff *skb;
> @@ -2079,6 +2432,9 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
> 	}
> 
> +	if (id->driver_info & BTUSB_INTEL_BOOT2)
> +		hdev->setup = btusb_setup_intel_boot2;
> +

This should include btusb_set_bdaddr_intel as well.

And you also want to set the special btusb_send_frame_intel here as well. And same for the internal bulk handler.

> 	if (id->driver_info & BTUSB_MARVELL)
> 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;

Regards

Marcel

