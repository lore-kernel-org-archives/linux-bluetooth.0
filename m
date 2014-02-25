Return-Path: <cyrus@holtmann.org>
Message-ID: <530C995C.3060201@tauria.ee>
Date: Tue, 25 Feb 2014 15:23:40 +0200
From: Peeter Vois <peeter@tauria.ee>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: BUG REPORT: Bluetooth LE HID keyboard key stays pressed when device
 disappears
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everybody !

First of all thanks for the bluez library and hid over gatt profile. I 
am developping a special purpuse keyboard and am using Linux as test 
platform. There is not much of the systems available for real life 
testing and luckily Linux does work well.

While developping, my firmware is ofcourse buggy and this helped me to 
uncover one of the bluez HoG profile feature that will have unpleasant 
result- the key stays pressed when bluetooth device disappears.

1. My device is sending key press, release and/or anotherkey press 
notification when something happens with the keyboard.
2. It is possible that my device will disappear after sending key press 
event. So far I have seen debug trap causing such thing- after the key 
press is sent, the firmware stops working. I believe such situation can 
happen even with firmware that does function correctly. I can imagine 
sudden power loss / battery failure e.t.c.
3. The result will be, that the key stays pressed and repeated entry 
will run where ever the keyboard focus will be placed.
4. By killing bluetoothd, the key will be released.

I believe the situation is rather complex, as the keyboard is not the 
only HID device possible. I will be available if needed.

I am using bluez-5.14-1.fc20.x86_64
and kernel-3.13.3-201.fc20.x86_64
at the moment.

Best Regards ...

-- 
Lugupidamisega
   Peeter Vois <tauria@tauria.ee>
   mobiil: +372 55611689
   Tauria OÜ
   juhatuse liige

