Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D32F7445
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013459; cv=none; b=eUqW6yf9nPZ4c1DuqR4EtLoATiZsVND/QZ2mf/wVWPLYF+Gi+VJ1u865M4iWOKpJXtIiMXY9wbYmv+EkjaHYTQDDEPkyNTl5HquAg2e/OT19XAuYhy4O6RyDnp6sAj5MB4kSJQbVlY9tBpfDxsUr0O0CLjHBQwiwRX/qE0X5eS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013459; c=relaxed/simple;
	bh=IzQFxSiqqN2/Rsxyn1DkTgLHoc3spa3O973MQJeFTXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RFt8YVNUFwzrpONEaaxdC1lnhje+IMaaAYl5mkFMdUDQeS6DYJzAOn0BJXB8WCrGpmNVm25zaXHLbLKqyaNMMw++3HUlSk34tn62HYRaoI/TMpokFBCKrYDreo1HMIOXTFhdJpjwDlStsFRTwy9mI2bFifrIccNKE3+hXCJEl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1796D3EBDB;
	Thu,  6 Aug 2026 10:50:49 +0000 (UTC)
Message-ID: <4e3162c58c77b6488b35e0e244fd7692ecb0dbe6.camel@hadess.net>
Subject: Re: [BlueZ, v2 2/3] unit: Adapt poc_*_oob.c test into a new test
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Elman Shahbazov
	 <shahbazovelman97@gmail.com>
Date: Thu, 06 Aug 2026 12:50:49 +0200
In-Reply-To: <CABBYNZ+MYf9AxCm-nWEqf0qOGxScsU=Ghb0OrvuT2SdjGvD6ZA@mail.gmail.com>
References: <20260804142419.2274153-1-hadess@hadess.net>
	 <20260804142419.2274153-3-hadess@hadess.net>
	 <CABBYNZKoj_jr=msyTAiQ+AcV9Xf4MjCAjvcq0pDf8bWPBoypyQ@mail.gmail.com>
	 <45bc30093210c94efca124c980135176c2375c90.camel@hadess.net>
	 <CABBYNZ+MYf9AxCm-nWEqf0qOGxScsU=Ghb0OrvuT2SdjGvD6ZA@mail.gmail.com>
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
X-GND-Cause: dmFkZTEOecUJxtsnBFJCM4cMpnyUB13eD7fjsE+c2npZDAhhzcy8A1DMJ9VexGrwScU1vAsXAlfpsfBKVjEv9PPci0zls8SznNBw3BlZAKu96e/Zn6mxJCjIPVVesBmQgJ4rTX6+Jj2p8JDGzIB7vj5Mv/J55GO/oK1GtU7iApaiCpI1XrMPF5X8GQOzZLfNH0FW4gIdeqdC56id1cms0+5ocbmg4fkti7wLun2fgHnXWzqKhYqWOPYLWK1mVXTLw84TqrW9Lp99Bf9s4I/Jsbrg2bPftS0vGKjq4cUf6Oyqvlg6reaTQImXOhFOBauEINE2do8ET5qQL6EiEUSS06qhRQdET6AjgrveDVcL0atKqu3aBTpEHlVssOTQ+qSMHGqkjTLfm3jqwrFzP212rbfy/aEcUW+Bi3eSaGaIgB2TwPPpiLwOT9laBbMQUBeNxzFOMDJQB1nTlvgFlgRxciYRjNyiBwuVJ41f6rrZjatacj8yXbvERiAQGQLuojxBxJGAvqaIYlpCLuv9yjzqELGbbKE0816qxwa4wAuluv+Lt0ZdeWQLCfDLXpLSIqOHAP4U1tl63z0Gwz6jQi47vancsxkvYXsWVRIMedpdpRfT9Hr6tNUmruesmi7w7R7IO20weUCn7vHnWVDtb4SvXGzYc65CtNmYFDZyzYkeXNiNb/erOg

