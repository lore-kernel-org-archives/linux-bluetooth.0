Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <56E6DEC6.2070709@intel.com>
Date: Mon, 14 Mar 2016 16:54:46 +0100
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Amitkumar Karwar <akarwar@marvell.com>,
	linux-bluetooth@vger.kernel.org
CC: Cathy Luo <cluo@marvell.com>, linux-kernel@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	Ganapathi Bhat <gbhat@marvell.com>
Subject: Re: [PATCH v4] Bluetooth: hci_uart: Support firmware download for
 Marvell
References: <1457006200-8132-1-git-send-email-akarwar@marvell.com> <1457006200-8132-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1457006200-8132-2-git-send-email-akarwar@marvell.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

Quick review inline.

On 03/03/2016 12:56, Amitkumar Karwar wrote:
> From: Ganapathi Bhat <gbhat@marvell.com>
>
> This patch implement firmware download feature for
> Marvell Bluetooth devices. If firmware is already
> downloaded, it will skip downloading.
>
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v2: Fixed compilation warning reported by kbuild test robot
> v3: Addressed review comments from Marcel Holtmann
>      a) Removed vendor specific code from hci_ldisc.c
>      b) Get rid of static forward declaration
>      c) Removed unnecessary heavy nesting
>      d) Git rid of module parameter and global variables
>      e) Add logic to pick right firmware image
> v4: Addresses review comments from Alan
>      a) Use existing kernel helper APIs instead of writing own.
>      b) Replace mdelay() with msleep()
> ---
>   drivers/bluetooth/Kconfig     |  10 +
>   drivers/bluetooth/Makefile    |   1 +
>   drivers/bluetooth/btmrvl.h    |  41 +++
>   drivers/bluetooth/hci_ldisc.c |   6 +
>   drivers/bluetooth/hci_mrvl.c  | 585 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/hci_uart.h  |  13 +-
>   6 files changed, 655 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/bluetooth/btmrvl.h
>   create mode 100644 drivers/bluetooth/hci_mrvl.c
>

> +
> +/* Download firmware to the device */
> +static int mrvl_dnld_fw(struct hci_uart *hu, const char *file_name)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	const struct firmware *fw;
> +	struct sk_buff *skb = NULL;
> +	int offset = 0;
> +	int ret, tx_len;
> +	struct mrvl_data *mrvl = hu->priv;
> +	struct fw_data *fw_data = mrvl->fwdata;
> +
> +	ret = request_firmware(&fw, file_name, &hdev->dev);
> +	if (ret < 0) {
> +		BT_ERR("request_firmware() failed");

Overall comment, You should use bt_dev_err/warn/dbg helpers when
relevant.

> +
> +void hci_uart_recv_data(struct hci_uart *hu, u8 *buf, int len)

Why this is not a static function ?

> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +	struct fw_data *fw_data = mrvl->fwdata;
> +	int i = 0;
> +
> +	if (len < 5) {

Be careful, here you seem to suppose that tty layer provides well 
shaped/non-split marvell packets. But this is just a byte stream, you
can receive bytes one by one or more than you expect.

> +		if ((!fw_data->next_index) &&
> +		    (buf[0] != fw_data->expected_ack)) {
> +			/*ex: XX XX XX*/
> +			return;
> +		}
> +	}
> +
> +	if (len == 5) {
> +		if (buf[0] != fw_data->expected_ack) {
> +			/*ex: XX XX XX XX XX*/
> +			return;
> +		}
> +		/*ex: 5A LL LL LL LL*/
> +		fw_data->next_index = 0;
> +		mrvl_validate_hdr_and_len(hu, buf);
> +		return;
> +	}
> +
> +	if (len > 5) {
> +		i = 0;
> +
> +		while ((i < len) && (buf[i] != fw_data->expected_ack))
> +			i++;
> +
> +		if (i == len) {
> +			/* Could not find a header */
> +			return;
> +		}
> +
> +		if ((len - i) >= 5) {
> +			/*ex: 00 00 00 00 a5 LL LL LL LL*/
> +			/*ex: a5 LL LL LL LL 00 00 00 00*/
> +			/*ex: 00 00 a5 LL LL LL LL 00 00*/
> +			/*ex: a5 LL LL LL LL*/

Check all your comments and respect Linux Kernel coding style.
Add short explanation of the expected data format.

> +			fw_data->next_index = 0;
> +			mrvl_validate_hdr_and_len(hu, buf + i);
> +			return;
> +		}
> +
> +		/*ex: 00 00 00 00 a5 LL LL*/
> +		hci_uart_recv_data(hu, buf + i, len - i);
> +		return;
> +	}
> +
> +	for (i = 0; i < len; i++) {
> +		fw_data->five_bytes[fw_data->next_index] = buf[i];
> +		if (++fw_data->next_index == 5) {
> +			fw_data->next_index = 0;
> +			mrvl_validate_hdr_and_len(hu, fw_data->five_bytes);
> +			return;
> +		}
> +	}
> +}

I think you should rework this function and make it more comprehensible.
h4_recv_buf or h5_recv are good examples.

> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 4814ff0..245cab58 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -35,7 +35,7 @@
>   #define HCIUARTGETFLAGS		_IOR('U', 204, int)
>
>   /* UART protocols */
> -#define HCI_UART_MAX_PROTO	10
> +#define HCI_UART_MAX_PROTO	11
>
>   #define HCI_UART_H4	0
>   #define HCI_UART_BCSP	1
> @@ -47,6 +47,7 @@
>   #define HCI_UART_BCM	7
>   #define HCI_UART_QCA	8
>   #define HCI_UART_AG6XX	9
> +#define HCI_UART_MRVL	10
>
>   #define HCI_UART_RAW_DEVICE	0
>   #define HCI_UART_RESET_ON_INIT	1
> @@ -95,11 +96,16 @@ struct hci_uart {
>   /* HCI_UART proto flag bits */
>   #define HCI_UART_PROTO_SET	0
>   #define HCI_UART_REGISTERED	1
> +#define HCI_UART_DNLD_FW	2

This flag is specific and should be part of your proto private data 
(mrvl_data).

>
>   /* TX states  */
>   #define HCI_UART_SENDING	1
>   #define HCI_UART_TX_WAKEUP	2
>
> +#ifdef CONFIG_BT_HCIUART_MRVL
> +void hci_uart_recv_data(struct hci_uart *hu, u8 *buf, int len);
> +int hci_uart_dnld_fw(struct hci_uart *hu);

Why you declare these functions here ?


Regards,
Loic
-- 
Intel Open Source Technology Center
http://oss.intel.com/
