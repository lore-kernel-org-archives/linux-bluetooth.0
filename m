Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 19 Oct 2007 03:31:32 -0400
From: Jeff Garzik <jeff@garzik.org>
To: marcel@holtmann.org, maxk@qualcomm.com, bluez-devel@lists.sf.net
Message-ID: <20071019073132.GA5678@havoc.gtf.org>
MIME-Version: 1.0
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [Bluez-devel] [PATCH] bluetooth: Eliminate checks for impossible
	conditions in	irq handler
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


commit 1c8073a42f133bf5780099c1e6efd9e48468cd29
Author: Jeff Garzik <jeff@garzik.org>
Date:   Fri Oct 19 03:07:30 2007 -0400

    [BLUETOOTH] Eliminate checks for impossible conditions in irq handler
    
    Our info structure and info->hdev is always passed to the irq handler,
    so we don't have to worry about these checks in every interrupt.
    
    Leave a BUG_ON() just to help unwary programmers, but these could
    probably be removed as well.
    
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

 drivers/bluetooth/bluecard_cs.c |    5 +----
 drivers/bluetooth/bt3c_cs.c     |    5 +----
 drivers/bluetooth/btuart_cs.c   |    5 +----
 drivers/bluetooth/dtl1_cs.c     |    5 +----
 4 files changed, 4 insertions(+), 16 deletions(-)

1c8073a42f133bf5780099c1e6efd9e48468cd29
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 851de4d..bcf5792 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -503,10 +503,7 @@ static irqreturn_t bluecard_interrupt(int irq, void *dev_inst)
 	unsigned int iobase;
 	unsigned char reg;
 
-	if (!info || !info->hdev) {
-		BT_ERR("Call of irq %d for unknown device", irq);
-		return IRQ_NONE;
-	}
+	BUG_ON(!info->hdev);
 
 	if (!test_bit(CARD_READY, &(info->hw_state)))
 		return IRQ_HANDLED;
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 3951607..a18f9b8 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -344,10 +344,7 @@ static irqreturn_t bt3c_interrupt(int irq, void *dev_inst)
 	unsigned int iobase;
 	int iir;
 
-	if (!info || !info->hdev) {
-		BT_ERR("Call of irq %d for unknown device", irq);
-		return IRQ_NONE;
-	}
+	BUG_ON(!info->hdev);
 
 	iobase = info->p_dev->io.BasePort1;
 
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index d7d2ea0..08f48d5 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -294,10 +294,7 @@ static irqreturn_t btuart_interrupt(int irq, void *dev_inst)
 	int boguscount = 0;
 	int iir, lsr;
 
-	if (!info || !info->hdev) {
-		BT_ERR("Call of irq %d for unknown device", irq);
-		return IRQ_NONE;
-	}
+	BUG_ON(!info->hdev);
 
 	iobase = info->p_dev->io.BasePort1;
 
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 7f9c54b..dae45cd 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -298,10 +298,7 @@ static irqreturn_t dtl1_interrupt(int irq, void *dev_inst)
 	int boguscount = 0;
 	int iir, lsr;
 
-	if (!info || !info->hdev) {
-		BT_ERR("Call of irq %d for unknown device", irq);
-		return IRQ_NONE;
-	}
+	BUG_ON(!info->hdev);
 
 	iobase = info->p_dev->io.BasePort1;
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
