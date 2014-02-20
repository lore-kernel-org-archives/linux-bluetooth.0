Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrea <mariofutire@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: partial success with PS3 sixaxis
Date: Thu, 20 Feb 2014 10:47:44 +0100
Message-ID: <1484977.kC8PK9znGI@uw000953>
In-Reply-To: <52FFD116.2080902@gmail.com>
References: <52FBE820.6050701@gmail.com> <2534491.XllyezJg3g@uw000953> <52FFD116.2080902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrea,

On Saturday 15 of February 2014 20:41:58 Andrea wrote:
> On 13/02/14 09:25, Szymon Janc wrote:
> > Hi Andrea,
> > 
> > 
> > I assume you are using bluetoothctl so do:
> > agent on
> > default-agent
> > 
> > Then you should get authorization request in bluetoothctl when DS3 is connecting.
> > 
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

This is a known regression on kernels >3.9. Should be fixed in 3.15 AFAIR.

> http://pastebin.com/pExywtUk  (this is the log from bluez where LEDs keep flashing)
> http://pastebin.com/BgRUnamS  (log from sixad where LEDs are set)
> 
> Happy to provide more if it can be of any help.
> 
> Andrea
> 

-- 
Best regards, 
Szymon Janc
