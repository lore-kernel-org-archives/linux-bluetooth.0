Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Problem with re-loading hci_uart.ko on RPi3
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1442521357.52785.1519393221115@email.1und1.de>
Date: Mon, 26 Feb 2018 09:13:13 +0100
Cc: Eric Anholt <eric@anholt.net>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <EFCB8D8B-6C3E-49B7-99AD-4F6273ECA9F8@holtmann.org>
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
 <A5A8F452-4D46-4608-91B7-94AD2D84EB2A@holtmann.org>
 <1803977951.61304.1519322745731@email.1und1.de>
 <AF2188B2-D523-42B1-A402-D95B2CE1C056@holtmann.org>
 <1442521357.52785.1519393221115@email.1und1.de>
To: Stefan Wahren <stefan.wahren@i2se.com>,
        Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

>>>>> After enabling bluetooth scanning i will see these error messages periodically:
>>>>> 
>>>>> [  815.939839] Bluetooth: hci0: last event is not cmd complete (0x0f)
>>>>> [  831.302476] Bluetooth: hci0: last event is not cmd complete (0x0f)
>>>>> [  847.303953] Bluetooth: hci0: last event is not cmd complete (0x0f)
>>>>> [  863.305284] Bluetooth: hci0: last event is not cmd complete (0x0f)
>>>>> [  879.306838] Bluetooth: hci0: last event is not cmd complete (0x0f)
>>>> 
>>>> I really need to hook up the error messages into the btmon output since then we can trace where these are coming from. Anyway, can you btmon -w trace.log from before loading the module and this error showing up.
>>> 
>>> I attached the log. According to dmesg this error happend only once during the trace.
>> 
>> I will add bt_dev_err tracing to be include in btmon and that way we can figure out where that error happens. Or do you have a trace.log and dmesg -T where we can correlate it based on time.
> 
> Please look at this attachment and the following output (issue appears every 16 seconds after enabling scanning even if i use a baudrate of 115200):
> 
> 2018-02-23T14:12:52,454443+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:13:08,454601+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:13:24,453167+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:13:40,453414+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:13:56,453859+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:14:12,453864+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:14:28,453966+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:14:44,455381+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:15:00,452972+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:15:16,453733+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:15:32,453318+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:15:48,453495+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:16:04,452430+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:16:20,452531+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:16:36,452813+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 2018-02-23T14:16:52,453043+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
> 
> I also noticed a different issue (only tested 4.15 yet), sometimes if i try to unload "modprobe -r hci_uart" the command blocks forever. There is no crash just the command hangs.

so it seems that this matched up to the set scan enable command.

< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2        #415 [hci0] 2018-02-23 14:12:52.478963
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                   #416 [hci0] 2018-02-23 14:12:52.483769
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)

Does this happen with all baud rates or just with 115200?

What could be the case is that the start of inquiry is too fast and the processing internally goes bonkers.

< HCI Command: Inquiry (0x01|0x0001) plen 5                   #417 [hci0] 2018-02-23 14:12:52.484027
        Access code: 0x9e8b33 (General Inquiry)
        Length: 5.12s (0x04)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                     #418 [hci0] 2018-02-23 14:12:52.486440
      Inquiry (0x01|0x0001) ncmd 1
        Status: Success (0x00)

The inquiry command is actually answered with a command status.

Johan, any ideas?

>>>>> Btw: Linus Wallej applied the GPIO expander driver
>>>> 
>>>> That is awesome. Do you see any difference now if you hook up the GPIO in DT. Mind you to change the resources part to allow using only the shutdown GPIO and not having the device-wakeup GPIO.
>>> 
>>> The RPi Zero W doesn't have a GPIO expander and the RPi 3 also uses the BT_ON line (via GPIO expander). So i don't expect any difference between them.
>> 
>> So on the Zero W the BT_ON GPIO is exposed without the expander? And the 3 needs the expander? Is that how they are designed?
> 
> Yes. Yes. I only have the firmware devicetree file [1] as reference.
> 
> Btw there is another difference between Zero W and 3. The Zero W could uses the hardware flow-control pins, the 3 not.
> 
> How does the Broadcom BT driver know about the flow control?
> Is it sufficient to add "uart-has-rtscts"?
> 
> [1] - https://github.com/raspberrypi/firmware/blob/master/extra/dt-blob.dts#L1536

I have no answer for this, but using flow control is required for H:4 operation as far as I remember.

Regards

Marcel

