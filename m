Return-Path: <cyrus@holtmann.org>
Message-ID: <4BCFF28C.8000606@atheros.com>
Date: Thu, 22 Apr 2010 12:24:04 +0530
From: Suraj Sumangala <suraj@atheros.com>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <gustavo@padovan.org>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>, Luis Rodriguez
	<Luis.Rodriguez@Atheros.com>, Jothikumar Mothilal
	<Jothikumar.Mothilal@Atheros.com>
Subject: Re: [PATCH v4] Add support for the Atheros AR300x Bluetooth Chip
References: <1268629296.21425.23.camel@atheros013-desktop> <1271758832.6585.33.camel@atheros013-desktop> <1271845337.15010.1.camel@atheros013-desktop> <20100422061056.GE22959@vigoh>
In-Reply-To: <20100422061056.GE22959@vigoh>
Content-Type: text/plain; charset="us-ascii"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Gustavo,

Gustavo F. Padovan wrote:
> * suraj <suraj@atheros.com> [2010-04-21 15:52:17 +0530]:
> 
>> This implements the Atheros Bluetooth serial protocol to
>> support the AR300x Bluetooth chipsets.
>> The serial protocol implements enhanced power management
>> features for the AR300x chipsets.
>>
>> Reviewed-by: Luis R. Rodriguez <lrodriguez@atheros.com>
>> Signed-off-by: Suraj <suraj@atheros.com>
>>
>> ---
>>  drivers/bluetooth/Kconfig     |   14 ++
>>  drivers/bluetooth/Makefile    |    1 +
>>  drivers/bluetooth/hci_ath.c   |  378 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/bluetooth/hci_ldisc.c |    6 +
>>  drivers/bluetooth/hci_uart.h  |    8 +-
>>  5 files changed, 406 insertions(+), 1 deletions(-)
>>  create mode 100755 drivers/bluetooth/hci_ath.c
>>
>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>> index 058fbcc..5546142 100644
>> --- a/drivers/bluetooth/Kconfig
>> +++ b/drivers/bluetooth/Kconfig
>> @@ -58,6 +58,20 @@ config BT_HCIUART_BCSP
>>
>>         Say Y here to compile support for HCI BCSP protocol.
>>
>> +config BT_HCIUART_ATH
>> +     bool "Atheros AR300x serial Bluetooth support"
>> +     depends on BT_HCIUART
>> +     help
>> +       HCIATH (HCI Atheros) is a serial protocol for communication
>> +       between the host and Atheros AR300x Bluetooth devices. The
>> +       protocol implements enhaned power management features for the
>> +       the AR300x chipsets. it lets the controller chip go to sleep
>> +       mode if there is no Bluetooth activity for some time and wakes
>> +       up the chip in case of a Bluetooth activity. Enable this option
>> +       if you have an UART Atheros AR300x serial device.
>> +
>> +       Say Y here to compile support for HCIATH protocol.
>> +
>>  config BT_HCIUART_LL
>>       bool "HCILL protocol support"
>>       depends on BT_HCIUART
>> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
>> index 7e5aed5..1481faa 100644
>> --- a/drivers/bluetooth/Makefile
>> +++ b/drivers/bluetooth/Makefile
>> @@ -26,4 +26,5 @@ hci_uart-y                          := hci_ldisc.o
>>  hci_uart-$(CONFIG_BT_HCIUART_H4)     += hci_h4.o
>>  hci_uart-$(CONFIG_BT_HCIUART_BCSP)   += hci_bcsp.o
>>  hci_uart-$(CONFIG_BT_HCIUART_LL)     += hci_ll.o
>> +hci_uart-$(CONFIG_BT_HCIUART_ATH)    += hci_ath.o
>>  hci_uart-objs                                := $(hci_uart-y)
>> diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
>> new file mode 100755
>> index 0000000..7e99559
>> --- /dev/null
>> +++ b/drivers/bluetooth/hci_ath.c
>> @@ -0,0 +1,378 @@
>> +/*
>> + * Copyright (c) 2009-2010 Atheros Communications Inc.
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License as published by
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +
>> +#include <linux/init.h>
>> +#include <linux/slab.h>
>> +#include <linux/tty.h>
>> +#include <linux/errno.h>
>> +#include <linux/ioctl.h>
>> +#include <linux/skbuff.h>
>> +
>> +#include <net/bluetooth/bluetooth.h>
>> +#include <net/bluetooth/hci_core.h>
>> +
>> +#include "hci_uart.h"
>> +
>> +/* HCIATH receiver States */
>> +#define HCIATH_W4_PACKET_TYPE                        0
>> +#define HCIATH_W4_EVENT_HDR                  1
>> +#define HCIATH_W4_ACL_HDR                    2
>> +#define HCIATH_W4_SCO_HDR                    3
>> +#define HCIATH_W4_DATA                               4
>> +
>> +struct ath_struct {
>> +     struct hci_uart *hu;
>> +     unsigned int rx_state;
>> +     unsigned int rx_count;
>> +     unsigned int cur_sleep;
>> +
>> +     spinlock_t hciath_lock;
>> +     struct sk_buff *rx_skb;
>> +     struct sk_buff_head txq;
>> +     wait_queue_head_t wqevt;
>> +     struct work_struct ctxtsw;
>> +};
>> +
>> +static int ath_wakeup_ar3001(struct tty_struct *tty)
>> +{
>> +     struct termios settings;
>> +     int status = tty->driver->ops->tiocmget(tty, NULL);
>> +
>> +     if (status & TIOCM_CTS)
>> +             return status;
>> +
>> +     n_tty_ioctl_helper(tty, NULL, TCGETS, (unsigned long)&settings);
>> +
>> +     /* Disable Automatic RTSCTS */
>> +     settings.c_cflag &= ~CRTSCTS;
>> +     n_tty_ioctl_helper(tty, NULL, TCSETS, (unsigned long)&settings);
>> +
>> +     status = tty->driver->ops->tiocmget(tty, NULL);
>> +
>> +     /* Clear RTS first */
>> +     tty->driver->ops->tiocmset(tty, NULL, 0x00, TIOCM_RTS);
>> +     mdelay(20);
>> +
>> +     status = tty->driver->ops->tiocmget(tty, NULL);
>> +
>> +     /* Set RTS, wake up board */
>> +     tty->driver->ops->tiocmset(tty, NULL, TIOCM_RTS, 0x00);
>> +     mdelay(20);
>> +
>> +     status = tty->driver->ops->tiocmget(tty, NULL);
>> +
>> +     n_tty_ioctl_helper(tty, NULL, TCGETS, (unsigned long)&settings);
>> +
>> +     settings.c_cflag |= CRTSCTS;
>> +     n_tty_ioctl_helper(tty, NULL, TCSETS, (unsigned long)&settings);
>> +
>> +     return status;
>> +}
>> +
>> +static void ath_hci_uart_work(struct work_struct *work)
>> +{
>> +     int status;
>> +     struct ath_struct *ath;
>> +     struct hci_uart *hu;
>> +     struct tty_struct *tty;
>> +
>> +     ath = container_of(work, struct ath_struct, ctxtsw);
>> +
>> +     hu = ath->hu;
>> +     tty = hu->tty;
>> +
>> +     /* verify and wake up controller */
>> +     if (ath->cur_sleep) {
>> +             status = ath_wakeup_ar3001(tty);
>> +
>> +             if (!(status & TIOCM_CTS))
>> +                     return;
>> +     }
>> +
>> +     /* Ready to send Data */
>> +     clear_bit(HCI_UART_SENDING, &hu->tx_state);
>> +     hci_uart_tx_wakeup(hu);
>> +}
>> +
>> +/* Initialize protocol */
>> +static int ath_open(struct hci_uart *hu)
>> +{
>> +     struct ath_struct *ath;
>> +
>> +     BT_DBG("hu %p", hu);
>> +
>> +     ath = kzalloc(sizeof(*ath), GFP_ATOMIC);
>> +     if (!ath)
>> +             return -ENOMEM;
>> +
>> +     skb_queue_head_init(&ath->txq);
>> +     spin_lock_init(&ath->hciath_lock);
>> +
>> +     hu->priv = ath;
>> +     ath->hu = hu;
>> +
>> +     init_waitqueue_head(&ath->wqevt);
>> +     INIT_WORK(&ath->ctxtsw, ath_hci_uart_work);
>> +
>> +     return 0;
>> +}
>> +
>> +/* Flush protocol data */
>> +static int ath_flush(struct hci_uart *hu)
>> +{
>> +     struct ath_struct *ath = hu->priv;
>> +
>> +     BT_DBG("hu %p", hu);
>> +
>> +     skb_queue_purge(&ath->txq);
>> +
>> +     return 0;
>> +}
>> +
>> +/* Close protocol */
>> +static int ath_close(struct hci_uart *hu)
>> +{
>> +     struct ath_struct *ath = hu->priv;
>> +
>> +     BT_DBG("hu %p", hu);
>> +
>> +     skb_queue_purge(&ath->txq);
>> +
>> +     kfree_skb(ath->rx_skb);
>> +
>> +     cancel_work_sync(&ath->ctxtsw);
>> +
>> +     hu->priv = NULL;
>> +     kfree(ath);
>> +
>> +     return 0;
>> +}
>> +
>> +/* Enqueue frame for transmittion */
>> +static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>> +{
>> +     struct ath_struct *ath = hu->priv;
>> +
>> +     if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
>> +
>> +             /* Discard SCO packet. AR3001 does not support SCO over HCI */
>> +             BT_DBG("SCO Packet over HCI received Dropping");
>> +
>> +             kfree(skb);
>> +
>> +             return 0;
>> +     }
>> +
>> +     BT_DBG("hu %p skb %p", hu, skb);
>> +
>> +     /* Prepend skb with frame type */
>> +     memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
>> +
>> +     skb_queue_tail(&ath->txq, skb);
>> +     set_bit(HCI_UART_SENDING, &hu->tx_state);
>> +
>> +     schedule_work(&ath->ctxtsw);
>> +
>> +     return 0;
>> +}
>> +
>> +static struct sk_buff *ath_dequeue(struct hci_uart *hu)
>> +{
>> +     struct ath_struct *ath = hu->priv;
>> +     struct sk_buff *skbuf;
>> +
>> +     skbuf = skb_dequeue(&ath->txq);
>> +
>> +     if (!skbuf)
>> +             return NULL;
>> +
>> +     /*
>> +      * Check if the HCI command is  HCI sleep enable and
>> +      * update the sleep enable flag with command parameter.
>> +      *
>> +      * Value of sleep enable flag will be used later
>> +      * to verify if controller has to be woken up before
>> +      * sending any packet.
>> +      */
>> +     if (skbuf->data[0] == 0x01 &&
>> +         skbuf->data[1] == 0x04 &&
>> +         skbuf->data[2] == 0xFC)
>> +             ath->cur_sleep = skbuf->data[4];
>> +
>> +     return skbuf;
>> +}
>> +
>> +static void ath_check_data_len(struct ath_struct *ath, int len)
>> +{
>> +     int room = skb_tailroom(ath->rx_skb);
>> +
>> +     BT_DBG("len %d room %d", len, room);
>> +
>> +     if (len > room) {
>> +             BT_ERR("Data length is too large");
>> +             kfree_skb(ath->rx_skb);
>> +             ath->rx_state = HCIATH_W4_PACKET_TYPE;
>> +             ath->rx_skb = NULL;
>> +             ath->rx_count = 0;
>> +     } else {
>> +             ath->rx_state = HCIATH_W4_DATA;
>> +             ath->rx_count = len;
>> +     }
>> +}
>> +
>> +/* Recv data */
>> +static int ath_recv(struct hci_uart *hu, void *data, int count)
>> +{
>> +     struct ath_struct *ath = hu->priv;
>> +     char *ptr = data;
>> +     struct hci_event_hdr *eh;
>> +     struct hci_acl_hdr *ah;
>> +     struct hci_sco_hdr *sh;
>> +     int len, type, dlen;
>> +
>> +     BT_DBG("hu %p count %d rx_state %d rx_count %d", hu, count,
>> +            ath->rx_state, ath->rx_count);
>> +
>> +     while (count) {
>> +             if (ath->rx_count) {
>> +
>> +                     len = min_t(unsigned int, ath->rx_count, count);
>> +                     memcpy(skb_put(ath->rx_skb, len), ptr, len);
>> +                     ath->rx_count -= len;
>> +                     count -= len;
>> +                     ptr += len;
>> +
>> +                     if (ath->rx_count)
>> +                             continue;
>> +                     switch (ath->rx_state) {
>> +                     case HCIATH_W4_DATA:
>> +                             hci_recv_frame(ath->rx_skb);
>> +                             ath->rx_state = HCIATH_W4_PACKET_TYPE;
>> +                             ath->rx_skb = NULL;
>> +                             ath->rx_count = 0;
>> +                             continue;
>> +
>> +                     case HCIATH_W4_EVENT_HDR:
>> +                             eh = (struct hci_event_hdr *)ath->rx_skb->data;
> 
> Use hci_event_hdr() here like hci_h4.c does.
> 
>> +
>> +                             BT_DBG("Event header: evt 0x%2.2x plen %d",
>> +                                    eh->evt, eh->plen);
>> +
>> +                             ath_check_data_len(ath, eh->plen);
>> +                             continue;
>> +
>> +                     case HCIATH_W4_ACL_HDR:
>> +                             ah = (struct hci_acl_hdr *)ath->rx_skb->data;
> 
> And hci_acl_hdr() here.
> 
>> +                             dlen = __le16_to_cpu(ah->dlen);
>> +
>> +                             BT_DBG("ACL header: dlen %d", dlen);
>> +
>> +                             ath_check_data_len(ath, dlen);
>> +                             continue;
>> +
>> +                     case HCIATH_W4_SCO_HDR:
>> +                             sh = (struct hci_sco_hdr *)ath->rx_skb->data;
> 
> hci_sco_hdr() here.
> 
>> +
>> +                             BT_DBG("SCO header: dlen %d", sh->dlen);
>> +
>> +                             ath_check_data_len(ath, sh->dlen);
>> +                             continue;
>> +
>> +                     }
>> +             }
>> +
>> +             /* HCIATH_W4_PACKET_TYPE */
>> +             switch (*ptr) {
>> +             case HCI_EVENT_PKT:
>> +                     BT_DBG("Event packet");
>> +                     ath->rx_state = HCIATH_W4_EVENT_HDR;
>> +                     ath->rx_count = HCI_EVENT_HDR_SIZE;
>> +                     type = HCI_EVENT_PKT;
>> +                     break;
>> +
>> +             case HCI_ACLDATA_PKT:
>> +                     BT_DBG("ACL packet");
>> +                     ath->rx_state = HCIATH_W4_ACL_HDR;
>> +                     ath->rx_count = HCI_ACL_HDR_SIZE;
>> +                     type = HCI_ACLDATA_PKT;
>> +                     break;
>> +
>> +             case HCI_SCODATA_PKT:
>> +                     BT_DBG("SCO packet");
>> +                     ath->rx_state = HCIATH_W4_SCO_HDR;
>> +                     ath->rx_count = HCI_SCO_HDR_SIZE;
>> +                     type = HCI_SCODATA_PKT;
>> +                     break;
>> +
>> +             default:
>> +                     BT_ERR("Unknown HCI packet type %2.2x", (__u8) *ptr);
>> +                     hu->hdev->stat.err_rx++;
>> +                     ptr++;
>> +                     count--;
>> +                     continue;
>> +
>> +             };
>> +             ptr++;
>> +             count--;
>> +
>> +             /* Allocate packet */
>> +             ath->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
>> +             if (!ath->rx_skb) {
>> +                     BT_ERR("Can't allocate mem for new packet");
>> +                     ath->rx_state = HCIATH_W4_PACKET_TYPE;
>> +                     ath->rx_count = 0;
>> +
>> +                     return -ENOMEM;
>> +             }
>> +             ath->rx_skb->dev = (void *)hu->hdev;
>> +             bt_cb(ath->rx_skb)->pkt_type = type;
>> +     }
>> +
>> +     return count;
>> +}
> 
> Just out of curiosity. I never worked in the driver world, but is it ok
> to duplicate lots of code when working with drivers? hci_h4.c and this
> patch share lots of similar code. ath_recv() and h4_recv() are exactly
> the same except for one line, the ath->rx_count = 0; at case HCIATH_W4_DATA.
> Does this line makes real difference? recv() is not the only function
> duplicating code here.

