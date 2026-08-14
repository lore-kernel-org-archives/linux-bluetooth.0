Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB792356772
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716058; cv=none; b=jtAJEbMxB9nyvvPZBfiIoOfMgoQ4vlATiHYuZkfKEypB74nFdGVthmPsdayE1z9U9DiyiZvIaUrx2kEjHrdfA/DHZeLkl4AU6hedRtABHnic4vueAOEZM3c+TVuIMJeNVFoFoaaSnpHH/yrbgbV0Ddz57zEASDw88m/iyWZFjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716058; c=relaxed/simple;
	bh=3LvIt1uBHNUiOgXZAkfcdTN5gHXKoD+3PKqGuwphyNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XYBMig3g5O8TQPM2xR+4npAEtMTqSv4Z5eQs6HS7gn5j1IXHelEKS5Ntod5b1KvXMKBUiJk/7BCkx8lvN3dKRY2BLCHlLUJ69WBg7hPWkSuAHzPPEDyh12xZy1fBbCYyjU+UfGfjgOwowTm5ca/DZ3YUvK0qMuE06x3jdAGiHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id CAC453EC99;
	Fri, 14 Aug 2026 14:00:47 +0000 (UTC)
Message-ID: <df8e5ede247fe29272263524f546e467459411da.camel@hadess.net>
Subject: Re: [BlueZ, v2 1/3] avrcp: Split off name parsing from
 parse_*_element()
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 14 Aug 2026 16:00:47 +0200
In-Reply-To: <CABBYNZ+MErHXc4N3FYN53pQhLn6YKtrkvMm66s1dab92HOjfgw@mail.gmail.com>
References: <20260804142419.2274153-1-hadess@hadess.net>
	 <20260804142419.2274153-2-hadess@hadess.net>
	 <CABBYNZKb7_6CBD_Aq27PHUqA5=_P_NeyY4qcKOjCNk-dRN6-cw@mail.gmail.com>
	 <e534cfe2f4fa335ebeb795e1c704584d77f3e1ed.camel@hadess.net>
	 <CABBYNZ+MErHXc4N3FYN53pQhLn6YKtrkvMm66s1dab92HOjfgw@mail.gmail.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEXGw9ooNIju5hbBLVEVWBoU0iOfsAdPreSSDVIWeOYS9EhTXntm+7lz1/jzl9Yh4cxuN9TzYz+TvbXCZU7bAr6ewKgCqUF0Q0hS52rS9FWOJ/JcMBsxiqus9SaHPROI7UHt94tGBJOIymqu3Fn8GKpOzVOazewPPFdK8SF1iRCCq7t/3B2dN8WdNRxQcdDLY057DvCUcHgkCHsacDfIEO5ZMCpZxdgfdAA/szTdifbxB5NBJPtcg443CTI8omEFzhvr8xYxsUP0egKrT1WnY6xzJ7NVayt7Jc8WdzDAWKYxeEnvH5L3ZdMNu6iyB1T2Si1Sm36soh0ZNSnsTpQMuN5XHf2udFIGwXiJUovYMXK84bE4oCpcnztJBQip02z5KbXxNjVKwUn02kMvjwSQvV852batq4Hb56tfMYMsheDZc0m+Y2k3d/Sd1ZqfbwObncSWuFb7MqaTFk3Sck9E+AoSAe01gO/7XfYFbXvjcDNu91KRvwoCUgFFtCHZkbB/kp0DQPgSqlWGVa15iMp4AXDCIKQ2h/joh0d083g/tjs96vbLDWyA65BoSs1bhbpltE94jxJuw17zKI19dkVAVHtYlatjb1pgLIHj2kauvQhtez7s2tTxYs3x5o/UWHtm9Kf5QrZKez6RJSVOqu+TIlX4q1TsB0t4upBRgMCI/9cWA

