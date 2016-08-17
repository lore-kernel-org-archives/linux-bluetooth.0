Return-Path: <gary@mort.net>
MIME-Version: 1.0
In-Reply-To: <1470671433.2492.14.camel@hadess.net>
References: <556CC928.60503@mort.net> <C1D5C485-4FA0-4221-9F1A-A1A0941FE5F8@holtmann.org>
 <556CF450.2030107@mort.net> <4CBFCC0A-794F-4F78-A499-DFD083F29378@holtmann.org>
 <556D3082.5060403@mort.net> <37075208-AE18-4114-8029-40930FE22DA7@holtmann.org>
 <1470671433.2492.14.camel@hadess.net>
From: Gary Mort <gary@mort.net>
Date: Tue, 16 Aug 2016 23:03:44 -0400
Message-ID: <CAK7gL6LS9wRc8CZME=bHustD_51__ahA=Sc84NRKu_Nwwetnyw@mail.gmail.com>
Subject: Re: 3dsp sample app and Bluez v5
To: Bastien Nocera <hadess@hadess.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=94eb2c048d246cbc7f053a3bb8ad
List-ID: <linux-bluetooth.vger.kernel.org>

--94eb2c048d246cbc7f053a3bb8ad
Content-Type: text/plain; charset=UTF-8

In my copious spare time, I'd like to get back to this and some other
projects[figuring out how to read/write to a pogo connect bluetooth
stylus]..  Using hcitool and a v4 adapter, I can connect to the pogo
connect and get a list of all the uuid's - but I find it somewhat tedious
to manually run commands to read or write to an endpoint.  As far as "usb
dongles" go - it seems most of the dev tools are really just usb serial
ports - so it doesn't really matter if it has a connection or not - just
get a usb to serial cable and away you go.

TI has a promising tool, smartRftm Studio and among the products you can
use it with are their CC2650 launchpad -
http://www.ti.com/tool/launchxl-cc2650 as well as using it with their
SesnorTag product if you have the debugger add on.

I have a preference for TI products...no real reason, I just like them.
However, smartRF studio is a windows only application which rules it out
for me on my home system[I use linux] and since this is a hobby project
it's not like I will maintain multiple systems.


So, that being said I've reluctantly had to look elsewhere.  For me,
elsewhere is Nordic semiconductors.  They have a number of reference
designs for very promising development platforms.  The nrf2401L seems to be
a widely used chip with many usb dongles - you can even get them very
cheaply from sites such as Banggood[disclaimer: links contain my affiliate
id]: http://www.banggood.com/?p=WF07171453576201504H

You can get 5 of them for about $15 if your willing to wait a while for
delivery[I find on average it takes 6-8 weeks]

http://www.banggood.com/5Pcs-1100-Meter-Long-Distance-NRF24L01PALNA-Wireless-Module-With-Antenna-p-1066642.html?p=WF07171453576201504H

The nrf2401 seems a bit long in the tooth, so I don't know if the various
tools for it are still active and what platforms they supported.
Personally I'm planning on ordering a pair of nRF51822's.  I'd prefer the
development board since it has a usb connector built in:
http://www.banggood.com/NRF51822-BLE4_0-Bluetooth-Development-Board-2_4G-Wireless-Communication-Module-p-1044143.html?p=WF07171453576201504H
  Since it is out of stock, I might go with the bare board and a usb/serial
cable:
http://www.banggood.com/NRF51822-Bluetooth-Wireless-Module-XL51822-Communication-Board-p-1075552.html?p=WF07171453576201504H


In all honesty though, if I can't get the dev kit I'd be inclined to get a
single dongle from Adafruit instead: https://www.adafruit.com/products/2269
  It costs 3 times as much but will arrive sooner.

The main attraction for me of the NRF51822 is the free development
application Nordic provides: nRF Connect.
http://www.nordicsemi.com/eng/Products/Bluetooth-low-energy/nRF-Connect-for-desktop

It runs on Windows, Linux and Mac.  While the marketting for the software
implied to me that it was just for low energy bluetooth,  reading the
getting started PDF I saw:
"nRF Connect supports configuration of the GATT attribute table, also known
as server setup, of the local
device. Adding attributes to the server setup allows the local device to
exhange data with a connected peer
device."

