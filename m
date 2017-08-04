Return-Path: <stefan.wahren@i2se.com>
Date: Fri, 4 Aug 2017 21:26:25 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh+dt@kernel.org>,
	Loic Poulain <loic.poulain@gmail.com>
Cc: rjui@broadcom.com, sbranden@broadcom.com, f.fainelli@gmail.com,
	linux-rpi-kernel@lists.infradead.org,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	devicetree <devicetree@vger.kernel.org>
Message-ID: <444254163.121186.1501874785594@email.1und1.de>
In-Reply-To: <696124D4-A5DA-46FA-A0F0-5DC74363BD23@holtmann.org>
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
 <1501576704-26423-3-git-send-email-loic.poulain@gmail.com>
 <696124D4-A5DA-46FA-A0F0-5DC74363BD23@holtmann.org>
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_bcm: Add serdev support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Marcel Holtmann <marcel@holtmann.org> hat am 4. August 2017 um 16:36 geschrieben:
> 
> 
> Hi Loic,
> 
> > Add basic support for Broadcom serial slave devices.
> > Probe the serial device, retrieve its maximum speed and
> > register a new hci uart device.
> > 
> > Tested/compatible with bcm43438 (RPi3).
> > 
> > Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> > ...
> > 
> > +static int bcm_serdev_probe(struct serdev_device *serdev)
> > +{
> > +	struct bcm_bt_device *bcmdev;
> > +	u32 speed;
> > +	int err;
> > +
> > +	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
> > +	if (!bcmdev)
> > +		return -ENOMEM;
> > +
> > +	bcmdev->hu.serdev = serdev;
> > +	serdev_device_set_drvdata(serdev, bcmdev);
> > +
> > +	err = of_property_read_u32(serdev->dev.of_node, "max-speed", &speed);
> > +	if (!err)
> > +		bcmdev->hu.oper_speed = speed;
> > +
> > +	return hci_uart_register_device(&bcmdev->hu, &bcm_proto);
> > +}
> 
> We do not need any GPIO for reset lines or anything else for the rPI3?
> 

unfortunately we don't have full schematics for RPI3, but according to firmware dt-blob.dts [1] there is a GPIO called BT_ON. This GPIO is controlled by the GPIO expander on the RPI3 board. The necessary driver for this expander is still out of tree (last mainlining attempt [2]).

Regards
Stefan

[1] - https://github.com/raspberrypi/firmware/blob/master/extra/dt-blob.dts
[2] - http://lists.infradead.org/pipermail/linux-rpi-kernel/2017-March/005801.html
