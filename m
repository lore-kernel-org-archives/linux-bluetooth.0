Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6874A094-FC92-47DD-B624-3CADAE801D27@comcast.net>
References: <6874A094-FC92-47DD-B624-3CADAE801D27@comcast.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 16 Sep 2016 15:05:20 +0300
Message-ID: <CABBYNZ+N-+f2dQigQH-voeRCHLM72sHHbp+bVOcgABR_5nyeSg@mail.gmail.com>
Subject: Re: Android 7.0 not discovering LE services
To: Wilson <griscruf@comcast.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wilson,

On Fri, Sep 16, 2016 at 2:02 PM, Wilson <griscruf@comcast.net> wrote:
> Hello, I have found a problem using Android 7.0 to connect to a bluez dev=
ice over BLE.  Android 6.0.1 is working.  Android 7 definitely changed some=
 things, but it is working with other (embedded) stacks like Wicentric and =
Searan.  I first found the problem on bluez 5.37 and linux 3.14, but I stil=
l see it on bluez 5.41 and linux 4.4.0 (Ubuntu 16.04 on a Mac mini).  I als=
o tried the latest bluez in git.
>
> I'm running nRF Connect on the Android devices.  I captured (latest) blue=
toothd and btmon logs for both cases:
>
> Android6 bluetoothd: https://paste.gnome.org/pfkliqrqw
> Android6 btmon:        https://paste.gnome.org/pcyxvla79
>
> Android7 bluetoothd: https://paste.gnome.org/pk4qj6wp8
> Android7 btmon:        https://paste.gnome.org/p5e4fgoua

Both seems to be connecting over BR/EDR and only finding GAP and GATT
primary service so I wonder if you do have anything else registered
there?

> Using Android 6 I'm able to connect and "Refresh device cache" as much as=
 I want and then disconnect.  All the logs are shown clean in bluetoothd an=
d nRF Connect is fast.  However, using Android 7, I'm only able to connect =
and the cached services come up.  If I refresh services, bluetoothd logs sh=
ow them read:
>
>         bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - start:=
 0x0001 end: 0x0005
>         bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - start:=
 0x0001 end: 0x0005
>         bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - start:=
 0x0005 end: 0x0005
>         bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - start:=
 0x0006 end: 0x0009
>         bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - start:=
 0x0006 end: 0x0009
>         bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - start:=
 0x0008 end: 0x0009
>         bluetoothd[2346]: src/device.c:gatt_debug() Find Info - start: 0x=
0009 end: 0x0009
>
> but then nRF Connect is hung spinning.  Disconnect does nothing.  There a=
re some differences in the logs but one major thing of note is at the end o=
f the initial connection by Android 7 there is this:
>
>         src/gatt-database.c:gatt_ccc_write_cb() CCC write called for hand=
le: 0x0009
>
> Is this a problem?

I guess not, this must be for Service Changed which is normally subscribed.

> Is a problem like this likely a bluetoothd problem or something in the li=
nux driver?
>
> One thing I've noticed in OTA captures is that bluez, which is the slave,=
 is requesting services from the master.  In my application I do not have t=
he need for this.  It might help (might not) if I could disable this, and i=
t would make the capture more clear.  Is it possible to disable this?

Well in GATT we can assume both roles, in fact some of the services do
actually have useful information for the stack to read automatically
like the device name for example, but I do recall Android having
problems with that but that perhaps was related to MTU Exchange being
sent over BR/EDR which was fixed recently.

--=20
Luiz Augusto von Dentz
