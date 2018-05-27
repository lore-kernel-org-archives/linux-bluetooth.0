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
Subject: [PATCH 10/13] Bluetooth: hci_h5: Add support for serdev enumerated devices
Date: Sun, 27 May 2018 21:04:54 +0200
Message-Id: <20180527190457.2632-11-hdegoede@redhat.com>
In-Reply-To: <20180527190457.2632-1-hdegoede@redhat.com>
References: <20180527190457.2632-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add basic support for serdev enumerated devices, note sine this does
not (yet) declare any of / ACPI ids to bind to atm this is a nop.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 51 +++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 6a8d0d06aba7..11bfe28edb86 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -23,6 +23,7 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/serdev.h>
 #include <linux/skbuff.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -65,6 +66,9 @@ enum {
 };
 
 struct h5 {
+	/* Must be the first member, hci_serdev.c expects this. */
+	struct hci_uart		serdev_hu;
+
 	struct sk_buff_head	unack;		/* Unack'ed packets queue */
 	struct sk_buff_head	rel;		/* Reliable packets queue */
 	struct sk_buff_head	unrel;		/* Unreliable packets queue */
@@ -193,9 +197,13 @@ static int h5_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
-	h5 = kzalloc(sizeof(*h5), GFP_KERNEL);
-	if (!h5)
-		return -ENOMEM;
+	if (hu->serdev) {
+		h5 = serdev_device_get_drvdata(hu->serdev);
+	} else {
+		h5 = kzalloc(sizeof(*h5), GFP_KERNEL);
+		if (!h5)
+			return -ENOMEM;
+	}
 
 	hu->priv = h5;
 	h5->hu = hu;
@@ -229,7 +237,8 @@ static int h5_close(struct hci_uart *hu)
 	skb_queue_purge(&h5->rel);
 	skb_queue_purge(&h5->unrel);
 
-	kfree(h5);
+	if (!hu->serdev)
+		kfree(h5);
 
 	return 0;
 }
@@ -750,12 +759,46 @@ static const struct hci_uart_proto h5p = {
 	.flush		= h5_flush,
 };
 
+static int h5_serdev_probe(struct serdev_device *serdev)
+{
+	struct h5 *h5;
+
+	h5 = devm_kzalloc(&serdev->dev, sizeof(*h5), GFP_KERNEL);
+	if (!h5)
+		return -ENOMEM;
+
+	set_bit(HCI_UART_RESET_ON_INIT, &h5->serdev_hu.flags);
+
+	h5->hu = &h5->serdev_hu;
+	h5->serdev_hu.serdev = serdev;
+	serdev_device_set_drvdata(serdev, h5);
+
+	return hci_uart_register_device(&h5->serdev_hu, &h5p);
+}
+
+static void h5_serdev_remove(struct serdev_device *serdev)
+{
+	struct h5 *h5 = serdev_device_get_drvdata(serdev);
+
+	hci_uart_unregister_device(&h5->serdev_hu);
+}
+
+static struct serdev_device_driver h5_serdev_driver = {
+	.probe = h5_serdev_probe,
+	.remove = h5_serdev_remove,
+	.driver = {
+		.name = "hci_uart_h5",
+	},
+};
+
 int __init h5_init(void)
 {
+	serdev_device_driver_register(&h5_serdev_driver);
 	return hci_uart_register_proto(&h5p);
 }
 
 int __exit h5_deinit(void)
 {
+	serdev_device_driver_unregister(&h5_serdev_driver);
 	return hci_uart_unregister_proto(&h5p);
 }
-- 
2.17.0
