Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460931579D
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781984; cv=none; b=Ji5djkmzWhMFLuTYjm5XMgNP635+IGB50kxMr8SaeH/07OmzourVkgG7Jc0m1y3wbs33VS9a4+nyWSzL6X15HWkoUvwIOg2xu4FYeNjd8+03ZW4E+/x2YbEJsimgcyqmqxjSq9PjrZ1wRQuML6EnGcE6NJIqVupNqphUTHk96qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781984; c=relaxed/simple;
	bh=8pXOTlIJKTbVM8/xNb+u8vEAN5FhgZvtieYbtqDmYas=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LKZj3e4AhSpwGW4Qir9kf9cZlcCnzuAgOhP3YnBNAe7OhB7MEPelLZWGy6x8df1qJFGRlH8MEe1mxm+9cmpkOCDzZy0aZLBODO+Q6JJGiRvroeAv2RO+WfZLbeimFTrhudd5zA5qMexCVlzpu7s7P3eVJfZygzuELYfprIXSKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6982543B14;
	Thu, 21 Aug 2025 13:12:55 +0000 (UTC)
Message-ID: <3895585d650231f4be45b49a1b8593e653e2f92a.camel@hadess.net>
Subject: Re: [PATCH BlueZ 2/2] plugins/sixaxis: Implement cable pairing for
 DualSense
From: Bastien Nocera <hadess@hadess.net>
To: sdoregor@sdore.me, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 21 Aug 2025 15:12:55 +0200
In-Reply-To: <5284d0fedf1e044e40aa6839d39f010626e6f637.camel@sdore.me>
References: <20250603095617.92785-1-sdoregor@sdore.me>
		 <20250603095617.92785-3-sdoregor@sdore.me>
		 <CABBYNZJYwKurqo+HDUKYtFx0+-rNquj=OHgpcZRZYVmAxDzqpA@mail.gmail.com>
		 <c8b55be8b9abdb73bc57e8a2d455770199a2b21b.camel@sdore.me>
		 <CABBYNZKL2gYmWPfP1owAUSAieWgt4ARaFp0-T5+vQ+rgjWnNHw@mail.gmail.com>
		 <4c6bec3c1c02243cf57e1618d1fd35a2f12bdf22.camel@sdore.me>
		 <CABBYNZL++r5p=opkw-saPK8yqKQWEPrU-AvcQvPK_x+0yXEUkQ@mail.gmail.com>
	 <5284d0fedf1e044e40aa6839d39f010626e6f637.camel@sdore.me>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedufeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehsughorhgvghhorhesshguohhrvgdrmhgvpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrn
 hgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

On Thu, 2025-06-05 at 01:50 +0300, Egor Vorontsov wrote:
> On Wed, 2025-06-04 at 08:41 -0400, Luiz Augusto von Dentz wrote:
> > Hmm, not so sure this is secure though, I mean it could be a rogue
> > USB
> > device pretending to be a controller so it would automatically be
> > considered paired if we just self generate the keys without asking
> > for
> > user confirmation.
>=20
> We can generate whatever we want, unless BlueZ will treat the key as
> bonded no question asked. Read on to see what I mean.
>=20
> > Yeah, the zero-click bond might be a security concern though, so I
> > think having the user do a confirmation for each step is sort of
> > assuring he knows (or at least pretend) what is going on.
>=20
> I strongly believe you only should confirm once. Especially since the
> first one doesn't actually pair or trust anything, instead it just
> creates the device record for it to be able to initiate a bonding
> connection to us without discoverable being on (as far as I
> understand
> it).

It also modifies the controller's storage to tell it to connect to our
computer when clicking the PS button.

>=20
> The painful re-re-pairing process is so strongly tied with Bluetooth
> in
> our minds, so I really don't want to further increase its
> awkwardness.
>=20
> > When would we generate the confirmation though? I sort of trust
> > more
> > the Bluetooth process to generate and exchange keys.
>=20
> That's exactly what I'd love to hear from someone, honestly :)
>=20
> I see a possible solution where we trigger agent on the first
> connect,
> even though the link key is already established. It might be a
> special
> flag for the device, or even just another value in the `LinkKey.Type'
> field -- meaning, "key was generated by us, should reconfirm
> pairing".
