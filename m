Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BE322535
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781217; cv=none; b=Fp7+ca6iCjcxkTR48JeGMv0QIWkyG/xHJDTW8x9yE1/vBkQSUbdzeH0pidt8zKz9PUHAgdI+nMa8R4wVgHBW1q77QWVCfZUp6glGdb5KKvTySZI/KeSWb11fGbR3293p3CNir2pJ0dqBv9p+tBrmx+FXThw+fZYuPfck+RariKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781217; c=relaxed/simple;
	bh=p0znKIhiriPva1T4ijztiFnWSdCYaZ70WJEDk7wzmV4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=brWllq63hEmbox9iSCwaB34KtIWWZGzWR1dRN3pFheXOvBBUqSJM5Cwp2rWQ8yyxwI5C1mMZnakOK6gSqr7Wm5OU9P73oPOJCoqDWThHzu2h87A8z8A332OWNOHKs072usoSsVTb2EXMWTvwTsK+5zbwBcuxoJllbM7Wgbu0Emo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A275644327;
	Thu, 21 Aug 2025 13:00:13 +0000 (UTC)
Message-ID: <ad8d173b591d701707107bb98902922583e7d61b.camel@hadess.net>
Subject: Re: [PATCH BlueZ 0/2] Cable pairing support for DualSense
From: Bastien Nocera <hadess@hadess.net>
To: Egor Vorontsov <sdoregor@sdore.me>, linux-bluetooth@vger.kernel.org
Date: Thu, 21 Aug 2025 15:00:13 +0200
In-Reply-To: <20250603095617.92785-1-sdoregor@sdore.me>
References: <20250603095617.92785-1-sdoregor@sdore.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedufedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepgedvheevleekveetkeehtdfhgfeltdejtdffkeefieejveeuvdelffegvdejudegnecuffhomhgrihhnpehgvghnthhoohdrohhrghenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepshguohhrvghgohhrsehsughorhgvrdhmvgdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

On Tue, 2025-06-03 at 12:56 +0300, Egor Vorontsov wrote:
> I have figured out the DualSense pairing to be pretty similar to that
> of DualShock 4. Successfully tested with a DualSense, from CLI and
> via GNOME Control Center.
>=20
> As a side discussion, don't we also have to add the DS4 constant
> at L398 (that's with this patch) for it to be supported as well?
> An article at Gentoo Wiki [1] suggests that DS4 pairing cannot
> currently be done the cable way. I don't currently have a way to
> verify this myself, though.
>=20
> [1]: https://wiki.gentoo.org/wiki/Sony_DualShock#DualShock_4

My guess is that the DS4 cable-pairing support stopped working when the
kernel migrated from hid-sony to hid-playstation (and devices changed
names...).

I sent patches which fix that in my local testing.

>=20
> Egor Vorontsov (2):
> =C2=A0 profiles/input: Add cable pairing constants for DualSense
> =C2=A0 plugins/sixaxis: Implement cable pairing for DualSense
>=20
> =C2=A0plugins/sixaxis.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 107
> +++++++++++++++++++++++++++++++++++++--
> =C2=A0profiles/input/server.c=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0profiles/input/sixaxis.h |=C2=A0 25 +++++++++
> =C2=A03 files changed, 131 insertions(+), 4 deletions(-)
