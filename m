Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CA527448
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721306310; cv=none; b=aXXLrPoqhddjmWD2yXW446r3lhk7FvLJZasgjWe1T1tQBuY4p3mfMN1ZKXQ8pzqPOlw4xvyBu3uzKpFgSbtcipKNUj3lDOfacgKWnbuSv4947onvj+1pH4CR/8O6PA2ONVXyOolsCccnnrl+njB8n2LA9ObIiR5bYP2TbFTUwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721306310; c=relaxed/simple;
	bh=wwuLXnD6RfnERuXqTJRgJm022ByhPZc4u7k7qzXdZUc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UwMnejBPcNmU6RKVfsqA7fnH6GLpne3NCyqbK93i2fbyoGamc3gOSgz/dAiZfMVvcCBDD+eNf91hGrYnEWrOcSgiGYgKtaeMevsyXV9UBByBB2sFpX0LtlLeVndBlo3/luidPBVSCCGk8I4iT4K3yC8Ty5pZFSy0WghwyOPyxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1485860004;
	Thu, 18 Jul 2024 12:38:19 +0000 (UTC)
Message-ID: <bf4942f84289df1b6983607c7ab0ad209f74d9b1.camel@hadess.net>
Subject: Re: [BlueZ v2 08/11] gatt-server: Fix integer overflow due to cast
 operation
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 18 Jul 2024 14:38:19 +0200
In-Reply-To: <CABBYNZLot6GBtvSGLyn_+wtk6RVCO6OuS23VoVuVcxMYLvaeog@mail.gmail.com>
References: <20240705085935.1255725-1-hadess@hadess.net>
	 <20240705085935.1255725-9-hadess@hadess.net>
	 <CABBYNZLot6GBtvSGLyn_+wtk6RVCO6OuS23VoVuVcxMYLvaeog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Mon, 2024-07-08 at 11:17 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Fri, Jul 5, 2024 at 5:00=E2=80=AFAM Bastien Nocera <hadess@hadess.net>
> wrote:
> >=20
> > Error: INTEGER_OVERFLOW (CWE-190): [#def25] [important]
> > bluez-5.76/src/shared/gatt-server.c:927:2: cast_overflow:
> > Truncation due to cast operation on "((unsigned int)mtu - 1U < len)
> > ? (unsigned int)mtu - 1U : len" from 32 to 16 bits.
> > bluez-5.76/src/shared/gatt-server.c:927:2: overflow_sink:
> > "((unsigned int)mtu - 1U < len) ? (unsigned int)mtu - 1U : len",
> > which might have overflowed, is passed to "bt_att_chan_send(op-
> > >chan, rsp_opcode, (len ? value : NULL), (((unsigned int)mtu - 1U <
> > len) ? (unsigned int)mtu - 1U : len), NULL, NULL, NULL)".
> > 925|=C2=A0=C2=A0=C2=A0 rsp_opcode =3D get_read_rsp_opcode(op->opcode);
> > 926|
> > 927|->=C2=A0 bt_att_chan_send_rsp(op->chan, rsp_opcode, len ? value :
> > NULL,
> > 928|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIN((=
unsigned int) mtu - 1,
> > len));
> > 929|=C2=A0=C2=A0=C2=A0 async_read_op_destroy(op);
> > ---
> > =C2=A0src/shared/gatt-server.c | 6 +++---
> > =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > index 66e370d1fe3d..e0e1776779cd 100644
> > --- a/src/shared/gatt-server.c
> > +++ b/src/shared/gatt-server.c
> > @@ -908,7 +908,7 @@ static void read_complete_cb(struct
> > gatt_db_attribute *attr, int err,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct async_read_op *op =3D=
 user_data;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bt_gatt_server *serve=
r =3D op->server;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t rsp_opcode;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t mtu;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t mtu;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t handle;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG(server, "Read Complete: =
err %d", err);
> > @@ -916,7 +916,7 @@ static void read_complete_cb(struct
> > gatt_db_attribute *attr, int err,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mtu =3D bt_att_get_mtu(serve=
r->att);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle =3D gatt_db_attribute=
_get_handle(attr);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err || mtu <=3D 1) {
>=20
> Also pointless here if the mtu is 0 then we should not attempt to
> send anything.

There's more than one fix in this patch. One is the data type used
(should be a size_t, not a uint16_t), the other is avoid a negative or
zero pdu value. What happens to guard against a "1" mtu? Do we need to
guard against it?

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bt_att_chan_send_error_rsp(op->chan, op->opcode,
> > handle, err);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 async_read_op_destroy(op);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> > @@ -925,7 +925,7 @@ static void read_complete_cb(struct
> > gatt_db_attribute *attr, int err,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rsp_opcode =3D get_read_rsp_=
opcode(op->opcode);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_att_chan_send_rsp(op->cha=
n, rsp_opcode, len ? value :
> > NULL,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 MIN((unsigned int) mtu - 1,
> > len));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 MIN(mtu - 1, len));
>=20
> And this is incorrect as well, we need the mtu of the channel here
> not
> bt_att_get_mtu.

I see you fixed this in 110a8b47a4f159a8239795255b6c1c0edd79e4cd
Thanks!

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 async_read_op_destroy(op);
> > =C2=A0}
> >=20
> > --
> > 2.45.2
> >=20
> >=20
>=20
>=20

