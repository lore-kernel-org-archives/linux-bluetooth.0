Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <43820E05-9D40-4470-AE6C-B7B6C705E0A5@holtmann.org>
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com>
 <1502102366-2760-2-git-send-email-loic.poulain@gmail.com> <43820E05-9D40-4470-AE6C-B7B6C705E0A5@holtmann.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 15 Aug 2017 14:12:19 -0500
Message-ID: <CAL_Jsq+WJDxghCwBzo2SyShEp56k_RWtN=6NHQyVAfC=QQibPA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 as serial slave
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Loic Poulain <loic.poulain@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>,
	devicetree <devicetree@vger.kernel.org>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 15, 2017 at 8:06 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Rob,
>
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
>> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/b=
cm2837-rpi-3-b.dts
>> index 20725ca..5abc1df 100644
>> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> @@ -8,6 +8,11 @@
>>       compatible =3D "raspberrypi,3-model-b", "brcm,bcm2837";
>>       model =3D "Raspberry Pi 3 Model B";
>>
>> +     chosen {
>> +             /* 8250 auxiliar UART instead of pl011 */
>> +             bootargs =3D "earlyprintk console=3DttyS0,115200";
>> +     };
>> +
>>       memory {
>>               reg =3D <0 0x40000000>;
>>       };
>> @@ -24,6 +29,11 @@
>>       pinctrl-names =3D "default";
>>       pinctrl-0 =3D <&uart0_gpio32 &gpclk2_gpio43>;
>>       status =3D "okay";
>> +
>> +     bluetooth {
>> +             compatible =3D "brcm,bcm43438-bt";
>> +             max-speed =3D <921600>;
>> +     };
>> };
>
> I know that hci_ll.c DT entry also uses max-speed for the naming. Is this=
 something common we should be doing? Essentially it is not really max-spee=
d. It is the operational speed that we are configuring. There is no down ne=
gotiation ongoing. Does it make sense to use oper-speed instead?

max-speed is correct to use. By default, a driver should know the max
speed of a device (implied by the compatible). The DT property is only
for when there is some host or board limitation as this case seems to
be.

> Are we otherwise fine with compatible string naming?

Yes.

Rob

>
> Loic, the hciattach examples list 3000000 as operational speed. Any reaso=
n why we should limit it?
>
> Regards
>
> Marcel
>
