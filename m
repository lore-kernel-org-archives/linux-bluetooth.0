Return-Path: <cyrus@holtmann.org>
Message-ID: <52FFD2DE.90709@gmail.com>
Date: Sat, 15 Feb 2014 20:49:34 +0000
From: Andrea <mariofutire@gmail.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: partial success with PS3 sixaxis
References: <52FBE820.6050701@gmail.com> <2534491.XllyezJg3g@uw000953> <52FFD116.2080902@gmail.com>
In-Reply-To: <52FFD116.2080902@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 15/02/14 20:41, Andrea wrote:
> On 13/02/14 09:25, Szymon Janc wrote:
>> Hi Andrea,
>>
>>
>> I assume you are using bluetoothctl so do:
>> agent on
>> default-agent
>>
>> Then you should get authorization request in bluetoothctl when DS3 is connecting.
>>
> 
> Hi,
> 
> I have tried on a different laptop (no more the raspberry pi, where I still have the issues I
> reported in the other email), running Fedora 19.
> 
> I compiled bluez 5.14 and run it.
> It is more stable and /dev/input/js0 is usable.
> 
> It is still not able to set the LEDs. This gets written in the output
> 
> Feb 15 16:55:02 localhost.localdomain bluetoothd[24620]: sixaxis: compatible device connected:
> PLAYSTATION(R)3 Contr
> Feb 15 16:55:02 localhost.localdomain kernel: input: PLAYSTATION(R)3 Controller as
> /devices/pci0000:00/0000:00:1d.1/
> Feb 15 16:55:02 localhost.localdomain kernel: sony 0005:054C:0268.000E: input,hidraw0: BLUETOOTH HID
> v1.00 Joystick
> Feb 15 16:55:02 localhost.localdomain bluetoothd[24620]: sixaxis: failed to set LEDS (0 bytes written)
> 
> I have tried to log the traffic for bluez and sixad (where the LEDs work), to see you can find any
> difference.
> 
> http://pastebin.com/pExywtUk  (this is the log from bluez where LEDs keep flashing)
> http://pastebin.com/BgRUnamS  (log from sixad where LEDs are set)
> 
> Happy to provide more if it can be of any help.
> 
> Andrea
> 

and this is the log from bluez 5.14 running on raspberry pi
where /dev/input/js0 disappears after a few seconds.

http://pastebin.com/Rxsv3php

Andrea

