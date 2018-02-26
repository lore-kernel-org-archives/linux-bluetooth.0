Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Problem with re-loading hci_uart.ko on RPi3
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <cd554013-24f1-eb73-f7af-8500141c0f44@i2se.com>
Date: Mon, 26 Feb 2018 14:59:26 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <18BCD856-1823-4B79-BA77-BFD2663C236E@holtmann.org>
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
 <EFCB8D8B-6C3E-49B7-99AD-4F6273ECA9F8@holtmann.org>
 <cd554013-24f1-eb73-f7af-8500141c0f44@i2se.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

>>>>>>> After enabling bluetooth scanning i will see these error messages periodically:
>>>>>>> 
>>>>>>> [  815.939839] Bluetooth: hci0: last event is not cmd complete (0x0f)
>>>>>>> [  831.302476] Bluetooth: hci0: last event is not cmd complete (0x0f)
>>>>>>> [  847.303953] Bluetooth: hci0: last event is not cmd complete (0x0f)
>>>>>>> [  863.305284] Bluetooth: hci0: last event is not cmd complete (0x0f)
>>>>>>> [  879.306838] Bluetooth: hci0: last event is not cmd complete (0x0f)
>>>>>> I really need to hook up the error messages into the btmon output since then we can trace where these are coming from. Anyway, can you btmon -w trace.log from before loading the module and this error showing up.
>>>>> I attached the log. According to dmesg this error happend only once during the trace.
>>>> I will add bt_dev_err tracing to be include in btmon and that way we can figure out where that error happens. Or do you have a trace.log and dmesg -T where we can correlate it based on time.
>>> Please look at this attachment and the following output (issue appears every 16 seconds after enabling scanning even if i use a baudrate of 115200):
>>> 
>>> 2018-02-23T14:12:52,454443+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:13:08,454601+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:13:24,453167+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:13:40,453414+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:13:56,453859+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:14:12,453864+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:14:28,453966+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:14:44,455381+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:15:00,452972+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:15:16,453733+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:15:32,453318+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:15:48,453495+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:16:04,452430+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:16:20,452531+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:16:36,452813+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 2018-02-23T14:16:52,453043+0100 Bluetooth: hci0: last event is not cmd complete (0x0f)
>>> 
>>> I also noticed a different issue (only tested 4.15 yet), sometimes if i try to unload "modprobe -r hci_uart" the command blocks forever. There is no crash just the command hangs.
>> so it seems that this matched up to the set scan enable command.
> Hm, i only enabled the scanning once. Does bluetoothctl send this command periodically every 16 seconds?

yes, it does interleaved scanning on LE and then BR/EDR. Hence the switch from LE Set Scan Enable to Inquiry etc.

>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2        #415 [hci0] 2018-02-23 14:12:52.478963
>>         Scanning: Disabled (0x00)
>>         Filter duplicates: Disabled (0x00)
>>> HCI Event: Command Complete (0x0e) plen 4                   #416 [hci0] 2018-02-23 14:12:52.483769
>>       LE Set Scan Enable (0x08|0x000c) ncmd 1
>>         Status: Success (0x00)
>> 
>> Does this happen with all baud rates or just with 115200?
> 
> I've seen this at 115200 and 2000000 baud.

This could be well our issue. I need to check if I can reproduce it.

I assume you use bluetoothctl for enabling scanning. Wonder what happens if you do it only on LE. So “menu scan” and then “transport le”. I think it is really just the switch from LE to BR/EDR where this happens.

Regards

Marcel

