Return-Path: <cyrus@holtmann.org>
Message-ID: <55771DCC.7000904@broadcom.com>
Date: Tue, 9 Jun 2015 19:09:32 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Frederic Danis <frederic.danis@linux.intel.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v9] Bluetooth: hci_uart: Add bcm_set_baudrate()
References: <1433859337-2398-1-git-send-email-frederic.danis@linux.intel.com> <1433859337-2398-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1433859337-2398-2-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/09/15 16:15, Frederic Danis wrote:
> Add vendor specific command to change controller device speed.
>
> Signed-off-by: Frederic Danis<frederic.danis@linux.intel.com>
> ---

With only 1 patch left you could consider adding the changelog in the 
patch itself like done with this comment ;-)

Regards,
Arend

---
>   drivers/bluetooth/btbcm.h   | 12 ++++++++++
>   drivers/bluetooth/hci_bcm.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 70 insertions(+)
>
> diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
> index f405f84..02f5f96 100644
> --- a/drivers/bluetooth/btbcm.h
> +++ b/drivers/bluetooth/btbcm.h
> @@ -21,6 +21,18 @@
>    *
>    */
>
> +#define BCM_UART_CLOCK_48MHZ	0x01
> +#define BCM_UART_CLOCK_24MHZ	0x02
> +
> +struct bcm_update_uart_baud_rate {
> +	__le16 zero;
> +	__le32 baud_rate;
> +} __packed;
> +
> +struct bcm_write_uart_clock_setting {
> +	__u8 type;
> +} __packed;
> +
>   #if IS_ENABLED(CONFIG_BT_BCM)
>
>   int btbcm_check_bdaddr(struct hci_dev *hdev);
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 0704522..e4d66b6 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -37,6 +37,55 @@ struct bcm_data {
>   	struct sk_buff_head txq;
>   };
>
> +static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	struct sk_buff *skb;
> +	struct bcm_update_uart_baud_rate param;
> +
> +	if (speed>  3000000) {
> +		struct bcm_write_uart_clock_setting clock;
> +
> +		clock.type = BCM_UART_CLOCK_48MHZ;
> +
> +		BT_DBG("%s: Set Controller clock (%d)", hdev->name, clock.type);
> +
> +		/* This Broadcom specific command changes the UART's controller
> +		 * clock for baud rate>  3000000.
> +		 */
> +		skb = __hci_cmd_sync(hdev, 0xfc45, 1,&clock, HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			int err = PTR_ERR(skb);
> +			BT_ERR("%s: BCM: failed to write clock command (%d)",
> +			       hdev->name, err);
> +			return err;
> +		}
> +
> +		kfree_skb(skb);
> +	}
> +
> +	BT_DBG("%s: Set Controller UART speed to %d bit/s", hdev->name, speed);
> +
> +	param.zero = cpu_to_le16(0);
> +	param.baud_rate = cpu_to_le32(speed);
> +
> +	/* This Broadcom specific command changes the UART's controller baud
> +	 * rate.
> +	 */
> +	skb = __hci_cmd_sync(hdev, 0xfc18, sizeof(param),&param,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		int err = PTR_ERR(skb);
> +		BT_ERR("%s: BCM: failed to write update baudrate command (%d)",
> +		       hdev->name, err);
> +		return err;
> +	}
> +
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
>   static int bcm_open(struct hci_uart *hu)
>   {
>   	struct bcm_data *bcm;
> @@ -107,6 +156,12 @@ static int bcm_setup(struct hci_uart *hu)
>   	if (hu->proto->init_speed)
>   		hci_uart_set_baudrate(hu, hu->proto->init_speed);
>
> +	if (hu->proto->oper_speed) {
> +		err = bcm_set_baudrate(hu, hu->proto->oper_speed);
> +		if (!err)
> +			hci_uart_set_baudrate(hu, hu->proto->oper_speed);
> +	}
> +
>   finalize:
>   	release_firmware(fw);
>
> @@ -162,10 +217,13 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
>   static const struct hci_uart_proto bcm_proto = {
>   	.id		= HCI_UART_BCM,
>   	.name		= "BCM",
> +	.init_speed	= 115200,
> +	.oper_speed	= 4000000,
>   	.open		= bcm_open,
>   	.close		= bcm_close,
>   	.flush		= bcm_flush,
>   	.setup		= bcm_setup,
> +	.set_baudrate	= bcm_set_baudrate,
>   	.recv		= bcm_recv,
>   	.enqueue	= bcm_enqueue,
>   	.dequeue	= bcm_dequeue,

