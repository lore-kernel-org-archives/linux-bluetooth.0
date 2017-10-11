Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20171011090354.GS4269@localhost>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com> <20171011090354.GS4269@localhost>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Oct 2017 15:09:12 +0200
Message-ID: <CAJZ5v0jPEg5Ow4p0DzPJ9Md7RUTPhZZqCzqP5zmX-pPf9N80=g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ACPI serdev support
To: Johan Hovold <johan@kernel.org>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>, Sebastian Reichel <sre@kernel.org>,
	Loic Poulain <loic.poulain@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <greg@kroah.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 11, 2017 at 11:03 AM, Johan Hovold <johan@kernel.org> wrote:
> On Wed, Oct 11, 2017 at 10:32:12AM +0200, Fr=C3=A9d=C3=A9ric Danis wrote:
>> Add ACPI support for serial attached devices.
>>
>> Currently, serial devices are not set as enumerated during ACPI scan for=
 SPI
>> or i2c buses (but not for UART). This should also be done for UART seria=
l
>> devices.
>> I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.
>>
>> This needs Johan Hovold's "serdev: fix registration of second slave" pat=
ch.
>
> In theory this series could go in through the acpi-tree without my
> fix. It would only affect an error case where an unlikely failure to
> register an ACPI serdev device, would prevent the tty-class device from
> being registered instead of the controller. That is, something we can
> live with until this all converges in 4.15-rc1 if needed.
>
> That said, I think we should consider taking all serdev changes, and
> therefore also the ACPI patch, through the tty tree instead in order to
> avoid merge conflicts. Rafael?

OK

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the ACPI core change.

And I will assume that this series will go in via the tty tree.

Thanks,
Rafael
