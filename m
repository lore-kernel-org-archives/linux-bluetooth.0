Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 3/5] Bluetooth: hci_intel: Introduce LPM support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440689946-13576-3-git-send-email-loic.poulain@intel.com>
Date: Thu, 27 Aug 2015 09:16:27 -0700
Cc: linux-bluetooth@vger.kernel.org, gaetan.prin@intel.com
Message-Id: <C3AB6F28-9EB2-4D37-9A3F-22159042E59B@holtmann.org>
References: <1440689946-13576-1-git-send-email-loic.poulain@intel.com> <1440689946-13576-3-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Enable controller Low-Power-Mode if we have a pdev to manage host
> wake-up. Once LPM is enabled, controller notifies its TX status via
> a vendor specific packet (tx_idle/tx_active).
> tx_active means that there is more data upcoming from controller.
> tx_idle means that controller can be put in suspended state.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 76 ++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 26a1314..f855515 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -44,6 +44,25 @@
> #define STATE_FIRMWARE_LOADED	2
> #define STATE_FIRMWARE_FAILED	3
> #define STATE_BOOTING		4
> +#define STATE_TX_ACTIVE		5
> +
> +#define HCI_LPM_PKT 0xf1
> +#define HCI_LPM_MAX_SIZE 10
> +#define HCI_LPM_HDR_SIZE HCI_EVENT_HDR_SIZE
> +#define H4_RECV_LPM \
> +	.type = HCI_LPM_PKT, \
> +	.hlen = HCI_LPM_HDR_SIZE, \
> +	.loff = 1, \
> +	.lsize = 1, \
> +	.maxlen = HCI_LPM_MAX_SIZE

lets name this INTEL_RECV_LPM and please put this one above intel_recv_pkts struct. Similar to what has been done in hci_qca.c.

> +
> +#define LPM_OP_TX_NOTIFY 0x00
> +
> +struct hci_lpm_pkt {
> +	__u8 opcode;
> +	__u8 dlen;
> +	__u8 data[0];
> +} __packed;
> 
> struct intel_device {
> 	struct list_head list;
> @@ -141,9 +160,10 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
> 	spin_lock(&intel_device_list_lock);
> 
> 	idev = intel_device_get(hu);
> -	if (!idev)
> +	if (!idev) {
> 		err = -ENODEV;
> 		goto done;
> +	}
> 
> 	if (!idev->reset) {
> 		err = -ENOTSUPP;
> @@ -299,7 +319,9 @@ static int intel_setup(struct hci_uart *hu)
> {
> 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
> 					  0x00, 0x08, 0x04, 0x00 };
> +	static const u8 lpm_param[] = {0x03, 0x07, 0x01, 0x0b};

Coding style.

> 	struct intel_data *intel = hu->priv;
> +	struct intel_device *idev;
> 	struct hci_dev *hdev = hu->hdev;
> 	struct sk_buff *skb;
> 	struct intel_version *ver;
> @@ -663,6 +685,25 @@ done:
> 
> 	BT_INFO("%s: Device booted in %llu usecs", hdev->name, duration);
> 
> +	spin_lock(&intel_device_list_lock);
> +	idev = intel_device_get(hu);
> +	if (!idev || !device_may_wakeup(&idev->pdev->dev)) {
> +		spin_unlock(&intel_device_list_lock);
> +		goto no_lpm;
> +	}
> +	spin_unlock(&intel_device_list_lock);

I really dislike having multiple unlock. This code needs to be restructured to become readable and easy to understand without having to think too much that it is correct.

> +
> +	BT_INFO("%s: Enabling LPM", hdev->name);
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc8b, sizeof(lpm_param), lpm_param,
> +			     HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: Failed to enable LPM", hdev->name);
> +		goto no_lpm;
> +	}
> +	kfree_skb(skb);
> +
> +no_lpm:
> 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_CMD_TIMEOUT);
> 	if (IS_ERR(skb))
> 		return PTR_ERR(skb);
> @@ -723,10 +764,43 @@ recv:
> 	return hci_recv_frame(hdev, skb);
> }
> 
> +static void intel_recv_lpm_notification(struct hci_dev *hdev, int value)
> +{

Shorten this name to ..notify instead of ..notification.

> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct intel_data *intel = hu->priv;
> +
> +	BT_DBG("%s: TX idle notification (%d)", hdev->name, value);
> +
> +	if (value)
> +		set_bit(STATE_TX_ACTIVE, &intel->flags);
> +	else
> +		clear_bit(STATE_TX_ACTIVE, &intel->flags);
> +}
> +
> +static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct hci_lpm_pkt *lpm = (void *)skb->data;
> +
> +	switch (lpm->opcode) {
> +	case LPM_OP_TX_NOTIFY:
> +		if (lpm->dlen)
> +			intel_recv_lpm_notification(hdev, lpm->data[0]);
> +		break;
> +	default:
> +		BT_ERR("%s: unknown LPM opcode (%02x)", hdev->name,
> +		       lpm->opcode);

We even have break; here.

> +	}
> +
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> static const struct h4_recv_pkt intel_recv_pkts[] = {
> 	{ H4_RECV_ACL,   .recv = hci_recv_frame },
> 	{ H4_RECV_SCO,   .recv = hci_recv_frame },
> 	{ H4_RECV_EVENT, .recv = intel_recv_event },
> +	{ H4_RECV_LPM,   .recv = intel_recv_lpm },
> };
> 
> static int intel_recv(struct hci_uart *hu, const void *data, int count)

Regards

Marcel

