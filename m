Return-Path: <cyrus@holtmann.org>
To: <linux-bluetooth@vger.kernel.org>,
	"Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
From: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Subject: [PATCH v3 2/2] Bluetooth: hciuart: Add support QCA chipset for UART
Message-ID: <55C40A13.1000801@qca.qualcomm.com>
Date: Thu, 6 Aug 2015 18:29:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

QCA61x4 chips have supported sleep feature using In-Band-Sleep commands
to enable sleep feature based on H4 protocol. After sending
patch/nvm configuration is done, IBS mode will be up and running

Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
---
 drivers/bluetooth/Kconfig     |   13 +
 drivers/bluetooth/Makefile    |    1 +
 drivers/bluetooth/hci_ldisc.c |    6 +
 drivers/bluetooth/hci_qca.c   | 1004 +++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_uart.h  |    8 +-
 5 files changed, 1031 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_qca.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index f580334..0bd88c9 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -155,6 +155,19 @@ config BT_HCIUART_BCM
 
 	  Say Y here to compile support for Broadcom protocol.
 
+config BT_HCIUART_QCA
+	bool "Qualcomm Atheros protocol support"
+	depends on BT_HCIUART
+	select BT_HCIUART_H4
+	select BT_QCA
+	help
+	  The Qualcomm Atheros protocol supports HCI In-Band Sleep feature
+	  over serial port interface(H4) between controller and host.
+	  This protocol is required for UART clock control for QCA Bluetooth
+	  devices.
+
+	  Say Y here to compile support for QCA protocol.
+
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
 	depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 15a0d1d..07c9cf3 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -35,6 +35,7 @@ hci_uart-$(CONFIG_BT_HCIUART_ATH3K)	+= hci_ath.o
 hci_uart-$(CONFIG_BT_HCIUART_3WIRE)	+= hci_h5.o
 hci_uart-$(CONFIG_BT_HCIUART_INTEL)	+= hci_intel.o
 hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
+hci_uart-$(CONFIG_BT_HCIUART_QCA)	+= hci_qca.o
 hci_uart-objs				:= $(hci_uart-y)
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 20c2ac1..0d5a05a 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -810,6 +810,9 @@ static int __init hci_uart_init(void)
 #ifdef CONFIG_BT_HCIUART_BCM
 	bcm_init();
 #endif
+#ifdef CONFIG_BT_HCIUART_QCA
+	qca_init();
+#endif
 
 	return 0;
 }
@@ -839,6 +842,9 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_BCM
 	bcm_deinit();
 #endif