If you do give one of them a try, I'd appreciate it if you can send me an
email with how easy you found the tools to use.  My expectation is that I
would very rapidly need to actually start writing some code - probably in
python since there are extensive bluetooth libraries available.   Mainly I
like the idea of a GUI tool for doing some initial poking around.   Things
like "yes, the device does exist...yes I can pair to it...yes I can get a
list of BLE uuid's and shove some data to them...yes I can run in sniffer
mode and then pair the device with the "Correct" hardware and capture the
network transfers between the devices as I use it"






On Mon, Aug 8, 2016 at 11:50 AM, Bastien Nocera <hadess@hadess.net> wrote:

> On Tue, 2015-06-02 at 07:00 +0200, Marcel Holtmann wrote:
> >
> <snip>
> > then you need a controller with connectionless slave broadcast
> > support in master mode. The only ones I know of are some Marvell
> > PCIe/USB or SDIO based cards and one Broadcom dongle with the
> > firmware update applied.
> >
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi
> > t/?id=d049f4e513e861167361b06c7ca85f9e872c8cde
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

--94eb2c048d246cbc7f053a3bb8ad
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In my copious spare time, I&#39;d like to get back to this=
 and some other projects[figuring out how to read/write to a pogo connect b=
luetooth stylus]..=C2=A0 Using hcitool and a v4 adapter, I can connect to t=
he pogo connect and get a list of all the uuid&#39;s - but I find it somewh=
at tedious to manually run commands to read or write to an endpoint.=C2=A0 =
As far as &quot;usb dongles&quot; go - it seems most of the dev tools are r=
eally just usb serial ports - so it doesn&#39;t really matter if it has a c=
onnection or not - just get a usb to serial cable and away you go.<div><br>=
</div><div>TI has a promising tool, smartRftm Studio and among the products=
 you can use it with are their CC2650 launchpad - <a href=3D"http://www.ti.=
com/tool/launchxl-cc2650">http://www.ti.com/tool/launchxl-cc2650</a> as wel=
l as using it with their SesnorTag product if you have the debugger add on.=
</div><div><br></div><div>I have a preference for TI products...no real rea=
son, I just like them. =C2=A0 However, smartRF studio is a windows only app=
lication which rules it out for me on my home system[I use linux] and since=
 this is a hobby project it&#39;s not like I will maintain multiple systems=
.</div><div><br></div><div><br></div><div>So, that being said I&#39;ve relu=
ctantly had to look elsewhere.=C2=A0 For me, elsewhere is Nordic semiconduc=
tors.=C2=A0 They have a number of reference designs for very promising deve=
lopment platforms.=C2=A0 The nrf2401L seems to be a widely used chip with m=
any usb dongles - you can even get them very cheaply from sites such as Ban=
ggood[disclaimer: links contain my affiliate id]: <a href=3D"http://www.ban=
ggood.com/?p=3DWF07171453576201504H">http://www.banggood.com/?p=3DWF0717145=
3576201504H</a>=C2=A0</div><div><br></div><div>You can get 5 of them for ab=
out $15 if your willing to wait a while for delivery[I find on average it t=
akes 6-8 weeks]</div><div>=C2=A0 <a href=3D"http://www.banggood.com/5Pcs-11=
00-Meter-Long-Distance-NRF24L01PALNA-Wireless-Module-With-Antenna-p-1066642=
.html?p=3DWF07171453576201504H">http://www.banggood.com/5Pcs-1100-Meter-Lon=
g-Distance-NRF24L01PALNA-Wireless-Module-With-Antenna-p-1066642.html?p=3DWF=
07171453576201504H</a></div><div><br></div><div>The nrf2401 seems a bit lon=
g in the tooth, so I don&#39;t know if the various tools for it are still a=
ctive and what platforms they supported.=C2=A0 Personally I&#39;m planning =
on ordering a pair of=C2=A0nRF51822&#39;s.=C2=A0 I&#39;d prefer the develop=
ment board since it has a usb connector built in:=C2=A0<a href=3D"http://ww=
w.banggood.com/NRF51822-BLE4_0-Bluetooth-Development-Board-2_4G-Wireless-Co=
mmunication-Module-p-1044143.html?p=3DWF07171453576201504H">http://www.bang=
good.com/NRF51822-BLE4_0-Bluetooth-Development-Board-2_4G-Wireless-Communic=
ation-Module-p-1044143.html?p=3DWF07171453576201504H</a> =C2=A0 Since it is=
 out of stock, I might go with the bare board and a usb/serial cable:=C2=A0=
