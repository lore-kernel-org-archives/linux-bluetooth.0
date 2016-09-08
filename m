Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Loic Poulain <loic.poulain@intel.com>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        Ganapathi Bhat
	<gbhat@marvell.com>
Subject: RE: [PATCH v12 3/3] Bluetooth: hci_uart: Support firmware download
 for Marvell
Date: Thu, 8 Sep 2016 14:35:18 +0000
Message-ID: <c00ece531ddb4653b819d70d9c32bfd8@SC-EXCH04.marvell.com>
References: <1470760353-2394-1-git-send-email-akarwar@marvell.com>
 <1470760353-2394-3-git-send-email-akarwar@marvell.com>
 <57B2C5B7.7010405@intel.com>
In-Reply-To: <57B2C5B7.7010405@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

Thanks for your comments.

> -----Original Message-----
> From: Loic Poulain [mailto:loic.poulain@intel.com]
> Sent: Tuesday, August 16, 2016 1:20 PM
> To: Amitkumar Karwar; linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-rockchip@lists.infradead.org;
> marcel@holtmann.org; Ganapathi Bhat
> Subject: Re: [PATCH v12 3/3] Bluetooth: hci_uart: Support firmware
> download for Marvell
>=20
> Hi Amit,
>=20
> On 09/08/2016 18:32, Amitkumar Karwar wrote:
> > From: Ganapathi Bhat <gbhat@marvell.com>
> >
> > This patch implement firmware download feature for Marvell Bluetooth
> > devices. If firmware is already downloaded, it will skip downloading.
> >
> > Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> > Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> > Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > ---
> > v2: Fixed compilation warning reported by kbuild test robot
> > v3: Addressed review comments from Marcel Holtmann
> >      a) Removed vendor specific code from hci_ldisc.c
> >      b) Get rid of static forward declaration
> >      c) Removed unnecessary heavy nesting
> >      d) Git rid of module parameter and global variables
> >      e) Add logic to pick right firmware image
> > v4: Addresses review comments from Alan
> >      a) Use existing kernel helper APIs instead of writing own.
> >      b) Replace mdelay() with msleep()
> > v5: Addresses review comments from Loic Poulain
> >      a) Use bt_dev_err/warn/dbg helpers insted of BT_ERR/WARN/DBG
> >      b) Used static functions where required and removed forward
> delcarations
> >      c) Edited comments for the function hci_uart_recv_data
> >      d) Made HCI_UART_DNLD_FW flag a part of driver private data
> > v6: Addresses review comments from Loic Poulain
> >      a) Used skb instead of array to store firmware data during
> download
> >      b) Used hci_uart_tx_wakeup and enqueued packets instead of tty
> write
> >      c) Used GFP_KERNEL instead of GFP_ATOMIC
> > v7: Edited Kconfig to add dependency for BT_HCIUART_H4. The change
> resolves
> >      errors reported by kbuild test robot.
> > v8: Addressed review comments from Marcel Holtmann
> >      a) Removed unnecessary memory allocation failure messages
> >      b) Get rid of btmrvl.h header file and add definitions in
> > hci_mrvl.c file
> > v9: Addressed review comments from Marcel Holtmann
> >      a) Moved firmware download code from setup to prepare handler.
> >      b) Change messages from bt_dev_*->BT_*, as hdev isn't available
> during firmware
> >       download.
> > v10: Addressed review comments from Marcel Holtmann
> >      a) Added new callback recv_for_prepare to receive data from
> device
> >       during prepare phase
> >      b) Avoided using private flags (HCI_UART_DNLD_FW) as new receive
> callback is
> >       added for the same purpose
> >      c) Used kernel API to handle unaligned data
> >      d) Moved mrvl_set_baud functionality inside setup callback
> > v11: Write data through ldisc in mrvl_send_ack() instead of directly
> calling
> >      write method(One Thousand Gnomes).
> > v12: a) Check for buffer length before copying to skb (Loic Poulain)
> >       b) Rearrange skb memory allocation check
> > ---
> >   drivers/bluetooth/Kconfig     |  11 +
> >   drivers/bluetooth/Makefile    |   1 +
> >   drivers/bluetooth/hci_ldisc.c |   6 +
> >   drivers/bluetooth/hci_mrvl.c  | 545
> ++++++++++++++++++++++++++++++++++++++++++
> >   drivers/bluetooth/hci_uart.h  |   8 +-
> >   5 files changed, 570 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/bluetooth/hci_mrvl.c
> >
> > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> > index cf50fd2..daafd0c 100644
> > --- a/drivers/bluetooth/Kconfig
> > +++ b/drivers/bluetooth/Kconfig
> > @@ -180,6 +180,17 @@ config BT_HCIUART_AG6XX
> >
> >   	  Say Y here to compile support for Intel AG6XX protocol.
> >
> > +config BT_HCIUART_MRVL
> > +	bool "Marvell protocol support"
> > +	depends on BT_HCIUART
> > +	select BT_HCIUART_H4
> > +	help
> > +	  Marvell is serial protocol for communication between Bluetooth
> > +	  device and host. This protocol is required for most Marvell
> Bluetooth
> > +	  devices with UART interface.
> > +
> > +	  Say Y here to compile support for HCI MRVL protocol.
> > +
> >   config BT_HCIBCM203X
> >   	tristate "HCI BCM203x USB driver"
> >   	depends on USB
> > diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> > index 9c18939..364dbb6 100644
> > --- a/drivers/bluetooth/Makefile
> > +++ b/drivers/bluetooth/Makefile
> > @@ -37,6 +37,7 @@ hci_uart-$(CONFIG_BT_HCIUART_INTEL)	+=3D hci_intel.o
> >   hci_uart-$(CONFIG_BT_HCIUART_BCM)	+=3D hci_bcm.o
> >   hci_uart-$(CONFIG_BT_HCIUART_QCA)	+=3D hci_qca.o
> >   hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+=3D hci_ag6xx.o
> > +hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+=3D hci_mrvl.o
> >   hci_uart-objs				:=3D $(hci_uart-y)
> >
> >   ccflags-y +=3D -D__CHECK_ENDIAN__
> > diff --git a/drivers/bluetooth/hci_ldisc.c
> > b/drivers/bluetooth/hci_ldisc.c index 2c88586..ded13d3 100644
> > --- a/drivers/bluetooth/hci_ldisc.c
> > +++ b/drivers/bluetooth/hci_ldisc.c
> > @@ -821,6 +821,9 @@ static int __init hci_uart_init(void)
> >   #ifdef CONFIG_BT_HCIUART_AG6XX
> >   	ag6xx_init();
> >   #endif
> > +#ifdef CONFIG_BT_HCIUART_MRVL
> > +	mrvl_init();
> > +#endif
> >
> >   	return 0;
> >   }
> > @@ -856,6 +859,9 @@ static void __exit hci_uart_exit(void)
> >   #ifdef CONFIG_BT_HCIUART_AG6XX
> >   	ag6xx_deinit();
> >   #endif
> > +#ifdef CONFIG_BT_HCIUART_MRVL
> > +	mrvl_deinit();
> > +#endif
> >
> >   	/* Release tty registration of line discipline */
> >   	err =3D tty_unregister_ldisc(N_HCI);
> > diff --git a/drivers/bluetooth/hci_mrvl.c
> > b/drivers/bluetooth/hci_mrvl.c new file mode 100644 index
> > 0000000..c993c1b
> > --- /dev/null
> > +++ b/drivers/bluetooth/hci_mrvl.c
> > @@ -0,0 +1,545 @@
> > +/* Bluetooth HCI UART driver for Marvell devices
> > + *
> > + * Copyright (C) 2016, Marvell International Ltd.
> > + *
> > + *  Acknowledgements:
> > + *  This file is based on hci_h4.c, which was written
> > + *  by Maxim Krasnyansky and Marcel Holtmann.
> > + *
> > + * This software file (the "File") is distributed by Marvell
> > +International
> > + * Ltd. under the terms of the GNU General Public License Version 2,
> > +June 1991
> > + * (the "License").  You may use, redistribute and/or modify this
> > +File in
> > + * accordance with the terms and conditions of the License, a copy of
> > +which
> > + * is available on the worldwide web at
> > + * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
> > + *
> > + * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND
> > +THE
> > + * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR
> > +PURPOSE
> > + * ARE EXPRESSLY DISCLAIMED.  The License provides additional details
> > +about
> > + * this warranty disclaimer.
> > + */
> > +
> > +#include <linux/firmware.h>
> > +#include <linux/tty.h>
> > +#include <asm/unaligned.h>
> > +#include <net/bluetooth/bluetooth.h>
> > +#include <net/bluetooth/hci_core.h>
> > +#include "hci_uart.h"
> > +
> > +struct fw_data {
> > +	wait_queue_head_t init_wait_q;
> > +	u8 wait_fw;
> > +	int next_len;
> > +	u8 five_bytes[5];
> > +	u8 next_index;
> > +	u8 last_ack;
> > +	u8 expected_ack;
> > +	struct ktermios old_termios;
> > +	u8 chip_id;
> > +	u8 chip_rev;
> > +	struct sk_buff *skb;
> > +};
> > +
> > +#define MRVL_HELPER_NAME	"mrvl/helper_uart_3000000.bin"
> > +#define MRVL_8997_CHIP_ID	0x50
> > +#define MRVL_8997_FW_NAME	"mrvl/uart8997_bt.bin"
> > +#define MRVL_MAX_FW_BLOCK_SIZE	1024
> > +#define MRVL_MAX_RETRY_SEND	12
> > +#define MRVL_DNLD_DELAY		100
> > +#define MRVL_ACK		0x5A
> > +#define MRVL_NAK		0xBF
> > +#define MRVL_HDR_REQ_FW		0xA5
> > +#define MRVL_HDR_CHIP_VER	0xAA
> > +#define MRVL_HCI_OP_SET_BAUD	0xFC09
> > +#define MRVL_FW_HDR_LEN		5
> > +#define MRVL_WAIT_TIMEOUT	msecs_to_jiffies(12000)
> > +
> > +struct mrvl_data {
> > +	struct sk_buff *rx_skb;
> > +	struct sk_buff_head txq;
> > +	struct fw_data *fwdata;
> > +};
> > +
> > +static int get_cts(struct hci_uart *hu) {
> > +	struct tty_struct *tty =3D hu->tty;
> > +	u32 state =3D  tty->ops->tiocmget(tty);
> > +
> > +	if (state & TIOCM_CTS) {
> > +		bt_dev_dbg(hu->hdev, "CTS is low");
> > +		return 1;
> > +	}
> > +	bt_dev_dbg(hu->hdev, "CTS is high");
> > +
> > +	return 0;
> > +}
> > +
> > +/* Initialize protocol */
> > +static int mrvl_open(struct hci_uart *hu) {
> > +	struct mrvl_data *mrvl;
> > +
> > +	bt_dev_dbg(hu->hdev, "hu %p", hu);
> > +
> > +	mrvl =3D kzalloc(sizeof(*mrvl), GFP_KERNEL);
> > +	if (!mrvl)
> > +		return -ENOMEM;
> > +
> > +	skb_queue_head_init(&mrvl->txq);
> > +	hu->priv =3D mrvl;
> > +
> > +	return 0;
> > +}
> > +
> > +/* Flush protocol data */
> > +static int mrvl_flush(struct hci_uart *hu) {
> > +	struct mrvl_data *mrvl =3D hu->priv;
> > +
> > +	bt_dev_dbg(hu->hdev, "hu %p", hu);
> > +
> > +	skb_queue_purge(&mrvl->txq);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Close protocol */
> > +static int mrvl_close(struct hci_uart *hu) {
> > +	struct mrvl_data *mrvl =3D hu->priv;
> > +
> > +	bt_dev_dbg(hu->hdev, "hu %p", hu);
> > +
> > +	skb_queue_purge(&mrvl->txq);
> > +	kfree_skb(mrvl->rx_skb);
> > +	hu->priv =3D NULL;
> > +	kfree(mrvl);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Enqueue frame for transmittion (padding, crc, etc) */ static int
> > +mrvl_enqueue(struct hci_uart *hu, struct sk_buff *skb) {
> > +	struct mrvl_data *mrvl =3D hu->priv;
> > +
> > +	bt_dev_dbg(hu->hdev, "hu %p skb %p", hu, skb);
> > +
> > +	/* Prepend skb with frame type */
> > +	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
> > +	skb_queue_tail(&mrvl->txq, skb);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct h4_recv_pkt mrvl_recv_pkts[] =3D {
> > +	{ H4_RECV_ACL,   .recv =3D hci_recv_frame },
> > +	{ H4_RECV_SCO,   .recv =3D hci_recv_frame },
> > +	{ H4_RECV_EVENT, .recv =3D hci_recv_frame }, };
> > +
> > +/* Send ACK/NAK to the device */
> > +static void mrvl_send_ack(struct hci_uart *hu, unsigned char ack) {
> > +	struct mrvl_data *mrvl =3D hu->priv;
> > +	struct sk_buff *skb =3D NULL;
> > +
> > +	skb =3D bt_skb_alloc(sizeof(ack), GFP_KERNEL);
> > +	if (!skb)
> > +		return;
> > +
> > +	memcpy(skb->data, &ack, sizeof(ack));
> > +	skb_put(skb, sizeof(ack));
> > +	skb_queue_head(&mrvl->txq, skb);
> > +	hci_uart_tx_wakeup(hu);
> > +}
> > +
> > +/* Validate the feedback data from device */ static void
> > +mrvl_pkt_complete(struct hci_uart *hu, struct sk_buff *skb) {
> > +	struct mrvl_data *mrvl =3D hu->priv;
> > +	struct fw_data *fw_data =3D mrvl->fwdata;
> > +	u16 lhs, rhs;
> > +
> > +	lhs =3D get_unaligned_le16(skb->data + 1);
> > +	rhs =3D get_unaligned_le16(skb->data + 3);
> > +	if ((lhs ^ rhs) =3D=3D 0xffff) {
> > +		mrvl_send_ack(hu, MRVL_ACK);
> > +		fw_data->wait_fw =3D 1;
> > +		fw_data->next_len =3D lhs;
> > +		/* Firmware download is done, send the last ack */
> > +		if (!lhs)
> > +			fw_data->last_ack =3D 1;
> > +
> > +		if (fw_data->expected_ack =3D=3D MRVL_HDR_CHIP_VER) {
> > +			fw_data->chip_id =3D skb->data[1];
> > +			fw_data->chip_rev =3D skb->data[2];
> > +		}
> > +		wake_up_interruptible(&fw_data->init_wait_q);
> > +	} else {
> > +		mrvl_send_ack(hu, MRVL_NAK);
> > +	}
> > +}
> > +
> > +/* This function receives data from the uart device during firmware
> download.
> > + * Driver expects 5 bytes of data as per the protocal in the below
> format:
> > + * <HEADER><BYTE_1><BYTE_2><BYTE_3><BYTE_4>
> > + * BYTE_3 and BYTE_4 are compliment of BYTE_1 an BYTE_2. Data can
> > +come in chunks
> > + * of any length. If length received is < 5, accumulate the data in
> > +an array,
> > + * until we have a sequence of 5 bytes, starting with the expected
> > +HEADER. If
> > + * the length received is > 5  bytes, then get the first 5 bytes,
> > +starting with
> > + * the HEADER and process the same, ignoring the rest of the bytes as
> > +per the
> > + * protocal.
> > + */
> > +static struct sk_buff *mrvl_process_fw_data(struct hci_uart *hu,
> > +					    struct sk_buff *skb,
> > +					    u8 *buf, int count)
> > +{
> > +	struct mrvl_data *mrvl =3D hu->priv;
> > +	struct fw_data *fw_data =3D mrvl->fwdata;
> > +	int i =3D 0, len;
> > +
> > +	if (!skb) {
> > +		while ((i < count) && buf[i] !=3D fw_data->expected_ack)
> > +			i++;
> > +		if (i =3D=3D count)
> > +			return ERR_PTR(-EILSEQ);
> > +
> > +		skb =3D bt_skb_alloc(MRVL_FW_HDR_LEN, GFP_KERNEL);
> > +		if (!skb)
> > +			return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	len =3D count - i;
> > +	if ((len + skb->len) > MRVL_FW_HDR_LEN)
> > +		return ERR_PTR(-EILSEQ);
> > +
> > +	memcpy(skb_put(skb, len), &buf[i], len);
> > +
> > +	if (skb->len =3D=3D MRVL_FW_HDR_LEN) {
> > +		mrvl_pkt_complete(hu, skb);
> > +		kfree_skb(skb);
> > +		skb =3D NULL;
> > +	}
> > +
> > +	return skb;
> > +}
> > +
> > +/* Receive firmware feedback data */
> > +static int mrvl_recv_for_prepare(struct hci_uart *hu, const void
> *data,
> > +				 int count)
> > +{
> > +	struct mrvl_data *mrvl =3D hu->priv;
> > +
> > +	mrvl->fwdata->skb =3D mrvl_process_fw_data(hu, mrvl->fwdata->skb,
> > +						 (u8 *)data, count);
> > +	if (IS_ERR(mrvl->fwdata->skb)) {
> > +		int err =3D PTR_ERR(mrvl->fwdata->skb);
> > +
> > +		bt_dev_err(hu->hdev,
> > +			   "Receive firmware data failed (%d)", err);
> > +		mrvl->fwdata->skb =3D NULL;
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> Don't understand why you need this 'prepare stuff', everything could be
> done in setup procedure.

We had our firmware download code in setup handler in initial versions of t=
his patch. Marcel pointed out that firmware download in ->setup() is fine a=
s long as it uses HCI commands. We don't use HCI commands for FW download. =
Assumption in ->setup handler is we are in an HCI capable transport and it =
is ready.

So we came up with prepare handler.

I have addressed your other comments in V13 patch. I will send it shortly.

Regards,
Amitkumar Karwar
