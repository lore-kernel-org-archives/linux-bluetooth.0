Return-Path: <gary@mort.net>
MIME-Version: 1.0
In-Reply-To: <CAK7gL6LS9wRc8CZME=bHustD_51__ahA=Sc84NRKu_Nwwetnyw@mail.gmail.com>
References: <556CC928.60503@mort.net> <C1D5C485-4FA0-4221-9F1A-A1A0941FE5F8@holtmann.org>
 <556CF450.2030107@mort.net> <4CBFCC0A-794F-4F78-A499-DFD083F29378@holtmann.org>
 <556D3082.5060403@mort.net> <37075208-AE18-4114-8029-40930FE22DA7@holtmann.org>
 <1470671433.2492.14.camel@hadess.net> <CAK7gL6LS9wRc8CZME=bHustD_51__ahA=Sc84NRKu_Nwwetnyw@mail.gmail.com>
From: Gary Mort <gary@mort.net>
Date: Tue, 16 Aug 2016 23:33:20 -0400
Message-ID: <CAK7gL6Km8K2rffaRP4Lizmk3vz9t1=cHmZdK=tGrTeoQ=aGNig@mail.gmail.com>
Subject: Re: 3dsp sample app and Bluez v5
To: Bastien Nocera <hadess@hadess.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

> In my copious spare time, I'd like to get back to this and some other pro=
jects[figuring out how to read/write to a pogo connect bluetooth stylus].. =
 Using hcitool and a v4 adapter, I can connect to the pogo connect and get =
a list of all the uuid's - but I find it somewhat tedious to manually run c=
ommands to read or write to an endpoint.  As far as "usb dongles" go - it s=
eems most of the dev tools are really just usb serial ports - so it doesn't=
 really matter if it has a connection or not - just get a usb to serial cab=
le and away you go.
>
> TI has a promising tool, smartRftm Studio and among the products you can =
use it with are their CC2650 launchpad - http://www.ti.com/tool/launchxl-cc=
2650 as well as using it with their SesnorTag product if you have the debug=
ger add on.
>
> I have a preference for TI products...no real reason, I just like them.  =
 However, smartRF studio is a windows only application which rules it out f=
or me on my home system[I use linux] and since this is a hobby project it's=
 not like I will maintain multiple systems.
>
>
> So, that being said I've reluctantly had to look elsewhere.  For me, else=
where is Nordic semiconductors.  They have a number of reference designs fo=
r very promising development platforms.  The nrf2401L seems to be a widely =
used chip with many usb dongles - you can even get them very cheaply from s=
ites such as Banggood[disclaimer: links contain my affiliate id]: http://ww=
w.banggood.com/?p=3DWF07171453576201504H
>
> You can get 5 of them for about $15 if your willing to wait a while for d=
elivery[I find on average it takes 6-8 weeks]
>   http://www.banggood.com/5Pcs-1100-Meter-Long-Distance-NRF24L01PALNA-Wir=
eless-Module-With-Antenna-p-1066642.html?p=3DWF07171453576201504H
>
> The nrf2401 seems a bit long in the tooth, so I don't know if the various=
 tools for it are still active and what platforms they supported.  Personal=
ly I'm planning on ordering a pair of nRF51822's.  I'd prefer the developme=
nt board since it has a usb connector built in: http://www.banggood.com/NRF=
51822-BLE4_0-Bluetooth-Development-Board-2_4G-Wireless-Communication-Module=
-p-1044143.html?p=3DWF07171453576201504H   Since it is out of stock, I migh=
t go with the bare board and a usb/serial cable: http://www.banggood.com/NR=
F51822-Bluetooth-Wireless-Module-XL51822-Communication-Board-p-1075552.html=
?p=3DWF07171453576201504H
>
> In all honesty though, if I can't get the dev kit I'd be inclined to get =
a single dongle from Adafruit instead: https://www.adafruit.com/products/22=
69   It costs 3 times as much but will arrive sooner.
>
> The main attraction for me of the NRF51822 is the free development applic=
ation Nordic provides: nRF Connect. http://www.nordicsemi.com/eng/Products/=
Bluetooth-low-energy/nRF-Connect-for-desktop
> It runs on Windows, Linux and Mac.  While the marketting for the software=
 implied to me that it was just for low energy bluetooth,  reading the gett=
ing started PDF I saw:
> "nRF Connect supports configuration of the GATT attribute table, also kno=
wn as server setup, of the local
> device. Adding attributes to the server setup allows the local device to =
exhange data with a connected peer
> device."
>
> If you do give one of them a try, I'd appreciate it if you can send me an=
 email with how easy you found the tools to use.  My expectation is that I =
would very rapidly need to actually start writing some code - probably in p=
ython since there are extensive bluetooth libraries available.   Mainly I l=
ike the idea of a GUI tool for doing some initial poking around.   Things l=
ike "yes, the device does exist...yes I can pair to it...yes I can get a li=
st of BLE uuid's and shove some data to them...yes I can run in sniffer mod=
e and then pair the device with the "Correct" hardware and capture the netw=
ork transfers between the devices as I use it"
>
>
>
>
>
>
> On Mon, Aug 8, 2016 at 11:50 AM, Bastien Nocera <hadess@hadess.net> wrote=
:
> On Tue, 2015-06-02 at 07:00 +0200, Marcel Holtmann wrote:
> >
> <snip>
> > then you need a controller with connectionless slave broadcast
> > support in master mode. The only ones I know of are some Marvell
> > PCIe/USB or SDIO based cards and one Broadcom dongle with the
> > firmware update applied.
> >
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi
> > t/?id=3Dd049f4e513e861167361b06c7ca85f9e872c8cde
> >
> > I wrote an extra long commit message for reference on how this dongle
> > works and that its slave mode is actually broken. And I have run this
> > against a 3D enabled TV and I can pretend to be 3D glasses.
> >
> > However for the display side, I have never gotten any good timing
> > values that would allow me to get the glasses do something useful.
> > And hooking it up to a proper frame sync was then just too much work.
> > Then again, the code is there and you can start toying with it.
>
> Doing thread grave digging.
>
> Are there any more Bluetooth adapters that would support the necessary
> mode to use 3DS glasses? One that would be available as external USB
> dongle would be nice.
>
> Cheers
>
