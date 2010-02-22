Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <Suraj.Sumangala@Atheros.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>
Date: Mon, 22 Feb 2010 14:24:44 +0530
Subject: RE: [PATCH] Added support for Atheros AR300x UART Bluetooth Chip
Message-ID: <44EE5C37ADC36343B0625A05DD408C48508B1F5BA1@CHEXMB-01.global.atheros.com>
References: <20100209114231.GA6587@ATH-LT-538>
 <1266805799.18491.33.camel@violet>
In-Reply-To: <1266805799.18491.33.camel@violet>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Monday, February 22, 2010 8:00 AM
To: Vikram Kandukuri
Cc: linux-bluetooth@vger.kernel.org; Suraj Sumangala; Luis Rodriguez
Subject: Re: [PATCH] Added support for Atheros AR300x UART Bluetooth Chip

Hi Vikram,

>  drivers/bluetooth/Kconfig     |   10 +
>  drivers/bluetooth/Makefile    |    1 +
>  drivers/bluetooth/hci_ath.c   |  545 +++++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/hci_ath.h   |   72 ++++++
>  drivers/bluetooth/hci_ldisc.c |    6 +
>  drivers/bluetooth/hci_uart.h  |    8 +-
>  6 files changed, 641 insertions(+), 1 deletions(-)
>  create mode 100755 drivers/bluetooth/hci_ath.c
>  create mode 100755 drivers/bluetooth/hci_ath.h
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 058fbcc..32b98a4 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -58,6 +58,16 @@ config BT_HCIUART_BCSP
>
>         Say Y here to compile support for HCI BCSP protocol.
>
> +config BT_HCIUART_ATH
> +     bool "Atheros AR3001 Board support"
> +     depends on BT_HCIUART
> +     help
> +       HCIATH (HCI Atheros) is a serial protocol for communication
> +       between Bluetooth device and host. This protocol is required for
> +       serial Bluetooth devices that are based on Atheros AR3001 chips.
> +
> +       Say Y here to compile support for HCIATH protocol.
> +

it would be nice if you add a document explaining this special Atheros
protocol that is used.

>> We will do the same

> +static void ath_context_switch(struct work_struct *work)
> +{
> +     int status;
> +     struct ath_struct *ath;
> +     struct hci_uart *hu;
> +     struct tty_struct *tty;
> +     struct sk_buff *skbuf;
> +     ath = container_of(work, struct ath_struct, ctxtsw);
> +     hu = ath->hu;
> +     tty = hu->tty;
> +     status = ath_wakeup_ar3001(tty);
> +     if ((status & TIOCM_CTS)) {
> +             while ((skbuf = skb_dequeue(&ath->tx_wait_q)))
> +                     skb_queue_tail(&ath->txq, skbuf);
> +
> +             /* Ready to send Data */
> +             clear_bit(HCI_UART_SENDING, &hu->tx_state);
> +             hci_uart_tx_wakeup(hu);
> +     }
> +}
> +
> +/* Initialize protocol */
> +static int ath_open(struct hci_uart *hu)
> +{
> +     struct ath_struct *ath;
> +     BT_DBG("hu %p", hu);
> +     ath = kzalloc(sizeof(*ath), GFP_ATOMIC);
> +     if (!ath)
> +             return -ENOMEM;
> +     skb_queue_head_init(&ath->txq);
> +     skb_queue_head_init(&ath->tx_wait_q);
> +     skb_queue_head_init(&ath->tx_cmd_wait_q);
> +     spin_lock_init(&ath->hciath_lock);
> +     ath->cur_sleep = 0;
> +     ath->num_cmds_complete = 1;
> +     hu->priv = ath;
> +     ath->hu = hu;
> +     init_waitqueue_head(&ath->wqevt);
> +     INIT_WORK(&ath->ctxtsw, ath_context_switch);
> +     return 0;
> +}

In all the function, use at least some empty lines in between so that
somebody can try to read these function. Cramping everything in less
space doesn't make it simpler.

>> We will make the necessary changes

> +/* Enqueue frame for transmittion (padding, crc, etc) */
> +/* may be called from two simultaneous tasklets */

Why are you stealing the comments from hci_ll.c. Are you using actually
padding and CRC?

>> Cleanup will be done

