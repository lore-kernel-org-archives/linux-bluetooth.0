Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Support for new firmware for ath3k USB
 Bluetooth device
From: Marcel Holtmann <marcel@holtmann.org>
To: David Vrabel <david.vrabel@csr.com>
Cc: Suraj Sumangala <suraj@atheros.com>,
	linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@atheros.com
In-Reply-To: <4CAACD5A.8040304@csr.com>
References: <1286259436-25424-1-git-send-email-suraj@atheros.com>
	 <4CAACD5A.8040304@csr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Oct 2010 09:38:55 +0200
Message-ID: <1286264335.17473.18.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> > This patch add support for new ath3k USB Bluetooth device firmare.
> > The firmware implements shared antenna support and
> > fixes few critical bugs.
> [...]
> >  static int ath3k_probe(struct usb_interface *intf,
> >  			const struct usb_device_id *id)
> >  {
> > @@ -110,6 +113,8 @@ static int ath3k_probe(struct usb_interface *intf,
> >  	struct usb_device *udev = interface_to_usbdev(intf);
> >  	struct ath3k_data *data;
> >  	int size;
> > +	int i;
> > +	char fw_file[MAXPATHLEN]
> 
> Suggest FW_PATH_LEN here to avoid confusion as most people would expect
> MAXPATHLEN to be enormous.
> 
> >  	BT_DBG("intf %p id %p", intf, id);
> >  
> > @@ -122,7 +127,16 @@ static int ath3k_probe(struct usb_interface *intf,
> >  
> >  	data->udev = udev;
> >  
> > -	if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
> 
> Why not request ath3k-1.fw (for backward compatibility) and ath3k.fw and
> symlink this name to ath3k-2.fw or any future version of firmware?
> 
> I think users should be able to update firmware without a kernel update
> where possible.

yes, it is mandatory to support at least the last two firmware version.
Just forcing a firmware update with a new kernel is not going to work.

So NAK on this patch.

Regards

Marcel


