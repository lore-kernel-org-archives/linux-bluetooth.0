Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B044B67E
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993074; cv=none; b=UnokeQXoD0M0ygsfw5h3k8y2WypzW5RxwvKJK38XE1JvAJz4nskrJAy+gZ85JGYjx0KHyqVfq/lJEXnJJHszhLqmDvdgGdLKotw+TDuWly9IjO9cwcmYzG/D7zU65BF8NOW8ZTT+KbgZ3rM+gPTzoB0LXs9FY4S/mPFsS/WdfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993074; c=relaxed/simple;
	bh=ggqwMYZjPQ++A2scxLufBuzGIJtpIIlCvJbxUG1jh+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oll6MoK37Ia/WuI29hwLRwQmTP1a4/icjATJVpc8itAKmTwsu8xEV3l8sewcrP6HpN8R6wiU4E9BXKipQbXYoTJvoASQa01REqmSy4UexlAwroDZNsHYHekk5YNj3dpRWXNXuX4jzOZlZ3EuZCOQzPi8lZ732+jGNcjUL9EYjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53B0B3EC64;
	Tue, 31 Mar 2026 21:37:45 +0000 (UTC)
Message-ID: <e6ce48e9a2d2b67ed069e91e7cc71f0ca8249a97.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/2] shared/util: Add MIN/MAX implementations
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 31 Mar 2026 23:37:44 +0200
In-Reply-To: <CABBYNZ+mm1q0gKCajcv4AnuNn13j5DXKzWAmDvCRj1LuGTfRag@mail.gmail.com>
References: <20260330143046.3497403-1-hadess@hadess.net>
	 <CABBYNZ+mm1q0gKCajcv4AnuNn13j5DXKzWAmDvCRj1LuGTfRag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: dmFkZTFRKhX9Yy4Gxo1H98ow0NcmVZmWydiNBl7SqHRuaGIuvRRR0q3R96dHJww3mihAJTgcHMz4u1Xc5YkQ+4eNPq9jGK2Yr7QERboTvgrTY5vLBsj0QkYu+JHNSDY3z5Y7PgYbTuCCSw3cHbIpSPSIzWEsBi1B0n08ylY3rM9q0ahUUZ7eHs8MNqVkLnPo1rAHP33m0xtWLPnMv4Oc9q3XrKBfUzGEA20ONWhdrQzyo2AtmcV+WqZNklt9UJ12Nys/y0I+JHpsZc5wGmOtjnlMWhMCCO0yY/ndOBbKapZOrzVgLMEm8cDhd4olwxokkuRy+OeUQReXYZ0b19RPiEkkMIu/WQZG3ceKTuC7lf3lSli0ZAGxmTj9GDVvXF3G1WSeriSeDW+vp68EhnFEId1X+IsValaFELnGDH36Hxsk9K3ORaYkeZ/hNYa6gjBzTSYKdDPuJ5uHWMfg000I/05FOnj8yVAPAF/L0fQ8qvSE0YtQSEH88fP8Lfv7ybnRTt6akQt5GNmafw3WpttpJi7rc8GTqdxbvAST1LDiMTmpFT5PV359t1TBfuiJpq9S1S0kvE6ZmpyzTSmCHFk3dAIF91cXr2VQ7L84XKnNRXWWZ6M/Y8+JBYKEUoqcG7kJ8BAyMQUOKXxnjf0964agWqnwjeK/Z4Cd85l9wJHGDJisYGewuA
X-GND-State: clean

On Tue, 2026-03-31 at 10:00 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Mon, Mar 30, 2026 at 10:42=E2=80=AFAM Bastien Nocera <hadess@hadess.ne=
t>
> wrote:
> >=20
> > And remove it from src/sdpd-request.c to avoid a redefinition
> > warning
> > at compile-time.
> > ---
> > =C2=A0src/sdpd-request.c | 2 --
> > =C2=A0src/shared/util.h=C2=A0 | 6 ++++++
> > =C2=A02 files changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/src/sdpd-request.c b/src/sdpd-request.c
> > index 1fc07e97bfe0..7c632c2aaf62 100644
> > --- a/src/sdpd-request.c
> > +++ b/src/sdpd-request.c
> > @@ -40,8 +40,6 @@ typedef struct {
> >=20
> > =C2=A0#define SDP_CONT_STATE_SIZE (sizeof(uint8_t) +
> > sizeof(sdp_cont_state_t))
> >=20
> > -#define MIN(x, y) ((x) < (y)) ? (x): (y)
> > -
> > =C2=A0typedef struct sdp_cont_info sdp_cont_info_t;
> >=20
> > =C2=A0struct sdp_cont_info {
> > diff --git a/src/shared/util.h b/src/shared/util.h
> > index c480351d6e9f..99a5aa2daf32 100644
> > --- a/src/shared/util.h
> > +++ b/src/shared/util.h
> > @@ -22,6 +22,12 @@
> > =C2=A0#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> > =C2=A0#define BIT(n)=C2=A0 (1 << (n))
> >=20
> > +#undef MIN
> > +#define MIN(a, b) ((a) > (b) ? (a) : (b))
> > +
> > +#undef MAX
> > +#define MAX(a, b) ((a) < (b) ? (a) : (b))
>=20
> This is causing many tests to fail with `make check`. It looks like
> the conditions are wrong, so MIN works as MAX and vice versa.

Whoops, fixed.

>=20
> > =C2=A0#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
> > =C2=A0#define le16_to_cpu(val) (val)
> > =C2=A0#define le32_to_cpu(val) (val)
> > --
> > 2.53.0
> >=20
> >=20
>=20
