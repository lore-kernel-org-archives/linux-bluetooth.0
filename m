Return-Path: <cyrus@holtmann.org>
From: hamzahfrq.sub@gmail.com
To: hamzahfrq.sub@gmail.com
Cc: gregkh@linuxfoundation.org, lee.jones@linaro.org, x0153368@ti.com,
	pavan_savoy@ti.com, gigi.joseph@gmail.com, bvijay@ti.com,
	dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Muhammad Hamza Farooq <mfarooq@visteon.com>
Subject: [PATCH] ti-st: use worker instead of calling st_int_write in wake up
Date: Sun, 20 Sep 2015 21:40:09 +0200
Message-Id: <1442778009-2696-1-git-send-email-mfarooq@visteon.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

The wake up method is called with the port lock held. The st_int_write
method calls port->ops->write with tries to acquire the lock again,
causing CPU to wait infinitely. Right way to do is to write data to port
in worker thread.

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
---
 drivers/misc/ti-st/st_core.c |   18 ++++++++++++++++--
 include/linux/ti_wilink_st.h |    1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index c8c6a36..6e3af8b 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -460,6 +460,13 @@ static void st_int_enqueue(struct st_data_s *st_gdata, struct sk_buff *skb)
  * - TTY layer when write's finished
  * - st_write (in context of the protocol stack)
  */
+static void work_fn_write_wakeup(struct work_struct *work)
+{
+	struct st_data_s *st_gdata = container_of(work, struct st_data_s,
+			work_write_wakeup);
+
+	st_tx_wakeup((void *)st_gdata);
+}
 void st_tx_wakeup(struct st_data_s *st_data)
 {
 	struct sk_buff *skb;
@@ -812,8 +819,12 @@ static void st_tty_wakeup(struct tty_struct *tty)
 	/* don't do an wakeup for now */
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 
-	/* call our internal wakeup */
-	st_tx_wakeup((void *)st_gdata);
+	/*
+	 * schedule the internal wakeup instead of calling directly to
+	 * avoid lockup (port->lock needed in tty->ops->write is
+	 * already taken here
+	 */
+	schedule_work(&st_gdata->work_write_wakeup);
 }
 
 static void st_tty_flush_buffer(struct tty_struct *tty)
@@ -881,6 +892,9 @@ int st_core_init(struct st_data_s **core_data)
 			pr_err("unable to un-register ldisc");
 		return err;
 	}
+
+	INIT_WORK(&st_gdata->work_write_wakeup, work_fn_write_wakeup);
+
 	*core_data = st_gdata;
 	return 0;
 }
diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
index c78dcfe..9b366ee 100644
--- a/include/linux/ti_wilink_st.h
+++ b/include/linux/ti_wilink_st.h
@@ -159,6 +159,7 @@ struct st_data_s {
 	unsigned long ll_state;
 	void *kim_data;
 	struct tty_struct *tty;
+	struct work_struct work_write_wakeup;
 };
 
 /*
-- 
1.7.9.5

