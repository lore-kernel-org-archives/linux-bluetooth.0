Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH v2] Bluetooth: hci_uart: Support firmware download for Marvell
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1455627233-6928-1-git-send-email-akarwar@marvell.com>
Date: Sat, 20 Feb 2016 00:07:19 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Nishant Sarmukadam <nishants@marvell.com>,
	linux-kernel@vger.kernel.org, Cathy Luo <cluo@marvell.com>,
	Ganapathi Bhat <gbhat@marvell.com>
Message-Id: <273F0F9E-5E5C-4F21-A503-027A83B7F61E@holtmann.org>
References: <1455627233-6928-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> This patch implement firmware download feature for
> Marvell Bluetooth devices. If firmware is already
> downloaded, it will skip downloading.
> 
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v2: Fixed compilation warning reported by kbuild test robot
> ---
> drivers/bluetooth/Kconfig     |  10 +
> drivers/bluetooth/Makefile    |   1 +
> drivers/bluetooth/btmrvl.h    |  38 +++
> drivers/bluetooth/hci_ldisc.c |  15 +-
> drivers/bluetooth/hci_mrvl.c  | 642 ++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/hci_uart.h  |  13 +-
> 6 files changed, 717 insertions(+), 2 deletions(-)
> create mode 100644 drivers/bluetooth/btmrvl.h
> create mode 100644 drivers/bluetooth/hci_mrvl.c
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index ec6af15..836f1c9 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -169,6 +169,16 @@ config BT_HCIUART_QCA
> 
> 	  Say Y here to compile support for QCA protocol.
> 
> +config BT_HCIUART_MRVL
> +	bool "Marvell protocol support"
> +	depends on BT_HCIUART
> +	help
> +	  Marvell is serial protocol for communication between Bluetooth
> +	  device and host. This protocol is required for most Marvell Bluetooth
> +	  devices with UART interface.
> +
> +	  Say Y here to compile support for HCI MRVL protocol.
> +
> config BT_HCIBCM203X
> 	tristate "HCI BCM203x USB driver"
> 	depends on USB
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 07c9cf3..f7cb408 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -36,6 +36,7 @@ hci_uart-$(CONFIG_BT_HCIUART_3WIRE)	+= hci_h5.o
> hci_uart-$(CONFIG_BT_HCIUART_INTEL)	+= hci_intel.o
> hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
> hci_uart-$(CONFIG_BT_HCIUART_QCA)	+= hci_qca.o
> +hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
> hci_uart-objs				:= $(hci_uart-y)
> 
> ccflags-y += -D__CHECK_ENDIAN__
> diff --git a/drivers/bluetooth/btmrvl.h b/drivers/bluetooth/btmrvl.h
> new file mode 100644
> index 0000000..6517cdd
> --- /dev/null
> +++ b/drivers/bluetooth/btmrvl.h
> @@ -0,0 +1,38 @@
> +/* Bluetooth support for Marvell devices
> + *
> + * Copyright (C) 2016, Marvell International Ltd.
> + *
> + * This software file (the "File") is distributed by Marvell International
> + * Ltd. under the terms of the GNU General Public License Version 2, June 1991
> + * (the "License").  You may use, redistribute and/or modify this File in
> + * accordance with the terms and conditions of the License, a copy of which
> + * is available on the worldwide web at
> + * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
> + *
> + * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
> + * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
> + * this warranty disclaimer.
> + */
> +
> +struct fw_data {
> +	wait_queue_head_t init_wait_q __aligned(4);
> +	u8 wait_fw;
> +	int next_len;
> +	u8 five_bytes[5];
> +	u8 next_index;
> +	u8 last_ack;
> +	u8 expected_ack;
> +	u8 fw_loaded;
> +	struct ktermios old_termios;
> +};
> +
> +#define MRVL_WAIT_TIMEOUT	12000
> +#define MRVL_MAX_FW_BLOCK_SIZE	1024
> +#define MRVL_MAX_RETRY_SEND	12
> +#define MRVL_DNLD_DELAY		100
> +#define MRVL_ACK		0x5A
> +#define MRVL_NAK		0xBF
> +#define MRVL_HDR_REQ_FW		0xA5
> +#define MRVL_HDR_CHIP_VER	0xAA
> +#define MRVL_HCI_OP_SET_BAUD	0xFC09
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 73202624..737a09f 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -163,7 +163,14 @@ restart:
> 		}
> 
> 		hci_uart_tx_complete(hu, hci_skb_pkt_type(skb));
> -		kfree_skb(skb);
> +#ifdef CONFIG_BT_HCIUART_MRVL
> +		if (hu->proto->id == HCI_UART_MRVL &&
> +		    !test_bit(HCI_UART_DNLD_FW, &hu->flags)) {
> +#endif
> +			kfree_skb(skb);
> +#ifdef CONFIG_BT_HCIUART_MRVL
> +		}
> +#endif

