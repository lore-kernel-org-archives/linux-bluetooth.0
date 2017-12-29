Return-Path: <ianwmorrison@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1514491453.7000.470.camel@linux.intel.com>
References: <20171228195503.4283-1-andriy.shevchenko@linux.intel.com> <1514491453.7000.470.camel@linux.intel.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Fri, 29 Dec 2017 17:09:55 +1100
Message-ID: <CAFXWsS9Rg3XuPTjqXLCb6BC1UBvjG4PTw4--JfWW=mFRC4vE_A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Replace dependency on SERIAL_DEV_BUS by selection
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
	"loic . poulain @ gmail . com" <loic.poulain@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	"arnd.bergmann" <arnd.bergmann@linaro.org>, Rob Herring <robh@kernel.org>,
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

This was discussed at length before and resulted in Johan Hovold's
patch 'Bluetooth: avoid silent hci_bcm ACPI PM regression' (commit
4294625e029028854596865be401b9c5c1f906ef).

I did some additional analysis at the time in attempting to force
BT_HCIUART_BCM to select SERIAL_DEV_CTRL_TTYPORT in
drivers/bluetooth/Kconfig but a warning of unmet dependencies was
encountered:

warning: (BT_HCIUART_BCM) selects SERIAL_DEV_CTRL_TTYPORT which has
unmet direct dependencies (TTY && SERIAL_DEV_BUS=y)

and the resultant .config was also incorrect in that it now had the
additional entry of CONFIG_SERIAL_DEV_CTRL_TTYPORT=y

The only way I could correctly set the runtime dependencies was by
modifying drivers/tty/serdev/Kconfig and:

changing SERIAL_DEV_BUS from being tristate to bool
changing SERIAL_DEV_CTRL_TTYPORT depends on SERIAL_DEV_BUS !=m to
SERIAL_DEV_CTRL_TTYPORT depends on SERIAL_DEV_BUS"

as a 'make' would prompt for the correct value for CONFIG_SERIAL_DEV_BUS.

However this can be addressed by distro owners updating their configs
and changing
CONFIG_SERIAL_DEV_BUS=m
to
CONFIG_SERIAL_DEV_BUS=y
and adding
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_BT_HCIUART_BCM=y

FYI I'm still waiting for Canonical to do this for Ubuntu and I've
recently raised a bug report (Bug #1739939) requesting the change.

Regards,
Ian

Cc: Johan Hovold

On 29 December 2017 at 07:04, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, 2017-12-28 at 21:55 +0200, Andy Shevchenko wrote:
>> The change restores build behaviour for old configurations when user
>> didn't know and thus didn't select SERIAL_DEV_BUS explicitly for given
>> HCI modules, such as hci_bcm.
>>
>
> +Cc: Arnd, Rob.
>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> v2: get rid of recursive dependencies
>>  drivers/bluetooth/Kconfig | 15 +++++----------
>>  1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>> index 60e1c7d6986d..ea3d114d19e5 100644
>> --- a/drivers/bluetooth/Kconfig
>> +++ b/drivers/bluetooth/Kconfig
>> @@ -66,7 +66,6 @@ config BT_HCIBTSDIO
>>
>>  config BT_HCIUART
>>       tristate "HCI UART driver"
>> -     depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
>>       depends on TTY
>>       help
>>         Bluetooth HCI UART driver.
>> @@ -78,11 +77,6 @@ config BT_HCIUART
>>         Say Y here to compile support for Bluetooth UART devices
>> into the
>>         kernel or say M to compile it as module (hci_uart).
>>
>> -config BT_HCIUART_SERDEV
>> -     bool
>> -     depends on SERIAL_DEV_BUS && BT_HCIUART
>> -     default y
>> -
>>  config BT_HCIUART_H4
>>       bool "UART (H4) protocol support"
>>       depends on BT_HCIUART
>> @@ -96,8 +90,8 @@ config BT_HCIUART_H4
>>  config BT_HCIUART_NOKIA
>>       tristate "UART Nokia H4+ protocol support"
>>       depends on BT_HCIUART
>> -     depends on BT_HCIUART_SERDEV
>>       depends on PM
>> +     select SERIAL_DEV_BUS
>>       select BT_HCIUART_H4
>>       select BT_BCM
>>       help
>> @@ -134,7 +128,8 @@ config BT_HCIUART_ATH3K
>>
>>  config BT_HCIUART_LL
>>       bool "HCILL protocol support"
>> -     depends on BT_HCIUART_SERDEV
>> +     depends on BT_HCIUART
>> +     select SERIAL_DEV_BUS
>>       help
>>         HCILL (HCI Low Level) is a serial protocol for
>> communication
>>         between Bluetooth device and host. This protocol is
>> required for
>> @@ -169,8 +164,8 @@ config BT_HCIUART_INTEL
>>  config BT_HCIUART_BCM
>>       bool "Broadcom protocol support"
>>       depends on BT_HCIUART
>> -     depends on BT_HCIUART_SERDEV
>> -     depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)
>> +     select SERIAL_DEV_CTRL_TTYPORT if !ACPI
>> +     select SERIAL_DEV_BUS
>>       select BT_HCIUART_H4
>>       select BT_BCM
>>       help
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
