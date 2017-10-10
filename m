Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Oct 2017 02:27:33 +0200
Message-ID: <CAJZ5v0iaXiPhZaohmN0XLJ2_n7ZzhbWebUh80uC3-8n5uGg8jg@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI serdev support
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Johan Hovold <johan@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 4, 2017 at 10:51 AM, Fr=C3=A9d=C3=A9ric Danis
<frederic.danis.oss@gmail.com> wrote:
> Add ACPI support for serial attached devices.
>
> Currently, serial devices are not set as enumerated during ACPI scan for =
SPI
> or i2c buses (but not for UART). This should also be done for UART serial
> devices.
> I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.
>
> For hci_bcm, this needs Hans de Goede's "Bluetooth: hci_bcm: Add (runtime=
)pm
> support to the serdev drv" patches to work.
>
> Tested on T100TA with Broadcom BCM2E39.
>
> Since RFC:
>   - Add or reword commit messages
>   - Rename *serial_slave* to *serial_bus_slave*
>   - Add specific check for Apple in acpi_is_serial_bus_slave(), thanks to
>     Lukas Wunner
>   - Update comment in acpi_default_enumeration()
>   - Remove patch 3 "Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E=
39"
>     in favor of patches from Hans de Goede
>
> Fr=C3=A9d=C3=A9ric Danis (2):
>   serdev: Add ACPI support
>   ACPI / scan: Fix enumeration for special UART devices

Some review comments you received on this series should be addressed
IMO, so I'm expecting an update of it.

When sending the next version, please add all of the tags you've
already received on it.

Thanks,
Rafael
