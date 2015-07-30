Return-Path: <cyrus@holtmann.org>
To: <linux-bluetooth@vger.kernel.org>
CC: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
From: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Subject: [PATCH 2/2] Bluetooth: hciuart: Add to support QCA ROME configuration
Message-ID: <55B97ECE.7020307@qca.qualcomm.com>
Date: Wed, 29 Jul 2015 18:33:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

QCA ROME has supported sleep feature using In-Band-Sleep commands
to enable sleep feature based on H4 protocol. After sending
patch/nvm configuration is done, IBS mode will be up and running

Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
---
 drivers/bluetooth/Kconfig       |   12 +
 drivers/bluetooth/Makefile      |    1 +
 drivers/bluetooth/hci_ldisc.c   |    6 +
 drivers/bluetooth/hci_qcarome.c | 1027 +++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_uart.h    |    8 +-
 5 files changed, 1053 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_qcarome.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index f580334..426819d 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -155,6 +155,18 @@ config BT_HCIUART_BCM
 
       Say Y here to compile support for Broadcom protocol.
 
+config BT_HCIUART_QCAROME
+    bool "Qualcomm Atheros protocol support"
+    depends on BT_HCIUART
+    select BT_QCA
+    help
+      The Qualcomm Atheros protocol supports HCI In-Band Sleep feature
+      over serial port interface(H4) between controller and host.
+      This protocol is required for UART clock control for QCA Bluetooth
+      devices.
+
+      Say Y here to compile support for QCA protocol.
+
 config BT_HCIBCM203X
     tristate "HCI BCM203x USB driver"
     depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 15a0d1d..eae2046 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -35,6 +35,7 @@ hci_uart-$(CONFIG_BT_HCIUART_ATH3K)    += hci_ath.o
 hci_uart-$(CONFIG_BT_HCIUART_3WIRE)    += hci_h5.o
 hci_uart-$(CONFIG_BT_HCIUART_INTEL)    += hci_intel.o
 hci_uart-$(CONFIG_BT_HCIUART_BCM)    += hci_bcm.o
+hci_uart-$(CONFIG_BT_HCIUART_QCAROME)    += hci_qcarome.o
 hci_uart-objs                := $(hci_uart-y)
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 20c2ac1..d3c1c5e 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -810,6 +810,9 @@ static int __init hci_uart_init(void)
 #ifdef CONFIG_BT_HCIUART_BCM
     bcm_init();
 #endif
+#ifdef CONFIG_BT_HCIUART_QCAROME
+    rome_init();
+#endif
 
     return 0;
 }
@@ -839,6 +842,9 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_BCM
     bcm_deinit();
 #endif
+#ifdef CONFIG_BT_HCIUART_QCAROME
+    rome_deinit();
+#endif
 
     /* Release tty registration of line discipline */
     err = tty_unregister_ldisc(N_HCI);
