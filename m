Return-Path: <keescook@chromium.org>
Date: Wed, 4 Oct 2017 17:54:29 -0700
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] Bluetooth: Convert timers to use timer_setup()
Message-ID: <20171005005429.GA23965@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. As already done in hci_qca, add
struct hci_uart pointer to priv structure.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This requires commit 686fef928bba ("timer: Prepare to change timer
callback argument type") in v4.14-rc3, but should be otherwise
stand-alone.
---
 drivers/bluetooth/bluecard_cs.c |  7 +++----
 drivers/bluetooth/hci_bcsp.c    | 10 ++++++----
 drivers/bluetooth/hci_h5.c      | 10 ++++++----
 drivers/bluetooth/hci_qca.c     | 17 ++++++++---------
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index b07ca9565291..d513ef4743dc 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -156,9 +156,9 @@ static void bluecard_detach(struct pcmcia_device *p_dev);
 /* ======================== LED handling routines ======================== */
 
 
-static void bluecard_activity_led_timeout(u_long arg)
+static void bluecard_activity_led_timeout(struct timer_list *t)
 {
-	struct bluecard_info *info = (struct bluecard_info *)arg;
+	struct bluecard_info *info = from_timer(info, t, timer);
 	unsigned int iobase = info->p_dev->resource[0]->start;
 
 	if (test_bit(CARD_ACTIVITY, &(info->hw_state))) {
@@ -691,8 +691,7 @@ static int bluecard_open(struct bluecard_info *info)
 
 	spin_lock_init(&(info->lock));
 
-	setup_timer(&(info->timer), &bluecard_activity_led_timeout,
-		    (u_long)info);
+	timer_setup(&info->timer, bluecard_activity_led_timeout, 0);
 
 	skb_queue_head_init(&(info->txq));
 
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index d880f4e33c75..1a7f0c82fb36 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -65,6 +65,7 @@ struct bcsp_struct {
 	u8	rxseq_txack;		/* rxseq == txack. */
 	u8	rxack;			/* Last packet sent by us that the peer ack'ed */
 	struct	timer_list tbcsp;
+	struct	hci_uart *hu;
 
 	enum {
 		BCSP_W4_PKT_DELIMITER,
@@ -697,10 +698,10 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 }
 
 	/* Arrange to retransmit all messages in the relq. */
-static void bcsp_timed_event(unsigned long arg)
+static void bcsp_timed_event(struct timer_list *t)
 {
-	struct hci_uart *hu = (struct hci_uart *)arg;
-	struct bcsp_struct *bcsp = hu->priv;
+	struct bcsp_struct *bcsp = from_timer(bcsp, t, tbcsp);
+	struct hci_uart *hu = bcsp->hu;
 	struct sk_buff *skb;
 	unsigned long flags;
 
@@ -729,11 +730,12 @@ static int bcsp_open(struct hci_uart *hu)
 		return -ENOMEM;
 
 	hu->priv = bcsp;
+	bcsp->hu = hu;
 	skb_queue_head_init(&bcsp->unack);
 	skb_queue_head_init(&bcsp->rel);
 	skb_queue_head_init(&bcsp->unrel);
 
-	setup_timer(&bcsp->tbcsp, bcsp_timed_event, (u_long)hu);
+	timer_setup(&bcsp->tbcsp, bcsp_timed_event, 0);
 
 	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
 
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index c0e4e26dc30d..6a8d0d06aba7 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -78,6 +78,7 @@ struct h5 {
 	int			(*rx_func)(struct hci_uart *hu, u8 c);
 
 	struct timer_list	timer;		/* Retransmission timer */
+	struct hci_uart		*hu;		/* Parent HCI UART */
 
 	u8			tx_seq;		/* Next seq number to send */
 	u8			tx_ack;		/* Next ack number to send */
@@ -120,12 +121,12 @@ static u8 h5_cfg_field(struct h5 *h5)
 	return h5->tx_win & 0x07;
 }
 
-static void h5_timed_event(unsigned long arg)
+static void h5_timed_event(struct timer_list *t)
 {
 	const unsigned char sync_req[] = { 0x01, 0x7e };
 	unsigned char conf_req[3] = { 0x03, 0xfc };
-	struct hci_uart *hu = (struct hci_uart *)arg;
-	struct h5 *h5 = hu->priv;
+	struct h5 *h5 = from_timer(h5, t, timer);
+	struct hci_uart *hu = h5->hu;
 	struct sk_buff *skb;
 	unsigned long flags;
 
@@ -197,6 +198,7 @@ static int h5_open(struct hci_uart *hu)
 		return -ENOMEM;
 
 	hu->priv = h5;
+	h5->hu = hu;
 
 	skb_queue_head_init(&h5->unack);
 	skb_queue_head_init(&h5->rel);
@@ -204,7 +206,7 @@ static int h5_open(struct hci_uart *hu)
 
 	h5_reset_rx(h5);
 
-	setup_timer(&h5->timer, h5_timed_event, (unsigned long)hu);
+	timer_setup(&h5->timer, h5_timed_event, 0);
 
 	h5->tx_win = H5_TX_WIN_MAX;
 
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 392f412b4575..4a949bb60394 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -307,10 +307,10 @@ static void qca_wq_serial_tx_clock_vote_off(struct work_struct *work)
 	serial_clock_vote(HCI_IBS_TX_VOTE_CLOCK_OFF, hu);
 }
 
-static void hci_ibs_tx_idle_timeout(unsigned long arg)
+static void hci_ibs_tx_idle_timeout(struct timer_list *t)
 {
-	struct hci_uart *hu = (struct hci_uart *)arg;
-	struct qca_data *qca = hu->priv;
+	struct qca_data *qca = from_timer(qca, t, tx_idle_timer);
+	struct hci_uart *hu = qca->hu;
 	unsigned long flags;
 
 	BT_DBG("hu %p idle timeout in %d state", hu, qca->tx_ibs_state);
@@ -342,10 +342,10 @@ static void hci_ibs_tx_idle_timeout(unsigned long arg)
 	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
 }
 
-static void hci_ibs_wake_retrans_timeout(unsigned long arg)
+static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
 {
-	struct hci_uart *hu = (struct hci_uart *)arg;
-	struct qca_data *qca = hu->priv;
+	struct qca_data *qca = from_timer(qca, t, wake_retrans_timer);
+	struct hci_uart *hu = qca->hu;
 	unsigned long flags, retrans_delay;
 	bool retransmit = false;
 
@@ -438,11 +438,10 @@ static int qca_open(struct hci_uart *hu)
 
 	hu->priv = qca;
 
-	setup_timer(&qca->wake_retrans_timer, hci_ibs_wake_retrans_timeout,
-		    (u_long)hu);
+	timer_setup(&qca->wake_retrans_timer, hci_ibs_wake_retrans_timeout, 0);
 	qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
 
-	setup_timer(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, (u_long)hu);
+	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
 	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
 
 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
-- 
2.7.4


-- 
Kees Cook
Pixel Security
