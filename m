Return-Path: <foo00@h08.hostsharing.net>
Date: Sat, 9 Sep 2017 19:24:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, robh@kernel.org, sre@kernel.org,
	loic.poulain@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC 2/3] ACPI / scan: Fix enumeration for special UART devices
Message-ID: <20170909172406.GA32618@wunner.de>
References: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
 <1504786214-1866-3-git-send-email-frederic.danis.oss@gmail.com>
 <2C6832A9-2BA5-42CD-A398-CD7BA5AE7C8E@holtmann.org>
 <ce2e3693-437b-1e51-61ad-3873a9e0f0f4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <ce2e3693-437b-1e51-61ad-3873a9e0f0f4@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Sep 09, 2017 at 03:46:07PM +0200, Frédéric Danis wrote:
> Le 07/09/2017 à 19:25, Marcel Holtmann a écrit :
> > >--- a/include/acpi/acpi_bus.h
> > >+++ b/include/acpi/acpi_bus.h
> > >@@ -211,7 +211,7 @@ struct acpi_device_flags {
> > >	u32 of_compatible_ok:1;
> > >	u32 coherent_dma:1;
> > >	u32 cca_seen:1;
> > >-	u32 spi_i2c_slave:1;
> > >+	u32 serial_slave:1;
> > >	u32 reserved:19;
> > >};
> > I am not an ACPI expert, but wouldn't we better have a serial_bus_slave
> > here. And the serial_bus_slave can be either UART or I2C? Or have a
> > pretty good commit message explaining why this is serial_slave only.
> 
> I will rename it.
> serial_bus_slave can be either SPI, I2C or UART
> (cf. http://elixir.free-electrons.com/linux/latest/source/include/acpi/acrestyp.h#L446).

Another idea would be to describe the *effect*, rather than the devices
affected, i.e. something like:

-	u32 spi_i2c_slave:1;
+	u32 parent_enumerated:1;

such that it could be extended to slaves on a non-serial bus in the
future.

Thanks,

Lukas
