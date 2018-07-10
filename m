Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v3 7/9] Bluetooth: hci_h5: Add vendor setup, open, and close callbacks
Date: Tue, 10 Jul 2018 10:11:15 +0200
Message-Id: <20180710081117.25078-8-hdegoede@redhat.com>
In-Reply-To: <20180710081117.25078-1-hdegoede@redhat.com>
References: <20180710081117.25078-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jeremy Cline <jeremy@jcline.org>

Allow vendor-specific setup, open, and close functions to be defined.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
[hdegoede@redhat.com: Port from bt3wire.c to hci_h5.c, drop dt support]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 39 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 672f63623bf7..0cf4f1e9df0c 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -21,8 +21,9 @@
  *
  */
 
-#include <linux/kernel.h>
+#include <linux/acpi.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
 
@@ -99,6 +100,15 @@ struct h5 {
 		H5_SLEEPING,
 		H5_WAKING_UP,
 	} sleep;
+
+	const struct h5_vnd *vnd;
+	const char *id;
+};
+
+struct h5_vnd {
+	int (*setup)(struct h5 *h5);
+	void (*open)(struct h5 *h5);
+	void (*close)(struct h5 *h5);
 };
 
 static void h5_reset_rx(struct h5 *h5);
@@ -218,6 +228,9 @@ static int h5_open(struct hci_uart *hu)
 
 	h5->tx_win = H5_TX_WIN_MAX;
 
+	if (h5->vnd && h5->vnd->open)
+		h5->vnd->open(h5);
+
 	set_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags);
 
 	/* Send initial sync request */
@@ -237,12 +250,25 @@ static int h5_close(struct hci_uart *hu)
 	skb_queue_purge(&h5->rel);
 	skb_queue_purge(&h5->unrel);
 
+	if (h5->vnd && h5->vnd->close)
+		h5->vnd->close(h5);
+
 	if (!hu->serdev)
 		kfree(h5);
 
 	return 0;
 }
 
+static int h5_setup(struct hci_uart *hu)
+{
+	struct h5 *h5 = hu->priv;
+
+	if (h5->vnd && h5->vnd->setup)
+		return h5->vnd->setup(h5);
+
+	return 0;
+}
+
 static void h5_pkt_cull(struct h5 *h5)
 {
 	struct sk_buff *skb, *tmp;
@@ -753,6 +779,7 @@ static const struct hci_uart_proto h5p = {
 	.name		= "Three-wire (H5)",
 	.open		= h5_open,
 	.close		= h5_close,
+	.setup		= h5_setup,
 	.recv		= h5_recv,
 	.enqueue	= h5_enqueue,
 	.dequeue	= h5_dequeue,
@@ -761,6 +788,7 @@ static const struct hci_uart_proto h5p = {
 
 static int h5_serdev_probe(struct serdev_device *serdev)
 {
+	const struct acpi_device_id *match;
 	struct device *dev = &serdev->dev;
 	struct h5 *h5;
 
@@ -774,6 +802,15 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	h5->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, h5);
 
+	if (has_acpi_companion(dev)) {
+		match = acpi_match_device(dev->driver->acpi_match_table, dev);
+		if (!match)
+			return -ENODEV;
+
+		h5->vnd = (const struct h5_vnd *)match->driver_data;
+		h5->id  = (char *)match->id;
+	}
+
 	return hci_uart_register_device(&h5->serdev_hu, &h5p);
 }
 
-- 
2.17.1
