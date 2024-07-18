Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8F1411E7
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310516; cv=none; b=JOG6Q0G9d7aED9R6tO0L5hwzpU+MkBDBJzx0iAT3WSLq3k9O/uDSuAmJMPBG0eylnfJsn+M0wRLYmnPdd9kd0gcDOSzLD8Cg/m4fVca2pmwyeTBSE5cCRvQy3Fb4piQ4oQRgj7gbrI337iw7ImIRiYqRAiO3XKeDJSGDVPmy1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310516; c=relaxed/simple;
	bh=M2eKnknpZT6H4iBrd00oq/eX6MM2V1NQocIQ24amQf4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uxYDAc6Kkw3GusZkVoN1YoFGf1Yr7UqPI+UXGnwjgsb4JY7ngRy2gg3XIznWvMEUxT3LjhYs4qd18rBAQVVYre205yPUz/s1PMQ9SbnCwAmc0P60SNLi25q9U0RjqPfoMdVufeXr4shIVROLvv1S8u5pcq75fEc+7Wj/SWsrS4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 813CE20002;
	Thu, 18 Jul 2024 13:48:26 +0000 (UTC)
Message-ID: <c9240ade6670887af205a0b6a6c3c936cc8583df.camel@hadess.net>
Subject: Re: [BlueZ v2 01/11] gatt-server: Don't allocate negative data
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 18 Jul 2024 15:48:26 +0200
In-Reply-To: <5763c696d519074969d3ddcb6c1468a44bebba07.camel@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
	 <20240705085935.1255725-2-hadess@hadess.net>
	 <CABBYNZ+dDvU4nUeCU+9VNfynmQ1iajp=SkD_oFf4F8wxWqsh9g@mail.gmail.com>
	 <5763c696d519074969d3ddcb6c1468a44bebba07.camel@hadess.net>
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

On Thu, 2024-07-18 at 14:40 +0200, Bastien Nocera wrote:
> On Mon, 2024-07-08 at 10:44 -0400, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >=20
> > On Fri, Jul 5, 2024 at 5:00=E2=80=AFAM Bastien Nocera <hadess@hadess.ne=
t>
> > wrote:
> > >=20
> > > Set a lower-bound to the data MTU to avoid allocating -1 elements
> > > if
> > > bt_att_get_mtu() returns zero.
> > >=20
> > > Error: OVERRUN (CWE-119): [#def36] [important]
> > > bluez-5.76/src/shared/gatt-server.c:1121:2: zero_return: Function
> > > call "bt_att_get_mtu(server->att)" returns 0.
> > > bluez-5.76/src/shared/gatt-server.c:1121:2: assignment:
> > > Assigning:
> > > "data->mtu" =3D "bt_att_get_mtu(server->att)". The value of "data-
> > > > mtu" is now 0.
> >=20
> > We are disconnected or have an invalid bt_att instance if
> > bt_att_get_mtu returns 0 so it is probably pointless to attempt to
> > send any response if that is the case.
>=20
> Same as for patch 8 in this series:
> gatt-server: Fix integer overflow due to cast operation
>=20
> Is "1" a valid value here?

Never mind, Coverity is happy, so I'm happy too.

>=20
> >=20
> > > bluez-5.76/src/shared/gatt-server.c:1123:19: assignment:
> > > Assigning:
> > > "__n" =3D "(size_t)(data->mtu - 1UL)". The value of "__n" is now
> > > 18446744073709551615.
> > > bluez-5.76/src/shared/gatt-server.c:1123:19: assignment:
> > > Assigning:
> > > "__s" =3D "1UL".
> > > bluez-5.76/src/shared/gatt-server.c:1123:19: overrun-buffer-arg:
> > > Calling "memset" with "__p" and "__n * __s" is suspicious because
> > > of the very large index, 18446744073709551615. The index may be
> > > due
> > > to a negative parameter being interpreted as unsigned. [Note: The
> > > source code implementation of the function has been overridden by
> > > a
> > > builtin model.]
> > > 1121|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dat=
a->mtu =3D bt_att_get_mtu(server->att);
> > > 1122|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dat=
a->length =3D 0;
> > > 1123|->=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->rsp_dat=
a =3D new0(uint8_t, data->mtu - 1);
> > > 1124|
> > > 1125|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn data;
> > > ---
> > > =C2=A0src/shared/gatt-server.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > > index 3a53d5dfde6b..66e370d1fe3d 100644
> > > --- a/src/shared/gatt-server.c
> > > +++ b/src/shared/gatt-server.c
> > > @@ -1120,7 +1120,7 @@ static struct read_mult_data
> > > *read_mult_data_new(struct bt_gatt_server *server,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->cur_handle =3D 0;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->mtu =3D bt_att_get_m=
tu(server->att);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->length =3D 0;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->rsp_data =3D new0(uint8_t=
, data->mtu - 1);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->rsp_data =3D new0(uint8_t=
, MAX(data->mtu, 1) - 1);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return data;
> > > =C2=A0}
> > > --
> > > 2.45.2
> > >=20
> > >=20
> >=20
> >=20
>=20

