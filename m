Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	robh@kernel.org,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 07/13] Bluetooth: hci_uart: Restore hci_dev->flush callback on open()
Date: Sun, 27 May 2018 21:04:51 +0200
Message-Id: <20180527190457.2632-8-hdegoede@redhat.com>
In-Reply-To: <20180527190457.2632-1-hdegoede@redhat.com>
References: <20180527190457.2632-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

For reasons explained in detail in commit 3611f4d2a5e0 ("hci_ldisc:
fix null pointer deref") the hci_uart_close() functions sets
hci_dev->flush to NULL.

But the device may be re-opened after a close, this commit restores the
hci_dev->flush callback on open().

Note this commit also moves the nearly empty defition of hci_uart_open()
a bit down in the file to avoid the need for forward declaring
hci_uart_flush().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_ldisc.c  | 20 +++++++++++---------
 drivers/bluetooth/hci_serdev.c | 19 +++++++++++--------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index b6a71705b7d6..8da0f53b5912 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -229,15 +229,6 @@ int hci_uart_init_ready(struct hci_uart *hu)
 }
 
 /* ------- Interface to HCI layer ------ */
-/* Initialize device */
-static int hci_uart_open(struct hci_dev *hdev)
-{
-	BT_DBG("%s %p", hdev->name, hdev);
-
-	/* Nothing to do for UART driver */
-	return 0;
-}
-
 /* Reset device */
 static int hci_uart_flush(struct hci_dev *hdev)
 {
@@ -264,6 +255,17 @@ static int hci_uart_flush(struct hci_dev *hdev)
 	return 0;
 }
 
+/* Initialize device */
+static int hci_uart_open(struct hci_dev *hdev)
+{
+	BT_DBG("%s %p", hdev->name, hdev);
+
+	/* Undo clearing this from hci_uart_close() */
+	hdev->flush = hci_uart_flush;
+
+	return 0;
+}
+
 /* Close device */
 static int hci_uart_close(struct hci_dev *hdev)
 {
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index e0e6461b9200..da6eb5bcfa6f 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -101,14 +101,6 @@ static void hci_uart_write_work(struct work_struct *work)
 
 /* ------- Interface to HCI layer ------ */
 
-/* Initialize device */
-static int hci_uart_open(struct hci_dev *hdev)
-{
-	BT_DBG("%s %p", hdev->name, hdev);
-
-	return 0;
-}
-
 /* Reset device */
 static int hci_uart_flush(struct hci_dev *hdev)
 {
@@ -129,6 +121,17 @@ static int hci_uart_flush(struct hci_dev *hdev)
 	return 0;
 }
 
+/* Initialize device */
+static int hci_uart_open(struct hci_dev *hdev)
+{
+	BT_DBG("%s %p", hdev->name, hdev);
+
+	/* Undo clearing this from hci_uart_close() */
+	hdev->flush = hci_uart_flush;
+
+	return 0;
+}
+
 /* Close device */
 static int hci_uart_close(struct hci_dev *hdev)
 {
-- 
2.17.0
