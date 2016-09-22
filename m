Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?utf-8?B?TWljaGHFgg==?= Narajowski <michal.narajowski@codecoup.pl>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Fix local name in scan rsp
Date: Thu, 22 Sep 2016 21:07:59 +0200
Message-ID: <2407078.m1aT8J8x6x@ix>
In-Reply-To: <9A1998C8-0404-4A27-B594-A55E2D80540D@holtmann.org>
References: <1474552899-3837-1-git-send-email-michal.narajowski@codecoup.pl> <9A1998C8-0404-4A27-B594-A55E2D80540D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thursday, 22 September 2016 17:47:15 CEST Marcel Holtmann wrote:
> Hi Michal,
>=20
> > Use complete name if it fits. If not and there is short name
> > check if it fits. If not then use shortened name as prefix
> > of complete name.
> >=20
> > Signed-off-by: Micha=C5=82 Narajowski <michal.narajowski@codecoup.pl>
> > ---
> > net/bluetooth/hci_request.c | 46
> > +++++++++++++++++++++++++++++++++------------ 1 file changed, 34
> > insertions(+), 12 deletions(-)
> >=20
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index c813568..880758c 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -973,25 +973,47 @@ void __hci_req_enable_advertising(struct hci_requ=
est
> > *req)
> >=20
> > static u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
> > {
> > -	size_t name_len;
> > +	size_t complete_len;
> > +	size_t short_len;
> >=20
> > 	int max_len;
> > =09
> > 	max_len =3D HCI_MAX_AD_LENGTH - ad_len - 2;
> >=20
> > -	name_len =3D strlen(hdev->dev_name);
> > -	if (name_len > 0 && max_len > 0) {
> > +	complete_len =3D strlen(hdev->dev_name);
> > +	short_len =3D strlen(hdev->short_name);
> >=20
> > -		if (name_len > max_len) {
> > -			name_len =3D max_len;
> > -			ptr[1] =3D EIR_NAME_SHORT;
> > -		} else
> > -			ptr[1] =3D EIR_NAME_COMPLETE;
> > +	/* no space left for name */
> > +	if (max_len < 1)
> > +		return ad_len;
> >=20
> > -		ptr[0] =3D name_len + 1;
> > +	/* no name set */
> > +	if (!complete_len)
> > +		return ad_len;
> >=20
> > -		memcpy(ptr + 2, hdev->dev_name, name_len);
> > +	/* complete name fits */
> > +	if (complete_len <=3D max_len) {
> > +		ptr[0] =3D complete_len + 1;
> > +		ptr[1] =3D EIR_NAME_COMPLETE;
> > +		memcpy(ptr + 2, hdev->dev_name, complete_len);
> >=20
> > -		ad_len +=3D (name_len + 2);
> > -		ptr +=3D (name_len + 2);
> > +		return ad_len + complete_len + 2;
> > +	}
>=20
> so what we discussed is that at minimum 11 octets of name will be included
> into the scan response. That is the same size of the Short_name (which
> includes the nul-byte).

minimum? And do we need to put null byte there?

>=20
> If the full name is 11 octets or smaller, then that is included. If the f=
ull
> name is longer and a short name has been set, then the short name is used.
> If the short name is not set, then the full name is truncated to 11 octet=
s.
>=20
> For the case where the full name is 11 octets or smaller, the complete tag
> is used. For the case where the short name is used or the full name is
> truncated, the partial tag is used.

So we never include full name if it is longer then 11 octets (with null)?
BTW where this 11 octets value came from? I cannot find such requirement in=
=20
spec. Or this is just limited on mgmt interface level?

I don't undertand why not to include complete name if it fits, even if long=
er=20
than 11 octets.

> > +
> > +	/* shortened name set and fits */
>=20
> Just a note here, it is not called shortened name. It is the short name. =
We
> clearly separated the full name vs short name in the mgmt API.

It is called 'shortened' in both CoreSpec and CSS.=20

> Regards
>=20
> Marcel
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


=2D-=20
pozdrawiam
Szymon Janc
