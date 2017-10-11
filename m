Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH v3 0/2] ACPI serdev support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJZ5v0jPEg5Ow4p0DzPJ9Md7RUTPhZZqCzqP5zmX-pPf9N80=g@mail.gmail.com>
Date: Wed, 11 Oct 2017 20:32:06 +0200
Cc: Johan Hovold <johan@kernel.org>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Message-Id: <AA38D4FD-5A35-460D-85CF-380BAB933448@holtmann.org>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
 <20171011090354.GS4269@localhost>
 <CAJZ5v0jPEg5Ow4p0DzPJ9Md7RUTPhZZqCzqP5zmX-pPf9N80=g@mail.gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Greg,

>>> Add ACPI support for serial attached devices.
>>> 
>>> Currently, serial devices are not set as enumerated during ACPI scan for SPI
>>> or i2c buses (but not for UART). This should also be done for UART serial
>>> devices.
>>> I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.
>>> 
>>> This needs Johan Hovold's "serdev: fix registration of second slave" patch.
>> 
>> In theory this series could go in through the acpi-tree without my
>> fix. It would only affect an error case where an unlikely failure to
>> register an ACPI serdev device, would prevent the tty-class device from
>> being registered instead of the controller. That is, something we can
>> live with until this all converges in 4.15-rc1 if needed.
>> 
>> That said, I think we should consider taking all serdev changes, and
>> therefore also the ACPI patch, through the tty tree instead in order to
>> avoid merge conflicts. Rafael?
> 
> OK
> 
> Please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to the ACPI core change.
> 
> And I will assume that this series will go in via the tty tree.

you have to take these two patches now via the TTY tree now. In case you already marked them as someone else problem ;)

Regards

Marcel

