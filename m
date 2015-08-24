Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v4 1/2] Bluetooth: hci_intel: Add Intel baudrate configuration support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440165583-23245-1-git-send-email-loic.poulain@intel.com>
Date: Mon, 24 Aug 2015 11:31:23 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <5D898BFA-B6C2-47DC-9DC4-DB3EDECA2E23@holtmann.org>
References: <1440165583-23245-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Implement the set_baudrate callback for hci_intel.
> - Controller requires a read Intel version command before updating
>   its baudrate.
> - Inject the change speed command complete since controller does not
>   respond at the same speed.
> - Wait 100ms to let the controller change its baudrate.
> 
> Manage speed change in the setup function, we need to restore the oper
> speed once chip has booted on patched firmware.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: simplify baudrate change, update commit message,
>     set missing set_baudrate callback.
> v3: Remove unused 'err' variable in intel_set_baudrate
> v4: Move set_bit STATE_BOOTING after speed changing in setup
>     change patch title, hci_uart->hci_intel
> 
> drivers/bluetooth/hci_intel.c | 134 +++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 133 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 21dfa89..080e794 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -38,6 +38,7 @@
> #define STATE_FIRMWARE_LOADED	2
> #define STATE_FIRMWARE_FAILED	3
> #define STATE_BOOTING		4
> +#define STATE_SPEED_CHANGING	5
> 
> struct intel_data {
> 	struct sk_buff *rx_skb;
> @@ -45,6 +46,38 @@ struct intel_data {
> 	unsigned long flags;
> };
> 
> +static u8 intel_convert_speed(unsigned int speed)
> +{
> +	switch (speed) {
> +	case 9600:
> +		return 0x00;
> +	case 19200:
> +		return 0x01;
> +	case 38400:
> +		return 0x02;
> +	case 57600:
> +		return 0x03;
> +	case 115200:
> +		return 0x04;
> +	case 230400:
> +		return 0x05;
> +	case 460800:
> +		return 0x06;
> +	case 921600:
> +		return 0x07;
> +	case 1843200:
> +		return 0x08;
> +	case 3250000:
> +		return 0x09;
> +	case 2000000:
> +		return 0x0a;
> +	case 3000000:
> +		return 0x0b;
> +	default:
> +		return 0xff;
> +	}
> +}
> +
> static int intel_open(struct hci_uart *hu)
> {
> 	struct intel_data *intel;
> @@ -111,6 +144,53 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
> 	return hci_recv_frame(hdev, skb);
> }
> 
> +static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
> +{
> +	struct intel_data *intel = hu->priv;
> +	struct hci_dev *hdev = hu->hdev;
> +	u8 intel_speed;
> +	struct sk_buff *skb;
> +
> +	BT_INFO("%s: Change controller speed to %d", hdev->name, speed);
> +
> +	/* Device will not accept speed change if Intel version has not been
> +	 * previously requested.
> +	 */
> +	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: Reading Intel version information failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +

This empty line can be removed. In case we do not do anything with the return value, then just free the skb right after it. So we are creating a nice and easy readable block.

> +	kfree_skb(skb);
> +
> +	intel_speed = intel_convert_speed(speed);
> +	if (intel_speed == 0xff) {
> +		BT_ERR("%s: Unsupported speed", hdev->name);
> +		return -EINVAL;
> +	}

I would move this conversion to the top of the function. So that the version only gets read if we have a correct baud rate in the first place.

> +
> +	set_bit(STATE_SPEED_CHANGING, &intel->flags);
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc06, 1, &intel_speed, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: Changing Intel speed failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		clear_bit(STATE_SPEED_CHANGING, &intel->flags);
> +		return PTR_ERR(skb);
> +	}

I think this approach is wrong. It is not that the controller sends no HCI Command Complete. It is just that it sends it later and we have to change the baud rate in between.

This is different from the case where the controller swallows the HCI Command Complete event altogether. So instead of trying to hack around this, why not just insert the HCI command into the queue like the QCA guys did. We have no chance of checking that it worked anyway.

> +
> +	kfree_skb(skb);
> +
> +	/* wait 100ms to change baudrate on controller side */
> +	msleep(100);
> +
> +	clear_bit(STATE_SPEED_CHANGING, &intel->flags);

If we just inject the command into the local queue and wakeup the processing, then the speed change state tracking for sending should go away. However we could keep it for waiting for the HCI Command Complete that indicates the success. And then continue. The msleep would then not be needed.

> +
> +	return 0;
> +}
> +
> static int intel_setup(struct hci_uart *hu)
> {
> 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
> @@ -126,6 +206,8 @@ static int intel_setup(struct hci_uart *hu)
> 	u32 frag_len;
> 	ktime_t calltime, delta, rettime;
> 	unsigned long long duration;
> +	unsigned int init_speed, oper_speed;
> +	int speed_change = 0;
> 	int err;
> 
> 	BT_DBG("%s", hdev->name);
> @@ -134,6 +216,19 @@ static int intel_setup(struct hci_uart *hu)
> 
> 	calltime = ktime_get();
> 
> +	if (hu->init_speed)
> +		init_speed = hu->init_speed;
> +	else
> +		init_speed = hu->proto->init_speed;
> +
> +	if (hu->oper_speed)
> +		oper_speed = hu->oper_speed;
> +	else
> +		oper_speed = hu->proto->oper_speed;
> +
> +	if (oper_speed && init_speed && oper_speed != init_speed)
> +		speed_change = 1;
> +
> 	set_bit(STATE_BOOTLOADER, &intel->flags);
> 
> 	/* Read the Intel version information to determine if the device
> @@ -416,6 +511,14 @@ done:
> 	if (err < 0)
> 		return err;
> 
> +	/* We need to restore the default speed before Intel reset */
> +	if (speed_change) {
> +		err = intel_set_baudrate(hu, init_speed);
> +		if (err)
> +			return err;
> +		hci_uart_set_baudrate(hu, init_speed);
> +	}
> +
> 	calltime = ktime_get();
> 
> 	set_bit(STATE_BOOTING, &intel->flags);
> @@ -456,6 +559,19 @@ done:
> 
> 	BT_INFO("%s: Device booted in %llu usecs", hdev->name, duration);
> 
> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	kfree_skb(skb);
> +
> +	if (speed_change) {
> +		err = intel_set_baudrate(hu, oper_speed);
> +		if (err)
> +			return err;
> +		hci_uart_set_baudrate(hu, oper_speed);
> +	}
> +
> 	clear_bit(STATE_BOOTLOADER, &intel->flags);
> 
> 	return 0;
> @@ -515,6 +631,10 @@ static int intel_recv(struct hci_uart *hu, const void *data, int count)
> 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> 		return -EUNATCH;
> 
> +	/* Ignore unexpected non-sync data during speed change */
> +	if (test_bit(STATE_SPEED_CHANGING, &intel->flags))
> +		return count;
> +
> 	intel->rx_skb = h4_recv_buf(hu->hdev, intel->rx_skb, data, count,
> 				    intel_recv_pkts,
> 				    ARRAY_SIZE(intel_recv_pkts));
> @@ -548,7 +668,9 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
> 	if (!skb)
> 		return skb;
> 
> -	if (test_bit(STATE_BOOTLOADER, &intel->flags) &&
> +	/* Inject cmd complete pkt for async commands */
> +	if ((test_bit(STATE_BOOTLOADER, &intel->flags) ||
> +	    test_bit(STATE_SPEED_CHANGING, &intel->flags)) &&
> 	    (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT)) {
> 		struct hci_command_hdr *cmd = (void *)skb->data;
> 		__u16 opcode = le16_to_cpu(cmd->opcode);
> @@ -560,6 +682,14 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
> 		 */
> 		if (opcode == 0xfc01)
> 			inject_cmd_complete(hu->hdev, opcode);
> +
> +		/* When the 0xfc06 command is issued to change the
> +		 * speed, device will send the command complete event
> +		 * only at the targeted speed. Host needs to change its
> +		 * own baudrate before being able to receive the response.
> +		 */
> +		if (opcode == 0xfc06)
> +			inject_cmd_complete(hu->hdev, opcode);
> 	}
> 
> 	/* Prepend skb with frame type */
> @@ -572,10 +702,12 @@ static const struct hci_uart_proto intel_proto = {
> 	.id		= HCI_UART_INTEL,
> 	.name		= "Intel",
> 	.init_speed	= 115200,
> +	.oper_speed	= 3000000,
> 	.open		= intel_open,
> 	.close		= intel_close,
> 	.flush		= intel_flush,
> 	.setup		= intel_setup,
> +	.set_baudrate	= intel_set_baudrate,
> 	.recv		= intel_recv,
> 	.enqueue	= intel_enqueue,
> 	.dequeue	= intel_dequeue,

Regards

Marcel