> +static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> +{
> +     struct ath_struct *ath;
> +     ath = hu->priv;

Direct assignment on declaration.

>> Will be done

> +     if (HCI_SCODATA_PKT == bt_cb(skb)->pkt_type) {

Always the other way around. Variable compares to constant. Not the
constant to variable.
>> Will change it accordingly

> +static struct sk_buff *ath_dequeue(struct hci_uart *hu)
> +{
> +     struct ath_struct *ath;
> +     struct sk_buff *skbuff;
> +     ath = hu->priv;
> +     skbuff = skb_dequeue(&ath->txq);
> +     if (NULL != skbuff) {

Never ever use the variable name skbuff and also if (skbuff) here.
However preferable this is if (!skb) return NULL;

>> Will change the variable name and implementation as mentioned

> +             ath_handle_host_data(ath, bt_cb(skbuff)->pkt_type,
> +                                  &skbuff->data[1], skbuff->len - 1);
> +     }
> +     return skbuff;
> +}
> +
> +static inline int ath_check_data_len(struct ath_struct *ath, int len)
> +{
> +     register int room = skb_tailroom(ath->rx_skb);
> +     BT_DBG("len %d room %d", len, room);
> +     if (!len) {
> +             hci_recv_frame(ath->rx_skb);
> +     } else if (len > room) {
> +             BT_ERR("Data length is too large");
> +             kfree_skb(ath->rx_skb);
> +     } else {
> +             ath->rx_state = HCIATH_W4_DATA;
> +             ath->rx_count = len;
> +             return len;
> +     }

How is this if statement even suppose to work?
>> This implementation was there in previous hci_ll and other implementation which we have used as our template

> +     ath->rx_state = HCIATH_W4_PACKET_TYPE;
> +     ath->rx_skb = NULL;
> +     ath->rx_count = 0;
> +     return 0;
> +}
> +
> +/* Recv data */
> +static int ath_recv(struct hci_uart *hu, void *data, int count)
> +{
> +     struct ath_struct *ath = hu->priv;
> +     register char *ptr;
> +     struct hci_event_hdr *eh;
> +     struct hci_acl_hdr *ah;
> +     struct hci_sco_hdr *sh;
> +     struct sk_buff *skbuff;
> +     register int len, type, dlen;
> +     skbuff = NULL;
> +     BT_DBG("hu %p count %d rx_state %d rx_count %d", hu, count,
> +            ath->rx_state, ath->rx_count);
> +     ptr = data;
> +     while (count) {
> +             if (ath->rx_count) {
> +                     len = min_t(unsigned int, ath->rx_count, count);
> +                     memcpy(skb_put(ath->rx_skb, len), ptr, len);
> +                     ath->rx_count -= len;
> +                     count -= len;
> +                     ptr += len;
> +                     if (ath->rx_count)
> +                             continue;
> +                     switch (ath->rx_state) {
> +                     case HCIATH_W4_DATA:
> +                             ath_handle_data_from_controller(ath,
> +                                                             bt_cb
> +                                                             (ath->rx_skb)->
> +                                                             pkt_type,
> +                                                             ath->rx_skb->
> +                                                             data,
> +                                                             ath->rx_skb->
> +                                                             len);
> +                             if (HCI_EVENT_PKT ==
> +                                 bt_cb(ath->rx_skb)->pkt_type
> +                                 && ath->num_cmds_complete > 0) {
> +
> +                                     skbuff =
> +                                         skb_dequeue(&ath->tx_cmd_wait_q);
> +                                     if (skbuff != NULL) {
> +                                             skb_queue_tail(&ath->txq,
> +                                                            skbuff);
> +                                             schedule_work(&ath->ctxtsw);
> +                                     }
> +                             }
> +                             if (ath_verify_event_discardable
> +                                 (hu, bt_cb(ath->rx_skb)->pkt_type,
> +                                  ath->rx_skb->data)) {
> +                                     kfree(ath->rx_skb);
> +                                     ath->rx_skb = NULL;
> +                             } else {
> +                                     hci_recv_frame(ath->rx_skb);
> +                             }
> +                             ath->rx_state = HCIATH_W4_PACKET_TYPE;
> +                             ath->rx_skb = NULL;
> +                             ath->rx_count = 0;
> +                             continue;
> +                     case HCIATH_W4_EVENT_HDR:
> +                             eh = (struct hci_event_hdr *)ath->rx_skb->data;
> +                             BT_DBG("Event header: evt 0x%2.2x plen %d",
> +                                    eh->evt, eh->plen);
> +                             ath_check_data_len(ath, eh->plen);
> +                             continue;
> +                     case HCIATH_W4_ACL_HDR:
> +                             ah = (struct hci_acl_hdr *)ath->rx_skb->data;
> +                             dlen = __le16_to_cpu(ah->dlen);
> +                             BT_DBG("ACL header: dlen %d", dlen);
> +                             ath_check_data_len(ath, dlen);
> +                             continue;
> +                     case HCIATH_W4_SCO_HDR:
> +                             sh = (struct hci_sco_hdr *)ath->rx_skb->data;
> +                             BT_DBG("SCO header: dlen %d", sh->dlen);
> +                             ath_check_data_len(ath, sh->dlen);
> +                             continue;
> +                     }
> +             }
> +
> +             /* HCIATH_W4_PACKET_TYPE */
> +             switch (*ptr) {
> +             case HCI_EVENT_PKT:
> +                     BT_DBG("Event packet");
> +                     ath->rx_state = HCIATH_W4_EVENT_HDR;
> +                     ath->rx_count = HCI_EVENT_HDR_SIZE;
> +                     type = HCI_EVENT_PKT;
> +                     break;
> +             case HCI_ACLDATA_PKT:
> +                     BT_DBG("ACL packet");
> +                     ath->rx_state = HCIATH_W4_ACL_HDR;
> +                     ath->rx_count = HCI_ACL_HDR_SIZE;
> +                     type = HCI_ACLDATA_PKT;
> +                     break;
> +             case HCI_SCODATA_PKT:
> +                     BT_DBG("SCO packet");
> +                     ath->rx_state = HCIATH_W4_SCO_HDR;
> +                     ath->rx_count = HCI_SCO_HDR_SIZE;
> +                     type = HCI_SCODATA_PKT;
> +                     break;
> +             default:
> +                     BT_ERR("Unknown HCI packet type %2.2x", (__u8) *ptr);
> +                     hu->hdev->stat.err_rx++;
> +                     ptr++;
> +                     count--;
> +                     continue;
> +             };
> +             ptr++;
> +             count--;
> +
> +             /* Allocate packet */
> +             ath->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
> +             if (!ath->rx_skb) {
> +                     BT_ERR("Can't allocate mem for new packet");
> +                     ath->rx_state = HCIATH_W4_PACKET_TYPE;
> +                     ath->rx_count = 0;
> +                     return 0;
> +             }
> +             ath->rx_skb->dev = (void *)hu->hdev;
> +             bt_cb(ath->rx_skb)->pkt_type = type;
> +     } return count;
> +}

We have a common exported function called hci_recv_fragment that should
be doing exactly this.

>>  Explained at bottom

> +static void ath_controller_sleep_mode(struct hci_uart *hu, bool enable)
> +{
> +     unsigned char sleepcmd[] = { 0x01, 0x04, 0xFC, 0x01, 0x00 };
> +     sleepcmd[4] = enable;
> +     ath_write_data_to_cntrlr(hu->hdev, sleepcmd, sizeof(sleepcmd));
> +}

Special vendor commands need a comment. Explain the data structure of
them and what are the options.

>> Will make the necessary changes

> +int ath_wakeup_ar3001(struct tty_struct *tty)
> +{
> +     struct termios settings;
> +     int status = 0x00;
> +     mm_segment_t oldfs;
> +     status = tty->driver->ops->tiocmget(tty, NULL);
> +
> +     if ((status & TIOCM_CTS))
> +             return status;
> +
> +     oldfs = get_fs();
> +     set_fs(KERNEL_DS);
> +     n_tty_ioctl_helper(tty, NULL, TCGETS, (unsigned long)&settings);
> +
> +     settings.c_cflag &= ~CRTSCTS;
> +     n_tty_ioctl_helper(tty, NULL, TCSETS, (unsigned long)&settings);
> +     set_fs(oldfs);
> +     status = tty->driver->ops->tiocmget(tty, NULL);
> +
> +     tty->driver->ops->tiocmset(tty, NULL, 0x00, TIOCM_RTS);
> +     mdelay(20);
> +
> +     status = tty->driver->ops->tiocmget(tty, NULL);
> +
> +     tty->driver->ops->tiocmset(tty, NULL, TIOCM_RTS, 0x00);
> +     mdelay(20);
> +
> +     status = tty->driver->ops->tiocmget(tty, NULL);
> +     oldfs = get_fs();
> +     set_fs(KERNEL_DS);
> +     n_tty_ioctl_helper(tty, NULL, TCGETS, (unsigned long)&settings);
> +
> +     settings.c_cflag |= CRTSCTS;
> +     n_tty_ioctl_helper(tty, NULL, TCSETS, (unsigned long)&settings);
> +     set_fs(oldfs);
> +     return status;
> +}

Why is this magic in kernel space and not inside hciattach?

>> We have a sleep feature which makes the controller go to deep sleep
if there is no Bluetooth activity for a while,
so the driver will verify if the controller is sleeping and
try to wake up the controller using the RTS/CTS mechanism.
This has to be done before sending any packet to controller.
This cannot be done in hciattach as this is required to be called throughout the life of the driver and not just when the driver is loaded.

> +int ath_fullboot_config(struct hci_uart *hu, int current_event)
> +{
> +     struct sk_buff *skbuf;
> +     struct ath_struct *ath = hu->priv;
> +     static int autosleep;
> +     unsigned char rstevt[] = { 0x1, 0x3, 0xc, 0x0 };
> +     if (current_event == HCI_RESET) {
> +
> +             if (ath->cur_sleep) {
> +                     autosleep = 1;
> +                     ath_controller_sleep_mode(hu, 1);
> +                     return 1;
> +             } else {
> +                     return 0;
> +             }
> +     }
> +
> +     if (current_event == HCI_SET_SLEEP_MODE) {
> +
> +             if (autosleep == 0)
> +                     return 1;
> +
> +             while ((skbuf = skb_dequeue(&ath->tx_wait_q)))
> +                     skb_queue_tail(&ath->txq, skbuf);
> +
> +             ath_write_data_to_host(hu->hdev, rstevt, sizeof(rstevt));
> +             autosleep = 0;
> +             return 1;
> +     }
> +     return 0;
> +}

Why is this function not static? And all the others?

>> Will make all the functions static

> +int ath_write_data_to_host(void *dev, unsigned char *data, u8 length)
> +{
> +     struct sk_buff *skbuf;
> +     struct hci_dev *hdev;
> +     hdev = (struct hci_dev *)dev;
> +     skbuf = bt_skb_alloc(length, GFP_ATOMIC);
> +     if (!skbuf) {
> +             BT_ERR("Memory allocation failed");
> +             return -1;
> +     }
> +     skb_orphan(skbuf);
> +
> +     /* First byte will be added as packet type */
> +     bt_cb(skbuf)->pkt_type = data[0];
> +     skbuf->dev = (void *)hdev;
> +     memcpy(skb_put(skbuf, length - 1), &data[1], length - 1);
> +     hci_recv_frame(skbuf);
> +     return length;
> +}

What is this exactly for? Do you have a secondary receive path?

>> Yes, we have situation where driver sends HCI events to depending on acknowledgement of sleep enable vendor specific command.
Explained at the bottom.

> +int ath_write_data_to_cntrlr(void *dev, unsigned char *Data, u8 len)
> +{
> +     struct sk_buff *skbuff;
> +     struct ath_struct *ath;
> +     struct hci_uart *hu;
> +     struct hci_dev *hdev;
> +     if (NULL == dev) {
> +             BT_DBG("NULL handle received %p  \n", dev);
> +             return 0;
> +     }
> +     hdev = (struct hci_dev *)dev;
> +     hu = (struct hci_uart *)hdev->driver_data;
> +     if (hu == NULL) {
> +             BT_DBG("NULL handle received %p  \n", hdev);
> +             return 0;
> +     }
> +     ath = hu->priv;
> +     if (ath == NULL) {
> +             BT_DBG("NULL handle received  \n");
> +             return 0;
> +     }
> +     skbuff = bt_skb_alloc(len, GFP_ATOMIC);
> +     if (skbuff == NULL) {
> +             BT_DBG("Malloc Fail memory %p   \n", skbuff);
> +             return 0;
> +     }
> +     skb_orphan(skbuff);
> +
> +     if (len != 0)
> +             memcpy(skb_put(skbuff, len), Data, len);
> +
> +     bt_cb(skbuff)->pkt_type = HCI_COMMAND_PKT;
> +     skbuff->dev = dev;
> +     if (ath->num_cmds_complete > 0) {
> +             skb_queue_tail(&ath->txq, skbuff);
> +             schedule_work(&ath->ctxtsw);
> +     } else {
> +             skb_queue_tail(&ath->tx_cmd_wait_q, skbuff);
> +     }
> +     return len;
> +}

Messing with num_cmds_complete inside the driver is wrong. What are you
doing here?

>> Explanation given at bottom

> +int ath_check_sleep_cmd(struct ath_struct *ath, unsigned char *packet)
> +{
> +     if (packet[0] == HCI_EVENT_PKT && packet[1] == 0xFC)
> +             ath->cur_sleep = packet[3];

How is this working. Every vendor event is sleep event?

>> Will correct it. It should have been packet[0] == 0x04.

> +int ath_verify_event_discardable(struct hci_uart *hu, unsigned char pkt_type,
> +                              unsigned char *packet)
> +{
> +     if (pkt_type != HCI_EVENT_PKT)
> +             return 0;
> +
> +     switch (packet[0]) {
> +     case 0x0E:              /* Command Complete Event */
> +             if (packet[3] == 0x03 && packet[4] == 0x0C) {
> +
> +                     /* Command complete for HCI Reset Received */
> +                     return ath_fullboot_config(hu, HCI_RESET);
> +             } else if (packet[3] == 0x04 && packet[4] == 0xFC) {
> +                     return ath_fullboot_config(hu, HCI_SET_SLEEP_MODE);
> +             }
> +             break;
> +     }
> +     return 0;
> +}

What are you doing here?
>> Events for commands sent from driver need not go to the host. They are discarded at the driver level.

> +void ath_handle_hci_event(struct ath_struct *ath, u8 * packet)
> +{
> +     switch (packet[0]) {
> +     case 0x05:              /* ACL Disconnection Complete Event */
> +             break;
> +     case 0x03:              /* ACL Connection Complete Event */
> +             break;
> +     case 0x0E:              /* Command Complete Event */
> +             spin_lock(&ath->hciath_lock);
> +             ath->num_cmds_complete = packet[2];
> +             spin_unlock(&ath->hciath_lock);
> +             break;
> +     case 0x0F:              /* Command Status Event */
> +             spin_lock(&ath->hciath_lock);
> +             ath->num_cmds_complete = packet[3];
> +             spin_unlock(&ath->hciath_lock);
> +             break;
> +     }
> +}

Something is really wrong in this driver? Are you really know how this
is suppose to work if you have to interfere this much?

>> Explanation given at the bottom

> +void ath_handle_host_data(struct ath_struct *ath, u8 pktType, u8 * packet,
> +                       unsigned int len)
> +{
> +     switch (pktType) {
> +     case HCI_ACLDATA_PKT:   /* ACL packets */
> +             break;
> +     case HCI_COMMAND_PKT:   /* HCI Commands */
> +             ath_handle_hci_cmd(ath, packet);
> +             ath_check_sleep_cmd(ath, packet);
> +             break;
> +     }
> +}
> +
> +void ath_handle_data_from_controller(struct ath_struct *ath, u8 pktType,
> +                                  u8 *packet, unsigned int len)
> +{
> +     switch (pktType) {
> +     case HCI_ACLDATA_PKT:   /* ACL packets */
> +             break;
> +     case HCI_EVENT_PKT:     /* HCI Events */
> +             ath_handle_hci_event(ath, packet);
> +             break;
> +     }
> +}

Seriously? are you implemented your own Bluetooth stack? Please explain
what you really need. And then the host stack can provide it for you.
This is not acceptable.


>> The AR3001 supports power management feature that can be enabled from host during hciattach.
 This will let the controller go to sleep if there is no data transfer for some time.
     This feature will be disabled automatically on receiving HCI RESET command and has to be enabled
Again by sending Sleep enable Vendor specific command after every Reset.

This required the driver to keep track of HCI RESET command complete event and sent Sleep Enable command on receiving the event.
Host will be notified of the HCI Reset command complete event only after the Sleep enable command is acknowledged by controller.
This is the reason for the following implementation changes
        1. We had to avoid using hci_recv_fragment as we need to verify and decide if the packet has to be sent to Host (In case of HCI RESET).
        2. We had to add ath_write_data_to_host so that we can sent HCI RESET
           command complete on receiving Sleep Enable command complete event from controller.
        3. We had to add ath_write_data_to_cntrlr  so that driver can send the Sleep enable command after every HCI RESET.
        4. Have ath_verify_event_discardable which keep track of the HCI RESET and Sleep Enable Command complete event
           and decide whether to send the HCI RESET event to host or send only after sleep enable.

>>  Regarding the use of num_cmds_complete inside driver,
we have to send vendor specific commands from the driver to configure the controller depending on the status of ACL connection.
So, there is a chance that the this might cause driver to send a command to controller
when it is already busy with command sent from host.
That is the reason why we had to go for streamlining the command flow in the driver.
If you can export hci_send_cmd API in hci_core.c, then we might be able to use it to send a command to controller without worrying about command streamlining.

Please do let me know your comments,

Regards
Suraj

