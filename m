Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <56ED9D81.2040205@intel.com>
Date: Sat, 19 Mar 2016 19:42:09 +0100
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Amitkumar Karwar <akarwar@marvell.com>,
	linux-bluetooth@vger.kernel.org
CC: Cathy Luo <cluo@marvell.com>, linux-kernel@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	Ganapathi Bhat <gbhat@marvell.com>
Subject: Re: [PATCH v5] Bluetooth: hci_uart: Support firmware download for
 Marvell
References: <1458224493-19096-1-git-send-email-akarwar@marvell.com> <1458224493-19096-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1458224493-19096-2-git-send-email-akarwar@marvell.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

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
> v5: Addresses review comments from Loic Poulain
>      a) Use bt_dev_err/warn/dbg helpers insted of BT_ERR/WARN/DBG
>      b) Used static functions where required and removed forward delcarations
>      c) Edited comments for the function hci_uart_recv_data
>      d) Made HCI_UART_DNLD_FW flag a part of driver private data
> ---
>   drivers/bluetooth/Kconfig     |  10 +
>   drivers/bluetooth/Makefile    |   1 +
>   drivers/bluetooth/btmrvl.h    |  41 +++
>   drivers/bluetooth/hci_ldisc.c |   6 +
>   drivers/bluetooth/hci_mrvl.c  | 592 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/hci_uart.h  |   8 +-
>   6 files changed, 657 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/bluetooth/btmrvl.h
>   create mode 100644 drivers/bluetooth/hci_mrvl.c
>

