Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth:btusb:fix incorrect type in initializer
Date: Mon, 9 Mar 2015 23:37:21 +0000
Message-ID: <771A272D-6934-4208-9CDE-09949BA3DE49@qca.qualcomm.com>
References: <E72C4779-837E-45DC-8256-AAA4F01DE182@qca.qualcomm.com>
 <,<20150306085517.GA20795@t440s.lan> <>>
 <093F1F09-B7D5-4ED3-B9E2-559CA4AC7710@qca.qualcomm.com>
 <22B47A84-0790-430D-A3DA-A3D55C927B45@holtmann.org>
In-Reply-To: <22B47A84-0790-430D-A3DA-A3D55C927B45@holtmann.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel/Johan,

On Mar 6, 2015, at 7:49 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Ben,
>=20
>>>> On Tue, Mar 03, 2015, Kim, Ben Young Tae wrote:
>>>> This fixes the following sparse warning:
>>>>=20
>>>> drivers/bluetooth/btusb.c:2677:11: warning: incorrect type in initiali=
zer (different base types)
>>>> drivers/bluetooth/btusb.c:2677:11: expected restricted __le32 [usertyp=
e] rom_version
>>>> drivers/bluetooth/btusb.c:2677:11: got int
>>>> drivers/bluetooth/btusb.c:2678:11: warning: incorrect type in initiali=
zer (different base types)
>>>> drivers/bluetooth/btusb.c:2678:11: expected restricted __le32 [usertyp=
e] rom_version
>>>> drivers/bluetooth/btusb.c:2678:11: got int
>>>> drivers/bluetooth/btusb.c:2679:11: warning: incorrect type in initiali=
zer (different base types)
>>>> drivers/bluetooth/btusb.c:2679:11: expected restricted __le32 [usertyp=
e] rom_version
>>>> drivers/bluetooth/btusb.c:2679:11: got int
>>>> drivers/bluetooth/btusb.c:2680:11: warning: incorrect type in initiali=
zer (different base types)
>>>> drivers/bluetooth/btusb.c:2680:11: expected restricted __le32 [usertyp=
e] rom_version
>>>> drivers/bluetooth/btusb.c:2680:11: got int
>>>> drivers/bluetooth/btusb.c:2681:11: warning: incorrect type in initiali=
zer (different base types)
>>>> drivers/bluetooth/btusb.c:2681:11: expected restricted __le32 [usertyp=
e] rom_version
>>>> drivers/bluetooth/btusb.c:2681:11: got int
>>>> drivers/bluetooth/btusb.c:2805:17: warning: restricted __le16 degrades=
 to integer
>>>> drivers/bluetooth/btusb.c:2805:37: warning: restricted __le32 degrades=
 to integer
>>>> drivers/bluetooth/btusb.c:2806:17: warning: restricted __le16 degrades=
 to integer
>>>> drivers/bluetooth/btusb.c:2806:39: warning: restricted __le32 degrades=
 to integer
>>>>=20
>>>> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
>>>> ---
>>>> drivers/bluetooth/btusb.c | 14 +++++++-------
>>>> 1 file changed, 7 insertions(+), 7 deletions(-)
>>>>=20
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>> index 0833054..f65cd44 100644
>>>> --- a/drivers/bluetooth/btusb.c
>>>> +++ b/drivers/bluetooth/btusb.c
>>>> @@ -2674,11 +2674,11 @@ struct qca_device_info {
>>>> };
>>>>=20
>>>> static const struct qca_device_info qca_devices_table[] =3D {
>>>> -    { 0x00000100, 20, 4, 10 }, /* Rome 1.0 */
>>>> -    { 0x00000101, 20, 4, 10 }, /* Rome 1.1 */
>>>> -    { 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
>>>> -    { 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
>>>> -    { 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
>>>> +    { cpu_to_le32(0x00000100), 20, 4, 10 }, /* Rome 1.0 */
>>>> +    { cpu_to_le32(0x00000101), 20, 4, 10 }, /* Rome 1.1 */
>>>> +    { cpu_to_le32(0x00000201), 28, 4, 18 }, /* Rome 2.1 */
>>>> +    { cpu_to_le32(0x00000300), 28, 4, 18 }, /* Rome 3.0 */
>>>> +    { cpu_to_le32(0x00000302), 28, 4, 18 }, /* Rome 3.2 */
>>>> };
>>>=20
>>> Since "struct qca_device_info" doesn't describe raw protocol data I
>>> don't think it should contain protocol endianness values, i.e. the
>>> rom_version member should be u32 instead of __le32.
>>>=20
>>=20
>> The rom_version will be coming from chipset when we ask chip version to =
soc at the first time and we are comparing to this during initialization. I=
 think this should be _le32 type.
>=20
> I made a mistake in the review actually that I only now realized it. And =
this means that you really have not tested anything on big-endian architect=
ures or just got lucky with the current values.
>=20
> So lets keep qca_device_info in host endian. It is a host data structure.=
 It is not a wire data structure.
>=20
> This is actually the broken one:
>=20
>        if (rver->rom_version !=3D ver->rom_version ||
>            rver->patch_version <=3D ver->patch_version) {
>=20
> You are now comparing little-endian values. That works all fine on a litt=
le-endian system, but on a big-endian system the <=3D comparison might not =
give you the result you are hoping for. So this all needs to be done with h=
ost endian values.
>=20
> Move qca_device_info to host endian and then go through the code and then=
 do the little-endian transformation of data from the the hardware. You can=
 easily check with spares (C=3D2) if you are doing this correctly.
>=20

Does host endian mean to use u32/u8 type instead of __le or __be? If yes, I=
=92ll work on this and send you the patch soon after verifying it with C=3D=
2 option.

> Regards
>=20
> Marcel
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
=97 Ben Kim=
