Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Problem with re-loading hci_uart.ko on RPi3
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2139019758.47998.1519309583130@email.1und1.de>
Date: Thu, 22 Feb 2018 16:43:47 +0100
Cc: Eric Anholt <eric@anholt.net>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <A5A8F452-4D46-4608-91B7-94AD2D84EB2A@holtmann.org>
References: <E4785C91-043A-4FF5-BFCA-5FADAFF81EE5@holtmann.org>
 <1941091231.91372.1518962068876@email.1und1.de>
 <414BD031-1C2F-4E27-BBB4-BEB9F71B099F@holtmann.org>
 <76f76129-dd3e-2d17-635d-18a563d12aa8@gmail.com>
 <f94056a0-ece7-c579-6b7d-d6589079d9e6@i2se.com>
 <E39D4C6D-90AC-426A-BA98-02EE4F78E14C@holtmann.org>
 <1290800239.153918.1519064893302@email.1und1.de>
 <25DCE32D-EDDA-40AC-B75C-133F1338A5D9@holtmann.org>
 <1332560657.154293.1519066383196@email.1und1.de>
 <68D82C47-F3AE-4E03-A687-A13F4F927310@holtmann.org>
 <2139019758.47998.1519309583130@email.1und1.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

>>>>>>>>>>> One option is of course to keep the max-speed in the DT at 115200 Mbps. It would work, but seriously slow down the transport. Maybe this should be done until we get access to the GPIOs.
>>>>>>>>> So I am convinced when we run on hardware that has no GPIO resources exposed (as it is with RPi right now), we should limit the operational speed to the initialization speed. And then my problem actually goes away. It also forces people to get the GPIOs exposed or they have to stick with a slower HCI transport.
>>>>>>>> 
>>>>>>>> We may also reset to initialization speed on module unload.
>>>>>>>> This will allow multiple tests on the hardware, even if it does not have GPIOs exposed.
>>>>>>> 
>>>>>>> I prefer this solution instead of coding workarounds within the devicetree.
>>>>>> 
>>>>>> DT is actually for encoding workarounds for the hardware. If the GPIOs are not exposed, we are actually limited. However I am going to do that in the hci_bcm.c driver itself since it is a more wider problem. If the GPIO resources are not available, the device will actually not function. This is actually a valid assumption for all hardwired Bluetooth chips. They all have some GPIO or power control option. The only reason to not have GPIOs would be external development boards. So the RPi with the not exposed GPIOs is kinda broken hardware right now. That we got this far supporting Bluetooth on it has to be considered pure luck :)
>>>>> 
>>>>> only to make sure that we talking about the same, please take a look at my attempt for the RPi Zero W [1].
>>>>> 
>>>>> Using the BT_ON signal as shutdown-gpio is not enough? I'm sorry i didn't test the reload case yet.
>>>>> 
>>>>> So after the implementation of the RPI firmware expander driver, we still need this baudrate limitiation?
>>>>> 
>>>>> Btw Baruch said that he will send a new version of his patch series soon.
>>>>> 
>>>>> [1] - https://github.com/lategoodbye/rpi-zero/commit/e3085c093e56364a69f2e32d35827635b95cf966
>>>> 
>>>> before you include "shutdown-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;” we might need to figure out on how the BT_ON GPIO is working and what it is suppose to be doing. But otherwise the patch fro the Zero W looks right to me.
>>>> 
>>>> Also keep in mind that the current 4.16-rc2 kernel will require the shutdown-gpios and device-wakeup-gpios both to be available. We have not yet tested this when only shutdown-gpios is available. You might need to modify bcm_get_resources and bcm_gpio_set_power to test this out.
>>> 
>>> i think this contradicts to the binding documentation, which defines both as optional.
>> 
>> the 4.15 kernel might be fine actually while the support for Apple hardware with Broadcom UART devices might have accidentally required this now. Maybe you just want to hack your kernel and see how it goes when just having the shutdown-gpios available.
>> 
>> I am super curious if the firmware resets and falls back to the ROM state or if something is actually kept.
> 
> since i don't have any schematics about the BT part, i simply retested my patches against 4.15 on RPi Zero W.
> 
> modprobe -r hci_uart
> modprobe hci_uart
> 
> works without any issues:
> 
> [  233.486208] Bluetooth: HCI UART driver ver 2.3
> [  233.486258] Bluetooth: HCI UART protocol H4 registered
> [  233.487189] hci_uart_bcm serial0-0: BCM irq: -22
> [  233.488382] Bluetooth: HCI UART protocol Broadcom registered
> [  233.641217] Bluetooth: hci0: BCM: chip id 94
> [  233.642081] Bluetooth: hci0: BCM: features 0x2e
> [  233.644283] Bluetooth: hci0: BCM43430A1
> [  233.644321] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
> [  234.360569] Bluetooth: hci0: BCM (001.002.009) build 0325
> 
> After enabling bluetooth scanning i will see these error messages periodically:
> 
> [  815.939839] Bluetooth: hci0: last event is not cmd complete (0x0f)
> [  831.302476] Bluetooth: hci0: last event is not cmd complete (0x0f)
> [  847.303953] Bluetooth: hci0: last event is not cmd complete (0x0f)
> [  863.305284] Bluetooth: hci0: last event is not cmd complete (0x0f)
> [  879.306838] Bluetooth: hci0: last event is not cmd complete (0x0f)

I really need to hook up the error messages into the btmon output since then we can trace where these are coming from. Anyway, can you btmon -w trace.log from before loading the module and this error showing up.

> Btw: Linus Wallej applied the GPIO expander driver

That is awesome. Do you see any difference now if you hook up the GPIO in DT. Mind you to change the resources part to allow using only the shutdown GPIO and not having the device-wakeup GPIO.

Also let me guess, 4.15 is fine, but 4.16-rc1 or later fails because of the Apple changes.

Regards

Marcel

