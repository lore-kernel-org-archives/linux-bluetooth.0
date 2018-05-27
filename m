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
Subject: [PATCH 11/13] Bluetooth: hci_h5: Add vendor setup, open, and close callbacks
Date: Sun, 27 May 2018 21:04:55 +0200
Message-Id: <20180527190457.2632-12-hdegoede@redhat.com>
In-Reply-To: <20180527190457.2632-1-hdegoede@redhat.com>
References: <20180527190457.2632-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jeremy Cline <jeremy@jcline.org>

Allow vendor-specific setup, open, and close functions to be defined.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
[hdegoede@redhat.com: Port from bt3wire.c to hci_h5.c]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 11bfe28edb86..db0d531d7813 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -21,8 +21,10 @@
  *
  */
 
-#include <linux/kernel.h>
+#include <linux/acpi.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/of_device.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
 
@@ -99,6 +101,14 @@ struct h5 {
 		H5_SLEEPING,
 		H5_WAKING_UP,
 	} sleep;
+
+	const struct h5_vnd *vnd;
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
@@ -773,6 +800,11 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	h5->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, h5);
 
+	if (has_acpi_companion(&serdev->dev))
+		h5->vnd = acpi_device_get_match_data(&serdev->dev);
+	else
+		h5->vnd = of_device_get_match_data(&serdev->dev);
+
 	return hci_uart_register_device(&h5->serdev_hu, &h5p);
 }
 
-- 
2.17.0
