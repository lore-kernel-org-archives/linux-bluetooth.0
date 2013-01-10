Return-Path: <cyrus@holtmann.org>
From: Sergio Cambra <sergio@enpijama.es>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth device 04ca:3008 should use ath3k
Date: Thu, 10 Jan 2013 08:20:19 +0100
Message-ID: <23412004.z3Fb8P0Pj2@tablet>
In-Reply-To: <20130110051709.GC18821@joana>
References: <20130109195346.GB30225@joana> <1357776415-6974-1-git-send-email-sergio@enpijama.es> <20130110051709.GC18821@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Great, thanks

On Jueves, 10 de enero de 2013 03:17:09 Gustavo Padovan escribió:
> Hi Sergio,
> 
> * Sergio Cambra <sergio@enpijama.es> [2013-01-10 01:06:55 +0100]:
> > From: Sergio Cambra <sergio@programatica.es>
> > 
> > Output of /sys/kernel/debug/usb/devices
> > T:  Bus=03 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  6 Spd=12   MxCh= 0
> > D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=04ca ProdID=3008 Rev= 0.02
> > C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> > I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > 
> > Signed-off-by: Sergio Cambra <sergio@programatica.es>
> > ---
> > 
> >  drivers/bluetooth/ath3k.c | 2 ++
> >  drivers/bluetooth/btusb.c | 1 +
> >  2 files changed, 3 insertions(+)
> 
> Patch has been applied to bluetooth.git. Thanks.
> 
> 	Gustavo
