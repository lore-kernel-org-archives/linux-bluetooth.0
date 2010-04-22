Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Thu, 22 Apr 2010 05:59:22 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [PATCH v4] Add support for the Atheros AR300x Bluetooth Chip
Message-ID: <20100422085922.GG22959@vigoh>
References: <1268629296.21425.23.camel@atheros013-desktop>
 <1271758832.6585.33.camel@atheros013-desktop>
 <1271845337.15010.1.camel@atheros013-desktop>
 <20100422061056.GE22959@vigoh>
 <4BCFF28C.8000606@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BCFF28C.8000606@atheros.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

* Suraj Sumangala <suraj@atheros.com> [2010-04-22 12:24:04 +0530]:

> 
> Hi Gustavo,
> 
> Gustavo F. Padovan wrote:
> >* suraj <suraj@atheros.com> [2010-04-21 15:52:17 +0530]:
> >
> >>This implements the Atheros Bluetooth serial protocol to
> >>support the AR300x Bluetooth chipsets.
> >>The serial protocol implements enhanced power management
> >>features for the AR300x chipsets.
> >>
> >>Reviewed-by: Luis R. Rodriguez <lrodriguez@atheros.com>
> >>Signed-off-by: Suraj <suraj@atheros.com>
> >>
> >>---
> >> drivers/bluetooth/Kconfig     |   14 ++
> >> drivers/bluetooth/Makefile    |    1 +
> >> drivers/bluetooth/hci_ath.c   |  378 +++++++++++++++++++++++++++++++++++++++++
> >> drivers/bluetooth/hci_ldisc.c |    6 +
> >> drivers/bluetooth/hci_uart.h  |    8 +-
> >> 5 files changed, 406 insertions(+), 1 deletions(-)
> >> create mode 100755 drivers/bluetooth/hci_ath.c
> >>

..snip..

