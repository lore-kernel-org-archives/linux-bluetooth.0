Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4dfd5709041225103246f6934c@mail.gmail.com>
From: CoCozZ geek <cocozz@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Error when compiling bluez-utils
In-Reply-To: <4dfd57090412251011705f52be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <4dfd570904122402134ec2fd32@mail.gmail.com>
	 <4dfd570904122509237f2a2f48@mail.gmail.com>
	 <1103995727.8758.31.camel@pegasus>
	 <4dfd570904122509451e811d7a@mail.gmail.com>
	 <1103996976.8758.34.camel@pegasus>
	 <4dfd5709041225095410f71a46@mail.gmail.com>
	 <1103997529.8758.36.camel@pegasus>
	 <4dfd570904122510081a9bfa7@mail.gmail.com>
	 <4dfd570904122510085371c17b@mail.gmail.com>
	 <4dfd57090412251011705f52be@mail.gmail.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 25 Dec 2004 19:32:26 +0100

Oh one more thing please :) File transfers are OK. But I need to send
things to the flash memory and not to the mobile memory. Is it
possible ?

It might be cool to access the mobile filesystem , is it possible to ?


On Sat, 25 Dec 2004 19:11:28 +0100, CoCozZ geek <cocozz@gmail.com> wrote:
> Yessssssss miracle :)
> 
> Cocozz cocozz # hcitool scan
> Scanning ...
>         00:0E:6D:85:74:7A       Nokia 6600
> 
> Lots lots lots lots lots of thanks !!!!
> 
> Have a very happy holidays ;=)))
> 
> 
> On Sat, 25 Dec 2004 19:08:46 +0100, CoCozZ geek <cocozz@gmail.com> wrote:
> > edit: oh ... yes im using an usb HUB. Ok wait I try to connect ir on
> > another usb port
> >
> > On Sat, 25 Dec 2004 19:08:30 +0100, CoCozZ geek <cocozz@gmail.com> wrote:
> > > oh ... yes im using an usb. Ok wait I try to connect ir on another usb port
> > >
> > >
> > > On Sat, 25 Dec 2004 18:58:49 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> > > > Hi,
> > > >
> > > > > Cocozz cocozz # uname -r
> > > > > 2.6.8-gentoo-r10
> > > > >
> > > > > Cocozz cocozz # cat /proc/bus/usb/devices
> > > > >
> > > > > T:  Bus=01 Lev=02 Prnt=05 Port=02 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
> > > > > D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > > > > P:  Vendor=0a12 ProdID=0001 Rev= 5.25
> > > > > C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
> > > > > I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> > > > > E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> > > > > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > > > > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > > > > I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > > > > E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > > > > E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > > > > I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > > > > E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > > > > E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > > > > I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > > > > E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > > > > E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > > > > I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > > > > E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > > > > E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > > > > I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > > > > E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > > > > E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > > > > I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > > > > E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > > > > E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > > > > I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
> > > >
> > > > I don't see any problem here and since this is a CSR dongle there
> > > > shouldn't be a problem at all. These devices normally work. Maybe you
> > > > need to change your USB devices a little bit. I heard of problems of
> > > > some Bluetooth dongles behind a hub etc.
> > > >
> > > > Regards
> > > >
> > > > Marcel
> > > >
> > > > -------------------------------------------------------
> > > > SF email is sponsored by - The IT Product Guide
> > > > Read honest & candid reviews on hundreds of IT Products from real users.
> > > > Discover which products truly live up to the hype. Start reading now.
> > > > http://productguide.itmanagersjournal.com/
> > > > _______________________________________________
> > > > Bluez-users mailing list
> > > > Bluez-users@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > > >
> > >
> >
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
