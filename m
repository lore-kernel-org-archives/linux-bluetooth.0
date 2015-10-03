Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMib2GZ9+KecnYU4Dp1QhTh-XCF_6Gr761+rnu5yF=8BesgpFA@mail.gmail.com>
References: <CAMib2GZpa=FgsNKXThWnNZ=m=nQgLJj8j1bYd8v12vb1dwOLNg@mail.gmail.com>
	<55ED3BFA.206@ubnt.com>
	<CAMib2GZ1D_Pp_m6qLMitzjAo7vS6Hrq1q9uaeAWg4zUYvj4u0w@mail.gmail.com>
	<55EE7672.1040406@ubnt.com>
	<CAMib2GZ9+KecnYU4Dp1QhTh-XCF_6Gr761+rnu5yF=8BesgpFA@mail.gmail.com>
Date: Sat, 3 Oct 2015 19:06:05 +0300
Message-ID: <CAMib2GbppUBtTbWV9JkGTm95KyxUeywU8c=E6g2-PJk6FBrZYA@mail.gmail.com>
Subject: Fwd: iOS 8 can't discover device
From: Kyle Shneider <shneiderkyle@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2015-09-08 8:47 GMT+03:00 Andrejs Hanins <andrejs.hanins@ubnt.com>:
> Hi,
>
> On 09/07/2015 07:47 PM, Kyle Shneider wrote:
>> 2015-09-07 10:25 GMT+03:00 Andrejs Hanins <andrejs.hanins@ubnt.com>:
>>>
>>> Hi Kyle,
>>>
>>> On 09/06/2015 05:23 PM, Kyle Shneider wrote:
>>>> Hello again.
>>>>
>>>> I'm testing bluez 5.33 on raspberry pi. After successfully launching
>>>> bluetoothd, powering hci-device up and setting it 'Discoverable' (done
>>>> through DBus API) iPad mini can't see it. In other way shitty android
>>>> 4.1.1 tablet finds raspberry in a moment.
>>>> Have i missed something?
>>> iOS will only show you devices which implement at least one of the Bluetooth profiles supported by iOS (https://support.apple.com/en-us/HT204387).
>>> So you need to have appropriate SDP record with supported profile. I would suggest to start with org.bluez.ProfileManager1 D-Bus interface.
>>>> Did anyone have successful experience of pairing apple devices and
>>>> latest versions of bluez?
>>>> BTW ble adapter: cambridge silicon radio.
>>>>
>>
>>
>> Thanks for the answer Andrejs.
>> I don't understand. What about GATT profile?
> I think, it is the same - you need to advertise a service supported by iOS in order for the BLE device to appear in standard iOS Bluetooth device list. However, if you write your own app, there is an access to all BLE devices seen around.
> Can iOS device initialize
>> pairing via GATT profile?
> Yes. It worked for me when I tried something like kernel 3.19 and BlueZ 5.32 or so. I was using LightBlue app for my testing.
>>

So after installing latest kernel 4.1.8 problem doesn't solved for me.
On raspberry i launch:
- bluetoothd -nE
- bluez-5.34/test/test-gatt-profile
- bluez-5.34/test/example-gatt-server
- bluez-5.34/test/simple-agent

Neither iOS LightBlue application can't see raspberry nor Android BLE
scanner. Have i missed something?

--
Kyle Shneider


-- 
Kyle Shneider
