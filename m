Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EC65C3CE-3B41-4398-832B-18F8EFDE663C@holtmann.org>
References: <CAEZxfGPDdgjcSwS6vK46Q4tMwdoD=SjV-te8chiERM-wnEP00w@mail.gmail.com>
 <CABBYNZ+GMyT8z8ujGGu3oMK1ffkdAuX21ZRu7Cf7eFpqS0jHuw@mail.gmail.com>
 <CAEZxfGMY5L=gcDczjUoM6Yg3m9z+LObByFgnAy0u7duyu+v-tg@mail.gmail.com>
 <CABBYNZL_DjeOGbbFKmavUY1QRMNb1V2KrBbNHZ2bH=hZ6q5vNg@mail.gmail.com>
 <CAEZxfGMNJKc3kW+isa8LofrLCuWFBaPvyAiiw5X_0ZBLsrTDgQ@mail.gmail.com> <EC65C3CE-3B41-4398-832B-18F8EFDE663C@holtmann.org>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Mon, 5 Oct 2015 13:25:05 +0200
Message-ID: <CAEZxfGN=++e0HGugMVwaousi3oa+y90FJ0e0Jdupni+5cFqPSA@mail.gmail.com>
Subject: Re: Disabling deviceinfo plugin on chromebooks?
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Oct 3, 2015 at 7:11 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Francois,
>
> >>> Thanks for your answer Luiz!
> >>
> >> Please comment inline in the ml.
> >>
> >>> From what I can see, Android and iOS Bluetooth Stack libraries don't
> >>> claim the device_information service.
> >>> Could it be possible to make it so that the plugin doesn't block othe=
r
> >>> clients (such as the Web Bluetooth API) from interacting with that
> >>> service.
> >>
> >> That probably a bad behavior in their own because it can only cause
> >> more traffic as this information can be cached and made available
> >> without causing any extra traffic, as I said I think we just need to
> >> expose the extra information over the device API, so we just have to
> >> add them here:
> >>
> >> https://webbluetoothcg.github.io/web-bluetooth/#bluetoothdevice (note
> >> that it already contains part of device information)
> >>
> >
> > As these characteristics might not be useful to everyone, I'm not sure
> > about the benefit of caching all these device_information service
> > characteristics in Bluez and exposing them to the bluetooth device
> > object.
> > From a web developer point of view, I think I want to get back as
> > quick as possible the bluetooth device object and get characteristics
> > afterwards when I need to.
>
> I am actually fine if we let Device Info services be read by any client. =
However it is a bit trickier since that means an exception in our code.
>

That would be awesome actually!

> Also only Device Info will fall ever into this category where you have a =
system service reading it and where it might be useful for non-system clien=
ts. When bluetoothd implement the profile side then we can not have another=
 client trying to mess around with it. Especially when it is security sensi=
tive like HID.

That makes sense. Thank you Marcel!

>
> Regards
>
> Marcel
>
