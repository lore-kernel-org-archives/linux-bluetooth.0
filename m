Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Bluetooth: Improve the throughput by increasing the
 frame size.
From: Marcel Holtmann <marcel@holtmann.org>
To: Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <44EE5C37ADC36343B0625A05DD408C485068E39EE6@CHEXMB-01.global.atheros.com>
References: <20090620061208.GB9947@atheros-laptop>
	 <1245399665.15367.40.camel@violet>
	 <44EE5C37ADC36343B0625A05DD408C485068E39EE6@CHEXMB-01.global.atheros.com>
Content-Type: text/plain
Date: Fri, 19 Jun 2009 11:29:51 +0200
Message-Id: <1245403791.15367.43.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

> > This patch increases the receive buffer size to HCI_MAX_FRAME_SIZE
> > which improves the Rx throughput considerably.
> >
> > Signed-off-by: Vikram Kandukuri <Vikram.Kandukuri@atheros.com>
> > ---
> >  drivers/bluetooth/btusb.c |    4 +---
> >  1 files changed, 1 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index e70c57e..124db8c 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -301,7 +301,7 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
> >       struct urb *urb;
> >       unsigned char *buf;
> >       unsigned int pipe;
> > -     int err, size;
> > +     int err, size = HCI_MAX_FRAME_SIZE;
> >
> >       BT_DBG("%s", hdev->name);
> >
> > @@ -312,8 +312,6 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
> >       if (!urb)
> >               return -ENOMEM;
> >
> > -     size = le16_to_cpu(data->bulk_rx_ep->wMaxPacketSize);
> > -
> 
> and we can ignore the wMaxPacketSize because. It would be nice to get a
> reason here and that this has been tested at least with a handful of
>
> When we are testing PAN profile with throughput run, we observed low rx throughput. We have referred hci_usb.c and found they have used HCI_MAX_FRAME_SIZE. This increases the bulk endpoint size to 1028 bytes.
> 
> This change gave significant (around 40%) increase in performance (increase from .8 to 1.5 Mb/s in shield room)
> 
> We have tested with BRM/Atheros/CSR USB dongles with PAN profile.
> We have tested with iperf and Chariot scripts. Let me know if you need more information.

I was more looking into the argument that the btusb driver doesn't have
to handle wMaxPacketSize, because the USB host controller will split
URBs accordingly anyway. Is this true for only bulk URBs? Or also for
interrupt and isoc URBs?

Regards

Marcel


