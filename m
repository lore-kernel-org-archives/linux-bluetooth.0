Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 2/3] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 as serial
 slave
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAL_JsqKxA2pgtjmG-cxy5XPWuRWUiia-weRZDSh4++Vn=QZmqA@mail.gmail.com>
Date: Thu, 10 Aug 2017 18:15:04 +0200
Cc: Loic Poulain <loic.poulain@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org
Message-Id: <8186E2A3-D0AC-498F-8229-78862D363F78@holtmann.org>
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com>
 <1502102366-2760-2-git-send-email-loic.poulain@gmail.com>
 <CAL_JsqKxA2pgtjmG-cxy5XPWuRWUiia-weRZDSh4++Vn=QZmqA@mail.gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob,

>> Add BCM43438 as a slave device of uart0 (pl011/ttyAMA0).
>> This allows to automatically insert the bcm43438 to the bluetooth
>> subsystem instead of relying on userspace helpers (hciattach).
>> 
>> Overwrite bootargs to use 8250 aux uart (ttyS0) as console instead
>> of pl011/ttyAMA0.
>> 
>> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
>> ---
>> v2: dt-bindings as separate patch
>>     rebase on upcoming pi3 dts changes
>> v3: changes in bcm serdev drivers:
>>     name refactoring and additional comments
>>     Add generic host_set_baudrate method
>>     Use agnostic device_property_read
>> 
>> arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> index 20725ca..5abc1df 100644
>> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> @@ -8,6 +8,11 @@
>>        compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
>>        model = "Raspberry Pi 3 Model B";
>> 
>> +       chosen {
>> +               /* 8250 auxiliar UART instead of pl011 */
>> +               bootargs = "earlyprintk console=ttyS0,115200";
> 
> This is an unrelated change. "earlyprintk" is arm32 specific and only
> works with a kernel built with a specific uart type and address. Also,
> stdout-path property is preferred to set the default over "console”.

the whole fun with the serial console on the rPI3 and the bt-miniuart overlay is something we should solve now. What is the upstream story on this since the config.txt and everything around it is confusing and also misleading since it relies on a Raspbian userspace.

Do we need to the kernel and init to stay away from the ttyAMA0 to avoid confusing the BT chip? As I mentioned earlier, I can not even get a Fedora 26 with hciattach or btattach to work.

Regards

Marcel

