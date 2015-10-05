Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJqR+C7m=o7Xzh68DJ4jLDEDisJdbqjjQuf6mCmqfNWsQ@mail.gmail.com>
References: <CAEZxfGPDdgjcSwS6vK46Q4tMwdoD=SjV-te8chiERM-wnEP00w@mail.gmail.com>
 <CABBYNZ+GMyT8z8ujGGu3oMK1ffkdAuX21ZRu7Cf7eFpqS0jHuw@mail.gmail.com>
 <CAEZxfGMY5L=gcDczjUoM6Yg3m9z+LObByFgnAy0u7duyu+v-tg@mail.gmail.com>
 <CABBYNZL_DjeOGbbFKmavUY1QRMNb1V2KrBbNHZ2bH=hZ6q5vNg@mail.gmail.com>
 <CAEZxfGMNJKc3kW+isa8LofrLCuWFBaPvyAiiw5X_0ZBLsrTDgQ@mail.gmail.com>
 <EC65C3CE-3B41-4398-832B-18F8EFDE663C@holtmann.org> <CAEZxfGN=++e0HGugMVwaousi3oa+y90FJ0e0Jdupni+5cFqPSA@mail.gmail.com>
 <CABBYNZJqR+C7m=o7Xzh68DJ4jLDEDisJdbqjjQuf6mCmqfNWsQ@mail.gmail.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Mon, 5 Oct 2015 13:36:57 +0200
Message-ID: <CAEZxfGNHai9Mv-D2fVnRRCcqeUXfBzaAfGqpHfQwXAunfdyHhg@mail.gmail.com>
Subject: Re: Disabling deviceinfo plugin on chromebooks?
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Do you want me to push a Pull Request?

On Mon, Oct 5, 2015 at 1:35 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Fran=C3=A7ois,
>
> On Mon, Oct 5, 2015 at 2:25 PM, Fran=C3=A7ois Beaufort
> <beaufort.francois@gmail.com> wrote:
>> On Sat, Oct 3, 2015 at 7:11 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>>>
>>> Hi Francois,
>>>
>>> >>> Thanks for your answer Luiz!
>>> >>
>>> >> Please comment inline in the ml.
>>> >>
>>> >>> From what I can see, Android and iOS Bluetooth Stack libraries don'=
t
>>> >>> claim the device_information service.
>>> >>> Could it be possible to make it so that the plugin doesn't block ot=
her
>>> >>> clients (such as the Web Bluetooth API) from interacting with that
>>> >>> service.
>>> >>
>>> >> That probably a bad behavior in their own because it can only cause
>>> >> more traffic as this information can be cached and made available
>>> >> without causing any extra traffic, as I said I think we just need to
>>> >> expose the extra information over the device API, so we just have to
>>> >> add them here:
>>> >>
>>> >> https://webbluetoothcg.github.io/web-bluetooth/#bluetoothdevice (not=
e
>>> >> that it already contains part of device information)
>>> >>
>>> >
>>> > As these characteristics might not be useful to everyone, I'm not sur=
e
>>> > about the benefit of caching all these device_information service
>>> > characteristics in Bluez and exposing them to the bluetooth device
>>> > object.
>>> > From a web developer point of view, I think I want to get back as
>>> > quick as possible the bluetooth device object and get characteristics
>>> > afterwards when I need to.
>>>
>>> I am actually fine if we let Device Info services be read by any client=
. However it is a bit trickier since that means an exception in our code.
>>>
>>
>> That would be awesome actually!
>>
>>> Also only Device Info will fall ever into this category where you have =
a system service reading it and where it might be useful for non-system cli=
ents. When bluetoothd implement the profile side then we can not have anoth=
er client trying to mess around with it. Especially when it is security sen=
sitive like HID.
>>
>> That makes sense. Thank you Marcel!
>
> The easiest way to accomplish this is the following:
>
> diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/devic=
einfo.c
> index a0e9951..501f791 100644
> --- a/profiles/deviceinfo/deviceinfo.c
> +++ b/profiles/deviceinfo/deviceinfo.c
> @@ -192,7 +192,8 @@ static struct btd_profile deviceinfo_profile =3D {
>         .name           =3D "deviceinfo",
>         .remote_uuid    =3D DEVICE_INFORMATION_UUID,
>         .device_probe   =3D deviceinfo_driver_probe,
> -       .device_remove  =3D deviceinfo_driver_remove
> +       .device_remove  =3D deviceinfo_driver_remove,
> +       .external       =3D true
>  };
>
>  static int deviceinfo_init(void)
> --
> Luiz Augusto von Dentz
