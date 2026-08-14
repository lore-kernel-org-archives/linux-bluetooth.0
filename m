Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E9370AF1
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716050; cv=none; b=M9fJoHzIc2nujbkrnl3hNpejNLoaoIYkUhIYRwe+WEiRqaKDqDeXT6Maxew2M1lYHpAEjjnuOvbGI+/vYQzTC86l5jwjA2oaEgdsn84RZiGYrnGDQcGrcBWCbvwLsvh/8Fnppz9MNfkxVXswuzU/qOTV6Bql8RMZ1g//rpFBWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716050; c=relaxed/simple;
	bh=GXfGACyR0EkakL7HzVxDpBpsCaKRThf1LV6QTuTvUs0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6ESderVOlFTUUhi6o9weHGuuruiwbdicv7W4KXlHLD4Rb5uIPj1OBKoLU+zp39TY5gfGD3b6p0d4uJ4W9jsYyR56sJlS8COMYM/IxXmDyi7n4t1dud9LDfXE41hcB0VrRxYdQRA1iwrx+8mOE1ooWG7QHIjOct2c+yy/InN5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF9E23ECC4;
	Fri, 14 Aug 2026 14:00:37 +0000 (UTC)
Message-ID: <402e9994069430a05832cde20430880b9bd97636.camel@hadess.net>
Subject: Re: [BlueZ, v3 2/5] unit: Remove left-over test-avrcp Android test
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 14 Aug 2026 16:00:37 +0200
In-Reply-To: <CABBYNZK7iPm4_y++hmRypfqnZ2oE-3J0fWYnpYpA8fORgxsO7g@mail.gmail.com>
References: <20260806132231.3052523-1-hadess@hadess.net>
	 <20260806132231.3052523-3-hadess@hadess.net>
	 <CABBYNZK7iPm4_y++hmRypfqnZ2oE-3J0fWYnpYpA8fORgxsO7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: dmFkZTEXGw9ooNIju5hbBLVEVWBoU0iOfsAdPreSSDVIWeOYS9EhTXntm+7lz1/jzl9Yh4cxuN9TzYz+TvbXCZU7bAr6ewKgCqUF0Q0hS52rS9FWOJ/JcMBsxiqus9SaHPROI7UHt94tGBJOIymqu3Fn8GKpOzVOazewPPFdK8SF1iRCCq7t/3B2dN8WdNRxQcdDLY057DvCUcHgkCHsacDfIEO5ZMCpZxdgfdAA/szTdifbxB5NBJPtcg443CTI8omEFzhvr8xYxsUP0egKrT1WnY6xzJ7NVayt7Jc8WdzDAWKYxeEnvH5L3ZdMNu6iyB1T2Si1Sm36soh0ZNSnsTpQMuN5XOUnvQ8liG82kPtLV3gSh3S6TV+CLnEYPPQ3F3lEXsoTAzDa/slQMkUqdb0Jpf9izXstjtXZh/X2qDIcgt9//zLNC1/rgsIHRnmbC13dPWNLDDAOqlUqbNZdPw3ZZCbVV6UqwKUpINqyBzEr1YheeHH1GWJWCvVPNoIh6yMN8aWoDV2rKDburWF2vMuV97vjmsNv4+EhtJgpubS9oq8CmhjGnIhgzOt/YiAbv6iQbSVB2dtMTCf56XpSa3OiT0sOwhJ7K9Yu74SkQkUpE14Fn2poKYUzpHeP2ocAHU8j0XnlzJRsoTGgMy7k+WQEortb8qI8UuMy2IbIs/UjHAKfAQ
X-GND-State: clean

On Thu, 2026-08-06 at 10:14 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Thu, Aug 6, 2026 at 9:29=E2=80=AFAM Bastien Nocera <hadess@hadess.net>
> wrote:
> >=20
> > This test was supposed to exercise the avrcp-lib from the Android
> > backend, but that backend was removed, and the library moved into
> > the unit/ directory.
> >=20
> > The tests provide 0% coverage towards profiles/audio so they're
> > just
> > dead code we should remove.
> > ---
> > =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 9 -
> > =C2=A0unit/avrcp-lib.c=C2=A0 | 3604 -----------------------------------=
------
> > ----
> > =C2=A0unit/avrcp-lib.h=C2=A0 |=C2=A0 343 -----
> > =C2=A0unit/test-avrcp.c | 2084 --------------------------
> > =C2=A04 files changed, 6040 deletions(-)
> > =C2=A0delete mode 100644 unit/avrcp-lib.c
> > =C2=A0delete mode 100644 unit/avrcp-lib.h
> > =C2=A0delete mode 100644 unit/test-avrcp.c
> >=20
> > diff --git a/Makefile.am b/Makefile.am
> > index 19c468d3a504..f4f638323c79 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -651,15 +651,6 @@ unit_test_avctp_SOURCES =3D unit/test-avctp.c \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unit/avctp.c unit/avctp.h
> > =C2=A0unit_test_avctp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
> >=20
> > -unit_tests +=3D unit/test-avrcp
> > -
> > -unit_test_avrcp_SOURCES =3D unit/test-avrcp.c \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src/log.h src/log.c \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unit/avctp.c unit/avctp.h \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unit/avrcp-lib.c unit/avrcp-lib.h
> > -unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.la \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src/libshared-glib.la $(GLIB_LIBS)
>=20
> The tests are valid, what isn't valid is that it doesn't test the
> right implementation, I understand this is a much bigger work though.

I'm pretty certain that reviving them is a complete rewrite, and right
now, it just takes compile and testing time all for nothing.

If somebody wants to revive those tests, they're a "git revert" away.