diff --git a/drivers/bluetooth/hci_qcarome.c b/drivers/bluetooth/hci_qcarome.c
new file mode 100644
index 0000000..5b752a1
--- /dev/null
+++ b/drivers/bluetooth/hci_qcarome.c
@@ -0,0 +1,1027 @@
+/*
+ *  Bluetooth Software UART Qualcomm protocol
+ *
+ *  HCI_IBS (HCI In-Band Sleep) is Qualcomm's power management
+ *  protocol extension to H4.
+ *
+ *  Copyright (C) 2007 Texas Instruments, Inc.
+ *  Copyright (c) 2010, 2012 The Linux Foundation. All rights reserved.
+ *
+ *  Acknowledgements:
+ *  This file is based on hci_ll.c, which was...
+ *  Written by Ohad Ben-Cohen <ohad@bencohen.org>
+ *  which was in turn based on hci_h4.c, which was written
+ *  by Maxim Krasnyansky and Marcel Holtmann.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/interrupt.h>
+#include <linux/ptrace.h>
+#include <linux/poll.h>
+
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/signal.h>
+#include <linux/ioctl.h>
+#include <linux/timer.h>
+#include <linux/skbuff.h>
+#include <linux/serial_core.h>
+
+#ifdef CONFIG_SERIAL_MSM_HS
+#include <linux/platform_data/msm_serial_hs.h>
+#endif
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "hci_uart.h"
+#include "btqca.h"
+
+/* HCI_IBS protocol messages */
+#define HCI_IBS_SLEEP_IND    0xFE
+#define HCI_IBS_WAKE_IND    0xFD
+#define HCI_IBS_WAKE_ACK    0xFC
+
+/* HCI_IBS receiver States */
+#define HCI_IBS_W4_PACKET_TYPE    0
+#define HCI_IBS_W4_EVENT_HDR    1
+#define HCI_IBS_W4_ACL_HDR    2
+#define HCI_IBS_W4_SCO_HDR    3
+#define HCI_IBS_W4_DATA        4
+
+/* Controller states */
+#define STATE_IN_BAND_SLEEP_ENABLED    1
+
+/* HCI_IBS transmit side sleep protocol states */
+enum tx_ibs_states_e {
+    HCI_IBS_TX_ASLEEP,
+    HCI_IBS_TX_WAKING,
+    HCI_IBS_TX_AWAKE,
+};
+
+/* HCI_IBS receive side sleep protocol states */
+enum rx_states_e {
+    HCI_IBS_RX_ASLEEP,
+    HCI_IBS_RX_AWAKE,
+};
+
+/* HCI_IBS transmit and receive side clock state vote */
+enum hci_ibs_clock_state_vote_e {
+    HCI_IBS_VOTE_STATS_UPDATE,
+    HCI_IBS_TX_VOTE_CLOCK_ON,
+    HCI_IBS_TX_VOTE_CLOCK_OFF,
+    HCI_IBS_RX_VOTE_CLOCK_ON,
+    HCI_IBS_RX_VOTE_CLOCK_OFF,
+};
+
+static unsigned long wake_retrans = 1*100;
+static unsigned long tx_idle_delay = (HZ * 2);
+
+struct hci_ibs_cmd {
+    u8 cmd;
+} __attribute__((packed));
+
+struct rome_data {
+    unsigned long rx_state;
+    unsigned long rx_count;
+    struct sk_buff *rx_skb;
+    struct sk_buff_head txq;
+    struct sk_buff_head tx_wait_q;    /* HCI_IBS wait queue    */
+    spinlock_t hci_ibs_lock;    /* HCI_IBS state lock    */
+    unsigned long tx_ibs_state;    /* HCI_IBS transmit side power state*/
+    unsigned long rx_ibs_state;    /* HCI_IBS receive side power state */
+    unsigned long tx_vote;        /* clock must be on for TX */
+    unsigned long rx_vote;        /* clock must be on for RX */
+    struct    timer_list tx_idle_timer;
+    struct    timer_list wake_retrans_timer;
+    struct    workqueue_struct *workqueue;
+    struct    work_struct ws_awake_rx;
+    struct    work_struct ws_awake_device;
+    struct    work_struct ws_rx_vote_off;
+    struct    work_struct ws_tx_vote_off;
+    unsigned long flags;
+    void *hci_uart; /* keeps the hci_uart pointer for reference */
+
+    /* debug */
+    unsigned long ibs_sent_wacks;
+    unsigned long ibs_sent_slps;
+    unsigned long ibs_sent_wakes;
+    unsigned long ibs_recv_wacks;
+    unsigned long ibs_recv_slps;
+    unsigned long ibs_recv_wakes;
+    unsigned long vote_last_jif;
+    unsigned long vote_on_ticks;
+    unsigned long vote_off_ticks;
+    unsigned long tx_votes_on;
+    unsigned long rx_votes_on;
+    unsigned long tx_votes_off;
+    unsigned long rx_votes_off;
+    unsigned long votes_on;
+    unsigned long votes_off;
+};
+
+static inline void __serial_clock_on(struct tty_struct *tty)
+{
+#ifdef CONFIG_SERIAL_MSM_HS
+    struct uart_state *state = tty->driver_data;
+    struct uart_port *port = state->uart_port;
+
+    msm_hs_request_clock_on(port);
+#endif
+}
+
+static inline void __serial_clock_request_off(struct tty_struct *tty)
+{
+#ifdef CONFIG_SERIAL_MSM_HS
+    struct uart_state *state = tty->driver_data;
+    struct uart_port *port = state->uart_port;
+
+    msm_hs_request_clock_off(port);
+#endif
+}
+
+/* clock_vote needs to be called with the ibs lock held */
+static void serial_clock_vote(unsigned long vote, struct hci_uart *hu)
+{
+    struct rome_data *rome = hu->priv;
+
+    unsigned long old_vote = (rome->tx_vote | rome->rx_vote);
+    unsigned long new_vote;
+
+    switch (vote) {
+    case HCI_IBS_VOTE_STATS_UPDATE:
+        if (old_vote)
+            rome->vote_off_ticks += (jiffies-rome->vote_last_jif);
+        else
+            rome->vote_on_ticks += (jiffies-rome->vote_last_jif);
+        return;
+
+    case HCI_IBS_TX_VOTE_CLOCK_ON:
+        rome->tx_vote = 1;
+        rome->tx_votes_on++;
+        new_vote = 1;
+        break;
+
+    case HCI_IBS_RX_VOTE_CLOCK_ON:
+        rome->rx_vote = 1;
+        rome->rx_votes_on++;
+        new_vote = 1;
+        break;
+
+    case HCI_IBS_TX_VOTE_CLOCK_OFF:
+        rome->tx_vote = 0;
+        rome->tx_votes_off++;
+        new_vote = rome->rx_vote | rome->tx_vote;
+        break;
+
+    case HCI_IBS_RX_VOTE_CLOCK_OFF:
+        rome->rx_vote = 0;
+        rome->rx_votes_off++;
+        new_vote = rome->rx_vote | rome->tx_vote;
+        break;
+
+    default: /* error */
+        BT_ERR("voting irregularity");
+        return;
+    }
+
+    if (new_vote != old_vote) {
+        if (new_vote)
+            __serial_clock_on(hu->tty);
+        else
+            __serial_clock_request_off(hu->tty);
+
+        BT_DBG("HCIUART_IBS: vote serial_hs clock %lu(%lu)",
+               new_vote, vote);
+
+        /* debug */
+        if (new_vote) {
+            rome->votes_on++;
+            rome->vote_off_ticks += (jiffies-rome->vote_last_jif);
+        } else {
+            rome->votes_off++;
+            rome->vote_on_ticks += (jiffies-rome->vote_last_jif);
+        }
+        rome->vote_last_jif = jiffies;
+    }
+}
+
+/*
+ * Builds and sends an HCI_IBS command packet.
+ * These are very simple packets with only 1 cmd byte
+ */
+static int send_hci_ibs_cmd(u8 cmd, struct hci_uart *hu)
+{
+    int err = 0;
+    struct sk_buff *skb = NULL;
+    struct rome_data *rome = hu->priv;
+    struct hci_ibs_cmd *hci_ibs_packet;
+
+    BT_DBG("hu %p send hci ibs cmd 0x%x", hu, cmd);
+
+    /* allocate packet */
+    skb = bt_skb_alloc(1, GFP_ATOMIC);
+    if (!skb) {
+        BT_ERR("cannot allocate memory for HCI_IBS packet");
+        err = -ENOMEM;
+        goto out;
+    }
+
+    /* prepare packet */
+    hci_ibs_packet = (struct hci_ibs_cmd *) skb_put(skb, 1);
+    hci_ibs_packet->cmd = cmd;
+    skb->dev = (void *) hu->hdev;
+
+    /* send packet */
+    skb_queue_tail(&rome->txq, skb);
+out:
+    return err;
+}
+
+static void rome_wq_awake_device(struct work_struct *work)
+{
+    struct rome_data *rome = container_of(work, struct rome_data,
+                          ws_awake_device);
+    struct hci_uart *hu = (struct hci_uart *)rome->hci_uart;
+
+    BT_DBG(" %p wq awake device", hu);
+
+    /* Vote for serial clock */
+    serial_clock_vote(HCI_IBS_TX_VOTE_CLOCK_ON, hu);
+
+    spin_lock(&rome->hci_ibs_lock);
+
+    /* send wake indication to device */
+    if (send_hci_ibs_cmd(HCI_IBS_WAKE_IND, hu) < 0)
+        BT_ERR("cannot send WAKE to device");
+
+    rome->ibs_sent_wakes++; /* debug */
+
+    /* start retransmit timer */
+    mod_timer(&rome->wake_retrans_timer, jiffies + wake_retrans);
+
+    spin_unlock(&rome->hci_ibs_lock);
+
+    /* actually send the packets */
+    hci_uart_tx_wakeup(hu);
+}
+
+static void rome_wq_awake_rx(struct work_struct *work)
+{
+    struct rome_data *rome = container_of(work, struct rome_data,
+                          ws_awake_rx);
+    struct hci_uart *hu = (struct hci_uart *)rome->hci_uart;
+
+    BT_DBG(" %p wq awake rx", hu);
+
+    serial_clock_vote(HCI_IBS_RX_VOTE_CLOCK_ON, hu);
+
+    spin_lock(&rome->hci_ibs_lock);
+    rome->rx_ibs_state = HCI_IBS_RX_AWAKE;
+
+    /* Always acknowledge device wake up,
+     * sending IBS message doesn't count as TX ON
+     */
+    if (send_hci_ibs_cmd(HCI_IBS_WAKE_ACK, hu) < 0)
+        BT_ERR("cannot acknowledge device wake up");
+
+    rome->ibs_sent_wacks++; /* debug */
+
+    spin_unlock(&rome->hci_ibs_lock);
+
+    /* actually send the packets */
+    hci_uart_tx_wakeup(hu);
+}
+
+static void rome_wq_serial_rx_clock_vote_off(struct work_struct *work)
+{
+    struct rome_data *rome = container_of(work, struct rome_data,
+                          ws_rx_vote_off);
+    struct hci_uart *hu = (struct hci_uart *)rome->hci_uart;
+
+    BT_DBG("hu %p rx clock vote off", hu);
+
+    serial_clock_vote(HCI_IBS_RX_VOTE_CLOCK_OFF, hu);
+}
+
+static void rome_wq_serial_tx_clock_vote_off(struct work_struct *work)
+{
+    struct rome_data *rome = container_of(work, struct rome_data,
+                          ws_tx_vote_off);
+    struct hci_uart *hu = (struct hci_uart *)rome->hci_uart;
+
+    BT_DBG("hu %p tx clock vote off", hu);
+
+    hci_uart_tx_wakeup(hu);  /* run HCI tx handling unlocked */
+
+    /* now that message queued to tty driver, vote for tty clocks off
+     * It is up to the tty driver to pend the clocks off until tx done.
+     */
+    serial_clock_vote(HCI_IBS_TX_VOTE_CLOCK_OFF, hu);
+}
+
+static void hci_ibs_tx_idle_timeout(unsigned long arg)
+{
+    struct hci_uart *hu = (struct hci_uart *) arg;
+    struct rome_data *rome = hu->priv;
+    unsigned long flags;
+
+    BT_DBG("hu %p idle timeout in %lu state", hu, rome->tx_ibs_state);
+
+    spin_lock_irqsave_nested(&rome->hci_ibs_lock,
+                 flags, SINGLE_DEPTH_NESTING);
+
+    switch (rome->tx_ibs_state) {
+    case HCI_IBS_TX_AWAKE: /* TX_IDLE, go to SLEEP */
+        if (send_hci_ibs_cmd(HCI_IBS_SLEEP_IND, hu) < 0) {
+            BT_ERR("cannot send SLEEP to device");
+            goto out;
+        }
+        rome->tx_ibs_state = HCI_IBS_TX_ASLEEP;
+        rome->ibs_sent_slps++; /* debug */
+        break;
+
+    case HCI_IBS_TX_ASLEEP:
+    case HCI_IBS_TX_WAKING:
+    default:
+        BT_ERR("spurrious timeout in tx state %ld", rome->tx_ibs_state);
+        goto out;
+    }
+
+    queue_work(rome->workqueue, &rome->ws_tx_vote_off);
+
+out:
+    spin_unlock_irqrestore(&rome->hci_ibs_lock, flags);
+}
+
+static void hci_ibs_wake_retrans_timeout(unsigned long arg)
+{
+    struct hci_uart *hu = (struct hci_uart *) arg;
+    struct rome_data *rome = hu->priv;
+    unsigned long flags;
+    unsigned long retransmit = 0;
+
+    BT_DBG("hu %p wake retransmit timeout in %lu state",
+        hu, rome->tx_ibs_state);
+
+    spin_lock_irqsave_nested(&rome->hci_ibs_lock,
+                 flags, SINGLE_DEPTH_NESTING);
+
+    switch (rome->tx_ibs_state) {
+    case HCI_IBS_TX_WAKING: /* No WAKE_ACK, retransmit WAKE */
+        retransmit = 1;
+        if (send_hci_ibs_cmd(HCI_IBS_WAKE_IND, hu) < 0) {
+            BT_ERR("cannot acknowledge device wake up");
+            goto out;
+        }
+        rome->ibs_sent_wakes++; /* debug */
+        mod_timer(&rome->wake_retrans_timer, jiffies + wake_retrans);
+        break;
+
+    case HCI_IBS_TX_ASLEEP:
+    case HCI_IBS_TX_AWAKE:
+    default:
+        BT_ERR("spurrious timeout tx state %ld", rome->tx_ibs_state);
+        break;
+    }
+
+out:
+    spin_unlock_irqrestore(&rome->hci_ibs_lock, flags);
+    if (retransmit)
+        hci_uart_tx_wakeup(hu);
+}
+
+/* Initialize protocol */
+static int rome_open(struct hci_uart *hu)
+{
+    struct rome_data *rome;
+
+    BT_DBG("hu %p rome_open", hu);
+
+    rome = kzalloc(sizeof(struct rome_data), GFP_ATOMIC);
+    if (!rome)
+        return -ENOMEM;
+
+    skb_queue_head_init(&rome->txq);
+    skb_queue_head_init(&rome->tx_wait_q);
+    spin_lock_init(&rome->hci_ibs_lock);
+    rome->workqueue = create_singlethread_workqueue("rome_wq");
+    if (!rome->workqueue) {
+        BT_ERR("ROME Workqueue not initialized properly");
+        kfree(rome);
+        return -ENOMEM;
+    }
+
+    INIT_WORK(&rome->ws_awake_rx, rome_wq_awake_rx);
+    INIT_WORK(&rome->ws_awake_device, rome_wq_awake_device);
+    INIT_WORK(&rome->ws_rx_vote_off, rome_wq_serial_rx_clock_vote_off);
+    INIT_WORK(&rome->ws_tx_vote_off, rome_wq_serial_tx_clock_vote_off);
+
+    rome->hci_uart = (void *)hu;
+
+    /* Assume we start with both sides asleep -- extra wakes OK */
+    rome->tx_ibs_state = HCI_IBS_TX_ASLEEP;
+    rome->rx_ibs_state = HCI_IBS_RX_ASLEEP;
+    /* clocks actually on, but we start votes off */
+    rome->tx_vote = 0;
+    rome->rx_vote = 0;
+    rome->flags = 0;
+
+    /* debug */
+    rome->ibs_sent_wacks = 0;
+    rome->ibs_sent_slps = 0;
+    rome->ibs_sent_wakes = 0;
+    rome->ibs_recv_wacks = 0;
+    rome->ibs_recv_slps = 0;
+    rome->ibs_recv_wakes = 0;
+    rome->vote_last_jif = jiffies;
+    rome->vote_on_ticks = 0;
+    rome->vote_off_ticks = 0;
+    rome->votes_on = 0;
+    rome->votes_off = 0;
+    rome->tx_votes_on = 0;
+    rome->tx_votes_off = 0;
+    rome->rx_votes_on = 0;
+    rome->rx_votes_off = 0;
+
+    hu->priv = rome;
+
+    init_timer(&rome->wake_retrans_timer);
+    rome->wake_retrans_timer.function = hci_ibs_wake_retrans_timeout;
+    rome->wake_retrans_timer.data     = (u_long) hu;
+
+    init_timer(&rome->tx_idle_timer);
+    rome->tx_idle_timer.function = hci_ibs_tx_idle_timeout;
+    rome->tx_idle_timer.data     = (u_long) hu;
+
+    BT_INFO("HCI_UART_ROME open, tx_idle_delay=%lu, wake_retrans=%lu",
+        tx_idle_delay, wake_retrans);
+
+    return 0;
+}
+
+static void ibs_log_local_stats(struct rome_data *rome)
+{
+    BT_INFO("HCI_UART_ROME stats: tx_idle_delay=%lu, wake_retrans=%lu",
+        tx_idle_delay, wake_retrans);
+
+    BT_INFO("HCI_UART_ROME stats: tx_ibs_state=%lu, rx_ibs_state=%lu",
+        rome->tx_ibs_state, rome->rx_ibs_state);
+    BT_INFO("HCI_UART_ROME stats: sent: sleep=%lu, wake=%lu, wake_ack=%lu",
+        rome->ibs_sent_slps,rome->ibs_sent_wakes,rome->ibs_sent_wacks);
+    BT_INFO("HCI_UART_ROME stats: recv: sleep=%lu, wake=%lu, wake_ack=%lu",
+        rome->ibs_recv_slps,rome->ibs_recv_wakes,rome->ibs_recv_wacks);
+
+    BT_INFO("HCI_UART_ROME stats: queues: txq=%s, txwaitq=%s",
+        skb_queue_empty(&(rome->txq)) ? "empty" : "full",
+        skb_queue_empty(&(rome->tx_wait_q)) ? "empty" : "full");
+
+    BT_INFO("HCI_UART_ROME stats: vote state: tx=%lu, rx=%lu",
+        rome->tx_vote, rome->rx_vote);
+    BT_INFO("HCI_UART_ROME stats: tx votes cast: on=%lu, off=%lu",
+        rome->tx_votes_on, rome->tx_votes_off);
+    BT_INFO("HCI_UART_ROME stats: rx votes cast: on=%lu, off=%lu",
+        rome->rx_votes_on, rome->rx_votes_off);
+    BT_INFO("HCI_UART_ROME stats: msm_clock votes cast: on=%lu, off=%lu",
+        rome->votes_on, rome->votes_off);
+    BT_INFO("HCI_UART_ROME stats: vote ticks: on=%lu, off=%lu",
+        rome->vote_on_ticks, rome->vote_off_ticks);
+}
+
+/* Flush protocol data */
+static int rome_flush(struct hci_uart *hu)
+{
+    struct rome_data *rome = hu->priv;
+
+    BT_DBG("hu %p rome flush", hu);
+
+    skb_queue_purge(&rome->tx_wait_q);
+    skb_queue_purge(&rome->txq);
+
+    return 0;
+}
+
+/* Close protocol */
+static int rome_close(struct hci_uart *hu)
+{
+    struct rome_data *rome = hu->priv;
+
+    BT_DBG("hu %p rome close", hu);
+
+    serial_clock_vote(HCI_IBS_VOTE_STATS_UPDATE, hu);
+    ibs_log_local_stats(rome);
+
+    skb_queue_purge(&rome->tx_wait_q);
+    skb_queue_purge(&rome->txq);
+    del_timer(&rome->tx_idle_timer);
+    del_timer(&rome->wake_retrans_timer);
+    destroy_workqueue(rome->workqueue);
+    rome->hci_uart = NULL;
+
+    kfree_skb(rome->rx_skb);
+
+    hu->priv = NULL;
+
+    kfree(rome);
+
+    return 0;
+}
+
+/*
+ * Called upon a wake-up-indication from the device
+ */
+static void device_want_to_wakeup(struct hci_uart *hu)
+{
+    unsigned long flags;
+    struct rome_data *rome = hu->priv;
+
+    BT_DBG("hu %p want to wake up", hu);
+
+    spin_lock_irqsave(&rome->hci_ibs_lock, flags);
+
+    /* debug */
+    rome->ibs_recv_wakes++;
+
+    switch (rome->rx_ibs_state) {
+    case HCI_IBS_RX_ASLEEP:
+        /* Make sure clock is on - we may have turned clock off since
+         * receiving the wake up indicator
+         */
+        /* awake rx clock */
+        queue_work(rome->workqueue, &rome->ws_awake_rx);
+        spin_unlock_irqrestore(&rome->hci_ibs_lock, flags);
+        return;
+
+    case HCI_IBS_RX_AWAKE:
+        /* Always acknowledge device wake up,
+         * sending IBS message doesn't count as TX ON.
+         */
+        if (send_hci_ibs_cmd(HCI_IBS_WAKE_ACK, hu) < 0) {
+            BT_ERR("cannot acknowledge device wake up");
+            goto out;
+        }
+        rome->ibs_sent_wacks++; /* debug */
+        break;
+
+    default:
+        /* any other state is illegal */
+        BT_ERR("received HCI_IBS_WAKE_IND in rx state %ld",
+            rome->rx_ibs_state);
+        break;
+    }
+
+out:
+    spin_unlock_irqrestore(&rome->hci_ibs_lock, flags);
+
+    /* actually send the packets */
+    hci_uart_tx_wakeup(hu);
+}
+
+/*
+ * Called upon a sleep-indication from the device
+ */
+static void device_want_to_sleep(struct hci_uart *hu)
+{
+    unsigned long flags;
+    struct rome_data *rome = hu->priv;
+
+    BT_DBG("hu %p want to sleep", hu);
+
+    spin_lock_irqsave(&rome->hci_ibs_lock, flags);
+
+    /* debug */
+    rome->ibs_recv_slps++;
+
+    switch (rome->rx_ibs_state) {
+    case HCI_IBS_RX_AWAKE:
+        /* update state */
+        rome->rx_ibs_state = HCI_IBS_RX_ASLEEP;
+        /* vote off rx clock under workqueue */
+        queue_work(rome->workqueue, &rome->ws_rx_vote_off);
+        break;
+
+    case HCI_IBS_RX_ASLEEP:
+        /* deliberate fall-through */
+    default:
+        /* any other state is illegal */
+        BT_ERR("received HCI_IBS_SLEEP_IND in rx state %ld",
+            rome->rx_ibs_state);
+        break;
+    }
+
+    spin_unlock_irqrestore(&rome->hci_ibs_lock, flags);
+}
+
+/*
+ * Called upon wake-up-acknowledgement from the device
+ */
+static void device_woke_up(struct hci_uart *hu)
+{
+    unsigned long flags;
+    struct rome_data *rome = hu->priv;
+    struct sk_buff *skb = NULL;
+
+    BT_DBG("hu %p woke up", hu);
+
+    spin_lock_irqsave(&rome->hci_ibs_lock, flags);
+
+    /* debug */
+    rome->ibs_recv_wacks++;
+
+    switch (rome->tx_ibs_state) {
+    case HCI_IBS_TX_AWAKE:
+        /* expect one if we send 2 WAKEs */
+        BT_DBG("received HCI_IBS_WAKE_ACK in tx state %ld",
+            rome->tx_ibs_state);
+        break;
+
+    case HCI_IBS_TX_WAKING:
+        /* send pending packets */
+        while ((skb = skb_dequeue(&rome->tx_wait_q)))
+            skb_queue_tail(&rome->txq, skb);
+
+        /* switch timers and change state to HCI_IBS_TX_AWAKE */
+        del_timer(&rome->wake_retrans_timer);
+        mod_timer(&rome->tx_idle_timer, jiffies + tx_idle_delay);
+        rome->tx_ibs_state = HCI_IBS_TX_AWAKE;
+        break;
+
+    case HCI_IBS_TX_ASLEEP:
+        /* This could be spurrious rx wake on the BT chip.
+         * Send it another SLEEP othwise it will stay awake. */
+    default:
+        BT_ERR("received HCI_IBS_WAKE_ACK in tx state %ld",
+            rome->tx_ibs_state);
+        break;
+    }
+
+    spin_unlock_irqrestore(&rome->hci_ibs_lock, flags);
+
+    /* actually send the packets */
+    hci_uart_tx_wakeup(hu);
+}
+
+/* Enqueue frame for transmittion (padding, crc, etc) */
+/* may be called from two simultaneous tasklets */
+static int rome_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+    unsigned long flags = 0;
+    struct rome_data *rome = hu->priv;
+
+    BT_DBG("hu %p rome enq skb %p tx_ibs_state %ld", hu, skb,
+           rome->tx_ibs_state);
+
+    /* Prepend skb with frame type */
+    memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+
+    /* don't go to sleep in middle of patch download or
+     * Out-Of-Band(GPIOs control) sleep is selected
+     */
+    if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &rome->flags)) {
+        skb_queue_tail(&rome->txq, skb);
+        return 0;
+    }
+
+    spin_lock_irqsave(&rome->hci_ibs_lock, flags);
+
+    /* act according to current state */
+    switch (rome->tx_ibs_state) {
+    case HCI_IBS_TX_AWAKE:
+        BT_DBG("device awake, sending normally");
+        skb_queue_tail(&rome->txq, skb);
+        mod_timer(&rome->tx_idle_timer, jiffies + tx_idle_delay);
+        break;
+
+    case HCI_IBS_TX_ASLEEP:
+        BT_DBG("device asleep, waking up and queueing packet");
+        /* save packet for later */
+        skb_queue_tail(&rome->tx_wait_q, skb);
+
+        rome->tx_ibs_state = HCI_IBS_TX_WAKING;
+        /* schedule a work queue to wake up device */
+        queue_work(rome->workqueue, &rome->ws_awake_device);
+        break;
+
+    case HCI_IBS_TX_WAKING:
+        BT_DBG("device waking up, queueing packet");
+        /* transient state; just keep packet for later */
+        skb_queue_tail(&rome->tx_wait_q, skb);
+        break;
+
+    default:
+        BT_ERR("illegal tx state: %ld (losing packet)",
+               rome->tx_ibs_state);
+        kfree_skb(skb);
+        break;
+    }
+
+    spin_unlock_irqrestore(&rome->hci_ibs_lock, flags);
+
+    return 0;
+}
+
+static inline int check_data_len(struct hci_dev *hdev, struct rome_data *rome,
+                 int len)
+{
+    register int room = skb_tailroom(rome->rx_skb);
+
+    BT_DBG("len %d room %d", len, room);
+
+    if (!len) {
+        hci_recv_frame(hdev, rome->rx_skb);
+        goto out;
+    }
+
+    if (len > room) {
+        BT_ERR("Data length is too large");
+        kfree_skb(rome->rx_skb);
+        goto out;
+    }
+
+    rome->rx_state = HCI_IBS_W4_DATA;
+    rome->rx_count = len;
+    return len;
+
+out:
+    rome->rx_state = HCI_IBS_W4_PACKET_TYPE;
+    rome->rx_skb   = NULL;
+    rome->rx_count = 0;
+
+    return 0;
+}
+
+/* Recv data */
+static int rome_recv(struct hci_uart *hu, const void *data, int count)
+{
+    struct rome_data *rome = hu->priv;
+    struct sk_buff *skb;
+    const uint8_t *ptr;
+    struct hci_event_hdr *eh;
+    struct hci_acl_hdr   *ah;
+    struct hci_sco_hdr   *sh;
+    register int len, type, dlen;
+    int ret;
+
+    BT_DBG("hu %p rome_recv count %d rx_state %ld rx_count %ld",
+           hu, count, rome->rx_state, rome->rx_count);
+
+    ptr = (const uint8_t*)data;
+    while (count) {
+        if (rome->rx_count) {
+            len = min_t(unsigned int, rome->rx_count, count);
+            memcpy(skb_put(rome->rx_skb, len), ptr, len);
+            rome->rx_count -= len; count -= len; ptr += len;
+
+            if (rome->rx_count)
+                continue;
+
+            switch (rome->rx_state) {
+            case HCI_IBS_W4_DATA:
+                BT_DBG("Complete data");
+                skb = rome->rx_skb;
+                rome_debug_dump(skb->data, skb->len, false);
+                ret = rome_vendor_frame(hu->hdev, skb);
+                if (!ret)
+                    ret = hci_recv_frame(hu->hdev, skb);
+
+                rome->rx_state = HCI_IBS_W4_PACKET_TYPE;
+                rome->rx_skb = NULL;
+                continue;
+
+            case HCI_IBS_W4_EVENT_HDR:
+                eh = (struct hci_event_hdr *)rome->rx_skb->data;
+
+                BT_DBG("Event header: evt 0x%2.2x plen %d",
+                    eh->evt, eh->plen);
+
+                check_data_len(hu->hdev, rome, eh->plen);
+                continue;
+
+            case HCI_IBS_W4_ACL_HDR:
+                ah = (struct hci_acl_hdr *)rome->rx_skb->data;
+                dlen = le16_to_cpu(ah->dlen);
+
+                BT_DBG("ACL header: dlen %d", dlen);
+
+                check_data_len(hu->hdev, rome, dlen);
+                continue;
+
+            case HCI_IBS_W4_SCO_HDR:
+                sh = (struct hci_sco_hdr *)rome->rx_skb->data;
+
+                BT_DBG("SCO header: dlen %d", sh->dlen);
+
+                check_data_len(hu->hdev, rome, sh->dlen);
+                continue;
+            }
+        }
+
+        switch (*ptr) {
+        case HCI_EVENT_PKT:
+            BT_DBG("Event packet");
+            rome->rx_state = HCI_IBS_W4_EVENT_HDR;
+            rome->rx_count = HCI_EVENT_HDR_SIZE;
+            type = HCI_EVENT_PKT;
+            break;
+
+        case HCI_ACLDATA_PKT:
+            BT_DBG("ACL packet");
+            rome->rx_state = HCI_IBS_W4_ACL_HDR;
+            rome->rx_count = HCI_ACL_HDR_SIZE;
+            type = HCI_ACLDATA_PKT;
+            break;
+
+        case HCI_SCODATA_PKT:
+            BT_DBG("SCO packet");
+            rome->rx_state = HCI_IBS_W4_SCO_HDR;
+            rome->rx_count = HCI_SCO_HDR_SIZE;
+            type = HCI_SCODATA_PKT;
+            break;
+
+        /* HCI_IBS signals */
+        case HCI_IBS_SLEEP_IND:
+            BT_DBG("HCI_IBS_SLEEP_IND packet");
+            rome_debug_dump(ptr, 1, false);
+            device_want_to_sleep(hu);
+            ptr++; count--;
+            continue;
+
+        case HCI_IBS_WAKE_IND:
+            BT_DBG("HCI_IBS_WAKE_IND packet");
+            rome_debug_dump(ptr, 1, false);
+            device_want_to_wakeup(hu);
+            ptr++; count--;
+            continue;
+
+        case HCI_IBS_WAKE_ACK:
+            BT_DBG("HCI_IBS_WAKE_ACK packet");
+            rome_debug_dump(ptr, 1, false);
+            device_woke_up(hu);
+            ptr++; count--;
+            continue;
+
+        default:
+            BT_ERR("Unknown HCI packet type %2.2x", (__u8)*ptr);
+            hu->hdev->stat.err_rx++;
+            ptr++; count--;
+            continue;
+        };
+
+        ptr++; count--;
+
+        /* Allocate packet */
+        rome->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
+        if (!rome->rx_skb) {
+            BT_ERR("Can't allocate mem for new packet");
+            rome->rx_state = HCI_IBS_W4_PACKET_TYPE;
+            rome->rx_count = 0;
+            return 0;
+        }
+
+        rome->rx_skb->dev = (void *) hu->hdev;
+        bt_cb(rome->rx_skb)->pkt_type = type;
+    }
+
+    return count;
+}
+
+static struct sk_buff *rome_dequeue(struct hci_uart *hu)
+{
+    struct rome_data *rome = hu->priv;
+    struct sk_buff *skb;
+
+    skb = skb_dequeue(&rome->txq);
+    if (skb) {
+        rome_debug_dump(skb->data, skb->len, true);
+    }
+
+    return skb;
+}
+
+static int rome_set_baudrate(struct hci_dev *hdev, unsigned int speed)
+{
+    struct sk_buff *skb;
+    uint8_t baudrate;
+
+    if (speed > 3000000)
+        return -EINVAL;
+
+    BT_INFO("%s: Set controller UART speed to %d", hdev->name, speed);
+
+    baudrate = rome_get_baudrate(speed);
+    skb = __hci_cmd_sync(hdev, EDL_PATCH_BAUDRATE, 1, &baudrate,
+                 msecs_to_jiffies(100));
+    if (IS_ERR(skb)) {
+        if (PTR_ERR(skb) == -ETIMEDOUT)
+            return 0;
+
+        return PTR_ERR(skb);
+    }
+
+    kfree_skb(skb);
+    return 0;
+}
+
+static int rome_setup(struct hci_uart *hu)
+{
+    struct hci_dev *hdev = hu->hdev;
+    struct rome_data *rome = hu->priv;
+    unsigned int speed;
+    int ret;
+
+    BT_INFO("%s: ROME setup", hdev->name);
+
+    /* Patch downloading has to be done without IBS mode */
+    clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &rome->flags);
+
+    /* setup initial baudrate */
+    speed = 0;
+    if (hu->init_speed)
+        speed = hu->init_speed;
+    else if (hu->proto->init_speed)
+        speed = hu->proto->init_speed;
+
+    if (speed)
+        hci_uart_set_baudrate(hu, speed);
+
+    /* setup user speed if needed */
+    speed = 0;
+    if (hu->oper_speed)
+        speed = hu->oper_speed;
+    else if (hu->proto->oper_speed)
+        speed = hu->proto->oper_speed;
+
+    if (speed) {
+        ret = rome_set_baudrate(hdev, speed);
+        if (ret) {
+            BT_ERR("%s: can't change the baud rate (%d)",
+                   hdev->name, ret);
+            return ret;
+        }
+        hci_uart_set_baudrate(hu, speed);
+    }
+
+    /* setup patch / nvm configurations */
+    ret = rome_uart_setup(hdev, speed);
+#ifdef QCA_FEATURE_UART_IN_BAND_SLEEP
+    if (!ret)
+        set_bit(STATE_IN_BAND_SLEEP_ENABLED, &rome->flags);
+#endif
+
+    /* setup bdaddr */
+    hu->hdev->set_bdaddr = rome_set_bdaddr;
+
+    return ret;
+}
+
+static struct hci_uart_proto rome_p = {
+    .id        = HCI_UART_ROME,
+    .name        = "ROME",
+    .open        = rome_open,
+    .init_speed    = 115200,
+    .oper_speed    = 3000000,
+    .close        = rome_close,
+    .recv        = rome_recv,
+    .enqueue    = rome_enqueue,
+    .dequeue    = rome_dequeue,
+    .flush        = rome_flush,
+    .setup        = rome_setup,
+};
+
+int __init rome_init(void)
+{
+    return hci_uart_register_proto(&rome_p);
+}
+
+int __exit rome_deinit(void)
+{
+    return hci_uart_unregister_proto(&rome_p);
+}
+
+module_param(wake_retrans, ulong, 0644);
+MODULE_PARM_DESC(wake_retrans, "Delay (1/HZ) to retransmit WAKE_IND");
+
+module_param(tx_idle_delay, ulong, 0644);
+MODULE_PARM_DESC(tx_idle_delay, "Delay (1/HZ) since last tx for SLEEP_IND");
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 496587a..dfdde8b 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,7 +35,7 @@
 #define HCIUARTGETFLAGS        _IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO    8
+#define HCI_UART_MAX_PROTO    9
 
 #define HCI_UART_H4    0
 #define HCI_UART_BCSP    1
@@ -45,6 +45,7 @@
 #define HCI_UART_ATH3K    5
 #define HCI_UART_INTEL    6
 #define HCI_UART_BCM    7
+#define HCI_UART_ROME     8
 
 #define HCI_UART_RAW_DEVICE    0
 #define HCI_UART_RESET_ON_INIT    1
@@ -176,3 +177,8 @@ int intel_deinit(void);
 int bcm_init(void);
 int bcm_deinit(void);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_QCAROME
+int rome_init(void);
+int rome_deinit(void);
+#endif
-- 
2.0.5
