Return-Path: <ohad@bencohen.org>
From: Ohad Ben-Cohen <ohad@bencohen.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 2.6.21] Bluetooth: fix potential NULL pointer dereference in hci line discipline
MIME-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sun, 6 May 2007 12:42:17 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705061242.17468.ohad@bencohen.org>
List-ID: <bluez-devel.lists.sourceforge.net>

From: Ohad Ben-Cohen <ohad@bencohen.org>

Normally a serial BT device is opened, TIOSETD'ed to N_HCI line discipline,
HCIUARTSETPROTO'ed and finally closed.
In case the device fails to HCIUARTSETPROTO,
closing it produces a NULL pointer dereference.
This patch fixes this scenario.

Signed-off-by: Ohad Ben-Cohen <ohad@bencohen.org>
---
 drivers/bluetooth/hci_ldisc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 75c1508..4a59a33 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -307,7 +307,8 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 
 	if (hu) {
 		struct hci_dev *hdev = hu->hdev;
-		hci_uart_close(hdev);
+		if(hdev)
+			hci_uart_close(hdev);
 
 		if (test_and_clear_bit(HCI_UART_PROTO_SET, &hu->flags)) {
 			hu->proto->close(hu);
-- 
1.5.0.6