> >>+
> >>+static void ath_check_data_len(struct ath_struct *ath, int len)
> >>+{
> >>+     int room = skb_tailroom(ath->rx_skb);
> >>+
> >>+     BT_DBG("len %d room %d", len, room);
> >>+
> >>+     if (len > room) {
> >>+             BT_ERR("Data length is too large");
> >>+             kfree_skb(ath->rx_skb);
> >>+             ath->rx_state = HCIATH_W4_PACKET_TYPE;
> >>+             ath->rx_skb = NULL;
> >>+             ath->rx_count = 0;
> >>+     } else {
> >>+             ath->rx_state = HCIATH_W4_DATA;
> >>+             ath->rx_count = len;
> >>+     }
> >>+}
> >>+
> >>+/* Recv data */
> >>+static int ath_recv(struct hci_uart *hu, void *data, int count)
> >>+{
> >>+     struct ath_struct *ath = hu->priv;
> >>+     char *ptr = data;
> >>+     struct hci_event_hdr *eh;
> >>+     struct hci_acl_hdr *ah;
> >>+     struct hci_sco_hdr *sh;
> >>+     int len, type, dlen;
> >>+
> >>+     BT_DBG("hu %p count %d rx_state %d rx_count %d", hu, count,
> >>+            ath->rx_state, ath->rx_count);
> >>+
> >>+     while (count) {
> >>+             if (ath->rx_count) {
> >>+
> >>+                     len = min_t(unsigned int, ath->rx_count, count);
> >>+                     memcpy(skb_put(ath->rx_skb, len), ptr, len);
> >>+                     ath->rx_count -= len;
> >>+                     count -= len;
> >>+                     ptr += len;
> >>+
> >>+                     if (ath->rx_count)
> >>+                             continue;
> >>+                     switch (ath->rx_state) {
> >>+                     case HCIATH_W4_DATA:
> >>+                             hci_recv_frame(ath->rx_skb);
> >>+                             ath->rx_state = HCIATH_W4_PACKET_TYPE;
> >>+                             ath->rx_skb = NULL;
> >>+                             ath->rx_count = 0;
> >>+                             continue;
> >>+
> >>+                     case HCIATH_W4_EVENT_HDR:
> >>+                             eh = (struct hci_event_hdr *)ath->rx_skb->data;
> >
> >Use hci_event_hdr() here like hci_h4.c does.
> >
> >>+
> >>+                             BT_DBG("Event header: evt 0x%2.2x plen %d",
> >>+                                    eh->evt, eh->plen);
> >>+
> >>+                             ath_check_data_len(ath, eh->plen);
> >>+                             continue;
> >>+
> >>+                     case HCIATH_W4_ACL_HDR:
> >>+                             ah = (struct hci_acl_hdr *)ath->rx_skb->data;
> >
> >And hci_acl_hdr() here.
> >
> >>+                             dlen = __le16_to_cpu(ah->dlen);
> >>+
> >>+                             BT_DBG("ACL header: dlen %d", dlen);
> >>+
> >>+                             ath_check_data_len(ath, dlen);
> >>+                             continue;
> >>+
> >>+                     case HCIATH_W4_SCO_HDR:
> >>+                             sh = (struct hci_sco_hdr *)ath->rx_skb->data;
> >
> >hci_sco_hdr() here.
> >
> >>+
> >>+                             BT_DBG("SCO header: dlen %d", sh->dlen);
> >>+
> >>+                             ath_check_data_len(ath, sh->dlen);
> >>+                             continue;
> >>+
> >>+                     }
> >>+             }
> >>+
> >>+             /* HCIATH_W4_PACKET_TYPE */
> >>+             switch (*ptr) {
> >>+             case HCI_EVENT_PKT:
> >>+                     BT_DBG("Event packet");
> >>+                     ath->rx_state = HCIATH_W4_EVENT_HDR;
> >>+                     ath->rx_count = HCI_EVENT_HDR_SIZE;
> >>+                     type = HCI_EVENT_PKT;
> >>+                     break;
> >>+
> >>+             case HCI_ACLDATA_PKT:
> >>+                     BT_DBG("ACL packet");
> >>+                     ath->rx_state = HCIATH_W4_ACL_HDR;
> >>+                     ath->rx_count = HCI_ACL_HDR_SIZE;
> >>+                     type = HCI_ACLDATA_PKT;
> >>+                     break;
> >>+
> >>+             case HCI_SCODATA_PKT:
> >>+                     BT_DBG("SCO packet");
> >>+                     ath->rx_state = HCIATH_W4_SCO_HDR;
> >>+                     ath->rx_count = HCI_SCO_HDR_SIZE;
> >>+                     type = HCI_SCODATA_PKT;
> >>+                     break;
> >>+
> >>+             default:
> >>+                     BT_ERR("Unknown HCI packet type %2.2x", (__u8) *ptr);
> >>+                     hu->hdev->stat.err_rx++;
> >>+                     ptr++;
> >>+                     count--;
> >>+                     continue;
> >>+
> >>+             };
> >>+             ptr++;
> >>+             count--;
> >>+
> >>+             /* Allocate packet */
> >>+             ath->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
> >>+             if (!ath->rx_skb) {
> >>+                     BT_ERR("Can't allocate mem for new packet");
> >>+                     ath->rx_state = HCIATH_W4_PACKET_TYPE;
> >>+                     ath->rx_count = 0;
> >>+
> >>+                     return -ENOMEM;
> >>+             }
> >>+             ath->rx_skb->dev = (void *)hu->hdev;
> >>+             bt_cb(ath->rx_skb)->pkt_type = type;
> >>+     }
> >>+
> >>+     return count;
> >>+}
> >
> >Just out of curiosity. I never worked in the driver world, but is it ok
> >to duplicate lots of code when working with drivers? hci_h4.c and this
> >patch share lots of similar code. ath_recv() and h4_recv() are exactly
> >the same except for one line, the ath->rx_count = 0; at case HCIATH_W4_DATA.
> >Does this line makes real difference? recv() is not the only function
> >duplicating code here.
> 
> Let me try to anwer you here. I am also new to the driver world, so
> correct me if I am wrong.
> 
> Both drivers do the same job, expect that the ATH driver does
> something more on the data transmit path. So, the receive path does
> the same thing. That is the reason why both looks same. This could
> possibly change later as new feature will be added to the ATH
> protocol.

Ok. I'm thinking if it is not possible create a separated 'lib' with the
common code. That's why I asked about the code duplication. I don't know
how worth it is, since we have only 3 drivers using similar code.

