Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <C283C351-9806-44B8-A2E5-0B0B377156F9@holtmann.org>
References: <20170419175051.4177480-1-arnd@arndb.de> <20170420001534.ecnkaqlk652thya7@earth>
 <C283C351-9806-44B8-A2E5-0B0B377156F9@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Apr 2017 09:02:19 +0200
Message-ID: <CAK8P3a2ZVZ_LjnNiVM-_ew-jR6=DyAjUhtU6do+sgAQv21kbJQ@mail.gmail.com>
Subject: Re: [PATCH] blutooth: try to improve CONFIG_SERIAL_DEV_BUS dependency
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Sebastian Reichel <sre@kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>, "David S. Miller" <davem@davemloft.net>,
	Kalle Valo <kvalo@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Apr 20, 2017 at 8:55 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Sebastian,
>
>>> With CONFIG_SERIAL_DEV_BUS=m, the hci_serdev.o file does not actually
>>> get built into hci_uart.o as the Makefile doesn't pick it up, leading
>>> to a link error with anything referring to it:
>>>
>>> ERROR: "hci_uart_register_device" [drivers/bluetooth/hci_nokia.ko] undefined!
>>> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
>>>
>>> Changing this in the Makefile would cause another problem when
>>> hci_uart itself is built-in and cannot reference symbols from the
>>> serdev module.
>>>
>>> This tries to address both problems by introducing a new hidden
>>> Kconfig symbol that controls both the compilation of hci_serdev.o
>>> and whether the Nokia driver can be selected. This seems to address
>>> the problem for me, though there might be a better way to do it.
>>>
>>> Fixes: 7bb318680e86 ("Bluetooth: add nokia driver")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>> drivers/bluetooth/Kconfig  | 8 +++++++-
>>> drivers/bluetooth/Makefile | 2 +-
>>> 2 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>>> index 8aafbed9e160..737d93ef27c5 100644
>>> --- a/drivers/bluetooth/Kconfig
>>> +++ b/drivers/bluetooth/Kconfig
>>> @@ -76,6 +76,12 @@ config BT_HCIUART
>>>        Say Y here to compile support for Bluetooth UART devices into the
>>>        kernel or say M to compile it as module (hci_uart).
>>>
>>> +config BT_HCIUART_SERDEV
>>> +    bool
>>> +    depends on SERIAL_DEV_BUS && BT_HCIUART
>>> +    depends on SERIAL_DEV_BUS=y || SERIAL_DEV_BUS=BT_HCIUART
>>> +    default y
>>> +
>>> config BT_HCIUART_H4
>>>      bool "UART (H4) protocol support"
>>>      depends on BT_HCIUART
>>> @@ -89,7 +95,7 @@ config BT_HCIUART_H4
>>> config BT_HCIUART_NOKIA
>>>      tristate "UART Nokia H4+ protocol support"
>>>      depends on BT_HCIUART
>>
>> I guess BT_HCIUART dependency is no longer needed
>> when we have BT_HCIUART_SERDEV dependency?
>
> if so then we need another patch since I already applied the one from Arnd.

We need both dependencies: BT_HCIUART_SERDEV is a 'bool'
symbol controlling whether subdrivers are able to use symbols
exported by the serdev code, while BT_HCIUART is a tristate
symbol and we need to depend on that to ensure that
BT_HCIUART_NOKIA cannot be set to '=y' when
BT_HCIUART=m.

No further patch should be needed.

    Arnd
