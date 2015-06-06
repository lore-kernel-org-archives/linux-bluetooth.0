Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v7 6/6] Bluetooth: hci_uart: Add bcm_set_baudrate()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432805106-25719-7-git-send-email-frederic.danis@linux.intel.com>
Date: Sat, 6 Jun 2015 07:47:11 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2DB4BA5D-A211-40C5-9F59-577843F885A6@holtmann.org>
References: <1432805106-25719-1-git-send-email-frederic.danis@linux.intel.com> <1432805106-25719-7-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Add vendor specific command to change controller device speed.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 6c34135..0cbf9d4 100644
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
> @@ -31,11 +32,55 @@
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

I think this data structure should go into btbcm.h with a little bit better name. This should be similar to the btintel.h where I am slowly trying to get the proper data structures put in place.



> +
> +static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	struct sk_buff *skb;
> +	struct hci_cp_bcm_set_speed param = { 0, cpu_to_le32(speed) };

I would prefer if we assign this one by one and use cpu_lo_le16(0) here as well. Just to remember that the value is actually in little endian.

> +
> +	if (speed > 3000000) {
> +		u8 clock = BCM43XX_CLOCK_48;
> +
> +		BT_DBG("%s: Set Controller clock (%d)", hdev->name, clock);
> +

I prefer having a comment above the vendor commands explain on what they do and why this is correct. That is as close as it gets for someone with the proper documentation to figure out why we are doing things. I think the Intel support is a good example on how far I have gone with this.

> +		skb = __hci_cmd_sync(hdev, 0xfc45, 1, &clock, HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			BT_ERR("%s: failed to write update clock command (%ld)”,

Lets try to be a bit consistent with the error messages. I think we prefixed most of it with BCM: as well. Overall, I try to make this really consistent.

> +			       hdev->name, PTR_ERR(skb));
> +			return PTR_ERR(skb);
> +		}
> +
> +		kfree_skb(skb);
> +	}
> +
> +	BT_DBG("%s: Set Controller UART speed to %d bit/s", hdev->name, speed);
> +

Same here. Comments should be put above and assignment of the values to param maybe better places above here so you know exactly where they are coming from.

> +	skb = __hci_cmd_sync(hdev, 0xfc18, sizeof(param), &param,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: failed to write update baudrate command (%ld)”,

Same as the comment above with the BCM: prefix.

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
> @@ -106,6 +151,14 @@ static int bcm_setup(struct hci_uart *hu)
> 	if (hu->proto->init_speed)
> 		hci_uart_set_baudrate(hu, hu->proto->init_speed);
> 
> +	if (hu->proto->oper_speed) {
> +		err = bcm_set_baudrate(hu, hu->proto->oper_speed);
> +		if (!err)
> +			/* hci_uart_set_baudrate() has no return value as
> +			   tty_set_termios() return is always 0 */

This comment is just duplicating it. Especially since above you do not comment it. So in this case I would remove it.

> +			hci_uart_set_baudrate(hu, hu->proto->oper_speed);
> +	}
> +
> finalize:
> 	release_firmware(fw);
> 
> @@ -161,10 +214,13 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
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

Regards

Marcel