Let me try to anwer you here. I am also new to the driver world, so 
correct me if I am wrong.

Both drivers do the same job, expect that the ATH driver does something 
more on the data transmit path. So, the receive path does the same 
thing. That is the reason why both looks same. This could possibly 
change later as new feature will be added to the ATH protocol.


The function "hci_recv_fragment()" could potentially replace most of the 
code in the ath_recv() function. But, unfortunately this function 
require the caller to provide the HCI Packet type as parameter.

This defeats all the advantage of "hci_recv_fragment()" in a UART HCI 
transport driver as all types of packets are received through the same 
callback. So the caller will have to write the same messy code in 
ath_recv() to find out the packet type negating all the advantages of 
"hci_recv_fragment()".


> 
>> +
>> +static struct hci_uart_proto athp = {
>> +     .id = HCI_UART_ATH,
>> +     .open = ath_open,
>> +     .close = ath_close,
>> +     .recv = ath_recv,
>> +     .enqueue = ath_enqueue,
>> +     .dequeue = ath_dequeue,
>> +     .flush = ath_flush,
>> +};
>> +
>> +int ath_init(void)
>> +{
>> +     int err = hci_uart_register_proto(&athp);
>> +
>> +     if (!err)
>> +             BT_INFO("HCIATH protocol initialized");
>> +     else
>> +             BT_ERR("HCIATH protocol registration failed");
>> +
>> +     return err;
>> +}
> 
> BTW, we never check this return value on hci_ldisc.c, why?

