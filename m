Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 11:20:35 -0800
From: "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Stephen Hemminger <shemminger@vyatta.com>,
	Vikram Kandukuri <vikram@qca.qualcomm.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: Re: ath3k: asus bluetooth dongle won't work
Message-ID: <20120217192035.GA8986@tux>
References: <20120216173504.2571de22@s6510.linuxnetplumber.net>
 <1329467683.28848.128.camel@aeonflux>
 <20120217075638.7bbdef33@nehalam.linuxnetplumber.net>
 <1329494697.28848.177.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1329494697.28848.177.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Feb 17, 2012 at 05:04:57PM +0100, Marcel Holtmann wrote:
> Hi Stephen,
> 
> > > > Running on Debian Wheezy (3.2.0-1-amd64), my new Asus bluetooth
> > > > dongle didn't work. Made sure and get the correct firmware, but
> > > > the driver does not load it correctly.
> > > > 
> > > > [    8.364186] Bluetooth: Can't change to loading configuration err
> > > > [    8.364263] ath3k: probe of 2-4.3:1.0 failed with error -110
> > > > [    8.364300] usbcore: registered new interface driver ath3k
> > > > 
> > > > 
> > > > This is from a cold (power off) boot, but it happens repeatedly.
> > > > 
> > > > Any idea what could be wrong?
> > > > 
> > > > lsusb
> > > > Bus 002 Device 005: ID 0cf3:3000 Atheros Communications, Inc. AR3011 Bluetooth (no firmware)
> > > 
> > > you need to ask Atheros for details, but maybe just the firmware file is
> > > missing.
> > 
> > Already covered that.
> > 
> > It is failing here where it sends the firmware.
> > 
> > 	memcpy(send_buf, firmware->data, 20);
> > 	if ((err = usb_control_msg(udev, pipe,
> > 				USB_REQ_DFU_DNLOAD,
> > 				USB_TYPE_VENDOR, 0, 0,
> > 				send_buf, 20, USB_CTRL_SET_TIMEOUT)) < 0) {
> > 		BT_ERR("Can't change to loading configuration err");
> > 		goto error;
> > 	}
> > 
> 
> then you need to track down the Atheros guys. Not my driver or
> hardware ;)

They have been poked (its not me but I poked some internal folks).  In the
meantime, stephen do you have the latest firmware? For what its worth the
documentation to this driver is at:

http://wireless.kernel.org/en/users/Drivers/ath3k

  Luis
