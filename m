Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Bluetooth: btusb: Add support for QCA ROME chipset
 family
Date: Tue, 3 Mar 2015 13:57:35 +0000
Message-ID: <E0D4EC52-706A-4FB9-827B-ABFE1BDB1CA4@qca.qualcomm.com>
References: <403291a4c9b848f6956683e60c7e016f@nalasexr02e.na.qualcomm.com>
 <782CEA04-7241-4AC6-BD39-F0FEB49AAF2B@holtmann.org>
 <B37A934A-7A6F-4D02-A3A1-081BB5DC5A48@holtmann.org>
In-Reply-To: <B37A934A-7A6F-4D02-A3A1-081BB5DC5A48@holtmann.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mar 2, 2015, at 5:17 PM, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Ben,
>=20
>>> This patch supports ROME Bluetooth family from Qualcomm Atheros,
>>> e.g. QCA61x4 or QCA6574.
>>>=20
>>> New chipset have similar firmware downloading sequences to previous
>>> chipset from Atheros, however, it doesn't support vid/pid switching
>>> after downloading the patch so that firmware needs to be handled by
>>> btusb module directly.
>>>=20
>>> ROME chipset can be differentiated from previous version by reading
>>> ROM version.
>>>=20
>>> T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D 16 Spd=3D12 =
  MxCh=3D 0
>>> D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1
>>> P:  Vendor=3D0cf3 ProdID=3De300 Rev=3D 0.01
>>> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
>>> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
>>> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>>> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>>> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>>> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>>> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>>> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>>> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>>> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>>>=20
>>> T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  8 Spd=3D12 =
  MxCh=3D 0
>>> D:  Ver=3D 2.01 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1
>>> P:  Vendor=3D0cf3 ProdID=3De360 Rev=3D 0.01
>>> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
>>> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
>>> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>>> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>>> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>>> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>>> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>>> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>>> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>>> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
>>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>>>=20
>>> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 254 +++++++++++++++++++++++++++++++++++++++=
+++++++
>>> 1 file changed, 254 insertions(+)
>>=20
>> patch has been applied to bluetooth-next tree.
>=20
> and now I am regretting having applied this patch. Have you actually run =
make C=3D2 on this?
>=20
>  CHECK   drivers/bluetooth/btusb.c
> drivers/bluetooth/btusb.c:2677:11: warning: incorrect type in initializer=
 (different base types)
> drivers/bluetooth/btusb.c:2677:11:    expected restricted __le32 [usertyp=
e] rom_version
> drivers/bluetooth/btusb.c:2677:11:    got int
> drivers/bluetooth/btusb.c:2678:11: warning: incorrect type in initializer=
 (different base types)
> drivers/bluetooth/btusb.c:2678:11:    expected restricted __le32 [usertyp=
e] rom_version
> drivers/bluetooth/btusb.c:2678:11:    got int
> drivers/bluetooth/btusb.c:2679:11: warning: incorrect type in initializer=
 (different base types)
> drivers/bluetooth/btusb.c:2679:11:    expected restricted __le32 [usertyp=
e] rom_version
> drivers/bluetooth/btusb.c:2679:11:    got int
> drivers/bluetooth/btusb.c:2680:11: warning: incorrect type in initializer=
 (different base types)
> drivers/bluetooth/btusb.c:2680:11:    expected restricted __le32 [usertyp=
e] rom_version
> drivers/bluetooth/btusb.c:2680:11:    got int
> drivers/bluetooth/btusb.c:2681:11: warning: incorrect type in initializer=
 (different base types)
> drivers/bluetooth/btusb.c:2681:11:    expected restricted __le32 [usertyp=
e] rom_version
> drivers/bluetooth/btusb.c:2681:11:    got int
> drivers/bluetooth/btusb.c:2805:17: warning: restricted __le16 degrades to=
 integer
> drivers/bluetooth/btusb.c:2805:37: warning: restricted __le32 degrades to=
 integer
> drivers/bluetooth/btusb.c:2806:17: warning: restricted __le16 degrades to=
 integer
> drivers/bluetooth/btusb.c:2806:39: warning: restricted __le32 degrades to=
 integer
>=20
> Please fix this quickly. Getting endian conversion right is important.
>=20

Got same warning messages on latest patch. I=92ll send new patch to address=
 this warning output.

> Regards
>=20
> Marcel

Thanks
=97 Ben Kim=