so this is not something we can do. You are adding vendor specific cruft to the generic part of the driver.

> 	}
> 
> 	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
> @@ -805,6 +812,9 @@ static int __init hci_uart_init(void)
> 	qca_init();
> #endif
> 
> +#ifdef CONFIG_BT_HCIUART_MRVL
> +	mrvl_init();
> +#endif
> 	return 0;
> }
> 
> @@ -836,6 +846,9 @@ static void __exit hci_uart_exit(void)
> #ifdef CONFIG_BT_HCIUART_QCA
> 	qca_deinit();
> #endif
> +#ifdef CONFIG_BT_HCIUART_MRVL
> +	mrvl_deinit();
> +#endif
> 
> 	/* Release tty registration of line discipline */
> 	err = tty_unregister_ldisc(N_HCI);
> diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
> new file mode 100644
> index 0000000..4704389
> --- /dev/null
> +++ b/drivers/bluetooth/hci_mrvl.c
> @@ -0,0 +1,642 @@
> +/* Bluetooth HCI UART driver for Marvell devices
> + *
> + * Copyright (C) 2016, Marvell International Ltd.
> + *
> + *  Acknowledgements:
> + *  This file is based on hci_h4.c, which was written
> + *  by Maxim Krasnyansky and Marcel Holtmann.
> + *
> + * This software file (the "File") is distributed by Marvell International
> + * Ltd. under the terms of the GNU General Public License Version 2, June 1991
> + * (the "License").  You may use, redistribute and/or modify this File in
> + * accordance with the terms and conditions of the License, a copy of which
> + * is available on the worldwide web at
> + * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
> + *
> + * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
> + * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
> + * this warranty disclaimer.
> + */
> +
> +#include <linux/module.h>
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/fcntl.h>
> +#include <linux/interrupt.h>
> +#include <linux/ptrace.h>
> +#include <linux/poll.h>
> +
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/signal.h>
> +#include <linux/ioctl.h>
> +#include <linux/skbuff.h>
> +#include <asm/unaligned.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "hci_uart.h"
> +#include <linux/proc_fs.h>
> +#include "btmrvl.h"
> +#include <linux/firmware.h>
> +#include <linux/version.h>

Global includes before local includes.

> +
> +struct mrvl_data {
> +	struct sk_buff *rx_skb;
> +	struct sk_buff_head txq;
> +	struct fw_data *fwdata;
> +};
> +
> +static char helper_name[128];
> +static char fw_name[128];

Global variables like this will not work. You might have more than one instances of this device.

> +
> +static int mrvl_init_fw_data(struct hci_uart *hu);
> +static int mrvl_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);

Why do we need forward declaration. That is not a good sign.