<a href=3D"http://www.banggood.com/NRF51822-Bluetooth-Wireless-Module-XL518=
22-Communication-Board-p-1075552.html?p=3DWF07171453576201504H">http://www.=
banggood.com/NRF51822-Bluetooth-Wireless-Module-XL51822-Communication-Board=
-p-1075552.html?p=3DWF07171453576201504H</a>=C2=A0</div><div><br></div><div=
>In all honesty though, if I can&#39;t get the dev kit I&#39;d be inclined =
to get a single dongle from Adafruit instead:=C2=A0<a href=3D"https://www.a=
dafruit.com/products/2269">https://www.adafruit.com/products/2269</a> =C2=
=A0 It costs 3 times as much but will arrive sooner.</div><div><br></div><d=
iv>The main attraction for me of the NRF51822 is the free development appli=
cation Nordic provides: nRF Connect.=C2=A0<a href=3D"http://www.nordicsemi.=
com/eng/Products/Bluetooth-low-energy/nRF-Connect-for-desktop">http://www.n=
ordicsemi.com/eng/Products/Bluetooth-low-energy/nRF-Connect-for-desktop</a>=
 =C2=A0</div><div>It runs on Windows, Linux and Mac.=C2=A0 While the market=
ting for the software implied to me that it was just for low energy bluetoo=
th, =C2=A0reading the getting started PDF I saw:</div><div><div>&quot;nRF C=
onnect supports configuration of the GATT attribute table, also known as se=
rver setup, of the local</div><div>device. Adding attributes to the server =
setup allows the local device to exhange data with a connected peer</div><d=
iv>device.&quot;</div></div><div><br></div><div>If you do give one of them =
a try, I&#39;d appreciate it if you can send me an email with how easy you =
found the tools to use.=C2=A0 My expectation is that I would very rapidly n=
eed to actually start writing some code - probably in python since there ar=
e extensive bluetooth libraries available. =C2=A0 Mainly I like the idea of=
 a GUI tool for doing some initial poking around. =C2=A0 Things like &quot;=
yes, the device does exist...yes I can pair to it...yes I can get a list of=
 BLE uuid&#39;s and shove some data to them...yes I can run in sniffer mode=
 and then pair the device with the &quot;Correct&quot; hardware and capture=
 the network transfers between the devices as I use it&quot;</div><div><br>=
</div><div><br></div><div><br></div><div><br></div><div><br></div></div><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Aug 8, 2016 =
at 11:50 AM, Bastien Nocera <span dir=3D"ltr">&lt;<a href=3D"mailto:hadess@=
hadess.net" target=3D"_blank">hadess@hadess.net</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">On Tue, 2015-06-02 at 07:00 +0200, Marcel Holt=
mann wrote:<br>
&gt;<br>
&lt;snip&gt;<br>
<span class=3D"">&gt; then you need a controller with connectionless slave =
broadcast<br>
&gt; support in master mode. The only ones I know of are some Marvell<br>
&gt; PCIe/USB or SDIO based cards and one Broadcom dongle with the<br>
&gt; firmware update applied.<br>
&gt;<br>
&gt; <a href=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux=
.git/commi" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/cgi=
t/<wbr>linux/kernel/git/torvalds/<wbr>linux.git/commi</a><br>
&gt; t/?id=3D<wbr>d049f4e513e861167361b06c7ca85f<wbr>9e872c8cde<br>
&gt;<br>
&gt; I wrote an extra long commit message for reference on how this dongle<=
br>
&gt; works and that its slave mode is actually broken. And I have run this<=
br>
&gt; against a 3D enabled TV and I can pretend to be 3D glasses.<br>
&gt;<br>
&gt; However for the display side, I have never gotten any good timing<br>
&gt; values that would allow me to get the glasses do something useful.<br>
&gt; And hooking it up to a proper frame sync was then just too much work.<=
br>
&gt; Then again, the code is there and you can start toying with it.<br>
<br>
</span>Doing thread grave digging.<br>
<br>
Are there any more Bluetooth adapters that would support the necessary<br>
mode to use 3DS glasses? One that would be available as external USB<br>
dongle would be nice.<br>
<br>
Cheers<br>
</blockquote></div><br></div>

--94eb2c048d246cbc7f053a3bb8ad--
