Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 1/2] Bluetooth: Add __init and __exit marks to UART drivers
Date: Sat, 24 Jul 2010 02:04:44 -0300
Message-Id: <1279947885-19304-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Those marks are useful to save space in the binary and in the memory.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 drivers/bluetooth/hci_ath.c  |    4 ++--
 drivers/bluetooth/hci_bcsp.c |    4 ++--
 drivers/bluetooth/hci_h4.c   |    4 ++--
 drivers/bluetooth/hci_ll.c   |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 5ab258b..b941dd5 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -217,7 +217,7 @@ static struct hci_uart_proto athp = {
 	.flush = ath_flush,
 };
 
-int ath_init(void)
+int __init ath_init(void)
 {
 	int err = hci_uart_register_proto(&athp);
 
@@ -229,7 +229,7 @@ int ath_init(void)
 	return err;
 }
 
-int ath_deinit(void)
+int __exit ath_deinit(void)
 {
 	return hci_uart_unregister_proto(&athp);
 }
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 42d69d4..9c5b2dc 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -739,7 +739,7 @@ static struct hci_uart_proto bcsp = {
 	.flush		= bcsp_flush
 };
 
-int bcsp_init(void)
+int __init bcsp_init(void)
 {
 	int err = hci_uart_register_proto(&bcsp);
 
@@ -751,7 +751,7 @@ int bcsp_init(void)
 	return err;
 }
 
-int bcsp_deinit(void)
+int __exit bcsp_deinit(void)
 {
 	return hci_uart_unregister_proto(&bcsp);
 }
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index b2cf50e..7b8ad93 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -173,7 +173,7 @@ static struct hci_uart_proto h4p = {
 	.flush		= h4_flush,
 };
 
-int h4_init(void)
+int __init h4_init(void)
 {
 	int err = hci_uart_register_proto(&h4p);
 
@@ -185,7 +185,7 @@ int h4_init(void)
 	return err;
 }
 
-int h4_deinit(void)
+int __exit h4_deinit(void)
 {
 	return hci_uart_unregister_proto(&h4p);
 }
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 5744aba..38595e7 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -517,7 +517,7 @@ static struct hci_uart_proto llp = {
 	.flush		= ll_flush,
 };
 
-int ll_init(void)
+int __init ll_init(void)
 {
 	int err = hci_uart_register_proto(&llp);
 
@@ -529,7 +529,7 @@ int ll_init(void)
 	return err;
 }
 
-int ll_deinit(void)
+int __exit ll_deinit(void)
 {
 	return hci_uart_unregister_proto(&llp);
 }
-- 
1.7.1.1
