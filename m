Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1793F0778
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767169; cv=none; b=XQ0z556Tz11tVrATVg6Xa4TCraGwZkXakDy+PyuZ5VN5gKJeBiBzNCusIwZkpoyWzHY5NKQXXJmE1MfNsLl/FsdS510+8IDjWPNOfkVRfH+z066zgc7VD/F/eSOolO9UtJnGwcrf0s2l47y6mkA6EiqKGiJie5MBEUHlCU0HyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767169; c=relaxed/simple;
	bh=B0hf8eqfUNKTBkoWSUWQAwV6lutjNZNG0Zd8WQm8Cho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IooEmGtn6xB36KGu/CyA/vhx4QM8e0EQUWy/oj61Zkv87BERKfzRKkrvLFBiMBlQzZoDKOvIPPI8ewseGq24NfYyPxP2IJlLB/KUlyN5AyLPK4caZPVDWAOvo/GB2F27OEcHjzFdVbXfnsN1ndGlAbHrT+6YkWd8zyThZCkcPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 093333EC2C;
	Tue, 17 Mar 2026 17:05:59 +0000 (UTC)
Message-ID: <298f24fbe2dacbf3dcdff58371690164d63cd7e1.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1] shared/ad: Fix not checking length on
 ad_replace_name
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 17 Mar 2026 18:05:59 +0100
In-Reply-To: <CABBYNZ+zM5x+XJ+zqOxV_LjzjrrDhQXQv9dZ8nfhu6+sVPNQqg@mail.gmail.com>
References: <20260316204320.57220-1-luiz.dentz@gmail.com>
	 <9388604ecf44cfb629f68e25d2357a9772e86dd9.camel@hadess.net>
	 <CABBYNZ+zM5x+XJ+zqOxV_LjzjrrDhQXQv9dZ8nfhu6+sVPNQqg@mail.gmail.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddukeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffeiueduvedutdffieehudetlefggfefgeeufeehudeujefhtdduvdekhfdvkefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupedtleeffeeffefgvedvvedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhuihiiuggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtt
 hhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

On Tue, 2026-03-17 at 12:43 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Tue, Mar 17, 2026 at 12:07=E2=80=AFPM Bastien Nocera <hadess@hadess.ne=
t>
> wrote:
> >=20
> > On Mon, 2026-03-16 at 16:43 -0400, Luiz Augusto von Dentz wrote:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >=20
> > > iov may carry move then HCI_MAX_NAME_LENGTH in which case it is
> > > truncated so it doesn't overflow utf8_name.
> > > ---
> > > =C2=A0src/shared/ad.c | 3 ++-
> > > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/src/shared/ad.c b/src/shared/ad.c
> > > index ac238014bcea..b1d1b84611aa 100644
> > > --- a/src/shared/ad.c
> > > +++ b/src/shared/ad.c
> > > @@ -278,7 +278,8 @@ static bool ad_replace_name(struct bt_ad *ad,
> > > struct iovec *iov)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char utf8_name[HCI_MAX_NAME_LENGTH + 2=
];
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(utf8_name, 0, sizeof(utf8_name)=
);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 strncpy(utf8_name, (const char *)iov->iov_b=
ase, iov-
> > > > iov_len);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 strncpy(utf8_name, (const char *)iov->iov_b=
ase,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIN(iov->iov_len, HC=
I_MAX_NAME_LENGTH));
> >=20
> > As I mentioned in my review, utf8_name could also have been shrunk
> > by
> > one byte.
>=20
> What review?

https://lore.kernel.org/linux-bluetooth/d054c110dc64a6278e052259bc315d44282=
8228c.camel@hadess.net/

>=20
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strisutf8(utf8_name, iov->iov_len)=
)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto done;
>=20
>=20
