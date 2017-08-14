Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 2/3] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 as serial
 slave
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <e001e055-10a5-facd-a8e1-57c1bdb78172@gmail.com>
Date: Tue, 15 Aug 2017 00:16:31 +0200
Cc: Rob Herring <robh+dt@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org
Message-Id: <FCD47ED6-F01F-4921-97A3-BBC1D0263747@holtmann.org>
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com>
 <1502102366-2760-2-git-send-email-loic.poulain@gmail.com>
 <CAL_JsqKxA2pgtjmG-cxy5XPWuRWUiia-weRZDSh4++Vn=QZmqA@mail.gmail.com>
 <8186E2A3-D0AC-498F-8229-78862D363F78@holtmann.org>
 <392e6d51-33d6-1585-6582-1397a0c64852@gmail.com>
 <161632C7-EBBF-47F5-86DC-453E10395B54@holtmann.org>
 <e001e055-10a5-facd-a8e1-57c1bdb78172@gmail.com>
To: Loic Poulain <loic.poulain@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

>>>>>> Add BCM43438 as a slave device of uart0 (pl011/ttyAMA0).
>>>>>> This allows to automatically insert the bcm43438 to the bluetooth
>>>>>> subsystem instead of relying on userspace helpers (hciattach).
>>>>>> 
>>>>>> Overwrite bootargs to use 8250 aux uart (ttyS0) as console instead
>>>>>> of pl011/ttyAMA0.
>>>>>> 
>>>>>> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
>>>>>> ---
>>>>>> v2: dt-bindings as separate patch
>>>>>>     rebase on upcoming pi3 dts changes
>>>>>> v3: changes in bcm serdev drivers:
>>>>>>     name refactoring and additional comments
>>>>>>     Add generic host_set_baudrate method
>>>>>>     Use agnostic device_property_read
>>>>>> 
>>>>>> arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
>>>>>> 1 file changed, 10 insertions(+)
>>>>>> 
>>>>>> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>>>>>> index 20725ca..5abc1df 100644
>>>>>> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>>>>>> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>>>>>> @@ -8,6 +8,11 @@
>>>>>>        compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
>>>>>>        model = "Raspberry Pi 3 Model B";
>>>>>> 
>>>>>> +       chosen {
>>>>>> +               /* 8250 auxiliar UART instead of pl011 */
>>>>>> +               bootargs = "earlyprintk console=ttyS0,115200";
>>>>> This is an unrelated change. "earlyprintk" is arm32 specific and only
>>>>> works with a kernel built with a specific uart type and address. Also,
>>>>> stdout-path property is preferred to set the default over "console”.
>>> I'm going to use stdout-path according to your comment.
>>> However one of the goals was to overwrite the bcm283x.dtsi bootargs,
>>> I assume the same comment apply on the dtsi (stdpath usage /earlyprintk)
>>> which should require update too.
>>> 
>>>> the whole fun with the serial console on the rPI3 and the bt-miniuart overlay is something we should solve now. What is the upstream story on this since the config.txt and everything around it is confusing and also misleading since it relies on a Raspbian userspace.
>>>> 
>>>> Do we need to the kernel and init to stay away from the ttyAMA0 to avoid confusing the BT chip? As I mentioned earlier, I can not even get a Fedora 26 with hciattach or btattach to work.
>>>> 
>>> It is also possible to mux the auxiliary mini UART to drive the Bluetooth
>>> controller in order to keep ttyAMA0 as the "legacy" RPi ext-uart/console,
>>> however SoC spec says that this mini UART is intented to be used mainly as
>>> a console due to shallow FIFOs and no DMA.
>> what upstream kernel tree did you test this with? On a Fedora 26 kernel (now 4.12 based), I still do not have the Bluetooth hardware working.
>> 
>> Regards
>> 
>> Marcel
>> 
> 
> I built kernel, modules and dtb from a bluetooth-next tree (4.12 and 4.13-rc3).
> Using 32-bit multi_v7_defconfig + some additional confs to enable miniuart (BCM2835AUX...) for console.
> I push this on a raspbian image.
> 
> my boot/config.txt is very simple (no overlay):
> 
> kernel=zImage
> device_tree=bcm2837-rpi-3-b.dtb
> # hack for miniuart serial clock
> core_freq=250
> dtparam=audio=on

so the Fedora 26 kernel that is based on 4.12 is missing uart0 configuration in DT. Adding it to bcm2837-rpi-3-b.dts will allow for btattach to actually work.

&uart0 {
	pinctrl-names = "default";
	pinctrl-0 = <&uart0_gpio32 &gpclk2_gpio43>;
	status = "okay”;
};

It kinda works, but not all of it. This command confuses me.

< HCI Command: Broadcom Write UART Clock Setting (0x3f|0x0045) plen 1
        01                                               .               
> HCI Event: Command Complete (0x0e) plen 4
      Broadcom Write UART Clock Setting (0x3f|0x0045) ncmd 1
        Status: Unknown HCI Command (0x01)

And I am seeing fun stuff like failed frame assembly.

[  888.687594] Bluetooth: hci0: BCM: chip id 94
[  888.687821] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0182
[  892.059023] Bluetooth: hci0: Frame reassembly failed (-84)
[  892.316936] Bluetooth: hci0: BCM: failed to write clock (-56)
[  892.429478] Bluetooth: hci0: BCM (001.002.009) build 0182

Actually not providing the firmware makes the controller work. It however is stuck ad AA:AA:.. default address. Providing the firmware turns the address active. However then it never completes.

Regards

Marcel

