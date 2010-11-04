Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 04 Nov 2010 08:04:33 +0100
From: gimli <gimli@dark-green.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: <linux-bluetooth@vger.kernel.org>, <gimli@dark-green.com>
Subject: [PATCH 1/1] Add MacBookAir3,1(2) support
In-Reply-To: <20101104023923.GA24092@vigoh>
References: <9e7738c0461aa509dd55fe470df3855e@mognix.dark-green.com> <20101102152454.GC11778@core.coreip.homeip.net> <1288712282.3322.181.camel@aeonflux> <20101103182159.GA17943@vigoh> <4CD1B30C.6010904@dark-green.com> <20101103191429.GA21114@vigoh> <4CD1C3E5.3030507@dark-green.com> <20101103215106.GA21950@vigoh> <c528a2a6fd9e96601997600559812f10@mognix.dark-green.com> <20101104023923.GA24092@vigoh>
Message-ID: <ffd9073aaab3142681f1b1340aea1cf0@mognix.dark-green.com>
Content-Type: multipart/mixed;
	boundary="=_0aca692010d12ab43f47fec0d4c9a6a3"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=_0aca692010d12ab43f47fec0d4c9a6a3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"

bluetooth: Add MacBookAir3,1(2) support

Adding the new MacBookAir3,1(2) to btusb.

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
---

--=_0aca692010d12ab43f47fec0d4c9a6a3
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8";
 name="btusb_macbookair.patch";
Content-Disposition: attachment;
 filename="btusb_macbookair.patch";

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgYi9kcml2ZXJzL2JsdWV0b290
aC9idHVzYi5jCmluZGV4IGQxMjBhNWMuLjE4MDU0N2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0dXNiLmMKKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYwpAQCAtNjgsNiAr
NjgsOSBAQCBzdGF0aWMgc3RydWN0IHVzYl9kZXZpY2VfaWQgYnR1c2JfdGFibGVbXSA9IHsKIAkv
KiBBcHBsZSBNYWNCb29rUHJvNiwyICovCiAJeyBVU0JfREVWSUNFKDB4MDVhYywgMHg4MjE4KSB9
LAogCisJLyogQXBwbGUgTWFjQm9va0FpcjMsMSwgTWFjQm9va0FpcjMsMiAqLworCXsgVVNCX0RF
VklDRSgweDA1YWMsIDB4ODIxYikgfSwKKwogCS8qIEFWTSBCbHVlRlJJVFohIFVTQiB2Mi4wICov
CiAJeyBVU0JfREVWSUNFKDB4MDU3YywgMHgzODAwKSB9LAogCg==
--=_0aca692010d12ab43f47fec0d4c9a6a3--

