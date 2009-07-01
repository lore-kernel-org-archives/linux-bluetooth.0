Return-Path: <cyrus@holtmann.org>
From: Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 1 Jul 2009 14:36:11 +0530
Subject: RE: [PATCH] Bluetooth: Improve the throughput by increasing the
 frame size.
Message-ID: <44EE5C37ADC36343B0625A05DD408C485068EDC9A2@CHEXMB-01.global.atheros.com>
References: <20090620061208.GB9947@atheros-laptop>
	 <1245399665.15367.40.camel@violet>
	 <44EE5C37ADC36343B0625A05DD408C485068E39EE6@CHEXMB-01.global.atheros.com>
 <1245403791.15367.43.camel@violet>
In-Reply-To: <1245403791.15367.43.camel@violet>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>



-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Friday, June 19, 2009 3:00 PM
To: Vikram Kandukuri
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: [PATCH] Bluetooth: Improve the throughput by increasing the fr=
ame size.

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
> > @@ -301,7 +301,7 @@ static int btusb_submit_bulk_urb(struct hci_dev *hd=
ev, gfp_t mem_flags)
> >       struct urb *urb;
> >       unsigned char *buf;
> >       unsigned int pipe;
> > -     int err, size;
> > +     int err, size =3D HCI_MAX_FRAME_SIZE;
> >
> >       BT_DBG("%s", hdev->name);
> >
> > @@ -312,8 +312,6 @@ static int btusb_submit_bulk_urb(struct hci_dev *hd=
ev, gfp_t mem_flags)
> >       if (!urb)
> >               return -ENOMEM;
> >
> > -     size =3D le16_to_cpu(data->bulk_rx_ep->wMaxPacketSize);
> > -
>
> and we can ignore the wMaxPacketSize because. It would be nice to get a
> reason here and that this has been tested at least with a handful of
>
> When we are testing PAN profile with throughput run, we observed low rx t=
hroughput. We have referred hci_usb.c and found they have used HCI_MAX_FRAM=
E_SIZE. This increases the bulk endpoint size to 1028 bytes.
>
> This change gave significant (around 40%) increase in performance (increa=
se from .8 to 1.5 Mb/s in shield room)
>
> We have tested with BRM/Atheros/CSR USB dongles with PAN profile.
> We have tested with iperf and Chariot scripts. Let me know if you need mo=
re information.

I was more looking into the argument that the btusb driver doesn't have
to handle wMaxPacketSize, because the USB host controller will split
URBs accordingly anyway. Is this true for only bulk URBs? Or also for
interrupt and isoc URBs?

Regards

Marcel

Hi Marcel,
I did not get a chance to test interrupt and isoc URBs.
I feel this fix is needed for bulk. I have sent the patch again.

Thanks
Vikram