> 
> 
> The function "hci_recv_fragment()" could potentially replace most of
> the code in the ath_recv() function. But, unfortunately this
> function require the caller to provide the HCI Packet type as
> parameter.
> 
> This defeats all the advantage of "hci_recv_fragment()" in a UART
> HCI transport driver as all types of packets are received through
> the same callback. So the caller will have to write the same messy
> code in ath_recv() to find out the packet type negating all the
> advantages of "hci_recv_fragment()".
> 
> 
> >
> >>+
> >>+static struct hci_uart_proto athp = {
> >>+     .id = HCI_UART_ATH,
> >>+     .open = ath_open,
> >>+     .close = ath_close,
> >>+     .recv = ath_recv,
> >>+     .enqueue = ath_enqueue,
> >>+     .dequeue = ath_dequeue,
> >>+     .flush = ath_flush,
> >>+};
> >>+
> >>+int ath_init(void)
> >>+{
> >>+     int err = hci_uart_register_proto(&athp);
> >>+
> >>+     if (!err)
> >>+             BT_INFO("HCIATH protocol initialized");
> >>+     else
> >>+             BT_ERR("HCIATH protocol registration failed");
> >>+
> >>+     return err;
> >>+}
> >
> >BTW, we never check this return value on hci_ldisc.c, why?
> 
> you, are correct. Just thought of keeping the same signature used by
> other protocol. moreover hci_ldisc.c being a common file used by all
> protocol it is possible that somebody want to check the return value
> at later point of time. So, kept it that way so that we do not have
> a problem then :-D
> 
> Your thoughts?

Yes, your code is right, the return value should be kept.  The problem
is that hci_uart_init() doesn't check any other protocol initialization
(h4, bcsp and ll). My thought is: we really need to check?

Marcel, can you answer that?

> >
> >>+
> >>+int ath_deinit(void)
> >>+{
> >>+     return hci_uart_unregister_proto(&athp);
> >>+}
> >>diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> >>index 76a1abb..7dd76d1 100644
> >>--- a/drivers/bluetooth/hci_ldisc.c
> >>+++ b/drivers/bluetooth/hci_ldisc.c
> >>@@ -542,6 +542,9 @@ static int __init hci_uart_init(void)
> >> #ifdef CONFIG_BT_HCIUART_LL
> >>      ll_init();
> >> #endif
> >>+#ifdef CONFIG_BT_HCIUART_ATH
> >>+     ath_init();
> >>+#endif
> >>
> >>      return 0;
> >> }
> >>@@ -559,6 +562,9 @@ static void __exit hci_uart_exit(void)
> >> #ifdef CONFIG_BT_HCIUART_LL
> >>      ll_deinit();
> >> #endif
> >>+#ifdef CONFIG_BT_HCIUART_ATH
> >>+     ath_deinit();
> >>+#endif
> >>
> >>      /* Release tty registration of line discipline */
> >>      if ((err = tty_unregister_ldisc(N_HCI)))
> >>diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> >>index 50113db..385537f 100644
> >>--- a/drivers/bluetooth/hci_uart.h
> >>+++ b/drivers/bluetooth/hci_uart.h
> >>@@ -33,13 +33,14 @@
> >> #define HCIUARTGETDEVICE     _IOR('U', 202, int)
> >>
> >> /* UART protocols */
> >>-#define HCI_UART_MAX_PROTO   5
> >>+#define HCI_UART_MAX_PROTO   6
> >>
> >> #define HCI_UART_H4  0
> >> #define HCI_UART_BCSP        1
> >> #define HCI_UART_3WIRE       2
> >> #define HCI_UART_H4DS        3
> >> #define HCI_UART_LL  4
> >>+#define HCI_UART_ATH 5
> >>
> >> struct hci_uart;
> >>
> >>@@ -91,3 +92,8 @@ int bcsp_deinit(void);
> >> int ll_init(void);
> >> int ll_deinit(void);
> >> #endif
> >>+
> >>+#ifdef CONFIG_BT_HCIUART_ATH
> >>+int ath_init(void);
> >>+int ath_deinit(void);
> >>+#endif
> >>--
> >>1.7.0
> >>
> >>
> >>
> >>
> >>
> >
> >--
> >Gustavo F. Padovan
> >http://padovan.org
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org
