Return-Path: <cyrus@holtmann.org>
Date: Wed, 09 Sep 2015 18:41:22 +1000
From: Michael Gratton <mike@vee.net>
Subject: Re: MacbookPro12,1 Bluetooth not found by Bluez
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1441788082.8206.0@mail.quuxo.net>
In-Reply-To: <8B052FF6-9EF3-4A9D-9ECA-773B40DC807E@holtmann.org>
References: <1441775933.3223.2@mail.quuxo.net>
	<8B052FF6-9EF3-4A9D-9ECA-773B40DC807E@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel,

On Wed, 9 Sep, 2015 at 3:57 PM, Marcel Holtmann <marcel@holtmann.org>=20
wrote:
>>=20
>>  Is there anything I can do to help debug this?
>=20
> check /sys/kernel/debug/usb/devices for the Bluetooth controller=20
> entry.

The following is reported there:

T: Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D02 Cnt=3D01 Dev#=3D 2 Spd=3D12 MxCh=
=3D 0
D: Ver=3D 2.01 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D 1
P: Vendor=3D05ac ProdID=3D8290 Rev=3D 0.90
S: Manufacturer=3DBroadcom Corp.
S: Product=3DBluetooth USB Host Controller
C:* #Ifs=3D 6 Cfg#=3D 1 Atr=3De0 MxPwr=3D 0mA
A: FirstIf#=3D 2 IfCount=3D 4 Cls=3Dff(vend.) Sub=3D01 Prot=3D01
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID ) Sub=3D01 Prot=3D01 Driver=3D=
usbhid
E: Ad=3D85(I) Atr=3D03(Int.) MxPS=3D 8 Ivl=3D10ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID ) Sub=3D01 Prot=3D02 Driver=3D=
usbhid
E: Ad=3D86(I) Atr=3D03(Int.) MxPS=3D 8 Ivl=3D10ms
I:* If#=3D 2 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E: Ad=3D81(I) Atr=3D03(Int.) MxPS=3D 16 Ivl=3D1ms
E: Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms
E: Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms
I:* If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 0 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 0 Ivl=3D1ms
I: If#=3D 3 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
(none)
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 9 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 9 Ivl=3D1ms
I: If#=3D 3 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
(none)
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 17 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 17 Ivl=3D1ms
I: If#=3D 3 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
(none)
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 25 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 25 Ivl=3D1ms
I: If#=3D 3 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
(none)
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 33 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 33 Ivl=3D1ms
I: If#=3D 3 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
(none)
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 49 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 49 Ivl=3D1ms
I:* If#=3D 4 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3D(none)
E: Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 32 Ivl=3D0ms
E: Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 32 Ivl=3D0ms
I:* If#=3D 5 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01 Driver=
=3D(none)


>>  Kernel logs:
[snip]
>>>  [ 10.254634] usbcore: registered new interface driver btusb
>>>  ...
>>>  [ 16.642700] usb 1-3: device descriptor read/64, error -110
>=20
> This might actually be the problem. It seems the Bluetooth controller=20
> gets detected correctly and the btusb driver loaded, but then we get=20
> some issues with the descriptor reading.
>=20
> Does the original Ubuntu 15.10 kernel work or any other kernel than=20
> 4.2-rc8. If you find a working kernel, you might need to bisect this.=20
> However my feeling is that this might be an issue in the USB host=20
> controller or somewhere else.

Just rebooted into the stock Ubuntu 4.2.0 kernel - same result. I=20
upgraded this system from 15.04, which was running 3.19, and this=20
problem existed with that version as well.

> In general all MacBook Bluetooth controllers are suppose to work. If=20
> you happen to still have OS X installed, then start it and see if it=20
> might runs a firmware upgrade for the controller.

I don't - I might be able to try it form an external hard drive over=20
the next few days however. Will report back if I do manage to.

Thanks,
//Mike

--=20
=E2=8A=A8 Michael Gratton, Percept Wrangler.
=E2=9A=99 <http://mjog.vee.net/>

=
