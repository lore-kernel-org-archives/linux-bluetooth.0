Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_bcm: Add serdev support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <444254163.121186.1501874785594@email.1und1.de>
Date: Fri, 4 Aug 2017 21:37:24 +0200
Cc: Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@gmail.com>, rjui@broadcom.com,
        sbranden@broadcom.com, f.fainelli@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>
Message-Id: <51D602E3-B21A-402B-A1F5-6241D55448E9@holtmann.org>
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
 <1501576704-26423-3-git-send-email-loic.poulain@gmail.com>
 <696124D4-A5DA-46FA-A0F0-5DC74363BD23@holtmann.org>
 <444254163.121186.1501874785594@email.1und1.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

>>> Add basic support for Broadcom serial slave devices.
>>> Probe the serial device, retrieve its maximum speed and
>>> register a new hci uart device.
>>> 
>>> Tested/compatible with bcm43438 (RPi3).
>>> 
>>> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
>>> ...
>>> 
>>> +static int bcm_serdev_probe(struct serdev_device *serdev)
>>> +{
>>> +	struct bcm_bt_device *bcmdev;
>>> +	u32 speed;
>>> +	int err;
>>> +
>>> +	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
>>> +	if (!bcmdev)
>>> +		return -ENOMEM;
>>> +
>>> +	bcmdev->hu.serdev = serdev;
>>> +	serdev_device_set_drvdata(serdev, bcmdev);
>>> +
>>> +	err = of_property_read_u32(serdev->dev.of_node, "max-speed", &speed);
>>> +	if (!err)
>>> +		bcmdev->hu.oper_speed = speed;
>>> +
>>> +	return hci_uart_register_device(&bcmdev->hu, &bcm_proto);
>>> +}
>> 
>> We do not need any GPIO for reset lines or anything else for the rPI3?
>> 
> 
> unfortunately we don't have full schematics for RPI3, but according to firmware dt-blob.dts [1] there is a GPIO called BT_ON. This GPIO is controlled by the GPIO expander on the RPI3 board. The necessary driver for this expander is still out of tree (last mainlining attempt [2]).

so who handles this GPIO then right now (or any other GPIO for that matter)? I have seen Bluetooth being enabled and operational, but I really want to get this working in a plain upstream Fedora and without using hciattach or btattach.

Regards

Marcel