+#ifdef CONFIG_BT_HCIUART_QCA
+	qca_deinit();
+#endif
 
 	/* Release tty registration of line discipline */
 	err = tty_unregister_ldisc(N_HCI);
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
new file mode 100644
index 0000000..f4afa4a
--- /dev/null
+++ b/drivers/bluetooth/hci_qca.c
@@ -0,0 +1,1004 @@
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
+#include <linux/debugfs.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "hci_uart.h"
+#include "btqca.h"
+
+/* HCI_IBS protocol messages */
+#define HCI_IBS_SLEEP_IND	0xFE
+#define HCI_IBS_WAKE_IND	0xFD
+#define HCI_IBS_WAKE_ACK	0xFC
+#define HCI_MAX_IBS_SIZE 	10
+
+/* Controller states */
+#define STATE_IN_BAND_SLEEP_ENABLED	1
+
+#define IBS_WAKE_RETRANS_TIMEOUT 	100
+#define IBS_TX_IDLE_TIMEOUT 		2000
+#define BAUDRATE_SETTLE_TIMEOUT		300
+
+/* HCI_IBS transmit side sleep protocol states */
+enum tx_ibs_states_e {
+	HCI_IBS_TX_ASLEEP,
+	HCI_IBS_TX_WAKING,
+	HCI_IBS_TX_AWAKE,
+};
+
+/* HCI_IBS receive side sleep protocol states */
+enum rx_states_e {
+	HCI_IBS_RX_ASLEEP,
+	HCI_IBS_RX_AWAKE,
+};
+
+/* HCI_IBS transmit and receive side clock state vote */
+enum hci_ibs_clock_state_vote_e {
+	HCI_IBS_VOTE_STATS_UPDATE,
+	HCI_IBS_TX_VOTE_CLOCK_ON,
+	HCI_IBS_TX_VOTE_CLOCK_OFF,
+	HCI_IBS_RX_VOTE_CLOCK_ON,
+	HCI_IBS_RX_VOTE_CLOCK_OFF,
+};
+
+static unsigned int wake_retrans;
+static unsigned int tx_idle_delay;
+
+struct qca_data {
+	struct hci_uart *hu;
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+	struct sk_buff_head tx_wait_q;	/* HCI_IBS wait queue	*/
+	spinlock_t hci_ibs_lock;	/* HCI_IBS state lock	*/
+	u8 tx_ibs_state;	/* HCI_IBS transmit side power state*/
+	u8 rx_ibs_state;	/* HCI_IBS receive side power state */
+	bool tx_vote;		/* clock must be on for TX */
+	bool rx_vote;		/* clock must be on for RX */
+	struct timer_list tx_idle_timer;
+	struct timer_list wake_retrans_timer;
+	struct workqueue_struct *workqueue;
+	struct work_struct ws_awake_rx;
+	struct work_struct ws_awake_device;
+	struct work_struct ws_rx_vote_off;
+	struct work_struct ws_tx_vote_off;
+	struct dentry *ibs_dir;
+	unsigned long flags;
+
+	/* debug */
+	u64 ibs_sent_wacks;
+	u64 ibs_sent_slps;
+	u64 ibs_sent_wakes;
+	u64 ibs_recv_wacks;
+	u64 ibs_recv_slps;
+	u64 ibs_recv_wakes;
+	u64 vote_last_jif;
+	u32 vote_on_ms;
+	u32 vote_off_ms;
+	u64 tx_votes_on;
+	u64 rx_votes_on;
+	u64 tx_votes_off;
+	u64 rx_votes_off;
+	u64 votes_on;
+	u64 votes_off;
+};
+
+static void __serial_clock_on(struct tty_struct *tty)
+{
+	/* TODO: Some chipset requires to enable UART clock on client
+	 * side to save power consumption or manual work is required.
+	 * Please put your code to control UART clock here if needed
+	 */
+}
+
+static void __serial_clock_off(struct tty_struct *tty)
+{
+	/* TODO: Some chipset requires to disable UART clock on client
+	 * side to save power consumption or manual work is required.
+	 * Please put your code to control UART clock off here if needed
+	 */
+}
+
+/* clock_vote needs to be called with the ibs lock held */
+static void serial_clock_vote(unsigned long vote, struct hci_uart *hu)
+{
+	struct qca_data *qca = hu->priv;
+	unsigned int diff;
+
+	bool old_vote = (qca->tx_vote | qca->rx_vote);
+	bool new_vote;
+
+	switch (vote) {
+	case HCI_IBS_VOTE_STATS_UPDATE:
+		diff = jiffies_to_msecs(jiffies - qca->vote_last_jif);
+
+		if (old_vote)
+			qca->vote_off_ms += diff;
+		else
+			qca->vote_on_ms += diff;
+		return;
+
+	case HCI_IBS_TX_VOTE_CLOCK_ON:
+		qca->tx_vote = true;
+		qca->tx_votes_on++;
+		new_vote = true;
+		break;
+
+	case HCI_IBS_RX_VOTE_CLOCK_ON:
+		qca->rx_vote = true;
+		qca->rx_votes_on++;
+		new_vote = true;
+		break;
+
+	case HCI_IBS_TX_VOTE_CLOCK_OFF:
+		qca->tx_vote = false;
+		qca->tx_votes_off++;
+		new_vote = qca->rx_vote | qca->tx_vote;
+		break;
+
+	case HCI_IBS_RX_VOTE_CLOCK_OFF:
+		qca->rx_vote = false;
+		qca->rx_votes_off++;
+		new_vote = qca->rx_vote | qca->tx_vote;
+		break;
+
+	default:
+		BT_ERR("voting irregularity");
+		return;
+	}
+
+	if (new_vote != old_vote) {
+		if (new_vote)
+			__serial_clock_on(hu->tty);
+		else
+			__serial_clock_off(hu->tty);
+
+		BT_DBG("HCIUART_IBS: vote serial clock %s(%s)",
+		       new_vote? "true" : "false",
+		       vote? "true" : "false");
+
+		/* debug */
+		diff = jiffies_to_msecs(jiffies - qca->vote_last_jif);
+
+		if (new_vote) {
+			qca->votes_on++;
+			qca->vote_off_ms += diff;
+		} else {
+			qca->votes_off++;
+			qca->vote_on_ms += diff;
+		}
+		qca->vote_last_jif = jiffies;
+	}
+}
+
+/*
+ * Builds and sends an HCI_IBS command packet.
+ * These are very simple packets with only 1 cmd byte
+ */
+static int send_hci_ibs_cmd(u8 cmd, struct hci_uart *hu)
+{
+	int err = 0;
+	struct sk_buff *skb = NULL;
+	struct qca_data *qca = hu->priv;
+
+	BT_DBG("hu %p send hci ibs cmd 0x%x", hu, cmd);
+
+	/* allocate packet */
+	skb = bt_skb_alloc(1, GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("cannot allocate memory for HCI_IBS packet");
+		return -ENOMEM;
+	}
+
+	/* prepare packet */
+	*skb_put(skb, 1) = cmd;
+
+	/* send packet */
+	skb_queue_tail(&qca->txq, skb);
+
+	return err;
+}
+
+static void qca_wq_awake_device(struct work_struct *work)
+{
+	struct qca_data *qca = container_of(work, struct qca_data,
+					    ws_awake_device);
+	struct hci_uart *hu = qca->hu;
+	unsigned long retrans_delay;
+
+	BT_DBG(" %p wq awake device", hu);
+
+	/* Vote for serial clock */
+	serial_clock_vote(HCI_IBS_TX_VOTE_CLOCK_ON, hu);
+
+	spin_lock(&qca->hci_ibs_lock);
+
+	/* send wake indication to device */
+	if (send_hci_ibs_cmd(HCI_IBS_WAKE_IND, hu) < 0)
+		BT_ERR("cannot send WAKE to device");
+
+	qca->ibs_sent_wakes++; /* debug */
+
+	/* start retransmit timer */
+	retrans_delay = msecs_to_jiffies(wake_retrans);
+	mod_timer(&qca->wake_retrans_timer, jiffies + retrans_delay);
+
+	spin_unlock(&qca->hci_ibs_lock);
+
+	/* actually send the packets */
+	hci_uart_tx_wakeup(hu);
+}
+
+static void qca_wq_awake_rx(struct work_struct *work)
+{
+	struct qca_data *qca = container_of(work, struct qca_data,
+					    ws_awake_rx);
+	struct hci_uart *hu = qca->hu;
+
+	BT_DBG(" %p wq awake rx", hu);
+
+	serial_clock_vote(HCI_IBS_RX_VOTE_CLOCK_ON, hu);
+
+	spin_lock(&qca->hci_ibs_lock);
+	qca->rx_ibs_state = HCI_IBS_RX_AWAKE;
+
+	/* Always acknowledge device wake up,
+	 * sending IBS message doesn't count as TX ON
+	 */
+	if (send_hci_ibs_cmd(HCI_IBS_WAKE_ACK, hu) < 0)
+		BT_ERR("cannot acknowledge device wake up");
+
+	qca->ibs_sent_wacks++; /* debug */
+
+	spin_unlock(&qca->hci_ibs_lock);
+
+	/* actually send the packets */
+	hci_uart_tx_wakeup(hu);
+}
+
+static void qca_wq_serial_rx_clock_vote_off(struct work_struct *work)
+{
+	struct qca_data *qca = container_of(work, struct qca_data,
+					    ws_rx_vote_off);
+	struct hci_uart *hu = qca->hu;
+
+	BT_DBG("hu %p rx clock vote off", hu);
+
+	serial_clock_vote(HCI_IBS_RX_VOTE_CLOCK_OFF, hu);
+}
+
+static void qca_wq_serial_tx_clock_vote_off(struct work_struct *work)
+{
+	struct qca_data *qca = container_of(work, struct qca_data,
+					    ws_tx_vote_off);
+	struct hci_uart *hu = qca->hu;
+
+	BT_DBG("hu %p tx clock vote off", hu);
+
+	hci_uart_tx_wakeup(hu);  /* run HCI tx handling unlocked */
+
+	/* now that message queued to tty driver, vote for tty clocks off
+	 * It is up to the tty driver to pend the clocks off until tx done.
+	 */
+	serial_clock_vote(HCI_IBS_TX_VOTE_CLOCK_OFF, hu);
+}
+
+static void hci_ibs_tx_idle_timeout(unsigned long arg)
+{
+	struct hci_uart *hu = (struct hci_uart *)arg;
+	struct qca_data *qca = hu->priv;
+	unsigned long flags;
+
+	BT_DBG("hu %p idle timeout in %hhu state", hu, qca->tx_ibs_state);
+
+	spin_lock_irqsave_nested(&qca->hci_ibs_lock,
+				 flags, SINGLE_DEPTH_NESTING);
+
+	switch (qca->tx_ibs_state) {
+	case HCI_IBS_TX_AWAKE: /* TX_IDLE, go to SLEEP */
+		if (send_hci_ibs_cmd(HCI_IBS_SLEEP_IND, hu) < 0) {
+			BT_ERR("cannot send SLEEP to device");
+			break;
+		}
+		qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
+		qca->ibs_sent_slps++; /* debug */
+		queue_work(qca->workqueue, &qca->ws_tx_vote_off);
+		break;
+
+	case HCI_IBS_TX_ASLEEP:
+	case HCI_IBS_TX_WAKING:
+	default:
+		BT_ERR("spurious timeout in tx state %hhu", qca->tx_ibs_state);
+		break;
+	}
+
+	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+}
+
+static void hci_ibs_wake_retrans_timeout(unsigned long arg)
+{
+	struct hci_uart *hu = (struct hci_uart *)arg;
+	struct qca_data *qca = hu->priv;
+	unsigned long flags, retrans_delay;
+	unsigned long retransmit = 0;
+
+	BT_DBG("hu %p wake retransmit timeout in %hhu state",
+		hu, qca->tx_ibs_state);
+
+	spin_lock_irqsave_nested(&qca->hci_ibs_lock,
+				 flags, SINGLE_DEPTH_NESTING);
+
+	switch (qca->tx_ibs_state) {
+	case HCI_IBS_TX_WAKING: /* No WAKE_ACK, retransmit WAKE */
+		retransmit = 1;
+		if (send_hci_ibs_cmd(HCI_IBS_WAKE_IND, hu) < 0) {
+			BT_ERR("cannot acknowledge device wake up");
+			break;
+		}
+		qca->ibs_sent_wakes++; /* debug */
+		retrans_delay = msecs_to_jiffies(wake_retrans);
+		mod_timer(&qca->wake_retrans_timer, jiffies + retrans_delay);
+		break;
+
+	case HCI_IBS_TX_ASLEEP:
+	case HCI_IBS_TX_AWAKE:
+	default:
+		BT_ERR("spurrious timeout tx state %hhu", qca->tx_ibs_state);
+		break;
+	}
+
+	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+
+	if (retransmit)
+		hci_uart_tx_wakeup(hu);
+}
+
+/* Initialize protocol */
+static int qca_open(struct hci_uart *hu)
+{
+	struct qca_data *qca;
+
+	BT_DBG("hu %p qca_open", hu);
+
+	qca = kzalloc(sizeof(struct qca_data), GFP_ATOMIC);
+	if (!qca)
+		return -ENOMEM;
+
+	skb_queue_head_init(&qca->txq);
+	skb_queue_head_init(&qca->tx_wait_q);
+	spin_lock_init(&qca->hci_ibs_lock);
+	qca->workqueue = create_singlethread_workqueue("qca_wq");
+	if (!qca->workqueue) {
+		BT_ERR("QCA Workqueue not initialized properly");
+		kfree(qca);
+		return -ENOMEM;
+	}
+
+	INIT_WORK(&qca->ws_awake_rx, qca_wq_awake_rx);
+	INIT_WORK(&qca->ws_awake_device, qca_wq_awake_device);
+	INIT_WORK(&qca->ws_rx_vote_off, qca_wq_serial_rx_clock_vote_off);
+	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
+
+	qca->hu = hu;
+
+	/* Assume we start with both sides asleep -- extra wakes OK */
+	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
+	qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
+	/* clocks actually on, but we start votes off */
+	qca->tx_vote = false;
+	qca->rx_vote = false;
+	qca->flags = 0;
+
+	/* debug */
+	qca->ibs_sent_wacks = 0;
+	qca->ibs_sent_slps = 0;
+	qca->ibs_sent_wakes = 0;
+	qca->ibs_recv_wacks = 0;
+	qca->ibs_recv_slps = 0;
+	qca->ibs_recv_wakes = 0;
+	qca->vote_last_jif = jiffies;
+	qca->vote_on_ms = 0;
+	qca->vote_off_ms = 0;
+	qca->votes_on = 0;
+	qca->votes_off = 0;
+	qca->tx_votes_on = 0;
+	qca->tx_votes_off = 0;
+	qca->rx_votes_on = 0;
+	qca->rx_votes_off = 0;
+
+	hu->priv = qca;
+
+	init_timer(&qca->wake_retrans_timer);
+	qca->wake_retrans_timer.function = hci_ibs_wake_retrans_timeout;
+	qca->wake_retrans_timer.data = (u_long)hu;
+	wake_retrans = IBS_WAKE_RETRANS_TIMEOUT;
+
+	init_timer(&qca->tx_idle_timer);
+	qca->tx_idle_timer.function = hci_ibs_tx_idle_timeout;
+	qca->tx_idle_timer.data = (u_long)hu;
+	tx_idle_delay = IBS_TX_IDLE_TIMEOUT;
+
+	BT_INFO("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
+		tx_idle_delay, wake_retrans);
+
+	return 0;
+}
+
+static void qca_debugfs_init(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+	umode_t mode;
+
+	if (!hdev->debugfs)
+		return;
+
+	qca->ibs_dir = debugfs_create_dir("ibs", hdev->debugfs);
+
+	/* read only */
+	mode = S_IRUGO;
+	debugfs_create_u8("tx_ibs_state", mode, qca->ibs_dir,
+			  &qca->tx_ibs_state);
+	debugfs_create_u8("rx_ibs_state", mode, qca->ibs_dir,
+			  &qca->rx_ibs_state);
+	debugfs_create_u64("ibs_sent_sleeps", mode, qca->ibs_dir,
+			   &qca->ibs_sent_slps);
+	debugfs_create_u64("ibs_sent_wakes", mode, qca->ibs_dir,
+			   &qca->ibs_sent_wakes);
+	debugfs_create_u64("ibs_sent_wake_acks", mode, qca->ibs_dir,
+			   &qca->ibs_sent_wacks);
+	debugfs_create_u64("ibs_recv_sleeps", mode, qca->ibs_dir,
+			   &qca->ibs_recv_slps);
+	debugfs_create_u64("ibs_recv_wakes", mode, qca->ibs_dir,
+			   &qca->ibs_recv_wakes);
+	debugfs_create_u64("ibs_recv_wake_acks", mode, qca->ibs_dir,
+			   &qca->ibs_recv_wacks);
+	debugfs_create_bool("tx_vote", mode, qca->ibs_dir,
+			    (u32 *)&qca->tx_vote);
+	debugfs_create_u64("tx_votes_on", mode, qca->ibs_dir,
+			   &qca->tx_votes_on);
+	debugfs_create_u64("tx_votes_off", mode, qca->ibs_dir,
+			   &qca->tx_votes_off);
+	debugfs_create_bool("rx_vote", mode, qca->ibs_dir,
+			    (u32 *)&qca->rx_vote);
+	debugfs_create_u64("rx_votes_on", mode, qca->ibs_dir,
+			   &qca->rx_votes_on);
+	debugfs_create_u64("rx_votes_off", mode, qca->ibs_dir,
+			   &qca->rx_votes_off);
+	debugfs_create_u64("votes_on", mode, qca->ibs_dir, &qca->votes_on);
+	debugfs_create_u64("votes_off", mode, qca->ibs_dir, &qca->votes_off);
+	debugfs_create_u32("vote_on_ms", mode, qca->ibs_dir,
+			   &qca->vote_on_ms);
+	debugfs_create_u32("vote_off_ms", mode, qca->ibs_dir,
+			   &qca->vote_off_ms);
+}
+
+/* Flush protocol data */
+static int qca_flush(struct hci_uart *hu)
+{
+	struct qca_data *qca = hu->priv;
+
+	BT_DBG("hu %p qca flush", hu);
+
+	skb_queue_purge(&qca->tx_wait_q);
+	skb_queue_purge(&qca->txq);
+
+	return 0;
+}
+
+/* Close protocol */
+static int qca_close(struct hci_uart *hu)
+{
+	struct qca_data *qca = hu->priv;
+
+	BT_DBG("hu %p qca close", hu);
+
+	serial_clock_vote(HCI_IBS_VOTE_STATS_UPDATE, hu);
+
+	skb_queue_purge(&qca->tx_wait_q);
+	skb_queue_purge(&qca->txq);
+	del_timer(&qca->tx_idle_timer);
+	del_timer(&qca->wake_retrans_timer);
+	destroy_workqueue(qca->workqueue);
+	qca->hu = NULL;
+
+	kfree_skb(qca->rx_skb);
+
+	hu->priv = NULL;
+
+	kfree(qca);
+
+	return 0;
+}
+
+/*
+ * Called upon a wake-up-indication from the device
+ */
+static void device_want_to_wakeup(struct hci_uart *hu)
+{
+	unsigned long flags;
+	struct qca_data *qca = hu->priv;
+
+	BT_DBG("hu %p want to wake up", hu);
+
+	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
+
+	/* debug */
+	qca->ibs_recv_wakes++;
+
+	switch (qca->rx_ibs_state) {
+	case HCI_IBS_RX_ASLEEP:
+		/* Make sure clock is on - we may have turned clock off since
+		 * receiving the wake up indicator
+		 * awake rx clock
+		 */
+		queue_work(qca->workqueue, &qca->ws_awake_rx);
+		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+		return;
+
+	case HCI_IBS_RX_AWAKE:
+		/* Always acknowledge device wake up,
+		 * sending IBS message doesn't count as TX ON.
+		 */
+		if (send_hci_ibs_cmd(HCI_IBS_WAKE_ACK, hu) < 0) {
+			BT_ERR("cannot acknowledge device wake up");
+			break;
+		}
+		qca->ibs_sent_wacks++; /* debug */
+		break;
+
+	default:
+		/* any other state is illegal */
+		BT_ERR("received HCI_IBS_WAKE_IND in rx state %hhu",
+		       qca->rx_ibs_state);
+		break;
+	}
+
+	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+
+	/* actually send the packets */
+	hci_uart_tx_wakeup(hu);
+}
+
+/*
+ * Called upon a sleep-indication from the device
+ */
+static void device_want_to_sleep(struct hci_uart *hu)
+{
+	unsigned long flags;
+	struct qca_data *qca = hu->priv;
+
+	BT_DBG("hu %p want to sleep", hu);
+
+	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
+
+	/* debug */
+	qca->ibs_recv_slps++;
+
+	switch (qca->rx_ibs_state) {
+	case HCI_IBS_RX_AWAKE:
+		/* update state */
+		qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
+		/* vote off rx clock under workqueue */
+		queue_work(qca->workqueue, &qca->ws_rx_vote_off);
+		break;
+
+	case HCI_IBS_RX_ASLEEP:
+		/* deliberate fall-through */
+	default:
+		/* any other state is illegal */
+		BT_ERR("received HCI_IBS_SLEEP_IND in rx state %hhu",
+		       qca->rx_ibs_state);
+		break;
+	}
+
+	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+}
+
+/*
+ * Called upon wake-up-acknowledgement from the device
+ */
+static void device_woke_up(struct hci_uart *hu)
+{
+	unsigned long flags, idle_delay;
+	struct qca_data *qca = hu->priv;
+	struct sk_buff *skb = NULL;
+
+	BT_DBG("hu %p woke up", hu);
+
+	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
+
+	/* debug */
+	qca->ibs_recv_wacks++;
+
+	switch (qca->tx_ibs_state) {
+	case HCI_IBS_TX_AWAKE:
+		/* expect one if we send 2 WAKEs */
+		BT_DBG("received HCI_IBS_WAKE_ACK in tx state %hhu",
+		       qca->tx_ibs_state);
+		break;
+
+	case HCI_IBS_TX_WAKING:
+		/* send pending packets */
+		while ((skb = skb_dequeue(&qca->tx_wait_q)))
+			skb_queue_tail(&qca->txq, skb);
+
+		/* switch timers and change state to HCI_IBS_TX_AWAKE */
+		del_timer(&qca->wake_retrans_timer);
+		idle_delay = msecs_to_jiffies(tx_idle_delay);
+		mod_timer(&qca->tx_idle_timer, jiffies + idle_delay);
+		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
+		break;
+
+	case HCI_IBS_TX_ASLEEP:
+		/* This could be spurrious rx wake on the BT chip.
+		 * Send it another SLEEP othwise it will stay awake. */
+	default:
+		BT_ERR("received HCI_IBS_WAKE_ACK in tx state %hhu",
+		       qca->tx_ibs_state);
+		break;
+	}
+
+	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+
+	/* actually send the packets */
+	hci_uart_tx_wakeup(hu);
+}
+
+/* Enqueue frame for transmittion (padding, crc, etc) */
+/* may be called from two simultaneous tasklets */
+static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	unsigned long flags = 0, idle_delay;
+	struct qca_data *qca = hu->priv;
+
+	BT_DBG("hu %p qca enq skb %p tx_ibs_state %hhu", hu, skb,
+	       qca->tx_ibs_state);
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+
+	/* don't go to sleep in middle of patch download or
+	 * Out-Of-Band(GPIOs control) sleep is selected
+	 */
+	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
+		skb_queue_tail(&qca->txq, skb);
+		return 0;
+	}
+
+	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
+
+	/* act according to current state */
+	switch (qca->tx_ibs_state) {
+	case HCI_IBS_TX_AWAKE:
+		BT_DBG("device awake, sending normally");
+		skb_queue_tail(&qca->txq, skb);
+		idle_delay = msecs_to_jiffies(tx_idle_delay);
+		mod_timer(&qca->tx_idle_timer, jiffies + idle_delay);
+		break;
+
+	case HCI_IBS_TX_ASLEEP:
+		BT_DBG("device asleep, waking up and queueing packet");
+		/* save packet for later */
+		skb_queue_tail(&qca->tx_wait_q, skb);
+
+		qca->tx_ibs_state = HCI_IBS_TX_WAKING;
+		/* schedule a work queue to wake up device */
+		queue_work(qca->workqueue, &qca->ws_awake_device);
+		break;
+
+	case HCI_IBS_TX_WAKING:
+		BT_DBG("device waking up, queueing packet");
+		/* transient state; just keep packet for later */
+		skb_queue_tail(&qca->tx_wait_q, skb);
+		break;
+
+	default:
+		BT_ERR("illegal tx state: %hhu (losing packet)",
+		       qca->tx_ibs_state);
+		kfree_skb(skb);
+		break;
+	}
+
+	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+
+	return 0;
+}
+
+#define QCA_IBS_SLEEP_IND_EVENT \
+	.type = HCI_IBS_SLEEP_IND, \
+	.hlen = 0, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = HCI_MAX_IBS_SIZE
+
+#define QCA_IBS_WAKE_IND_EVENT \
+	.type = HCI_IBS_WAKE_IND, \
+	.hlen = 0, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = HCI_MAX_IBS_SIZE
+
+#define QCA_IBS_WAKE_ACK_EVENT \
+	.type = HCI_IBS_WAKE_ACK, \
+	.hlen = 0, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = HCI_MAX_IBS_SIZE
+
+static int qca_ibs_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	u8 pkt_type;
+
+	pkt_type = bt_cb(skb)->pkt_type;
+
+	switch (pkt_type) {
+	case HCI_IBS_SLEEP_IND:
+		BT_DBG("HCI_IBS_SLEEP_IND packet");
+		device_want_to_sleep(hu);
+		break;
+
+	case HCI_IBS_WAKE_IND:
+		BT_DBG("HCI_IBS_WAKE_IND packet");
+		device_want_to_wakeup(hu);
+		break;
+
+	case HCI_IBS_WAKE_ACK:
+		BT_DBG("HCI_IBS_WAKE_ACK packet");
+		device_woke_up(hu);
+		break;
+
+	default:
+		BT_ERR("Unknown HCI packet type %2.2x", (__u8)*skb->data);
+		hdev->stat.err_rx++;
+		break;
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static const struct h4_recv_pkt qca_recv_pkts[] = {
+	{ H4_RECV_ACL,   	   .recv = hci_recv_frame },
+	{ H4_RECV_SCO,   	   .recv = hci_recv_frame },
+	{ H4_RECV_EVENT, 	   .recv = hci_recv_frame },
+	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_recv_frame },
+	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_recv_frame },
+	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_recv_frame },
+};
+
+static int qca_recv(struct hci_uart *hu, const void *data, int count)
+{
+	struct qca_data *qca = hu->priv;
+
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
+	qca->rx_skb = h4_recv_buf(hu->hdev, qca->rx_skb, data, count,
+				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
+	if (IS_ERR(qca->rx_skb)) {
+		int err = PTR_ERR(qca->rx_skb);
+		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
+		qca->rx_skb = NULL;
+		return err;
+	}
+
+	return count;
+}
+
+static struct sk_buff *qca_dequeue(struct hci_uart *hu)
+{
+	struct qca_data *qca = hu->priv;
+
+	return skb_dequeue(&qca->txq);
+}
+
+static uint8_t qca_get_baudrate_value(int speed)
+{
+	switch(speed) {
+	case 9600:
+		return QCA_BAUDRATE_9600;
+	case 19200:
+		return QCA_BAUDRATE_19200;
+	case 38400:
+		return QCA_BAUDRATE_38400;
+	case 57600:
+		return QCA_BAUDRATE_57600;
+	case 115200:
+		return QCA_BAUDRATE_115200;
+	case 230400:
+		return QCA_BAUDRATE_230400;
+	case 460800:
+		return QCA_BAUDRATE_460800;
+	case 500000:
+		return QCA_BAUDRATE_500000;
+	case 921600:
+		return QCA_BAUDRATE_921600;
+	case 1000000:
+		return QCA_BAUDRATE_1000000;
+	case 2000000:
+		return QCA_BAUDRATE_2000000;
+	case 3000000:
+		return QCA_BAUDRATE_3000000;
+	case 3500000:
+		return QCA_BAUDRATE_3500000;
+	default:
+		return QCA_BAUDRATE_115200;
+	}
+}
+
+static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+	struct sk_buff *skb;
+	u8 cmd[] = {0x01, 0x48, 0xFC, 0x01, 0x00};
+
+	if (baudrate > QCA_BAUDRATE_3000000)
+		return -EINVAL;
+
+	cmd[4] = baudrate;
+
+	/* allocate packet */
+	skb = bt_skb_alloc(sizeof(cmd), GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("cannot allocate memory for baudrate packet");
+		return -ENOMEM;
+	}
+
+	/* prepare packet */
+	memcpy(skb_put(skb, sizeof(cmd)), cmd, sizeof(cmd));
+	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+
+	/* send packet */
+	skb_queue_tail(&qca->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	/* wait 300ms to change new baudrate on controller side
+	 * controller will come back after they receive this HCI command
+	 * then host can communicate with new baudrate to controller
+	 */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT));
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	return 0;
+}
+
+static int qca_setup(struct hci_uart *hu)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct qca_data *qca = hu->priv;
+	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
+	int ret;
+
+	BT_INFO("%s: ROME setup", hdev->name);
+
+	/* Patch downloading has to be done without IBS mode */
+	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+
+	/* setup initial baudrate */
+	speed = 0;
+	if (hu->init_speed)
+		speed = hu->init_speed;
+	else if (hu->proto->init_speed)
+		speed = hu->proto->init_speed;
+
+	if (speed)
+		hci_uart_set_baudrate(hu, speed);
+
+	/* setup user speed if needed */
+	speed = 0;
+	if (hu->oper_speed)
+		speed = hu->oper_speed;
+	else if (hu->proto->oper_speed)
+		speed = hu->proto->oper_speed;
+
+	if (speed) {
+		qca_baudrate = qca_get_baudrate_value(speed);
+
+		BT_INFO("%s: Set UART speed to %d", hdev->name, speed);
+		ret = qca_set_baudrate(hdev, qca_baudrate);
+		if (ret) {
+			BT_ERR("%s: can't change the baud rate (%d)",
+			       hdev->name, ret);
+			return ret;
+		}
+		hci_uart_set_baudrate(hu, speed);
+	}
+
+	/* setup patch / nvm configurations */
+	ret = rome_uart_setup(hdev, qca_baudrate);
+#ifdef QCA_FEATURE_UART_IN_BAND_SLEEP
+	if (!ret) {
+		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+#ifdef CONFIG_DEBUG_FS
+		qca_debugfs_init(hdev);
+#endif
+	}
+#endif
+	/* setup bdaddr */
+	hu->hdev->set_bdaddr = rome_set_bdaddr;
+
+	return ret;
+}
+
+static struct hci_uart_proto qca_p = {
+	.id		= HCI_UART_QCA,
+	.name		= "QCA",
+	.open		= qca_open,
+	.init_speed	= 115200,
+	.oper_speed	= 3000000,
+	.close		= qca_close,
+	.recv		= qca_recv,
+	.enqueue	= qca_enqueue,
+	.dequeue	= qca_dequeue,
+	.flush		= qca_flush,
+	.setup		= qca_setup,
+};
+
+int __init qca_init(void)
+{
+	return hci_uart_register_proto(&qca_p);
+}
+
+int __exit qca_deinit(void)
+{
+	return hci_uart_unregister_proto(&qca_p);
+}
+
+module_param(wake_retrans, uint, 0644);
+MODULE_PARM_DESC(wake_retrans, "Delay ms to retransmit WAKE_IND");
+
+module_param(tx_idle_delay, uint, 0644);
+MODULE_PARM_DESC(tx_idle_delay, "Delay ms since last tx for SLEEP_IND");
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 496587a..495b9ef 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,7 +35,7 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	8
+#define HCI_UART_MAX_PROTO	9
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
@@ -45,6 +45,7 @@
 #define HCI_UART_ATH3K	5
 #define HCI_UART_INTEL	6
 #define HCI_UART_BCM	7
+#define HCI_UART_QCA	8
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
@@ -176,3 +177,8 @@ int intel_deinit(void);
 int bcm_init(void);
 int bcm_deinit(void);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_QCA
+int qca_init(void);
+int qca_deinit(void);
+#endif
-- 
2.0.5


