Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH 2/2] ACPI / scan: Fix enumeration for special UART devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171007225311.lvli7rkhv3bebq2j@earth>
Date: Sun, 8 Oct 2017 10:51:52 +0200
Cc: Johan Hovold <johan@kernel.org>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Hans de Goede <hdegoede@redhat.com>,
        "bluez mailin list (linux-bluetooth@vger.kernel.org)"
        <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Message-Id: <B8D6C3B8-8108-4372-88E6-6182314C7849@holtmann.org>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
 <20171007151934.GJ2618@localhost> <20171007225311.lvli7rkhv3bebq2j@earth>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

>>> UART devices is expected to be enumerated by SerDev subsystem.
>>> 
>>> During ACPI scan, serial devices behind SPI, I2C or UART buses are not
>>> enumerated, allowing them to be enumerated by their respective parents.
>>> 
>>> Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for serial
>>> devices on serial buses (SPI, I2C or UART).
>>> 
>>> On Macs an empty ResourceTemplate is returned for uart slaves.
>>> Instead the device properties "baud", "parity", "dataBits", "stopBits" are
>>> provided. Add a check for "baud" in acpi_is_serial_bus_slave().
>>> 
>>> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
>> 
>> So just to reiterate what I just mentioned in a comment to one of Hans's
>> hci_bcm patches:
>> 
>> This one would silently break PM for such devices on any system which
>> does not have serdev enabled (as the corresponding platform devices
>> would no longer be registered). And with serdev enabled, hciattach
>> (btattach) would start failing as the tty device would no longer be
>> registered (but I assume everyone is aware of that, and fine with it, by
>> now).
>> 
>> Perhaps the hci_bcm driver should start depending on
>> SERIAL_DEV_CTRL_TTYPORT when ACPI is enabled?
> 
> ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly,
> since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented
> for serdev. If any other controller is implemented that one could
> also be used.
> 
> I wonder if we should just hide SERIAL_DEV_CTRL_TTYPORT and enable
> it together with SERDEV. I suspect that we won't see any other
> controller (it would be a UART device, that is not registered as
> tty device) in the next few years and the extra option seems to
> confuse people.

I wonder if we should just default SERIAL_DEV_CTRL_TTYPORT=y when DT or ACPI is enabled. Then no driver would have to select or depend on it.

Regards

Marcel

