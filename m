Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: PATCH: RFC: Broadcom serdev driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a7a41abf-0dc2-03d7-a529-ade49f326bb5@mnementh.co.uk>
Date: Sat, 8 Jul 2017 12:25:20 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        Rob Herring <robh@kernel.org>
Message-Id: <E30A8409-1953-4B47-9C3B-D8EE46CFCF9E@holtmann.org>
References: <afbbb4ed-d1aa-2ae8-33c5-1fab8e360551@mnementh.co.uk>
 <A31E83F8-3A6E-49DC-BF1A-0FA1C6E10552@holtmann.org>
 <a7a41abf-0dc2-03d7-a529-ade49f326bb5@mnementh.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

>>> One oddity I've spotted is that the chip tries to go back to 115200 baud
>>> after loading its firmware patch, which messes up the change to
>>> oper_speed. I've worked around this by not using the set_baudrate hook,
>>> just setting the operating speed after firmware loading in setup.
>> 
>> I assume we addressed that in hci_uart. If not then we need to handle that there first.
> 
> 
> In hci_uart_setup() in hci_serdev.c, there is the following:
> 
> 
>        if (hu->init_speed)
>                speed = hu->init_speed;
>        else if (hu->proto->init_speed)
>                speed = hu->proto->init_speed;
>        else
>                speed = 0;
> 
>        if (speed)
>                serdev_device_set_baudrate(hu->serdev, speed);
> 
>        /* Operational speed if any */
>        if (hu->oper_speed)
>                speed = hu->oper_speed;
>        else if (hu->proto->oper_speed)
>                speed = hu->proto->oper_speed;
>        else
>                speed = 0;
> 
>        if (hu->proto->set_baudrate && speed) {
>                err = hu->proto->set_baudrate(hu, speed);
>                if (err)
>                        BT_ERR("%s: failed to set baudrate", hdev->name);
>                else
>                        serdev_device_set_baudrate(hu->serdev, speed);
>        }
> 
>        if (hu->proto->setup)
>                return hu->proto->setup(hu);
> 
> 
> The problem is that it attempts to set the baudrate to oper_speed
> *prior* to calling the driver's setup() hook.
> 
> It *seems* simple enough that we could move the setup call to prior to
> the change to oper_speed, but I am unsure how this might affect other
> drivers.
> 
> I can test this on my driver (and implement the set_baudrate command
> properly as a result.
> 
> I can send a patch to this effect if you want?

the hci_bcm.c on ACPI based Baytrail platforms is capable of dealing with this. What is different here?

Regards

Marcel

