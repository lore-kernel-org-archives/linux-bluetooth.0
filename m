Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 07:56:38 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Vikram Kandukuri <vkandukuri@atheros.com>, "Luis R. Rodriguez"
 <mcgrof@qca.qualcomm.com>, linux-bluetooth@vger.kernel.org
Subject: Re: ath3k: asus bluetooth dongle won't work
Message-ID: <20120217075638.7bbdef33@nehalam.linuxnetplumber.net>
In-Reply-To: <1329467683.28848.128.camel@aeonflux>
References: <20120216173504.2571de22@s6510.linuxnetplumber.net>
	<1329467683.28848.128.camel@aeonflux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 17 Feb 2012 09:34:43 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Stephen,
> 
> > Running on Debian Wheezy (3.2.0-1-amd64), my new Asus bluetooth
> > dongle didn't work. Made sure and get the correct firmware, but
> > the driver does not load it correctly.
> > 
> > [    8.364186] Bluetooth: Can't change to loading configuration err
> > [    8.364263] ath3k: probe of 2-4.3:1.0 failed with error -110
> > [    8.364300] usbcore: registered new interface driver ath3k
> > 
> > 
> > This is from a cold (power off) boot, but it happens repeatedly.
> > 
> > Any idea what could be wrong?
> > 
> > lsusb
> > Bus 002 Device 005: ID 0cf3:3000 Atheros Communications, Inc. AR3011 Bluetooth (no firmware)
> 
> you need to ask Atheros for details, but maybe just the firmware file is
> missing.

Already covered that.

It is failing here where it sends the firmware.

	memcpy(send_buf, firmware->data, 20);
	if ((err = usb_control_msg(udev, pipe,
				USB_REQ_DFU_DNLOAD,
				USB_TYPE_VENDOR, 0, 0,
				send_buf, 20, USB_CTRL_SET_TIMEOUT)) < 0) {
		BT_ERR("Can't change to loading configuration err");
		goto error;
	}
