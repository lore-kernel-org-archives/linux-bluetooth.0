Return-Path: <ianwmorrison@gmail.com>
MIME-Version: 1.0
In-Reply-To: <D567DA4A-4443-4A88-B078-50EE458C822A@holtmann.org>
References: <a4051ac2-1156-751d-ec16-2dbbb30b9258@gmail.com> <D567DA4A-4443-4A88-B078-50EE458C822A@holtmann.org>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Sat, 7 Oct 2017 23:06:44 +1100
Message-ID: <CAFXWsS-VsQvpat=fGbYeR3_STFJ=pTjDr9oUFaS3oHtMPoK8Hw@mail.gmail.com>
Subject: Re: [PATCH] serdev: Update drivers/tty/serdev/Kconfig for ACPI support
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>,
	Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>,
	Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On 7 October 2017 at 17:42, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Ian,
>
>> The current Kconfig for serdev is not compatible when adding ACPI suppor=
t as it does not work when built as a module as it requires config SERIAL_D=
EV_CTRL_TTYPORT to be set. This patch makes serdev compiled into the kernel=
 if selected so that config SERIAL_DEV_CTRL_TTYPORT can be correctly set if=
 requiring ACPI support.
>> ---
>> drivers/tty/serdev/Kconfig | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
>> index cdc6b820cf93..a9fb09a9c105 100644
>> --- a/drivers/tty/serdev/Kconfig
>> +++ b/drivers/tty/serdev/Kconfig
>> @@ -2,7 +2,8 @@
>> # Serial bus device driver configuration
>> #
>> menuconfig SERIAL_DEV_BUS
>> -     tristate "Serial device bus"
>> +     bool "Serial device bus"
>> +     default y
>>       help
>>         Core support for devices connected via a serial port.
>>
>> @@ -11,6 +12,6 @@ if SERIAL_DEV_BUS
>> config SERIAL_DEV_CTRL_TTYPORT
>>       bool "Serial device TTY port controller"
>>       depends on TTY
>> -     depends on SERIAL_DEV_BUS !=3D m
>> +     default y
>
> actually we made hci_nokia.c be buildable as separate module. We might ne=
ed to do the same for hci_bcm.c to avoid forcing SERIAL_DEV_BUS into a bool=
. Or you need to explain the reason behind this change a bit better.
>
> Regards
>
> Marcel
>

Hi Marcel,

For serdev to support for devices connected via a serial port such as
a tty (for example an ACPI enumerated BT driver) its code hooks into
TTY code meaning serdev can no longer be compiled as a module for this
functionality to work. With CONFIG_SERIAL_DEV_BUS originally being
defined as a tristate a provision was made when compiling serdev as a
module to return ENODEV when trying to register a tty port. This
provision still exists with CONFIG_SERIAL_DEV_BUS defined as a bool
because CONFIG_SERIAL_DEV_CTRL_TTYPORT actually controls this.

My patch also aligns CONFIG_SERIAL_DEV_BUS (serdev) which provides
"Core serial port support" to CONFIG_SERIAL_NONSTANDARD or
"Non-standard serial port support" as this seems logical comparison.
CONFIG_SERIAL_NONSTANDARD is a bool similar to how I've made
CONFIG_SERIAL_DEV_BUS a bool.

Whilst it may be preferable to make hci_bcm.c buildable as separate
module like hci_nokia.c I don't relate the 'modularity' of bluetooth
drivers with the 'modularity' of a serial device bus as I see the
latter more similar to PCI support or ACPI support.

Because of the link and/or cross-over between serial port support and
tty support I believe serdev should be built-in rather than
modularized if and when it is required.

If this better explains the reason for the patch I can resubmit with
an updated changelog together with a signoff which I accidentally
during editing.

Regards,
Ian