> +
> +/* This function receives data from the uart device during firmware download.
> + * Driver expects 5 bytes of data as per the protocal in the below format:
> + * <HEADER><BYTE_1><BYTE_2><BYTE_3><BYTE_4>
> + * BYTE_3 and BYTE_4 are compliment of BYTE_1 an BYTE_2. Data can come in chunks
> + * of any length. If length received is < 5, accumulate the data in an array,
> + * until we have a sequence of 5 bytes, starting with the expected HEADER. If
> + * the length received is > 5  bytes, then get the first 5 bytes, starting with
> + * the HEADER and process the same, ignoring the rest of the bytes as per the
> + * protocal.
> + */
> +static void hci_uart_recv_data(struct hci_uart *hu, u8 *buf, int len)
> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +	struct fw_data *fw_data = mrvl->fwdata;
> +	int i = 0;
> +
> +	if (len < 5) {

You want to accumulate your data in a buf/skb, once the size of your
buffer matches your packet expected size, call a mrvl_pkt_complete(hu, 
skb). This is the len of your current buffer you want to test, not
the current len. Keep it simple.

> +		if ((!fw_data->next_index) &&
> +		    (buf[0] != fw_data->expected_ack)) {
> +			return;
> +		}
> +	}
> +
> +	if (len == 5) {
> +		if (buf[0] != fw_data->expected_ack)
> +			return;
> +
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
> +		if (i == len)
> +			return;
> +
> +		if ((len - i) >= 5) {
> +			fw_data->next_index = 0;
> +			mrvl_validate_hdr_and_len(hu, buf + i);
> +			return;
> +		}
> +
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
> +

> +
> +/* Send bytes to device */
> +static int mrvl_send_data(struct hci_uart *hu, struct sk_buff *skb)
> +{
> +	struct tty_struct *tty = hu->tty;
> +	int retry = 0;
> +	int skb_len;
> +
> +	skb_len = skb->len;
> +	while (retry < MRVL_MAX_RETRY_SEND) {
> +		tty->ops->write(tty, skb->data, skb->len);

You should test write returned value (look at hci_uart_write_work).
I don't understand why you don't enqueue your packet in your existing
tx queue to let hci_ldisc taking care writing to the tty layer.
skb_queue_head(&mrvl->txq, skb);
hci_uart_tx_wakeup(hu);

> +		if (mrvl_wait_for_hdr(hu, MRVL_HDR_REQ_FW) == -1) {
> +			retry++;
> +			continue;
> +		} else {
> +			skb_pull(skb, skb_len);
> +			break;
> +		}
> +	}
> +	if (retry == MRVL_MAX_RETRY_SEND)
> +		return -1;
> +
> +	return 0;
> +}
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
> +		bt_dev_err(hu->hdev, "request_firmware() failed");
> +		ret = -1;
> +		goto done;

Why you don't just return here, nothing to do in done.

> +	}
> +	if (fw) {

You already tested request_firmware output, don't need to test fw.

> +		bt_dev_info(hu->hdev, "Downloading FW (%d bytes)",
> +			    (u16)fw->size);
> +	} else {
> +		bt_dev_err(hu->hdev, "No FW image found");
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	skb = bt_skb_alloc(MRVL_MAX_FW_BLOCK_SIZE, GFP_ATOMIC);

Why GFP_ATOMIC, use GFP_KERNEL, you are allowed to sleep here.

> +	if (!skb) {
> +		bt_dev_err(hu->hdev, "cannot allocate memory for skb");
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	skb->dev = (void *)hdev;
> +	fw_data->last_ack = 0;
> +
> +	do {
> +		if ((offset >= fw->size) || (fw_data->last_ack))
> +			break;
> +		tx_len = fw_data->next_len;
> +		if ((fw->size - offset) < tx_len)
> +			tx_len = fw->size - offset;
> +
> +		memcpy(skb->data, &fw->data[offset], tx_len);
> +		skb_put(skb, tx_len);
> +		if (mrvl_send_data(hu, skb) != 0) {
> +			bt_dev_err(hu->hdev, "fail to download firmware");
> +			ret = -1;
> +			goto done;
> +		}
> +		skb_push(skb, tx_len);
> +		skb_trim(skb, 0);
> +		offset += tx_len;
> +	} while (1);
> +
> +	bt_dev_info(hu->hdev, "downloaded %d byte firmware", offset);
> +done:
> +	if (fw)

I think fw can be unassigned if you come from request_firmware error.
Just return on request firmware issue and release firmware
unconditionally here.

> +		release_firmware(fw);
> +
> +	kfree(skb);
> +	return ret;
> +}
> +
> +/* Set the baud rate */
> +static int mrvl_set_dev_baud(struct hci_uart *hu)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	struct sk_buff *skb;
> +	static const u8 baud_param[] = { 0xc0, 0xc6, 0x2d, 0x00};
Missing space before closing bracket.

> +	int err;
> +
> +	skb = __hci_cmd_sync(hdev, MRVL_HCI_OP_SET_BAUD, sizeof(baud_param),
> +			     baud_param, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hu->hdev, "Set device baudrate failed (%d)", err);
> +		return err;
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> +
> +/* Download helper and firmare to device */
> +static int hci_uart_dnld_fw(struct hci_uart *hu)
> +{
> +	struct tty_struct *tty = hu->tty;
> +	struct ktermios new_termios;
> +	struct ktermios old_termios;
> +	struct mrvl_data *mrvl = hu->priv;
> +	char fw_name[128];
> +	int ret;
> +
> +	old_termios = tty->termios;
> +
> +	if (!tty) {

Seems to be useless, tty should not be null here.

> +		bt_dev_err(hu->hdev, "tty is null");
> +		clear_bit(HCI_UART_DNLD_FW, &mrvl->flags);
> +		ret = -1;
> +		goto fail;
> +	}
> +
> +	if (get_cts(hu)) {
> +		bt_dev_info(hu->hdev, "fw is running");
> +		clear_bit(HCI_UART_DNLD_FW, &mrvl->flags);
> +		goto set_baud;
> +	}
> +
> +	hci_uart_set_baudrate(hu, 115200);
> +	hci_uart_set_flow_control(hu, true);
> +
> +	ret = mrvl_wait_for_hdr(hu, MRVL_HDR_REQ_FW);
> +	if (ret)
> +		goto fail;
> +
> +	ret = mrvl_dnld_fw(hu, MRVL_HELPER_NAME);
> +	if (ret)
> +		goto fail;
> +
> +	msleep(MRVL_DNLD_DELAY);
> +
> +	hci_uart_set_baudrate(hu, 3000000);
> +	hci_uart_set_flow_control(hu, false);
> +
> +	ret = mrvl_get_fw_name(hu, fw_name);
> +	if (ret)
> +		goto fail;
> +
> +	ret = mrvl_wait_for_hdr(hu, MRVL_HDR_REQ_FW);
> +	if (ret)
> +		goto fail;
> +
> +	ret = mrvl_dnld_fw(hu, fw_name);
> +	if (ret)
> +		goto fail;
> +
> +	msleep(MRVL_DNLD_DELAY);
> +	/* restore uart settings */
> +	new_termios = tty->termios;
> +	tty->termios.c_cflag = old_termios.c_cflag;
> +	tty_set_termios(tty, &new_termios);
> +	clear_bit(HCI_UART_DNLD_FW, &mrvl->flags);
> +
> +set_baud:
> +	ret = mrvl_set_baud(hu);
> +	if (ret)
> +		goto fail;
> +
> +	msleep(MRVL_DNLD_DELAY);
> +
> +	return ret;
> +fail:
> +	/* restore uart settings */
> +	new_termios = tty->termios;
> +	tty->termios.c_cflag = old_termios.c_cflag;
> +	tty_set_termios(tty, &new_termios);
> +	clear_bit(HCI_UART_DNLD_FW, &mrvl->flags);
> +
> +	return ret;
> +}
> +

Regards,
Loic
-- 
Intel Open Source Technology Center
http://oss.intel.com/
