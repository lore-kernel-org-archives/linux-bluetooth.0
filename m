Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] Bluetooth: hci_uart: Introduce Intel HCI UART driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1435746026-1024-1-git-send-email-loic.poulain@intel.com>
Date: Sat, 4 Jul 2015 15:15:17 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <188DA073-D50B-4173-B879-0AFD8A0C7915@holtmann.org>
References: <1435746026-1024-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add minimal support for Intel Bluetooth over UART.

so this is really not an acceptable commit message. It is a bit tiny. Compare this to what I added as commit message when we added support for Snowfield Peak USB controllers.

I took the basics from the Snowfield Peak commit and adapted it for Lighting Peak. That gives other readers at least a chance to see what this patch is for.

> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 602 ++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/hci_ldisc.c |   6 +
> drivers/bluetooth/hci_uart.h  |   5 +
> 3 files changed, 613 insertions(+)

I did apply this patch to bluetooth-next tree, but I had to fix a bunch of coding style mistakes.

Initially I was going to send this back, but in the end they were so easy to fix inline that it would have just delayed the process for getting larger exposure of this patch. However please review these since there were obvious coding style mistakes.

<snip>

> +static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct intel_data *intel = hu->priv;
> +	struct hci_event_hdr *hdr;
> +
> +	if (!test_bit(STATE_BOOTLOADER, &intel->flags))
> +		goto recv;
> +
> +	hdr = (void *)skb->data;
> +
> +	/* When the firmware loading completes the device sends
> +	 * out a vendor specific event indicating the result of
> +	 * the firmware loading.
> +	 */
> +	if (skb->len == 7 && hdr->evt == 0xff && hdr->plen == 0x05 &&
> +		skb->data[2] == 0x06) {

This is wrongly aligned. It needs to align with skb->len in the line above.

> +		if (skb->data[3] != 0x00)
> +			set_bit(STATE_FIRMWARE_FAILED, &intel->flags);
> +
> +		if (test_and_clear_bit(STATE_DOWNLOADING, &intel->flags) &&
> +			    test_bit(STATE_FIRMWARE_LOADED, &intel->flags)) {

This one needs to align with with the test_ above.

> +				smp_mb__after_atomic();
> +				wake_up_bit(&intel->flags, STATE_DOWNLOADING);

These two have one indentation too many.

> +		}
> +
> +	/* When switching to the operational firmware the device
> +	 * sends a vendor specific event indicating that the bootup
> +	 * completed.
> +	 */
> +	} else if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
> +		   skb->data[2] == 0x02) {
> +		if (test_and_clear_bit(STATE_BOOTING, &intel->flags)) {
> +			smp_mb__after_atomic();
> +			wake_up_bit(&intel->flags, STATE_BOOTING);
> +		}
> +	}
> +recv:
> +	return hci_recv_frame(hdev, skb);
> +}
> +
> +static const struct h4_recv_pkt intel_recv_pkts[] = {
> +	{ H4_RECV_ACL,   .recv = hci_recv_frame },
> +	{ H4_RECV_SCO,   .recv = hci_recv_frame },
> +	{ H4_RECV_EVENT, .recv = intel_recv_event },
> +};
> +
> +static int intel_recv(struct hci_uart *hu, const void *data, int count)
> +{
> +	struct intel_data *intel = hu->priv;
> +
> +	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> +		return -EUNATCH;
> +
> +	intel->rx_skb = h4_recv_buf(hu->hdev, intel->rx_skb, data, count,
> +				  intel_recv_pkts, ARRAY_SIZE(intel_recv_pkts));

This one is wrongly aligned.

> +	if (IS_ERR(intel->rx_skb)) {
> +		int err = PTR_ERR(intel->rx_skb);
> +		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);

As with previous discussion, rx_skb needs to be set back to NULL here.

> +		return err;
> +	}
> +
> +	return count;
> +}
> +
> +static int intel_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> +{
> +	struct intel_data *intel = hu->priv;
> +
> +	BT_DBG("hu %p skb %p", hu, skb);
> +
> +	skb_queue_tail(&intel->txq, skb);
> +
> +	return 0;
> +}
> +
> +static struct sk_buff *intel_dequeue(struct hci_uart *hu)
> +{
> +	struct intel_data *intel = hu->priv;
> +	struct sk_buff *skb;
> +
> +	skb = skb_dequeue(&intel->txq);
> +	if (!skb)
> +		return skb;
> +
> +	if (test_bit(STATE_BOOTLOADER, &intel->flags) &&
> +		(bt_cb(skb)->pkt_type == HCI_COMMAND_PKT)) {

This needs to align with the test_bit from the line above.

> +		struct hci_command_hdr *cmd = (void *)skb->data;
> +		__u16 opcode = le16_to_cpu(cmd->opcode);
> +
> +		/* When the 0xfc01 command is issued to boot into
> +		 * the operational firmware, it will actually not
> +		 * send a command complete event. To keep the flow
> +		 * control working inject that event here.
> +		 */
> +		if (opcode == 0xfc01)
> +			inject_cmd_complete(hu->hdev, opcode);
> +	}
> +
> +	/* Prepend skb with frame type */
> +	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
> +
> +	return skb;
> +}

In addition, I did a test run on one of my development boards and having to wait almost 1 minute for the firmware to load is impressive. Seems we really want to add the higher speed UART support.

[171933.957748] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 34 2014
[171933.969914] Bluetooth: hci0: Device revision is 5
[171933.969916] Bluetooth: hci0: Secure boot is enabled
[171933.969918] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[171933.969918] Bluetooth: hci0: No device address configured
[171933.975503] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[171988.683798] Bluetooth: hci0: Waiting for firmware download to complete
[171988.683801] Bluetooth: hci0: Firmware loaded in 53497399 usecs
[171988.683886] Bluetooth: hci0: Waiting for device to boot
[171988.696706] Bluetooth: hci0: Device booted in 12593 usecs
[171988.714708] Bluetooth: hci0 hardware error 0x0e

This could be an issue of the development board or the firmware I choose. However I see an hardware error right after the device booted. I need to double check why that happens.

Which also means you want to hook up the hdev->hw_error handling we are doing for Snowfield Peak since they are identical. Then we should get some extra status on where this error occurred.

I also noticed that the hdev->set_bdaddr integration is missing. My development board has not valid address and is now in a chicken and egg problem. It boots unconfigured, but there is no way to set the address, so it is stuck in that mode forever.

Regards

Marcel

