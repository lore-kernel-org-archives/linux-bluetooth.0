Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@tieto.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix reporting incorrect EIR in device found mgmt event
Date: Wed, 20 May 2015 21:55:12 +0200
Message-ID: <2392277.yFK0Kh5x9r@athlon>
In-Reply-To: <59B793A7-A4A2-4F52-A942-B0DD9807D660@holtmann.org>
References: <1431600513-6793-1-git-send-email-szymon.janc@tieto.com> <59B793A7-A4A2-4F52-A942-B0DD9807D660@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tuesday 19 May 2015 21:17:40 Marcel Holtmann wrote:
> Hi Szymon,
>=20
> > Some remote devices (ie Gigaset G-Tag) misbehave with ADV data leng=
th.
> > This can lead to incorrect EIR format in device found event when
> > ADV_DATA and SCAN_RSP are merged (terminator field before SCAN_RSP
> > part).
> >=20
> > Fix this by inspecting ADV_DATA and correct its length if terminato=
r
> > is found.
> >=20
> >> HCI Event: LE Meta Event (0x3e) plen 42              [hci0] 32.172=
182
> >>=20
> >      LE Advertising Report (0x02)
> >     =20
> >        Num reports: 1
> >        Event type: Connectable undirected - ADV_IND (0x00)
> >        Address type: Public (0x00)
> >        Address: 7C:2F:80:94:97:5A (Gigaset Communications GmbH)
> >        Data length: 30
> >        Flags: 0x06
> >       =20
> >          LE General Discoverable Mode
> >          BR/EDR Not Supported
> >       =20
> >        Company: Gigaset Communications GmbH (384)
> >       =20
> >          Data: 021512348094975abbc5
> >       =20
> >        16-bit Service UUIDs (partial): 1 entry
> >       =20
> >          Battery Service (0x180f)
> >       =20
> >        RSSI: -65 dBm (0xbf)
> >>=20
> >> HCI Event: LE Meta Event (0x3e) plen 27              [hci0] 32.172=
191
> >>=20
> >      LE Advertising Report (0x02)
> >     =20
> >        Num reports: 1
> >        Event type: Scan response - SCAN_RSP (0x04)
> >        Address type: Public (0x00)
> >        Address: 7C:2F:80:94:97:5A (Gigaset Communications GmbH)
> >        Data length: 15
> >        Name (complete): Gigaset G-tag
> >        RSSI: -59 dBm (0xc5)
> >=20
> > Note "Data length: 30" in ADV_DATA which results in 9 extra zero by=
tes
> > after Battery Service UUID. Terminator field present in the middle =
of
> > EIR in Device Found event resulted in userspace stop parsing EIR an=
d
> > skipping device name.
> >=20
> > @ Device Found: 7C:2F:80:94:97:5A (1) rssi -59 flags 0x0000
> >=20
> >      02 01 06 0d ff 80 01 02 15 12 34 80 94 97 5a bb  ..........4..=
.Z.
> >      c5 03 02 0f 18 00 00 00 00 00 00 00 00 00 0e 09  .............=
...
> >      47 69 67 61 73 65 74 20 47 2d 74 61 67           Gigaset G-tag=

> >=20
> > With this fix EIR with merged ADV_DATA and SCAN_RSP in device found=

> > event is properly formatted:
> >=20
> > @ Device Found: 7C:2F:80:94:97:5A (1) rssi -59 flags 0x0000
> >=20
> >      02 01 06 0d ff 80 01 02 15 12 34 80 94 97 5a bb  ..........4..=
.Z.
> >      c5 03 02 0f 18 0e 09 47 69 67 61 73 65 74 20 47  .......Gigase=
t G
> >      2d 74 61 67                                      -tag
> >=20
> > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > ---
> > v2: fixed build error due to use of non-upstream BT_ERR_RATELIMITED=

> >=20
> > net/bluetooth/hci_event.c | 17 +++++++++++++++++
> > 1 file changed, 17 insertions(+)
> >=20
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 7b61be7..0407324 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4711,6 +4711,23 @@ static void process_adv_report(struct hci_de=
v
> > *hdev, u8 type, bdaddr_t *bdaddr,>=20
> > =09struct hci_conn *conn;
> > =09bool match;
> > =09u32 flags;
> >=20
> > +=09u8 *ptr, real_len;
> > +
> > +=09/* Find the 'real' end of the data in case remote incorrectly
> > +=09 * set significant part length.
>=20
> I do not understand this sentence. I assume what you want to say find=
 the
> end of the data in case the report contains padded zero bytes at the =
end
> causing an invalid length value.

Spec is says about significant and non-significant part of advertising =
(where=20
length is length of significant part) but I can rephrase that.

> > +=09 */
> > +=09for (ptr =3D data; ptr < data + len && *ptr; ptr +=3D *ptr + 1)=
 {
> > +=09=09if (ptr + 1 + *ptr > data + len)
> > +=09=09=09break;
> > +=09}
>=20
> I am worried about the unchecked usage of *ptr here. That might let y=
ou jump
> into some memory area. How are we protecting this against malicious
> advertising data. And we should have mgnt-tester test cases for malic=
ious
> fields that are not valid data and would make you jump outside of the=
 31
> bytes.

OK, I see now that data can be NULL in case of direct advertising repor=
t. I'll=20
add check for that and provide mgmt-tester cases for this and for bogus=
=20
advertising data as well.

> > +
> > +=09real_len =3D ptr - data;
> > +
> > +=09/* Adjust for actual length */
> > +=09if (len !=3D real_len) {
> > +=09=09BT_ERR("Corrected invalid ADV_DATA length=E2=80=9D);
>=20
> I would spell advertising report data length here. There really is no=

> ADV_DATA anywhere in the specification or used in BlueZ like that.

OK. Yet, I still wonder about ratelimit here. With 10 or more G-Tags ar=
ound=20
this can become quite spammy...

--=20
Szymon K. Janc
szymon.janc@gmail.com
