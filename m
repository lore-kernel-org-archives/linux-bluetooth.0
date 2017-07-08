Return-Path: <ian@mnementh.co.uk>
Subject: Re: PATCH: RFC: Broadcom serdev driver
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Loic Poulain <loic.poulain@gmail.com>, Rob Herring <robh@kernel.org>
References: <afbbb4ed-d1aa-2ae8-33c5-1fab8e360551@mnementh.co.uk>
 <A31E83F8-3A6E-49DC-BF1A-0FA1C6E10552@holtmann.org>
 <a7a41abf-0dc2-03d7-a529-ade49f326bb5@mnementh.co.uk>
 <E30A8409-1953-4B47-9C3B-D8EE46CFCF9E@holtmann.org>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <e9f07754-39bc-8fb0-0abf-eb0b8692c2eb@mnementh.co.uk>
Date: Sat, 8 Jul 2017 14:27:01 +0100
MIME-Version: 1.0
In-Reply-To: <E30A8409-1953-4B47-9C3B-D8EE46CFCF9E@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/07/17 11:25, Marcel Holtmann wrote:
> Hi Ian,

Hi Marcel,

>> In hci_uart_setup() in hci_serdev.c, there is the following:
>>
>>
>>        if (hu->init_speed)
>>                speed = hu->init_speed;
>>        else if (hu->proto->init_speed)
>>                speed = hu->proto->init_speed;
>>        else
>>                speed = 0;
>>
>>        if (speed)
>>                serdev_device_set_baudrate(hu->serdev, speed);
>>
>>        /* Operational speed if any */
>>        if (hu->oper_speed)
>>                speed = hu->oper_speed;
>>        else if (hu->proto->oper_speed)
>>                speed = hu->proto->oper_speed;
>>        else
>>                speed = 0;
>>
>>        if (hu->proto->set_baudrate && speed) {
>>                err = hu->proto->set_baudrate(hu, speed);
>>                if (err)
>>                        BT_ERR("%s: failed to set baudrate", hdev->name);
>>                else
>>                        serdev_device_set_baudrate(hu->serdev, speed);
>>        }
>>
>>        if (hu->proto->setup)
>>                return hu->proto->setup(hu);
>>
>>
>> The problem is that it attempts to set the baudrate to oper_speed
>> *prior* to calling the driver's setup() hook.
>>
>> It *seems* simple enough that we could move the setup call to prior to
>> the change to oper_speed, but I am unsure how this might affect other
>> drivers.
>>
>> I can test this on my driver (and implement the set_baudrate command
>> properly as a result.
>>
>> I can send a patch to this effect if you want?
> 
> the hci_bcm.c on ACPI based Baytrail platforms is capable of dealing with this. What is different here?

hci_bcm.c changes speed for itself during bcm_setup(), after loading the
firmware. This doesnt work for at least the 43430 I have here (SDIO
based WiFi with UART BT). If oper_speed != 115200 it fails to
communicate after FW load.

This occurred with hci_bcm.c as well as with my driver.

Perhaps we could introduce a flag, say, HCI_SLOW_INIT or something to
prevent hci_serdev.c from changing speed prior to FW loading? It could
also be a dt property. What do you think?

-Ian
