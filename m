Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-bluetooth@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH] Bluetooth: btusb: use irqsave() in URB's complete callback
Date: Tue, 19 Jun 2018 23:56:57 +0200
Message-Id: <20180619215657.13745-1-bigeasy@linutronix.de>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

The USB completion callback does not disable interrupts while acquiring
the ->lock. We want to remove the local_irq_disable() invocation from
__usb_hcd_giveback_urb() and therefore it is required for the callback
handler to disable the interrupts while acquiring the lock.
The callback may be invoked either in IRQ or BH context depending on the
USB host controller.
Use the _irqsave variant of the locking primitives.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/bluetooth/btusb.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f73a27ea28cc..f262163fecd5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -509,9 +509,10 @@ static inline void btusb_free_frags(struct btusb_data =
*data)
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int coun=
t)
 {
 	struct sk_buff *skb;
+	unsigned long flags;
 	int err =3D 0;
=20
-	spin_lock(&data->rxlock);
+	spin_lock_irqsave(&data->rxlock, flags);
 	skb =3D data->evt_skb;
=20
 	while (count) {
@@ -556,7 +557,7 @@ static int btusb_recv_intr(struct btusb_data *data, voi=
d *buffer, int count)
 	}
=20
 	data->evt_skb =3D skb;
-	spin_unlock(&data->rxlock);
+	spin_unlock_irqrestore(&data->rxlock, flags);
=20
 	return err;
 }
@@ -564,9 +565,10 @@ static int btusb_recv_intr(struct btusb_data *data, vo=
id *buffer, int count)
 static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int coun=
t)
 {
 	struct sk_buff *skb;
+	unsigned long flags;
 	int err =3D 0;
=20
-	spin_lock(&data->rxlock);
+	spin_lock_irqsave(&data->rxlock, flags);
 	skb =3D data->acl_skb;
=20
 	while (count) {
@@ -613,7 +615,7 @@ static int btusb_recv_bulk(struct btusb_data *data, voi=
d *buffer, int count)
 	}
=20
 	data->acl_skb =3D skb;
-	spin_unlock(&data->rxlock);
+	spin_unlock_irqrestore(&data->rxlock, flags);
=20
 	return err;
 }
@@ -621,9 +623,10 @@ static int btusb_recv_bulk(struct btusb_data *data, vo=
id *buffer, int count)
 static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int coun=
t)
 {
 	struct sk_buff *skb;
+	unsigned long flags;
 	int err =3D 0;
=20
-	spin_lock(&data->rxlock);
+	spin_lock_irqsave(&data->rxlock, flags);
 	skb =3D data->sco_skb;
=20
 	while (count) {
@@ -668,7 +671,7 @@ static int btusb_recv_isoc(struct btusb_data *data, voi=
d *buffer, int count)
 	}
=20
 	data->sco_skb =3D skb;
-	spin_unlock(&data->rxlock);
+	spin_unlock_irqrestore(&data->rxlock, flags);
=20
 	return err;
 }
@@ -1066,6 +1069,7 @@ static void btusb_tx_complete(struct urb *urb)
 	struct sk_buff *skb =3D urb->context;
 	struct hci_dev *hdev =3D (struct hci_dev *)skb->dev;
 	struct btusb_data *data =3D hci_get_drvdata(hdev);
+	unsigned long flags;
=20
 	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
 	       urb->actual_length);
@@ -1079,9 +1083,9 @@ static void btusb_tx_complete(struct urb *urb)
 		hdev->stat.err_tx++;
=20
 done:
-	spin_lock(&data->txlock);
+	spin_lock_irqsave(&data->txlock, flags);
 	data->tx_in_flight--;
-	spin_unlock(&data->txlock);
+	spin_unlock_irqrestore(&data->txlock, flags);
=20
 	kfree(urb->setup_packet);
=20
--=20
2.17.1
