Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAL_JsqKDzR9-ptE=SbL0LuQvTKDNT-GZ8buOvffJDyWz6fHfSA@mail.gmail.com>
Date: Fri, 6 Oct 2017 20:32:27 +0200
Cc: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Message-Id: <BF8AC3FB-72FE-41C3-BE8D-27A32B84F6CB@holtmann.org>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
 <CAL_JsqKDzR9-ptE=SbL0LuQvTKDNT-GZ8buOvffJDyWz6fHfSA@mail.gmail.com>
To: Rob Herring <robh@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob,

>> This patch allows SerDev module to manage serial devices declared as
>> attached to an UART in ACPI table.
>> 
>> acpi_serdev_add_device() callback will only take into account entries
>> without enumerated flag set. This flags is set for all entries during
>> ACPI scan, except for SPI and I2C serial devices, and for UART with
>> 2nd patch in the series.
>> 
>> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
>> ---
>> drivers/tty/serdev/core.c | 99 ++++++++++++++++++++++++++++++++++++++++++++---
>> 1 file changed, 94 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

so how do we get these changes upstream? If the serdev changes alone do not cause any harm, I am almost proposing taking them through bluetooth-next tree and only leave only the ACPI change to the ACPI maintainers.

Greg, any thoughts?

Regards

Marcel