you, are correct. Just thought of keeping the same signature used by 
other protocol. moreover hci_ldisc.c being a common file used by all 
protocol it is possible that somebody want to check the return value at 
later point of time. So, kept it that way so that we do not have a 
problem then :-D

Your thoughts?
> 
>> +
>> +int ath_deinit(void)
>> +{
>> +     return hci_uart_unregister_proto(&athp);
>> +}
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index 76a1abb..7dd76d1 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -542,6 +542,9 @@ static int __init hci_uart_init(void)
>>  #ifdef CONFIG_BT_HCIUART_LL
>>       ll_init();
>>  #endif
>> +#ifdef CONFIG_BT_HCIUART_ATH
>> +     ath_init();
>> +#endif
>>
>>       return 0;
>>  }
>> @@ -559,6 +562,9 @@ static void __exit hci_uart_exit(void)
>>  #ifdef CONFIG_BT_HCIUART_LL
>>       ll_deinit();
>>  #endif
>> +#ifdef CONFIG_BT_HCIUART_ATH
>> +     ath_deinit();
>> +#endif
>>
>>       /* Release tty registration of line discipline */
>>       if ((err = tty_unregister_ldisc(N_HCI)))
>> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
>> index 50113db..385537f 100644
>> --- a/drivers/bluetooth/hci_uart.h
>> +++ b/drivers/bluetooth/hci_uart.h
>> @@ -33,13 +33,14 @@
>>  #define HCIUARTGETDEVICE     _IOR('U', 202, int)
>>
>>  /* UART protocols */
>> -#define HCI_UART_MAX_PROTO   5
>> +#define HCI_UART_MAX_PROTO   6
>>
>>  #define HCI_UART_H4  0
>>  #define HCI_UART_BCSP        1
>>  #define HCI_UART_3WIRE       2
>>  #define HCI_UART_H4DS        3
>>  #define HCI_UART_LL  4
>> +#define HCI_UART_ATH 5
>>
>>  struct hci_uart;
>>
>> @@ -91,3 +92,8 @@ int bcsp_deinit(void);
>>  int ll_init(void);
>>  int ll_deinit(void);
>>  #endif
>> +
>> +#ifdef CONFIG_BT_HCIUART_ATH
>> +int ath_init(void);
>> +int ath_deinit(void);
>> +#endif
>> --
>> 1.7.0
>>
>>
>>
>>
>>
> 
> --
> Gustavo F. Padovan
> http://padovan.org
