Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v5] Bluetooth: Add support for QCA ROME chipset family
Date: Sun, 15 Feb 2015 00:03:02 +0000
Message-ID: <6725D567-5603-463F-BBC0-D04F10C76AC8@qca.qualcomm.com>
References: <5355d8dbb7584d488f6d059306d3a1ad@nalasexr02e.na.qualcomm.com>
 <230EFAD9-F4D1-43E0-B84B-CD8AFB612B96@holtmann.org>
 <5D613851-2AAB-4104-BD45-5A7A95647BEA@qca.qualcomm.com>
 <D68C4A91-FF79-411F-8E80-95AFE46DE339@holtmann.org>
In-Reply-To: <D68C4A91-FF79-411F-8E80-95AFE46DE339@holtmann.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Feb 14, 2015, at 3:35 PM, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Ben,
>=20
>>>> This patch supports ROME Bluetooth family from Qualcomm Atheros,
>>>> e.g. QCA61x4 or QCA6574.
>>>>=20
>>>> New chipset have similar firmware downloading sequences to previous
>>>> chipset from Atheros, however, it doesn't support vid/pid switching
>>>> after downloading the patch so that firmware needs to be handled by
>>>> btusb module directly.
>>>>=20
>>>> ROME chipset can be differentiated from previous version by reading
>>>> ROM version.
>>>>=20
>>>> T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D 16 Spd=3D12=
   MxCh=3D 0
>>>> D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D =
 1
>>>> P:  Vendor=3D0cf3 ProdID=3De300 Rev=3D 0.01
>>>> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
>>>> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
>>>> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>>>> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>>>> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>>>> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>>>> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>>>> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>>>> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>>>> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>>>>=20
>>>> T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  8 Spd=3D12=
   MxCh=3D 0
>>>> D:  Ver=3D 2.01 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D =
 1
>>>> P:  Vendor=3D0cf3 ProdID=3De360 Rev=3D 0.01
>>>> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
>>>> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
>>>> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>>>> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>>>> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>>>> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>>>> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>>>> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>>>> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>>>> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb
>>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>>>>=20
>>>> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
>>>> ---
>>>> drivers/bluetooth/btusb.c | 265 ++++++++++++++++++++++++++++++++++++++=
++++++++
>>>> 1 file changed, 265 insertions(+)
>>>>=20
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>> index b876888..45fe262 100644
>>>> --- a/drivers/bluetooth/btusb.c
>>>> +++ b/drivers/bluetooth/btusb.c
>>>> @@ -52,6 +52,7 @@ static struct usb_driver btusb_driver;
>>>> #define BTUSB_SWAVE		0x1000
>>>> #define BTUSB_INTEL_NEW		0x2000
>>>> #define BTUSB_AMP		0x4000
>>>> +#define BTUSB_QCA_ROME		0x8000
>>>>=20
>>>> static const struct usb_device_id btusb_table[] =3D {
>>>> 	/* Generic Bluetooth USB device */
>>>> @@ -212,6 +213,10 @@ static const struct usb_device_id blacklist_table=
[] =3D {
>>>> 	{ USB_DEVICE(0x0489, 0xe036), .driver_info =3D BTUSB_ATH3012 },
>>>> 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info =3D BTUSB_ATH3012 },
>>>>=20
>>>> +	/* QCA ROME chipset */
>>>> +	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info =3D BTUSB_QCA_ROME},
>>>> +	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info =3D BTUSB_QCA_ROME},
>>>> +
>>>> 	/* Broadcom BCM2035 */
>>>> 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info =3D BTUSB_BCM92035 },
>>>> 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info =3D BTUSB_WRONG_SCO_MTU },
>>>> @@ -336,6 +341,8 @@ struct btusb_data {
>>>>=20
>>>> 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
>>>> 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
>>>> +
>>>> +	int (*setup_patch_usb)(struct hci_dev *hdev);
>>>> };
>>>=20
>>> I prefer to do this in two patches. One that add the extra callback han=
dling. And then the other adding QCA support.
>>>=20
>>> However I do wonder if setup_patch_usb is the right name here. I curren=
t fail to come up with a better name. So I am open for ideas.
>>>=20
>>> One other thing I am wondering is if this should take a btusb_data poin=
ter. Since we are bypassing hci_dev anyway. We do not have to do that, but =
I am wondering if that makes sense.
>>=20
>> If we=92re okay to touch hci_dev structure, I would prefer to add this f=
unction pointer in hci_dev. The reason why btusb_data struct was chosen is =
it doesn=92t need to touch outside of header or files except btusb.c file. =
If possible, I=92ll add setup function pointer in hci_dev as =92setup_on_us=
b=92. That is more clean & easily readable.
>=20
> we are not okay with that at all. This is btusb.c internal detail on how =
to handle the USB transport. That is why I asked about doing this over HCI.=
 Then we could involve the core layer, but for USB specific details we can =
never ever involve the Bluetooth core layer.
>=20

So only option here is putting =91setup_on_usb=92 pointer in btusb_data str=
ucture and invoke it from btusb_open function I guess. If you have better i=
dea to deal with USB operation in btusb loader, please let me know.

>>>=20
>>> The overall patch looks fine to me and if it works for you I am fine do=
ing it. I think we just need to make sure this is clean and all angles are =
thought through before I merge it.
>>=20
>> My testing has been good & got couple of testing feedbacks said this pat=
ch is good to go.
>=20
>=20
> Yes. It is just cosmetics at this point.
>=20
> Regards
>=20
> Marcel
