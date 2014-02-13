Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrea <mariofutire@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: partial success with PS3 sixaxis
Date: Thu, 13 Feb 2014 10:25:43 +0100
Message-ID: <2534491.XllyezJg3g@uw000953>
In-Reply-To: <52FBE820.6050701@gmail.com>
References: <52FBE820.6050701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrea,

On Wednesday 12 of February 2014 21:31:12 Andrea wrote:
> Hi,
> 
> I've been trying to pair a PS3 sixaxis controller using bluez 5.14
> I've had so far only partial success.
> 
> It connects, creates js0 and event0 devices, but after a few seconds it removes them.
> 
> The lights are always flashing.
> 
> I am on a Raspberry running ArchLinux.
> 
> This is the output of bluetoothctl
> 
> ...
> [bluetooth]# disconnect
> [CHG] Device 00:0B:EB:63:F2:62 Connected: yes
> [bluetooth]# disconnect show
> [bluetooth]# disconnect 00:0B:EB:63:F2:62
> Attempting to disconnect from 00:0B:EB:63:F2:62
> Successful disconnected
> [CHG] Device 00:0B:EB:63:F2:62 Connected: no
> [CHG] Device 00:0B:EB:63:F2:62 Connected: yes
> 
> then in dmesg I can see
> 
> [ 2745.435967] sony 0005:054C:0268.0008: Fixing up Sony Sixaxis report descriptor
> [ 2745.452105] sony 0005:054C:0268.0008: unknown main item tag 0x0
> [ 2745.471504] input: PLAYSTATION(R)3 Controller as
> /devices/platform/bcm2708_usb/usb1/1-1/1-1.3/1-1.3.1/1-1.3.1:1.0/bluetooth/hci0/hci0:11/input7
> [ 2745.472795] sony 0005:054C:0268.0008: input,hidraw0: BLUETOOTH HID v1.00 Joystick
> [PLAYSTATION(R)3 Controller] on 00:0b:0d:4c:94:a6
> [ 2755.472242] sony: probe of 0005:054C:0268.0008 failed with error -5
> 
> the hardware should be ok as it works using sixad & sixpair.
> 
> any idea what could be going wrong?
> I am not even sure if I am doing the right thing to pair, trust, connect etc... as I cannot google
> anything using bluez 5 + ps3. All the howtos are for sixad.

This should "just work". Since 5.14 there is authorization needed when DS3 is
connecting (device is not marked as trusted when connected on USB) so please
make sure you have default agent registered.

I assume you are using bluetoothctl so do:
agent on
default-agent

Then you should get authorization request in bluetoothctl when DS3 is connecting.

-- 
Best regards, 
Szymon Janc
