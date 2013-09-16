Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: "'Mike Frysinger'" <vapier@chromium.org>, Bing Zhao <bzhao@marvell.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        Hyuckjoo Lee <hyuckjoo.lee@samsung.com>
Date: Mon, 16 Sep 2013 08:51:11 -0700
Subject: RE: [PATCH v4] Bluetooth: btmrvl: add calibration data download
 support
Message-ID: <5FF020A1CFFEEC49BD1E09530C4FF59510BD88214E@SC-VEXCH1.marvell.com>
In-Reply-To: <CAAbOScnG8RHWbPdjq6=e=EBJPr_f6+R4o36f3h0T=NxGgQt7AQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

Thanks for your comments. We will take care of them in updated version.

>=20
> On Fri, Sep 13, 2013 at 7:32 PM, Bing Zhao wrote:
> > --- a/drivers/bluetooth/btmrvl_main.c
> > +++ b/drivers/bluetooth/btmrvl_main.c
> >
> > +static int btmrvl_parse_cal_cfg(const u8 *src, u32 len, u8 *dst, u32
> dst_size)
>=20
> would be nice if you put a comment above this func explaining the
> expected format.  otherwise, we see arbitrary parsing with no idea if
> it's correct.

Sure. We will add below information.

Calibrated input data should contain hex bytes separated by space or
new line character. Here is an example
00 1C 01 37 FF FF FF FF 02 04 7F 01
CE BA 00 00 00 2D C6 C0 00 00 00 00
00 F0 00 00

>=20
> > +       while ((s - src) < len) {
> > +               if (isspace(*s)) {
> > +                       s++;
> > +                       continue;
> > +               }
> > +
> > +               if (isxdigit(*s)) {
> > +                       if ((d - dst) >=3D dst_size) {
> > +                               BT_ERR("calibration data file too
> big!!!");
> > +                               return -EINVAL;
> > +                       }
> > +
> > +                       memcpy(tmp, s, 2);
> > +
> > +                       ret =3D kstrtou8(tmp, 16, d++);
> > +                       if (ret < 0)
> > +                               return ret;
> > +
> > +                       s +=3D 2;
> > +               } else {
> > +                       s++;
> > +               }
> > +       }
>=20
> so if it's a space, you skip it.  if it's a hexdigit, you parse two
> bytes.  if it's anything else, you skip it.  i'd imagine the "non
> space and non hexdigit" case should throw a warning if not reject the
> file out right.  otherwise, if you want to keep this logic, punt the
> explicit "isspace" check.

You are right. Rejecting the file containing non space, non new line and no=
n hexdigit character makes sense.

>=20
> you might also copy one more byte than you should ?  your limit is "(s
> - src) < len", yet the isxdigit code always copies two bytes.

Thanks for pointing this out. We will replace "(s - src) < len" with "(s -s=
rc) <=3D (len - 2)".=20

>=20
> > +static int btmrvl_load_cal_data(struct btmrvl_private *priv,
> > +                               u8 *config_data)
> > +{
> > +       struct sk_buff *skb;
> > +       struct btmrvl_cmd *cmd;
> > +       int i;
> > +
> > +       skb =3D bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
>=20
> maybe i'm unfamiliar with bluetooth and this is common, but why is
> your code so special as to require GFP_ATOMIC allocations ?

GFP_ATOMIC was used to match other usages in bluetooth code.
I just found that as per commit "Remove GFP_ATOMIC usage from l2cap_core.c"=
(commit id: 8bcde1f2ab..), since bluetooth core is now running in process c=
ontext, we don't need to use GFP_ATOMIC.

We will replace it with GFP_KERNEL in updated version.

>=20
> > +       for (i =3D 4; i < BT_CMD_DATA_SIZE; i++)
> > +               cmd->data[i] =3D config_data[(i/4)*8 - 1 - i];
>=20
> style nit, but there should be spacing around those math operators.
> ignoring the fact that this is some funky funky buffer offsets.
>=20
> i =3D 4
>  config_data[(4 / 4) * 8 - 1 - 4] ->
>  config_data[8 - 1 - 4] ->
>  config_data[3]
>=20
> i =3D 5
>  config_data[(5 / 4) * 8 - 1 - 5] ->
>  config_data[8 - 1 - 5] ->
>  config_data[2]
>=20
> i =3D 6
>  config_data[(6 / 4) * 8 - 1 - 6] ->
>  config_data[8 - 1 - 6] ->
>  config_data[1]
>=20
> i =3D 7
>  config_data[(7 / 4) * 8 - 1 - 7] ->
>  config_data[8 - 1 - 7] ->
>  config_data[0]
>=20
> i =3D 8
>  config_data[(8 / 4) * 8 - 1 - 8] ->
>  config_data[16 - 1 - 8] ->
>  config_data[7]
>=20
> i =3D {4,5,6,7} -> config_data[{3,2,1,0}]
> i =3D {8,9,10,11} -> config_data[{7,6,5,4}]
>=20
> that really could do with a comment explaining the mapping of input
> bytes to output bytes.

Sure. We add a comment here.
Actually each 4 bytes are being swapped. Considering 4 byte SDIO header off=
set, it becomes
input{3, 2, 1, 0} -> output{0+4, 1+4, 2+4, 3+4}

Regards,
Amitkumar Karwar

> -mike
