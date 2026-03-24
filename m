Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086738AC79
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341722; cv=none; b=D5P2ksS7A+cANynBTLRHxVf0Qw0S8r8LHTiUhV5fxSMXtaOMM0pl5L5X7SyaWsjse8jl+ZSbUnPhx5iE/xg3dz1UmjR23vVQAFIG+rMQy4V/Ph2o6E0mkppWE9drHrTnD0Kf/m/vp856NPUgV2EHmNKskunB+9dXSubqXkM0xxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341722; c=relaxed/simple;
	bh=AQZ1UL10qG4nNnj6aJaXakPiPZuN0xHkcGWtG+HVYoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2oqALHK8P7DmEFTh+NTerZllvkGUmaoahEOxVQNSFnGcc6IVo048kf+/y8hRXQ6tndJg8b2tZ+oF2jNfkVdMbobC0qkoTmlv2Is5+aB59OS+18PIhDsm19bESOggGgjt1aIziiet+SD41SoXDPfLHUm7JXSnsdZRRKrza3ZFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 148E03ED76;
	Tue, 24 Mar 2026 08:41:50 +0000 (UTC)
Message-ID: <842660bf07b12dd00533e0345065710f3edaeea6.camel@hadess.net>
Subject: Re: [EXT] Re: [PATCH BlueZ v1 1/1] test: Fix pbap-client to work
 with system bus obexd
From: Bastien Nocera <hadess@hadess.net>
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Cc: "luiz.von.dentz@intel.com" <luiz.von.dentz@intel.com>, 
 "linux-bluetooth@vger.kernel.org"
	 <linux-bluetooth@vger.kernel.org>, Vinit Mehta <vinit.mehta@nxp.com>, 
 Devyani Godbole <devyani.godbole@nxp.com>
Date: Tue, 24 Mar 2026 09:41:50 +0100
In-Reply-To: <GV2PR04MB12191ED7BE594E774D9D163DB934BA@GV2PR04MB12191.eurprd04.prod.outlook.com>
References: <20260320151958.851-1-sarveshwar.bajaj@nxp.com>
	 <20260320151958.851-2-sarveshwar.bajaj@nxp.com>
	 <CABBYNZJyr3-J1pVj_kGWLjjPn1_tYNhkYY9wEoahY-8s2kdWVw@mail.gmail.com>
	 <GV2PR04MB12191ED7BE594E774D9D163DB934BA@GV2PR04MB12191.eurprd04.prod.outlook.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepudegkefgtdefgfffjeeipdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehsrghrvhgvshhhfigrrhdrsggrjhgrjhesnhigphdrtghomhdprhgtphhtthhopehluhhiiiguvghnthiisehgm
 hgrihhlrdgtohhmpdhrtghpthhtoheplhhuihiirdhvohhnrdguvghnthiisehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhnihhtrdhmvghhthgrsehngihprdgtohhmpdhrtghpthhtohepuggvvhihrghnihdrghhouggsohhlvgesnhigphdrtghomh
X-GND-State: clean
X-GND-Score: -100

On Mon, 2026-03-23 at 12:35 +0000, Sarveshwar Bajaj wrote:
> Hi @Luiz,
>=20
> Thanks for the feedback.
>=20
> After commit 765356e80262 (=E2=80=9Cobexd: Unregister profiles when the u=
ser
> is inactive=E2=80=9D), obexd operates exclusively on the system bus, and
> session bus mode is no longer supported. Because of this, pbap client
> test script must also use the system bus to function correctly with
> modern bluez.

That's not what that commit does, and I don't see anything that would
cause obexd to not be able to run on the session bus, bug
notwithstanding.

Cheers
