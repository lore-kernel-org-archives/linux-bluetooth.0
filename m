Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7827CCEE
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666256; cv=none; b=Mx9S682+mxHSSc7pqocta3ZNonZsRjnTjPhPDiCU/SwepPB+4O5WyIzmsX2TkHLyImbtOvAqUDnbfx5czsU1wsG8ckf8EQscyrztXug6yM8l+KHFvbtEUz+rjRC6pjMdQ/yE/cFzlCn4G1tsSVOs/WCshcQQhyVMKOc3eyngzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666256; c=relaxed/simple;
	bh=AGHHaZgAaa1vMGmq+lubVlfGkgDJ5BJ/gLYk5EB+Mls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1kYMAM8yIwM3qL5vrdJ4b/ykJjhJ/aKn714vRMh491XVThdJd0LvByViMPuqk+9DsqMCnmm1xiekBXwGSng0C80tgRJTRr91I8B4vpp3wFgJqq2MkaDYX8rSn0e/vs8lqJJvzgLfGIRkam+M/A7gJW+Nott59eT3BX1JnNmd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FA2A43A0E;
	Fri,  8 Aug 2025 15:17:26 +0000 (UTC)
Message-ID: <1ede7e964c25af2a310985d8c711e937af41aa62.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2 1/3] build: Move library source to lib/bluetooth
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 08 Aug 2025 17:17:25 +0200
In-Reply-To: <CABBYNZJbfk7GipDbox9KvP5SXWL-XYG2GGyojvH0UCzvbgucog@mail.gmail.com>
References: <20250807155115.1037982-1-hadess@hadess.net>
	 <20250807155115.1037982-2-hadess@hadess.net>
	 <CABBYNZJbfk7GipDbox9KvP5SXWL-XYG2GGyojvH0UCzvbgucog@mail.gmail.com>
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
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffegffdtkeevkeeltdfgkedtveeuueejjefgtddtgeefhffgueetjefhvdefleefnecuffhomhgrihhnpehmvghsohhnsghuihhlugdrtghomhenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvl
 hdrohhrgh
X-GND-Sasl: hadess@hadess.net

On Fri, 2025-08-08 at 10:42 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Thu, Aug 7, 2025 at 11:51=E2=80=AFAM Bastien Nocera <hadess@hadess.net=
>
> wrote:
> >=20
> > This fixes the installed directory hierarchy not matching the
> > source
> > directory hierarchy.
>=20
> Ok, but why do we need to do such a change? Doesn't meson handle
> installing in a different directory? If it doesn't you can probably
> state it or point to the documentation.

The problem isn't installing to a different directory, but the fact
that public headers which mention "#include <bluetooth/bluetooth.h>"
will actually want to include "lib/bluetooth.h" when building inside
the bluez repo.

The autotools way was to hack it by linking all the "lib/*.h" headers
into "lib/bluetooth", it's just as easy renaming them all, rather than
perpetuating that hack into the meson build system.

The idiomatic way to do things, in autotools just as in meson, would be
to have the header directory in the sources to be the same as when
installed to /usr/include, not to use symlink'ing hacks.

We could also rename the top-level "lib/" directory to "bluetooth/",
but that would be slightly non-descript when reading the sources.

I haven't looked at implementing the same autotools hack in meson,
because it seemed like a better idea to just fix things, rather than
continue with the brokenness. It might be possible with
meson.add_postconf_script():
https://mesonbuild.com/Reference-manual_builtin_meson.html#mesonadd_postcon=
f_script

But I'd really rather fix this hack.

Let me know what you think.
