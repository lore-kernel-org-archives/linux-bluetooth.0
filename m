Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5586821E08D
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806771; cv=none; b=EUSp1AQ9ZYBKNKZ6beO7uoIDOvLwzLmZeQrKMcTpvWUBYbbGUaLG8v2+XCGUk579fStbDt47sLx8FdygmM0VCr4IiGtN63sntXXaAVsaP3pvE+YXrqxmBkI11574Z6Todtx/DvTmxD9Oc1n6Di43GMgILXoCqyY7jCRggPagbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806771; c=relaxed/simple;
	bh=iys5KEqdpW8LMlttWeXAtw4106XZFTDHv9K+B6jPjYE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p1geQBdTwe0tcAbyjn+h0xnzVRJZXAaIlUC8Z/Zatx+hs/qW0IouX+rz4E8hlVx67zOoyreEj3Rsa0u99+Njkt0ehhu/AdZ9BRMdt0ECR32eKG+nj+wZ26IrGb+cKB1bNDD63WVQ6//vLjLqSNOROHbbqvxWF5WwRYAJJ6/IUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10A6E44438;
	Mon, 17 Feb 2025 15:39:26 +0000 (UTC)
Message-ID: <6b8b1f29602f8303eea241ae69a7fddcb15560c4.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1] org.bluez.Device: Introduced PreferredBearer
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pauli.virtanen@iki.fi>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Date: Mon, 17 Feb 2025 16:39:26 +0100
In-Reply-To: <3e36e6c2c9b201a5c06c0bc166cd4d38bb8067b3.camel@iki.fi>
References: <20250214202129.968369-1-luiz.dentz@gmail.com>
		 <CABBYNZJmigw_3=5CZ5eaSGC8ZHTzmsZA11p558EtcET-FcrVEA@mail.gmail.com>
	 <3e36e6c2c9b201a5c06c0bc166cd4d38bb8067b3.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepteehfeevueehgfegheeigeegueehudduveegieffjedvkeejgeeigffhveejhedvnecuffhomhgrihhnpehgnhhomhgvrdhorhhgnecukfhppeejkedrudelledriedtrddvgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepjeekrdduleelrdeitddrvdegvddphhgvlhhopegludelvddrudeikedruddrudegjegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehprghulhhirdhvihhrthgrnhgvnhesihhkihdrfhhipdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

Hey,

On Sat, 2025-02-15 at 20:27 +0200, Pauli Virtanen wrote:
> <snip>robably Gnome BT settings also would need to grow a
> corresponding
> setting. Labeling such setting so that people understand it is maybe
> harder...
>=20
> There's a few questions:
>=20
> - Is there something that tells which bearers are available for a
> device? It would probably be needed too if it doesn't exist.
>=20
> - Interaction with CSIP, if you pair initially with bredr I think you
> don't get the other earbud paired. If you switch bearer + disconnect
> +
> connect, does it pair & connect the other one?
>=20
> - Who is going to be the agent that accepts the pairing of the other
> CSIP devices? GNOME BT settings I think is not running all time (and
> does it do CSIP accepts?).
>=20
> - Whether disconnect+reconnect should be needed to switch the bearer,
> or if just changing the property is enough if already connected?
> Maybe
> it is needed?

I don't have access to any CSIP supported devices, which is one of the
reasons why gnome-bluetooth has no support for it.

I think that the AX210 I have has support for CSIP on the adapter side,
but I would need to know what cheap device I could get that supports
it.

This is tracked in:
https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/130

