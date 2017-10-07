Return-Path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
Date: Sat, 7 Oct 2017 17:19:34 +0200
From: Johan Hovold <johan@kernel.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
Cc: robh@kernel.org, marcel@holtmann.org, sre@kernel.org,
	loic.poulain@gmail.com, johan@kernel.org, lukas@wunner.de,
	hdegoede@redhat.com, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] ACPI / scan: Fix enumeration for special UART devices
Message-ID: <20171007151934.GJ2618@localhost>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 04, 2017 at 10:51:30AM +0200, Frédéric Danis wrote:
> UART devices is expected to be enumerated by SerDev subsystem.
> 
> During ACPI scan, serial devices behind SPI, I2C or UART buses are not
> enumerated, allowing them to be enumerated by their respective parents.
> 
> Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for serial
> devices on serial buses (SPI, I2C or UART).
> 
> On Macs an empty ResourceTemplate is returned for uart slaves.
> Instead the device properties "baud", "parity", "dataBits", "stopBits" are
> provided. Add a check for "baud" in acpi_is_serial_bus_slave().
> 
> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>

So just to reiterate what I just mentioned in a comment to one of Hans's
hci_bcm patches:

This one would silently break PM for such devices on any system which
does not have serdev enabled (as the corresponding platform devices
would no longer be registered). And with serdev enabled, hciattach
(btattach) would start failing as the tty device would no longer be
registered (but I assume everyone is aware of that, and fine with it, by
now).

Perhaps the hci_bcm driver should start depending on
SERIAL_DEV_CTRL_TTYPORT when ACPI is enabled?

Johan
