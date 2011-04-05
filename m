Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 5 Apr 2011 13:38:45 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] kstrtox: convert net/bluetooth/
Message-ID: <20110405162326.GB2259@joana>
References: <20110402111941.GB19357@p183.telecom.by>
 <20110404220002.GF2230@joana>
 <BANLkTimwBDydVTS2Crcbgiy7sKK+T49pHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTimwBDydVTS2Crcbgiy7sKK+T49pHw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexey,

* Alexey Dobriyan <adobriyan@gmail.com> [2011-04-05 15:33:47 +0300]:

> On Tue, Apr 5, 2011 at 1:00 AM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
>=20
> >> @@ -299,15 +300,13 @@ static ssize_t show_sniff_max_interval(struct de=
vice *dev, struct device_attribu
> >> =A0static ssize_t store_sniff_max_interval(struct device *dev, struct =
device_attribute *attr, const char *buf, size_t count)
> >> =A0{
> >> =A0 =A0 =A0 struct hci_dev *hdev =3D dev_get_drvdata(dev);
> >> - =A0 =A0 unsigned long val;
> >> -
> >> - =A0 =A0 if (strict_strtoul(buf, 0, &val) < 0)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> -
> >> - =A0 =A0 if (val < 0x0002 || val > 0xFFFE || val % 2)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> + =A0 =A0 u16 val;
> >> + =A0 =A0 int rv;
> >>
> >> - =A0 =A0 if (val < hdev->sniff_min_interval)
> >> + =A0 =A0 rv =3D kstrtou16(buf, 0, &val);
> >> + =A0 =A0 if (rv < 0)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return rv;
> >> + =A0 =A0 if (val =3D=3D 0 || val % 2 || val < hdev->sniff_min_interva=
l)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >
> > Why are you changing other things besides the string conversions?
>=20
> Because this is not mindless s/foo/bar/g conversion.
>=20
> > The checks for val should stay the same.
>=20
> No, they should not. kstrtou16() takes care of [0x0000, 0xFFFF] interval,
> then you check for even values, then you have only 0 to ban.
>=20
> WIth previous checks, say, "val > 0xFFFE" is not necessary,
> kstrtou16 + "val % 2" do it.

Ok, I agree, I didn't noted that at in a first review. Patch is now applied.
Thanks.


--=20
Gustavo F. Padovan
http://profusion.mobi
