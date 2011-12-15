Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Gustavo Padovan <padovan@profusion.mobi>, Marcel Holtmann
	<marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 15 Dec 2011 15:29:22 -0800
Subject: Bluetooth: btusb: urb->interval speed check in
 btusb_submit_isoc_urb()
Message-ID: <477F20668A386D41ADCC57781B1F704308185E345D@SC-VEXCH1.marvell.com>
References: <1321504842-11199-1-git-send-email-bzhao@marvell.com>
 <20111121155255.GD2552@joana>
In-Reply-To: <20111121155255.GD2552@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo, Marcel,

In drivers/Bluetooth/btusb.c, function btusb_send_frame(), we call

        usb_fill_int_urb(urb, data->udev, pipe,
                        skb->data, skb->len, btusb_isoc_tx_complete,
                        skb, data->isoc_tx_ep->bInterval);

in case HCI_SCODATA_PKT. The inline function usb_fill_int_urb will check US=
B_SPEED_HIGH or USB_SPEED_SUPER to assign different value to urb->interval.

        if (dev->speed =3D=3D USB_SPEED_HIGH || dev->speed =3D=3D USB_SPEED=
_SUPER)
                urb->interval =3D 1 << (interval - 1);
        else
                urb->interval =3D interval;

Shall we do the same check for btusb_submit_isoc_urb()?

---
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ea5ad1c..27ecf40 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -512,7 +512,11 @@ static int btusb_submit_isoc_urb(struct hci_dev *hdev,=
 gfp_
        urb->pipe     =3D pipe;
        urb->context  =3D hdev;
        urb->complete =3D btusb_isoc_complete;
-       urb->interval =3D data->isoc_rx_ep->bInterval;
+       if (data->udev->speed =3D=3D USB_SPEED_HIGH
+                               || data->udev->speed =3D=3D USB_SPEED_SUPER=
)
+               urb->interval =3D 1 << (data->isoc_rx_ep->bInterval - 1);
+       else
+               urb->interval =3D data->isoc_rx_ep->bInterval;

        urb->transfer_flags  =3D URB_FREE_BUFFER | URB_ISO_ASAP;
        urb->transfer_buffer =3D buf;
--

Thanks,
Bing
