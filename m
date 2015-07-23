Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] Bluetooth: hci_uart: Add Intel baudrate configuration support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1437472694-4805-1-git-send-email-loic.poulain@intel.com>
Date: Thu, 23 Jul 2015 16:48:01 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <B70087AE-159E-4483-B599-11A4DD3D4538@holtmann.org>
References: <1437472694-4805-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Implement the set_baudrate callback for hci_intel:
>  - Controller requires a read Intel version command before updating its
>    baudrate.
>  - Host sends the change speed command at initial speed and controller
>    replies with the command complete at targeted speed.
> 
> In the setup function, we need to reset the baudrate to initial speed
> after the firmware upload and restore the operational speed once
> controller has booted on the new firmware.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 161 +++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 159 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 21dfa89..682da32 100644
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
> @@ -111,6 +144,76 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
> 	return hci_recv_frame(hdev, skb);
> }
> 
> +static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
> +{
> +	struct intel_data *intel = hu->priv;
> +	struct hci_dev *hdev = hu->hdev;
> +	u8 intel_speed;
> +	struct sk_buff *skb;
> +	int err;
> +
> +	BT_INFO("%s: Change device speed to %d", hdev->name, speed);
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
> +	kfree_skb(skb);
> +
> +	intel_speed = intel_convert_speed(speed);
> +	if (intel_speed == 0xff) {
> +		BT_ERR("%s: Unsupported speed", hdev->name);
> +		return -EINVAL;
> +	}
> +
> +	set_bit(STATE_SPEED_CHANGING, &intel->flags);
> +
> +	hci_uart_set_flow_control(hu, 1);
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc06, 1, &intel_speed, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: Changing Intel speed failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	kfree_skb(skb);
> +
> +	/* Be sure change speed packet has been flushed to the phy before
> +	 * changing host speed.
> +	 */
> +	msleep(10);
> +	hci_uart_set_baudrate(hu, speed);
> +
> +	hci_uart_set_flow_control(hu, 0);
> +
> +	/* Previous change speed command complete has been virtually injected.
> +	 * Wait for this event now we both are at targeted speed.
> +	 */
> +	err = wait_on_bit_timeout(&intel->flags, STATE_SPEED_CHANGING,
> +				  TASK_INTERRUPTIBLE,
> +				  msecs_to_jiffies(100));
> +	if (err == 1) {
> +		BT_ERR("%s: Changing speed interrupted", hdev->name);
> +		return -EINTR;
> +	}
> +
> +	if (err) {
> +		/* Some hardwares seem buggy and don't return the cmd complete.
> +		 * Just ignore timeout.
> +		 */
> +		BT_ERR("%s: Changing speed timeout, continue...", hdev->name);
> +	}
> +
> +	return 0;
> +}
> +
> static int intel_setup(struct hci_uart *hu)
> {
> 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
> @@ -126,6 +229,8 @@ static int intel_setup(struct hci_uart *hu)
> 	u32 frag_len;
> 	ktime_t calltime, delta, rettime;
> 	unsigned long long duration;
> +	unsigned int init_speed, oper_speed;
> +	int speed_change = 0;
> 	int err;
> 
> 	BT_DBG("%s", hdev->name);
> @@ -134,6 +239,19 @@ static int intel_setup(struct hci_uart *hu)
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
> @@ -420,6 +538,10 @@ done:
> 
> 	set_bit(STATE_BOOTING, &intel->flags);
> 
> +	/* We need to restore the default speed before Intel reset */
> +	if (speed_change)
> +		intel_set_baudrate(hu, init_speed);
> +
> 	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
> 			     HCI_INIT_TIMEOUT);
> 	if (IS_ERR(skb))
> @@ -456,6 +578,18 @@ done:
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
> +			hci_uart_set_baudrate(hu, init_speed);
> +	}
> +
> 	clear_bit(STATE_BOOTLOADER, &intel->flags);
> 
> 	return 0;
> @@ -467,7 +601,8 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> 	struct intel_data *intel = hu->priv;
> 	struct hci_event_hdr *hdr;
> 
> -	if (!test_bit(STATE_BOOTLOADER, &intel->flags))
> +	if (!test_bit(STATE_BOOTLOADER, &intel->flags) &&
> +	    !test_bit(STATE_SPEED_CHANGING, &intel->flags))
> 		goto recv;
> 
> 	hdr = (void *)skb->data;
> @@ -497,7 +632,18 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> 			smp_mb__after_atomic();
> 			wake_up_bit(&intel->flags, STATE_BOOTING);
> 		}
> +
> +	/* When the firmware change speed completes the device sends
> +	 * the command complete event from the new baudrate.
> +	 */
> +	} else if (skb->len >= 5 && hdr->evt == HCI_EV_CMD_COMPLETE &&
> +		   skb->data[3] == 0x06 && skb->data[4] == 0xfc) {
> +		if (test_and_clear_bit(STATE_SPEED_CHANGING, &intel->flags)) {
> +			smp_mb__after_atomic();
> +			wake_up_bit(&intel->flags, STATE_SPEED_CHANGING);
> +		}
> 	}
> +
> recv:
> 	return hci_recv_frame(hdev, skb);
> }
> @@ -548,7 +694,9 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
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
> @@ -560,6 +708,14 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
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

this is a really bad behavior from our firmware then. We would actually like to get the cmd status or cmd complete on the current baud rate and once that has been confirmed, we switch to the new baud rate. I remember that there are actually two different baud rate change commands for the Intel controllers. Are you using the right one?

Regards

Marcel

