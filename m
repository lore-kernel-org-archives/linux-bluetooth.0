Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3B137C36
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720122668; cv=none; b=bAplTyMhKOgowT31Y29jy++i73XOWc5TkZ8lhLMxMcVx9MuTDvpqEZLr+Ey9ZA1QBcJHkeZ+yG1JfAgpWo5+WeA0ZmaseapGq4dgnj/MwKfEiYaRLHBv8IRS65pR5Xk1oW+5PjMExOg75uQLWhvV1JKgOEUZ7+xZjpieq1UvWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720122668; c=relaxed/simple;
	bh=XlgxD1X0rlIvgIMCdaQlP7wqPfXR6DrEEwa4ADkGg6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BtUdlkgIro/nUGyaHgUM6vbLuGrhpFaOvouoZlw3pJWg2c5QcI9G7jDXfoxkp35MHmzK5vmQpjK9VsoIqDfQRLB9AgROGEwaOJQniKLA/bKRIAP4HQp4AgOL2/9LzFkrFZ5c7+uP3c/kugtbPTDzEiMy4w+vH9sbUWCLIHgol0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9608240002;
	Thu,  4 Jul 2024 19:51:03 +0000 (UTC)
Message-ID: <0b647d8fd3fd6e3ccf748bcdacfd4b89f5098ae0.camel@hadess.net>
Subject: Re: [BlueZ 11/12] tools/mesh: Fix integer overflow due to cast
 operation
From: Bastien Nocera <hadess@hadess.net>
To: Brian Gix <bggixx@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 04 Jul 2024 21:51:03 +0200
In-Reply-To: <C7C313BA-2B8A-4638-81E8-80ED55CE07B6@gmail.com>
References: <20240704102617.1132337-12-hadess@hadess.net>
	 <C7C313BA-2B8A-4638-81E8-80ED55CE07B6@gmail.com>
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

On Thu, 2024-07-04 at 11:45 -0700, Brian Gix wrote:
>=20
> > On Jul 4, 2024, at 3:27=E2=80=AFAM, Bastien Nocera <hadess@hadess.net>
> > wrote:
> >=20
> > =EF=BB=BFError: INTEGER_OVERFLOW (CWE-190): [#def29] [important]
> > bluez-5.76/tools/mesh/mesh-db.c:551:3: cast_overflow: Truncation
> > due to cast operation on "ele_cnt" from 32 to 8 bits.
> > bluez-5.76/tools/mesh/mesh-db.c:551:3: overflow_sink: "ele_cnt",
> > which might have overflowed, is passed to "remote_add_node((uint8_t
> > const *)uuid, unicast, ele_cnt, key_idx)".
> > 549|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
continue;
> > 550|
> > 551|->=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 remote_add_node((const=
 uint8_t *)uuid, unicast,
> > ele_cnt,
> > 552|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key_idx);
> > 553|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =3D 1; j < key_cn=
t; j++) {
> > ---
> > tools/mesh/mesh-db.c | 6 ++----
> > 1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
> > index 1d047691d240..abcc09d523a5 100644
> > --- a/tools/mesh/mesh-db.c
> > +++ b/tools/mesh/mesh-db.c
> > @@ -503,7 +503,8 @@ static void load_remotes(json_object *jcfg)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t uuid[16];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t unicast, key_idx;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *str;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ele_cnt, key_cnt;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t ele_cnt;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int key_cnt;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int j;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jnode =3D json_object_array_get_id=
x(jnodes, i);
> > @@ -533,9 +534,6 @@ static void load_remotes(json_object *jcfg)
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ele_cnt =3D json_object_array_leng=
th(jarray);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ele_cnt > MAX_ELE_COUNT=
)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue;
> > -
>=20
> What happens if the json file is corrupted and there are more than
> 255 elements in the array?

ele_cnt is a uint8_t, so it will wrap around.

We could add that if you preferred (I checked, and the array length is
cached):

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index abcc09d523a5..4c74e874986c 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -529,7 +529,8 @@ static void load_remotes(json_object *jcfg)
                        continue;
=20
                json_object_object_get_ex(jnode, "elements", &jarray);
-               if (!jarray || json_object_get_type(jarray) !=3D json_type_=
array)
+               if (!jarray || json_object_get_type(jarray) !=3D json_type_=
array ||
+                   json_object_array_length(jarray) > MAX_ELE_COUNT)
                        continue;
=20
                ele_cnt =3D json_object_array_length(jarray);



>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 json_object_object_get_ex(jnode, "=
netKeys", &jarray);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!jarray || json_object_get_typ=
e(jarray) !=3D
> > json_type_array)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > --
> > 2.45.2
> >=20
> >=20

