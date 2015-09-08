Return-Path: <cyrus@holtmann.org>
Subject: Re: iOS 8 can't discover device
To: Kyle Shneider <shneiderkyle@gmail.com>,
	linux-bluetooth@vger.kernel.org
References: <CAMib2GZpa=FgsNKXThWnNZ=m=nQgLJj8j1bYd8v12vb1dwOLNg@mail.gmail.com>
 <55ED3BFA.206@ubnt.com>
 <CAMib2GZ1D_Pp_m6qLMitzjAo7vS6Hrq1q9uaeAWg4zUYvj4u0w@mail.gmail.com>
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
Message-ID: <55EE7672.1040406@ubnt.com>
Date: Tue, 8 Sep 2015 08:47:30 +0300
MIME-Version: 1.0
In-Reply-To: <CAMib2GZ1D_Pp_m6qLMitzjAo7vS6Hrq1q9uaeAWg4zUYvj4u0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 09/07/2015 07:47 PM, Kyle Shneider wrote:
> 2015-09-07 10:25 GMT+03:00 Andrejs Hanins <andrejs.hanins@ubnt.com>:
>>
>> Hi Kyle,
>>
>> On 09/06/2015 05:23 PM, Kyle Shneider wrote:
>>> Hello again.
>>>
>>> I'm testing bluez 5.33 on raspberry pi. After successfully launching
>>> bluetoothd, powering hci-device up and setting it 'Discoverable' (done
>>> through DBus API) iPad mini can't see it. In other way shitty android
>>> 4.1.1 tablet finds raspberry in a moment.
>>> Have i missed something?
>> iOS will only show you devices which implement at least one of the Bluetooth profiles supported by iOS (https://support.apple.com/en-us/HT204387).
>> So you need to have appropriate SDP record with supported profile. I would suggest to start with org.bluez.ProfileManager1 D-Bus interface.
>>> Did anyone have successful experience of pairing apple devices and
>>> latest versions of bluez?
>>> BTW ble adapter: cambridge silicon radio.
>>>
> 
> 
> Thanks for the answer Andrejs.
> I don't understand. What about GATT profile?
I think, it is the same - you need to advertise a service supported by iOS in order for the BLE device to appear in standard iOS Bluetooth device list. However, if you write your own app, there is an access to all BLE devices seen around.
Can iOS device initialize
> pairing via GATT profile?
Yes. It worked for me when I tried something like kernel 3.19 and BlueZ 5.32 or so. I was using LightBlue app for my testing.
> 
