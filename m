Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96E33D505
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714373; cv=none; b=sWgb2lh+YqxwmRQL5Ik3LYJCrtVC8d4TQOgM6U5jPvy9NFBONmiP4AQxMa+gLm4tjVNsiFN1rGcUcvi2IH1AK+j+7DqIT/4+v1xMypdtgHw49+pCbEUYyb253uUgmqbNB1E/wn9g/KYrFFiKK/HFN3HQgLj5GLHh/uEIWyY2hbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714373; c=relaxed/simple;
	bh=273y5FURc4jKhoKY7Oz482GNdP+gRYuPDRPczZ3dfjI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWk1dx5szeDAyFjjvP4b7WuWqUUoZpWXqTqDDqmDgSRH8h6kHk9KeUGWlnB0VIuxyPuXZhqb0XCdvhUbjE6tEI9Pm556Gev0Cp/f9SgL7z17yQeIM2AW4sYPfHFLI/dKGrGsCC0iO48rcXdL49GtZrliDijJ/RTfv7stsprrnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4EBC33EA58;
	Tue, 10 Feb 2026 09:06:03 +0000 (UTC)
Message-ID: <77d38ca59a66d2d114d430ebd13dfe26e7997ae9.camel@hadess.net>
Subject: Re: [PATCH BlueZ 2/2] emulator: Fix compilation on big endian
 systems
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Date: Tue, 10 Feb 2026 10:06:02 +0100
In-Reply-To: <8e576f35b6279255c1eed099c1142625c53a6be5.camel@iki.fi>
References: <20260209203316.3050687-1-hadess@hadess.net>
		 <20260209203316.3050687-2-hadess@hadess.net>
	 <8e576f35b6279255c1eed099c1142625c53a6be5.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeggfeuveeffefgteehkedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepphgrvhesihhkihdrfhhipdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvl
 hdrohhrgh
X-GND-State: clean

On Mon, 2026-02-09 at 21:36 +0000, Pauli Virtanen wrote:
> Hi,
>=20
> ma, 2026-02-09 kello 21:33 +0100, Bastien Nocera kirjoitti:
> > Use new helper macros for byteswapping constants.
> >=20
> > This fixes the build on big endian systems like s390x:
> >=20
> > emulator/bthost.c: In function =E2=80=98bthost_setup_sco=E2=80=99:
> > ./src/shared/util.h:43:26: error: initializer element is not
> > constant
> > =C2=A0=C2=A0 43 | #define cpu_to_le32(val) bswap_32(val)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~
> > etc.
> >=20
> > Fixes: 85888a8357ea ("bthost: add bthost_setup_sco() and accept
> > incoming eSCO")
> > ---
> > =C2=A0emulator/bthost.c | 16 ++++++++--------
> > =C2=A01 file changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/emulator/bthost.c b/emulator/bthost.c
> > index d09ad1e76c50..37865f61bc52 100644
> > --- a/emulator/bthost.c
> > +++ b/emulator/bthost.c
> > @@ -3562,18 +3562,18 @@ int bthost_setup_sco(struct bthost *bthost,
> > uint16_t acl_handle,
> > =C2=A0{
> > =C2=A0	static const struct bt_hci_cmd_setup_sync_conn settings[]
> > =3D
> > {
>=20
> Removing the "static" here would be another way to fix it, as it
> doesn't really need to be static here.

That looks like it's enough indeed, let me respin a patch.