On Wed, 2026-08-05 at 12:44 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Wed, Aug 5, 2026 at 3:59=E2=80=AFAM Bastien Nocera <hadess@hadess.net>
> wrote:
> >=20
> > On Tue, 2026-08-04 at 12:46 -0400, Luiz Augusto von Dentz wrote:
> > > Hi Bastien,
> > >=20
> > > On Tue, Aug 4, 2026 at 10:31=E2=80=AFAM Bastien Nocera
> > > <hadess@hadess.net>
> > > wrote:
> > > >=20
> > > > Adapt poc_avrcp_oob.c and poc_folder_oob.c into unit tests.
> > > >=20
> > > > Co-authored-by: Elman Shahbazov <shahbazovelman97@gmail.com>
> > > > ---
> > > > =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 9 +++++
> > > > =C2=A0unit/test-avrcp-sec.c | 76
> > > > +++++++++++++++++++++++++++++++++++++++++++
> > > > =C2=A02 files changed, 85 insertions(+)
> > > > =C2=A0create mode 100644 unit/test-avrcp-sec.c
> > > >=20
> > > > diff --git a/Makefile.am b/Makefile.am
> > > > index 19c468d3a504..e3baa4155c1f 100644
> > > > --- a/Makefile.am
> > > > +++ b/Makefile.am
> > > > @@ -660,6 +660,15 @@ unit_test_avrcp_SOURCES =3D unit/test-
> > > > avrcp.c \
> > > > =C2=A0unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.la \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src/libshared-glib.la
> > > > $(GLIB_LIBS)
> > > >=20
> > > > +unit_tests +=3D unit/test-avrcp-sec
> > > > +
> > > > +unit_test_avrcp_sec_SOURCES =3D unit/test-avrcp-sec.c \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 profiles=
/audio/avrcp-parse.c \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 profiles=
/audio/avrcp-parse.h \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src/log.=
h src/log.c
> > > > +unit_test_avrcp_sec_LDADD =3D lib/libbluetooth-internal.la \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src/libshared-glib.la
> > > > $(GLIB_LIBS)
> > >=20
> > > Any reason why this couldn't live inside test-avrcp.c?
> >=20
> > Because most of the code in test-avrcp.c is mocked in unit/avrcp-
> > lib.[ch] and conflicts with code from profiles/audio/avrcp.c. I
> > really
> > did try...
>=20
> Ok, well then perhaps we should start testing what we really use in
> the avrcp plugin rather than the removed Android code, or we could
> have a bigger task: converting this type of code to
> src/shared/avrcp.c
> (e.g. bt_avrcp) so it can be unit tested.

I figured that this code would actually test *something*, but it looks
like I was wrong.

I'll re-send the patch to remove the dead code for unit/avrcp.c, and
send a follow-up patch to remove this code here, and reinstate it with
this test.

Right now, "make coverage" says that profiles/audio has no coverage at
all...

> > I can change the name of the test if needed.
>=20
> I'm not concerned about the name, I'm concerned about the number of
> unit test files which could otherwise be in a single file instead of
> duplicating a lot of context.
>=20
> > >=20
> > > > =C2=A0unit_tests +=3D unit/test-hfp
> > > >=20
> > > > =C2=A0unit_test_hfp_SOURCES =3D unit/test-hfp.c
> > > > diff --git a/unit/test-avrcp-sec.c b/unit/test-avrcp-sec.c
> > > > new file mode 100644
> > > > index 000000000000..a100b2d68e35
> > > > --- /dev/null
> > > > +++ b/unit/test-avrcp-sec.c
> > > > @@ -0,0 +1,76 @@
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
> > > > +#ifdef HAVE_CONFIG_H
> > > > +#include <config.h>
> > > > +#endif
> > > > +
> > > > +#include <glib.h>
> > > > +
> > > > +#include "src/shared/util.h"
> > > > +#include "src/shared/tester.h"
> > > > +#include "src/log.h"
> > > > +
> > > > +#include "profiles/audio/avrcp-parse.h"
> > > > +
> > > > +static void avrcp_element_name_oob(gconstpointer data)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char name[255];
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t namesize;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gboolean ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Crafting a malicious paylo=
ad.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Actual packet length =
(len) =3D 14 bytes */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t malicious_packet[14] =
=3D {0};
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Specify namesize =3D 1000 =
(0x03E8 in Big Endian) at
> > > > offset
> > > > 11 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 malicious_packet[11] =3D 0x03=
;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 malicious_packet[12] =3D 0xE8=
;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Launching the PoC. We tran=
smit a 14-byte packet, but
> > > > namesize=3D1000... */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D parse_media_element_n=
ame(malicious_packet,
> > > > sizeof(malicious_packet),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 name, &namesize);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tester_test_passed();
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tester_test_failed();
> > > > +}
> > > > +
> > > > +static void avrcp_folder_name_oob(gconstpointer data)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char name[255];
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gboolean ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Crafting a malicious paylo=
ad.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Actual packet length =
(len) =3D 14 bytes */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t malicious_packet[14] =
=3D {0};
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Specify namesize =3D 1000 =
(0x03E8 in Big Endian) at
> > > > offset
> > > > 12 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 malicious_packet[12] =3D 0x03=
;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 malicious_packet[13] =3D 0xE8=
;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Launching the PoC. We tran=
smit a 14-byte packet, but
> > > > namesize=3D1000... */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D parse_media_folder_na=
me(malicious_packet,
> > > > sizeof(malicious_packet),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 name);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tester_test_passed();
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tester_test_failed();
> > > > +}
> > > > +
> > > > +int main(int argc, char *argv[])
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tester_init(&argc, &argv);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tester_add("/avrcp-element-na=
me-oob", NULL, NULL,
> > > > avrcp_element_name_oob, NULL);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tester_add("/avrcp-folder-nam=
e-oob", NULL, NULL,
> > > > avrcp_folder_name_oob, NULL);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return tester_run();
> > > > +}
> > > > --
> > > > 2.55.0
> > > >=20
> > > >=20
> > >=20
>=20
>=20
