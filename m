Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2 5/5] Bluetooth: btbcm: Add bcm_set_baudrate()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1431008699-6419-5-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 7 May 2015 17:16:24 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <46D1E4EC-7381-4DBA-AB08-54734FCF38C7@holtmann.org>
References: <1431008699-6419-1-git-send-email-frederic.danis@linux.intel.com> <1431008699-6419-5-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Add vendor specific command to change controller device speed.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 71 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 0e77b9a..6b3f5d5 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -24,6 +24,7 @@
> #include <linux/kernel.h>
> #include <linux/errno.h>
> #include <linux/skbuff.h>
> +#include <linux/tty.h>
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -31,11 +32,71 @@
> #include "btbcm.h"
> #include "hci_uart.h"
> 
> +#define BCM43XX_CLOCK_48 1
> +#define BCM43XX_CLOCK_24 2
> +
> struct bcm_data {
> 	struct sk_buff *rx_skb;
> 	struct sk_buff_head txq;
> };
> 
> +struct hci_cp_bcm_set_speed {
> +	__le16   dummy;
> +	__le32   speed;
> +} __packed;
> +
> +static int bcm_set_baudrate(struct hci_uart *hu, int speed)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	struct sk_buff *skb;
> +	struct hci_cp_bcm_set_speed param = { 0, cpu_to_le32(speed) };
> +	u8 status;
> +
> +	if (speed > 3000000) {
> +		u8 clock = BCM43XX_CLOCK_48;
> +
> +		BT_DBG("%s: Set Controller clock (%d)", hdev->name, clock);
> +
> +		skb = __hci_cmd_sync(hdev, 0xfc45, 1, &clock, HCI_INIT_TIMEOUT,
> +				     &status);
> +		if (IS_ERR(skb)) {
> +			BT_ERR("%s: failed to write update clock command (%ld)",
> +			       hdev->name, PTR_ERR(skb));
> +			return PTR_ERR(skb);
> +		}
> +
> +		if (status) {
> +			BT_ERR("%s: write update clock event failed (%02x)",
> +			       hdev->name, status);
> +			kfree_skb(skb);
> +			return -bt_to_errno(status);
> +		}
> +
> +		kfree_skb(skb);
> +	}
> +
> +	BT_DBG("%s: Set Controller UART speed to %d bit/s", hdev->name, speed);
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc18, sizeof(param), &param,
> +			     HCI_INIT_TIMEOUT, &status);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: failed to write update baudrate command (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (status) {
> +		BT_ERR("%s: write update baudrate event failed (%02x)",
> +		       hdev->name, status);
> +		kfree_skb(skb);
> +		return -bt_to_errno(status);
> +	}
> +
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> static int bcm_open(struct hci_uart *hu)
> {
> 	struct bcm_data *bcm;
> @@ -98,6 +159,13 @@ static int bcm_setup(struct hci_uart *hu)
> 	if (hu->proto->default_speed)
> 		hci_uart_set_baudrate(hu, hu->proto->default_speed);
> 
> +	if (hu->proto->operational_speed) {
> +		err = bcm_set_baudrate(hu, hu->proto->operational_speed);
> +		if (err)
> +			return err;

Why would we fail here. I think we can just gracefully continue. It just means it is slower.

> +		hci_uart_set_baudrate(hu, hu->proto->operational_speed);

This one failing would be pretty bad and we might need to check that. However it could be well that this can not fail at all actually. Check the TTY layer and add a comment here explaining it either way.

> +	}
> +
> 	err = btbcm_setup_post(hu->hdev);
> 
> 	return err;
> @@ -150,10 +218,13 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
> static const struct hci_uart_proto bcm_proto = {
> 	.id		= HCI_UART_BCM,
> 	.name		= "BCM",
> +	.default_speed	= 115200,
> +	.operational_speed = 4000000,
> 	.open		= bcm_open,
> 	.close		= bcm_close,
> 	.flush		= bcm_flush,
> 	.setup		= bcm_setup,
> +	.set_baudrate	= bcm_set_baudrate,
> 	.recv		= bcm_recv,
> 	.enqueue	= bcm_enqueue,
> 	.dequeue	= bcm_dequeue,

Regards

Marcel

