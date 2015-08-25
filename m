Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v5 1/2] Bluetooth: hci_intel: Add Intel baudrate configuration support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440498097-19739-1-git-send-email-loic.poulain@intel.com>
Date: Tue, 25 Aug 2015 08:15:31 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2AEABB7B-A28E-49C1-B42B-0AE3ABD936A1@holtmann.org>
References: <1440498097-19739-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Implement the set_baudrate callback for hci_intel.
> - Controller requires a read Intel version command before updating
>   its baudrate.
> - The operation consists in an async cmd since the controller does
>   not respond at the same speed.
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
> v5: Direclty enqueue speed cmd instead of hacking hci_cmd_sync
>     intel_set_baudrate refactoring.
>     keep STATE_SPEED_CHANGING flag in order to ignore incoming packet
>     during transition. Could be used later to indicate cmd complete,
>     avoiding msleep usage.
> 
> drivers/bluetooth/hci_intel.c | 126 ++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 126 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 21dfa89..ba38e6c 100644
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
> @@ -111,6 +144,54 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
> 	return hci_recv_frame(hdev, skb);
> }
> 
> +static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
> +{
> +	struct intel_data *intel = hu->priv;
> +	struct hci_dev *hdev = hu->hdev;
> +	u8 speed_cmd[] = { 0x06, 0xfc, 0x01, 0x00 };
> +	struct sk_buff *skb;
> +
> +	BT_INFO("%s: Change controller speed to %d", hdev->name, speed);
> +
> +	speed_cmd[3] = intel_convert_speed(speed);
> +	if (speed_cmd[3] == 0xff) {
> +		BT_ERR("%s: Unsupported speed", hdev->name);
> +		return -EINVAL;
> +	}
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
> +	kfree_skb(skb);
> +
> +	skb = bt_skb_alloc(sizeof(speed_cmd), GFP_KERNEL);
> +	if (!skb) {
> +		BT_ERR("Failed to allocate memory for baudrate packet");

please also introduce %s: here for hdev->name.

I think that long term we need to introduce bt_dev_err(hdev, "Foo") support to unify all these cases.

> +		return -ENOMEM;
> +	}
> +
> +	memcpy(skb_put(skb, sizeof(speed_cmd)), speed_cmd, sizeof(speed_cmd));
> +	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
> +
> +	set_bit(STATE_SPEED_CHANGING, &intel->flags);
> +
> +	skb_queue_tail(&intel->txq, skb);
> +	hci_uart_tx_wakeup(hu);
> +
> +	/* wait 100ms to change baudrate on controller side */
> +	msleep(100);
> +
> +	clear_bit(STATE_SPEED_CHANGING, &intel->flags);

I think if we follow the proper procedure this extra details should not be needed.

1) Suspend queuing of new HCI packets.
2) De-assert the UART flow go signal i.e. set RTS to flow stop.
3) Queue the HCI_Intel_Set_UART_Baudrate command for transmission on the UART.
4) Wait until the end of the last bit of the last octet of the command is propagated on the UART Tx line.
5) Reconfigure the UART baud rate.
6) Assert the UART flow go signal i.e. set RTS to flow go.
7) Resume queueing of new HCI packets.

While some wait might be needed for us to be sure that the command has been sent, I think that handling garbage input should not happen while RTS is de-asserted.

> +
> +	return 0;
> +}
> +
> static int intel_setup(struct hci_uart *hu)
> {
> 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
> @@ -126,6 +207,8 @@ static int intel_setup(struct hci_uart *hu)
> 	u32 frag_len;
> 	ktime_t calltime, delta, rettime;
> 	unsigned long long duration;
> +	unsigned int init_speed, oper_speed;
> +	int speed_change = 0;
> 	int err;
> 
> 	BT_DBG("%s", hdev->name);
> @@ -134,6 +217,19 @@ static int intel_setup(struct hci_uart *hu)
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
> @@ -416,6 +512,14 @@ done:
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
> @@ -456,6 +560,21 @@ done:
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
> +	BT_INFO("%s: Setup complete", hdev->name);
> +
> 	clear_bit(STATE_BOOTLOADER, &intel->flags);
> 
> 	return 0;
> @@ -515,6 +634,10 @@ static int intel_recv(struct hci_uart *hu, const void *data, int count)
> 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> 		return -EUNATCH;
> 
> +	/* Ignore unexpected non-sync data during speed change */
> +	if (test_bit(STATE_SPEED_CHANGING, &intel->flags))
> +		return count;
> +

I am pretty much convinced with RTS de-asserted, we do not need this.

> 	intel->rx_skb = h4_recv_buf(hu->hdev, intel->rx_skb, data, count,
> 				    intel_recv_pkts,
> 				    ARRAY_SIZE(intel_recv_pkts));
> @@ -548,6 +671,7 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
> 	if (!skb)
> 		return skb;
> 
> +	/* Inject cmd complete pkt for async commands */

Scrap this extra comment.

> 	if (test_bit(STATE_BOOTLOADER, &intel->flags) &&
> 	    (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT)) {
> 		struct hci_command_hdr *cmd = (void *)skb->data;
> @@ -572,10 +696,12 @@ static const struct hci_uart_proto intel_proto = {
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

