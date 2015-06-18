Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Fix speed selection
Date: Thu, 18 Jun 2015 12:43:27 +0200
Message-Id: <1434624207-393-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hu->proto->*speed will always be used for all device where it is set.
But hu->*speed should be used if exist, so the test should be swapped.

The equivalent change is needed in bcm_setup() of hci_bcm.c.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c   | 29 +++++++++++++++++++++++------
 drivers/bluetooth/hci_ldisc.c | 12 ++++++------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index aa3c9ac..23523e1 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -131,6 +131,7 @@ static int bcm_setup(struct hci_uart *hu)
 {
 	char fw_name[64];
 	const struct firmware *fw;
+	unsigned int speed;
 	int err;
 
 	BT_DBG("hu %p", hu);
@@ -153,13 +154,29 @@ static int bcm_setup(struct hci_uart *hu)
 		goto finalize;
 	}
 
-	if (hu->proto->init_speed)
-		hci_uart_set_baudrate(hu, hu->proto->init_speed);
-
-	if (hu->proto->oper_speed) {
-		err = bcm_set_baudrate(hu, hu->proto->oper_speed);
+	/* Init speed if any */
+	if (hu->init_speed)
+		speed = hu->init_speed;
+	else if (hu->proto->init_speed)
+		speed = hu->proto->init_speed;
+	else
+		speed = 0;
+
+	if (speed)
+		hci_uart_set_baudrate(hu, speed);
+
+	/* Operational speed if any */
+	if (hu->oper_speed)
+		speed = hu->oper_speed;
+	else if (hu->proto->oper_speed)
+		speed = hu->proto->oper_speed;
+	else
+		speed = 0;
+
+	if (speed) {
+		err = bcm_set_baudrate(hu, speed);
 		if (!err)
-			hci_uart_set_baudrate(hu, hu->proto->oper_speed);
+			hci_uart_set_baudrate(hu, speed);
 	}
 
 finalize:
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 590bd8e..177dd69 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -370,10 +370,10 @@ static int hci_uart_setup(struct hci_dev *hdev)
 	int err;
 
 	/* Init speed if any */
-	if (hu->proto->init_speed)
-		speed = hu->proto->init_speed;
-	else if (hu->init_speed)
+	if (hu->init_speed)
 		speed = hu->init_speed;
+	else if (hu->proto->init_speed)
+		speed = hu->proto->init_speed;
 	else
 		speed = 0;
 
@@ -381,10 +381,10 @@ static int hci_uart_setup(struct hci_dev *hdev)
 		hci_uart_set_baudrate(hu, speed);
 
 	/* Operational speed if any */
-	if (hu->proto->oper_speed)
-		speed = hu->proto->oper_speed;
-	else if (hu->oper_speed)
+	if (hu->oper_speed)
 		speed = hu->oper_speed;
+	else if (hu->proto->oper_speed)
+		speed = hu->proto->oper_speed;
 	else
 		speed = 0;
 
-- 
1.9.1

