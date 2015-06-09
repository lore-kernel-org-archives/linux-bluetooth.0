Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v8] Bluetooth: hci_uart: Add bcm_set_baudrate()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433840693-5991-2-git-send-email-frederic.danis@linux.intel.com>
Date: Tue, 9 Jun 2015 11:33:20 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <30E00E8F-98D7-4AE8-A5AC-29F464BAC050@holtmann.org>
References: <1433840693-5991-1-git-send-email-frederic.danis@linux.intel.com> <1433840693-5991-2-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Add vendor specific command to change controller device speed.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/btbcm.h   |  5 ++++
> drivers/bluetooth/hci_bcm.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 63 insertions(+)
> 
> diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
> index f405f84..e1770d8 100644
> --- a/drivers/bluetooth/btbcm.h
> +++ b/drivers/bluetooth/btbcm.h
> @@ -21,6 +21,11 @@
>  *
>  */
> 
> +struct bcm_set_speed {
> +	__le16   zero;
> +	__le32   speed;
> +} __packed;
> +

I think this should actually be

	struct bcm_update_uart_baud_rate {
		__le16 zero;
		__le32 baud_rate;
	} __packed;

And lets just add this one as well

	struct bcm_write_uart_clock_setting {
		__u8 type;
	} __packed;

> #if IS_ENABLED(CONFIG_BT_BCM)
> 
> int btbcm_check_bdaddr(struct hci_dev *hdev);
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 0704522..2a064a5 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -25,6 +25,7 @@
> #include <linux/errno.h>
> #include <linux/skbuff.h>
> #include <linux/firmware.h>
> +#include <linux/tty.h>
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -32,11 +33,59 @@
> #include "btbcm.h"
> #include "hci_uart.h"
> 
> +#define BCM43XX_CLOCK_48 1
> +#define BCM43XX_CLOCK_24 2
> +

Lets put these in btbcm.h as well.

#define BCM_UART_CLOCK_48MHZ	0x01
#define BCM_UART_CLOCK_24MHZ	0x02

> struct bcm_data {
> 	struct sk_buff *rx_skb;
> 	struct sk_buff_head txq;
> };
> 
> +static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	struct sk_buff *skb;
> +	struct bcm_set_speed param;
> +
> +	if (speed > 3000000) {
> +		u8 clock = BCM43XX_CLOCK_48;
> +
> +		BT_DBG("%s: Set Controller clock (%d)", hdev->name, clock);
> +
> +		/* This Broadcom specific command changes the UART's controller
> +		 * clock for baud rate > 3000000.
> +		 */
> +		skb = __hci_cmd_sync(hdev, 0xfc45, 1, &clock, HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			BT_ERR("%s: BCM: failed to write update clock command"
> +			       " (%ld)", hdev->name, PTR_ERR(skb));
> +			return PTR_ERR(skb);

In many cases we did this:

		int err = PTR_ERR(skb);
		BT_ERR("%s .. (%d)", hdev->name, err);
		return err;

I have the feeling that we might want to stick with this. Might be worth while to check how consistent we have actually been.

> +		}
> +
> +		kfree_skb(skb);
> +	}
> +
> +	BT_DBG("%s: Set Controller UART speed to %d bit/s", hdev->name, speed);
> +
> +	param.zero = cpu_to_le16(0);
> +	param.speed = cpu_to_le32(speed);
> +
> +	/* This Broadcom specific command changes the UART's controller baud
> +	 * rate.
> +	 */
> +	skb = __hci_cmd_sync(hdev, 0xfc18, sizeof(param), &param,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: BCM: failed to write update baudrate command (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return PTR_ERR(skb);
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
> @@ -107,6 +156,12 @@ static int bcm_setup(struct hci_uart *hu)
> 	if (hu->proto->init_speed)
> 		hci_uart_set_baudrate(hu, hu->proto->init_speed);
> 
> +	if (hu->proto->oper_speed) {
> +		err = bcm_set_baudrate(hu, hu->proto->oper_speed);
> +		if (!err)
> +			hci_uart_set_baudrate(hu, hu->proto->oper_speed);
> +	}
> +
> finalize:
> 	release_firmware(fw);
> 
> @@ -162,10 +217,13 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
> static const struct hci_uart_proto bcm_proto = {
> 	.id		= HCI_UART_BCM,
> 	.name		= "BCM",
> +	.init_speed	= 115200,
> +	.oper_speed	= 4000000,
> 	.open		= bcm_open,
> 	.close		= bcm_close,
> 	.flush		= bcm_flush,
> 	.setup		= bcm_setup,
> +	.set_baudrate	= bcm_set_baudrate,
> 	.recv		= bcm_recv,
> 	.enqueue	= bcm_enqueue,
> 	.dequeue	= bcm_dequeue,

Rest looks good.

Regards

Marcel

