Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A76136E30
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Aug 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045190; cv=none; b=AghRxqDSAbujsF1/VeZRfIVzHhXt5xq+VwPPYuMnkIRUbHvc294erF8tTv3ChLmAS3+w5JrDwyPEcXcIubU4K/OmbiXcExhosC9xscscqAB1X6RkJka4Mcl1hcaa76PtjWuZTBFhNi9WlGBODB9tBIEO9x2SJt5rq90OFEwj32U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045190; c=relaxed/simple;
	bh=L8NsJIvDAxk/N/oqHkQvJEaBvq1J3n93rtyXjaD8d70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Czha5TkpCpSnW9EtHLR2nLwAqZM0T2oaHoNsiffow6C8ApmQwOJ/uQ+wTle3NspV7wDBIZUWX5TYkV77SV//ofwTmwvgvp9vzQodsUsWNZ8rih2MQ7ihxevMMOa80Kqmf/uGR1lsb47WLHy+uARPM+a22swCwrd2uCl1kwx0kQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF6071BF208;
	Wed,  7 Aug 2024 15:39:45 +0000 (UTC)
Message-ID: <a86fa1676c72005cd77faabf65f9553242ea7a45.camel@hadess.net>
Subject: Re: [BlueZ 6/8] shared/gatt-db: Fix possible buffer overrun
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 07 Aug 2024 17:39:45 +0200
In-Reply-To: <CABBYNZLeuUw5nO-nw65nccSCKXcf-KLMxqDfPTObk-S3NP+tTQ@mail.gmail.com>
References: <20240805140840.1606239-1-hadess@hadess.net>
	 <20240805140840.1606239-7-hadess@hadess.net>
	 <CABBYNZLeuUw5nO-nw65nccSCKXcf-KLMxqDfPTObk-S3NP+tTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Tue, 2024-08-06 at 15:08 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Mon, Aug 5, 2024 at 10:09=E2=80=AFAM Bastien Nocera <hadess@hadess.net=
>
> wrote:
> >=20
> > uuid_to_le() returns one of the possible values from bt_uuid_len().
> > bt_uuid_len() returns "type / 8".
> > type is a value between 0 and 128, but could be something else
> > depending on the validity of the UUID that's parsed. So an invalid
> > value of type between 128 and 256 would trigger an overrun.
> >=20
> > Add a check to make sure that an invalid type isn't used to
> > calculate
> > the length.
> >=20
> > Error: OVERRUN (CWE-119): [#def6] [important]
> > bluez-5.77/src/shared/gatt-db.c:612:2: assignment: Assigning: "len"
> > =3D "uuid_to_le(uuid, value)". The value of "len" is now between 0
> > and 31 (inclusive).
> > bluez-5.77/src/shared/gatt-db.c:614:2: overrun-buffer-arg:
> > Overrunning array "value" of 16 bytes by passing it to a function
> > which accesses it at byte offset 30 using argument "len" (which
> > evaluates to 31).
> > 612|=C2=A0=C2=A0=C2=A0 len =3D uuid_to_le(uuid, value);
> > 613|
> > 614|->=C2=A0 service->attributes[0] =3D new_attribute(service, handle,
> > type, value,
> > 615|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 len);
> > 616|=C2=A0=C2=A0=C2=A0 if (!service->attributes[0]) {
> > ---
> > =C2=A0src/shared/gatt-db.c | 11 ++++++++---
> > =C2=A01 file changed, 8 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> > index b35763410d17..cd0eba6bf1d0 100644
> > --- a/src/shared/gatt-db.c
> > +++ b/src/shared/gatt-db.c
> > @@ -560,9 +560,14 @@ static int uuid_to_le(const bt_uuid_t *uuid,
> > uint8_t *dst)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return bt_uuid_len(uuid);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_uuid_to_uuid128(uuid, &uuid128=
);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bswap_128(&uuid128.value.u128, ds=
t);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bt_uuid_len(&uuid128);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (uuid->type =3D=3D BT_UUID32 |=
|
>=20
> BT_UUID32 is not really valid in LE, so Id leave this check to be:
>=20
> switch (uuid->type) {
> case BT_UUID16:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_le16(uuid->value.u16, dst)=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bt_uuid_len(uuid);
> case BT_UUID128:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_uuid_to_uuid128(uuid,=
 &uuid128);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bswap_128(&uuid128.value=
.u128, dst);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bt_uuid_len(&uuid=
128);
> }
>=20
> return 0;
>=20
> We do however have bt_uuid_to_le with the only difference being that
> it is more generic and it doesn't return the actual bytes written to
> the dst, anyway we could replace the code above with:
>=20
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index b35763410d17..71976de48569 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -553,16 +553,9 @@ bool gatt_db_isempty(struct gatt_db *db)
>=20
> =C2=A0static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_uuid_t uuid128;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_uuid_to_le(uuid, dst);
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (uuid->type =3D=3D BT_UUID16) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 put_le16(uuid->value.u16, dst);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return bt_uuid_len(uuid);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_uuid_to_uuid128(uuid, &uuid128);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bswap_128(&uuid128.value.u128, dst)=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bt_uuid_len(&uuid128);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bt_uuid_len(uuid) =3D=3D 4 ?=
 16 : bt_uuid_len(uuid);

Or this with error checking?

static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
{
        if (bt_uuid_to_le(uuid, dst) < 0)=20
                return 0;
        return bt_uuid_len(uuid) =3D=3D 4 ? 16 : bt_uuid_len(uuid);
}

> =C2=A0}
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid->typ=
e =3D=3D BT_UUID128) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bt_uuid_to_uuid128(uuid, &uuid128);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bswap_128(&uuid128.value.u128, dst);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return bt_uuid_len(&uuid128);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
> >=20
> > =C2=A0static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t
> > *uuid)
> > --
> > 2.45.2
> >=20
> >=20
>=20
>=20

