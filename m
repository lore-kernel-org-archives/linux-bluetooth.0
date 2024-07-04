Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC621AED49
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101830; cv=none; b=c5ArIw6k6VS8d0/yPKjaSnFKbnmHp165Ir0GKR3RQMxIJJXjN9c6/JxKAaPIB6l4Wd2k+d+lqq5dCL9QOEoXtyoxVoig5iyHxv0/RrhiuRAS5huq7BpfgIN2br6Uuf32pco8gJWoJOm68McZsCc/sJAnBXNrO8PTHGLKJDTrphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101830; c=relaxed/simple;
	bh=0I9Bz70gT826G6ZdYTShnJSKZukvCAk6r/lZDm6eaNU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPu3uIRPyOOx7pXGMe3bzzrIE/dmbKzgM4iBIUAPRugD1coeV9qVZm3/zbBXIReKPxgIEuaZxhhk1n2NDlQgoEeDDh+ik0XEebqZFZpkTdDaytu0gGtqqAGmjXltGQyr0tOmb0uKWN3TWxmzKRFh/08st0EHsLSijZ1KpHcuVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D6F31BF210;
	Thu,  4 Jul 2024 14:03:46 +0000 (UTC)
Message-ID: <86b5a90fef7eb8c440a9ea0ad5aac7be66fb7fe8.camel@hadess.net>
Subject: Re: [BlueZ 01/12] gatt-server: Don't allocate negative data
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Date: Thu, 04 Jul 2024 16:03:46 +0200
In-Reply-To: <1d92694f4c71324970862724d693c45c423f94ae.camel@iki.fi>
References: <20240704102617.1132337-1-hadess@hadess.net>
	 <20240704102617.1132337-2-hadess@hadess.net>
	 <1d92694f4c71324970862724d693c45c423f94ae.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Thu, 2024-07-04 at 15:25 +0300, Pauli Virtanen wrote:
> Hi,
>=20
> to, 2024-07-04 kello 12:24 +0200, Bastien Nocera kirjoitti:
> > Set a lower-bound to the data MTU to avoid allocating -1 elements
> > if
> > bt_att_get_mtu() returns zero.
> >=20
> > Error: OVERRUN (CWE-119): [#def36] [important]
> > bluez-5.76/src/shared/gatt-server.c:1121:2: zero_return: Function
> > call "bt_att_get_mtu(server->att)" returns 0.
> > bluez-5.76/src/shared/gatt-server.c:1121:2: assignment: Assigning:
> > "data->mtu" =3D "bt_att_get_mtu(server->att)". The value of "data-
> > >mtu" is now 0.
> > bluez-5.76/src/shared/gatt-server.c:1123:19: assignment: Assigning:
> > "__n" =3D "(size_t)(data->mtu - 1UL)". The value of "__n" is now
> > 18446744073709551615.
> > bluez-5.76/src/shared/gatt-server.c:1123:19: assignment: Assigning:
> > "__s" =3D "1UL".
> > bluez-5.76/src/shared/gatt-server.c:1123:19: overrun-buffer-arg:
> > Calling "memset" with "__p" and "__n * __s" is suspicious because
> > of the very large index, 18446744073709551615. The index may be due
> > to a negative parameter being interpreted as unsigned. [Note: The
> > source code implementation of the function has been overridden by a
> > builtin model.]
> > 1121|		data->mtu =3D bt_att_get_mtu(server->att);
> > 1122|		data->length =3D 0;
> > 1123|->		data->rsp_data =3D new0(uint8_t, data->mtu - 1);
> > 1124|
> > 1125|		return data;
> > ---
> > =C2=A0src/shared/gatt-server.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > index 3a53d5dfde6b..c587553d655d 100644
> > --- a/src/shared/gatt-server.c
> > +++ b/src/shared/gatt-server.c
> > @@ -1118,7 +1118,7 @@ static struct read_mult_data
> > *read_mult_data_new(struct bt_gatt_server *server,
> > =C2=A0	data->server =3D server;
> > =C2=A0	data->num_handles =3D num_handles;
> > =C2=A0	data->cur_handle =3D 0;
> > -	data->mtu =3D bt_att_get_mtu(server->att);
> > +	data->mtu =3D MAX(bt_att_get_mtu(server->att),
> > BT_ATT_DEFAULT_LE_MTU);
>=20
> Is this correct, probably MTU less than default are valid?

This is the same code as in bt_gatt_server_new().

>=20
> > =C2=A0	data->length =3D 0;
> > =C2=A0	data->rsp_data =3D new0(uint8_t, data->mtu - 1);
> > =C2=A0
>=20
> Might be better to instead: MAX(data->mtu, 1) - 1

I'd be fine with either, if somebody knows that particular part of the
code better than I do...