On Thu, 2026-08-06 at 10:19 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Thu, Aug 6, 2026 at 5:59=E2=80=AFAM Bastien Nocera <hadess@hadess.net>
> wrote:
> >=20
> > On Wed, 2026-08-05 at 13:12 -0400, Luiz Augusto von Dentz wrote:
> > > Hi Bastien,
> > >=20
> > > On Tue, Aug 4, 2026 at 10:31=E2=80=AFAM Bastien Nocera
> > > <hadess@hadess.net>
> > > wrote:
> > > >=20
> > > > This will allow us to use the name extraction code in
> > > > parse_media_element() and parse_folder_element() separately,
> > > > such
> > > > as in tests.
> > > > ---
> > > > =C2=A0Makefile.plugins=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0profiles/audio/avrcp-parse.c | 47
> > > > ++++++++++++++++++++++++++++++++++++
> > > > =C2=A0profiles/audio/avrcp-parse.h | 19 +++++++++++++++
> > > > =C2=A0profiles/audio/avrcp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
26 +++++---------------
> > > > =C2=A04 files changed, 73 insertions(+), 20 deletions(-)
> > > > =C2=A0create mode 100644 profiles/audio/avrcp-parse.c
> > > > =C2=A0create mode 100644 profiles/audio/avrcp-parse.h
> > > >=20
> > > > diff --git a/Makefile.plugins b/Makefile.plugins
> > > > index ac667beda847..a505fcd6691f 100644
> > > > --- a/Makefile.plugins
> > > > +++ b/Makefile.plugins
> > > > @@ -37,6 +37,7 @@ builtin_modules +=3D avrcp
> > > > =C2=A0builtin_sources +=3D profiles/audio/control.h
> > > > profiles/audio/control.c \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
ofiles/audio/avctp.h
> > > > profiles/audio/avctp.c \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
ofiles/audio/avrcp.h
> > > > profiles/audio/avrcp.c \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 profiles=
/audio/avrcp-parse.h
> > > > profiles/audio/avrcp-parse.c \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
ofiles/audio/avrcp-player.c
> > > > =C2=A0endif
> > > >=20
> > > > diff --git a/profiles/audio/avrcp-parse.c
> > > > b/profiles/audio/avrcp-
> > > > parse.c
> > > > new file mode 100644
> > > > index 000000000000..d3d0a070a4da
> > > > --- /dev/null
> > > > +++ b/profiles/audio/avrcp-parse.c
> > > > @@ -0,0 +1,47 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + *
> > > > + *=C2=A0 BlueZ - Bluetooth protocol stack for Linux
> > > > + *
> > > > + *=C2=A0 Copyright (C) 2026=C2=A0 Red Hat Inc.
> > > > + *
> > > > + *
> > > > + */
> > > > +
> > > > +#include "avrcp-parse.h"
> > > > +#include "src/shared/util.h"
> > > > +
> > > > +gboolean parse_media_element_name(uint8_t *operands, uint16_t
> > > > len,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 char *name, uint16_t
> > > > *namesize)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t namelen;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len < 13)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return FALSE;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(name, 0, NAME_MAX_LEN)=
;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *namesize =3D get_be16(&opera=
nds[11]);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 namelen =3D MIN(*namesize, NA=
ME_MAX_LEN - 1);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (namelen > 0) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 memcpy(name, &operands[13], namelen);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 strtoutf8(name, namelen);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return TRUE;
> > > > +}
> > > > +
> > > > +gboolean parse_media_folder_name(uint8_t *operands, uint16_t
> > > > len,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 char *name)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t namelen;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len < 12)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return FALSE;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(name, 0, NAME_MAX_LEN)=
;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 namelen =3D MIN(get_be16(&ope=
rands[12]), NAME_MAX_LEN -
> > > > 1);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (namelen > 0)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 memcpy(name, &operands[14], namelen);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return TRUE;
> > > > +}
> > >=20
> > > Rather than creating yet another file how about hosting this
> > > under
> > > shared/util.h directly? It already depends on it anyway, we could
> > > got
> > > with something like strntoutf8 or a similar function that checks
> > > the
> > > length, etc, actually be maybe better to do it under
> > > util_iov_pull_utf8(iov, len, str, str_max_len) so we can load the
> > > pdu
> > > into the iov then use iov_pull_mem, etc, to verify that we have
> > > enough
> > > bytes in a generic manner.

That sounds like some pretty big code changes that are beyond what I
have the time to do right now.

> > That would be nice follow-up work to be done, but this patch is
> > specifically about being able to test the out-of-bounds access
> > caused
> > by those 2 portions of code in patch #2.
> >=20
> > Then the fix is applied in patch #3.
> >=20
> > Finally, we could optimise/clean this up and remove that parsing
> > code,
> > but that would be in a 4th patch.
>=20
> I don't think this is the best approach because test-avrcp is testing
> the wrong implementation, so that needs rework.
>=20
>  I'd go straight to
> shared/util helper function which would allow us to create test cases
> immediately without changing a bunch of things and removing
> test-avrcp.c in the process.

But then you're not actually testing that your fix actually fixed the
security issue / bug...

I'll re-send a better version of the fix without tests.

Cheers
