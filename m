Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_uart: Remove the manual protocol init message
Date: Sat,  4 Apr 2015 22:27:35 -0700
Message-Id: <1428211655-15217-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The init function for each HCI UART protocol prints the same on success
and failure. This information is so generic, remove it and let the main
HCI UART handling print it instead.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ath.c   | 9 +--------
 drivers/bluetooth/hci_bcsp.c  | 9 +--------
 drivers/bluetooth/hci_h4.c    | 9 +--------
 drivers/bluetooth/hci_h5.c    | 9 +--------
 drivers/bluetooth/hci_ldisc.c | 2 ++
 drivers/bluetooth/hci_ll.c    | 9 +--------
 6 files changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 32c46cd40d85..54af95c95b07 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -218,14 +218,7 @@ static const struct hci_uart_proto athp = {
 
 int __init ath_init(void)
 {
-	int err = hci_uart_register_proto(&athp);
-
-	if (!err)
-		BT_INFO("HCIATH3K protocol initialized");
-	else
-		BT_ERR("HCIATH3K protocol registration failed");
-
-	return err;
+	return hci_uart_register_proto(&athp);
 }
 
 int __exit ath_deinit(void)
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 285fd0a97311..a467aa28009a 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -748,14 +748,7 @@ static const struct hci_uart_proto bcsp = {
 
 int __init bcsp_init(void)
 {
-	int err = hci_uart_register_proto(&bcsp);
-
-	if (!err)
-		BT_INFO("HCI BCSP protocol initialized");
-	else
-		BT_ERR("HCI BCSP protocol registration failed");
-
-	return err;
+	return hci_uart_register_proto(&bcsp);
 }
 
 int __exit bcsp_deinit(void)
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 7c5e68cb9959..81ad249fc44f 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -152,14 +152,7 @@ static const struct hci_uart_proto h4p = {
 
 int __init h4_init(void)
 {
-	int err = hci_uart_register_proto(&h4p);
-
-	if (!err)
-		BT_INFO("HCI H4 protocol initialized");
-	else
-		BT_ERR("HCI H4 protocol registration failed");
-
-	return err;
+	return hci_uart_register_proto(&h4p);
 }
 
 int __exit h4_deinit(void)
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index de7da17ccdab..3455cecc9ecf 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -756,14 +756,7 @@ static const struct hci_uart_proto h5p = {
 
 int __init h5_init(void)
 {
-	int err = hci_uart_register_proto(&h5p);
-
-	if (!err)
-		BT_INFO("HCI Three-wire UART (H5) protocol initialized");
-	else
-		BT_ERR("HCI Three-wire UART (H5) protocol init failed");
-
-	return err;
+	return hci_uart_register_proto(&h5p);
 }
 
 int __exit h5_deinit(void)
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index ba3b988ce60a..19d0960489b6 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -60,6 +60,8 @@ int hci_uart_register_proto(const struct hci_uart_proto *p)
 
 	hup[p->id] = p;
 
+	BT_INFO("HCI UART protocol %s registered", p->name);
+
 	return 0;
 }
 
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index c6a1aeb4e7fb..9ee24b075f79 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -518,14 +518,7 @@ static const struct hci_uart_proto llp = {
 
 int __init ll_init(void)
 {
-	int err = hci_uart_register_proto(&llp);
-
-	if (!err)
-		BT_INFO("HCILL protocol initialized");
-	else
-		BT_ERR("HCILL protocol registration failed");
-
-	return err;
+	return hci_uart_register_proto(&llp);
 }
 
 int __exit ll_deinit(void)
-- 
2.1.0

