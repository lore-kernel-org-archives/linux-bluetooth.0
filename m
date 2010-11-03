Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 03 Nov 2010 23:03:13 +0100
From: gimli <gimli@dark-green.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/6] MacBookAir3,1(3,2) btusb support
In-Reply-To: <20101103215106.GA21950@vigoh>
References: <9e7738c0461aa509dd55fe470df3855e@mognix.dark-green.com> <20101102152454.GC11778@core.coreip.homeip.net> <1288712282.3322.181.camel@aeonflux> <20101103182159.GA17943@vigoh> <4CD1B30C.6010904@dark-green.com> <20101103191429.GA21114@vigoh> <4CD1C3E5.3030507@dark-green.com> <20101103215106.GA21950@vigoh>
Message-ID: <c528a2a6fd9e96601997600559812f10@mognix.dark-green.com>
Content-Type: multipart/mixed;
	boundary="=_8ecc8db6f0331a43f9d44fc07cba0003"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=_8ecc8db6f0331a43f9d44fc07cba0003
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"

This patch enables MacBookAir3,1(2) support in btusb :

Output without the patch and btusb loaded :

T:  Bus=03 Lev=02 Prnt=03 Port=02 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=05ac ProdID=821b Rev= 0.34
S:  Manufacturer=Apple Inc.
S:  Product=Bluetooth USB Host Controller
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Output with the patch and btusb loaded :

T:  Bus=03 Lev=02 Prnt=03 Port=02 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=05ac ProdID=821b Rev= 0.34
S:  Manufacturer=Apple Inc.
S:  Product=Bluetooth USB Host Controller
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Signed-off-by: Edgar (gimli) Hucek <gimli@dark-green.com>

On Wed, 3 Nov 2010 17:51:06 -0400, "Gustavo F. Padovan"
<padovan@profusion.mobi> wrote:
> Hi Gimli,
> 
> Again, please stop top posting, it's not accepted here.
> 
> * gimli <gimli@dark-green.com> [2010-11-03 21:19:49 +0100]:
> 
>> Here is the output :
>> 
>> T:  Bus=03 Lev=02 Prnt=03 Port=02 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
>> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=05ac ProdID=821b Rev= 0.34
>> S:  Manufacturer=Apple Inc.
>> S:  Product=Bluetooth USB Host Controller
>> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
>> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
>> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
>> I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Actually you have to post the output of usb-devices without your patch
> to show why your patch need is needed. And you should add that to the
> commit message and resend your patch to linux-bluetooth instead of
> posting it on this thread.
--=_8ecc8db6f0331a43f9d44fc07cba0003
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8";
 name="btusb_macbookair.patch";
Content-Disposition: attachment;
 filename="btusb_macbookair.patch";

LS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYwkyMDEwLTEwLTMwIDIxOjA4OjQ1LjE3MDQ5
MjAwMiArMDIwMAorKysgYi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jCTIwMTAtMTAtMzAgMjE6
MTg6MTEuODIwNDkyMDAwICswMjAwCkBAIC02Miw2ICs2Miw5IEBACiAJLyogQXBwbGUgaU1hYzEx
LDEgKi8KIAl7IFVTQl9ERVZJQ0UoMHgwNWFjLCAweDgyMTUpIH0sCiAKKwkvKiBBcHBsZSBNYWNC
b29rQWlyMywxLCBNYWNCb29rQWlyMywyICovCisJeyBVU0JfREVWSUNFKDB4MDVhYywgMHg4MjFi
KSB9LAorCiAJLyogQVZNIEJsdWVGUklUWiEgVVNCIHYyLjAgKi8KIAl7IFVTQl9ERVZJQ0UoMHgw
NTdjLCAweDM4MDApIH0sCiAK
--=_8ecc8db6f0331a43f9d44fc07cba0003--

