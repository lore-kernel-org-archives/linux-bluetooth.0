Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Sep 2015 14:10:43 +1000
From: Michael Gratton <mike@vee.net>
Subject: Re: MacbookPro12,1 Bluetooth not found by Bluez
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1441858243.5491.0@mail.quuxo.net>
In-Reply-To: <CF352616-2132-4266-92B6-4F643C69BE5D@holtmann.org>
References: <1441775933.3223.2@mail.quuxo.net>
	<8B052FF6-9EF3-4A9D-9ECA-773B40DC807E@holtmann.org>
	<1441788082.8206.0@mail.quuxo.net>
	<CF352616-2132-4266-92B6-4F643C69BE5D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 10 Sep, 2015 at 1:21 AM, Marcel Holtmann <marcel@holtmann.org>=20
wrote:
>>=20
>>  T: Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D02 Cnt=3D01 Dev#=3D 2 Spd=3D12 Mx=
Ch=3D 0
>>  D: Ver=3D 2.01 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D 1
>>  P: Vendor=3D05ac ProdID=3D8290 Rev=3D 0.90
>>  S: Manufacturer=3DBroadcom Corp.
>>  S: Product=3DBluetooth USB Host Controller
[snip]
>=20
> okay, this is new. Is this by any chance the new Broadwell based=20
> MacBook Pro from beginning of the year?

Yep, it sure is - has an i7-5557U Broadwell-U SoC.

>>>  In general all MacBook Bluetooth controllers are suppose to work.=20
>>> If you happen to still have OS X installed, then start it and see=20
>>> if it might runs a firmware upgrade for the controller.
>>=20
>>  I don't - I might be able to try it form an external hard drive=20
>> over the next few days however. Will report back if I do manage to.
>=20
> If you can, then that would be great, however I assume that with the=20
> new Broadwell designs they have picked new Broadcom controllers and=20
> instead of hiding behind an internal USB hub, the devices are=20
> multi-function devices with HID and Bluetooth combined into a single=20
> USB device.
>=20
> I do think there is an update of the Bluetooth controller firmware=20
> from 0.90 that you have to 1.04 at least. While it might not make the=20
> controller work, but it might fix actual Bluetooth bug in the=20
> firmware that you would stumble over later. So try to boot up an OS X=20
> if you can. If this is the BCM20703A1 chip from Broadcom, then they=20
> are rather new and having an updated firmware helps there.
>=20
> We have the following statement in probe function:
>=20
>         /* interface numbers are hardcoded in the spec */
>         if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0)
>                 return -ENODEV;
>=20
> This will avoid activating the device correctly in your case.
>=20
> As a background, we chose to do it this simple since Bluetooth is a=20
> multi-interface device by itself. It uses interface 0 (for=20
> ACL/cmd/evt) and also interface 1 (for SCO). So the interface numbers=20
> are pretty much hard coded and in the last 15 years nobody did it=20
> different. However it seems you find the first device that does this=20
> differently now.
>=20
> So you change the above 0 to a 2 and the later on then 1 to a 3.
>=20
>                 /* Interface numbers are hardcoded in the=20
> specification */
>                 data->isoc =3D usb_ifnum_to_if(data->udev, 1);
>=20
> This should get you your controller working, but obviously that is=20
> just for testing. The real fix is a lot more complicated and such a=20
> simple change will break every other Bluetooth dongle you might want=20
> to play with.

It did indeed - I changed those values, recompiled and installed the=20
new kernel, rebooted and the adapter is now being found. I was able to=20
pair it with my Nexus 5 and transfer a file across, but getting=20
Internet access through doesn't seem to be working.

I'll look into doing the firmware upgrade that you suggest above and=20
see if that helps anything.

Thanks for looking into this. I could try working on a real fix but=20
don't have any experience working on the kernel, so would need some=20
guidance. In any case I am more than happy to test patches and what-not.

//Mike

--=20
=E2=8A=A8 Michael Gratton, Percept Wrangler.
=E2=9A=99 <http://mjog.vee.net/>

=