> +
> +/* Initialize protocol */
> +static int mrvl_open(struct hci_uart *hu)
> +{
> +	struct mrvl_data *mrvl;
> +
> +	BT_DBG("hu %p", hu);
> +
> +	mrvl = kzalloc(sizeof(*mrvl), GFP_KERNEL);
> +	if (!mrvl)
> +		return -ENOMEM;
> +
> +	skb_queue_head_init(&mrvl->txq);
> +	hu->priv = mrvl;
> +
> +	return 0;
> +}
> +
> +/* Flush protocol data */
> +static int mrvl_flush(struct hci_uart *hu)
> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +
> +	BT_DBG("hu %p", hu);
> +
> +	skb_queue_purge(&mrvl->txq);
> +
> +	return 0;
> +}
> +
> +/* Close protocol */
> +static int mrvl_close(struct hci_uart *hu)
> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +
> +	BT_DBG("hu %p", hu);
> +
> +	skb_queue_purge(&mrvl->txq);
> +	kfree_skb(mrvl->rx_skb);
> +	kfree(mrvl->fwdata);
> +	hu->priv = NULL;
> +	kfree(mrvl);
> +
> +	return 0;
> +}
> +
> +/* Enqueue frame for transmittion (padding, crc, etc) */
> +static int mrvl_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +
> +	if (test_bit(HCI_UART_DNLD_FW, &hu->flags))
> +		return -EBUSY;
> +
> +	BT_DBG("hu %p skb %p", hu, skb);
> +
> +	/* Prepend skb with frame type */
> +	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
> +	skb_queue_tail(&mrvl->txq, skb);
> +
> +	return 0;
> +}
> +
> +static const struct h4_recv_pkt mrvl_recv_pkts[] = {
> +	{ H4_RECV_ACL,   .recv = hci_recv_frame },
> +	{ H4_RECV_SCO,   .recv = hci_recv_frame },
> +	{ H4_RECV_EVENT, .recv = mrvl_recv_frame },
> +};
> +
> +static int mrvl_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	int ret;
> +
> +	ret = hci_recv_frame(hdev, skb);
> +
> +	return ret;
> +}
> +
> +/* Receive data */
> +static int mrvl_recv(struct hci_uart *hu, const void *data, int count)
> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +
> +	if (test_bit(HCI_UART_DNLD_FW, &hu->flags)) {
> +		hci_uart_recv_data(hu, (u8 *)data, count);
> +		return 0;
> +	}
> +
> +	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> +		return -EUNATCH;
> +
> +	mrvl->rx_skb = h4_recv_buf(hu->hdev, mrvl->rx_skb, data, count,
> +				   mrvl_recv_pkts, ARRAY_SIZE(mrvl_recv_pkts));
> +	if (IS_ERR(mrvl->rx_skb)) {
> +		int err = PTR_ERR(mrvl->rx_skb);
> +
> +		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
> +		mrvl->rx_skb = NULL;
> +		return err;
> +	}
> +
> +	return count;
> +}
> +
> +static struct sk_buff *mrvl_dequeue(struct hci_uart *hu)
> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +
> +	return skb_dequeue(&mrvl->txq);
> +}
> +
> +static int mrvl_setup(struct hci_uart *hu)
> +{
> +	mrvl_init_fw_data(hu);
> +	set_bit(HCI_UART_DNLD_FW, &hu->flags);
> +
> +	return hci_uart_dnld_fw(hu);
> +}
> +
> +static const struct hci_uart_proto mrvlp = {
> +	.id		= HCI_UART_MRVL,
> +	.name		= "MRVL",
> +	.open		= mrvl_open,
> +	.close		= mrvl_close,
> +	.recv		= mrvl_recv,
> +	.enqueue	= mrvl_enqueue,
> +	.dequeue	= mrvl_dequeue,
> +	.flush		= mrvl_flush,
> +	.setup		= mrvl_setup,
> +};
> +
> +int __init mrvl_init(void)
> +{
> +	return hci_uart_register_proto(&mrvlp);
> +}
> +
> +int __exit mrvl_deinit(void)
> +{
> +	return hci_uart_unregister_proto(&mrvlp);
> +}
> +
> +static int get_cts(struct tty_struct *tty)
> +{
> +	u32 state;
> +
> +	if (tty->ops->tiocmget) {
> +		state = tty->ops->tiocmget(tty);
> +		if (state & TIOCM_CTS) {
> +			BT_DBG("CTS is low\n");
> +			return 1;
> +		}
> +		BT_DBG("CTS is high\n");
> +		return 0;
> +	}
> +	return -1;
> +}
> +
> +static int mrvl_init_fw_data(struct hci_uart *hu)
> +{
> +	struct fw_data *fwdata;
> +	struct mrvl_data *mrvl = hu->priv;
> +
> +	fwdata = kzalloc(sizeof(*fwdata), GFP_KERNEL);
> +
> +	if (!fwdata) {
> +		BT_ERR("Can't allocate firmware data\n");
> +		return -ENOMEM;
> +	}
> +
> +	mrvl->fwdata = fwdata;
> +	fwdata->fw_loaded = 0;
> +
> +	init_waitqueue_head(&fwdata->init_wait_q);
> +
> +	return 0;
> +}
> +
> +/* Wait for the header from device */
> +static int mrvl_wait_for_hdr(struct hci_uart *hu, u8 header)
> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +	struct fw_data *fw_data = mrvl->fwdata;
> +
> +	fw_data->expected_ack = header;
> +	fw_data->wait_fw = 0;
> +
> +	if (!wait_event_interruptible_timeout(fw_data->init_wait_q,
> +					      fw_data->wait_fw,
> +					((MRVL_WAIT_TIMEOUT) * HZ / 1000))) {
> +		BT_ERR("TIMEOUT, waiting for:0x%x\n", fw_data->expected_ack);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Send bytes to device */
> +static int mrvl_send_data(struct hci_uart *hu, struct sk_buff *skb)
> +{
> +	int retry = 0;
> +	int skb_len;
> +
> +	skb_len = skb->len;
> +	while (retry < MRVL_MAX_RETRY_SEND) {
> +		hu->tx_skb = skb;
> +		hci_uart_tx_wakeup(hu);
> +		if (mrvl_wait_for_hdr(hu, MRVL_HDR_REQ_FW) == -1) {
> +			skb_push(skb, skb_len);
> +			retry++;
> +			continue;
> +		} else {
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
> +	BT_INFO("enter dnld_fw\n");
> +
> +	ret = request_firmware(&fw, file_name, &hdev->dev);
> +	if (ret < 0) {
> +		BT_ERR("request_firmware() failed\n");
> +		ret = -1;
> +		goto done;
> +	}
> +	if (fw) {
> +		BT_INFO("Downloading FW (%d bytes)\n", (u16)fw->size);
> +	} else {
> +		BT_ERR("No FW image found\n");
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	skb = bt_skb_alloc(MRVL_MAX_FW_BLOCK_SIZE, GFP_ATOMIC);
> +	if (!skb) {
> +		BT_ERR("cannot allocate memory for skb\n");
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
> +			BT_ERR("fail to download firmware\n");
> +			ret = -1;
> +			goto done;
> +		}
> +		skb_push(skb, tx_len);
> +		skb_trim(skb, 0);
> +		offset += tx_len;
> +	} while (1);
> +
> +	BT_INFO("downloaded %d byte firmware\n", offset);
> +done:
> +	if (fw)
> +		release_firmware(fw);
> +
> +	kfree(skb);
> +	BT_INFO("leave dnld_fw\n");
> +
> +	return ret;
> +}

I think it would help if you explain on how the firmware download for your UART devices work. I have the feeling we need a bit better core handling in this case and not end up hacking it in this way.

> +
> +/* Get standard baud rate, given the speed */
> +static unsigned int get_baud_rate(unsigned int speed)
> +{
> +	switch (speed) {
> +	case 9600:
> +		return B9600;
> +	case 19200:
> +		return B19200;
> +	case 38400:
> +		return B38400;
> +	case 57600:
> +		return B57600;
> +	case 115200:
> +		return B115200;
> +	case 230400:
> +		return B230400;
> +	case 460800:
> +		return B460800;
> +	case 921600:
> +		return B921600;
> +	case 2000000:
> +		return B2000000;
> +	case 3000000:
> +		return B3000000;
> +	default:
> +		return -1;
> +	}
> +}
> +
> +/* Set terminal properties */
> +static int mrvl_set_termios(struct tty_struct *tty, unsigned int speed,
> +			    unsigned char flow_ctl)
> +{
> +	struct ktermios old_termios = tty->termios;
> +	int baud;
> +
> +	tty->termios.c_cflag &= ~CBAUD;
> +	baud = get_baud_rate(speed);
> +
> +	if (baud == -1) {
> +		BT_ERR("Baud rate not supported\n");
> +		return -1;
> +	}
> +
> +	tty->termios.c_cflag |= baud;
> +
> +	if (flow_ctl)
> +		tty->termios.c_cflag |= CRTSCTS;
> +	else
> +		tty->termios.c_cflag &= ~CRTSCTS;
> +
> +	tty->ops->set_termios(tty, &old_termios);
> +
> +	return 0;
> +}
> +
> +/* Check if firmware is already loaded */
> +static bool mrvl_fw_loaded(struct hci_uart *hu)
> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +	struct fw_data *fw_data = mrvl->fwdata;
> +
> +	return get_cts(hu->tty) || fw_data->fw_loaded;
> +}
> +
> +/* Set the baud rate */
> +static int mrvl_set_baudrate(struct hci_uart *hu)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	struct sk_buff *skb;
> +	static const u8 baud_param[] = { 0xc0, 0xc6, 0x2d, 0x00};
> +	int err;
> +
> +	skb = __hci_cmd_sync(hdev, MRVL_HCI_OP_SET_BAUD, sizeof(baud_param),
> +			     baud_param, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		BT_ERR("%s: Set device baudrate failed (%d)", hdev->name, err);
> +		return err;
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> +/* Reset device */
> +static int mrvl_reset(struct hci_uart *hu)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	struct sk_buff *skb;
> +	int err;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		BT_ERR("%s: Reset device failed (%d)", hdev->name, err);
> +		return err;
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> +/* Download helper and firmare to device */
> +int hci_uart_dnld_fw(struct hci_uart *hu)
> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +	struct fw_data *fw_data = mrvl->fwdata;
> +	struct tty_struct *tty = hu->tty;
> +	struct ktermios new_termios;
> +	struct ktermios old_termios;
> +	int ret;
> +
> +	old_termios = tty->termios;
> +
> +	if (!tty) {
> +		BT_ERR("tty is null\n");
> +		clear_bit(HCI_UART_DNLD_FW, &hu->flags);
> +		ret = -1;
> +		goto fail;
> +	}
> +
> +	if (mrvl_fw_loaded(hu)) {
> +		BT_INFO("fw is running\n");
> +		clear_bit(HCI_UART_DNLD_FW, &hu->flags);
> +		goto set_term_baud;
> +	}
> +
> +	ret = mrvl_set_termios(tty, 115200, 0);
> +	if (ret)
> +		goto fail;
> +
> +	ret = mrvl_wait_for_hdr(hu, MRVL_HDR_REQ_FW);
> +	if (ret)
> +		goto fail;
> +
> +	ret = mrvl_dnld_fw(hu, helper_name);
> +	if (ret)
> +		goto fail;
> +
> +	mdelay(MRVL_DNLD_DELAY);
> +
> +	ret = mrvl_set_termios(tty, 3000000, 1);
> +	if (ret)
> +		goto fail;
> +
> +	ret = mrvl_wait_for_hdr(hu, MRVL_HDR_CHIP_VER);
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
> +	else
> +		fw_data->fw_loaded = 1;
> +
> +	mdelay(MRVL_DNLD_DELAY);
> +	/* restore uart settings */
> +	new_termios = tty->termios;
> +	tty->termios.c_cflag = old_termios.c_cflag;
> +	tty->ops->set_termios(tty, &new_termios);
> +	clear_bit(HCI_UART_DNLD_FW, &hu->flags);
> +
> +	ret = mrvl_reset(hu);
> +	if (ret)
> +		goto fail;
> +
> +	ret = mrvl_set_baudrate(hu);
> +	if (ret)
> +		goto fail;
> +
> +set_term_baud:
> +	ret = mrvl_set_termios(tty, 3000000, 1);
> +	if (ret)
> +		goto fail;
> +
> +	mdelay(MRVL_DNLD_DELAY);
> +
> +	return ret;
> +fail:
> +	/* restore uart settings */
> +	new_termios = tty->termios;
> +	tty->termios.c_cflag = old_termios.c_cflag;
> +	tty->ops->set_termios(tty, &new_termios);
> +	clear_bit(HCI_UART_DNLD_FW, &hu->flags);
> +
> +	return ret;
> +}
> +
> +static void mrvl_print_fw_data(u8 *buf)
> +{
> +	int i;
> +
> +	BT_DBG("\nfive_bytes:");
> +
> +	for (i = 0; i < 5; i++)
> +		BT_DBG(" 0x%x", buf[i]);
> +
> +	BT_DBG("\n");
> +}

This needs to away. It is your debug code that has no place upstream.

> +
> +/* Send ACK/NAK to the device */
> +static void mrvl_send_ack(struct hci_uart *hu, unsigned char ack)
> +{
> +	struct tty_struct *tty = hu->tty;
> +
> +	tty->ops->write(tty, &ack, sizeof(ack));
> +}
> +
> +/* Validate the feedback data from device */
> +static void mrvl_validate_hdr_and_len(struct hci_uart *hu, u8 *buf)
> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +	struct fw_data *fw_data = mrvl->fwdata;
> +	u16 lhs, rhs;
> +
> +	mrvl_print_fw_data(buf);
> +	lhs = *((u16 *)(&buf[1]));
> +	rhs = *((u16 *)(&buf[3]));

I bet you that you really wanted to use aligned access and also consider endianness.

> +	if ((lhs ^ rhs) == 0xffff) {
> +		mrvl_send_ack(hu, MRVL_ACK);
> +		fw_data->wait_fw = 1;
> +		fw_data->next_len = lhs;
> +		/*firmware download is done, send the last ack*/
> +		if (!lhs)
> +			fw_data->last_ack = 1;
> +		wake_up_interruptible(&fw_data->init_wait_q);
> +	} else {
> +		mrvl_send_ack(hu, MRVL_NAK);
> +	}
> +}
> +
> +void hci_uart_recv_data(struct hci_uart *hu, u8 *buf, int len)
> +{
> +	struct mrvl_data *mrvl = hu->priv;
> +	struct fw_data *fw_data = mrvl->fwdata;
> +	int i = 0;
> +
> +	if (len < 5) {
> +		if ((!fw_data->next_index) &&
> +		    (buf[0] != fw_data->expected_ack)) {
> +			/*ex: XX XX XX*/
> +			return;
> +		}
> +	} else if (len == 5) {
> +		if (buf[0] != fw_data->expected_ack) {
> +			/*ex: XX XX XX XX XX*/
> +			return;
> +		}
> +		/*ex: 5A LL LL LL LL*/
> +		fw_data->next_index = 0;
> +		mrvl_validate_hdr_and_len(hu, buf);
> +		return;
> +	} else if (len > 5) {
> +		i = 0;
> +
> +		while ((i < len) && (buf[i] != fw_data->expected_ack))
> +			i++;
> +
> +		if (i == len) {
> +			return;
> +		} else if ((len - i) >= 5 &&
> +			   (buf[i] == fw_data->expected_ack)) {
> +			/*ex: 00 00 00 00 a5 LL LL LL LL*/
> +			/*ex: a5 LL LL LL LL 00 00 00 00*/
> +			/*ex: 00 00 a5 LL LL LL LL 00 00*/
> +			/*ex: a5 LL LL LL LL*/
> +			fw_data->next_index = 0;
> +			mrvl_validate_hdr_and_len(hu, buf + i);
> +			return;
> +		} else if (buf[i] == fw_data->expected_ack) {
> +			/*ex: 00 00 00 00 a5 LL LL*/
> +			hci_uart_recv_data(hu, buf + i, len - i);
> +		}

Why is this if { } else if {} if you always use return to leave the function. Just break out of the function and don't bother with this heavy nesting.

> +	}
> +
> +	for (i = 0; i < len; i++) {
> +		fw_data->five_bytes[fw_data->next_index] = buf[i];
> +		if (++fw_data->next_index == 5) {
> +			mrvl_validate_hdr_and_len(hu, fw_data->five_bytes);
> +			fw_data->next_index = 0;
> +			return;
> +		}
> +	}
> +}
> +
> +module_param_string(helper_name, helper_name, sizeof(helper_name), 0);
> +MODULE_PARM_DESC(helper_name, "helper file name");
> +
> +module_param_string(fw_name, fw_name, sizeof(fw_name), 0);
> +MODULE_PARM_DESC(fw_name, "firmware name");

I am not a big fan of this overwrite from modules parameters. Also if not set, the driver should be able to pick the right firmware.

> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 82c92f1..206677c 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -35,7 +35,7 @@
> #define HCIUARTGETFLAGS		_IOR('U', 204, int)
> 
> /* UART protocols */
> -#define HCI_UART_MAX_PROTO	9
> +#define HCI_UART_MAX_PROTO	10
> 
> #define HCI_UART_H4	0
> #define HCI_UART_BCSP	1
> @@ -46,6 +46,7 @@
> #define HCI_UART_INTEL	6
> #define HCI_UART_BCM	7
> #define HCI_UART_QCA	8
> +#define HCI_UART_MRVL	9
> 
> #define HCI_UART_RAW_DEVICE	0
> #define HCI_UART_RESET_ON_INIT	1
> @@ -94,11 +95,16 @@ struct hci_uart {
> /* HCI_UART proto flag bits */
> #define HCI_UART_PROTO_SET	0
> #define HCI_UART_REGISTERED	1
> +#define HCI_UART_DNLD_FW	3
> 
> /* TX states  */
> #define HCI_UART_SENDING	1
> #define HCI_UART_TX_WAKEUP	2
> 
> +#ifdef CONFIG_BT_HCIUART_MRVL
> +void hci_uart_recv_data(struct hci_uart *hu, u8 *buf, int len);
> +int hci_uart_dnld_fw(struct hci_uart *hu);
> +#endif
> int hci_uart_register_proto(const struct hci_uart_proto *p);
> int hci_uart_unregister_proto(const struct hci_uart_proto *p);
> int hci_uart_tx_wakeup(struct hci_uart *hu);
> @@ -182,3 +188,8 @@ int bcm_deinit(void);
> int qca_init(void);
> int qca_deinit(void);
> #endif
> +
> +#ifdef CONFIG_BT_HCIUART_MRVL
> +int mrvl_init(void);
> +int mrvl_deinit(void);
> +#endif

Regards

Marcel
