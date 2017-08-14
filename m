Return-Path: <loic.poulain@gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 as serial
 slave
To: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh+dt@kernel.org>,
 Stefan Wahren <stefan.wahren@i2se.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 linux-rpi-kernel@lists.infradead.org
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com>
 <1502102366-2760-2-git-send-email-loic.poulain@gmail.com>
 <CAL_JsqKxA2pgtjmG-cxy5XPWuRWUiia-weRZDSh4++Vn=QZmqA@mail.gmail.com>
 <8186E2A3-D0AC-498F-8229-78862D363F78@holtmann.org>
From: Loic Poulain <loic.poulain@gmail.com>
Message-ID: <392e6d51-33d6-1585-6582-1397a0c64852@gmail.com>
Date: Mon, 14 Aug 2017 15:56:56 +0200
MIME-Version: 1.0
In-Reply-To: <8186E2A3-D0AC-498F-8229-78862D363F78@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob, Marcel,


> Hi Rob,
>
>>> Add BCM43438 as a slave device of uart0 (pl011/ttyAMA0).
>>> This allows to automatically insert the bcm43438 to the bluetooth
>>> subsystem instead of relying on userspace helpers (hciattach).
>>>
>>> Overwrite bootargs to use 8250 aux uart (ttyS0) as console instead
>>> of pl011/ttyAMA0.
>>>
>>> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
>>> ---
>>> v2: dt-bindings as separate patch
>>>      rebase on upcoming pi3 dts changes
>>> v3: changes in bcm serdev drivers:
>>>      name refactoring and additional comments
>>>      Add generic host_set_baudrate method
>>>      Use agnostic device_property_read
>>>
>>> arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
>>> 1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>>> index 20725ca..5abc1df 100644
>>> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>>> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>>> @@ -8,6 +8,11 @@
>>>         compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
>>>         model = "Raspberry Pi 3 Model B";
>>>
>>> +       chosen {
>>> +               /* 8250 auxiliar UART instead of pl011 */
>>> +               bootargs = "earlyprintk console=ttyS0,115200";
>> This is an unrelated change. "earlyprintk" is arm32 specific and only
>> works with a kernel built with a specific uart type and address. Also,
>> stdout-path property is preferred to set the default over "console”.
I'm going to use stdout-path according to your comment.
However one of the goals was to overwrite the bcm283x.dtsi bootargs,
I assume the same comment apply on the dtsi (stdpath usage /earlyprintk)
which should require update too.

> the whole fun with the serial console on the rPI3 and the bt-miniuart overlay is something we should solve now. What is the upstream story on this since the config.txt and everything around it is confusing and also misleading since it relies on a Raspbian userspace.
>
> Do we need to the kernel and init to stay away from the ttyAMA0 to avoid confusing the BT chip? As I mentioned earlier, I can not even get a Fedora 26 with hciattach or btattach to work.
>

It is also possible to mux the auxiliary mini UART to drive the Bluetooth
controller in order to keep ttyAMA0 as the "legacy" RPi ext-uart/console,
however SoC spec says that this mini UART is intented to be used mainly as
a console due to shallow FIFOs and no DMA.

Regards,
Loic
