Return-Path: <honwchong@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] bluetooth: btusb: Add device ID for RTL8822BE
From: Hon Weng Chong <honwchong@gmail.com>
In-Reply-To: <a2c8efa7-6acb-fc97-8401-87bbc9e3d618@lwfinger.net>
Date: Wed, 15 Nov 2017 10:40:35 +1100
Cc: Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-bluetooth@vger.kernel.org
Message-Id: <0FED073A-DD17-4075-A7FD-15BD4615987E@gmail.com>
References: <20171111174326.9243-1-Larry.Finger@lwfinger.net>
 <82ACB0CF-DD2F-4A44-A2F0-75D1C1B3DA9C@holtmann.org>
 <a2c8efa7-6acb-fc97-8401-87bbc9e3d618@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Larry,

Apologies for the delayed reply. Here's the data for the Realtek =
Bluetooth Device:

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D13 Cnt=3D07 Dev#=3D 14 Spd=3D12   =
MxCh=3D 0
D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0b05 ProdID=3D185c Rev=3D 1.10
S:  Manufacturer=3DRealtek=20
S:  Product=3DBluetooth Radio=20
S:  SerialNumber=3D00e04c000001
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms

> On 12 Nov 2017, at 6:10 am, Larry Finger <Larry.Finger@lwfinger.net> =
wrote:
>=20
> On 11/11/2017 12:51 PM, Marcel Holtmann wrote:
>> Hi Larry,
>>> The Asus Z370-I contains a Realtek RTL8822BE device with an =
associated
>>> BT chip using a USB ID of 0b05:185c. This device is added to the =
driver.
>>>=20
>>> Signed-off-by: Hon Weng Chong <honwchong@gmail.com>
>>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>>> ---
>>> drivers/bluetooth/btusb.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>=20
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 7a5c06aaa181..c265ef63cab7 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -373,6 +373,9 @@ static const struct usb_device_id =
blacklist_table[] =3D {
>>> 	{ USB_DEVICE(0x13d3, 0x3461), .driver_info =3D BTUSB_REALTEK },
>>> 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info =3D BTUSB_REALTEK },
>>>=20
>>> +	/* Additional Realtek 8822BE Bluetooth devices */
>>> +	{ USB_DEVICE(0x0b05, 0x1185c), .driver_info =3D BTUSB_REALTEK },
>>> +
>> I prefer to have /sys/kernel/debug/usb/devices for the device =
included in the commit message.
>> Regards
>> Marcel
> Hon,
>=20
> Please provide the data.
>=20
> Larry
>=20
