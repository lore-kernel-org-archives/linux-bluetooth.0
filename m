Return-Path: <cyrus@holtmann.org>
Message-ID: <5208A7DD.9070600@mentor.com>
Date: Mon, 12 Aug 2013 10:16:13 +0100
From: Dean Jenkins <Dean_Jenkins@mentor.com>
MIME-Version: 1.0
To: Valentin Ilie <valentin.ilie@gmail.com>
CC: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: clean up
References: <1376225793-22981-1-git-send-email-valentin.ilie@gmail.com>
In-Reply-To: <1376225793-22981-1-git-send-email-valentin.ilie@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/08/13 13:56, Valentin Ilie wrote:
> Clean up bluetooth files
> - replace foo* bar with foo *bar
> - add space arround '='
> - remove trailing witespaces
> - remove assignment in if
> - fix coding style issues
I suggest you split the commits into 2:
a) commit with whitespace changes
b) commit with other coding style changes that cause C statements to be 
rewritten.

This makes it easier for people to separate whitespace changes from 
technical changes to the C code.

Also it would help people back-porting these commits to older kernels.

>
> Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>
> ---
>   drivers/bluetooth/Kconfig     |   12 +++++------
>   drivers/bluetooth/dtl1_cs.c   |    6 +++---
>   drivers/bluetooth/hci_bcsp.c  |   48 +++++++++++++++++++++--------------------
>   drivers/bluetooth/hci_h5.c    |    6 ++++--
>   drivers/bluetooth/hci_ldisc.c |   15 +++++++------
>   drivers/bluetooth/hci_vhci.c  |    4 ++--
>   6 files changed, 49 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 11a6104..6421414 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -30,8 +30,8 @@ config BT_HCIUART
>   	help
>   	  Bluetooth HCI UART driver.
>   	  This driver is required if you want to use Bluetooth devices with
> -	  serial port interface. You will also need this driver if you have
> -	  UART based Bluetooth PCMCIA and CF devices like Xircom Credit Card
> +	  serial port interface. You will also need this driver if you have
> +	  UART based Bluetooth PCMCIA and CF devices like Xircom Credit Card
>   	  adapter and BrainBoxes Bluetooth PC Card.
>   
>   	  Say Y here to compile support for Bluetooth UART devices into the
> @@ -41,9 +41,9 @@ config BT_HCIUART_H4
>   	bool "UART (H4) protocol support"
>   	depends on BT_HCIUART
>   	help
> -	  UART (H4) is serial protocol for communication between Bluetooth
> -	  device and host. This protocol is required for most Bluetooth devices
> -	  with UART interface, including PCMCIA and CF cards.
> +	  UART (H4) is serial protocol for communication between Bluetooth
> +	  device and host. This protocol is required for most Bluetooth devices
> +	  with UART interface, including PCMCIA and CF cards.
>   
>   	  Say Y here to compile support for HCI UART (H4) protocol.
>   
> @@ -52,7 +52,7 @@ config BT_HCIUART_BCSP
>   	depends on BT_HCIUART
>   	select BITREVERSE
>   	help
> -	  BCSP (BlueCore Serial Protocol) is serial protocol for communication
> +	  BCSP (BlueCore Serial Protocol) is serial protocol for communication
>   	  between Bluetooth device and host. This protocol is required for non
>   	  USB Bluetooth devices based on CSR BlueCore chip, including PCMCIA and
>   	  CF cards.
> diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
> index 33f3a69..3b89c0d 100644
> --- a/drivers/bluetooth/dtl1_cs.c
> +++ b/drivers/bluetooth/dtl1_cs.c
> @@ -153,7 +153,8 @@ static void dtl1_write_wakeup(dtl1_info_t *info)
>   		if (!pcmcia_dev_present(info->p_dev))
>   			return;
>   
> -		if (!(skb = skb_dequeue(&(info->txq))))
> +		skb = skb_dequeue(&(info->txq));
> +		if (!skb)
>   			break;
>   
>   		/* Send frame */
> @@ -181,9 +182,8 @@ static void dtl1_control(dtl1_info_t *info, struct sk_buff *skb)
>   	int i;
>   
>   	printk(KERN_INFO "Bluetooth: Nokia control data =");
> -	for (i = 0; i < skb->len; i++) {
> +	for (i = 0; i < skb->len; i++)
>   		printk(" %02x", skb->data[i]);
> -	}
>   	printk("\n");
>   
>   	/* transition to active state */
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index 57e502e..fbd54e8 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -105,11 +105,11 @@ static const u16 crc_table[] = {
>   #define BCSP_CRC_INIT(x) x = 0xffff
>   
>   /*
> -   Update crc with next data byte
> +	Update crc with next data byte
>   
> -   Implementation note
> -        The data byte is treated as two nibbles.  The crc is generated
> -        in reverse, i.e., bits are fed into the register from the top.
> +	Implementation note
> +		The data byte is treated as two nibbles.  The crc is generated
> +		in reverse, i.e., bits are fed into the register from the top.
>   */
>   static void bcsp_crc_update(u16 *crc, u8 d)
>   {
> @@ -287,11 +287,12 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
>   	struct bcsp_struct *bcsp = hu->priv;
>   	unsigned long flags;
>   	struct sk_buff *skb;
> -	
> +
>   	/* First of all, check for unreliable messages in the queue,
>   	   since they have priority */
>   
> -	if ((skb = skb_dequeue(&bcsp->unrel)) != NULL) {
> +	skb = skb_dequeue(&bcsp->unrel);
> +	if (skb != NULL) {
>   		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len, bt_cb(skb)->pkt_type);
>   		if (nskb) {
>   			kfree_skb(skb);
> @@ -308,7 +309,8 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
>   
>   	spin_lock_irqsave_nested(&bcsp->unack.lock, flags, SINGLE_DEPTH_NESTING);
>   
> -	if (bcsp->unack.qlen < BCSP_TXWINSIZE && (skb = skb_dequeue(&bcsp->rel)) != NULL) {
> +	skb = skb_dequeue(&bcsp->rel);
> +	if (bcsp->unack.qlen < BCSP_TXWINSIZE && skb != NULL) {
THIS CHANGE IS INCORRECT.

The call to skb_dequeue() depends on bcsp->unack.qlen < BCSP_TXWINSIZE 
being true. In other words the 2nd condition of && is not executed when 
the 1st condition is false. Therefore 2 nested if statements are needed.

>   		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len, bt_cb(skb)->pkt_type);
>   		if (nskb) {
>   			__skb_queue_tail(&bcsp->unack, skb);
> @@ -433,7 +435,7 @@ static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char
>   			break;
>   		default:
>   			memcpy(skb_put(bcsp->rx_skb, 1), &byte, 1);
> -			if ((bcsp->rx_skb-> data[0] & 0x40) != 0 &&
> +			if ((bcsp->rx_skb->data[0] & 0x40) != 0 &&
>   					bcsp->rx_state != BCSP_W4_CRC)
>   				bcsp_crc_update(&bcsp->message_crc, byte);
>   			bcsp->rx_count--;
> @@ -444,24 +446,24 @@ static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char
>   		switch (byte) {
>   		case 0xdc:
>   			memcpy(skb_put(bcsp->rx_skb, 1), &c0, 1);
> -			if ((bcsp->rx_skb-> data[0] & 0x40) != 0 &&
> +			if ((bcsp->rx_skb->data[0] & 0x40) != 0 &&
>   					bcsp->rx_state != BCSP_W4_CRC)
> -				bcsp_crc_update(&bcsp-> message_crc, 0xc0);
> +				bcsp_crc_update(&bcsp->message_crc, 0xc0);
>   			bcsp->rx_esc_state = BCSP_ESCSTATE_NOESC;
>   			bcsp->rx_count--;
>   			break;
>   
>   		case 0xdd:
>   			memcpy(skb_put(bcsp->rx_skb, 1), &db, 1);
> -			if ((bcsp->rx_skb-> data[0] & 0x40) != 0 &&
> -					bcsp->rx_state != BCSP_W4_CRC)
> -				bcsp_crc_update(&bcsp-> message_crc, 0xdb);
> +			if ((bcsp->rx_skb->data[0] & 0x40) != 0 &&
> +					bcsp->rx_state != BCSP_W4_CRC)
> +				bcsp_crc_update(&bcsp->message_crc, 0xdb);
>   			bcsp->rx_esc_state = BCSP_ESCSTATE_NOESC;
>   			bcsp->rx_count--;
>   			break;
>   
>   		default:
> -			BT_ERR ("Invalid byte %02x after esc byte", byte);
> +			BT_ERR("Invalid byte %02x after esc byte", byte);
>   			kfree_skb(bcsp->rx_skb);
>   			bcsp->rx_skb = NULL;
>   			bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
> @@ -524,9 +526,9 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
>   
>   				hci_recv_frame(bcsp->rx_skb);
>   			} else {
> -				BT_ERR ("Packet for unknown channel (%u %s)",
> +				BT_ERR("Packet for unknown channel (%u %s)",
>   					bcsp->rx_skb->data[1] & 0x0f,
> -					bcsp->rx_skb->data[0] & 0x80 ?
> +					bcsp->rx_skb->data[0] & 0x80 ?
>   					"reliable" : "unreliable");
>   				kfree_skb(bcsp->rx_skb);
>   			}
> @@ -554,7 +556,7 @@ static int bcsp_recv(struct hci_uart *hu, void *data, int count)
>   	struct bcsp_struct *bcsp = hu->priv;
>   	unsigned char *ptr;
>   
> -	BT_DBG("hu %p count %d rx_state %d rx_count %ld",
> +	BT_DBG("hu %p count %d rx_state %d rx_count %ld",
>   		hu, count, bcsp->rx_state, bcsp->rx_count);
>   
>   	ptr = data;
> @@ -574,7 +576,7 @@ static int bcsp_recv(struct hci_uart *hu, void *data, int count)
>   
>   		switch (bcsp->rx_state) {
>   		case BCSP_W4_BCSP_HDR:
> -			if ((0xff & (u8) ~ (bcsp->rx_skb->data[0] + bcsp->rx_skb->data[1] +
> +			if ((0xff & (u8) ~(bcsp->rx_skb->data[0] + bcsp->rx_skb->data[1] +
>   					bcsp->rx_skb->data[2])) != bcsp->rx_skb->data[3]) {
>   				BT_ERR("Error in BCSP hdr checksum");
>   				kfree_skb(bcsp->rx_skb);
> @@ -583,8 +585,8 @@ static int bcsp_recv(struct hci_uart *hu, void *data, int count)
>   				continue;
>   			}
>   			if (bcsp->rx_skb->data[0] & 0x80	/* reliable pkt */
> -			    		&& (bcsp->rx_skb->data[0] & 0x07) != bcsp->rxseq_txack) {
> -				BT_ERR ("Out-of-order packet arrived, got %u expected %u",
> +			&& (bcsp->rx_skb->data[0] & 0x07) != bcsp->rxseq_txack) {
> +				BT_ERR("Out-of-order packet arrived, got %u expected %u",
>   					bcsp->rx_skb->data[0] & 0x07, bcsp->rxseq_txack);
>   
>   				kfree_skb(bcsp->rx_skb);
> @@ -593,7 +595,7 @@ static int bcsp_recv(struct hci_uart *hu, void *data, int count)
>   				continue;
>   			}
>   			bcsp->rx_state = BCSP_W4_DATA;
> -			bcsp->rx_count = (bcsp->rx_skb->data[1] >> 4) +
> +			bcsp->rx_count = (bcsp->rx_skb->data[1] >> 4) +
>   					(bcsp->rx_skb->data[2] << 4);	/* May be 0 */
>   			continue;
>   
> @@ -607,7 +609,7 @@ static int bcsp_recv(struct hci_uart *hu, void *data, int count)
>   
>   		case BCSP_W4_CRC:
>   			if (bitrev16(bcsp->message_crc) != bscp_get_crc(bcsp)) {
> -				BT_ERR ("Checksum failed: computed %04x received %04x",
> +				BT_ERR("Checksum failed: computed %04x received %04x",
>   					bitrev16(bcsp->message_crc),
>   					bscp_get_crc(bcsp));
>   
> @@ -645,7 +647,7 @@ static int bcsp_recv(struct hci_uart *hu, void *data, int count)
>   				BCSP_CRC_INIT(bcsp->message_crc);
>   
>   				/* Do not increment ptr or decrement count
> -				 * Allocate packet. Max len of a BCSP pkt=
> +				 * Allocate packet. Max len of a BCSP pkt=
>   				 * 0xFFF (payload) +4 (header) +2 (crc) */
>   
>   				bcsp->rx_skb = bt_skb_alloc(0x1005, GFP_ATOMIC);
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index b6154d5..67a0e6c 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -673,7 +673,8 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
>   		return h5_prepare_pkt(hu, HCI_3WIRE_LINK_PKT, wakeup_req, 2);
>   	}
>   
> -	if ((skb = skb_dequeue(&h5->unrel)) != NULL) {
> +	skb = skb_dequeue(&h5->unrel);
> +	if (skb != NULL) {
>   		nskb = h5_prepare_pkt(hu, bt_cb(skb)->pkt_type,
>   				      skb->data, skb->len);
>   		if (nskb) {
> @@ -690,7 +691,8 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
>   	if (h5->unack.qlen >= h5->tx_win)
>   		goto unlock;
>   
> -	if ((skb = skb_dequeue(&h5->rel)) != NULL) {
> +	skb = skb_dequeue(&h5->rel);
> +	if (skb != NULL) {
>   		nskb = h5_prepare_pkt(hu, bt_cb(skb)->pkt_type,
>   				      skb->data, skb->len);
>   		if (nskb) {
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index bc68a44..d424e7d 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -236,7 +236,7 @@ static int hci_uart_close(struct hci_dev *hdev)
>   /* Send frames from HCI layer */
>   static int hci_uart_send_frame(struct sk_buff *skb)
>   {
> -	struct hci_dev* hdev = (struct hci_dev *) skb->dev;
> +	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
>   	struct hci_uart *hu;
>   
>   	if (!hdev) {
> @@ -279,7 +279,8 @@ static int hci_uart_tty_open(struct tty_struct *tty)
>   	if (tty->ops->write == NULL)
>   		return -EOPNOTSUPP;
>   
> -	if (!(hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL))) {
> +	hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL);
> +	if (!hu) {
>   		BT_ERR("Can't allocate control structure");
>   		return -ENFILE;
>   	}
> @@ -483,7 +484,7 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
>    *
>    * Return Value:    Command dependent
>    */
> -static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
> +static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
>   					unsigned int cmd, unsigned long arg)
>   {
>   	struct hci_uart *hu = (void *)tty->disc_data;
> @@ -564,7 +565,7 @@ static int __init hci_uart_init(void)
>   
>   	/* Register the tty discipline */
>   
> -	memset(&hci_uart_ldisc, 0, sizeof (hci_uart_ldisc));
> +	memset(&hci_uart_ldisc, 0, sizeof(hci_uart_ldisc));
>   	hci_uart_ldisc.magic		= TTY_LDISC_MAGIC;
>   	hci_uart_ldisc.name		= "n_hci";
>   	hci_uart_ldisc.open		= hci_uart_tty_open;
> @@ -577,7 +578,8 @@ static int __init hci_uart_init(void)
>   	hci_uart_ldisc.write_wakeup	= hci_uart_tty_wakeup;
>   	hci_uart_ldisc.owner		= THIS_MODULE;
>   
> -	if ((err = tty_register_ldisc(N_HCI, &hci_uart_ldisc))) {
> +	err = tty_register_ldisc(N_HCI, &hci_uart_ldisc);
> +	if (err) {
>   		BT_ERR("HCI line discipline registration failed. (%d)", err);
>   		return err;
>   	}
> @@ -622,7 +624,8 @@ static void __exit hci_uart_exit(void)
>   #endif
>   
>   	/* Release tty registration of line discipline */
> -	if ((err = tty_unregister_ldisc(N_HCI)))
> +	err = tty_unregister_ldisc(N_HCI);
> +	if (err)
>   		BT_ERR("Can't unregister HCI line discipline (%d)", err);
>   }
>   
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index d8b7aed..4b499f2 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -82,7 +82,7 @@ static int vhci_flush(struct hci_dev *hdev)
>   
>   static int vhci_send_frame(struct sk_buff *skb)
>   {
> -	struct hci_dev* hdev = (struct hci_dev *) skb->dev;
> +	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
>   	struct vhci_data *data;
>   
>   	if (!hdev) {
> @@ -281,7 +281,7 @@ static const struct file_operations vhci_fops = {
>   	.llseek		= no_llseek,
>   };
>   
> -static struct miscdevice vhci_miscdev= {
> +static struct miscdevice vhci_miscdev = {
>   	.name	= "vhci",
>   	.fops	= &vhci_fops,
>   	.minor	= MISC_DYNAMIC_MINOR,
Dean Jenkins
Mentor Graphics
